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
 p_id=>wwv_flow_imp.id(930000000000001349)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-1349'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7002_REQUEST_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0637\0644\0628'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001349
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001350)
,p_plug_name=>unistr('\0637\0644\0628 \0634\0631\0627\0621')
,p_static_id=>'r930000000000001350'
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
 p_id=>wwv_flow_imp.id(930000000000001351)
,p_name=>'P7002_REQUEST_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_source=>'REQUEST_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001352)
,p_name=>'P7002_REQUEST_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001353)
,p_name=>'P7002_STATUS_TXT'
,p_item_sequence=>6
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001354)
,p_name=>'P7002_SUBJECT'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001355)
,p_name=>'P7002_REQUEST_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001356)
,p_name=>'P7002_REQUESTER_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001357)
,p_name=>'P7002_UNIT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001358)
,p_name=>'P7002_JUSTIFICATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001359)
,p_name=>'P7002_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001360)
,p_name=>'P7002_DECISION_TXT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001361)
,p_name=>'P7002_PURCHASE_TXT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001350)
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
 p_id=>wwv_flow_imp.id(930000000000001362)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load request info'
,p_static_id=>'load-request-info-1362'
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
,p_internal_uid=>930000000000001362
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001363)
,p_validation_name=>'Requester known'
,p_static_id=>'requester-known-1363'
,p_validation_sequence=>10
,p_validation=>'nvl(:P7002_REQUESTER_EMPLOYEE_ID, MOINFO_HR.MY_EMPLOYEE_ID) is not null'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\062D\062F\062F \0635\0627\062D\0628 \0627\0644\0637\0644\0628 (\062D\0633\0627\0628\0643 \063A\064A\0631 \0645\0631\062A\0628\0637 \0628\0645\0648\0638\0641)')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001364)
,p_process_sequence=>15
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Default requester'
,p_static_id=>'default-requester-1364'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7002_REQUEST_ID is null and :P7002_REQUESTER_EMPLOYEE_ID is null then',
'    :P7002_REQUESTER_EMPLOYEE_ID := MOINFO_HR.MY_EMPLOYEE_ID;',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>930000000000001364
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001365)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_button_name=>'BACK'
,p_static_id=>'back-1365'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:7001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001366)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1366'
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
 p_id=>wwv_flow_imp.id(930000000000001367)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_button_name=>'SAVE'
,p_static_id=>'save-1367'
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
 p_id=>wwv_flow_imp.id(930000000000001368)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001350)
,p_button_name=>'CREATE'
,p_static_id=>'create-1368'
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
 p_id=>wwv_flow_imp.id(930000000000001369)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001350)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Request'
,p_static_id=>'init-1369'
,p_internal_uid=>930000000000001369
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001370)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001350)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Request'
,p_static_id=>'dml-1370'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001370
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001371)
,p_plug_name=>unistr('\0627\0644\0625\062C\0631\0627\0621\0627\062A')
,p_static_id=>'r930000000000001371'
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
 p_id=>wwv_flow_imp.id(930000000000001372)
,p_name=>'P7002_ACTION_REASON'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001371)
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
 p_id=>wwv_flow_imp.id(930000000000001373)
,p_name=>'P7002_ACTION_DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001371)
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
 p_id=>wwv_flow_imp.id(930000000000001374)
,p_name=>'P7002_ACTION_PO_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001371)
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
 p_id=>wwv_flow_imp.id(930000000000001375)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001371)
,p_button_name=>'SUBMIT'
,p_static_id=>'submit-1375'
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
 p_id=>wwv_flow_imp.id(930000000000001376)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001371)
,p_button_name=>'APPROVE'
,p_static_id=>'approve-1376'
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
 p_id=>wwv_flow_imp.id(930000000000001377)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001371)
,p_button_name=>'REJECT'
,p_static_id=>'reject-1377'
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
 p_id=>wwv_flow_imp.id(930000000000001378)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001371)
,p_button_name=>'REOPEN'
,p_static_id=>'reopen-1378'
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
 p_id=>wwv_flow_imp.id(930000000000001379)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(930000000000001371)
,p_button_name=>'PURCHASE'
,p_static_id=>'purchase-1379'
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
 p_id=>wwv_flow_imp.id(930000000000001380)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(930000000000001371)
,p_button_name=>'DELIVER'
,p_static_id=>'deliver-1380'
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
 p_id=>wwv_flow_imp.id(930000000000001381)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(930000000000001371)
,p_button_name=>'CANCEL_REQ'
,p_static_id=>'cancel-req-1381'
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
 p_id=>wwv_flow_imp.id(930000000000001382)
,p_validation_name=>'Reject reason'
,p_static_id=>'reject-reason-1382'
,p_validation_sequence=>50
,p_validation=>'P7002_ACTION_REASON'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0633\0628\0628 \0627\0644\0631\0641\0636')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001377)
,p_associated_item=>wwv_flow_imp.id(930000000000001372)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001383)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action SUBMIT'
,p_static_id=>'action-submit-1383'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.SUBMIT(:P7002_REQUEST_ID);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001375)
,p_process_success_message=>unistr('\0642\064F\062F\0651\0645 \0627\0644\0637\0644\0628 \0644\0644\0627\0639\062A\0645\0627\062F')
,p_internal_uid=>930000000000001383
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001384)
,p_process_sequence=>31
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action APPROVE'
,p_static_id=>'action-approve-1384'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.APPROVE(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001376)
,p_process_success_message=>unistr('\0627\0639\062A\064F\0645\062F \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001384
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001385)
,p_process_sequence=>32
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action REJECT'
,p_static_id=>'action-reject-1385'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.REJECT(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001377)
,p_process_success_message=>unistr('\0631\064F\0641\0636 \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001385
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001386)
,p_process_sequence=>33
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action REOPEN'
,p_static_id=>'action-reopen-1386'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.REOPEN(:P7002_REQUEST_ID);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001378)
,p_process_success_message=>unistr('\0639\0627\062F \0627\0644\0637\0644\0628 \0645\0633\0648\062F\0629')
,p_internal_uid=>930000000000001386
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001387)
,p_process_sequence=>34
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action PURCHASE'
,p_static_id=>'action-purchase-1387'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.PURCHASE(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, ''DD/MM/YYYY''), :P7002_ACTION_PO_ID);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001379)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644 \0627\0644\0634\0631\0627\0621')
,p_internal_uid=>930000000000001387
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001388)
,p_process_sequence=>35
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action DELIVER'
,p_static_id=>'action-deliver-1388'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.DELIVER(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, ''DD/MM/YYYY''));',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001380)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644 \0627\0644\0627\0633\062A\0644\0627\0645')
,p_internal_uid=>930000000000001388
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001389)
,p_process_sequence=>36
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action CANCEL_REQ'
,p_static_id=>'action-cancel-req-1389'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.CANCEL(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001381)
,p_process_success_message=>unistr('\0623\064F\0644\063A\064A \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001389
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001390)
,p_plug_name=>unistr('\0627\0644\0623\0635\0646\0627\0641')
,p_static_id=>'r930000000000001390'
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
 p_id=>wwv_flow_imp.id(930000000000001391)
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
,p_internal_uid=>930000000000001391
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001392)
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
 p_id=>wwv_flow_imp.id(930000000000001393)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0635\0646\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001394)
,p_db_column_name=>'PRODUCT_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001395)
,p_db_column_name=>'BRAND_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001396)
,p_db_column_name=>'MODEL_NAME'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001397)
,p_db_column_name=>'SUPPLIER_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0648\0631\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001398)
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
 p_id=>wwv_flow_imp.id(930000000000001399)
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
 p_id=>wwv_flow_imp.id(930000000000001400)
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
 p_id=>wwv_flow_imp.id(930000000000001401)
,p_db_column_name=>'APPROVAL_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0642\0631\0627\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001402)
,p_db_column_name=>'REJECT_REASON'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0633\0628\0628 \0627\0644\0631\0641\0636')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001403)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0648\0635\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001404)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1405'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ITEM_NAME:PRODUCT_TYPE_AR:BRAND_NAME:MODEL_NAME:SUPPLIER_AR:QUANTITY:UNIT_PRICE:LINE_TOTAL:APPROVAL_AR:REJECT_REASON:DESCRIPTION:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001406)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001390)
,p_button_name=>'ADD_ITEM'
,p_static_id=>'add-item-1406'
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
 p_id=>wwv_flow_imp.id(930000000000001407)
,p_plug_name=>unistr('\0627\0644\0645\0631\0641\0642\0627\062A')
,p_static_id=>'r930000000000001407'
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
 p_id=>wwv_flow_imp.id(930000000000001408)
,p_name=>'P7002_FILES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001407)
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
 p_id=>wwv_flow_imp.id(930000000000001409)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001407)
,p_button_name=>'UPLOAD'
,p_static_id=>'upload-1409'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\0631\0641\0639')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-upload'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001410)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Store files'
,p_static_id=>'store-files-1410'
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
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001409)
,p_process_success_message=>unistr('\0631\064F\0641\0639\062A \0627\0644\0645\0644\0641\0627\062A')
,p_internal_uid=>930000000000001410
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001411)
,p_plug_name=>unistr('\0645\0644\0641\0627\062A \0627\0644\0637\0644\0628')
,p_static_id=>'r930000000000001411'
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
 p_id=>wwv_flow_imp.id(930000000000001412)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001412
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001413)
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
 p_id=>wwv_flow_imp.id(930000000000001414)
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
 p_id=>wwv_flow_imp.id(930000000000001415)
,p_db_column_name=>'FILE_SIZE_TEXT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\062C\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001416)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0631\0641\0639\0647')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001417)
,p_db_column_name=>'CREATED_AT_TXT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\0642\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001418)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1419'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FILE_LINK:FILE_SIZE_TEXT:CREATED_BY_NAME:CREATED_AT_TXT:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001420)
,p_branch_name=>'Go To Page 7001'
,p_branch_action=>'f?p=&APP_ID.:7001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000001366)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001421)
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
 p_id=>wwv_flow_imp.id(930000000000001422)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-1422'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7003_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7003_REQUEST_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0637\0644\0628'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001422
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001423)
,p_plug_name=>unistr('\0635\0646\0641')
,p_static_id=>'r930000000000001423'
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
 p_id=>wwv_flow_imp.id(930000000000001424)
,p_name=>'P7003_ITEM_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_source=>'ITEM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001425)
,p_name=>'P7003_REQUEST_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>2
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_source=>'REQUEST_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001426)
,p_name=>'P7003_ITEM_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001427)
,p_name=>'P7003_PRODUCT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001428)
,p_name=>'P7003_BRAND_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001429)
,p_name=>'P7003_MODEL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001430)
,p_name=>'P7003_SUPPLIER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001431)
,p_name=>'P7003_QUANTITY'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001432)
,p_name=>'P7003_UNIT_PRICE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001433)
,p_name=>'P7003_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001434)
,p_name=>'P7003_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001435)
,p_name=>'P7003_IS_APPROVED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001436)
,p_name=>'P7003_REJECT_REASON'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001423)
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
 p_id=>wwv_flow_imp.id(930000000000001437)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-1437'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:7002:&SESSION.::&DEBUG.::P7002_REQUEST_ID:&P7003_REQUEST_ID.'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001438)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1438'
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
 p_id=>wwv_flow_imp.id(930000000000001439)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_button_name=>'SAVE'
,p_static_id=>'save-1439'
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
 p_id=>wwv_flow_imp.id(930000000000001440)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001423)
,p_button_name=>'CREATE'
,p_static_id=>'create-1440'
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
 p_id=>wwv_flow_imp.id(930000000000001441)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001423)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Item'
,p_static_id=>'init-1441'
,p_internal_uid=>930000000000001441
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001442)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001423)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Item'
,p_static_id=>'dml-1442'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001442
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001443)
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
 p_id=>wwv_flow_imp.id(930000000000001444)
,p_plug_name=>unistr('\062A\0646\0632\064A\0644')
,p_static_id=>'r930000000000001444'
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
 p_id=>wwv_flow_imp.id(930000000000001445)
,p_name=>'P7004_ATTACHMENT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001444)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001446)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download'
,p_static_id=>'download-1446'
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
,p_internal_uid=>930000000000001446
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
 p_id=>wwv_flow_imp.id(930000000000001447)
,p_plug_name=>unistr('\0627\0644\0637\0644\0628\0627\062A \062D\0633\0628 \0627\0644\0634\0647\0631 \0648\0627\0644\062C\0647\0629 \0648\0627\0644\062D\0627\0644\0629')
,p_static_id=>'r930000000000001447'
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
 p_id=>wwv_flow_imp.id(930000000000001448)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001448
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001449)
,p_db_column_name=>'MONTH_TXT'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\0634\0647\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001450)
,p_db_column_name=>'UNIT_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001451)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001452)
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
 p_id=>wwv_flow_imp.id(930000000000001453)
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
 p_id=>wwv_flow_imp.id(930000000000001454)
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
 p_id=>wwv_flow_imp.id(930000000000001455)
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
 p_id=>wwv_flow_imp.id(930000000000001456)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1457'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MONTH_TXT:UNIT_AR:STATUS_AR:REQUESTS_COUNT:ITEMS_COUNT:TOTAL_AMOUNT:APPROVED_AMOUNT:'
);
end;
/

prompt --application/pages/delete_08001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8001);
end;
/

prompt --application/pages/page_08001
begin
wwv_flow_imp_page.create_page(
 p_id=>8001
,p_name=>unistr('\0627\0644\0645\0639\062F\0627\062A')
,p_alias=>'STD-ITEMS'
,p_step_title=>unistr('\0627\0644\0645\0639\062F\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000014)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001458)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0627\062A')
,p_static_id=>'r930000000000001458'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ITEM_ID, BARCODE, ITEM_NAME, SERIAL_NO, PRODUCT_TYPE_AR, BRAND_NAME, MODEL_NAME, STATUS_AR, LOCATION_AR,',
unistr('       BIN_AR, QTY_IN_STOCK, QTY_OUT, QTY_TOTAL, MIN_QTY, case IS_LOW when ''Y'' then ''\0646\0642\0635'' end as LOW_AR'),
'  from MOINFO_STD_V_ITEMS',
' where IS_ACTIVE = ''Y''',
' order by ITEM_NAME'))
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
 p_id=>wwv_flow_imp.id(930000000000001459)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:8002:&SESSION.::&DEBUG.:8002:P8002_ITEM_ID:#ITEM_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001459
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001460)
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
 p_id=>wwv_flow_imp.id(930000000000001461)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001462)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001463)
,p_db_column_name=>'SERIAL_NO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001464)
,p_db_column_name=>'PRODUCT_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001465)
,p_db_column_name=>'BRAND_NAME'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001466)
,p_db_column_name=>'MODEL_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001467)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001468)
,p_db_column_name=>'LOCATION_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001469)
,p_db_column_name=>'BIN_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0631\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001470)
,p_db_column_name=>'QTY_IN_STOCK'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0641\064A \0627\0644\0645\062E\0632\0646')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001471)
,p_db_column_name=>'QTY_OUT'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0645\0635\0631\0648\0641')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001472)
,p_db_column_name=>'QTY_TOTAL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0627\0644\0625\062C\0645\0627\0644\064A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001473)
,p_db_column_name=>'MIN_QTY'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('\0627\0644\062D\062F \0627\0644\0623\062F\0646\0649')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001474)
,p_db_column_name=>'LOW_AR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0646\0642\0635')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001475)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1476'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:SERIAL_NO:PRODUCT_TYPE_AR:BRAND_NAME:MODEL_NAME:STATUS_AR:LOCATION_AR:BIN_AR:QTY_IN_STOCK:QTY_OUT:QTY_TOTAL:MIN_QTY:LOW_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001477)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001458)
,p_button_name=>'CREATE'
,p_static_id=>'create-1477'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0645\0639\062F\0629 \062C\062F\064A\062F\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:8002:&SESSION.::&DEBUG.:8002::'
,p_button_condition=>'MOINFO_STD.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_08002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8002);
end;
/

prompt --application/pages/page_08002
begin
wwv_flow_imp_page.create_page(
 p_id=>8002
,p_name=>unistr('\0645\0639\062F\0629')
,p_alias=>'STD-ITEM'
,p_step_title=>unistr('\0645\0639\062F\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000014)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001478)
,p_plug_name=>unistr('\0645\0639\062F\0629')
,p_static_id=>'r930000000000001478'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_STD_ITEMS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001479)
,p_name=>'P8002_ITEM_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_source=>'ITEM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001480)
,p_name=>'P8002_ITEM_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0633\0645 \0627\0644\0645\0639\062F\0629')
,p_source=>'ITEM_NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
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
 p_id=>wwv_flow_imp.id(930000000000001481)
,p_name=>'P8002_BARCODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_source=>'BARCODE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0627\062A\0631\0643\0647 \0641\0627\0631\063A\064B\0627 \0644\064A\064F\0648\0644\064E\0651\062F \0631\0642\0645 \062A\0644\0642\0627\0626\064A\064B\0627')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001482)
,p_name=>'P8002_SERIAL_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_source=>'SERIAL_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001483)
,p_name=>'P8002_PRODUCT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
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
 p_id=>wwv_flow_imp.id(930000000000001484)
,p_name=>'P8002_BRAND_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
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
 p_id=>wwv_flow_imp.id(930000000000001485)
,p_name=>'P8002_MODEL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_source=>'MODEL_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STD_MODELS_BY_BRAND'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_lov_cascade_parent_items=>'P8002_BRAND_ID'
,p_ajax_optimize_refresh=>'Y'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001486)
,p_name=>'P8002_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\062D\0627\0644\0629')
,p_source=>'STATUS_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_STD_ITEM_STATUS'
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
 p_id=>wwv_flow_imp.id(930000000000001487)
,p_name=>'P8002_LOCATION_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\0645\0648\0642\0639')
,p_source=>'LOCATION_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_STD_LOCATION'
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
 p_id=>wwv_flow_imp.id(930000000000001488)
,p_name=>'P8002_BIN_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\0631\0641 \0623\0648 \0627\0644\062E\0627\0646\0629')
,p_source=>'BIN_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_STD_BIN'
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
 p_id=>wwv_flow_imp.id(930000000000001489)
,p_name=>'P8002_QTY_IN_STOCK'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_default=>'0'
,p_prompt=>unistr('\0627\0644\0643\0645\064A\0629 \0627\0644\0627\0641\062A\062A\0627\062D\064A\0629')
,p_source=>'QTY_IN_STOCK'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_display_when=>'P8002_ITEM_ID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0628\0639\062F \0627\0644\0625\0636\0627\0641\0629 \064A\062A\063A\064A\0631 \0627\0644\0631\0635\064A\062F \0628\0627\0644\062D\0631\0643\0627\062A \0641\0642\0637')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001490)
,p_name=>'P8002_STOCK_TXT'
,p_item_sequence=>101
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\0631\0635\064A\062F')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P8002_ITEM_ID'
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
 p_id=>wwv_flow_imp.id(930000000000001491)
,p_name=>'P8002_MIN_QTY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\062D\062F \0627\0644\0623\062F\0646\0649 \0644\0644\062A\0646\0628\064A\0647')
,p_source=>'MIN_QTY'
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
 p_id=>wwv_flow_imp.id(930000000000001492)
,p_name=>'P8002_WARRANTY_END'
,p_source_data_type=>'DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0646\0647\0627\064A\0629 \0627\0644\0636\0645\0627\0646')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'WARRANTY_END'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001493)
,p_name=>'P8002_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_prompt=>unistr('\0627\0644\0648\0635\0641')
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
 p_id=>wwv_flow_imp.id(930000000000001494)
,p_name=>'P8002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_item_default=>'Y'
,p_prompt=>unistr('\0646\0634\0637\0629')
,p_source=>'IS_ACTIVE'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001495)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load stock'
,p_static_id=>'load-stock-1495'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for x in (select QTY_IN_STOCK, QTY_OUT, QTY_TOTAL from MOINFO_STD_V_ITEMS',
'           where ITEM_ID = :P8002_ITEM_ID) loop',
unistr('    :P8002_STOCK_TXT := ''\0641\064A \0627\0644\0645\062E\0632\0646 '' || x.QTY_IN_STOCK || ''\060C \0645\0635\0631\0648\0641 '' || x.QTY_OUT || ''\060C \0627\0644\0625\062C\0645\0627\0644\064A '' || x.QTY_TOTAL;'),
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P8002_ITEM_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>930000000000001495
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001496)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_button_name=>'BACK'
,p_static_id=>'back-1496'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:8001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001497)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1497'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062D\0630\0641 \0627\0644\0645\0639\062F\0629 \0648\0643\0644 \062D\0631\0643\0627\062A\0647\0627\061F')
,p_confirm_style=>'danger'
,p_button_condition=>':P8002_ITEM_ID is not null and MOINFO_STD.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001498)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_button_name=>'SAVE'
,p_static_id=>'save-1498'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P8002_ITEM_ID is not null and MOINFO_STD.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001499)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001478)
,p_button_name=>'CREATE'
,p_static_id=>'create-1499'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>':P8002_ITEM_ID is null and MOINFO_STD.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001500)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001478)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Item'
,p_static_id=>'init-1500'
,p_internal_uid=>930000000000001500
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001501)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001478)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Item'
,p_static_id=>'dml-1501'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001501
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001502)
,p_plug_name=>unistr('\062A\0633\062C\064A\0644 \062D\0631\0643\0629')
,p_static_id=>'r930000000000001502'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>':P8002_ITEM_ID is not null and MOINFO_STD.CAN_MOVE = ''Y'''
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001503)
,p_name=>'P8002_MV_TYPE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_item_default=>'OUT'
,p_prompt=>unistr('\0646\0648\0639 \0627\0644\062D\0631\0643\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STD_MOVEMENT_TYPE'
,p_cHeight=>1
,p_field_template=>1612549789555753698
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001504)
,p_name=>'P8002_MV_QTY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_prompt=>unistr('\0627\0644\0643\0645\064A\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0641\064A \0627\0644\062A\0633\0648\064A\0629: \0627\0643\062A\0628 \0627\0644\0631\0635\064A\062F \0627\0644\062C\062F\064A\062F \0628\0639\062F \0627\0644\062C\0631\062F')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001505)
,p_name=>'P8002_MV_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_item_default=>'to_char(sysdate, ''DD/MM/YYYY'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001506)
,p_name=>'P8002_MV_EMPLOYEE_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_prompt=>unistr('\0627\0644\0645\0633\062A\0644\0645 (\0645\0648\0638\0641)')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
,p_lov_display_null=>'YES'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_inline_help_text=>unistr('\0644\0644\0635\0631\0641 \0648\0627\0644\0625\0631\062C\0627\0639')
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
 p_id=>wwv_flow_imp.id(930000000000001507)
,p_name=>'P8002_MV_PERSON'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_prompt=>unistr('\0623\0648 \0627\0633\0645 \0627\0644\0645\0633\062A\0644\0645')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0644\0645\0646 \0644\064A\0633 \0645\0648\0638\0641\064B\0627 \0641\064A \0627\0644\0646\0638\0627\0645')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001508)
,p_name=>'P8002_MV_AUTH_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_prompt=>unistr('\0628\062A\0641\0648\064A\0636 \0645\0646')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
,p_lov_display_null=>'YES'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
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
 p_id=>wwv_flow_imp.id(930000000000001509)
,p_name=>'P8002_MV_EXPECTED'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\0625\0631\062C\0627\0639 \0627\0644\0645\062A\0648\0642\0639')
,p_format_mask=>'DD/MM/YYYY'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001510)
,p_name=>'P8002_MV_REMARKS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>1000
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0625\0644\0632\0627\0645\064A\0629 \0641\064A \0627\0644\062A\0633\0648\064A\0629')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001511)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001502)
,p_button_name=>'MOVE'
,p_static_id=>'move-1511'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\062D\0631\0643\0629')
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001512)
,p_validation_name=>'Movement qty'
,p_static_id=>'movement-qty-1512'
,p_validation_sequence=>60
,p_validation=>'P8002_MV_QTY'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0627\0644\0643\0645\064A\0629')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001511)
,p_associated_item=>wwv_flow_imp.id(930000000000001504)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001513)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Record movement'
,p_static_id=>'record-movement-1513'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_item number := :P8002_ITEM_ID;',
'    l_date date := nvl(to_date(:P8002_MV_DATE, ''DD/MM/YYYY''), trunc(sysdate));',
'    l_qty  number := to_number(:P8002_MV_QTY);',
'begin',
'    case :P8002_MV_TYPE',
'        when ''IN'' then',
'            MOINFO_STD.RECEIVE(l_item, l_qty, l_date, :P8002_MV_REMARKS);',
'        when ''OUT'' then',
'            MOINFO_STD.ISSUE(l_item, l_qty, :P8002_MV_EMPLOYEE_ID, :P8002_MV_PERSON, :P8002_MV_AUTH_ID,',
'                             to_date(:P8002_MV_EXPECTED, ''DD/MM/YYYY''), l_date, :P8002_MV_REMARKS);',
'        when ''RETURN'' then',
'            MOINFO_STD.RETURN_ITEM(l_item, l_qty, :P8002_MV_EMPLOYEE_ID, :P8002_MV_PERSON, l_date, :P8002_MV_REMARKS);',
'        when ''ADJUST'' then',
'            MOINFO_STD.ADJUST(l_item, l_qty, :P8002_MV_REMARKS, l_date);',
'    end case;',
'    :P8002_MV_QTY := null;',
'    :P8002_MV_EMPLOYEE_ID := null;',
'    :P8002_MV_PERSON := null;',
'    :P8002_MV_AUTH_ID := null;',
'    :P8002_MV_EXPECTED := null;',
'    :P8002_MV_REMARKS := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001511)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644\062A \0627\0644\062D\0631\0643\0629')
,p_internal_uid=>930000000000001513
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001514)
,p_plug_name=>unistr('\0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_static_id=>'r930000000000001514'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ITEM_ID, BARCODE, ITEM_NAME, RECIPIENT_AR, EMPLOYEE_NO, PHONE_EXT, QTY_OUT, LAST_ISSUE_DATE,',
unistr('       EXPECTED_RETURN_DATE, DAYS_OUT, case IS_OVERDUE when ''Y'' then ''\0645\062A\0623\062E\0631'' end as OVERDUE_AR'),
'  from MOINFO_STD_V_OUTSTANDING',
' where ITEM_ID = :P8002_ITEM_ID',
' order by LAST_ISSUE_DATE'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P8002_ITEM_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001515)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001515
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001516)
,p_db_column_name=>'ITEM_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ITEM_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001517)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001518)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001519)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001520)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001521)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001522)
,p_db_column_name=>'QTY_OUT'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0643\0645\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001523)
,p_db_column_name=>'LAST_ISSUE_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0622\062E\0631 \0635\0631\0641')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001524)
,p_db_column_name=>'EXPECTED_RETURN_DATE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0625\0631\062C\0627\0639 \0627\0644\0645\062A\0648\0642\0639')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001525)
,p_db_column_name=>'DAYS_OUT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0645\0646\0630 (\0623\064A\0627\0645)')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001526)
,p_db_column_name=>'OVERDUE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0645\062A\0623\062E\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001527)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1528'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:RECIPIENT_AR:EMPLOYEE_NO:PHONE_EXT:QTY_OUT:LAST_ISSUE_DATE:EXPECTED_RETURN_DATE:DAYS_OUT:OVERDUE_AR:'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001529)
,p_plug_name=>unistr('\0633\062C\0644 \0627\0644\062D\0631\0643\0627\062A')
,p_static_id=>'r930000000000001529'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>40
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select MOVEMENT_ID, to_char(MOVEMENT_DATE, ''DD/MM/YYYY HH24:MI'') as MOVEMENT_DATE_TXT, MOVEMENT_TYPE_AR, QTY,',
'       BALANCE_AFTER, RECIPIENT_AR, AUTHORIZED_BY_AR, EXPECTED_RETURN_DATE, REMARKS, CREATED_BY_NAME',
'  from MOINFO_STD_V_MOVEMENTS',
' where ITEM_ID = :P8002_ITEM_ID',
' order by MOVEMENT_DATE desc, MOVEMENT_ID desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P8002_ITEM_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001530)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001530
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001531)
,p_db_column_name=>'MOVEMENT_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'MOVEMENT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001532)
,p_db_column_name=>'MOVEMENT_DATE_TXT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001533)
,p_db_column_name=>'MOVEMENT_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001534)
,p_db_column_name=>'QTY'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0643\0645\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001535)
,p_db_column_name=>'BALANCE_AFTER'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0631\0635\064A\062F \0628\0639\062F\0647\0627')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001536)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001537)
,p_db_column_name=>'AUTHORIZED_BY_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0628\062A\0641\0648\064A\0636 \0645\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001538)
,p_db_column_name=>'EXPECTED_RETURN_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0625\0631\062C\0627\0639 \0627\0644\0645\062A\0648\0642\0639')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001539)
,p_db_column_name=>'REMARKS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001540)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0628\0648\0627\0633\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001541)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1542'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MOVEMENT_DATE_TXT:MOVEMENT_TYPE_AR:QTY:BALANCE_AFTER:RECIPIENT_AR:AUTHORIZED_BY_AR:EXPECTED_RETURN_DATE:REMARKS:CREATED_BY_NAME:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001543)
,p_branch_name=>'Go To Page 8001'
,p_branch_action=>'f?p=&APP_ID.:8001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000001497)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001544)
,p_branch_name=>'Go To Page 8002'
,p_branch_action=>'f?p=&APP_ID.:8002:&SESSION.::&DEBUG.::P8002_ITEM_ID:&P8002_ITEM_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_08003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8003);
end;
/

prompt --application/pages/page_08003
begin
wwv_flow_imp_page.create_page(
 p_id=>8003
,p_name=>unistr('\0635\0631\0641 \0648\0627\0633\062A\0644\0627\0645 \0628\0627\0644\0628\0627\0631\0643\0648\062F')
,p_alias=>'STD-SCAN'
,p_step_title=>unistr('\0635\0631\0641 \0648\0627\0633\062A\0644\0627\0645 \0628\0627\0644\0628\0627\0631\0643\0648\062F')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000028)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001545)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0629')
,p_static_id=>'r930000000000001545'
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
 p_id=>wwv_flow_imp.id(930000000000001546)
,p_name=>'P8003_CODE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001545)
,p_prompt=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F \0623\0648 \0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0627\0645\0633\062D \0627\0644\0628\0627\0631\0643\0648\062F \0623\0648 \0627\0643\062A\0628\0647 \062B\0645 \0627\0636\063A\0637 Enter')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'Y',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001547)
,p_name=>'P8003_ITEM_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001545)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001548)
,p_name=>'P8003_ITEM_INFO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001545)
,p_prompt=>unistr('\0627\0644\0645\0639\062F\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P8003_CODE'
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
 p_id=>wwv_flow_imp.id(930000000000001549)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Find item'
,p_static_id=>'find-item-1549'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P8003_ITEM_ID := MOINFO_STD.ITEM_BY_CODE(:P8003_CODE);',
unistr(':P8003_ITEM_INFO := ''\0644\0627 \062A\0648\062C\062F \0645\0639\062F\0629 \0628\0647\0630\0627 \0627\0644\0631\0645\0632'';'),
'for x in (select ITEM_NAME, BARCODE, STATUS_AR, LOCATION_AR, BIN_AR, QTY_IN_STOCK, QTY_OUT',
'            from MOINFO_STD_V_ITEMS where ITEM_ID = :P8003_ITEM_ID) loop',
'    :P8003_ITEM_INFO := x.ITEM_NAME || '' ('' || x.BARCODE || '') - '' || x.STATUS_AR',
'        || nvl2(x.LOCATION_AR, '' - '' || x.LOCATION_AR, '''') || nvl2(x.BIN_AR, '' / '' || x.BIN_AR, '''')',
unistr('        || '' - \0641\064A \0627\0644\0645\062E\0632\0646 '' || x.QTY_IN_STOCK || ''\060C \0645\0635\0631\0648\0641 '' || x.QTY_OUT;'),
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P8003_CODE'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>930000000000001549
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001550)
,p_plug_name=>unistr('\062A\0633\062C\064A\0644 \062D\0631\0643\0629')
,p_static_id=>'r930000000000001550'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'MOINFO_STD.ITEM_BY_CODE(:P8003_CODE) is not null'
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001551)
,p_name=>'P8003_MV_TYPE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_item_default=>'OUT'
,p_prompt=>unistr('\0646\0648\0639 \0627\0644\062D\0631\0643\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STD_MOVEMENT_TYPE'
,p_cHeight=>1
,p_field_template=>1612549789555753698
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001552)
,p_name=>'P8003_MV_QTY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_prompt=>unistr('\0627\0644\0643\0645\064A\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0641\064A \0627\0644\062A\0633\0648\064A\0629: \0627\0643\062A\0628 \0627\0644\0631\0635\064A\062F \0627\0644\062C\062F\064A\062F \0628\0639\062F \0627\0644\062C\0631\062F')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001553)
,p_name=>'P8003_MV_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_item_default=>'to_char(sysdate, ''DD/MM/YYYY'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001554)
,p_name=>'P8003_MV_EMPLOYEE_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_prompt=>unistr('\0627\0644\0645\0633\062A\0644\0645 (\0645\0648\0638\0641)')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
,p_lov_display_null=>'YES'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_inline_help_text=>unistr('\0644\0644\0635\0631\0641 \0648\0627\0644\0625\0631\062C\0627\0639')
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
 p_id=>wwv_flow_imp.id(930000000000001555)
,p_name=>'P8003_MV_PERSON'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_prompt=>unistr('\0623\0648 \0627\0633\0645 \0627\0644\0645\0633\062A\0644\0645')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0644\0645\0646 \0644\064A\0633 \0645\0648\0638\0641\064B\0627 \0641\064A \0627\0644\0646\0638\0627\0645')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001556)
,p_name=>'P8003_MV_AUTH_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_prompt=>unistr('\0628\062A\0641\0648\064A\0636 \0645\0646')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
,p_lov_display_null=>'YES'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
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
 p_id=>wwv_flow_imp.id(930000000000001557)
,p_name=>'P8003_MV_EXPECTED'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\0625\0631\062C\0627\0639 \0627\0644\0645\062A\0648\0642\0639')
,p_format_mask=>'DD/MM/YYYY'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001558)
,p_name=>'P8003_MV_REMARKS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>1000
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0625\0644\0632\0627\0645\064A\0629 \0641\064A \0627\0644\062A\0633\0648\064A\0629')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001559)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001550)
,p_button_name=>'MOVE'
,p_static_id=>'move-1559'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\062D\0631\0643\0629')
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001560)
,p_validation_name=>'Movement qty'
,p_static_id=>'movement-qty-1560'
,p_validation_sequence=>60
,p_validation=>'P8003_MV_QTY'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0627\0644\0643\0645\064A\0629')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001559)
,p_associated_item=>wwv_flow_imp.id(930000000000001552)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001561)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Record movement'
,p_static_id=>'record-movement-1561'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_item number := MOINFO_STD.ITEM_BY_CODE(:P8003_CODE);',
'    l_date date := nvl(to_date(:P8003_MV_DATE, ''DD/MM/YYYY''), trunc(sysdate));',
'    l_qty  number := to_number(:P8003_MV_QTY);',
'begin',
'    case :P8003_MV_TYPE',
'        when ''IN'' then',
'            MOINFO_STD.RECEIVE(l_item, l_qty, l_date, :P8003_MV_REMARKS);',
'        when ''OUT'' then',
'            MOINFO_STD.ISSUE(l_item, l_qty, :P8003_MV_EMPLOYEE_ID, :P8003_MV_PERSON, :P8003_MV_AUTH_ID,',
'                             to_date(:P8003_MV_EXPECTED, ''DD/MM/YYYY''), l_date, :P8003_MV_REMARKS);',
'        when ''RETURN'' then',
'            MOINFO_STD.RETURN_ITEM(l_item, l_qty, :P8003_MV_EMPLOYEE_ID, :P8003_MV_PERSON, l_date, :P8003_MV_REMARKS);',
'        when ''ADJUST'' then',
'            MOINFO_STD.ADJUST(l_item, l_qty, :P8003_MV_REMARKS, l_date);',
'    end case;',
'    :P8003_MV_QTY := null;',
'    :P8003_MV_EMPLOYEE_ID := null;',
'    :P8003_MV_PERSON := null;',
'    :P8003_MV_AUTH_ID := null;',
'    :P8003_MV_EXPECTED := null;',
'    :P8003_MV_REMARKS := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001559)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644\062A \0627\0644\062D\0631\0643\0629')
,p_internal_uid=>930000000000001561
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001562)
,p_plug_name=>unistr('\0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_static_id=>'r930000000000001562'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ITEM_ID, BARCODE, ITEM_NAME, RECIPIENT_AR, EMPLOYEE_NO, PHONE_EXT, QTY_OUT, LAST_ISSUE_DATE,',
unistr('       EXPECTED_RETURN_DATE, DAYS_OUT, case IS_OVERDUE when ''Y'' then ''\0645\062A\0623\062E\0631'' end as OVERDUE_AR'),
'  from MOINFO_STD_V_OUTSTANDING',
' where ITEM_ID = MOINFO_STD.ITEM_BY_CODE(:P8003_CODE)',
' order by LAST_ISSUE_DATE'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P8003_CODE'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001563)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001563
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001564)
,p_db_column_name=>'ITEM_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ITEM_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001565)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001566)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001567)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001568)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001569)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001570)
,p_db_column_name=>'QTY_OUT'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0643\0645\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001571)
,p_db_column_name=>'LAST_ISSUE_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0622\062E\0631 \0635\0631\0641')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001572)
,p_db_column_name=>'EXPECTED_RETURN_DATE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0625\0631\062C\0627\0639 \0627\0644\0645\062A\0648\0642\0639')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001573)
,p_db_column_name=>'DAYS_OUT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0645\0646\0630 (\0623\064A\0627\0645)')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001574)
,p_db_column_name=>'OVERDUE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0645\062A\0623\062E\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001575)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1576'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:RECIPIENT_AR:EMPLOYEE_NO:PHONE_EXT:QTY_OUT:LAST_ISSUE_DATE:EXPECTED_RETURN_DATE:DAYS_OUT:OVERDUE_AR:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001577)
,p_branch_name=>'Go To Page 8003'
,p_branch_action=>'f?p=&APP_ID.:8003:&SESSION.::&DEBUG.::P8003_CODE:&P8003_CODE.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_08004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8004);
end;
/

prompt --application/pages/page_08004
begin
wwv_flow_imp_page.create_page(
 p_id=>8004
,p_name=>unistr('\0627\0644\0645\0639\062F\0627\062A \0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_alias=>'STD-OUTSTANDING'
,p_step_title=>unistr('\0627\0644\0645\0639\062F\0627\062A \0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000014)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001578)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0627\062A \0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_static_id=>'r930000000000001578'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ITEM_ID, BARCODE, ITEM_NAME, RECIPIENT_AR, EMPLOYEE_NO, PHONE_EXT, QTY_OUT, LAST_ISSUE_DATE,',
unistr('       EXPECTED_RETURN_DATE, DAYS_OUT, case IS_OVERDUE when ''Y'' then ''\0645\062A\0623\062E\0631'' end as OVERDUE_AR'),
'  from MOINFO_STD_V_OUTSTANDING',
' order by IS_OVERDUE desc, LAST_ISSUE_DATE'))
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
 p_id=>wwv_flow_imp.id(930000000000001579)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:8002:&SESSION.::&DEBUG.:8002:P8002_ITEM_ID:#ITEM_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001579
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001580)
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
 p_id=>wwv_flow_imp.id(930000000000001581)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001582)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001583)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001584)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001585)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001586)
,p_db_column_name=>'QTY_OUT'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0643\0645\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001587)
,p_db_column_name=>'LAST_ISSUE_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0622\062E\0631 \0635\0631\0641')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001588)
,p_db_column_name=>'EXPECTED_RETURN_DATE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0625\0631\062C\0627\0639 \0627\0644\0645\062A\0648\0642\0639')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001589)
,p_db_column_name=>'DAYS_OUT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0645\0646\0630 (\0623\064A\0627\0645)')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001590)
,p_db_column_name=>'OVERDUE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0645\062A\0623\062E\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001591)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1592'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:RECIPIENT_AR:EMPLOYEE_NO:PHONE_EXT:QTY_OUT:LAST_ISSUE_DATE:EXPECTED_RETURN_DATE:DAYS_OUT:OVERDUE_AR:'
);
end;
/

prompt --application/pages/delete_08005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8005);
end;
/

prompt --application/pages/page_08005
begin
wwv_flow_imp_page.create_page(
 p_id=>8005
,p_name=>unistr('\0633\062C\0644 \0627\0644\062D\0631\0643\0627\062A')
,p_alias=>'STD-MOVEMENTS'
,p_step_title=>unistr('\0633\062C\0644 \0627\0644\062D\0631\0643\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000014)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001593)
,p_plug_name=>unistr('\0633\062C\0644 \0627\0644\062D\0631\0643\0627\062A')
,p_static_id=>'r930000000000001593'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select MOVEMENT_ID, to_char(MOVEMENT_DATE, ''DD/MM/YYYY HH24:MI'') as MOVEMENT_DATE_TXT, MOVEMENT_TYPE_AR, QTY,',
'       BALANCE_AFTER, RECIPIENT_AR, AUTHORIZED_BY_AR, EXPECTED_RETURN_DATE, REMARKS, CREATED_BY_NAME, ITEM_ID, BARCODE, ITEM_NAME',
'  from MOINFO_STD_V_MOVEMENTS',
' order by MOVEMENT_DATE desc, MOVEMENT_ID desc'))
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
 p_id=>wwv_flow_imp.id(930000000000001594)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:8002:&SESSION.::&DEBUG.:8002:P8002_ITEM_ID:#ITEM_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001594
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001595)
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
 p_id=>wwv_flow_imp.id(930000000000001596)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001597)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001598)
,p_db_column_name=>'MOVEMENT_ID'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'MOVEMENT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001599)
,p_db_column_name=>'MOVEMENT_DATE_TXT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001600)
,p_db_column_name=>'MOVEMENT_TYPE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062D\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001601)
,p_db_column_name=>'QTY'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0643\0645\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001602)
,p_db_column_name=>'BALANCE_AFTER'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0631\0635\064A\062F \0628\0639\062F\0647\0627')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001603)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001604)
,p_db_column_name=>'AUTHORIZED_BY_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0628\062A\0641\0648\064A\0636 \0645\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001605)
,p_db_column_name=>'EXPECTED_RETURN_DATE'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0625\0631\062C\0627\0639 \0627\0644\0645\062A\0648\0642\0639')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001606)
,p_db_column_name=>'REMARKS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001607)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0628\0648\0627\0633\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001608)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1609'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:MOVEMENT_DATE_TXT:MOVEMENT_TYPE_AR:QTY:BALANCE_AFTER:RECIPIENT_AR:AUTHORIZED_BY_AR:EXPECTED_RETURN_DATE:REMARKS:CREATED_BY_NAME:'
);
end;
/

prompt --application/pages/delete_08006
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8006);
end;
/

prompt --application/pages/page_08006
begin
wwv_flow_imp_page.create_page(
 p_id=>8006
,p_name=>unistr('\0627\0644\0646\0648\0627\0642\0635')
,p_alias=>'STD-LOW'
,p_step_title=>unistr('\0627\0644\0646\0648\0627\0642\0635')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000014)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001610)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0627\062A \0627\0644\062A\064A \0628\0644\063A\062A \0627\0644\062D\062F \0627\0644\0623\062F\0646\0649')
,p_static_id=>'r930000000000001610'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ITEM_ID, BARCODE, ITEM_NAME, SERIAL_NO, PRODUCT_TYPE_AR, BRAND_NAME, MODEL_NAME, STATUS_AR, LOCATION_AR,',
unistr('       BIN_AR, QTY_IN_STOCK, QTY_OUT, QTY_TOTAL, MIN_QTY, case IS_LOW when ''Y'' then ''\0646\0642\0635'' end as LOW_AR'),
'  from MOINFO_STD_V_ITEMS',
' where IS_ACTIVE = ''Y'' and IS_LOW = ''Y''',
' order by ITEM_NAME'))
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
 p_id=>wwv_flow_imp.id(930000000000001611)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:8002:&SESSION.::&DEBUG.:8002:P8002_ITEM_ID:#ITEM_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001611
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001613)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001614)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001615)
,p_db_column_name=>'SERIAL_NO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001616)
,p_db_column_name=>'PRODUCT_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001617)
,p_db_column_name=>'BRAND_NAME'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001618)
,p_db_column_name=>'MODEL_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001619)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001620)
,p_db_column_name=>'LOCATION_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001621)
,p_db_column_name=>'BIN_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0631\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001622)
,p_db_column_name=>'QTY_IN_STOCK'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0641\064A \0627\0644\0645\062E\0632\0646')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001623)
,p_db_column_name=>'QTY_OUT'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0645\0635\0631\0648\0641')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001624)
,p_db_column_name=>'QTY_TOTAL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0627\0644\0625\062C\0645\0627\0644\064A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001625)
,p_db_column_name=>'MIN_QTY'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('\0627\0644\062D\062F \0627\0644\0623\062F\0646\0649')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001626)
,p_db_column_name=>'LOW_AR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0646\0642\0635')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001627)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1628'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:SERIAL_NO:PRODUCT_TYPE_AR:BRAND_NAME:MODEL_NAME:STATUS_AR:LOCATION_AR:BIN_AR:QTY_IN_STOCK:QTY_OUT:QTY_TOTAL:MIN_QTY:LOW_AR:'
);
end;
/

prompt --application/pages/delete_08007
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8007);
end;
/

prompt --application/pages/page_08007
begin
wwv_flow_imp_page.create_page(
 p_id=>8007
,p_name=>unistr('\0642\0648\0627\0626\0645 \0627\0644\0645\062E\0632\0646')
,p_alias=>'P8007'
,p_step_title=>unistr('\0642\0648\0627\0626\0645 \0627\0644\0645\062E\0632\0646')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000025)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001629)
,p_plug_name=>unistr('\0642\0648\0627\0626\0645 \0627\0644\0645\062E\0632\0646')
,p_static_id=>'r930000000000001629'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select l.LOOKUP_ID, t.TYPE_NAME_AR, l.NAME_AR, l.NAME_EN, l.SORT_ORDER, case l.IS_ACTIVE when ''Y'' then ''\0646\0639\0645'' else ''\0644\0627'' end as IS_ACTIVE_AR'),
'  from MOINFO_LOOKUPS l',
'  join MOINFO_LOOKUP_TYPES t on t.LOOKUP_TYPE = l.LOOKUP_TYPE',
' where l.LOOKUP_TYPE in (''STD_ITEM_STATUS'', ''STD_LOCATION'', ''STD_BIN'')',
' order by t.TYPE_NAME_AR, l.SORT_ORDER, l.NAME_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000001630)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:8008:&SESSION.::&DEBUG.:8008:P8008_LOOKUP_ID:#LOOKUP_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001630
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001631)
,p_db_column_name=>'LOOKUP_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'LOOKUP_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001632)
,p_db_column_name=>'TYPE_NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001633)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001634)
,p_db_column_name=>'NAME_EN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001635)
,p_db_column_name=>'SORT_ORDER'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062A\0631\062A\064A\0628')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001636)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0646\0634\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001637)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1638'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE_NAME_AR:NAME_AR:NAME_EN:SORT_ORDER:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001639)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001629)
,p_button_name=>'CREATE'
,p_static_id=>'create-1639'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:8008:&SESSION.::&DEBUG.:8008::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_08008
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8008);
end;
/

prompt --application/pages/page_08008
begin
wwv_flow_imp_page.create_page(
 p_id=>8008
,p_name=>unistr('\0642\064A\0645\0629')
,p_alias=>'P8008'
,p_step_title=>unistr('\0642\064A\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000025)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001640)
,p_plug_name=>unistr('\0642\064A\0645\0629')
,p_static_id=>'r930000000000001640'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_LOOKUPS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001641)
,p_name=>'P8008_LOOKUP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_source=>'LOOKUP_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001642)
,p_name=>'P8008_LOOKUP_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_prompt=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_source=>'LOOKUP_TYPE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STD_LIST_TYPES'
,p_cHeight=>1
,p_field_template=>1612549789555753698
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001643)
,p_name=>'P8008_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_prompt=>unistr('\0627\0644\0642\064A\0645\0629 \0628\0627\0644\0639\0631\0628\064A\0629')
,p_source=>'NAME_AR'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
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
 p_id=>wwv_flow_imp.id(930000000000001644)
,p_name=>'P8008_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_prompt=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_source=>'NAME_EN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001645)
,p_name=>'P8008_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_prompt=>unistr('\0627\0644\062A\0631\062A\064A\0628')
,p_source=>'SORT_ORDER'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001646)
,p_name=>'P8008_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_item_default=>'Y'
,p_prompt=>unistr('\0646\0634\0637\0629')
,p_source=>'IS_ACTIVE'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001647)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-1647'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:8007:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001648)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1648'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0627 \0627\0644\0633\062C\0644\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P8008_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001649)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_button_name=>'SAVE'
,p_static_id=>'save-1649'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P8008_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001650)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001640)
,p_button_name=>'CREATE'
,p_static_id=>'create-1650'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621')
,p_button_position=>'CREATE'
,p_button_condition=>'P8008_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001651)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001640)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0642\064A\0645\0629')
,p_static_id=>'init-1651'
,p_internal_uid=>930000000000001651
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001652)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001640)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0642\064A\0645\0629')
,p_static_id=>'dml-1652'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000001652
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001653)
,p_branch_name=>'Go To Page 8007'
,p_branch_action=>'f?p=&APP_ID.:8007:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
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
