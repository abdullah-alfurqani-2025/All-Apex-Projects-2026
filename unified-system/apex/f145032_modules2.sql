prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد: صفحات الوحدات، الملف 2 (يُشغَّل بعد f145032.sql)
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.04.07'
,p_release=>'26.2.1'
,p_default_workspace_id=>12399410469927812686
,p_default_application_id=>145032
,p_default_id_offset=>0
,p_default_owner=>'WKSP_ABDULLAHALFURQANI2025'
);
end;
/

prompt --application/pages/delete_07002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>7002);
end;
/

prompt --application/pages/page_07002
begin
wwv_flow_imp_page.create_page(
 p_id=>7002
,p_name=>unistr('\0637\0644\0628 \0634\0631\0627\0621')
,p_alias=>'PRC-REQUEST'
,p_step_title=>unistr('\0637\0644\0628 \0634\0631\0627\0621')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000013)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001326)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-1326'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7002_REQUEST_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0637\0644\0628'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001326
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001327)
,p_plug_name=>unistr('\0637\0644\0628 \0634\0631\0627\0621')
,p_static_id=>'r930000000000001327'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_PRC_REQUESTS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001328)
,p_name=>'P7002_REQUEST_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_source=>'REQUEST_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001329)
,p_name=>'P7002_REQUEST_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\0637\0644\0628')
,p_source=>'REQUEST_NO'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P7002_REQUEST_ID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001330)
,p_name=>'P7002_STATUS_TXT'
,p_item_sequence=>6
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0627\0644\062D\0627\0644\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_display_when=>'P7002_REQUEST_ID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001331)
,p_name=>'P7002_SUBJECT'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0627\0644\0645\0648\0636\0648\0639')
,p_source=>'SUBJECT'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>300
,p_field_template=>1612549789555753698
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001332)
,p_name=>'P7002_REQUEST_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_default=>'to_char(sysdate, ''DD/MM/YYYY'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'REQUEST_DATE'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001333)
,p_name=>'P7002_REQUESTER_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_default=>'MOINFO_HR.MY_EMPLOYEE_ID'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0635\0627\062D\0628 \0627\0644\0637\0644\0628')
,p_source=>'REQUESTER_EMPLOYEE_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_display_when=>'MOINFO_SEC.HAS_ROLE(''PRC'', ''MANAGER'')'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001334)
,p_name=>'P7002_UNIT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0627\0644\062C\0647\0629 \0627\0644\0637\0627\0644\0628\0629')
,p_source=>'UNIT_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'UNITS'
,p_lov_display_null=>'YES'
,p_display_when=>'MOINFO_SEC.HAS_ROLE(''PRC'', ''MANAGER'')'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0625\0646 \062A\064F\0631\0643\062A \0641\0627\0631\063A\0629 \062A\0624\062E\0630 \062C\0647\0629 \0635\0627\062D\0628 \0627\0644\0637\0644\0628')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001335)
,p_name=>'P7002_JUSTIFICATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0627\0644\0645\0628\0631\0631\0627\062A')
,p_source=>'JUSTIFICATION'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cHeight=>4
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001336)
,p_name=>'P7002_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'REMARKS'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cHeight=>4
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001337)
,p_name=>'P7002_DECISION_TXT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0627\0644\0642\0631\0627\0631')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P7002_DECISION_TXT'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001338)
,p_name=>'P7002_PURCHASE_TXT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_prompt=>unistr('\0627\0644\0634\0631\0627\0621 \0648\0627\0644\0627\0633\062A\0644\0627\0645')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_display_when=>'P7002_PURCHASE_TXT'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001339)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load request info'
,p_static_id=>'load-request-info-1339'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for x in (select STATUS_AR, STATUS_CODE, DECIDED_BY_NAME, DECIDED_AT, DECISION_REASON, PO_NO,',
'                 PURCHASED_DATE, DELIVERED_DATE',
'            from MOINFO_PRC_V_REQUESTS where REQUEST_ID = :P7002_REQUEST_ID) loop',
'    :P7002_STATUS_TXT := x.STATUS_AR;',
'    if x.DECIDED_AT is not null or x.DECISION_REASON is not null then',
'        :P7002_DECISION_TXT := x.DECIDED_BY_NAME',
'            || nvl2(x.DECIDED_AT, '' - '' || to_char(cast(x.DECIDED_AT as date), ''DD/MM/YYYY HH24:MI''), '''')',
'            || nvl2(x.DECISION_REASON, '': '' || x.DECISION_REASON, '''');',
'    end if;',
'    if x.PURCHASED_DATE is not null then',
unistr('        :P7002_PURCHASE_TXT := ''\0627\0644\0634\0631\0627\0621 '' || to_char(x.PURCHASED_DATE, ''DD/MM/YYYY'')'),
unistr('            || nvl2(x.PO_NO, '' (\0623\0645\0631 '' || x.PO_NO || '')'', '''')'),
unistr('            || nvl2(x.DELIVERED_DATE, '' - \0627\0644\0627\0633\062A\0644\0627\0645 '' || to_char(x.DELIVERED_DATE, ''DD/MM/YYYY''), '''');'),
'    end if;',
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P7002_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>930000000000001339
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001340)
,p_validation_name=>'Requester known'
,p_static_id=>'requester-known-1340'
,p_validation_sequence=>10
,p_validation=>'nvl(:P7002_REQUESTER_EMPLOYEE_ID, MOINFO_HR.MY_EMPLOYEE_ID) is not null'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\062D\062F\062F \0635\0627\062D\0628 \0627\0644\0637\0644\0628 (\062D\0633\0627\0628\0643 \063A\064A\0631 \0645\0631\062A\0628\0637 \0628\0645\0648\0638\0641)')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001341)
,p_process_sequence=>15
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Default requester'
,p_static_id=>'default-requester-1341'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7002_REQUEST_ID is null and :P7002_REQUESTER_EMPLOYEE_ID is null then',
'    :P7002_REQUESTER_EMPLOYEE_ID := MOINFO_HR.MY_EMPLOYEE_ID;',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>930000000000001341
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001342)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_button_name=>'BACK'
,p_static_id=>'back-1342'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:7001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001343)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1343'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0627 \0627\0644\0637\0644\0628 \0648\0623\0635\0646\0627\0641\0647\061F')
,p_confirm_style=>'danger'
,p_button_condition=>':P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001344)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_button_name=>'SAVE'
,p_static_id=>'save-1344'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001345)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001327)
,p_button_name=>'CREATE'
,p_static_id=>'create-1345'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621 \0648\0625\0636\0627\0641\0629 \0627\0644\0623\0635\0646\0627\0641')
,p_button_position=>'CREATE'
,p_button_condition=>'P7002_REQUEST_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001346)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001327)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Request'
,p_static_id=>'init-1346'
,p_internal_uid=>930000000000001346
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001347)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001327)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Request'
,p_static_id=>'dml-1347'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001347
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001348)
,p_plug_name=>unistr('\0627\0644\0625\062C\0631\0627\0621\0627\062A')
,p_static_id=>'r930000000000001348'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>15
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P7002_REQUEST_ID'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001349)
,p_name=>'P7002_ACTION_REASON'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_prompt=>unistr('\0627\0644\0633\0628\0628 / \0627\0644\0645\0644\0627\062D\0638\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cHeight=>2
,p_display_when=>'MOINFO_PRC.CAN_DECIDE(:P7002_REQUEST_ID) = ''Y'' or MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in (''DRAFT'',''SUBMITTED'',''APPROVED'')'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001350)
,p_name=>'P7002_ACTION_DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_item_default=>'to_char(sysdate, ''DD/MM/YYYY'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_display_when=>'MOINFO_PRC.IS_PURCHASER = ''Y'' and MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in (''APPROVED'',''PURCHASED'')'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001351)
,p_name=>'P7002_ACTION_PO_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_prompt=>unistr('\0623\0645\0631 \0627\0644\0634\0631\0627\0621')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'HD_PURCHASE_ORDERS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_display_when=>'MOINFO_PRC.IS_PURCHASER = ''Y'' and MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in (''APPROVED'')'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001352)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_button_name=>'SUBMIT'
,p_static_id=>'submit-1352'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0642\062F\064A\0645 \0644\0644\0627\0639\062A\0645\0627\062F')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062A\0642\062F\064A\0645 \0627\0644\0637\0644\0628 \0644\0644\0627\0639\062A\0645\0627\062F\061F \0644\0646 \062A\062A\0645\0643\0646 \0645\0646 \062A\0639\062F\064A\0644 \0627\0644\0623\0635\0646\0627\0641 \0628\0639\062F\0647\0627')
,p_confirm_style=>'danger'
,p_button_condition=>'MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-send'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001353)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_button_name=>'APPROVE'
,p_static_id=>'approve-1353'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0627\0639\062A\0645\0627\062F')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0627\0639\062A\0645\0627\062F \0627\0644\0637\0644\0628\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'MOINFO_PRC.CAN_DECIDE(:P7002_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001354)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_button_name=>'REJECT'
,p_static_id=>'reject-1354'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\0631\0641\0636')
,p_button_position=>'NEXT'
,p_confirm_message=>unistr('\0631\0641\0636 \0627\0644\0637\0644\0628\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'MOINFO_PRC.CAN_DECIDE(:P7002_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001355)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_button_name=>'REOPEN'
,p_static_id=>'reopen-1355'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\0625\0639\0627\062F\0629 \0625\0644\0649 \0645\0633\0648\062F\0629')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>'MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in (''REJECTED'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001356)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_button_name=>'PURCHASE'
,p_static_id=>'purchase-1356'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\0634\0631\0627\0621')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>'MOINFO_PRC.IS_PURCHASER = ''Y'' and MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in (''APPROVED'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-shopping-cart'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001357)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_button_name=>'DELIVER'
,p_static_id=>'deliver-1357'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\0627\0633\062A\0644\0627\0645')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>'MOINFO_PRC.IS_PURCHASER = ''Y'' and MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in (''PURCHASED'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-truck'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001358)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(930000000000001348)
,p_button_name=>'CANCEL_REQ'
,p_static_id=>'cancel-req-1358'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621 \0627\0644\0637\0644\0628')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0625\0644\063A\0627\0621 \0627\0644\0637\0644\0628 \0646\0647\0627\0626\064A\064B\0627\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in (''DRAFT'',''SUBMITTED'',''APPROVED'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-ban'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001359)
,p_validation_name=>'Reject reason'
,p_static_id=>'reject-reason-1359'
,p_validation_sequence=>50
,p_validation=>'P7002_ACTION_REASON'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0633\0628\0628 \0627\0644\0631\0641\0636')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001354)
,p_associated_item=>wwv_flow_imp.id(930000000000001349)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001360)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action SUBMIT'
,p_static_id=>'action-submit-1360'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.SUBMIT(:P7002_REQUEST_ID);',
':P7002_ACTION_REASON := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001352)
,p_process_success_message=>unistr('\0642\064F\062F\0651\0645 \0627\0644\0637\0644\0628 \0644\0644\0627\0639\062A\0645\0627\062F')
,p_internal_uid=>930000000000001360
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001361)
,p_process_sequence=>31
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action APPROVE'
,p_static_id=>'action-approve-1361'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.APPROVE(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001353)
,p_process_success_message=>unistr('\0627\0639\062A\064F\0645\062F \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001361
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001362)
,p_process_sequence=>32
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action REJECT'
,p_static_id=>'action-reject-1362'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.REJECT(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001354)
,p_process_success_message=>unistr('\0631\064F\0641\0636 \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001362
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001363)
,p_process_sequence=>33
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action REOPEN'
,p_static_id=>'action-reopen-1363'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.REOPEN(:P7002_REQUEST_ID);',
':P7002_ACTION_REASON := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001355)
,p_process_success_message=>unistr('\0639\0627\062F \0627\0644\0637\0644\0628 \0645\0633\0648\062F\0629')
,p_internal_uid=>930000000000001363
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001364)
,p_process_sequence=>34
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action PURCHASE'
,p_static_id=>'action-purchase-1364'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.PURCHASE(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, ''DD/MM/YYYY''), :P7002_ACTION_PO_ID);',
':P7002_ACTION_REASON := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001356)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644 \0627\0644\0634\0631\0627\0621')
,p_internal_uid=>930000000000001364
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001365)
,p_process_sequence=>35
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action DELIVER'
,p_static_id=>'action-deliver-1365'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.DELIVER(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, ''DD/MM/YYYY''));',
':P7002_ACTION_REASON := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001357)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644 \0627\0644\0627\0633\062A\0644\0627\0645')
,p_internal_uid=>930000000000001365
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001366)
,p_process_sequence=>36
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action CANCEL_REQ'
,p_static_id=>'action-cancel-req-1366'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.CANCEL(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001358)
,p_process_success_message=>unistr('\0623\064F\0644\063A\064A \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001366
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001367)
,p_plug_name=>unistr('\0627\0644\0623\0635\0646\0627\0641')
,p_static_id=>'r930000000000001367'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ITEM_ID, ITEM_NAME, PRODUCT_TYPE_AR, BRAND_NAME, MODEL_NAME, SUPPLIER_AR, QUANTITY, UNIT_PRICE,',
'       LINE_TOTAL, APPROVAL_AR, REJECT_REASON, DESCRIPTION',
'  from MOINFO_PRC_V_ITEMS',
' where REQUEST_ID = :P7002_REQUEST_ID',
' order by SORT_ORDER nulls last, ITEM_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P7002_REQUEST_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001368)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:7003:&SESSION.::&DEBUG.:7003:P7003_ITEM_ID:#ITEM_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001368
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001369)
,p_db_column_name=>'ITEM_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ITEM_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001370)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0635\0646\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001371)
,p_db_column_name=>'PRODUCT_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001372)
,p_db_column_name=>'BRAND_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001373)
,p_db_column_name=>'MODEL_NAME'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001374)
,p_db_column_name=>'SUPPLIER_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0648\0631\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001375)
,p_db_column_name=>'QUANTITY'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0643\0645\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001376)
,p_db_column_name=>'UNIT_PRICE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0633\0639\0631 \0627\0644\0648\062D\062F\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001377)
,p_db_column_name=>'LINE_TOTAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0625\062C\0645\0627\0644\064A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001378)
,p_db_column_name=>'APPROVAL_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0642\0631\0627\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001379)
,p_db_column_name=>'REJECT_REASON'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0633\0628\0628 \0627\0644\0631\0641\0636')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001380)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0648\0635\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001381)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1382'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ITEM_NAME:PRODUCT_TYPE_AR:BRAND_NAME:MODEL_NAME:SUPPLIER_AR:QUANTITY:UNIT_PRICE:LINE_TOTAL:APPROVAL_AR:REJECT_REASON:DESCRIPTION:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001383)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001367)
,p_button_name=>'ADD_ITEM'
,p_static_id=>'add-item-1383'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629 \0635\0646\0641')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:7003:&SESSION.::&DEBUG.:7003:P7003_REQUEST_ID:&P7002_REQUEST_ID.'
,p_button_condition=>'MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001384)
,p_plug_name=>unistr('\0627\0644\0645\0631\0641\0642\0627\062A')
,p_static_id=>'r930000000000001384'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>40
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P7002_REQUEST_ID'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001385)
,p_name=>'P7002_FILES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001384)
,p_prompt=>unistr('\0625\0631\0641\0627\0642 \0645\0644\0641\0627\062A (\0639\0631\0636 \0633\0639\0631\060C \0641\0627\062A\0648\0631\0629 ...)')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_FILE'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_multiple_files', 'Y',
  'display_as', 'DROPZONE_BLOCK',
  'purge_file_at', 'REQUEST',
  'storage_type', 'APEX_APPLICATION_TEMP_FILES')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001386)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001384)
,p_button_name=>'UPLOAD'
,p_static_id=>'upload-1386'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\0631\0641\0639')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-upload'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001387)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Store files'
,p_static_id=>'store-files-1387'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_n number;',
'begin',
'    if MOINFO_PRC.CAN_SEE(:P7002_REQUEST_ID) = ''N'' then',
unistr('        raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0637\0644\0628'');'),
'    end if;',
'    l_n := MOINFO_FILES.ADD_FROM_APEX(''PRC'', ''MOINFO_PRC_REQUESTS'', :P7002_REQUEST_ID, :P7002_FILES);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001386)
,p_process_success_message=>unistr('\0631\064F\0641\0639\062A \0627\0644\0645\0644\0641\0627\062A')
,p_internal_uid=>930000000000001387
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001388)
,p_plug_name=>unistr('\0645\0644\0641\0627\062A \0627\0644\0637\0644\0628')
,p_static_id=>'r930000000000001388'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>50
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.ATTACHMENT_ID,',
'       ''<a href="'' || apex_page.get_url(p_page => 7004, p_items => ''P7004_ATTACHMENT_ID'', p_values => a.ATTACHMENT_ID)',
'       || ''"><span class="fa fa-download"></span> '' || apex_escape.html(a.FILE_NAME) || ''</a>'' as FILE_LINK,',
'       a.FILE_SIZE_TEXT, a.CREATED_BY_NAME, to_char(cast(a.CREATED_AT as date), ''DD/MM/YYYY HH24:MI'') as CREATED_AT_TXT',
'  from MOINFO_V_ATTACHMENTS a',
' where a.ENTITY_NAME = ''MOINFO_PRC_REQUESTS'' and a.ENTITY_ID = :P7002_REQUEST_ID',
' order by a.CREATED_AT desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P7002_REQUEST_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001389)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001389
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001390)
,p_db_column_name=>'ATTACHMENT_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ATTACHMENT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001391)
,p_db_column_name=>'FILE_LINK'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0645\0644\0641')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001392)
,p_db_column_name=>'FILE_SIZE_TEXT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\062C\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001393)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0631\0641\0639\0647')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001394)
,p_db_column_name=>'CREATED_AT_TXT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\0642\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001395)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1396'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FILE_LINK:FILE_SIZE_TEXT:CREATED_BY_NAME:CREATED_AT_TXT:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001397)
,p_branch_name=>'Go To Page 7001'
,p_branch_action=>'f?p=&APP_ID.:7001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000001343)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001398)
,p_branch_name=>'Go To Page 7002'
,p_branch_action=>'f?p=&APP_ID.:7002:&SESSION.::&DEBUG.::P7002_REQUEST_ID:&P7002_REQUEST_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_07003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>7003);
end;
/

prompt --application/pages/page_07003
begin
wwv_flow_imp_page.create_page(
 p_id=>7003
,p_name=>unistr('\0635\0646\0641')
,p_alias=>'PRC-ITEM'
,p_step_title=>unistr('\0635\0646\0641')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000013)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001399)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-1399'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7003_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7003_REQUEST_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0637\0644\0628'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001399
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001400)
,p_plug_name=>unistr('\0635\0646\0641')
,p_static_id=>'r930000000000001400'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_PRC_REQUEST_ITEMS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001401)
,p_name=>'P7003_ITEM_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_source=>'ITEM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001402)
,p_name=>'P7003_REQUEST_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>2
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_source=>'REQUEST_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001403)
,p_name=>'P7003_ITEM_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0627\0644\0635\0646\0641')
,p_source=>'ITEM_NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>300
,p_field_template=>1612549789555753698
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001404)
,p_name=>'P7003_PRODUCT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0627\0644\0646\0648\0639')
,p_source=>'PRODUCT_TYPE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'CAT_PRODUCT_TYPES'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001405)
,p_name=>'P7003_BRAND_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_source=>'BRAND_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'CAT_BRANDS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001406)
,p_name=>'P7003_MODEL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_source=>'MODEL_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'PRC_MODELS_BY_BRAND'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_lov_cascade_parent_items=>'P7003_BRAND_ID'
,p_ajax_optimize_refresh=>'Y'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001407)
,p_name=>'P7003_SUPPLIER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0627\0644\0645\0648\0631\062F \0627\0644\0645\0642\062A\0631\062D')
,p_source=>'SUPPLIER_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'CAT_SUPPLIERS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001408)
,p_name=>'P7003_QUANTITY'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_default=>'1'
,p_prompt=>unistr('\0627\0644\0643\0645\064A\0629')
,p_source=>'QUANTITY'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>1612549789555753698
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001409)
,p_name=>'P7003_UNIT_PRICE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0633\0639\0631 \0627\0644\0648\062D\062F\0629')
,p_source=>'UNIT_PRICE'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001410)
,p_name=>'P7003_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0627\0644\062A\0631\062A\064A\0628')
,p_source=>'SORT_ORDER'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001411)
,p_name=>'P7003_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0627\0644\0648\0635\0641 \0648\0627\0644\0645\0648\0627\0635\0641\0627\062A')
,p_source=>'DESCRIPTION'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cHeight=>4
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001412)
,p_name=>'P7003_IS_APPROVED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0642\0631\0627\0631 \0627\0644\0627\0639\062A\0645\0627\062F')
,p_source=>'IS_APPROVED'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'PRC_ITEM_DECISION'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0644\0645 \064A\064F\062D\062F\062F -')
,p_cHeight=>1
,p_display_when=>'MOINFO_PRC.CAN_DECIDE(:P7003_REQUEST_ID) = ''Y'''
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001413)
,p_name=>'P7003_REJECT_REASON'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_prompt=>unistr('\0633\0628\0628 \0631\0641\0636 \0627\0644\0635\0646\0641')
,p_source=>'REJECT_REASON'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
,p_begin_on_new_line=>'N'
,p_display_when=>'MOINFO_PRC.CAN_DECIDE(:P7003_REQUEST_ID) = ''Y'''
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001414)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-1414'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:7002:&SESSION.::&DEBUG.::P7002_REQUEST_ID:&P7003_REQUEST_ID.'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001415)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1415'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062D\0630\0641 \0627\0644\0635\0646\0641\061F')
,p_confirm_style=>'danger'
,p_button_condition=>':P7003_ITEM_ID is not null and MOINFO_PRC.CAN_EDIT(:P7003_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001416)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_button_name=>'SAVE'
,p_static_id=>'save-1416'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P7003_ITEM_ID is not null and (MOINFO_PRC.CAN_EDIT(:P7003_REQUEST_ID) = ''Y'' or MOINFO_PRC.CAN_DECIDE(:P7003_REQUEST_ID) = ''Y'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001417)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001400)
,p_button_name=>'CREATE'
,p_static_id=>'create-1417'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>':P7003_ITEM_ID is null and MOINFO_PRC.CAN_EDIT(:P7003_REQUEST_ID) = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001418)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001400)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Item'
,p_static_id=>'init-1418'
,p_internal_uid=>930000000000001418
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001419)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001400)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Item'
,p_static_id=>'dml-1419'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001419
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001420)
,p_branch_name=>'Go To Page 7002'
,p_branch_action=>'f?p=&APP_ID.:7002:&SESSION.::&DEBUG.::P7002_REQUEST_ID:&P7003_REQUEST_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_07004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>7004);
end;
/

prompt --application/pages/page_07004
begin
wwv_flow_imp_page.create_page(
 p_id=>7004
,p_name=>unistr('\062A\0646\0632\064A\0644 \0645\0644\0641')
,p_alias=>'PRC-DOWNLOAD'
,p_step_title=>unistr('\062A\0646\0632\064A\0644 \0645\0644\0641')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000013)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001421)
,p_plug_name=>unistr('\062A\0646\0632\064A\0644')
,p_static_id=>'r930000000000001421'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001422)
,p_name=>'P7004_ATTACHMENT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001421)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001423)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download'
,p_static_id=>'download-1423'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for a in (select ENTITY_ID from MOINFO_ATTACHMENTS',
'           where ATTACHMENT_ID = :P7004_ATTACHMENT_ID and ENTITY_NAME = ''MOINFO_PRC_REQUESTS'') loop',
'    if MOINFO_PRC.CAN_SEE(a.ENTITY_ID) = ''Y'' then',
'        MOINFO_FILES.DOWNLOAD(:P7004_ATTACHMENT_ID);',
'    end if;',
'end loop;',
unistr('raise_application_error(-20100, ''\0627\0644\0645\0644\0641 \063A\064A\0631 \0645\062A\0627\062D'');')))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001423
);
end;
/

prompt --application/pages/delete_07007
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>7007);
end;
/

prompt --application/pages/page_07007
begin
wwv_flow_imp_page.create_page(
 p_id=>7007
,p_name=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\0645\0634\062A\0631\064A\0627\062A')
,p_alias=>'PRC-STATS'
,p_step_title=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\0645\0634\062A\0631\064A\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000013)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001424)
,p_plug_name=>unistr('\0627\0644\0637\0644\0628\0627\062A \062D\0633\0628 \0627\0644\0634\0647\0631 \0648\0627\0644\062C\0647\0629 \0648\0627\0644\062D\0627\0644\0629')
,p_static_id=>'r930000000000001424'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select to_char(REQUEST_MONTH, ''YYYY-MM'') as MONTH_TXT, UNIT_AR, STATUS_AR, REQUESTS_COUNT, ITEMS_COUNT,',
'       TOTAL_AMOUNT, APPROVED_AMOUNT',
'  from MOINFO_PRC_V_STATS',
' where MOINFO_SEC.DATA_SCOPE(''PRC'') = ''ALL''',
'    or (UNIT_ID is not null and MOINFO_SEC.CAN_SEE_UNIT(''PRC'', UNIT_ID) = ''Y'')',
' order by REQUEST_MONTH desc, UNIT_AR, STATUS_AR'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001425)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001425
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001426)
,p_db_column_name=>'MONTH_TXT'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\0634\0647\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001427)
,p_db_column_name=>'UNIT_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001428)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001429)
,p_db_column_name=>'REQUESTS_COUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0637\0644\0628\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001430)
,p_db_column_name=>'ITEMS_COUNT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0623\0635\0646\0627\0641')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001431)
,p_db_column_name=>'TOTAL_AMOUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0625\062C\0645\0627\0644\064A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001432)
,p_db_column_name=>'APPROVED_AMOUNT'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0639\062A\0645\062F')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001433)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1434'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MONTH_TXT:UNIT_AR:STATUS_AR:REQUESTS_COUNT:ITEMS_COUNT:TOTAL_AMOUNT:APPROVED_AMOUNT:'
);
end;
/

prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
