--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- السكربت 08a: تعديل على 08 (لمن نفّذ 08 قبل هذا التعديل)
--   - الحالة الافتراضية للجهاز الجديد (IN_STOCK) ولطلب الدعم الجديد (NEW) من قاعدة البيانات
--   - الدالة MOINFO_HD.IS_MANAGER للاستخدام في SQL
-- التثبيت الجديد يكفيه 08 (يحتوي هذا التعديل).
--------------------------------------------------------------------------------

--==============================================================================
-- 4) Triggers القواعد (منفصلة عن Triggers التدقيق المولّدة)
--==============================================================================

-- نهاية الضمان تُحسب من البداية ونوع الضمان إن لم تُدخل يدويًا
CREATE OR REPLACE TRIGGER MOINFO_HD_DEVICES_WARR_BIU
BEFORE INSERT OR UPDATE OF WARRANTY_TYPE_ID, WARRANTY_START, WARRANTY_END, STATUS_ID ON MOINFO_HD_DEVICES
FOR EACH ROW
DECLARE
    l_months NUMBER;
BEGIN
    -- الجهاز الجديد بدون حالة يبدأ في المخزن
    IF :NEW.STATUS_ID IS NULL THEN
        SELECT LOOKUP_ID INTO :NEW.STATUS_ID
          FROM MOINFO_LOOKUPS
         WHERE LOOKUP_TYPE = 'HD_DEVICE_STATUS' AND LOOKUP_CODE = 'IN_STOCK';
    END IF;
    IF :NEW.WARRANTY_END IS NULL AND :NEW.WARRANTY_START IS NOT NULL AND :NEW.WARRANTY_TYPE_ID IS NOT NULL THEN
        SELECT MONTHS INTO l_months FROM MOINFO_CAT_WARRANTY_TYPES WHERE WARRANTY_TYPE_ID = :NEW.WARRANTY_TYPE_ID;
        IF l_months > 0 THEN
            :NEW.WARRANTY_END := ADD_MONTHS(:NEW.WARRANTY_START, l_months) - 1;
        END IF;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER MOINFO_HD_PARTS_WARR_BIU
BEFORE INSERT OR UPDATE OF WARRANTY_TYPE_ID, WARRANTY_START, WARRANTY_END ON MOINFO_HD_SPARE_PARTS
FOR EACH ROW
DECLARE
    l_months NUMBER;
BEGIN
    IF :NEW.WARRANTY_END IS NULL AND :NEW.WARRANTY_START IS NOT NULL AND :NEW.WARRANTY_TYPE_ID IS NOT NULL THEN
        SELECT MONTHS INTO l_months FROM MOINFO_CAT_WARRANTY_TYPES WHERE WARRANTY_TYPE_ID = :NEW.WARRANTY_TYPE_ID;
        IF l_months > 0 THEN
            :NEW.WARRANTY_END := ADD_MONTHS(:NEW.WARRANTY_START, l_months) - 1;
        END IF;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
END;
/

-- إغلاق طلب الدعم: تاريخ الإغلاق يُعبّأ للحالتين DONE و CANCELLED ويُمسح عند إعادة الفتح
CREATE OR REPLACE TRIGGER MOINFO_HD_REQUESTS_CLOSE_BIU
BEFORE INSERT OR UPDATE OF STATUS_ID, CLOSED_DATE ON MOINFO_HD_REQUESTS
FOR EACH ROW
DECLARE
    l_code MOINFO_LOOKUPS.LOOKUP_CODE%TYPE;
BEGIN
    -- الطلب الجديد بدون حالة يبدأ بالحالة NEW (الموظف العادي لا يرى حقل الحالة)
    IF :NEW.STATUS_ID IS NULL THEN
        SELECT LOOKUP_ID INTO :NEW.STATUS_ID
          FROM MOINFO_LOOKUPS
         WHERE LOOKUP_TYPE = 'HD_REQUEST_STATUS' AND LOOKUP_CODE = 'NEW';
    END IF;
    SELECT LOOKUP_CODE INTO l_code FROM MOINFO_LOOKUPS WHERE LOOKUP_ID = :NEW.STATUS_ID;
    IF l_code IN ('DONE', 'CANCELLED') THEN
        IF :NEW.CLOSED_DATE IS NULL THEN
            :NEW.CLOSED_DATE := GREATEST(TRUNC(SYSDATE), :NEW.REQUEST_DATE);
        END IF;
    ELSE
        :NEW.CLOSED_DATE := NULL;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
END;
/


--==============================================================================
-- 5) MOINFO_HD: دوال الوحدة
--==============================================================================
CREATE OR REPLACE PACKAGE MOINFO_HD AS

    -- رقم قيمة مرجعية من نوعها ورمزها، مثل LOOKUP_ID('HD_REQUEST_STATUS', 'NEW')
    FUNCTION LOOKUP_ID (p_type IN VARCHAR2, p_code IN VARCHAR2) RETURN NUMBER;

    -- تسليم جهاز لموظف أو وحدة: يغلق التسليم السابق المفتوح، وينشئ تسليمًا جديدًا،
    -- ويحدّث حامل الجهاز الحالي وحالته إلى ASSIGNED
    PROCEDURE ASSIGN_DEVICE (
        p_device_id   IN NUMBER,
        p_employee_id IN NUMBER,
        p_unit_id     IN NUMBER DEFAULT NULL,
        p_date        IN DATE   DEFAULT TRUNC(SYSDATE),
        p_remarks     IN VARCHAR2 DEFAULT NULL
    );

    -- استرجاع الجهاز إلى المخزن: يغلق التسليم المفتوح ويعيد الحالة إلى IN_STOCK
    PROCEDURE RETURN_DEVICE (
        p_device_id IN NUMBER,
        p_date      IN DATE DEFAULT TRUNC(SYSDATE),
        p_remarks   IN VARCHAR2 DEFAULT NULL
    );

    -- 'Y' إن كان المستخدم الحالي فني دعم (دور MANAGER أو أعلى في الوحدة HD). صالحة للاستخدام في SQL
    FUNCTION IS_MANAGER RETURN VARCHAR2;

    -- 'Y' إن كان يحق للمستخدم الحالي رؤية طلب الدعم
    FUNCTION CAN_SEE_REQUEST (p_request_id IN NUMBER) RETURN VARCHAR2;

    -- يضيف ملاحظة متابعة للطلب، ويغيّر حالته إن أُرسلت حالة جديدة
    PROCEDURE ADD_NOTE (p_request_id IN NUMBER, p_note_text IN VARCHAR2, p_status_id IN NUMBER DEFAULT NULL);

END MOINFO_HD;
/

CREATE OR REPLACE PACKAGE BODY MOINFO_HD AS

    FUNCTION LOOKUP_ID (p_type IN VARCHAR2, p_code IN VARCHAR2) RETURN NUMBER IS
        l_id NUMBER;
    BEGIN
        SELECT LOOKUP_ID INTO l_id
          FROM MOINFO_LOOKUPS
         WHERE LOOKUP_TYPE = UPPER(p_type)
           AND LOOKUP_CODE = UPPER(p_code);
        RETURN l_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END LOOKUP_ID;

    PROCEDURE ASSIGN_DEVICE (
        p_device_id   IN NUMBER,
        p_employee_id IN NUMBER,
        p_unit_id     IN NUMBER DEFAULT NULL,
        p_date        IN DATE   DEFAULT TRUNC(SYSDATE),
        p_remarks     IN VARCHAR2 DEFAULT NULL
    ) IS
        l_unit   NUMBER := p_unit_id;
        l_date   DATE   := NVL(p_date, TRUNC(SYSDATE));
        l_status NUMBER := LOOKUP_ID('HD_DEVICE_STATUS', 'ASSIGNED');
    BEGIN
        IF p_employee_id IS NULL AND p_unit_id IS NULL THEN
            RAISE_APPLICATION_ERROR(-20040, 'حدد الموظف أو الوحدة التي يُسلَّم لها الجهاز');
        END IF;

        IF l_unit IS NULL THEN
            SELECT MAX(UNIT_ID) INTO l_unit FROM MOINFO_EMPLOYEES WHERE EMPLOYEE_ID = p_employee_id;
        END IF;

        UPDATE MOINFO_HD_ASSIGNMENTS
           SET RETURN_DATE = GREATEST(l_date, ASSIGNED_DATE)
         WHERE DEVICE_ID = p_device_id
           AND RETURN_DATE IS NULL;

        INSERT INTO MOINFO_HD_ASSIGNMENTS (DEVICE_ID, EMPLOYEE_ID, UNIT_ID, ASSIGNED_DATE, REMARKS)
        VALUES (p_device_id, p_employee_id, l_unit, l_date, p_remarks);

        UPDATE MOINFO_HD_DEVICES
           SET CURRENT_EMPLOYEE_ID = p_employee_id,
               CURRENT_UNIT_ID     = l_unit,
               STATUS_ID           = l_status
         WHERE DEVICE_ID = p_device_id;
    END ASSIGN_DEVICE;

    PROCEDURE RETURN_DEVICE (
        p_device_id IN NUMBER,
        p_date      IN DATE DEFAULT TRUNC(SYSDATE),
        p_remarks   IN VARCHAR2 DEFAULT NULL
    ) IS
        l_date   DATE   := NVL(p_date, TRUNC(SYSDATE));
        l_status NUMBER := LOOKUP_ID('HD_DEVICE_STATUS', 'IN_STOCK');
    BEGIN
        UPDATE MOINFO_HD_ASSIGNMENTS
           SET RETURN_DATE = GREATEST(l_date, ASSIGNED_DATE),
               REMARKS     = CASE
                                 WHEN p_remarks IS NULL THEN REMARKS
                                 ELSE SUBSTR(REMARKS || CASE WHEN REMARKS IS NOT NULL THEN ' / ' END || p_remarks, 1, 1000)
                             END
         WHERE DEVICE_ID = p_device_id
           AND RETURN_DATE IS NULL;

        UPDATE MOINFO_HD_DEVICES
           SET CURRENT_EMPLOYEE_ID = NULL,
               CURRENT_UNIT_ID     = NULL,
               STATUS_ID           = l_status
         WHERE DEVICE_ID = p_device_id;
    END RETURN_DEVICE;

    FUNCTION IS_MANAGER RETURN VARCHAR2 IS
    BEGIN
        RETURN CASE WHEN MOINFO_SEC.HAS_ROLE('HD', 'MANAGER') THEN 'Y' ELSE 'N' END;
    END IS_MANAGER;

    FUNCTION CAN_SEE_REQUEST (p_request_id IN NUMBER) RETURN VARCHAR2 IS
        l_scope      VARCHAR2(10);
        l_requester  NUMBER;
        l_assigned   NUMBER;
        l_unit_id    NUMBER;
        l_my_emp     NUMBER;
        l_created_by VARCHAR2(255);
        l_me         VARCHAR2(255) := UPPER(TRIM(V('APP_USER')));
    BEGIN
        l_scope := MOINFO_SEC.DATA_SCOPE('HD');
        IF l_scope = 'ALL' THEN
            RETURN 'Y';
        ELSIF l_scope IS NULL THEN
            RETURN 'N';
        END IF;

        SELECT r.REQUESTER_EMPLOYEE_ID, r.ASSIGNED_EMPLOYEE_ID, e.UNIT_ID, r.CREATED_BY
          INTO l_requester, l_assigned, l_unit_id, l_created_by
          FROM MOINFO_HD_REQUESTS r
          JOIN MOINFO_EMPLOYEES e ON e.EMPLOYEE_ID = r.REQUESTER_EMPLOYEE_ID
         WHERE r.REQUEST_ID = p_request_id;

        l_my_emp := MOINFO_HR.MY_EMPLOYEE_ID;
        IF (l_my_emp IS NOT NULL AND (l_requester = l_my_emp OR l_assigned = l_my_emp))
           OR UPPER(l_created_by) = l_me THEN
            RETURN 'Y';
        END IF;

        IF l_scope = 'UNIT' THEN
            RETURN MOINFO_SEC.CAN_SEE_UNIT('HD', l_unit_id);
        END IF;
        RETURN 'N';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'N';
    END CAN_SEE_REQUEST;

    PROCEDURE ADD_NOTE (p_request_id IN NUMBER, p_note_text IN VARCHAR2, p_status_id IN NUMBER DEFAULT NULL) IS
    BEGIN
        INSERT INTO MOINFO_HD_REQUEST_NOTES (REQUEST_ID, NOTE_TEXT, STATUS_ID)
        VALUES (p_request_id, p_note_text, p_status_id);

        IF p_status_id IS NOT NULL THEN
            UPDATE MOINFO_HD_REQUESTS
               SET STATUS_ID = p_status_id
             WHERE REQUEST_ID = p_request_id
               AND STATUS_ID <> p_status_id;
        END IF;
    END ADD_NOTE;

END MOINFO_HD;
/



SELECT OBJECT_TYPE, OBJECT_NAME, STATUS
  FROM USER_OBJECTS
 WHERE OBJECT_NAME IN ('MOINFO_HD', 'MOINFO_HD_DEVICES_WARR_BIU', 'MOINFO_HD_PARTS_WARR_BIU', 'MOINFO_HD_REQUESTS_CLOSE_BIU')
 ORDER BY OBJECT_TYPE, OBJECT_NAME;
