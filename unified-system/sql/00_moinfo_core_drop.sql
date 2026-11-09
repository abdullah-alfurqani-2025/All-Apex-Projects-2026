--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- السكربت 00: حذف كائنات النواة لإعادة التثبيت (للبيئة التجريبية فقط)
--
-- يتوقف تلقائيًا إن لم يجد الجدول MOINFO_MODULES، وهو جدول موجود في النظام
-- الموحد فقط. هذا يمنع تشغيله بالخطأ في Schema الخاص بـ ServiceDesk أو ABDULLAH.
--------------------------------------------------------------------------------
DECLARE
    l_n NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n FROM USER_TABLES WHERE TABLE_NAME = 'MOINFO_MODULES';
    IF l_n = 0 THEN
        RAISE_APPLICATION_ERROR(-20099, 'هذا ليس Schema النظام الموحد (لا يوجد MOINFO_MODULES). تم الإيقاف.');
    END IF;

    FOR r IN (SELECT OBJECT_NAME, OBJECT_TYPE
                FROM USER_OBJECTS
               WHERE OBJECT_TYPE IN ('PACKAGE', 'VIEW')
                 AND OBJECT_NAME IN ('MOINFO_UTIL', 'MOINFO_AUTH', 'MOINFO_SEC', 'MOINFO_V_UNITS'))
    LOOP
        EXECUTE IMMEDIATE 'DROP ' || r.OBJECT_TYPE || ' "' || r.OBJECT_NAME || '"';
    END LOOP;

    FOR r IN (SELECT TABLE_NAME
                FROM USER_TABLES
               WHERE TABLE_NAME IN (
                     'MOINFO_ATTACHMENTS', 'MOINFO_AUDIT_LOG', 'MOINFO_LOGIN_HISTORY',
                     'MOINFO_USER_MODULES', 'MOINFO_USER_CREDENTIALS', 'MOINFO_USERS',
                     'MOINFO_ROLES', 'MOINFO_EMPLOYEES', 'MOINFO_WILAYATS',
                     'MOINFO_GOVERNORATES', 'MOINFO_COUNTRIES', 'MOINFO_TITLES',
                     'MOINFO_UNITS', 'MOINFO_LEVELS', 'MOINFO_MODULES', 'MOINFO_SETTINGS'))
    LOOP
        EXECUTE IMMEDIATE 'DROP TABLE "' || r.TABLE_NAME || '" CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/
