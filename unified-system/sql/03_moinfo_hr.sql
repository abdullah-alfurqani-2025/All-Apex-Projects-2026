--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- السكربت 03: وحدة الموارد البشرية (HR) — بديل HrSystem (f100)
--
-- يُشغَّل بعد 01 و 02 في نفس الـ Schema.
--
-- ما الذي انتقل إلى أين من PRT_HR_*:
--   PRT_HR_SECTORS / DEPARTMENTS / SECTIONS  ← MOINFO_UNITS (النواة)
--   PRT_HR_USERSTYPES                        ← MOINFO_ROLES (النواة)
--   PRT_HR_LOGINHISTORY                      ← MOINFO_LOGIN_HISTORY (النواة)
--   PRT_HR_EMPLOYEES (71 عمودًا) قُسّم إلى:
--       البيانات الأساسية          ← MOINFO_EMPLOYEES (النواة)
--       اسم المستخدم وكلمة المرور  ← MOINFO_USERS / MOINFO_USER_CREDENTIALS (النواة)
--       البيانات الشخصية والحساسة  ← MOINFO_HR_EMPLOYEE_DETAILS
--       الهواتف والتحويلات         ← MOINFO_HR_DIRECTORY
--   PRT_HR_ZK_CHECKINOUT                     ← MOINFO_HR_ATTENDANCE_LOG
--
-- أعمدة لم تُنقل:
--   AGE            ← يُحسب من تاريخ الميلاد في الـ View
--   MINISTRY_NAME  ← إعداد واحد HR_ORGANIZATION_NAME بدل تكراره في كل سجل
--   GENDER_NEW / MARTST_NEW / NATIONALITY (نصية) ← مكررة مع الأعمدة المرمّزة
--   ACTION_DELETE / ACTION_RESTORE / ACTION_RESET ← كانت أعمدة مساعدة للواجهة
--   IS_DELETED / IS_BLOCKED ← IS_ACTIVE في النواة
--------------------------------------------------------------------------------


--==============================================================================
-- 1) القوائم المرجعية الخاصة بالوحدة
--==============================================================================
INSERT INTO MOINFO_LOOKUP_TYPES (LOOKUP_TYPE, MODULE_CODE, TYPE_NAME_AR, TYPE_NAME_EN) VALUES ('HR_MARITAL_STATUS',   'HR', 'الحالة الاجتماعية', 'Marital Status');
INSERT INTO MOINFO_LOOKUP_TYPES (LOOKUP_TYPE, MODULE_CODE, TYPE_NAME_AR, TYPE_NAME_EN) VALUES ('HR_RELIGION',         'HR', 'الديانة',           'Religion');
INSERT INTO MOINFO_LOOKUP_TYPES (LOOKUP_TYPE, MODULE_CODE, TYPE_NAME_AR, TYPE_NAME_EN) VALUES ('HR_APPOINTMENT_TYPE', 'HR', 'نوع التعيين',       'Appointment Type');
INSERT INTO MOINFO_LOOKUP_TYPES (LOOKUP_TYPE, MODULE_CODE, TYPE_NAME_AR, TYPE_NAME_EN) VALUES ('HR_QUALIFICATION',    'HR', 'المؤهل العلمي',     'Qualification');
INSERT INTO MOINFO_LOOKUP_TYPES (LOOKUP_TYPE, MODULE_CODE, TYPE_NAME_AR, TYPE_NAME_EN) VALUES ('HR_BANK',             'HR', 'البنك',             'Bank');
INSERT INTO MOINFO_LOOKUP_TYPES (LOOKUP_TYPE, MODULE_CODE, TYPE_NAME_AR, TYPE_NAME_EN) VALUES ('HR_EMP_STATUS',       'HR', 'حالة الموظف',       'Employee Status');

INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_MARITAL_STATUS', 'SINGLE',   'أعزب',  'Single',   1);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_MARITAL_STATUS', 'MARRIED',  'متزوج', 'Married',  2);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_MARITAL_STATUS', 'DIVORCED', 'مطلق',  'Divorced', 3);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_MARITAL_STATUS', 'WIDOWED',  'أرمل',  'Widowed',  4);

INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_QUALIFICATION', 'BELOW_SEC', 'دون الثانوية', 'Below Secondary', 1);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_QUALIFICATION', 'SECONDARY', 'دبلوم عام',    'Secondary',       2);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_QUALIFICATION', 'DIPLOMA',   'دبلوم',        'Diploma',         3);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_QUALIFICATION', 'BACHELOR',  'بكالوريوس',    'Bachelor',        4);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_QUALIFICATION', 'MASTER',    'ماجستير',      'Master',          5);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_QUALIFICATION', 'PHD',       'دكتوراه',      'PhD',             6);

INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_EMP_STATUS', 'ACTIVE',    'على رأس العمل', 'Active',      1);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_EMP_STATUS', 'LEAVE',     'في إجازة',      'On Leave',    2);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_EMP_STATUS', 'SECONDED',  'منتدب',         'Seconded',    3);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_EMP_STATUS', 'RETIRED',   'متقاعد',        'Retired',     4);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_EMP_STATUS', 'RESIGNED',  'مستقيل',        'Resigned',    5);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('HR_EMP_STATUS', 'ENDED',     'منتهية خدمته',  'Terminated',  6);

-- إعدادات الوحدة
INSERT INTO MOINFO_SETTINGS (SETTING_KEY, SETTING_VALUE, DESCRIPTION)
VALUES ('HR_ORGANIZATION_NAME', NULL, 'اسم الجهة (كان يتكرر في كل سجل موظف باسم MINISTRY_NAME)');
INSERT INTO MOINFO_SETTINGS (SETTING_KEY, SETTING_VALUE, DESCRIPTION)
VALUES ('HR_DOC_EXPIRY_DAYS', '90', 'عدد الأيام قبل انتهاء البطاقة أو الجواز لإظهارها في تقرير الوثائق');

-- سجل البصمة كثيف الإدخال، فلا يُسجَّل في التدقيق
UPDATE MOINFO_SETTINGS
   SET SETTING_VALUE = CASE
                           WHEN SETTING_VALUE IS NULL THEN 'MOINFO_HR_ATTENDANCE_LOG'
                           ELSE SETTING_VALUE || ',MOINFO_HR_ATTENDANCE_LOG'
                       END
 WHERE SETTING_KEY = 'AUDIT_EXCLUDE_TABLES';

COMMIT;


--==============================================================================
-- 2) الجداول
--==============================================================================

-- البيانات الشخصية والحساسة: سجل واحد لكل موظف.
-- لا يطّلع عليها إلا من له دور MANAGER أو أعلى في وحدة HR، والموظف على بياناته.
CREATE TABLE MOINFO_HR_EMPLOYEE_DETAILS (
    EMPLOYEE_ID             NUMBER              NOT NULL,
    E_EMPLOYEE_NO           VARCHAR2(30),
    BUDGET_NO               VARCHAR2(30),
    BUDGET_NAME             VARCHAR2(255 CHAR),
    GRADE                   VARCHAR2(30),
    POSITION_CODE           VARCHAR2(30),
    APPOINTMENT_TYPE_ID     NUMBER,
    UPGRADE_DATE            DATE,
    BIRTH_DATE              DATE,
    BIRTH_PLACE             VARCHAR2(255 CHAR),
    NATIONALITY_ID          NUMBER,
    MARITAL_STATUS_ID       NUMBER,
    RELIGION_ID             NUMBER,
    QUALIFICATION_ID        NUMBER,
    QUALIFICATION_DETAILS   VARCHAR2(500 CHAR),
    CIVIL_ID_NO             VARCHAR2(30),
    CIVIL_ID_ISSUE_DATE     DATE,
    CIVIL_ID_EXPIRY_DATE    DATE,
    PASSPORT_NO             VARCHAR2(30),
    PASSPORT_ISSUE_PLACE    VARCHAR2(255 CHAR),
    PASSPORT_ISSUE_DATE     DATE,
    PASSPORT_EXPIRY_DATE    DATE,
    ADDRESS                 VARCHAR2(500 CHAR),
    ADDRESS2                VARCHAR2(500 CHAR),
    MOBILE2                 VARCHAR2(30),
    BASIC_SALARY            NUMBER(12,3),
    BANK_ID                 NUMBER,
    BANK_BRANCH             VARCHAR2(150 CHAR),
    BANK_ACCOUNT_NO         VARCHAR2(50),
    LEAVE_BALANCE_1         NUMBER(6,1),
    LEAVE_BALANCE_2         NUMBER(6,1),
    EMP_STATUS_ID           NUMBER,
    ATTENDANCE_PIN          VARCHAR2(20),
    DATA_VERIFIED_AT        DATE,
    REMARKS                 VARCHAR2(1000 CHAR),
    CREATED_BY              VARCHAR2(255),
    CREATED_AT              TIMESTAMP WITH LOCAL TIME ZONE,
    UPDATED_BY              VARCHAR2(255),
    UPDATED_AT              TIMESTAMP WITH LOCAL TIME ZONE,
    CONSTRAINT MOINFO_HR_EMP_DET_PK PRIMARY KEY (EMPLOYEE_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_EMP_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES MOINFO_EMPLOYEES (EMPLOYEE_ID) ON DELETE CASCADE,
    CONSTRAINT MOINFO_HR_EMP_DET_CIVIL_UK UNIQUE (CIVIL_ID_NO),
    CONSTRAINT MOINFO_HR_EMP_DET_PIN_UK UNIQUE (ATTENDANCE_PIN),
    CONSTRAINT MOINFO_HR_EMP_DET_APPT_FK FOREIGN KEY (APPOINTMENT_TYPE_ID) REFERENCES MOINFO_LOOKUPS (LOOKUP_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_NAT_FK FOREIGN KEY (NATIONALITY_ID) REFERENCES MOINFO_COUNTRIES (COUNTRY_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_MAR_FK FOREIGN KEY (MARITAL_STATUS_ID) REFERENCES MOINFO_LOOKUPS (LOOKUP_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_REL_FK FOREIGN KEY (RELIGION_ID) REFERENCES MOINFO_LOOKUPS (LOOKUP_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_QUAL_FK FOREIGN KEY (QUALIFICATION_ID) REFERENCES MOINFO_LOOKUPS (LOOKUP_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_BANK_FK FOREIGN KEY (BANK_ID) REFERENCES MOINFO_LOOKUPS (LOOKUP_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_STATUS_FK FOREIGN KEY (EMP_STATUS_ID) REFERENCES MOINFO_LOOKUPS (LOOKUP_ID),
    CONSTRAINT MOINFO_HR_EMP_DET_SALARY_CK CHECK (BASIC_SALARY IS NULL OR BASIC_SALARY >= 0)
);
CREATE INDEX MOINFO_HR_EMP_DET_APPT_IX   ON MOINFO_HR_EMPLOYEE_DETAILS (APPOINTMENT_TYPE_ID);
CREATE INDEX MOINFO_HR_EMP_DET_NAT_IX    ON MOINFO_HR_EMPLOYEE_DETAILS (NATIONALITY_ID);
CREATE INDEX MOINFO_HR_EMP_DET_MAR_IX    ON MOINFO_HR_EMPLOYEE_DETAILS (MARITAL_STATUS_ID);
CREATE INDEX MOINFO_HR_EMP_DET_REL_IX    ON MOINFO_HR_EMPLOYEE_DETAILS (RELIGION_ID);
CREATE INDEX MOINFO_HR_EMP_DET_QUAL_IX   ON MOINFO_HR_EMPLOYEE_DETAILS (QUALIFICATION_ID);
CREATE INDEX MOINFO_HR_EMP_DET_BANK_IX   ON MOINFO_HR_EMPLOYEE_DETAILS (BANK_ID);
CREATE INDEX MOINFO_HR_EMP_DET_STATUS_IX ON MOINFO_HR_EMPLOYEE_DETAILS (EMP_STATUS_ID);

-- دليل الهواتف والتحويلات (بديل صفحة EmployeesExt). بيانات غير حساسة يراها الجميع.
-- رقم الجوال والتحويلة الأساسية والبريد في MOINFO_EMPLOYEES.
CREATE TABLE MOINFO_HR_DIRECTORY (
    EMPLOYEE_ID         NUMBER                  NOT NULL,
    PHONE_EXT2          VARCHAR2(20),
    TEL1                VARCHAR2(30),
    TEL2                VARCHAR2(30),
    FAX1                VARCHAR2(30),
    FAX2                VARCHAR2(30),
    OFFICE_DEVICE       VARCHAR2(200 CHAR),
    SHOW_IN_DIRECTORY   VARCHAR2(1) DEFAULT ON NULL 'Y' NOT NULL,
    REMARKS             VARCHAR2(500 CHAR),
    CREATED_BY          VARCHAR2(255),
    CREATED_AT          TIMESTAMP WITH LOCAL TIME ZONE,
    UPDATED_BY          VARCHAR2(255),
    UPDATED_AT          TIMESTAMP WITH LOCAL TIME ZONE,
    CONSTRAINT MOINFO_HR_DIRECTORY_PK PRIMARY KEY (EMPLOYEE_ID),
    CONSTRAINT MOINFO_HR_DIRECTORY_EMP_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES MOINFO_EMPLOYEES (EMPLOYEE_ID) ON DELETE CASCADE,
    CONSTRAINT MOINFO_HR_DIRECTORY_SHOW_CK CHECK (SHOW_IN_DIRECTORY IN ('Y','N'))
);

-- سجل البصمة المستورد من أجهزة ZK. يُربط بالموظف عبر ATTENDANCE_PIN.
-- القيد الفريد يمنع تكرار الحركة عند إعادة الاستيراد.
CREATE TABLE MOINFO_HR_ATTENDANCE_LOG (
    LOG_ID              NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    ATTENDANCE_PIN      VARCHAR2(20)            NOT NULL,
    CHECK_TIME          TIMESTAMP               NOT NULL,
    CHECK_TYPE          VARCHAR2(20),
    VERIFY_CODE         NUMBER,
    WORK_CODE           VARCHAR2(20),
    DEVICE_SN           VARCHAR2(40),
    LOCATION            VARCHAR2(100 CHAR),
    CREATED_BY          VARCHAR2(255),
    CREATED_AT          TIMESTAMP WITH LOCAL TIME ZONE,
    CONSTRAINT MOINFO_HR_ATT_LOG_PK PRIMARY KEY (LOG_ID),
    CONSTRAINT MOINFO_HR_ATT_LOG_UK UNIQUE (ATTENDANCE_PIN, CHECK_TIME, DEVICE_SN)
);
CREATE INDEX MOINFO_HR_ATT_LOG_TIME_IX ON MOINFO_HR_ATTENDANCE_LOG (CHECK_TIME);


--==============================================================================
-- 3) MOINFO_HR: دوال الوحدة
--==============================================================================
CREATE OR REPLACE PACKAGE MOINFO_HR AS

    -- رقم الموظف المرتبط بالمستخدم الحالي (لصفحة "بياناتي")
    -- مثال: WHERE EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID
    FUNCTION MY_EMPLOYEE_ID RETURN NUMBER;

    -- هل يحق للمستخدم الحالي رؤية البيانات الحساسة لموظف معيّن؟
    -- 'Y' لصاحب البيانات، أو لمن له دور MANAGER فأعلى في HR ويقع الموظف ضمن نطاقه.
    FUNCTION CAN_VIEW_DETAILS (p_employee_id IN NUMBER) RETURN VARCHAR2;

END MOINFO_HR;
/

CREATE OR REPLACE PACKAGE BODY MOINFO_HR AS

    FUNCTION MY_EMPLOYEE_ID RETURN NUMBER IS
        l_user VARCHAR2(255) := UPPER(TRIM(V('APP_USER')));
        l_id   NUMBER;
    BEGIN
        SELECT EMPLOYEE_ID
          INTO l_id
          FROM MOINFO_USERS
         WHERE USERNAME = l_user
           AND IS_ACTIVE = 'Y';
        RETURN l_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END MY_EMPLOYEE_ID;

    FUNCTION CAN_VIEW_DETAILS (p_employee_id IN NUMBER) RETURN VARCHAR2 IS
        l_unit_id NUMBER;
    BEGIN
        IF p_employee_id IS NULL THEN
            RETURN 'N';
        END IF;

        IF p_employee_id = MY_EMPLOYEE_ID THEN
            RETURN 'Y';
        END IF;

        IF NOT MOINFO_SEC.HAS_ROLE('HR', 'MANAGER') THEN
            RETURN 'N';
        END IF;

        IF MOINFO_SEC.DATA_SCOPE('HR') = 'ALL' THEN
            RETURN 'Y';
        END IF;

        SELECT UNIT_ID INTO l_unit_id FROM MOINFO_EMPLOYEES WHERE EMPLOYEE_ID = p_employee_id;
        RETURN MOINFO_SEC.CAN_SEE_UNIT('HR', l_unit_id);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'N';
    END CAN_VIEW_DETAILS;

END MOINFO_HR;
/


--==============================================================================
-- 4) Views
--==============================================================================

-- الموظفون مع وحدتهم ومسماهم (بيانات غير حساسة)
CREATE OR REPLACE VIEW MOINFO_HR_V_EMPLOYEES AS
SELECT e.EMPLOYEE_ID,
       e.EMPLOYEE_NO,
       e.NAME_AR,
       e.NAME_EN,
       e.GENDER,
       e.HIRE_DATE,
       e.EMAIL,
       e.MOBILE,
       e.PHONE_EXT,
       e.IS_ACTIVE,
       e.UNIT_ID,
       u.UNIT_NAME_AR,
       u.UNIT_PATH_AR,
       e.TITLE_ID,
       t.TITLE_NAME_AR,
       usr.USER_ID,
       usr.USERNAME,
       st.NAME_AR AS EMP_STATUS_AR
  FROM MOINFO_EMPLOYEES e
  LEFT JOIN MOINFO_V_UNITS u               ON u.UNIT_ID = e.UNIT_ID
  LEFT JOIN MOINFO_TITLES t                ON t.TITLE_ID = e.TITLE_ID
  LEFT JOIN MOINFO_USERS usr               ON usr.EMPLOYEE_ID = e.EMPLOYEE_ID
  LEFT JOIN MOINFO_HR_EMPLOYEE_DETAILS d   ON d.EMPLOYEE_ID = e.EMPLOYEE_ID
  LEFT JOIN MOINFO_LOOKUPS st              ON st.LOOKUP_ID = d.EMP_STATUS_ID;

-- البيانات الكاملة. استخدمها دائمًا مع الشرط:
--   WHERE MOINFO_HR.CAN_VIEW_DETAILS(EMPLOYEE_ID) = 'Y'
CREATE OR REPLACE VIEW MOINFO_HR_V_EMPLOYEE_DETAILS AS
SELECT e.EMPLOYEE_ID,
       e.EMPLOYEE_NO,
       e.NAME_AR,
       e.NAME_EN,
       e.GENDER,
       e.HIRE_DATE,
       e.EMAIL,
       e.MOBILE,
       e.PHONE_EXT,
       e.IS_ACTIVE,
       e.UNIT_ID,
       u.UNIT_PATH_AR,
       t.TITLE_NAME_AR,
       d.E_EMPLOYEE_NO,
       d.BUDGET_NO,
       d.BUDGET_NAME,
       d.GRADE,
       d.POSITION_CODE,
       appt.NAME_AR AS APPOINTMENT_TYPE_AR,
       d.UPGRADE_DATE,
       d.BIRTH_DATE,
       TRUNC(MONTHS_BETWEEN(SYSDATE, d.BIRTH_DATE) / 12) AS AGE,
       d.BIRTH_PLACE,
       c.NAME_AR AS NATIONALITY_COUNTRY_AR,
       c.NATIONALITY_AR,
       mar.NAME_AR AS MARITAL_STATUS_AR,
       rel.NAME_AR AS RELIGION_AR,
       qual.NAME_AR AS QUALIFICATION_AR,
       d.QUALIFICATION_DETAILS,
       d.CIVIL_ID_NO,
       d.CIVIL_ID_ISSUE_DATE,
       d.CIVIL_ID_EXPIRY_DATE,
       d.PASSPORT_NO,
       d.PASSPORT_ISSUE_PLACE,
       d.PASSPORT_ISSUE_DATE,
       d.PASSPORT_EXPIRY_DATE,
       d.ADDRESS,
       d.ADDRESS2,
       d.MOBILE2,
       d.BASIC_SALARY,
       bank.NAME_AR AS BANK_AR,
       d.BANK_BRANCH,
       d.BANK_ACCOUNT_NO,
       d.LEAVE_BALANCE_1,
       d.LEAVE_BALANCE_2,
       st.NAME_AR AS EMP_STATUS_AR,
       d.ATTENDANCE_PIN,
       d.DATA_VERIFIED_AT,
       d.REMARKS
  FROM MOINFO_EMPLOYEES e
  LEFT JOIN MOINFO_HR_EMPLOYEE_DETAILS d ON d.EMPLOYEE_ID = e.EMPLOYEE_ID
  LEFT JOIN MOINFO_V_UNITS u             ON u.UNIT_ID = e.UNIT_ID
  LEFT JOIN MOINFO_TITLES t              ON t.TITLE_ID = e.TITLE_ID
  LEFT JOIN MOINFO_COUNTRIES c           ON c.COUNTRY_ID = d.NATIONALITY_ID
  LEFT JOIN MOINFO_LOOKUPS appt          ON appt.LOOKUP_ID = d.APPOINTMENT_TYPE_ID
  LEFT JOIN MOINFO_LOOKUPS mar           ON mar.LOOKUP_ID = d.MARITAL_STATUS_ID
  LEFT JOIN MOINFO_LOOKUPS rel           ON rel.LOOKUP_ID = d.RELIGION_ID
  LEFT JOIN MOINFO_LOOKUPS qual          ON qual.LOOKUP_ID = d.QUALIFICATION_ID
  LEFT JOIN MOINFO_LOOKUPS bank          ON bank.LOOKUP_ID = d.BANK_ID
  LEFT JOIN MOINFO_LOOKUPS st            ON st.LOOKUP_ID = d.EMP_STATUS_ID;

-- دليل الهواتف (بديل EmployeesExt)
CREATE OR REPLACE VIEW MOINFO_HR_V_DIRECTORY AS
SELECT e.EMPLOYEE_ID,
       e.NAME_AR,
       e.NAME_EN,
       u.UNIT_NAME_AR,
       u.UNIT_PATH_AR,
       t.TITLE_NAME_AR,
       e.EMAIL,
       e.MOBILE,
       e.PHONE_EXT,
       dir.PHONE_EXT2,
       dir.TEL1,
       dir.TEL2,
       dir.FAX1,
       dir.FAX2,
       dir.OFFICE_DEVICE
  FROM MOINFO_EMPLOYEES e
  LEFT JOIN MOINFO_HR_DIRECTORY dir ON dir.EMPLOYEE_ID = e.EMPLOYEE_ID
  LEFT JOIN MOINFO_V_UNITS u        ON u.UNIT_ID = e.UNIT_ID
  LEFT JOIN MOINFO_TITLES t         ON t.TITLE_ID = e.TITLE_ID
 WHERE e.IS_ACTIVE = 'Y'
   AND NVL(dir.SHOW_IN_DIRECTORY, 'Y') = 'Y';

-- تقرير البيانات الناقصة (بديل Incompleted Data Report): كل موظف ينقصه حقل أساسي
CREATE OR REPLACE VIEW MOINFO_HR_V_INCOMPLETE AS
SELECT EMPLOYEE_ID,
       EMPLOYEE_NO,
       NAME_AR,
       UNIT_PATH_AR,
       MISSING_FIELDS
  FROM (SELECT e.EMPLOYEE_ID,
               e.EMPLOYEE_NO,
               e.NAME_AR,
               u.UNIT_PATH_AR,
               RTRIM(
                      CASE WHEN e.EMPLOYEE_NO        IS NULL THEN 'الرقم الوظيفي، '   END
                   || CASE WHEN e.UNIT_ID            IS NULL THEN 'الوحدة التنظيمية، ' END
                   || CASE WHEN e.TITLE_ID           IS NULL THEN 'المسمى الوظيفي، '  END
                   || CASE WHEN e.MOBILE             IS NULL THEN 'الجوال، '          END
                   || CASE WHEN e.EMAIL              IS NULL THEN 'البريد، '          END
                   || CASE WHEN d.CIVIL_ID_NO        IS NULL THEN 'البطاقة المدنية، ' END
                   || CASE WHEN d.CIVIL_ID_EXPIRY_DATE IS NULL THEN 'انتهاء البطاقة، ' END
                   || CASE WHEN d.BIRTH_DATE         IS NULL THEN 'تاريخ الميلاد، '   END
                   || CASE WHEN d.NATIONALITY_ID     IS NULL THEN 'الجنسية، '         END
                   || CASE WHEN d.QUALIFICATION_ID   IS NULL THEN 'المؤهل، '          END
                   || CASE WHEN d.BANK_ACCOUNT_NO    IS NULL THEN 'الحساب البنكي، '   END,
                   '، ') AS MISSING_FIELDS
          FROM MOINFO_EMPLOYEES e
          LEFT JOIN MOINFO_HR_EMPLOYEE_DETAILS d ON d.EMPLOYEE_ID = e.EMPLOYEE_ID
          LEFT JOIN MOINFO_V_UNITS u             ON u.UNIT_ID = e.UNIT_ID
         WHERE e.IS_ACTIVE = 'Y')
 WHERE MISSING_FIELDS IS NOT NULL;

-- وثائق منتهية أو تقترب من الانتهاء (البطاقة المدنية والجواز)
CREATE OR REPLACE VIEW MOINFO_HR_V_EXPIRING_DOCS AS
SELECT e.EMPLOYEE_ID,
       e.EMPLOYEE_NO,
       e.NAME_AR,
       u.UNIT_PATH_AR,
       x.DOC_TYPE_AR,
       x.DOC_NO,
       x.EXPIRY_DATE,
       x.EXPIRY_DATE - TRUNC(SYSDATE) AS DAYS_LEFT
  FROM MOINFO_EMPLOYEES e
  JOIN MOINFO_HR_EMPLOYEE_DETAILS d ON d.EMPLOYEE_ID = e.EMPLOYEE_ID
  LEFT JOIN MOINFO_V_UNITS u        ON u.UNIT_ID = e.UNIT_ID
 CROSS APPLY (
        SELECT CAST('البطاقة المدنية' AS VARCHAR2(50 CHAR)) AS DOC_TYPE_AR, d.CIVIL_ID_NO AS DOC_NO, d.CIVIL_ID_EXPIRY_DATE AS EXPIRY_DATE FROM DUAL
        UNION ALL
        SELECT CAST('جواز السفر' AS VARCHAR2(50 CHAR)), d.PASSPORT_NO, d.PASSPORT_EXPIRY_DATE FROM DUAL
       ) x
 WHERE e.IS_ACTIVE = 'Y'
   AND x.EXPIRY_DATE IS NOT NULL
   AND x.EXPIRY_DATE <= TRUNC(SYSDATE)
                        + TO_NUMBER(NVL((SELECT s.SETTING_VALUE
                                           FROM MOINFO_SETTINGS s
                                          WHERE s.SETTING_KEY = 'HR_DOC_EXPIRY_DAYS'), '90'));

-- سجل البصمة مع اسم الموظف
CREATE OR REPLACE VIEW MOINFO_HR_V_ATTENDANCE AS
SELECT a.LOG_ID,
       a.ATTENDANCE_PIN,
       a.CHECK_TIME,
       TRUNC(a.CHECK_TIME) AS CHECK_DATE,
       a.CHECK_TYPE,
       a.DEVICE_SN,
       a.LOCATION,
       e.EMPLOYEE_ID,
       e.EMPLOYEE_NO,
       e.NAME_AR,
       e.UNIT_ID
  FROM MOINFO_HR_ATTENDANCE_LOG a
  LEFT JOIN MOINFO_HR_EMPLOYEE_DETAILS d ON d.ATTENDANCE_PIN = a.ATTENDANCE_PIN
  LEFT JOIN MOINFO_EMPLOYEES e           ON e.EMPLOYEE_ID = d.EMPLOYEE_ID;


--==============================================================================
-- 5) Triggers (سجل البصمة بلا تدقيق حسب الإعداد AUDIT_EXCLUDE_TABLES)
--==============================================================================
BEGIN
    MOINFO_UTIL.CREATE_ALL_TRIGGERS('MOINFO\_HR\_%');
END;
/


--==============================================================================
-- 6) التحقق
--==============================================================================
SELECT OBJECT_TYPE, OBJECT_NAME, STATUS
  FROM USER_OBJECTS
 WHERE OBJECT_NAME LIKE 'MOINFO\_HR%' ESCAPE '\'
   AND OBJECT_TYPE IN ('TABLE', 'PACKAGE', 'PACKAGE BODY', 'TRIGGER', 'VIEW')
 ORDER BY STATUS DESC, OBJECT_TYPE, OBJECT_NAME;
