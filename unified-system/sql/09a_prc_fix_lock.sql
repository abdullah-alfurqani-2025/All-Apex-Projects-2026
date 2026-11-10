--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- السكربت 09a: إصلاح Trigger قفل الأصناف في 09 (DECODE لا تُستخدم في PL/SQL)
-- التثبيت الجديد يكفيه 09.
--------------------------------------------------------------------------------

-- الأصناف تُضاف وتُعدّل في المسودة فقط. بعد التقديم يُسمح بقرار الاعتماد على الصنف وحده.
-- (الحذف غير مقيّد هنا حتى لا يتعارض مع حذف الطلب بالتسلسل؛ الصفحات تمنعه بعد التقديم)
CREATE OR REPLACE TRIGGER MOINFO_PRC_ITEMS_LOCK_BIU
BEFORE INSERT OR UPDATE ON MOINFO_PRC_REQUEST_ITEMS
FOR EACH ROW
DECLARE
    l_status MOINFO_LOOKUPS.LOOKUP_CODE%TYPE;
    FUNCTION SAME (a IN NUMBER, b IN NUMBER) RETURN BOOLEAN IS
    BEGIN
        RETURN (a = b) OR (a IS NULL AND b IS NULL);
    END;
    FUNCTION SAME (a IN VARCHAR2, b IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN (a = b) OR (a IS NULL AND b IS NULL);
    END;
BEGIN
    SELECT s.LOOKUP_CODE INTO l_status
      FROM MOINFO_PRC_REQUESTS r
      JOIN MOINFO_LOOKUPS s ON s.LOOKUP_ID = r.STATUS_ID
     WHERE r.REQUEST_ID = :NEW.REQUEST_ID;

    IF l_status = 'DRAFT' THEN
        RETURN;
    END IF;

    IF INSERTING THEN
        RAISE_APPLICATION_ERROR(-20051, 'لا يمكن إضافة أصناف بعد تقديم الطلب');
    END IF;

    IF l_status = 'SUBMITTED'
       AND :NEW.REQUEST_ID = :OLD.REQUEST_ID
       AND :NEW.ITEM_NAME = :OLD.ITEM_NAME
       AND :NEW.QUANTITY = :OLD.QUANTITY
       AND SAME(:NEW.UNIT_PRICE, :OLD.UNIT_PRICE)
       AND SAME(:NEW.PRODUCT_TYPE_ID, :OLD.PRODUCT_TYPE_ID)
       AND SAME(:NEW.BRAND_ID, :OLD.BRAND_ID)
       AND SAME(:NEW.MODEL_ID, :OLD.MODEL_ID)
       AND SAME(:NEW.SUPPLIER_ID, :OLD.SUPPLIER_ID)
       AND SAME(:NEW.DESCRIPTION, :OLD.DESCRIPTION) THEN
        RETURN;  -- قرار الاعتماد على الصنف فقط
    END IF;

    RAISE_APPLICATION_ERROR(-20052, 'لا يمكن تعديل أصناف الطلب بعد تقديمه');
END;
/



ALTER PACKAGE MOINFO_PRC COMPILE;
ALTER PACKAGE MOINFO_PRC COMPILE BODY;

SELECT OBJECT_TYPE, OBJECT_NAME, STATUS
  FROM USER_OBJECTS
 WHERE OBJECT_NAME LIKE 'MOINFO\_PRC%' ESCAPE '\'
   AND OBJECT_TYPE IN ('TABLE', 'PACKAGE', 'PACKAGE BODY', 'TRIGGER', 'VIEW', 'SEQUENCE')
 ORDER BY STATUS DESC, OBJECT_TYPE, OBJECT_NAME;
