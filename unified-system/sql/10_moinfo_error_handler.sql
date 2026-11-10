--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- السكربت 10: دالة معالجة الأخطاء للتطبيق (Error Handling Function)
--
-- يُشغَّل بعد 01 إلى 09. يربطها التطبيق 145032 في خصائصه (Error Handling Function).
--
-- ما تفعله:
--   - أخطاء النظام المقصودة (RAISE_APPLICATION_ERROR من -20000 إلى -20999) تظهر رسالتها
--     العربية فقط، بدون "ORA-20056:" وبدون سطر ORA-06512.
--   - أخطاء القيود الشائعة تظهر برسالة عربية مفهومة بدل نص Oracle:
--       ORA-00001 قيمة مكررة، ORA-02292 حذف سجل مرتبط بسجلات أخرى،
--       ORA-02291 قيمة مرتبطة غير موجودة، ORA-02290 قيمة غير مسموحة، ORA-01400 حقل مطلوب.
--   - غير ذلك يبقى كما يعرضه APEX.
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION MOINFO_APEX_ERROR_HANDLER (
    p_error IN APEX_ERROR.T_ERROR
) RETURN APEX_ERROR.T_ERROR_RESULT
IS
    l_result APEX_ERROR.T_ERROR_RESULT;
    l_constraint VARCHAR2(255);
BEGIN
    l_result := APEX_ERROR.INIT_ERROR_RESULT(p_error => p_error);

    IF p_error.ora_sqlcode BETWEEN -20999 AND -20000 THEN
        l_result.message := APEX_ERROR.GET_FIRST_ORA_ERROR_TEXT(p_error => p_error);
        l_result.additional_info := NULL;
    ELSIF p_error.ora_sqlcode IN (-1, -2290, -2291, -2292, -1400) THEN
        l_constraint := APEX_ERROR.EXTRACT_CONSTRAINT_NAME(p_error => p_error, p_include_schema => FALSE);
        l_result.message :=
            CASE p_error.ora_sqlcode
                WHEN -1    THEN 'القيمة مسجلة من قبل، ولا يمكن تكرارها'
                WHEN -2292 THEN 'لا يمكن حذف هذا السجل لأنه مرتبط بسجلات أخرى'
                WHEN -2291 THEN 'القيمة المختارة غير موجودة في القائمة المرتبطة'
                WHEN -2290 THEN 'قيمة غير مسموحة في أحد الحقول'
                WHEN -1400 THEN 'حقل مطلوب لم يُعبّأ'
            END
            || CASE WHEN l_constraint IS NOT NULL THEN ' (' || l_constraint || ')' END;
        l_result.additional_info := NULL;
    END IF;

    -- ربط الخطأ بالحقل المعني إن أمكن
    IF l_result.page_item_name IS NULL AND l_result.column_alias IS NULL THEN
        APEX_ERROR.AUTO_SET_ASSOCIATED_ITEM(p_error => p_error, p_error_result => l_result);
    END IF;

    RETURN l_result;
END MOINFO_APEX_ERROR_HANDLER;
/

SELECT OBJECT_TYPE, OBJECT_NAME, STATUS
  FROM USER_OBJECTS
 WHERE OBJECT_NAME = 'MOINFO_APEX_ERROR_HANDLER';
