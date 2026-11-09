--------------------------------------------------------------------------------
-- إصلاح لمن شغّل النسخة الأولى من 03_moinfo_hr.sql
-- رقم البصمة هو الرقم الوظيفي، فيُحذف العمود ATTENDANCE_PIN من بيانات الموظف،
-- ويُربط سجل البصمة بالموظف عبر EMPLOYEE_NO.
-- لا حاجة لتشغيله إن ثبّتّ النسخة المحدّثة من 03 مباشرة.
--------------------------------------------------------------------------------
DECLARE
    l_n NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_n
      FROM USER_TAB_COLUMNS
     WHERE TABLE_NAME = 'MOINFO_HR_EMPLOYEE_DETAILS'
       AND COLUMN_NAME = 'ATTENDANCE_PIN';
    IF l_n > 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE MOINFO_HR_EMPLOYEE_DETAILS DROP COLUMN ATTENDANCE_PIN';
    END IF;
END;
/

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
  LEFT JOIN MOINFO_EMPLOYEES e ON e.EMPLOYEE_NO = a.ATTENDANCE_PIN;


--==============================================================================
-- إعادة توليد الـ Triggers بعد حذف العمود
--==============================================================================
BEGIN
    MOINFO_UTIL.CREATE_ALL_TRIGGERS('MOINFO\_HR\_%');
END;
/

SELECT OBJECT_TYPE, OBJECT_NAME, STATUS
  FROM USER_OBJECTS
 WHERE OBJECT_NAME LIKE 'MOINFO\_HR%' ESCAPE '\'
   AND OBJECT_TYPE IN ('TABLE', 'PACKAGE', 'PACKAGE BODY', 'TRIGGER', 'VIEW')
 ORDER BY STATUS DESC, OBJECT_TYPE, OBJECT_NAME;
