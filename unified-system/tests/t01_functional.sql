DECLARE
    l_ok        BOOLEAN;
    l_uid       NUMBER;
    l_lvl1      NUMBER;
    l_lvl2      NUMBER;
    l_sector    NUMBER;
    l_dept      NUMBER;
    l_emp1      NUMBER;
    l_emp2      NUMBER;
    l_evt_type  NUMBER;
    l_ev1       NUMBER;
    l_task      NUMBER;
    l_done      NUMBER;
    l_new       NUMBER;
    l_closed    DATE;
    l_cov       NUMBER;
    l_ch        NUMBER;
    l_n         NUMBER;
    l_txt       VARCHAR2(4000);
    l_fail      NUMBER := 0;
    PROCEDURE chk (p_name VARCHAR2, p_cond BOOLEAN) IS
    BEGIN
        IF p_cond THEN DBMS_OUTPUT.PUT_LINE('PASS  ' || p_name);
        ELSE DBMS_OUTPUT.PUT_LINE('FAIL  ' || p_name); l_fail := l_fail + 1; END IF;
    END;
BEGIN
    -- 1) المستخدمون والمصادقة
    l_uid := MOINFO_ADMIN.CREATE_USER('zz_test_user', 'مستخدم اختبار', 'Test#1234');
    SELECT COUNT(*) INTO l_n FROM MOINFO_USERS WHERE USER_ID = l_uid AND USERNAME = 'ZZ_TEST_USER';
    chk('CREATE_USER stores upper username', l_n = 1);
    SELECT COUNT(*) INTO l_n FROM MOINFO_USER_CREDENTIALS WHERE USER_ID = l_uid AND LENGTH(PASSWORD_HASH) = 64 AND MUST_CHANGE_PWD = 'Y';
    chk('password hashed (64 hex) + must change', l_n = 1);
    chk('VALIDATE_PASSWORD_RULES rejects short', MOINFO_AUTH.VALIDATE_PASSWORD_RULES('ab1') IS NOT NULL);
    chk('VALIDATE_PASSWORD_RULES rejects no digit', MOINFO_AUTH.VALIDATE_PASSWORD_RULES('abcdefghij') IS NOT NULL);
    chk('VALIDATE_PASSWORD_RULES accepts good', MOINFO_AUTH.VALIDATE_PASSWORD_RULES('Good#2026') IS NULL);
    chk('same password+salt gives same hash', MOINFO_AUTH.HASH_PASSWORD('x1y2z3w4','S') = MOINFO_AUTH.HASH_PASSWORD('x1y2z3w4','S'));
    chk('different salt gives different hash', MOINFO_AUTH.HASH_PASSWORD('x1y2z3w4','S1') <> MOINFO_AUTH.HASH_PASSWORD('x1y2z3w4','S2'));
    chk('AUTHENTICATE correct password', MOINFO_AUTH.AUTHENTICATE('zz_test_user', 'Test#1234'));
    chk('AUTHENTICATE wrong password', NOT MOINFO_AUTH.AUTHENTICATE('zz_test_user', 'Wrong#1234'));
    chk('AUTHENTICATE unknown user', NOT MOINFO_AUTH.AUTHENTICATE('zz_nobody', 'Test#1234'));
    chk('ADMIN exists with credentials', MOINFO_AUTH.MUST_CHANGE_PASSWORD('ADMIN') IS NOT NULL);

    -- 2) الهيكل التنظيمي والتدقيق
    SELECT LEVEL_ID INTO l_lvl1 FROM MOINFO_LEVELS WHERE LEVEL_DEPTH = 1;
    SELECT LEVEL_ID INTO l_lvl2 FROM MOINFO_LEVELS WHERE LEVEL_DEPTH = 2;
    INSERT INTO MOINFO_UNITS (LEVEL_ID, UNIT_NAME_AR) VALUES (l_lvl1, 'قطاع اختبار') RETURNING UNIT_ID INTO l_sector;
    INSERT INTO MOINFO_UNITS (PARENT_ID, LEVEL_ID, UNIT_NAME_AR) VALUES (l_sector, l_lvl2, 'دائرة اختبار') RETURNING UNIT_ID INTO l_dept;
    SELECT COUNT(*) INTO l_n FROM MOINFO_UNITS WHERE UNIT_ID = l_dept AND CREATED_BY IS NOT NULL AND CREATED_AT IS NOT NULL;
    chk('trigger fills CREATED_BY/AT', l_n = 1);
    SELECT COUNT(*) INTO l_n FROM MOINFO_AUDIT_LOG WHERE TABLE_NAME = 'MOINFO_UNITS' AND ROW_PK = TO_CHAR(l_dept) AND ACTION = 'I' AND JSON_VALUE(NEW_DATA, '$.UNIT_NAME_AR') = 'دائرة اختبار';
    chk('audit log insert with JSON + PK', l_n = 1);
    UPDATE MOINFO_UNITS SET UNIT_NAME_EN = 'Test Dept' WHERE UNIT_ID = l_dept;
    SELECT COUNT(*) INTO l_n FROM MOINFO_AUDIT_LOG WHERE TABLE_NAME = 'MOINFO_UNITS' AND ROW_PK = TO_CHAR(l_dept) AND ACTION = 'U';
    chk('audit log update', l_n = 1);
    UPDATE MOINFO_UNITS SET UNIT_NAME_EN = 'Test Dept' WHERE UNIT_ID = l_dept;
    SELECT COUNT(*) INTO l_n FROM MOINFO_AUDIT_LOG WHERE TABLE_NAME = 'MOINFO_UNITS' AND ROW_PK = TO_CHAR(l_dept) AND ACTION = 'U';
    chk('no audit row when nothing changed', l_n = 1);
    SELECT COUNT(*) INTO l_n FROM MOINFO_V_UNITS WHERE UNIT_ID = l_dept AND UNIT_PATH_AR = 'قطاع اختبار » دائرة اختبار' AND TREE_DEPTH = 2;
    chk('V_UNITS path and depth', l_n = 1);

    -- 3) الموظفون و HR
    INSERT INTO MOINFO_EMPLOYEES (EMPLOYEE_NO, NAME_AR, UNIT_ID) VALUES ('ZZ001', 'موظف اختبار 1', l_dept) RETURNING EMPLOYEE_ID INTO l_emp1;
    INSERT INTO MOINFO_EMPLOYEES (EMPLOYEE_NO, NAME_AR, UNIT_ID) VALUES ('ZZ002', 'موظف اختبار 2', l_sector) RETURNING EMPLOYEE_ID INTO l_emp2;
    INSERT INTO MOINFO_HR_EMPLOYEE_DETAILS (EMPLOYEE_ID, CIVIL_ID_NO, CIVIL_ID_EXPIRY_DATE, BIRTH_DATE)
    VALUES (l_emp1, 'ZZ-CIV-1', TRUNC(SYSDATE) + 10, ADD_MONTHS(TRUNC(SYSDATE), -12 * 30));
    SELECT COUNT(*) INTO l_n FROM MOINFO_HR_V_EMPLOYEE_DETAILS WHERE EMPLOYEE_ID = l_emp1 AND AGE = 30;
    chk('HR age computed', l_n = 1);
    SELECT COUNT(*) INTO l_n FROM MOINFO_HR_V_EXPIRING_DOCS WHERE EMPLOYEE_ID = l_emp1 AND DAYS_LEFT = 10;
    chk('HR expiring docs (civil id in 10 days)', l_n = 1);
    SELECT COUNT(*) INTO l_n FROM MOINFO_HR_V_INCOMPLETE WHERE EMPLOYEE_ID = l_emp2 AND MISSING_FIELDS LIKE '%الجوال%';
    chk('HR incomplete report', l_n = 1);
    INSERT INTO MOINFO_HR_ATTENDANCE_LOG (ATTENDANCE_PIN, CHECK_TIME, DEVICE_SN) VALUES ('ZZ001', SYSTIMESTAMP, 'DEV1');
    SELECT COUNT(*) INTO l_n FROM MOINFO_HR_V_ATTENDANCE WHERE EMPLOYEE_ID = l_emp1;
    chk('attendance linked by EMPLOYEE_NO', l_n = 1);
    SELECT COUNT(*) INTO l_n FROM MOINFO_AUDIT_LOG WHERE TABLE_NAME = 'MOINFO_HR_ATTENDANCE_LOG';
    chk('attendance excluded from audit', l_n = 0);

    -- 4) مشاركات الموظفين
    SELECT LOOKUP_ID INTO l_evt_type FROM MOINFO_LOOKUPS WHERE LOOKUP_TYPE = 'EVT_TYPE' AND LOOKUP_CODE = 'COURSE';
    INSERT INTO MOINFO_EVT_EVENTS (EMPLOYEE_ID, EVENT_TYPE_ID, TITLE, START_DATE, END_DATE)
    VALUES (l_emp1, l_evt_type, 'دورة 1', DATE '2026-01-10', DATE '2026-01-14') RETURNING EVENT_ID INTO l_ev1;
    chk('HAS_OVERLAP Y', MOINFO_EVT.HAS_OVERLAP(l_emp1, DATE '2026-01-13', DATE '2026-01-20') = 'Y');
    chk('HAS_OVERLAP N', MOINFO_EVT.HAS_OVERLAP(l_emp1, DATE '2026-01-15', DATE '2026-01-20') = 'N');
    chk('HAS_OVERLAP excludes self', MOINFO_EVT.HAS_OVERLAP(l_emp1, DATE '2026-01-10', DATE '2026-01-14', l_ev1) = 'N');
    l_txt := MOINFO_EVT.OVERLAP_MESSAGE(l_emp1, DATE '2026-01-13', DATE '2026-01-20');
    chk('OVERLAP_MESSAGE text', l_txt LIKE '%دورة 1%');
    INSERT INTO MOINFO_EVT_EVENTS (EMPLOYEE_ID, EVENT_TYPE_ID, TITLE, START_DATE, END_DATE)
    VALUES (l_emp1, l_evt_type, 'دورة 2', DATE '2026-01-13', DATE '2026-01-16');
    SELECT MAX(OVERLAP_DAYS) INTO l_n FROM MOINFO_EVT_V_OVERLAPS WHERE EMPLOYEE_ID = l_emp1;
    chk('V_OVERLAPS 2 days', l_n = 2);
    SELECT SUM(TOTAL_DAYS) INTO l_n FROM MOINFO_EVT_V_EMPLOYEE_SUMMARY WHERE EMPLOYEE_ID = l_emp1;
    chk('summary total days 9', l_n = 9);
    BEGIN
        INSERT INTO MOINFO_EVT_EVENTS (EMPLOYEE_ID, EVENT_TYPE_ID, TITLE, START_DATE, END_DATE)
        VALUES (l_emp1, l_evt_type, 'خطأ', DATE '2026-02-10', DATE '2026-02-01');
        chk('end before start rejected', FALSE);
    EXCEPTION WHEN OTHERS THEN chk('end before start rejected', SQLCODE = -2290);
    END;

    -- 5) المهام
    l_done := MOINFO_TSK.GET_STATUS_ID('DONE');
    l_new  := MOINFO_TSK.GET_STATUS_ID('NEW');
    INSERT INTO MOINFO_TSK_TASKS (TITLE, STATUS_ID, ASSIGNED_EMPLOYEE_ID, RECEIVED_DATE)
    VALUES ('مهمة اختبار', l_new, l_emp1, TRUNC(SYSDATE) - 3) RETURNING TASK_ID INTO l_task;
    MOINFO_TSK.ADD_NOTE(l_task, 'تم الإنجاز', l_done);
    SELECT CLOSED_DATE INTO l_closed FROM MOINFO_TSK_TASKS WHERE TASK_ID = l_task;
    chk('closing sets CLOSED_DATE', l_closed = TRUNC(SYSDATE));
    UPDATE MOINFO_TSK_TASKS SET STATUS_ID = l_new WHERE TASK_ID = l_task;
    SELECT CLOSED_DATE INTO l_closed FROM MOINFO_TSK_TASKS WHERE TASK_ID = l_task;
    chk('reopen clears CLOSED_DATE', l_closed IS NULL);
    SELECT COUNT(*) INTO l_n FROM MOINFO_TSK_V_TASKS WHERE TASK_ID = l_task AND DURATION_DAYS = 3 AND STATUS_CODE = 'NEW';
    chk('V_TASKS duration', l_n = 1);
    SELECT COUNT(*) INTO l_n FROM MOINFO_TSK_V_NOTES WHERE TASK_ID = l_task;
    chk('task note stored', l_n = 1);

    -- 6) التغطيات الإعلامية
    INSERT INTO MOINFO_MED_CHANNELS (NAME_AR) VALUES ('قناة اختبار') RETURNING CHANNEL_ID INTO l_ch;
    INSERT INTO MOINFO_MED_COVERAGES (COVERAGE_DATE, CHANNEL_ID) VALUES (TRUNC(SYSDATE), l_ch) RETURNING COVERAGE_ID INTO l_cov;
    MOINFO_MED.SET_CREW(l_cov, 'PHOTOGRAPHER', l_emp1 || ':' || l_emp2);
    chk('SET_CREW two photographers', MOINFO_MED.GET_CREW_IDS(l_cov, 'PHOTOGRAPHER') = LEAST(l_emp1,l_emp2) || ':' || GREATEST(l_emp1,l_emp2));
    MOINFO_MED.SET_CREW(l_cov, 'PHOTOGRAPHER', TO_CHAR(l_emp2));
    chk('SET_CREW replaces list', MOINFO_MED.GET_CREW_IDS(l_cov, 'PHOTOGRAPHER') = TO_CHAR(l_emp2));
    SELECT COUNT(*) INTO l_n FROM MOINFO_MED_V_COVERAGES WHERE COVERAGE_ID = l_cov AND PHOTOGRAPHERS = 'موظف اختبار 2';
    chk('V_COVERAGES crew names', l_n = 1);
    SELECT SUM(ADDED_TODAY) INTO l_n FROM MOINFO_MED_V_STATS WHERE CHANNEL_AR = 'قناة اختبار';
    chk('V_STATS added today', l_n = 1);

    -- 7) المرفقات
    SELECT COUNT(*) INTO l_n FROM MOINFO_ATT_V_DOCUMENTS;
    chk('ATT view queryable', l_n >= 0);
    chk('FORMAT_SIZE', MOINFO_FILES.FORMAT_SIZE(2621440) = '2.5 MB');

    DBMS_OUTPUT.PUT_LINE('---- FAILURES: ' || l_fail);
    ROLLBACK;
    -- سجل الدخول يُكتب في معاملة مستقلة، فيُحذف يدويًا
    DELETE FROM MOINFO_LOGIN_HISTORY WHERE USERNAME IN ('ZZ_TEST_USER', 'ZZ_NOBODY');
    DBMS_OUTPUT.PUT_LINE('login history rows cleaned: ' || SQL%ROWCOUNT);
    COMMIT;
END;
