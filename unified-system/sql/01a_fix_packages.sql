--------------------------------------------------------------------------------
-- إصلاح لمن شغّل النسخة الأولى من 01_moinfo_core.sql
-- يعيد إنشاء جسمَي الحزمتين MOINFO_AUTH و MOINFO_SEC ثم ينشئ المستخدم ADMIN.
-- لا حاجة لتشغيله إن ثبّتّ النسخة المحدّثة من 01 مباشرة.
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY MOINFO_AUTH AS

    -- لا تغيّر هذا الرقم بعد إنشاء مستخدمين، وإلا لن تتطابق كلمات مرورهم
    c_iterations CONSTANT PLS_INTEGER := 1000;

    FUNCTION client_ip RETURN VARCHAR2 IS
    BEGIN
        RETURN SUBSTR(OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR'), 1, 60);
    EXCEPTION
        WHEN OTHERS THEN
            RETURN SUBSTR(SYS_CONTEXT('USERENV', 'IP_ADDRESS'), 1, 60);
    END client_ip;

    FUNCTION apex_session RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(SYS_CONTEXT('APEX$SESSION', 'APP_SESSION'));
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END apex_session;

    FUNCTION new_salt RETURN VARCHAR2 IS
    BEGIN
        RETURN RAWTOHEX(SYS_GUID()) || DBMS_RANDOM.STRING('X', 16);
    END new_salt;

    PROCEDURE log_login (
        p_username IN VARCHAR2,
        p_user_id  IN NUMBER,
        p_success  IN VARCHAR2,
        p_reason   IN VARCHAR2
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        -- الدوال الخاصة بالحزمة لا تُستدعى داخل SQL، فتُقرأ قيمها في متغيرات أولًا
        l_ip      VARCHAR2(60) := client_ip;
        l_session NUMBER       := apex_session;
    BEGIN
        INSERT INTO MOINFO_LOGIN_HISTORY (USERNAME, USER_ID, LOGIN_AT, IS_SUCCESS, FAILURE_REASON, IP_ADDRESS, APEX_SESSION_ID)
        VALUES (SUBSTR(UPPER(TRIM(p_username)), 1, 100), p_user_id, SYSTIMESTAMP, p_success, p_reason, l_ip, l_session);
        COMMIT;
    END log_login;

    PROCEDURE register_failure (p_user_id IN NUMBER) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        l_max  NUMBER := TO_NUMBER(MOINFO_UTIL.GET_SETTING('AUTH_MAX_FAILED', '5'));
        l_lock NUMBER := TO_NUMBER(MOINFO_UTIL.GET_SETTING('AUTH_LOCK_MINUTES', '15'));
    BEGIN
        UPDATE MOINFO_USER_CREDENTIALS
           SET FAILED_LOGINS = FAILED_LOGINS + 1,
               LOCKED_UNTIL  = CASE
                                   WHEN FAILED_LOGINS + 1 >= l_max
                                   THEN SYSTIMESTAMP + NUMTODSINTERVAL(l_lock, 'MINUTE')
                                   ELSE LOCKED_UNTIL
                               END
         WHERE USER_ID = p_user_id;
        COMMIT;
    END register_failure;

    PROCEDURE register_success (p_user_id IN NUMBER) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UPDATE MOINFO_USER_CREDENTIALS
           SET FAILED_LOGINS = 0,
               LOCKED_UNTIL  = NULL,
               LAST_LOGIN_AT = SYSTIMESTAMP
         WHERE USER_ID = p_user_id;
        COMMIT;
    END register_success;

    -- يتحقق من كلمة المرور دون تسجيل أي شيء
    FUNCTION password_matches (p_user_id IN NUMBER, p_password IN VARCHAR2) RETURN BOOLEAN IS
        l_hash MOINFO_USER_CREDENTIALS.PASSWORD_HASH%TYPE;
        l_salt MOINFO_USER_CREDENTIALS.PASSWORD_SALT%TYPE;
    BEGIN
        SELECT PASSWORD_HASH, PASSWORD_SALT
          INTO l_hash, l_salt
          FROM MOINFO_USER_CREDENTIALS
         WHERE USER_ID = p_user_id;

        IF l_hash IS NULL OR p_password IS NULL THEN
            RETURN FALSE;
        END IF;
        RETURN HASH_PASSWORD(p_password, l_salt) = l_hash;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END password_matches;

    FUNCTION HASH_PASSWORD (p_password IN VARCHAR2, p_salt IN VARCHAR2) RETURN VARCHAR2 IS
        l_hex VARCHAR2(64);
    BEGIN
        IF p_password IS NULL OR p_salt IS NULL THEN
            RETURN NULL;
        END IF;

        SELECT RAWTOHEX(STANDARD_HASH(p_salt || p_password, 'SHA256')) INTO l_hex FROM DUAL;
        FOR i IN 2 .. c_iterations LOOP
            SELECT RAWTOHEX(STANDARD_HASH(l_hex || p_salt, 'SHA256')) INTO l_hex FROM DUAL;
        END LOOP;
        RETURN l_hex;
    END HASH_PASSWORD;

    FUNCTION VALIDATE_PASSWORD_RULES (p_password IN VARCHAR2) RETURN VARCHAR2 IS
        l_min NUMBER := TO_NUMBER(MOINFO_UTIL.GET_SETTING('PWD_MIN_LENGTH', '8'));
    BEGIN
        IF p_password IS NULL OR LENGTH(p_password) < l_min THEN
            RETURN 'كلمة المرور يجب ألا تقل عن ' || l_min || ' أحرف';
        ELSIF NOT REGEXP_LIKE(p_password, '[0-9]') OR NOT REGEXP_LIKE(p_password, '[[:alpha:]]') THEN
            RETURN 'كلمة المرور يجب أن تحتوي على حروف وأرقام';
        END IF;
        RETURN NULL;
    END VALIDATE_PASSWORD_RULES;

    PROCEDURE SET_PASSWORD (
        p_user_id     IN NUMBER,
        p_password    IN VARCHAR2,
        p_must_change IN VARCHAR2 DEFAULT 'N'
    ) IS
        l_error VARCHAR2(400);
        l_salt  VARCHAR2(64);
        l_hash  VARCHAR2(64);
    BEGIN
        l_error := VALIDATE_PASSWORD_RULES(p_password);
        IF l_error IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20001, l_error);
        END IF;

        l_salt := new_salt;
        l_hash := HASH_PASSWORD(p_password, l_salt);

        MERGE INTO MOINFO_USER_CREDENTIALS c
        USING (SELECT p_user_id AS USER_ID FROM DUAL) s
           ON (c.USER_ID = s.USER_ID)
         WHEN MATCHED THEN UPDATE
              SET c.PASSWORD_HASH       = l_hash,
                  c.PASSWORD_SALT       = l_salt,
                  c.MUST_CHANGE_PWD     = NVL(p_must_change, 'N'),
                  c.FAILED_LOGINS       = 0,
                  c.LOCKED_UNTIL        = NULL,
                  c.PASSWORD_CHANGED_AT = SYSTIMESTAMP
         WHEN NOT MATCHED THEN INSERT
              (USER_ID, PASSWORD_HASH, PASSWORD_SALT, MUST_CHANGE_PWD, FAILED_LOGINS, PASSWORD_CHANGED_AT)
              VALUES (s.USER_ID, l_hash, l_salt, NVL(p_must_change, 'N'), 0, SYSTIMESTAMP);
    END SET_PASSWORD;

    FUNCTION AUTHENTICATE (p_username IN VARCHAR2, p_password IN VARCHAR2) RETURN BOOLEAN IS
        l_user_id MOINFO_USERS.USER_ID%TYPE;
        l_active  MOINFO_USERS.IS_ACTIVE%TYPE;
        l_locked  MOINFO_USER_CREDENTIALS.LOCKED_UNTIL%TYPE;
    BEGIN
        BEGIN
            SELECT u.USER_ID, u.IS_ACTIVE, c.LOCKED_UNTIL
              INTO l_user_id, l_active, l_locked
              FROM MOINFO_USERS u
              LEFT JOIN MOINFO_USER_CREDENTIALS c ON c.USER_ID = u.USER_ID
             WHERE u.USERNAME = UPPER(TRIM(p_username));
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                log_login(p_username, NULL, 'N', 'USER_NOT_FOUND');
                RETURN FALSE;
        END;

        IF l_active <> 'Y' THEN
            log_login(p_username, l_user_id, 'N', 'INACTIVE');
            RETURN FALSE;
        END IF;

        IF l_locked IS NOT NULL AND l_locked > SYSTIMESTAMP THEN
            log_login(p_username, l_user_id, 'N', 'LOCKED');
            RETURN FALSE;
        END IF;

        IF NOT password_matches(l_user_id, p_password) THEN
            register_failure(l_user_id);
            log_login(p_username, l_user_id, 'N', 'WRONG_PASSWORD');
            RETURN FALSE;
        END IF;

        register_success(l_user_id);
        log_login(p_username, l_user_id, 'Y', NULL);
        RETURN TRUE;
    END AUTHENTICATE;

    PROCEDURE POST_AUTH IS
    BEGIN
        -- توحيد اسم المستخدم بحروف كبيرة في :APP_USER
        APEX_CUSTOM_AUTH.SET_USER(UPPER(TRIM(V('APP_USER'))));
    END POST_AUTH;

    PROCEDURE POST_LOGOUT IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        l_session NUMBER := apex_session;
    BEGIN
        UPDATE MOINFO_LOGIN_HISTORY
           SET LOGOUT_AT = SYSTIMESTAMP
         WHERE APEX_SESSION_ID = l_session
           AND IS_SUCCESS = 'Y'
           AND LOGOUT_AT IS NULL;
        COMMIT;
    END POST_LOGOUT;

    FUNCTION CHANGE_PASSWORD (
        p_username     IN VARCHAR2,
        p_old_password IN VARCHAR2,
        p_new_password IN VARCHAR2
    ) RETURN BOOLEAN IS
        l_user_id MOINFO_USERS.USER_ID%TYPE;
    BEGIN
        SELECT USER_ID INTO l_user_id
          FROM MOINFO_USERS
         WHERE USERNAME = UPPER(TRIM(p_username))
           AND IS_ACTIVE = 'Y';

        IF NOT password_matches(l_user_id, p_old_password) THEN
            register_failure(l_user_id);
            RETURN FALSE;
        END IF;

        SET_PASSWORD(l_user_id, p_new_password, 'N');
        RETURN TRUE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END CHANGE_PASSWORD;

    FUNCTION MUST_CHANGE_PASSWORD (p_username IN VARCHAR2) RETURN BOOLEAN IS
        l_flag MOINFO_USER_CREDENTIALS.MUST_CHANGE_PWD%TYPE;
    BEGIN
        SELECT c.MUST_CHANGE_PWD
          INTO l_flag
          FROM MOINFO_USERS u
          JOIN MOINFO_USER_CREDENTIALS c ON c.USER_ID = u.USER_ID
         WHERE u.USERNAME = UPPER(TRIM(p_username));
        RETURN l_flag = 'Y';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END MUST_CHANGE_PASSWORD;

END MOINFO_AUTH;
/

CREATE OR REPLACE PACKAGE BODY MOINFO_SEC AS

    c_admin_rank CONSTANT NUMBER := 9999;

    FUNCTION app_user RETURN VARCHAR2 IS
    BEGIN
        RETURN UPPER(TRIM(V('APP_USER')));
    END app_user;

    FUNCTION CURRENT_USER_ID RETURN NUMBER IS
        l_id   MOINFO_USERS.USER_ID%TYPE;
        l_user VARCHAR2(255) := app_user;
    BEGIN
        SELECT USER_ID INTO l_id
          FROM MOINFO_USERS
         WHERE USERNAME = l_user
           AND IS_ACTIVE = 'Y';
        RETURN l_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END CURRENT_USER_ID;

    FUNCTION IS_ADMIN RETURN BOOLEAN IS
        l_n    NUMBER;
        l_user VARCHAR2(255) := app_user;
    BEGIN
        SELECT COUNT(*) INTO l_n
          FROM MOINFO_USERS
         WHERE USERNAME = l_user
           AND IS_ACTIVE = 'Y'
           AND IS_SYS_ADMIN = 'Y';
        RETURN l_n > 0;
    END IS_ADMIN;

    FUNCTION ROLE_RANK (p_module IN VARCHAR2) RETURN NUMBER IS
        l_rank NUMBER;
        l_user VARCHAR2(255) := app_user;
    BEGIN
        IF IS_ADMIN THEN
            RETURN c_admin_rank;
        END IF;

        SELECT MAX(r.ROLE_RANK)
          INTO l_rank
          FROM MOINFO_USERS u
          JOIN MOINFO_USER_MODULES um ON um.USER_ID = u.USER_ID
          JOIN MOINFO_MODULES m       ON m.MODULE_CODE = um.MODULE_CODE
          JOIN MOINFO_ROLES r         ON r.ROLE_ID = um.ROLE_ID
         WHERE u.USERNAME = l_user
           AND u.IS_ACTIVE = 'Y'
           AND um.MODULE_CODE = UPPER(p_module)
           AND um.IS_ACTIVE = 'Y'
           AND m.IS_ACTIVE = 'Y'
           AND r.IS_ACTIVE = 'Y';
        RETURN NVL(l_rank, 0);
    END ROLE_RANK;

    FUNCTION HAS_MODULE (p_module IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN ROLE_RANK(p_module) > 0;
    END HAS_MODULE;

    FUNCTION HAS_ROLE (p_module IN VARCHAR2, p_role_code IN VARCHAR2) RETURN BOOLEAN IS
        l_required NUMBER;
    BEGIN
        -- الدور الخاص بالوحدة له الأولوية على الدور العام بنفس الرمز
        SELECT ROLE_RANK
          INTO l_required
          FROM (SELECT ROLE_RANK
                  FROM MOINFO_ROLES
                 WHERE ROLE_CODE = UPPER(p_role_code)
                   AND (MODULE_CODE = UPPER(p_module) OR MODULE_CODE IS NULL)
                 ORDER BY CASE WHEN MODULE_CODE IS NULL THEN 1 ELSE 0 END)
         WHERE ROWNUM = 1;

        RETURN ROLE_RANK(p_module) >= l_required;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END HAS_ROLE;

    FUNCTION DATA_SCOPE (p_module IN VARCHAR2) RETURN VARCHAR2 IS
        l_scope MOINFO_USER_MODULES.DATA_SCOPE%TYPE;
        l_user  VARCHAR2(255) := app_user;
    BEGIN
        IF IS_ADMIN THEN
            RETURN 'ALL';
        END IF;

        SELECT um.DATA_SCOPE
          INTO l_scope
          FROM MOINFO_USERS u
          JOIN MOINFO_USER_MODULES um ON um.USER_ID = u.USER_ID
         WHERE u.USERNAME = l_user
           AND u.IS_ACTIVE = 'Y'
           AND um.MODULE_CODE = UPPER(p_module)
           AND um.IS_ACTIVE = 'Y';
        RETURN l_scope;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END DATA_SCOPE;

    FUNCTION CAN_SEE_UNIT (p_module IN VARCHAR2, p_unit_id IN NUMBER) RETURN VARCHAR2 IS
        l_scope MOINFO_USER_MODULES.DATA_SCOPE%TYPE;
        l_user  VARCHAR2(255) := app_user;
        l_root  NUMBER;
        l_n     NUMBER;
    BEGIN
        IF IS_ADMIN THEN
            RETURN 'Y';
        END IF;

        SELECT um.DATA_SCOPE, NVL(um.SCOPE_UNIT_ID, e.UNIT_ID)
          INTO l_scope, l_root
          FROM MOINFO_USERS u
          JOIN MOINFO_USER_MODULES um ON um.USER_ID = u.USER_ID
          LEFT JOIN MOINFO_EMPLOYEES e ON e.EMPLOYEE_ID = u.EMPLOYEE_ID
         WHERE u.USERNAME = l_user
           AND u.IS_ACTIVE = 'Y'
           AND um.MODULE_CODE = UPPER(p_module)
           AND um.IS_ACTIVE = 'Y';

        IF l_scope = 'ALL' THEN
            RETURN 'Y';
        ELSIF l_scope = 'UNIT' AND l_root IS NOT NULL AND p_unit_id IS NOT NULL THEN
            SELECT COUNT(*)
              INTO l_n
              FROM MOINFO_UNITS
             WHERE UNIT_ID = p_unit_id
             START WITH UNIT_ID = l_root
           CONNECT BY PRIOR UNIT_ID = PARENT_ID;
            RETURN CASE WHEN l_n > 0 THEN 'Y' ELSE 'N' END;
        END IF;

        -- OWN: التصفية تتم في الوحدة نفسها على CREATED_BY
        RETURN 'N';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'N';
    END CAN_SEE_UNIT;

END MOINFO_SEC;
/

--==============================================================================
-- 8) مدير النظام: ADMIN / Admin#2026 (يُطلب تغييرها عند أول دخول)
--==============================================================================
DECLARE
    l_user_id NUMBER;
BEGIN
    BEGIN
        SELECT USER_ID INTO l_user_id FROM MOINFO_USERS WHERE USERNAME = 'ADMIN';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO MOINFO_USERS (USERNAME, DISPLAY_NAME, IS_SYS_ADMIN, HOME_MODULE)
            VALUES ('ADMIN', 'مدير النظام', 'Y', 'CORE')
            RETURNING USER_ID INTO l_user_id;
    END;

    MOINFO_AUTH.SET_PASSWORD(l_user_id, 'Admin#2026', 'Y');
    COMMIT;
END;
/


--==============================================================================
-- 9) التحقق: يجب ألا تظهر كائنات INVALID
--==============================================================================
SELECT OBJECT_TYPE, OBJECT_NAME, STATUS
  FROM USER_OBJECTS
 WHERE OBJECT_NAME LIKE 'MOINFO\_%' ESCAPE '\'
   AND OBJECT_TYPE IN ('PACKAGE', 'PACKAGE BODY', 'TRIGGER', 'VIEW')
 ORDER BY STATUS DESC, OBJECT_TYPE, OBJECT_NAME;
