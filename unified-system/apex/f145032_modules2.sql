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
 p_id=>wwv_flow_imp.id(930000000000001411)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-1411'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7002_REQUEST_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0637\0644\0628'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001411
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001412)
,p_plug_name=>unistr('\0637\0644\0628 \0634\0631\0627\0621')
,p_static_id=>'r930000000000001412'
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
 p_id=>wwv_flow_imp.id(930000000000001413)
,p_name=>'P7002_REQUEST_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_source=>'REQUEST_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001414)
,p_name=>'P7002_REQUEST_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001415)
,p_name=>'P7002_STATUS_TXT'
,p_item_sequence=>6
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001416)
,p_name=>'P7002_SUBJECT'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001417)
,p_name=>'P7002_REQUEST_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001418)
,p_name=>'P7002_REQUESTER_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001419)
,p_name=>'P7002_UNIT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001420)
,p_name=>'P7002_JUSTIFICATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001421)
,p_name=>'P7002_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001422)
,p_name=>'P7002_DECISION_TXT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001423)
,p_name=>'P7002_PURCHASE_TXT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001412)
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
 p_id=>wwv_flow_imp.id(930000000000001424)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load request info'
,p_static_id=>'load-request-info-1424'
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
,p_internal_uid=>930000000000001424
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001425)
,p_validation_name=>'Requester known'
,p_static_id=>'requester-known-1425'
,p_validation_sequence=>10
,p_validation=>'nvl(:P7002_REQUESTER_EMPLOYEE_ID, MOINFO_HR.MY_EMPLOYEE_ID) is not null'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\062D\062F\062F \0635\0627\062D\0628 \0627\0644\0637\0644\0628 (\062D\0633\0627\0628\0643 \063A\064A\0631 \0645\0631\062A\0628\0637 \0628\0645\0648\0638\0641)')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001426)
,p_process_sequence=>15
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Default requester'
,p_static_id=>'default-requester-1426'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7002_REQUEST_ID is null and :P7002_REQUESTER_EMPLOYEE_ID is null then',
'    :P7002_REQUESTER_EMPLOYEE_ID := MOINFO_HR.MY_EMPLOYEE_ID;',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>930000000000001426
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001427)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_button_name=>'BACK'
,p_static_id=>'back-1427'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:7001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001428)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1428'
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
 p_id=>wwv_flow_imp.id(930000000000001429)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_button_name=>'SAVE'
,p_static_id=>'save-1429'
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
 p_id=>wwv_flow_imp.id(930000000000001430)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001412)
,p_button_name=>'CREATE'
,p_static_id=>'create-1430'
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
 p_id=>wwv_flow_imp.id(930000000000001431)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001412)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Request'
,p_static_id=>'init-1431'
,p_internal_uid=>930000000000001431
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001432)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001412)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Request'
,p_static_id=>'dml-1432'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001432
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001433)
,p_plug_name=>unistr('\0627\0644\0625\062C\0631\0627\0621\0627\062A')
,p_static_id=>'r930000000000001433'
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
 p_id=>wwv_flow_imp.id(930000000000001434)
,p_name=>'P7002_ACTION_REASON'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001433)
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
 p_id=>wwv_flow_imp.id(930000000000001435)
,p_name=>'P7002_ACTION_DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001433)
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
 p_id=>wwv_flow_imp.id(930000000000001436)
,p_name=>'P7002_ACTION_PO_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001433)
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
 p_id=>wwv_flow_imp.id(930000000000001437)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001433)
,p_button_name=>'SUBMIT'
,p_static_id=>'submit-1437'
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
 p_id=>wwv_flow_imp.id(930000000000001438)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001433)
,p_button_name=>'APPROVE'
,p_static_id=>'approve-1438'
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
 p_id=>wwv_flow_imp.id(930000000000001439)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001433)
,p_button_name=>'REJECT'
,p_static_id=>'reject-1439'
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
 p_id=>wwv_flow_imp.id(930000000000001440)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001433)
,p_button_name=>'REOPEN'
,p_static_id=>'reopen-1440'
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
 p_id=>wwv_flow_imp.id(930000000000001441)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(930000000000001433)
,p_button_name=>'PURCHASE'
,p_static_id=>'purchase-1441'
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
 p_id=>wwv_flow_imp.id(930000000000001442)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(930000000000001433)
,p_button_name=>'DELIVER'
,p_static_id=>'deliver-1442'
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
 p_id=>wwv_flow_imp.id(930000000000001443)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(930000000000001433)
,p_button_name=>'CANCEL_REQ'
,p_static_id=>'cancel-req-1443'
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
 p_id=>wwv_flow_imp.id(930000000000001444)
,p_validation_name=>'Reject reason'
,p_static_id=>'reject-reason-1444'
,p_validation_sequence=>50
,p_validation=>'P7002_ACTION_REASON'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0633\0628\0628 \0627\0644\0631\0641\0636')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001439)
,p_associated_item=>wwv_flow_imp.id(930000000000001434)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001445)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action SUBMIT'
,p_static_id=>'action-submit-1445'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.SUBMIT(:P7002_REQUEST_ID);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001437)
,p_process_success_message=>unistr('\0642\064F\062F\0651\0645 \0627\0644\0637\0644\0628 \0644\0644\0627\0639\062A\0645\0627\062F')
,p_internal_uid=>930000000000001445
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001446)
,p_process_sequence=>31
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action APPROVE'
,p_static_id=>'action-approve-1446'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.APPROVE(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001438)
,p_process_success_message=>unistr('\0627\0639\062A\064F\0645\062F \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001446
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001447)
,p_process_sequence=>32
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action REJECT'
,p_static_id=>'action-reject-1447'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.REJECT(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001439)
,p_process_success_message=>unistr('\0631\064F\0641\0636 \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001447
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001448)
,p_process_sequence=>33
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action REOPEN'
,p_static_id=>'action-reopen-1448'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.REOPEN(:P7002_REQUEST_ID);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001440)
,p_process_success_message=>unistr('\0639\0627\062F \0627\0644\0637\0644\0628 \0645\0633\0648\062F\0629')
,p_internal_uid=>930000000000001448
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001449)
,p_process_sequence=>34
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action PURCHASE'
,p_static_id=>'action-purchase-1449'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.PURCHASE(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, ''DD/MM/YYYY''), :P7002_ACTION_PO_ID);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001441)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644 \0627\0644\0634\0631\0627\0621')
,p_internal_uid=>930000000000001449
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001450)
,p_process_sequence=>35
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action DELIVER'
,p_static_id=>'action-deliver-1450'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.DELIVER(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, ''DD/MM/YYYY''));',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001442)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644 \0627\0644\0627\0633\062A\0644\0627\0645')
,p_internal_uid=>930000000000001450
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001451)
,p_process_sequence=>36
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Action CANCEL_REQ'
,p_static_id=>'action-cancel-req-1451'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_PRC.CANCEL(:P7002_REQUEST_ID, :P7002_ACTION_REASON);',
':P7002_ACTION_REASON := null;',
':P7002_ACTION_DATE := null;',
':P7002_ACTION_PO_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001443)
,p_process_success_message=>unistr('\0623\064F\0644\063A\064A \0627\0644\0637\0644\0628')
,p_internal_uid=>930000000000001451
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001452)
,p_plug_name=>unistr('\0627\0644\0623\0635\0646\0627\0641')
,p_static_id=>'r930000000000001452'
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
 p_id=>wwv_flow_imp.id(930000000000001453)
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
,p_internal_uid=>930000000000001453
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001454)
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
 p_id=>wwv_flow_imp.id(930000000000001455)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0635\0646\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001456)
,p_db_column_name=>'PRODUCT_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001457)
,p_db_column_name=>'BRAND_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001458)
,p_db_column_name=>'MODEL_NAME'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001459)
,p_db_column_name=>'SUPPLIER_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0648\0631\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001460)
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
 p_id=>wwv_flow_imp.id(930000000000001461)
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
 p_id=>wwv_flow_imp.id(930000000000001462)
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
 p_id=>wwv_flow_imp.id(930000000000001463)
,p_db_column_name=>'APPROVAL_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0642\0631\0627\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001464)
,p_db_column_name=>'REJECT_REASON'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0633\0628\0628 \0627\0644\0631\0641\0636')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001465)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0648\0635\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001466)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1467'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ITEM_NAME:PRODUCT_TYPE_AR:BRAND_NAME:MODEL_NAME:SUPPLIER_AR:QUANTITY:UNIT_PRICE:LINE_TOTAL:APPROVAL_AR:REJECT_REASON:DESCRIPTION:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001468)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001452)
,p_button_name=>'ADD_ITEM'
,p_static_id=>'add-item-1468'
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
 p_id=>wwv_flow_imp.id(930000000000001469)
,p_plug_name=>unistr('\0627\0644\0645\0631\0641\0642\0627\062A')
,p_static_id=>'r930000000000001469'
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
 p_id=>wwv_flow_imp.id(930000000000001470)
,p_name=>'P7002_FILES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001469)
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
 p_id=>wwv_flow_imp.id(930000000000001471)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001469)
,p_button_name=>'UPLOAD'
,p_static_id=>'upload-1471'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\0631\0641\0639')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-upload'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001472)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Store files'
,p_static_id=>'store-files-1472'
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
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001471)
,p_process_success_message=>unistr('\0631\064F\0641\0639\062A \0627\0644\0645\0644\0641\0627\062A')
,p_internal_uid=>930000000000001472
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001473)
,p_plug_name=>unistr('\0645\0644\0641\0627\062A \0627\0644\0637\0644\0628')
,p_static_id=>'r930000000000001473'
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
 p_id=>wwv_flow_imp.id(930000000000001474)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001474
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001475)
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
 p_id=>wwv_flow_imp.id(930000000000001476)
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
 p_id=>wwv_flow_imp.id(930000000000001477)
,p_db_column_name=>'FILE_SIZE_TEXT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\062C\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001478)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0631\0641\0639\0647')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001479)
,p_db_column_name=>'CREATED_AT_TXT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\0642\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001480)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1481'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FILE_LINK:FILE_SIZE_TEXT:CREATED_BY_NAME:CREATED_AT_TXT:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001482)
,p_branch_name=>'Go To Page 7001'
,p_branch_action=>'f?p=&APP_ID.:7001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000001428)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001483)
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
 p_id=>wwv_flow_imp.id(930000000000001484)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-1484'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7003_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7003_REQUEST_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0637\0644\0628'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001484
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001485)
,p_plug_name=>unistr('\0635\0646\0641')
,p_static_id=>'r930000000000001485'
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
 p_id=>wwv_flow_imp.id(930000000000001486)
,p_name=>'P7003_ITEM_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_source=>'ITEM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001487)
,p_name=>'P7003_REQUEST_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>2
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_source=>'REQUEST_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001488)
,p_name=>'P7003_ITEM_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001489)
,p_name=>'P7003_PRODUCT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001490)
,p_name=>'P7003_BRAND_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001491)
,p_name=>'P7003_MODEL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001492)
,p_name=>'P7003_SUPPLIER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001493)
,p_name=>'P7003_QUANTITY'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001494)
,p_name=>'P7003_UNIT_PRICE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001495)
,p_name=>'P7003_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001496)
,p_name=>'P7003_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001497)
,p_name=>'P7003_IS_APPROVED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001498)
,p_name=>'P7003_REJECT_REASON'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001485)
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
 p_id=>wwv_flow_imp.id(930000000000001499)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-1499'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:7002:&SESSION.::&DEBUG.::P7002_REQUEST_ID:&P7003_REQUEST_ID.'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001500)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1500'
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
 p_id=>wwv_flow_imp.id(930000000000001501)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_button_name=>'SAVE'
,p_static_id=>'save-1501'
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
 p_id=>wwv_flow_imp.id(930000000000001502)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001485)
,p_button_name=>'CREATE'
,p_static_id=>'create-1502'
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
 p_id=>wwv_flow_imp.id(930000000000001503)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001485)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Item'
,p_static_id=>'init-1503'
,p_internal_uid=>930000000000001503
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001504)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001485)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Item'
,p_static_id=>'dml-1504'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001504
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001505)
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
 p_id=>wwv_flow_imp.id(930000000000001506)
,p_plug_name=>unistr('\062A\0646\0632\064A\0644')
,p_static_id=>'r930000000000001506'
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
 p_id=>wwv_flow_imp.id(930000000000001507)
,p_name=>'P7004_ATTACHMENT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001506)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001508)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download'
,p_static_id=>'download-1508'
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
,p_internal_uid=>930000000000001508
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
 p_id=>wwv_flow_imp.id(930000000000001509)
,p_plug_name=>unistr('\0627\0644\0637\0644\0628\0627\062A \062D\0633\0628 \0627\0644\0634\0647\0631 \0648\0627\0644\062C\0647\0629 \0648\0627\0644\062D\0627\0644\0629')
,p_static_id=>'r930000000000001509'
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
 p_id=>wwv_flow_imp.id(930000000000001510)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001510
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001511)
,p_db_column_name=>'MONTH_TXT'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\0634\0647\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001512)
,p_db_column_name=>'UNIT_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001513)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001514)
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
 p_id=>wwv_flow_imp.id(930000000000001515)
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
 p_id=>wwv_flow_imp.id(930000000000001516)
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
 p_id=>wwv_flow_imp.id(930000000000001517)
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
 p_id=>wwv_flow_imp.id(930000000000001518)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1519'
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
 p_id=>wwv_flow_imp.id(930000000000001520)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0627\062A')
,p_static_id=>'r930000000000001520'
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
 p_id=>wwv_flow_imp.id(930000000000001521)
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
,p_internal_uid=>930000000000001521
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001522)
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
 p_id=>wwv_flow_imp.id(930000000000001523)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001524)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001525)
,p_db_column_name=>'SERIAL_NO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001526)
,p_db_column_name=>'PRODUCT_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001527)
,p_db_column_name=>'BRAND_NAME'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001528)
,p_db_column_name=>'MODEL_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001529)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001530)
,p_db_column_name=>'LOCATION_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001531)
,p_db_column_name=>'BIN_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0631\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001532)
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
 p_id=>wwv_flow_imp.id(930000000000001533)
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
 p_id=>wwv_flow_imp.id(930000000000001534)
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
 p_id=>wwv_flow_imp.id(930000000000001535)
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
 p_id=>wwv_flow_imp.id(930000000000001536)
,p_db_column_name=>'LOW_AR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0646\0642\0635')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001537)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1538'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:SERIAL_NO:PRODUCT_TYPE_AR:BRAND_NAME:MODEL_NAME:STATUS_AR:LOCATION_AR:BIN_AR:QTY_IN_STOCK:QTY_OUT:QTY_TOTAL:MIN_QTY:LOW_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001539)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001520)
,p_button_name=>'CREATE'
,p_static_id=>'create-1539'
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
 p_id=>wwv_flow_imp.id(930000000000001540)
,p_plug_name=>unistr('\0645\0639\062F\0629')
,p_static_id=>'r930000000000001540'
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
 p_id=>wwv_flow_imp.id(930000000000001541)
,p_name=>'P8002_ITEM_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_source=>'ITEM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001542)
,p_name=>'P8002_ITEM_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001543)
,p_name=>'P8002_BARCODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001544)
,p_name=>'P8002_SERIAL_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001545)
,p_name=>'P8002_PRODUCT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001546)
,p_name=>'P8002_BRAND_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001547)
,p_name=>'P8002_MODEL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001548)
,p_name=>'P8002_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001549)
,p_name=>'P8002_LOCATION_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001550)
,p_name=>'P8002_BIN_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001551)
,p_name=>'P8002_QTY_IN_STOCK'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001552)
,p_name=>'P8002_STOCK_TXT'
,p_item_sequence=>101
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001553)
,p_name=>'P8002_MIN_QTY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001554)
,p_name=>'P8002_WARRANTY_END'
,p_source_data_type=>'DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001555)
,p_name=>'P8002_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001556)
,p_name=>'P8002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001540)
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
 p_id=>wwv_flow_imp.id(930000000000001557)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load stock'
,p_static_id=>'load-stock-1557'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for x in (select QTY_IN_STOCK, QTY_OUT, QTY_TOTAL from MOINFO_STD_V_ITEMS',
'           where ITEM_ID = :P8002_ITEM_ID) loop',
unistr('    :P8002_STOCK_TXT := ''\0641\064A \0627\0644\0645\062E\0632\0646 '' || x.QTY_IN_STOCK || ''\060C \0645\0635\0631\0648\0641 '' || x.QTY_OUT || ''\060C \0627\0644\0625\062C\0645\0627\0644\064A '' || x.QTY_TOTAL;'),
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P8002_ITEM_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>930000000000001557
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001558)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_button_name=>'BACK'
,p_static_id=>'back-1558'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:8001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001559)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1559'
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
 p_id=>wwv_flow_imp.id(930000000000001560)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_button_name=>'SAVE'
,p_static_id=>'save-1560'
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
 p_id=>wwv_flow_imp.id(930000000000001561)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001540)
,p_button_name=>'CREATE'
,p_static_id=>'create-1561'
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
 p_id=>wwv_flow_imp.id(930000000000001562)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001540)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Item'
,p_static_id=>'init-1562'
,p_internal_uid=>930000000000001562
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001563)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001540)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Item'
,p_static_id=>'dml-1563'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001563
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001564)
,p_plug_name=>unistr('\062A\0633\062C\064A\0644 \062D\0631\0643\0629')
,p_static_id=>'r930000000000001564'
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
 p_id=>wwv_flow_imp.id(930000000000001565)
,p_name=>'P8002_MV_TYPE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001566)
,p_name=>'P8002_MV_QTY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001567)
,p_name=>'P8002_MV_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001568)
,p_name=>'P8002_MV_EMPLOYEE_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001569)
,p_name=>'P8002_MV_PERSON'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001570)
,p_name=>'P8002_MV_AUTH_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001571)
,p_name=>'P8002_MV_EXPECTED'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001572)
,p_name=>'P8002_MV_REMARKS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001564)
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
 p_id=>wwv_flow_imp.id(930000000000001573)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001564)
,p_button_name=>'MOVE'
,p_static_id=>'move-1573'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\062D\0631\0643\0629')
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001574)
,p_validation_name=>'Movement qty'
,p_static_id=>'movement-qty-1574'
,p_validation_sequence=>60
,p_validation=>'P8002_MV_QTY'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0627\0644\0643\0645\064A\0629')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001573)
,p_associated_item=>wwv_flow_imp.id(930000000000001566)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001575)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Record movement'
,p_static_id=>'record-movement-1575'
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
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001573)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644\062A \0627\0644\062D\0631\0643\0629')
,p_internal_uid=>930000000000001575
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001576)
,p_plug_name=>unistr('\0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_static_id=>'r930000000000001576'
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
 p_id=>wwv_flow_imp.id(930000000000001577)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001577
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001578)
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
 p_id=>wwv_flow_imp.id(930000000000001579)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001580)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001581)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001582)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001583)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001584)
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
 p_id=>wwv_flow_imp.id(930000000000001585)
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
 p_id=>wwv_flow_imp.id(930000000000001586)
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
 p_id=>wwv_flow_imp.id(930000000000001587)
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
 p_id=>wwv_flow_imp.id(930000000000001588)
,p_db_column_name=>'OVERDUE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0645\062A\0623\062E\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001589)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1590'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'BARCODE:ITEM_NAME:RECIPIENT_AR:EMPLOYEE_NO:PHONE_EXT:QTY_OUT:LAST_ISSUE_DATE:EXPECTED_RETURN_DATE:DAYS_OUT:OVERDUE_AR:'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001591)
,p_plug_name=>unistr('\0633\062C\0644 \0627\0644\062D\0631\0643\0627\062A')
,p_static_id=>'r930000000000001591'
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
 p_id=>wwv_flow_imp.id(930000000000001592)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001592
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001593)
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
 p_id=>wwv_flow_imp.id(930000000000001594)
,p_db_column_name=>'MOVEMENT_DATE_TXT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001595)
,p_db_column_name=>'MOVEMENT_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001596)
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
 p_id=>wwv_flow_imp.id(930000000000001597)
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
 p_id=>wwv_flow_imp.id(930000000000001598)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001599)
,p_db_column_name=>'AUTHORIZED_BY_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0628\062A\0641\0648\064A\0636 \0645\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001600)
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
 p_id=>wwv_flow_imp.id(930000000000001601)
,p_db_column_name=>'REMARKS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001602)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0628\0648\0627\0633\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001603)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1604'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MOVEMENT_DATE_TXT:MOVEMENT_TYPE_AR:QTY:BALANCE_AFTER:RECIPIENT_AR:AUTHORIZED_BY_AR:EXPECTED_RETURN_DATE:REMARKS:CREATED_BY_NAME:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001605)
,p_branch_name=>'Go To Page 8001'
,p_branch_action=>'f?p=&APP_ID.:8001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000001559)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001606)
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
,p_required_role=>wwv_flow_imp.id(930000000000000031)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001607)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0629')
,p_static_id=>'r930000000000001607'
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
 p_id=>wwv_flow_imp.id(930000000000001608)
,p_name=>'P8003_CODE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001607)
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
 p_id=>wwv_flow_imp.id(930000000000001609)
,p_name=>'P8003_ITEM_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001607)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001610)
,p_name=>'P8003_ITEM_INFO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001607)
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
 p_id=>wwv_flow_imp.id(930000000000001611)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Find item'
,p_static_id=>'find-item-1611'
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
,p_internal_uid=>930000000000001611
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001612)
,p_plug_name=>unistr('\062A\0633\062C\064A\0644 \062D\0631\0643\0629')
,p_static_id=>'r930000000000001612'
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
 p_id=>wwv_flow_imp.id(930000000000001613)
,p_name=>'P8003_MV_TYPE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001614)
,p_name=>'P8003_MV_QTY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001615)
,p_name=>'P8003_MV_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001616)
,p_name=>'P8003_MV_EMPLOYEE_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001617)
,p_name=>'P8003_MV_PERSON'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001618)
,p_name=>'P8003_MV_AUTH_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001619)
,p_name=>'P8003_MV_EXPECTED'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001620)
,p_name=>'P8003_MV_REMARKS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001612)
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
 p_id=>wwv_flow_imp.id(930000000000001621)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001612)
,p_button_name=>'MOVE'
,p_static_id=>'move-1621'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\062D\0631\0643\0629')
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001622)
,p_validation_name=>'Movement qty'
,p_static_id=>'movement-qty-1622'
,p_validation_sequence=>60
,p_validation=>'P8003_MV_QTY'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0627\0644\0643\0645\064A\0629')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001621)
,p_associated_item=>wwv_flow_imp.id(930000000000001614)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001623)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Record movement'
,p_static_id=>'record-movement-1623'
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
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001621)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644\062A \0627\0644\062D\0631\0643\0629')
,p_internal_uid=>930000000000001623
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001624)
,p_plug_name=>unistr('\0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_static_id=>'r930000000000001624'
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
 p_id=>wwv_flow_imp.id(930000000000001625)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001625
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001626)
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
 p_id=>wwv_flow_imp.id(930000000000001627)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001628)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001629)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001630)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001631)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001632)
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
 p_id=>wwv_flow_imp.id(930000000000001633)
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
 p_id=>wwv_flow_imp.id(930000000000001634)
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
 p_id=>wwv_flow_imp.id(930000000000001635)
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
 p_id=>wwv_flow_imp.id(930000000000001636)
,p_db_column_name=>'OVERDUE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0645\062A\0623\062E\0631')
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
,p_report_columns=>'BARCODE:ITEM_NAME:RECIPIENT_AR:EMPLOYEE_NO:PHONE_EXT:QTY_OUT:LAST_ISSUE_DATE:EXPECTED_RETURN_DATE:DAYS_OUT:OVERDUE_AR:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001639)
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
 p_id=>wwv_flow_imp.id(930000000000001640)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0627\062A \0644\062F\0649 \0627\0644\0645\0633\062A\0644\0645\064A\0646')
,p_static_id=>'r930000000000001640'
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
 p_id=>wwv_flow_imp.id(930000000000001641)
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
,p_internal_uid=>930000000000001641
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001642)
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
 p_id=>wwv_flow_imp.id(930000000000001643)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001644)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001645)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001646)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001647)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001648)
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
 p_id=>wwv_flow_imp.id(930000000000001649)
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
 p_id=>wwv_flow_imp.id(930000000000001650)
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
 p_id=>wwv_flow_imp.id(930000000000001651)
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
 p_id=>wwv_flow_imp.id(930000000000001652)
,p_db_column_name=>'OVERDUE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0645\062A\0623\062E\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001653)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1654'
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
 p_id=>wwv_flow_imp.id(930000000000001655)
,p_plug_name=>unistr('\0633\062C\0644 \0627\0644\062D\0631\0643\0627\062A')
,p_static_id=>'r930000000000001655'
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
 p_id=>wwv_flow_imp.id(930000000000001656)
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
,p_internal_uid=>930000000000001656
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001657)
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
 p_id=>wwv_flow_imp.id(930000000000001658)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001659)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001660)
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
 p_id=>wwv_flow_imp.id(930000000000001661)
,p_db_column_name=>'MOVEMENT_DATE_TXT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001662)
,p_db_column_name=>'MOVEMENT_TYPE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062D\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001663)
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
 p_id=>wwv_flow_imp.id(930000000000001664)
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
 p_id=>wwv_flow_imp.id(930000000000001665)
,p_db_column_name=>'RECIPIENT_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0645\0633\062A\0644\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001666)
,p_db_column_name=>'AUTHORIZED_BY_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0628\062A\0641\0648\064A\0636 \0645\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001667)
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
 p_id=>wwv_flow_imp.id(930000000000001668)
,p_db_column_name=>'REMARKS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001669)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0628\0648\0627\0633\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001670)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1671'
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
 p_id=>wwv_flow_imp.id(930000000000001672)
,p_plug_name=>unistr('\0627\0644\0645\0639\062F\0627\062A \0627\0644\062A\064A \0628\0644\063A\062A \0627\0644\062D\062F \0627\0644\0623\062F\0646\0649')
,p_static_id=>'r930000000000001672'
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
 p_id=>wwv_flow_imp.id(930000000000001673)
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
,p_internal_uid=>930000000000001673
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001674)
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
 p_id=>wwv_flow_imp.id(930000000000001675)
,p_db_column_name=>'BARCODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0628\0627\0631\0643\0648\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001676)
,p_db_column_name=>'ITEM_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001677)
,p_db_column_name=>'SERIAL_NO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001678)
,p_db_column_name=>'PRODUCT_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001679)
,p_db_column_name=>'BRAND_NAME'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001680)
,p_db_column_name=>'MODEL_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\062F\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001681)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001682)
,p_db_column_name=>'LOCATION_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001683)
,p_db_column_name=>'BIN_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0631\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001684)
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
 p_id=>wwv_flow_imp.id(930000000000001685)
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
 p_id=>wwv_flow_imp.id(930000000000001686)
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
 p_id=>wwv_flow_imp.id(930000000000001687)
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
 p_id=>wwv_flow_imp.id(930000000000001688)
,p_db_column_name=>'LOW_AR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0646\0642\0635')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001689)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1690'
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
 p_id=>wwv_flow_imp.id(930000000000001691)
,p_plug_name=>unistr('\0642\0648\0627\0626\0645 \0627\0644\0645\062E\0632\0646')
,p_static_id=>'r930000000000001691'
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
 p_id=>wwv_flow_imp.id(930000000000001692)
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
,p_internal_uid=>930000000000001692
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001693)
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
 p_id=>wwv_flow_imp.id(930000000000001694)
,p_db_column_name=>'TYPE_NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001695)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001696)
,p_db_column_name=>'NAME_EN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001697)
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
 p_id=>wwv_flow_imp.id(930000000000001698)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0646\0634\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001699)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1700'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE_NAME_AR:NAME_AR:NAME_EN:SORT_ORDER:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001701)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001691)
,p_button_name=>'CREATE'
,p_static_id=>'create-1701'
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
 p_id=>wwv_flow_imp.id(930000000000001702)
,p_plug_name=>unistr('\0642\064A\0645\0629')
,p_static_id=>'r930000000000001702'
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
 p_id=>wwv_flow_imp.id(930000000000001703)
,p_name=>'P8008_LOOKUP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_source=>'LOOKUP_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001704)
,p_name=>'P8008_LOOKUP_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001702)
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
 p_id=>wwv_flow_imp.id(930000000000001705)
,p_name=>'P8008_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001702)
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
 p_id=>wwv_flow_imp.id(930000000000001706)
,p_name=>'P8008_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001702)
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
 p_id=>wwv_flow_imp.id(930000000000001707)
,p_name=>'P8008_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001702)
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
 p_id=>wwv_flow_imp.id(930000000000001708)
,p_name=>'P8008_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001702)
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
 p_id=>wwv_flow_imp.id(930000000000001709)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-1709'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:8007:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001710)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1710'
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
 p_id=>wwv_flow_imp.id(930000000000001711)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_button_name=>'SAVE'
,p_static_id=>'save-1711'
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
 p_id=>wwv_flow_imp.id(930000000000001712)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001702)
,p_button_name=>'CREATE'
,p_static_id=>'create-1712'
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
 p_id=>wwv_flow_imp.id(930000000000001713)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001702)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0642\064A\0645\0629')
,p_static_id=>'init-1713'
,p_internal_uid=>930000000000001713
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001714)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001702)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0642\064A\0645\0629')
,p_static_id=>'dml-1714'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000001714
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001715)
,p_branch_name=>'Go To Page 8007'
,p_branch_action=>'f?p=&APP_ID.:8007:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_09001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9001);
end;
/

prompt --application/pages/page_09001
begin
wwv_flow_imp_page.create_page(
 p_id=>9001
,p_name=>unistr('\0627\0644\062D\0633\0627\0628\0627\062A')
,p_alias=>'ADV-ACCOUNTS'
,p_step_title=>unistr('\0627\0644\062D\0633\0627\0628\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000015)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001716)
,p_plug_name=>unistr('\0627\0644\0634\0631\0643\0627\062A \0648\0627\0644\0648\0643\0627\0644\0627\062A')
,p_static_id=>'r930000000000001716'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ACCOUNT_ID, ACCOUNT_TYPE_AR, NAME, AGENCY_NAME, SECTOR_AR, INDUSTRY_AR, PHONE, EMAIL,',
'       PRIMARY_CONTACT, CONTACTS_COUNT, CLIENTS_COUNT',
'  from MOINFO_ADV_V_ACCOUNTS',
' where IS_ACTIVE = ''Y''',
' order by NAME'))
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
 p_id=>wwv_flow_imp.id(930000000000001717)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9002:&SESSION.::&DEBUG.:9002:P9002_ACCOUNT_ID:#ACCOUNT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001717
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001718)
,p_db_column_name=>'ACCOUNT_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ACCOUNT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001719)
,p_db_column_name=>'ACCOUNT_TYPE_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001720)
,p_db_column_name=>'NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001721)
,p_db_column_name=>'AGENCY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\0643\0627\0644\0629 \0627\0644\0645\0645\062B\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001722)
,p_db_column_name=>'SECTOR_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0642\0637\0627\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001723)
,p_db_column_name=>'INDUSTRY_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0646\0634\0627\0637')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001724)
,p_db_column_name=>'PHONE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001725)
,p_db_column_name=>'EMAIL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001726)
,p_db_column_name=>'PRIMARY_CONTACT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\062C\0647\0629 \0627\0644\0627\062A\0635\0627\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001727)
,p_db_column_name=>'CONTACTS_COUNT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\062C\0647\0627\062A \0627\0644\0627\062A\0635\0627\0644')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001728)
,p_db_column_name=>'CLIENTS_COUNT'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0639\0645\0644\0627\0621 \0627\0644\0648\0643\0627\0644\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001729)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1730'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ACCOUNT_TYPE_AR:NAME:AGENCY_NAME:SECTOR_AR:INDUSTRY_AR:PHONE:EMAIL:PRIMARY_CONTACT:CONTACTS_COUNT:CLIENTS_COUNT:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001731)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001716)
,p_button_name=>'CREATE'
,p_static_id=>'create-1731'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0633\0627\0628 \062C\062F\064A\062F')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:9002:&SESSION.::&DEBUG.:9002::'
,p_button_condition=>'MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_09002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9002);
end;
/

prompt --application/pages/page_09002
begin
wwv_flow_imp_page.create_page(
 p_id=>9002
,p_name=>unistr('\062D\0633\0627\0628')
,p_alias=>'ADV-ACCOUNT'
,p_step_title=>unistr('\062D\0633\0627\0628')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000015)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001732)
,p_plug_name=>unistr('\062D\0633\0627\0628')
,p_static_id=>'r930000000000001732'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_ADV_ACCOUNTS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001733)
,p_name=>'P9002_ACCOUNT_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_source=>'ACCOUNT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001734)
,p_name=>'P9002_ACCOUNT_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_default=>'COMPANY'
,p_prompt=>unistr('\0627\0644\0646\0648\0639')
,p_source=>'ACCOUNT_TYPE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ADV_ACCOUNT_TYPE'
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
 p_id=>wwv_flow_imp.id(930000000000001735)
,p_name=>'P9002_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0627\0633\0645')
,p_source=>'NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001736)
,p_name=>'P9002_AGENCY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0648\0643\0627\0644\0629 \0627\0644\0645\0645\062B\0644\0629')
,p_source=>'AGENCY_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ADV_AGENCIES'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0645\0628\0627\0634\0631 \0628\0644\0627 \0648\0643\0627\0644\0629 -')
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0644\0644\0634\0631\0643\0629 \0627\0644\0645\0639\0644\0646\0629 \0641\0642\0637: \0627\0644\0648\0643\0627\0644\0629 \0627\0644\0625\0639\0644\0627\0646\064A\0629 \0627\0644\062A\064A \062A\0645\062B\0651\0644\0647\0627')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001737)
,p_name=>'P9002_SECTOR_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0642\0637\0627\0639')
,p_source=>'SECTOR_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_ADV_SECTOR'
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
 p_id=>wwv_flow_imp.id(930000000000001738)
,p_name=>'P9002_INDUSTRY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0646\0634\0627\0637 \0627\0644\062A\062C\0627\0631\064A')
,p_source=>'INDUSTRY_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_ADV_INDUSTRY'
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
 p_id=>wwv_flow_imp.id(930000000000001739)
,p_name=>'P9002_PHONE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0647\0627\062A\0641')
,p_source=>'PHONE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000001740)
,p_name=>'P9002_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0628\0631\064A\062F \0627\0644\0625\0644\0643\062A\0631\0648\0646\064A')
,p_source=>'EMAIL'
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
 p_id=>wwv_flow_imp.id(930000000000001741)
,p_name=>'P9002_WEBSITE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0645\0648\0642\0639 \0627\0644\0625\0644\0643\062A\0631\0648\0646\064A')
,p_source=>'WEBSITE'
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
 p_id=>wwv_flow_imp.id(930000000000001742)
,p_name=>'P9002_ADDRESS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0627\0644\0639\0646\0648\0627\0646')
,p_source=>'ADDRESS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
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
 p_id=>wwv_flow_imp.id(930000000000001743)
,p_name=>'P9002_NOTES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'NOTES'
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
 p_id=>wwv_flow_imp.id(930000000000001744)
,p_name=>'P9002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_item_default=>'Y'
,p_prompt=>unistr('\0646\0634\0637')
,p_source=>'IS_ACTIVE'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001745)
,p_validation_name=>'Agency for company only'
,p_static_id=>'agency-for-company-only-1745'
,p_validation_sequence=>10
,p_validation=>':P9002_AGENCY_ID is null or :P9002_ACCOUNT_TYPE = ''COMPANY'''
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\0627\0644\0648\0643\0627\0644\0629 \0627\0644\0645\0645\062B\0644\0629 \0644\0644\0634\0631\0643\0629 \0627\0644\0645\0639\0644\0646\0629 \0641\0642\0637')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001746)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_button_name=>'BACK'
,p_static_id=>'back-1746'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:9001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001747)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1747'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062D\0630\0641 \0627\0644\062D\0633\0627\0628 \0648\062C\0647\0627\062A \0627\062A\0635\0627\0644\0647\061F')
,p_confirm_style=>'danger'
,p_button_condition=>':P9002_ACCOUNT_ID is not null and MOINFO_ADV.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001748)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_button_name=>'SAVE'
,p_static_id=>'save-1748'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P9002_ACCOUNT_ID is not null and MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001749)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001732)
,p_button_name=>'CREATE'
,p_static_id=>'create-1749'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>':P9002_ACCOUNT_ID is null and MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001750)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001732)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Account'
,p_static_id=>'init-1750'
,p_internal_uid=>930000000000001750
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001751)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001732)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Account'
,p_static_id=>'dml-1751'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001751
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001752)
,p_plug_name=>unistr('\062C\0647\0627\062A \0627\0644\0627\062A\0635\0627\0644')
,p_static_id=>'r930000000000001752'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select CONTACT_ID, NAME, JOB_TITLE, MOBILE, EMAIL,',
unistr('       case IS_PRIMARY when ''Y'' then ''\0627\0644\0623\0633\0627\0633\064A\0629'' end as PRIMARY_AR, case IS_ACTIVE when ''N'' then ''\063A\064A\0631 \0646\0634\0637\0629'' end as ACTIVE_AR'),
'  from MOINFO_ADV_CONTACTS',
' where ACCOUNT_ID = :P9002_ACCOUNT_ID',
' order by IS_PRIMARY desc, NAME'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P9002_ACCOUNT_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001753)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9003:&SESSION.::&DEBUG.:9003:P9003_CONTACT_ID:#CONTACT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001753
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001754)
,p_db_column_name=>'CONTACT_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'CONTACT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001755)
,p_db_column_name=>'NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001756)
,p_db_column_name=>'JOB_TITLE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0633\0645\0649')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001757)
,p_db_column_name=>'MOBILE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001758)
,p_db_column_name=>'EMAIL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001759)
,p_db_column_name=>'PRIMARY_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0623\0633\0627\0633\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001760)
,p_db_column_name=>'ACTIVE_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001761)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1762'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:JOB_TITLE:MOBILE:EMAIL:PRIMARY_AR:ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001763)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001752)
,p_button_name=>'ADD_CHILD'
,p_static_id=>'add-child-1763'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629 \062C\0647\0629 \0627\062A\0635\0627\0644')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:9003:&SESSION.::&DEBUG.:9003:P9003_ACCOUNT_ID:&P9002_ACCOUNT_ID.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001764)
,p_plug_name=>unistr('\0639\0645\0644\0627\0621 \0627\0644\0648\0643\0627\0644\0629')
,p_static_id=>'r930000000000001764'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ACCOUNT_ID, NAME, SECTOR_AR, INDUSTRY_AR, PRIMARY_CONTACT',
'  from MOINFO_ADV_V_ACCOUNTS',
' where AGENCY_ID = :P9002_ACCOUNT_ID',
' order by NAME'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>':P9002_ACCOUNT_ID is not null and :P9002_ACCOUNT_TYPE = ''AGENCY'''
,p_plug_display_when_cond2=>'PLSQL'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001765)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9002:&SESSION.::&DEBUG.:9002:P9002_ACCOUNT_ID:#ACCOUNT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001765
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001766)
,p_db_column_name=>'ACCOUNT_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ACCOUNT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001767)
,p_db_column_name=>'NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0634\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001768)
,p_db_column_name=>'SECTOR_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0642\0637\0627\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001769)
,p_db_column_name=>'INDUSTRY_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0646\0634\0627\0637')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001770)
,p_db_column_name=>'PRIMARY_CONTACT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\062C\0647\0629 \0627\0644\0627\062A\0635\0627\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001771)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1772'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:SECTOR_AR:INDUSTRY_AR:PRIMARY_CONTACT:'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001773)
,p_plug_name=>unistr('\0627\0644\0641\0631\0635')
,p_static_id=>'r930000000000001773'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>40
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DEAL_ID, TITLE, ADVERTISER_NAME, AGENCY_NAME, MEDIA_AR, STATUS_AR, OWNER_AR, DEAL_DATE, EXPECTED_AMOUNT,',
'       NEXT_FOLLOWUP_DATE, FOLLOWUP_STATE_AR, ACTIVITIES_COUNT',
'  from MOINFO_ADV_V_DEALS',
' where (ADVERTISER_ID = :P9002_ACCOUNT_ID or AGENCY_ID = :P9002_ACCOUNT_ID)',
'   and MOINFO_ADV.CAN_SEE(DEAL_ID) = ''Y''',
' order by IS_CLOSED, DEAL_DATE desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P9002_ACCOUNT_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001774)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9005:&SESSION.::&DEBUG.:9005:P9005_DEAL_ID:#DEAL_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001774
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001775)
,p_db_column_name=>'DEAL_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'DEAL_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001776)
,p_db_column_name=>'TITLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0641\0631\0635\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001777)
,p_db_column_name=>'ADVERTISER_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\0644\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001778)
,p_db_column_name=>'AGENCY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\0643\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001779)
,p_db_column_name=>'MEDIA_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\0633\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001780)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001781)
,p_db_column_name=>'OWNER_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0646\062F\0648\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001782)
,p_db_column_name=>'DEAL_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001783)
,p_db_column_name=>'EXPECTED_AMOUNT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629 \0627\0644\0645\062A\0648\0642\0639\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001784)
,p_db_column_name=>'NEXT_FOLLOWUP_DATE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0629 \0627\0644\0642\0627\062F\0645\0629')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001785)
,p_db_column_name=>'FOLLOWUP_STATE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\062A\0646\0628\064A\0647')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001786)
,p_db_column_name=>'ACTIVITIES_COUNT'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001787)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1788'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TITLE:ADVERTISER_NAME:AGENCY_NAME:MEDIA_AR:STATUS_AR:OWNER_AR:DEAL_DATE:EXPECTED_AMOUNT:NEXT_FOLLOWUP_DATE:FOLLOWUP_STATE_AR:ACTIVITIES_COUNT:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001789)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001773)
,p_button_name=>'ADD_DEAL'
,p_static_id=>'add-deal-1789'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0641\0631\0635\0629 \062C\062F\064A\062F\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:9005:&SESSION.::&DEBUG.:9005:P9005_ADVERTISER_ID:&P9002_ACCOUNT_ID.'
,p_button_condition=>':P9002_ACCOUNT_TYPE = ''COMPANY'' and MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001790)
,p_branch_name=>'Go To Page 9001'
,p_branch_action=>'f?p=&APP_ID.:9001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000001747)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001791)
,p_branch_name=>'Go To Page 9002'
,p_branch_action=>'f?p=&APP_ID.:9002:&SESSION.::&DEBUG.::P9002_ACCOUNT_ID:&P9002_ACCOUNT_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_09003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9003);
end;
/

prompt --application/pages/page_09003
begin
wwv_flow_imp_page.create_page(
 p_id=>9003
,p_name=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644')
,p_alias=>'P9003'
,p_step_title=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000015)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001792)
,p_plug_name=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644')
,p_static_id=>'r930000000000001792'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_ADV_CONTACTS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001793)
,p_name=>'P9003_CONTACT_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_source=>'CONTACT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001794)
,p_name=>'P9003_ACCOUNT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>6
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_source=>'ACCOUNT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001795)
,p_name=>'P9003_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_prompt=>unistr('\0627\0644\0627\0633\0645')
,p_source=>'NAME'
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
 p_id=>wwv_flow_imp.id(930000000000001796)
,p_name=>'P9003_JOB_TITLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_prompt=>unistr('\0627\0644\0645\0633\0645\0649 \0627\0644\0648\0638\064A\0641\064A')
,p_source=>'JOB_TITLE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>250
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
 p_id=>wwv_flow_imp.id(930000000000001797)
,p_name=>'P9003_MOBILE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_prompt=>unistr('\0627\0644\0647\0627\062A\0641')
,p_source=>'MOBILE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000001798)
,p_name=>'P9003_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_prompt=>unistr('\0627\0644\0628\0631\064A\062F \0627\0644\0625\0644\0643\062A\0631\0648\0646\064A')
,p_source=>'EMAIL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
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
 p_id=>wwv_flow_imp.id(930000000000001799)
,p_name=>'P9003_IS_PRIMARY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_default=>'N'
,p_prompt=>unistr('\062C\0647\0629 \0627\0644\0627\062A\0635\0627\0644 \0627\0644\0623\0633\0627\0633\064A\0629')
,p_source=>'IS_PRIMARY'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001800)
,p_name=>'P9003_NOTES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'NOTES'
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
 p_id=>wwv_flow_imp.id(930000000000001801)
,p_name=>'P9003_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001792)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001802)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-1802'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:9002:&SESSION.::&DEBUG.::P9002_ACCOUNT_ID:&P9003_ACCOUNT_ID.'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001803)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1803'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \0627\0644\062D\0630\0641\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P9003_CONTACT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001804)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_button_name=>'SAVE'
,p_static_id=>'save-1804'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P9003_CONTACT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001805)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001792)
,p_button_name=>'CREATE'
,p_static_id=>'create-1805'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>'P9003_CONTACT_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001806)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001792)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \062C\0647\0629 \0627\062A\0635\0627\0644')
,p_static_id=>'init-1806'
,p_internal_uid=>930000000000001806
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001807)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001792)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \062C\0647\0629 \0627\062A\0635\0627\0644')
,p_static_id=>'dml-1807'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000001807
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001808)
,p_branch_name=>'Go To Page 9002'
,p_branch_action=>'f?p=&APP_ID.:9002:&SESSION.::&DEBUG.::P9002_ACCOUNT_ID:&P9003_ACCOUNT_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_09004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9004);
end;
/

prompt --application/pages/page_09004
begin
wwv_flow_imp_page.create_page(
 p_id=>9004
,p_name=>unistr('\0627\0644\0641\0631\0635 \0627\0644\0625\0639\0644\0627\0646\064A\0629')
,p_alias=>'ADV-DEALS'
,p_step_title=>unistr('\0627\0644\0641\0631\0635 \0627\0644\0625\0639\0644\0627\0646\064A\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000015)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001809)
,p_plug_name=>unistr('\0627\0644\0641\0631\0635 \0627\0644\0625\0639\0644\0627\0646\064A\0629')
,p_static_id=>'r930000000000001809'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DEAL_ID, TITLE, ADVERTISER_NAME, AGENCY_NAME, MEDIA_AR, STATUS_AR, OWNER_AR, DEAL_DATE, EXPECTED_AMOUNT,',
'       NEXT_FOLLOWUP_DATE, FOLLOWUP_STATE_AR, ACTIVITIES_COUNT',
'  from MOINFO_ADV_V_DEALS',
' where IS_ACTIVE = ''Y'' and MOINFO_ADV.CAN_SEE(DEAL_ID) = ''Y''',
' order by IS_CLOSED, NEXT_FOLLOWUP_DATE nulls last, DEAL_DATE desc'))
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
 p_id=>wwv_flow_imp.id(930000000000001810)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9005:&SESSION.::&DEBUG.:9005:P9005_DEAL_ID:#DEAL_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001810
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001811)
,p_db_column_name=>'DEAL_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'DEAL_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001812)
,p_db_column_name=>'TITLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0641\0631\0635\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001813)
,p_db_column_name=>'ADVERTISER_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\0644\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001814)
,p_db_column_name=>'AGENCY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\0643\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001815)
,p_db_column_name=>'MEDIA_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\0633\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001816)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001817)
,p_db_column_name=>'OWNER_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0646\062F\0648\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001818)
,p_db_column_name=>'DEAL_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001819)
,p_db_column_name=>'EXPECTED_AMOUNT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629 \0627\0644\0645\062A\0648\0642\0639\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001820)
,p_db_column_name=>'NEXT_FOLLOWUP_DATE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0629 \0627\0644\0642\0627\062F\0645\0629')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001821)
,p_db_column_name=>'FOLLOWUP_STATE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\062A\0646\0628\064A\0647')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001822)
,p_db_column_name=>'ACTIVITIES_COUNT'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001823)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1824'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TITLE:ADVERTISER_NAME:AGENCY_NAME:MEDIA_AR:STATUS_AR:OWNER_AR:DEAL_DATE:EXPECTED_AMOUNT:NEXT_FOLLOWUP_DATE:FOLLOWUP_STATE_AR:ACTIVITIES_COUNT:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001825)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001809)
,p_button_name=>'CREATE'
,p_static_id=>'create-1825'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0641\0631\0635\0629 \062C\062F\064A\062F\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:9005:&SESSION.::&DEBUG.:9005::'
,p_button_condition=>'MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_09005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9005);
end;
/

prompt --application/pages/page_09005
begin
wwv_flow_imp_page.create_page(
 p_id=>9005
,p_name=>unistr('\0641\0631\0635\0629 \0625\0639\0644\0627\0646\064A\0629')
,p_alias=>'ADV-DEAL'
,p_step_title=>unistr('\0641\0631\0635\0629 \0625\0639\0644\0627\0646\064A\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000015)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001826)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-1826'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P9005_DEAL_ID is not null and MOINFO_ADV.CAN_SEE(:P9005_DEAL_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0647 \0627\0644\0641\0631\0635\0629'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000001826
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001827)
,p_plug_name=>unistr('\0641\0631\0635\0629 \0625\0639\0644\0627\0646\064A\0629')
,p_static_id=>'r930000000000001827'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_ADV_DEALS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001828)
,p_name=>'P9005_DEAL_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_source=>'DEAL_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001829)
,p_name=>'P9005_TITLE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0627\0644\0641\0631\0635\0629')
,p_source=>'TITLE'
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
 p_id=>wwv_flow_imp.id(930000000000001830)
,p_name=>'P9005_ADVERTISER_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0627\0644\0645\0639\0644\0646')
,p_source=>'ADVERTISER_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'ADV_COMPANIES'
,p_lov_display_null=>'YES'
,p_field_template=>1612549789555753698
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
 p_id=>wwv_flow_imp.id(930000000000001831)
,p_name=>'P9005_AGENCY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0639\0628\0631 \0627\0644\0648\0643\0627\0644\0629')
,p_source=>'AGENCY_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ADV_AGENCIES'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0645\0628\0627\0634\0631 -')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0639\0646\062F \0627\0644\0625\0636\0627\0641\0629 \062A\0624\062E\0630 \0648\0643\0627\0644\0629 \0627\0644\0645\0639\0644\0646 \0625\0646 \062A\064F\0631\0643\062A \0641\0627\0631\063A\0629')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001832)
,p_name=>'P9005_CONTACT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\062C\0647\0629 \0627\0644\0627\062A\0635\0627\0644')
,p_source=>'CONTACT_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ADV_DEAL_CONTACTS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_lov_cascade_parent_items=>'P9005_ADVERTISER_ID,P9005_AGENCY_ID'
,p_ajax_optimize_refresh=>'Y'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001833)
,p_name=>'P9005_MEDIA_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0627\0644\0648\0633\064A\0644\0629 \0627\0644\0625\0639\0644\0627\0645\064A\0629')
,p_source=>'MEDIA_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_ADV_MEDIA'
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
 p_id=>wwv_flow_imp.id(930000000000001834)
,p_name=>'P9005_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_default=>'MOINFO_HD.LOOKUP_ID(''ADV_DEAL_STATUS'', ''NEW'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\062D\0627\0644\0629')
,p_source=>'STATUS_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_ADV_DEAL_STATUS'
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
 p_id=>wwv_flow_imp.id(930000000000001835)
,p_name=>'P9005_OWNER_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_default=>'MOINFO_HR.MY_EMPLOYEE_ID'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\0645\0646\062F\0648\0628 \0627\0644\0645\0633\0624\0648\0644')
,p_source=>'OWNER_EMPLOYEE_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001836)
,p_name=>'P9005_DEAL_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_default=>'to_char(sysdate, ''DD/MM/YYYY'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DEAL_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000001837)
,p_name=>'P9005_EXPECTED_AMOUNT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0627\0644\0642\064A\0645\0629 \0627\0644\0645\062A\0648\0642\0639\0629')
,p_source=>'EXPECTED_AMOUNT'
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
 p_id=>wwv_flow_imp.id(930000000000001838)
,p_name=>'P9005_NEXT_FOLLOWUP_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0627\0644\0645\062A\0627\0628\0639\0629 \0627\0644\0642\0627\062F\0645\0629')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'NEXT_FOLLOWUP_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000001839)
,p_name=>'P9005_CLOSED_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>105
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\0625\063A\0644\0627\0642')
,p_source=>'CLOSED_DATE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P9005_CLOSED_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000001840)
,p_name=>'P9005_SALES_HISTORY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\062A\0639\0627\0645\0644')
,p_source=>'SALES_HISTORY'
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
 p_id=>wwv_flow_imp.id(930000000000001841)
,p_name=>'P9005_OBJECTIONS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0627\0644\0627\0639\062A\0631\0627\0636\0627\062A')
,p_source=>'OBJECTIONS'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cHeight=>4
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000001842)
,p_name=>'P9005_NOTES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'NOTES'
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
 p_id=>wwv_flow_imp.id(930000000000001843)
,p_name=>'P9005_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001827)
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
 p_id=>wwv_flow_imp.id(930000000000001844)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_button_name=>'BACK'
,p_static_id=>'back-1844'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:9004:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001845)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1845'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062D\0630\0641 \0627\0644\0641\0631\0635\0629 \0648\0633\062C\0644 \0645\062A\0627\0628\0639\062A\0647\0627\061F')
,p_confirm_style=>'danger'
,p_button_condition=>':P9005_DEAL_ID is not null and MOINFO_ADV.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001846)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_button_name=>'SAVE'
,p_static_id=>'save-1846'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P9005_DEAL_ID is not null and MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001847)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001827)
,p_button_name=>'CREATE'
,p_static_id=>'create-1847'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>':P9005_DEAL_ID is null and MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001848)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001827)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Deal'
,p_static_id=>'init-1848'
,p_internal_uid=>930000000000001848
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001849)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001827)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Deal'
,p_static_id=>'dml-1849'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000001849
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001850)
,p_plug_name=>unistr('\0625\0636\0627\0641\0629 \0645\062A\0627\0628\0639\0629')
,p_static_id=>'r930000000000001850'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>':P9005_DEAL_ID is not null and MOINFO_SEC.HAS_ROLE(''ADV'', ''USER'')'
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001851)
,p_name=>'P9005_ACT_NOTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001850)
,p_prompt=>unistr('\0645\0627 \062A\0645')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cHeight=>4
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001852)
,p_name=>'P9005_ACT_TYPE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001850)
,p_prompt=>unistr('\0627\0644\0646\0648\0639')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_ADV_ACTIVITY_TYPE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001853)
,p_name=>'P9005_ACT_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001850)
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
 p_id=>wwv_flow_imp.id(930000000000001854)
,p_name=>'P9005_ACT_NEXT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001850)
,p_prompt=>unistr('\0627\0644\0645\062A\0627\0628\0639\0629 \0627\0644\0642\0627\062F\0645\0629')
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
 p_id=>wwv_flow_imp.id(930000000000001855)
,p_name=>'P9005_ACT_STATUS_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001850)
,p_prompt=>unistr('\062A\063A\064A\064A\0631 \0627\0644\062D\0627\0644\0629 \0625\0644\0649')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_ADV_DEAL_STATUS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0628\062F\0648\0646 \062A\063A\064A\064A\0631 -')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001856)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001850)
,p_button_name=>'ADD_ACTIVITY'
,p_static_id=>'add-activity-1856'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629 \0627\0644\0645\062A\0627\0628\0639\0629')
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000001857)
,p_validation_name=>'Activity note'
,p_static_id=>'activity-note-1857'
,p_validation_sequence=>40
,p_validation=>'P9005_ACT_NOTE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0645\0627 \062A\0645 \0641\064A \0627\0644\0645\062A\0627\0628\0639\0629')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000001856)
,p_associated_item=>wwv_flow_imp.id(930000000000001851)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001858)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Add activity'
,p_static_id=>'add-activity-1858'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_ADV.ADD_ACTIVITY(',
'    p_deal_id   => :P9005_DEAL_ID,',
'    p_note      => :P9005_ACT_NOTE,',
'    p_type_id   => :P9005_ACT_TYPE_ID,',
'    p_date      => nvl(to_date(:P9005_ACT_DATE, ''DD/MM/YYYY''), trunc(sysdate)),',
'    p_next_date => to_date(:P9005_ACT_NEXT, ''DD/MM/YYYY''),',
'    p_status_id => :P9005_ACT_STATUS_ID);',
':P9005_ACT_NOTE := null;',
':P9005_ACT_TYPE_ID := null;',
':P9005_ACT_DATE := null;',
':P9005_ACT_NEXT := null;',
':P9005_ACT_STATUS_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001856)
,p_process_success_message=>unistr('\0623\064F\0636\064A\0641\062A \0627\0644\0645\062A\0627\0628\0639\0629')
,p_internal_uid=>930000000000001858
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001859)
,p_plug_name=>unistr('\0633\062C\0644 \0627\0644\0645\062A\0627\0628\0639\0629')
,p_static_id=>'r930000000000001859'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ACTIVITY_ID, ACTIVITY_DATE, ACTIVITY_TYPE_AR, NOTE_TEXT, NEXT_FOLLOWUP_DATE, STATUS_AR, CREATED_BY_NAME',
'  from MOINFO_ADV_V_ACTIVITIES',
' where DEAL_ID = :P9005_DEAL_ID',
' order by ACTIVITY_DATE desc, ACTIVITY_ID desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P9005_DEAL_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000001860)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001860
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001861)
,p_db_column_name=>'ACTIVITY_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ACTIVITY_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001862)
,p_db_column_name=>'ACTIVITY_DATE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001863)
,p_db_column_name=>'ACTIVITY_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001864)
,p_db_column_name=>'NOTE_TEXT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0645\0627 \062A\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001865)
,p_db_column_name=>'NEXT_FOLLOWUP_DATE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0629 \0627\0644\0642\0627\062F\0645\0629')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001866)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629 \0627\0644\062C\062F\064A\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001867)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0628\0648\0627\0633\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001868)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1869'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ACTIVITY_DATE:ACTIVITY_TYPE_AR:NOTE_TEXT:NEXT_FOLLOWUP_DATE:STATUS_AR:CREATED_BY_NAME:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001870)
,p_branch_name=>'Go To Page 9004'
,p_branch_action=>'f?p=&APP_ID.:9004:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000001845)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001871)
,p_branch_name=>'Go To Page 9005'
,p_branch_action=>'f?p=&APP_ID.:9005:&SESSION.::&DEBUG.::P9005_DEAL_ID:&P9005_DEAL_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_09006
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9006);
end;
/

prompt --application/pages/page_09006
begin
wwv_flow_imp_page.create_page(
 p_id=>9006
,p_name=>unistr('\0627\0644\0645\062A\0627\0628\0639\0627\062A \0627\0644\0645\0633\062A\062D\0642\0629')
,p_alias=>'ADV-DUE'
,p_step_title=>unistr('\0627\0644\0645\062A\0627\0628\0639\0627\062A \0627\0644\0645\0633\062A\062D\0642\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000015)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001872)
,p_plug_name=>unistr('\0627\0644\0645\062A\0627\0628\0639\0627\062A \0627\0644\0645\0633\062A\062D\0642\0629 \062E\0644\0627\0644 \0623\0633\0628\0648\0639 \0648\0627\0644\0645\062A\0623\062E\0631\0629')
,p_static_id=>'r930000000000001872'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DEAL_ID, TITLE, ADVERTISER_NAME, AGENCY_NAME, MEDIA_AR, STATUS_AR, OWNER_AR, DEAL_DATE, EXPECTED_AMOUNT,',
'       NEXT_FOLLOWUP_DATE, FOLLOWUP_STATE_AR, ACTIVITIES_COUNT',
'  from MOINFO_ADV_V_DEALS',
' where IS_ACTIVE = ''Y'' and IS_CLOSED = ''N''',
'   and NEXT_FOLLOWUP_DATE <= trunc(sysdate) + 7',
'   and MOINFO_ADV.CAN_SEE(DEAL_ID) = ''Y''',
' order by NEXT_FOLLOWUP_DATE'))
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
 p_id=>wwv_flow_imp.id(930000000000001873)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9005:&SESSION.::&DEBUG.:9005:P9005_DEAL_ID:#DEAL_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001873
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001874)
,p_db_column_name=>'DEAL_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'DEAL_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001875)
,p_db_column_name=>'TITLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0641\0631\0635\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001876)
,p_db_column_name=>'ADVERTISER_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0639\0644\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001877)
,p_db_column_name=>'AGENCY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\0643\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001878)
,p_db_column_name=>'MEDIA_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\0633\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001879)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001880)
,p_db_column_name=>'OWNER_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0646\062F\0648\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001881)
,p_db_column_name=>'DEAL_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001882)
,p_db_column_name=>'EXPECTED_AMOUNT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629 \0627\0644\0645\062A\0648\0642\0639\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001883)
,p_db_column_name=>'NEXT_FOLLOWUP_DATE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0629 \0627\0644\0642\0627\062F\0645\0629')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001884)
,p_db_column_name=>'FOLLOWUP_STATE_AR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\062A\0646\0628\064A\0647')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001885)
,p_db_column_name=>'ACTIVITIES_COUNT'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001886)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1887'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TITLE:ADVERTISER_NAME:AGENCY_NAME:MEDIA_AR:STATUS_AR:OWNER_AR:DEAL_DATE:EXPECTED_AMOUNT:NEXT_FOLLOWUP_DATE:FOLLOWUP_STATE_AR:ACTIVITIES_COUNT:'
);
end;
/

prompt --application/pages/delete_09007
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9007);
end;
/

prompt --application/pages/page_09007
begin
wwv_flow_imp_page.create_page(
 p_id=>9007
,p_name=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\0642\0633\0645 \0627\0644\062A\062C\0627\0631\064A')
,p_alias=>'ADV-STATS'
,p_step_title=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\0642\0633\0645 \0627\0644\062A\062C\0627\0631\064A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000015)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001888)
,p_plug_name=>unistr('\0627\0644\0641\0631\0635 \062D\0633\0628 \0627\0644\0634\0647\0631 \0648\0627\0644\0648\0633\064A\0644\0629 \0648\0627\0644\062D\0627\0644\0629 \0648\0627\0644\0645\0646\062F\0648\0628')
,p_static_id=>'r930000000000001888'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select to_char(DEAL_MONTH, ''YYYY-MM'') as MONTH_TXT, MEDIA_AR, STATUS_AR, OWNER_AR, DEALS_COUNT, EXPECTED_AMOUNT',
'  from MOINFO_ADV_V_STATS',
' where MOINFO_SEC.DATA_SCOPE(''ADV'') = ''ALL''',
'    or OWNER_EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID',
'    or (MOINFO_SEC.DATA_SCOPE(''ADV'') = ''UNIT'' and OWNER_UNIT_ID is not null',
'        and MOINFO_SEC.CAN_SEE_UNIT(''ADV'', OWNER_UNIT_ID) = ''Y'')',
' order by DEAL_MONTH desc, MEDIA_AR, STATUS_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000001889)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000001889
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001890)
,p_db_column_name=>'MONTH_TXT'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\0634\0647\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001891)
,p_db_column_name=>'MEDIA_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0648\0633\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001892)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001893)
,p_db_column_name=>'OWNER_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0646\062F\0648\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001894)
,p_db_column_name=>'DEALS_COUNT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0641\0631\0635')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001895)
,p_db_column_name=>'EXPECTED_AMOUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629 \0627\0644\0645\062A\0648\0642\0639\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001896)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1897'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MONTH_TXT:MEDIA_AR:STATUS_AR:OWNER_AR:DEALS_COUNT:EXPECTED_AMOUNT:'
);
end;
/

prompt --application/pages/delete_09008
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9008);
end;
/

prompt --application/pages/page_09008
begin
wwv_flow_imp_page.create_page(
 p_id=>9008
,p_name=>unistr('\0642\0648\0627\0626\0645 \0627\0644\0642\0633\0645 \0627\0644\062A\062C\0627\0631\064A')
,p_alias=>'P9008'
,p_step_title=>unistr('\0642\0648\0627\0626\0645 \0627\0644\0642\0633\0645 \0627\0644\062A\062C\0627\0631\064A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000026)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001898)
,p_plug_name=>unistr('\0642\0648\0627\0626\0645 \0627\0644\0642\0633\0645 \0627\0644\062A\062C\0627\0631\064A')
,p_static_id=>'r930000000000001898'
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
' where l.LOOKUP_TYPE in (''ADV_SECTOR'', ''ADV_INDUSTRY'', ''ADV_MEDIA'', ''ADV_DEAL_STATUS'', ''ADV_ACTIVITY_TYPE'')',
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
 p_id=>wwv_flow_imp.id(930000000000001899)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:9009:&SESSION.::&DEBUG.:9009:P9009_LOOKUP_ID:#LOOKUP_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001899
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001900)
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
 p_id=>wwv_flow_imp.id(930000000000001901)
,p_db_column_name=>'TYPE_NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001902)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001903)
,p_db_column_name=>'NAME_EN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001904)
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
 p_id=>wwv_flow_imp.id(930000000000001905)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0646\0634\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001906)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1907'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE_NAME_AR:NAME_AR:NAME_EN:SORT_ORDER:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001908)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001898)
,p_button_name=>'CREATE'
,p_static_id=>'create-1908'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:9009:&SESSION.::&DEBUG.:9009::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_09009
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9009);
end;
/

prompt --application/pages/page_09009
begin
wwv_flow_imp_page.create_page(
 p_id=>9009
,p_name=>unistr('\0642\064A\0645\0629')
,p_alias=>'P9009'
,p_step_title=>unistr('\0642\064A\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000026)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001909)
,p_plug_name=>unistr('\0642\064A\0645\0629')
,p_static_id=>'r930000000000001909'
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
 p_id=>wwv_flow_imp.id(930000000000001910)
,p_name=>'P9009_LOOKUP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_source=>'LOOKUP_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001911)
,p_name=>'P9009_LOOKUP_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_prompt=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_source=>'LOOKUP_TYPE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ADV_LIST_TYPES'
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
 p_id=>wwv_flow_imp.id(930000000000001912)
,p_name=>'P9009_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001909)
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
 p_id=>wwv_flow_imp.id(930000000000001913)
,p_name=>'P9009_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001909)
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
 p_id=>wwv_flow_imp.id(930000000000001914)
,p_name=>'P9009_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001909)
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
 p_id=>wwv_flow_imp.id(930000000000001915)
,p_name=>'P9009_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001909)
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
 p_id=>wwv_flow_imp.id(930000000000001916)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-1916'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:9008:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001917)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_button_name=>'DELETE'
,p_static_id=>'delete-1917'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0627 \0627\0644\0633\062C\0644\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P9009_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001918)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_button_name=>'SAVE'
,p_static_id=>'save-1918'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P9009_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001919)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001909)
,p_button_name=>'CREATE'
,p_static_id=>'create-1919'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621')
,p_button_position=>'CREATE'
,p_button_condition=>'P9009_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001920)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001909)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0642\064A\0645\0629')
,p_static_id=>'init-1920'
,p_internal_uid=>930000000000001920
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001921)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001909)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0642\064A\0645\0629')
,p_static_id=>'dml-1921'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000001921
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001922)
,p_branch_name=>'Go To Page 9008'
,p_branch_action=>'f?p=&APP_ID.:9008:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_10001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10001);
end;
/

prompt --application/pages/page_10001
begin
wwv_flow_imp_page.create_page(
 p_id=>10001
,p_name=>unistr('\0627\0644\0623\0634\062E\0627\0635')
,p_alias=>'OMI-PERSONS'
,p_step_title=>unistr('\0627\0644\0623\0634\062E\0627\0635')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000016)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001923)
,p_plug_name=>unistr('\0627\0644\0623\0634\062E\0627\0635')
,p_static_id=>'r930000000000001923'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PERSON_ID, EMP_NO, WORK_ID, NAME_AR, NAME_EN, CIVIL_NO, SITE_AR, REGISTERED_AR,',
'       to_char(REGISTERED_AT, ''DD/MM/YYYY HH24:MI'') as REGISTERED_AT_TXT, REG_POINT_AR, TERMINAL_NAME, UPLOADED_AR, REMARKS',
'  from MOINFO_OMI_V_PERSONS',
' where IS_ACTIVE = ''Y''',
' order by NAME_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000001924)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10002:&SESSION.::&DEBUG.:10002:P10002_PERSON_ID:#PERSON_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001924
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001925)
,p_db_column_name=>'PERSON_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'PERSON_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001926)
,p_db_column_name=>'EMP_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001927)
,p_db_column_name=>'WORK_ID'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0631\0642\0645 \0627\0644\0639\0645\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001928)
,p_db_column_name=>'NAME_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001929)
,p_db_column_name=>'NAME_EN'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0627\0633\0645 \0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001930)
,p_db_column_name=>'CIVIL_NO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\062F\0646\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001931)
,p_db_column_name=>'SITE_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001932)
,p_db_column_name=>'REGISTERED_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0628\0635\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001933)
,p_db_column_name=>'REGISTERED_AT_TXT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0648\0642\062A \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001934)
,p_db_column_name=>'REG_POINT_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001935)
,p_db_column_name=>'TERMINAL_NAME'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\0632')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001936)
,p_db_column_name=>'UPLOADED_AR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Alpeta'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001937)
,p_db_column_name=>'REMARKS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001938)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1939'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMP_NO:WORK_ID:NAME_AR:NAME_EN:CIVIL_NO:SITE_AR:REGISTERED_AR:REGISTERED_AT_TXT:REG_POINT_AR:TERMINAL_NAME:UPLOADED_AR:REMARKS:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001940)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001923)
,p_button_name=>'CREATE'
,p_static_id=>'create-1940'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0634\062E\0635 \062C\062F\064A\062F')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:10002:&SESSION.::&DEBUG.:10002::'
,p_button_condition=>'MOINFO_OMI.CAN_REGISTER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_10003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10003);
end;
/

prompt --application/pages/page_10003
begin
wwv_flow_imp_page.create_page(
 p_id=>10003
,p_name=>unistr('\062A\0633\062C\064A\0644 \0627\0644\064A\0648\0645')
,p_alias=>'OMI-TODAY'
,p_step_title=>unistr('\062A\0633\062C\064A\0644 \0627\0644\064A\0648\0645')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000016)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001941)
,p_plug_name=>unistr('\062A\0633\062C\064A\0644 \0627\0644\064A\0648\0645')
,p_static_id=>'r930000000000001941'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PERSON_ID, EMP_NO, WORK_ID, NAME_AR, NAME_EN, CIVIL_NO, SITE_AR, REGISTERED_AR,',
'       to_char(REGISTERED_AT, ''DD/MM/YYYY HH24:MI'') as REGISTERED_AT_TXT, REG_POINT_AR, TERMINAL_NAME, UPLOADED_AR, REMARKS',
'  from MOINFO_OMI_V_PERSONS',
' where IS_ACTIVE = ''Y''',
'   and trunc(REGISTERED_AT) = trunc(sysdate)',
' order by REGISTERED_AT desc'))
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
 p_id=>wwv_flow_imp.id(930000000000001942)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10002:&SESSION.::&DEBUG.:10002:P10002_PERSON_ID:#PERSON_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001942
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001943)
,p_db_column_name=>'PERSON_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'PERSON_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001944)
,p_db_column_name=>'EMP_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001945)
,p_db_column_name=>'WORK_ID'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0631\0642\0645 \0627\0644\0639\0645\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001946)
,p_db_column_name=>'NAME_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001947)
,p_db_column_name=>'NAME_EN'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0627\0633\0645 \0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001948)
,p_db_column_name=>'CIVIL_NO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\062F\0646\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001949)
,p_db_column_name=>'SITE_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001950)
,p_db_column_name=>'REGISTERED_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0628\0635\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001951)
,p_db_column_name=>'REGISTERED_AT_TXT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0648\0642\062A \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001952)
,p_db_column_name=>'REG_POINT_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001953)
,p_db_column_name=>'TERMINAL_NAME'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\0632')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001954)
,p_db_column_name=>'UPLOADED_AR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Alpeta'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001955)
,p_db_column_name=>'REMARKS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001956)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1957'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMP_NO:WORK_ID:NAME_AR:NAME_EN:CIVIL_NO:SITE_AR:REGISTERED_AR:REGISTERED_AT_TXT:REG_POINT_AR:TERMINAL_NAME:UPLOADED_AR:REMARKS:'
);
end;
/

prompt --application/pages/delete_10005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10005);
end;
/

prompt --application/pages/page_10005
begin
wwv_flow_imp_page.create_page(
 p_id=>10005
,p_name=>unistr('\0644\0645 \062A\064F\0633\062C\064E\0651\0644 \0628\0635\0645\062A\0647\0645')
,p_alias=>'OMI-NOT-REGISTERED'
,p_step_title=>unistr('\0644\0645 \062A\064F\0633\062C\064E\0651\0644 \0628\0635\0645\062A\0647\0645')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000016)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001958)
,p_plug_name=>unistr('\0644\0645 \062A\064F\0633\062C\064E\0651\0644 \0628\0635\0645\062A\0647\0645')
,p_static_id=>'r930000000000001958'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PERSON_ID, EMP_NO, WORK_ID, NAME_AR, NAME_EN, CIVIL_NO, SITE_AR, REGISTERED_AR,',
'       to_char(REGISTERED_AT, ''DD/MM/YYYY HH24:MI'') as REGISTERED_AT_TXT, REG_POINT_AR, TERMINAL_NAME, UPLOADED_AR, REMARKS',
'  from MOINFO_OMI_V_PERSONS',
' where IS_ACTIVE = ''Y''',
'   and IS_REGISTERED = ''N''',
' order by NAME_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000001959)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10002:&SESSION.::&DEBUG.:10002:P10002_PERSON_ID:#PERSON_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001959
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001960)
,p_db_column_name=>'PERSON_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'PERSON_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001961)
,p_db_column_name=>'EMP_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001962)
,p_db_column_name=>'WORK_ID'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0631\0642\0645 \0627\0644\0639\0645\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001963)
,p_db_column_name=>'NAME_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001964)
,p_db_column_name=>'NAME_EN'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0627\0633\0645 \0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001965)
,p_db_column_name=>'CIVIL_NO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\062F\0646\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001966)
,p_db_column_name=>'SITE_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001967)
,p_db_column_name=>'REGISTERED_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0628\0635\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001968)
,p_db_column_name=>'REGISTERED_AT_TXT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0648\0642\062A \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001969)
,p_db_column_name=>'REG_POINT_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001970)
,p_db_column_name=>'TERMINAL_NAME'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\0632')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001971)
,p_db_column_name=>'UPLOADED_AR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Alpeta'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001972)
,p_db_column_name=>'REMARKS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001973)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1974'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMP_NO:WORK_ID:NAME_AR:NAME_EN:CIVIL_NO:SITE_AR:REGISTERED_AR:REGISTERED_AT_TXT:REG_POINT_AR:TERMINAL_NAME:UPLOADED_AR:REMARKS:'
);
end;
/

prompt --application/pages/delete_10004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10004);
end;
/

prompt --application/pages/page_10004
begin
wwv_flow_imp_page.create_page(
 p_id=>10004
,p_name=>unistr('\0645\0633\062C\0651\0644\0648\0646 \0644\0645 \064A\064F\0631\0641\0639\0648\0627 \0625\0644\0649 Alpeta')
,p_alias=>'OMI-NOT-UPLOADED'
,p_step_title=>unistr('\0645\0633\062C\0651\0644\0648\0646 \0644\0645 \064A\064F\0631\0641\0639\0648\0627 \0625\0644\0649 Alpeta')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000016)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001975)
,p_plug_name=>unistr('\0645\0633\062C\0651\0644\0648\0646 \0644\0645 \064A\064F\0631\0641\0639\0648\0627 \0625\0644\0649 Alpeta')
,p_static_id=>'r930000000000001975'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PERSON_ID, EMP_NO, WORK_ID, NAME_AR, NAME_EN, CIVIL_NO, SITE_AR, REGISTERED_AR,',
'       to_char(REGISTERED_AT, ''DD/MM/YYYY HH24:MI'') as REGISTERED_AT_TXT, REG_POINT_AR, TERMINAL_NAME, UPLOADED_AR, REMARKS',
'  from MOINFO_OMI_V_PERSONS',
' where IS_ACTIVE = ''Y''',
'   and IS_REGISTERED = ''Y'' and IS_UPLOADED = ''N''',
'   and (:P10004_SITE_ID is null or SITE_ID = :P10004_SITE_ID)',
' order by REGISTERED_AT'))
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
 p_id=>wwv_flow_imp.id(930000000000001976)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10002:&SESSION.::&DEBUG.:10002:P10002_PERSON_ID:#PERSON_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000001976
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001977)
,p_db_column_name=>'PERSON_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'PERSON_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001978)
,p_db_column_name=>'EMP_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001979)
,p_db_column_name=>'WORK_ID'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0631\0642\0645 \0627\0644\0639\0645\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001980)
,p_db_column_name=>'NAME_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001981)
,p_db_column_name=>'NAME_EN'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0627\0633\0645 \0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001982)
,p_db_column_name=>'CIVIL_NO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\062F\0646\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001983)
,p_db_column_name=>'SITE_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001984)
,p_db_column_name=>'REGISTERED_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0628\0635\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001985)
,p_db_column_name=>'REGISTERED_AT_TXT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0648\0642\062A \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001986)
,p_db_column_name=>'REG_POINT_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001987)
,p_db_column_name=>'TERMINAL_NAME'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\0632')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001988)
,p_db_column_name=>'UPLOADED_AR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Alpeta'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000001989)
,p_db_column_name=>'REMARKS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000001990)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1991'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMP_NO:WORK_ID:NAME_AR:NAME_EN:CIVIL_NO:SITE_AR:REGISTERED_AR:REGISTERED_AT_TXT:REG_POINT_AR:TERMINAL_NAME:UPLOADED_AR:REMARKS:'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001992)
,p_plug_name=>unistr('\062A\0623\0643\064A\062F \0627\0644\0631\0641\0639')
,p_static_id=>'r930000000000001992'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>5
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'MOINFO_OMI.IS_MANAGER = ''Y'''
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001993)
,p_name=>'P10004_SITE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001992)
,p_prompt=>unistr('\0627\0644\0645\0648\0642\0639')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_OMI_SITE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0643\0644 \0627\0644\0645\0648\0627\0642\0639 -')
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000001994)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001992)
,p_button_name=>'UPLOAD_ALL'
,p_static_id=>'upload-all-1994'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0623\0643\064A\062F \0631\0641\0639 \0643\0644 \0627\0644\0645\0633\062C\0651\0644\064A\0646 \0625\0644\0649 Alpeta')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062A\0623\0643\064A\062F \0623\0646 \0628\0635\0645\0627\062A \0643\0644 \0627\0644\0645\0639\0631\0648\0636\064A\0646 \0631\064F\0641\0639\062A \0625\0644\0649 Alpeta\061F')
,p_confirm_style=>'danger'
,p_icon_css_classes=>'fa-cloud-upload'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000001995)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload all'
,p_static_id=>'upload-all-1995'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_n number;',
'begin',
'    l_n := MOINFO_OMI.MARK_ALL_UPLOADED(:P10004_SITE_ID);',
unistr('    apex_application.g_print_success_message := ''\062A\0645 \062A\0623\0643\064A\062F \0631\0641\0639 '' || l_n || '' \0634\062E\0635'';'),
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000001994)
,p_internal_uid=>930000000000001995
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000001996)
,p_branch_name=>'Go To Page 10004'
,p_branch_action=>'f?p=&APP_ID.:10004:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_10002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10002);
end;
/

prompt --application/pages/page_10002
begin
wwv_flow_imp_page.create_page(
 p_id=>10002
,p_name=>unistr('\0634\062E\0635')
,p_alias=>'OMI-PERSON'
,p_step_title=>unistr('\0634\062E\0635')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000016)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000001997)
,p_plug_name=>unistr('\0634\062E\0635')
,p_static_id=>'r930000000000001997'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_OMI_PERSONS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001998)
,p_name=>'P10002_PERSON_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_source=>'PERSON_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000001999)
,p_name=>'P10002_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0645\0648\0638\0641 \0641\064A \0627\0644\0646\0638\0627\0645')
,p_source=>'EMPLOYEE_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
,p_lov_display_null=>'YES'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0627\062E\062A\064A\0627\0631\064A. \0625\0646 \0627\062E\062A\0631\062A \0645\0648\0638\0641\064B\0627 \0648\062A\0631\0643\062A \0627\0644\0627\0633\0645 \0648\0627\0644\0631\0642\0645 \0641\0627\0631\063A\064A\0646 \0623\064F\062E\0630\0627 \0645\0646\0647')
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
 p_id=>wwv_flow_imp.id(930000000000002000)
,p_name=>'P10002_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0627\0644\0627\0633\0645')
,p_source=>'NAME_AR'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
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
 p_id=>wwv_flow_imp.id(930000000000002001)
,p_name=>'P10002_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0627\0644\0627\0633\0645 \0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_source=>'NAME_EN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
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
 p_id=>wwv_flow_imp.id(930000000000002002)
,p_name=>'P10002_EMP_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_source=>'EMP_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
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
 p_id=>wwv_flow_imp.id(930000000000002003)
,p_name=>'P10002_WORK_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\0639\0645\0644')
,p_source=>'WORK_ID'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
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
 p_id=>wwv_flow_imp.id(930000000000002004)
,p_name=>'P10002_CIVIL_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\062F\0646\064A')
,p_source=>'CIVIL_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
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
 p_id=>wwv_flow_imp.id(930000000000002005)
,p_name=>'P10002_SITE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0627\0644\0645\0648\0642\0639')
,p_source=>'SITE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_OMI_SITE'
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
 p_id=>wwv_flow_imp.id(930000000000002006)
,p_name=>'P10002_STATUS_TXT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0627\0644\062D\0627\0644\0629')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_display_when=>'P10002_PERSON_ID'
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
 p_id=>wwv_flow_imp.id(930000000000002007)
,p_name=>'P10002_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'REMARKS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
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
 p_id=>wwv_flow_imp.id(930000000000002008)
,p_name=>'P10002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_item_default=>'Y'
,p_prompt=>unistr('\0646\0634\0637')
,p_source=>'IS_ACTIVE'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002009)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load status'
,p_static_id=>'load-status-2009'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'for x in (select REGISTERED_AR, REGISTERED_AT, REG_POINT_AR, TERMINAL_NAME, UPLOADED_AR, UPLOADED_AT',
'            from MOINFO_OMI_V_PERSONS where PERSON_ID = :P10002_PERSON_ID) loop',
'    :P10002_STATUS_TXT := x.REGISTERED_AR',
'        || nvl2(x.REGISTERED_AT, '' '' || to_char(x.REGISTERED_AT, ''DD/MM/YYYY HH24:MI''), '''')',
'        || nvl2(x.REG_POINT_AR, '' - '' || x.REG_POINT_AR, '''') || nvl2(x.TERMINAL_NAME, '' / '' || x.TERMINAL_NAME, '''')',
unistr('        || ''\060C '' || x.UPLOADED_AR || nvl2(x.UPLOADED_AT, '' '' || to_char(x.UPLOADED_AT, ''DD/MM/YYYY''), '''');'),
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P10002_PERSON_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>930000000000002009
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000002010)
,p_validation_name=>'Name or employee'
,p_static_id=>'name-or-employee-2010'
,p_validation_sequence=>10
,p_validation=>':P10002_NAME_AR is not null or :P10002_EMPLOYEE_ID is not null'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\0627\0643\062A\0628 \0627\0644\0627\0633\0645 \0623\0648 \0627\062E\062A\0631 \0627\0644\0645\0648\0638\0641')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002011)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_button_name=>'BACK'
,p_static_id=>'back-2011'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:10001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002012)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_button_name=>'DELETE'
,p_static_id=>'delete-2012'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062D\0630\0641 \0647\0630\0627 \0627\0644\0634\062E\0635\061F')
,p_confirm_style=>'danger'
,p_button_condition=>':P10002_PERSON_ID is not null and MOINFO_OMI.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002013)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_button_name=>'SAVE'
,p_static_id=>'save-2013'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P10002_PERSON_ID is not null and MOINFO_OMI.CAN_REGISTER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002014)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000001997)
,p_button_name=>'CREATE'
,p_static_id=>'create-2014'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>':P10002_PERSON_ID is null and MOINFO_OMI.CAN_REGISTER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002015)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000001997)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Person'
,p_static_id=>'init-2015'
,p_internal_uid=>930000000000002015
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002016)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000001997)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Person'
,p_static_id=>'dml-2016'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000002016
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002017)
,p_plug_name=>unistr('\0627\0644\0628\0635\0645\0629')
,p_static_id=>'r930000000000002017'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>':P10002_PERSON_ID is not null and MOINFO_OMI.CAN_REGISTER = ''Y'''
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002018)
,p_name=>'P10002_REG_POINT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000002017)
,p_prompt=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_OMI_REG_POINT'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002019)
,p_name=>'P10002_TERMINAL_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000002017)
,p_prompt=>unistr('\0627\0644\062C\0647\0627\0632')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'OMI_TERMINALS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002020)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002017)
,p_button_name=>'REGISTER'
,p_static_id=>'register-2020'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\0628\0635\0645\0629 \0627\0644\0622\0646')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>'select 1 from MOINFO_OMI_PERSONS where PERSON_ID = :P10002_PERSON_ID and IS_REGISTERED = ''N'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-hand-pointer-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002021)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000002017)
,p_button_name=>'UNREGISTER'
,p_static_id=>'unregister-2021'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621 \0627\0644\062A\0633\062C\064A\0644')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0625\0644\063A\0627\0621 \062A\0633\062C\064A\0644 \0627\0644\0628\0635\0645\0629\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'select 1 from MOINFO_OMI_PERSONS where PERSON_ID = :P10002_PERSON_ID and IS_REGISTERED = ''Y'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002022)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000002017)
,p_button_name=>'UPLOAD'
,p_static_id=>'upload-2022'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_image_alt=>unistr('\062A\0623\0643\064A\062F \0627\0644\0631\0641\0639 \0625\0644\0649 Alpeta')
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>'select 1 from MOINFO_OMI_PERSONS where PERSON_ID = :P10002_PERSON_ID and IS_REGISTERED = ''Y'' and IS_UPLOADED = ''N'' and MOINFO_OMI.IS_MANAGER = ''Y'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-cloud-upload'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002023)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Register'
,p_static_id=>'register-2023'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_OMI.REGISTER_PERSON(:P10002_PERSON_ID, :P10002_REG_POINT_ID, :P10002_TERMINAL_ID);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000002020)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644\062A \0627\0644\0628\0635\0645\0629')
,p_internal_uid=>930000000000002023
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002024)
,p_process_sequence=>31
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Unregister'
,p_static_id=>'unregister-2024'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_OMI.UNREGISTER_PERSON(:P10002_PERSON_ID);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000002021)
,p_process_success_message=>unistr('\0623\064F\0644\063A\064A \0627\0644\062A\0633\062C\064A\0644')
,p_internal_uid=>930000000000002024
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002025)
,p_process_sequence=>32
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload'
,p_static_id=>'upload-2025'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_OMI.MARK_UPLOADED(:P10002_PERSON_ID);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000002022)
,p_process_success_message=>unistr('\0623\064F\0643\0651\062F \0627\0644\0631\0641\0639 \0625\0644\0649 Alpeta')
,p_internal_uid=>930000000000002025
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002026)
,p_branch_name=>'Go To Page 10001'
,p_branch_action=>'f?p=&APP_ID.:10001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000002012)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002027)
,p_branch_name=>'Go To Page 10002'
,p_branch_action=>'f?p=&APP_ID.:10002:&SESSION.::&DEBUG.::P10002_PERSON_ID:&P10002_PERSON_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_10011
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10011);
end;
/

prompt --application/pages/page_10011
begin
wwv_flow_imp_page.create_page(
 p_id=>10011
,p_name=>unistr('\062A\0633\062C\064A\0644 \0633\0631\064A\0639')
,p_alias=>'OMI-QUICK'
,p_step_title=>unistr('\062A\0633\062C\064A\0644 \0633\0631\064A\0639')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000032)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002028)
,p_plug_name=>unistr('\0627\0644\0628\062D\062B \0639\0646 \0627\0644\0634\062E\0635')
,p_static_id=>'r930000000000002028'
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
 p_id=>wwv_flow_imp.id(930000000000002029)
,p_name=>'P10011_CODE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000002028)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\062F\0646\064A \0623\0648 \0627\0644\0648\0638\064A\0641\064A \0623\0648 \0631\0642\0645 \0627\0644\0639\0645\0644')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>unistr('\0627\0643\062A\0628 \0627\0644\0631\0642\0645 \062B\0645 \0627\0636\063A\0637 Enter')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'Y',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002030)
,p_name=>'P10011_PERSON_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000002028)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002031)
,p_name=>'P10011_INFO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000002028)
,p_prompt=>unistr('\0627\0644\0634\062E\0635')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P10011_CODE'
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
 p_id=>wwv_flow_imp.id(930000000000002032)
,p_name=>'P10011_REG_POINT_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000002028)
,p_prompt=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_OMI_REG_POINT'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_inline_help_text=>unistr('\062A\0628\0642\0649 \0643\0645\0627 \0647\064A \0644\0644\062A\0633\062C\064A\0644 \0627\0644\062A\0627\0644\064A')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002033)
,p_name=>'P10011_TERMINAL_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000002028)
,p_prompt=>unistr('\0627\0644\062C\0647\0627\0632')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'OMI_TERMINALS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002034)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Find person'
,p_static_id=>'find-person-2034'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P10011_PERSON_ID := null;',
unistr(':P10011_INFO := ''\0644\0627 \064A\0648\062C\062F \0634\062E\0635 \0628\0647\0630\0627 \0627\0644\0631\0642\0645'';'),
'for x in (select PERSON_ID, NAME_AR, EMP_NO, CIVIL_NO, SITE_AR, REGISTERED_AR, REGISTERED_AT, UPLOADED_AR',
'            from MOINFO_OMI_V_PERSONS',
'           where IS_ACTIVE = ''Y''',
'             and (CIVIL_NO = trim(:P10011_CODE) or upper(EMP_NO) = upper(trim(:P10011_CODE))',
'                  or upper(WORK_ID) = upper(trim(:P10011_CODE)))',
'           order by PERSON_ID',
'           fetch first 1 row only) loop',
'    :P10011_PERSON_ID := x.PERSON_ID;',
'    :P10011_INFO := x.NAME_AR || '' - '' || nvl(x.EMP_NO, x.CIVIL_NO) || nvl2(x.SITE_AR, '' - '' || x.SITE_AR, '''')',
'        || '' - '' || x.REGISTERED_AR || nvl2(x.REGISTERED_AT, '' '' || to_char(x.REGISTERED_AT, ''DD/MM/YYYY HH24:MI''), '''')',
unistr('        || ''\060C '' || x.UPLOADED_AR;'),
'end loop;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P10011_CODE'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>930000000000002034
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002035)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002028)
,p_button_name=>'REGISTER'
,p_static_id=>'register-2035'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062A\0633\062C\064A\0644 \0627\0644\0628\0635\0645\0629')
,p_button_position=>'NEXT'
,p_button_condition=>'select 1 from MOINFO_OMI_PERSONS
 where PERSON_ID = :P10011_PERSON_ID and IS_REGISTERED = ''N'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-hand-pointer-o'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002036)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Register'
,p_static_id=>'register-2036'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_OMI.REGISTER_PERSON(:P10011_PERSON_ID, :P10011_REG_POINT_ID, :P10011_TERMINAL_ID);',
':P10011_CODE := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000002035)
,p_process_success_message=>unistr('\0633\064F\062C\0651\0644\062A \0627\0644\0628\0635\0645\0629')
,p_internal_uid=>930000000000002036
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002037)
,p_plug_name=>unistr('\0633\064F\062C\0651\0644\0648\0627 \0627\0644\064A\0648\0645')
,p_static_id=>'r930000000000002037'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PERSON_ID, EMP_NO, WORK_ID, NAME_AR, NAME_EN, CIVIL_NO, SITE_AR, REGISTERED_AR,',
'       to_char(REGISTERED_AT, ''DD/MM/YYYY HH24:MI'') as REGISTERED_AT_TXT, REG_POINT_AR, TERMINAL_NAME, UPLOADED_AR, REMARKS',
'  from MOINFO_OMI_V_PERSONS',
' where trunc(REGISTERED_AT) = trunc(sysdate)',
' order by REGISTERED_AT desc'))
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
 p_id=>wwv_flow_imp.id(930000000000002038)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10002:&SESSION.::&DEBUG.:10002:P10002_PERSON_ID:#PERSON_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002038
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002039)
,p_db_column_name=>'PERSON_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'PERSON_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002040)
,p_db_column_name=>'EMP_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002041)
,p_db_column_name=>'WORK_ID'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0631\0642\0645 \0627\0644\0639\0645\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002042)
,p_db_column_name=>'NAME_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002043)
,p_db_column_name=>'NAME_EN'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0627\0633\0645 \0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002044)
,p_db_column_name=>'CIVIL_NO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\062F\0646\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002045)
,p_db_column_name=>'SITE_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002046)
,p_db_column_name=>'REGISTERED_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0628\0635\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002047)
,p_db_column_name=>'REGISTERED_AT_TXT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0648\0642\062A \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002048)
,p_db_column_name=>'REG_POINT_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002049)
,p_db_column_name=>'TERMINAL_NAME'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\0632')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002050)
,p_db_column_name=>'UPLOADED_AR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Alpeta'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002051)
,p_db_column_name=>'REMARKS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002052)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2053'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMP_NO:WORK_ID:NAME_AR:NAME_EN:CIVIL_NO:SITE_AR:REGISTERED_AR:REGISTERED_AT_TXT:REG_POINT_AR:TERMINAL_NAME:UPLOADED_AR:REMARKS:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002054)
,p_branch_name=>'Go To Page 10011'
,p_branch_action=>'f?p=&APP_ID.:10011:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_10006
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10006);
end;
/

prompt --application/pages/page_10006
begin
wwv_flow_imp_page.create_page(
 p_id=>10006
,p_name=>unistr('\0623\062C\0647\0632\0629 \0627\0644\0628\0635\0645\0629')
,p_alias=>'P10006'
,p_step_title=>unistr('\0623\062C\0647\0632\0629 \0627\0644\0628\0635\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000016)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002055)
,p_plug_name=>unistr('\0623\062C\0647\0632\0629 \0627\0644\0628\0635\0645\0629')
,p_static_id=>'r930000000000002055'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select TERMINAL_ID, NAME, SERIAL_NO, MAC_ADDRESS, IP_ADDRESS, SITE_AR, REG_POINT_AR, LOCATION_DESC,',
unistr('       case IS_FIXED when ''Y'' then ''\0646\0639\0645'' else ''\0644\0627'' end as IS_FIXED_AR, case IS_CONNECTED when ''Y'' then ''\0646\0639\0645'' else ''\0644\0627'' end as IS_CONNECTED_AR, PERSONS_COUNT,'),
unistr('       case IS_ACTIVE when ''Y'' then ''\0646\0639\0645'' else ''\0644\0627'' end as IS_ACTIVE_AR'),
'  from MOINFO_OMI_V_TERMINALS'))
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
 p_id=>wwv_flow_imp.id(930000000000002056)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10007:&SESSION.::&DEBUG.:10007:P10007_TERMINAL_ID:#TERMINAL_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002056
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002057)
,p_db_column_name=>'TERMINAL_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'TERMINAL_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002058)
,p_db_column_name=>'NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002059)
,p_db_column_name=>'SERIAL_NO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002060)
,p_db_column_name=>'MAC_ADDRESS'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'MAC'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002061)
,p_db_column_name=>'IP_ADDRESS'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'IP'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002062)
,p_db_column_name=>'SITE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002063)
,p_db_column_name=>'REG_POINT_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002064)
,p_db_column_name=>'LOCATION_DESC'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0645\0643\0627\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002065)
,p_db_column_name=>'IS_FIXED_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\062B\0627\0628\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002066)
,p_db_column_name=>'IS_CONNECTED_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0645\062A\0635\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002067)
,p_db_column_name=>'PERSONS_COUNT'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0645\0633\062C\0651\0644\0648\0646 \0639\0644\064A\0647')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002068)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0646\0634\0637')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002069)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2070'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:SERIAL_NO:MAC_ADDRESS:IP_ADDRESS:SITE_AR:REG_POINT_AR:LOCATION_DESC:IS_FIXED_AR:IS_CONNECTED_AR:PERSONS_COUNT:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002071)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002055)
,p_button_name=>'CREATE'
,p_static_id=>'create-2071'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:10007:&SESSION.::&DEBUG.:10007::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_10007
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10007);
end;
/

prompt --application/pages/page_10007
begin
wwv_flow_imp_page.create_page(
 p_id=>10007
,p_name=>unistr('\062C\0647\0627\0632 \0628\0635\0645\0629')
,p_alias=>'P10007'
,p_step_title=>unistr('\062C\0647\0627\0632 \0628\0635\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000027)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002072)
,p_plug_name=>unistr('\062C\0647\0627\0632 \0628\0635\0645\0629')
,p_static_id=>'r930000000000002072'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_OMI_TERMINALS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002073)
,p_name=>'P10007_TERMINAL_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_source=>'TERMINAL_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002074)
,p_name=>'P10007_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_prompt=>unistr('\0627\0644\0627\0633\0645')
,p_source=>'NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
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
 p_id=>wwv_flow_imp.id(930000000000002075)
,p_name=>'P10007_SERIAL_NO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\062A\0633\0644\0633\0644\064A')
,p_source=>'SERIAL_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000002076)
,p_name=>'P10007_MAC_ADDRESS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_prompt=>'MAC Address'
,p_source=>'MAC_ADDRESS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
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
 p_id=>wwv_flow_imp.id(930000000000002077)
,p_name=>'P10007_IP_ADDRESS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_prompt=>'IP Address'
,p_source=>'IP_ADDRESS'
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
 p_id=>wwv_flow_imp.id(930000000000002078)
,p_name=>'P10007_SITE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_prompt=>unistr('\0627\0644\0645\0648\0642\0639')
,p_source=>'SITE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_OMI_SITE'
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
 p_id=>wwv_flow_imp.id(930000000000002079)
,p_name=>'P10007_REG_POINT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_prompt=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_source=>'REG_POINT_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_OMI_REG_POINT'
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
 p_id=>wwv_flow_imp.id(930000000000002080)
,p_name=>'P10007_LOCATION_DESC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_prompt=>unistr('\0648\0635\0641 \0627\0644\0645\0643\0627\0646')
,p_source=>'LOCATION_DESC'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
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
 p_id=>wwv_flow_imp.id(930000000000002081)
,p_name=>'P10007_IS_FIXED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_default=>'N'
,p_prompt=>unistr('\062C\0647\0627\0632 \062B\0627\0628\062A')
,p_source=>'IS_FIXED'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002082)
,p_name=>'P10007_IS_CONNECTED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_default=>'N'
,p_prompt=>unistr('\0645\062A\0635\0644 \0628\0627\0644\0634\0628\0643\0629')
,p_source=>'IS_CONNECTED'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002083)
,p_name=>'P10007_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
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
 p_id=>wwv_flow_imp.id(930000000000002084)
,p_name=>'P10007_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_item_default=>'Y'
,p_prompt=>unistr('\0646\0634\0637')
,p_source=>'IS_ACTIVE'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002085)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-2085'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:10006:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002086)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_button_name=>'DELETE'
,p_static_id=>'delete-2086'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0627 \0627\0644\0633\062C\0644\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P10007_TERMINAL_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002087)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_button_name=>'SAVE'
,p_static_id=>'save-2087'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P10007_TERMINAL_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002088)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000002072)
,p_button_name=>'CREATE'
,p_static_id=>'create-2088'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621')
,p_button_position=>'CREATE'
,p_button_condition=>'P10007_TERMINAL_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002089)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000002072)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \062C\0647\0627\0632 \0628\0635\0645\0629')
,p_static_id=>'init-2089'
,p_internal_uid=>930000000000002089
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002090)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000002072)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \062C\0647\0627\0632 \0628\0635\0645\0629')
,p_static_id=>'dml-2090'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000002090
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002091)
,p_branch_name=>'Go To Page 10006'
,p_branch_action=>'f?p=&APP_ID.:10006:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_10008
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10008);
end;
/

prompt --application/pages/page_10008
begin
wwv_flow_imp_page.create_page(
 p_id=>10008
,p_name=>unistr('\0645\0644\062E\0635 \0627\0644\062A\0633\062C\064A\0644')
,p_alias=>'OMI-SUMMARY'
,p_step_title=>unistr('\0645\0644\062E\0635 \0627\0644\062A\0633\062C\064A\0644')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000016)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002092)
,p_plug_name=>unistr('\062D\0633\0628 \0627\0644\0645\0648\0642\0639')
,p_static_id=>'r930000000000002092'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select SITE_AR, PERSONS_COUNT, REGISTERED_COUNT, NOT_REGISTERED_COUNT, NOT_UPLOADED_COUNT, TODAY_COUNT',
'  from MOINFO_OMI_V_SUMMARY',
' order by SITE_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000002093)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000002093
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002094)
,p_db_column_name=>'SITE_AR'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002095)
,p_db_column_name=>'PERSONS_COUNT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0623\0634\062E\0627\0635')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002096)
,p_db_column_name=>'REGISTERED_COUNT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0645\0633\062C\0651\0644\0648\0646')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002097)
,p_db_column_name=>'NOT_REGISTERED_COUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\063A\064A\0631 \0645\0633\062C\0651\0644\064A\0646')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002098)
,p_db_column_name=>'NOT_UPLOADED_COUNT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0644\0645 \064A\064F\0631\0641\0639\0648\0627')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002099)
,p_db_column_name=>'TODAY_COUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\064A\0648\0645')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002100)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2101'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'SITE_AR:PERSONS_COUNT:REGISTERED_COUNT:NOT_REGISTERED_COUNT:NOT_UPLOADED_COUNT:TODAY_COUNT:'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002102)
,p_plug_name=>unistr('\0627\0644\062A\0633\062C\064A\0644 \0627\0644\064A\0648\0645\064A')
,p_static_id=>'r930000000000002102'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select REG_DAY, SITE_AR, REG_POINT_AR, REGISTERED_COUNT, UPLOADED_COUNT',
'  from MOINFO_OMI_V_DAILY',
' order by REG_DAY desc, SITE_AR, REG_POINT_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000002103)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000002103
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002104)
,p_db_column_name=>'REG_DAY'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\064A\0648\0645')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002105)
,p_db_column_name=>'SITE_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002106)
,p_db_column_name=>'REG_POINT_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0646\0642\0637\0629 \0627\0644\062A\0633\062C\064A\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002107)
,p_db_column_name=>'REGISTERED_COUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0645\0633\062C\0651\0644\0648\0646')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002108)
,p_db_column_name=>'UPLOADED_COUNT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0645\0631\0641\0648\0639\0648\0646')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002109)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2110'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REG_DAY:SITE_AR:REG_POINT_AR:REGISTERED_COUNT:UPLOADED_COUNT:'
);
end;
/

prompt --application/pages/delete_10009
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10009);
end;
/

prompt --application/pages/page_10009
begin
wwv_flow_imp_page.create_page(
 p_id=>10009
,p_name=>unistr('\0642\0648\0627\0626\0645 \062A\0633\062C\064A\0644 \0627\0644\0628\0635\0645\0629')
,p_alias=>'P10009'
,p_step_title=>unistr('\0642\0648\0627\0626\0645 \062A\0633\062C\064A\0644 \0627\0644\0628\0635\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000027)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002111)
,p_plug_name=>unistr('\0642\0648\0627\0626\0645 \062A\0633\062C\064A\0644 \0627\0644\0628\0635\0645\0629')
,p_static_id=>'r930000000000002111'
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
' where l.LOOKUP_TYPE in (''OMI_SITE'', ''OMI_REG_POINT'')',
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
 p_id=>wwv_flow_imp.id(930000000000002112)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:10010:&SESSION.::&DEBUG.:10010:P10010_LOOKUP_ID:#LOOKUP_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002112
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002113)
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
 p_id=>wwv_flow_imp.id(930000000000002114)
,p_db_column_name=>'TYPE_NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002115)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002116)
,p_db_column_name=>'NAME_EN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002117)
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
 p_id=>wwv_flow_imp.id(930000000000002118)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0646\0634\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002119)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2120'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE_NAME_AR:NAME_AR:NAME_EN:SORT_ORDER:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002121)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002111)
,p_button_name=>'CREATE'
,p_static_id=>'create-2121'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:10010:&SESSION.::&DEBUG.:10010::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_10010
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10010);
end;
/

prompt --application/pages/page_10010
begin
wwv_flow_imp_page.create_page(
 p_id=>10010
,p_name=>unistr('\0642\064A\0645\0629')
,p_alias=>'P10010'
,p_step_title=>unistr('\0642\064A\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000027)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002122)
,p_plug_name=>unistr('\0642\064A\0645\0629')
,p_static_id=>'r930000000000002122'
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
 p_id=>wwv_flow_imp.id(930000000000002123)
,p_name=>'P10010_LOOKUP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_source=>'LOOKUP_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002124)
,p_name=>'P10010_LOOKUP_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_prompt=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_source=>'LOOKUP_TYPE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'OMI_LIST_TYPES'
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
 p_id=>wwv_flow_imp.id(930000000000002125)
,p_name=>'P10010_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002122)
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
 p_id=>wwv_flow_imp.id(930000000000002126)
,p_name=>'P10010_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002122)
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
 p_id=>wwv_flow_imp.id(930000000000002127)
,p_name=>'P10010_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002122)
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
 p_id=>wwv_flow_imp.id(930000000000002128)
,p_name=>'P10010_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002122)
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
 p_id=>wwv_flow_imp.id(930000000000002129)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-2129'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:10009:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002130)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_button_name=>'DELETE'
,p_static_id=>'delete-2130'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0627 \0627\0644\0633\062C\0644\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P10010_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002131)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_button_name=>'SAVE'
,p_static_id=>'save-2131'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P10010_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002132)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000002122)
,p_button_name=>'CREATE'
,p_static_id=>'create-2132'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621')
,p_button_position=>'CREATE'
,p_button_condition=>'P10010_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002133)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000002122)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0642\064A\0645\0629')
,p_static_id=>'init-2133'
,p_internal_uid=>930000000000002133
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002134)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000002122)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0642\064A\0645\0629')
,p_static_id=>'dml-2134'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000002134
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002135)
,p_branch_name=>'Go To Page 10009'
,p_branch_action=>'f?p=&APP_ID.:10009:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_11001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11001);
end;
/

prompt --application/pages/page_11001
begin
wwv_flow_imp_page.create_page(
 p_id=>11001
,p_name=>unistr('\062F\0644\064A\0644 \0627\0644\0627\062A\0635\0627\0644')
,p_alias=>'NWS-DIRECTORY'
,p_step_title=>unistr('\062F\0644\064A\0644 \0627\0644\0627\062A\0635\0627\0644')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000017)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002136)
,p_plug_name=>unistr('\062F\0644\064A\0644 \0627\0644\0627\062A\0635\0627\0644')
,p_static_id=>'r930000000000002136'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select CONTACT_ID, NAME, DESIGNATION, ENTITY_PATH_AR, ENTITY_TYPE_AR, COUNTRY_AR, REGION_AR, GOVERNORATE_AR,',
'       WILAYAT_AR, CITY, MOBILE1, MOBILE2, TEL, OFFICE_NO, EMAIL, REMARKS',
'  from MOINFO_NWS_V_CONTACTS',
' where IS_ACTIVE = ''Y''',
' order by ENTITY_PATH_AR, NAME'))
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
 p_id=>wwv_flow_imp.id(930000000000002137)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:11004:&SESSION.::&DEBUG.:11004:P11004_CONTACT_ID:#CONTACT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002137
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002138)
,p_db_column_name=>'CONTACT_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'CONTACT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002139)
,p_db_column_name=>'NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002140)
,p_db_column_name=>'DESIGNATION'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0633\0645\0649')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002141)
,p_db_column_name=>'ENTITY_PATH_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002142)
,p_db_column_name=>'ENTITY_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0646\0648\0639 \0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002143)
,p_db_column_name=>'COUNTRY_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062F\0648\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002144)
,p_db_column_name=>'REGION_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0625\0642\0644\064A\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002145)
,p_db_column_name=>'GOVERNORATE_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0645\062D\0627\0641\0638\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002146)
,p_db_column_name=>'WILAYAT_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0648\0644\0627\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002147)
,p_db_column_name=>'CITY'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0645\062F\064A\0646\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002148)
,p_db_column_name=>'MOBILE1'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641 1')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002149)
,p_db_column_name=>'MOBILE2'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641 2')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002150)
,p_db_column_name=>'TEL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0627\0644\062B\0627\0628\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002151)
,p_db_column_name=>'OFFICE_NO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('\0627\0644\0645\0643\062A\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002152)
,p_db_column_name=>'EMAIL'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002153)
,p_db_column_name=>'REMARKS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002154)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2155'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:DESIGNATION:ENTITY_PATH_AR:ENTITY_TYPE_AR:COUNTRY_AR:REGION_AR:GOVERNORATE_AR:WILAYAT_AR:CITY:MOBILE1:MOBILE2:TEL:OFFICE_NO:EMAIL:REMARKS:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002156)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002136)
,p_button_name=>'CREATE'
,p_static_id=>'create-2156'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644 \062C\062F\064A\062F\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:11004:&SESSION.::&DEBUG.:11004::'
,p_button_condition=>'MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_11002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11002);
end;
/

prompt --application/pages/page_11002
begin
wwv_flow_imp_page.create_page(
 p_id=>11002
,p_name=>unistr('\0627\0644\062C\0647\0627\062A')
,p_alias=>'NWS-ENTITIES'
,p_step_title=>unistr('\0627\0644\062C\0647\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000017)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002157)
,p_plug_name=>unistr('\0627\0644\062C\0647\0627\062A')
,p_static_id=>'r930000000000002157'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ENTITY_ID, ENTITY_PATH_AR, ENTITY_TYPE_AR, CATEGORY_AR, COUNTRY_AR, GOVERNORATE_AR, WILAYAT_AR, PHONE, EMAIL,',
'       CHILDREN_COUNT, CONTACTS_COUNT',
'  from MOINFO_NWS_V_ENTITIES',
' where IS_ACTIVE = ''Y''',
' order by ENTITY_PATH_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000002158)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:11003:&SESSION.::&DEBUG.:11003:P11003_ENTITY_ID:#ENTITY_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002158
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002159)
,p_db_column_name=>'ENTITY_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ENTITY_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002160)
,p_db_column_name=>'ENTITY_PATH_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002161)
,p_db_column_name=>'ENTITY_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002162)
,p_db_column_name=>'CATEGORY_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\062A\0635\0646\064A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002163)
,p_db_column_name=>'COUNTRY_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062F\0648\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002164)
,p_db_column_name=>'GOVERNORATE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\062D\0627\0641\0638\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002165)
,p_db_column_name=>'WILAYAT_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0648\0644\0627\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002166)
,p_db_column_name=>'PHONE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002167)
,p_db_column_name=>'EMAIL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002168)
,p_db_column_name=>'CHILDREN_COUNT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\062C\0647\0627\062A \0641\0631\0639\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002169)
,p_db_column_name=>'CONTACTS_COUNT'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\062C\0647\0627\062A \0627\0644\0627\062A\0635\0627\0644')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002170)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2171'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ENTITY_PATH_AR:ENTITY_TYPE_AR:CATEGORY_AR:COUNTRY_AR:GOVERNORATE_AR:WILAYAT_AR:PHONE:EMAIL:CHILDREN_COUNT:CONTACTS_COUNT:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002172)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002157)
,p_button_name=>'CREATE'
,p_static_id=>'create-2172'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062C\0647\0629 \062C\062F\064A\062F\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:11003:&SESSION.::&DEBUG.:11003::'
,p_button_condition=>'MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_11003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11003);
end;
/

prompt --application/pages/page_11003
begin
wwv_flow_imp_page.create_page(
 p_id=>11003
,p_name=>unistr('\062C\0647\0629')
,p_alias=>'NWS-ENTITY'
,p_step_title=>unistr('\062C\0647\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000017)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002173)
,p_plug_name=>unistr('\062C\0647\0629')
,p_static_id=>'r930000000000002173'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_NWS_ENTITIES'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002174)
,p_name=>'P11003_ENTITY_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_source=>'ENTITY_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002175)
,p_name=>'P11003_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0633\0645 \0627\0644\062C\0647\0629')
,p_source=>'NAME_AR'
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
 p_id=>wwv_flow_imp.id(930000000000002176)
,p_name=>'P11003_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_source=>'NAME_EN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>300
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
 p_id=>wwv_flow_imp.id(930000000000002177)
,p_name=>'P11003_PARENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\062A\062A\0628\0639 \0627\0644\062C\0647\0629')
,p_source=>'PARENT_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'NWS_PARENT_ENTITIES'
,p_lov_display_null=>'YES'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0627\062A\0631\0643\0647\0627 \0641\0627\0631\063A\0629 \0625\0646 \0643\0627\0646\062A \062C\0647\0629 \0631\0626\064A\0633\064A\0629')
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
 p_id=>wwv_flow_imp.id(930000000000002178)
,p_name=>'P11003_ENTITY_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0646\0648\0639')
,p_source=>'ENTITY_TYPE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_NWS_ENTITY_TYPE'
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
 p_id=>wwv_flow_imp.id(930000000000002179)
,p_name=>'P11003_CATEGORY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\062A\0635\0646\064A\0641')
,p_source=>'CATEGORY_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_NWS_CATEGORY'
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
 p_id=>wwv_flow_imp.id(930000000000002180)
,p_name=>'P11003_COUNTRY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\062F\0648\0644\0629')
,p_source=>'COUNTRY_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'COUNTRIES'
,p_lov_display_null=>'YES'
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
 p_id=>wwv_flow_imp.id(930000000000002181)
,p_name=>'P11003_GOVERNORATE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0645\062D\0627\0641\0638\0629')
,p_source=>'GOVERNORATE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'GOVERNORATES'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0644\0644\062C\0647\0627\062A \062F\0627\062E\0644 \0627\0644\0633\0644\0637\0646\0629')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002182)
,p_name=>'P11003_WILAYAT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0648\0644\0627\064A\0629')
,p_source=>'WILAYAT_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'NWS_WILAYATS_BY_GOV'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_lov_cascade_parent_items=>'P11003_GOVERNORATE_ID'
,p_ajax_optimize_refresh=>'Y'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002183)
,p_name=>'P11003_CITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0645\062F\064A\0646\0629')
,p_source=>'CITY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
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
 p_id=>wwv_flow_imp.id(930000000000002184)
,p_name=>'P11003_PHONE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0647\0627\062A\0641')
,p_source=>'PHONE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000002185)
,p_name=>'P11003_FAX'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0641\0627\0643\0633')
,p_source=>'FAX'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000002186)
,p_name=>'P11003_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0628\0631\064A\062F \0627\0644\0625\0644\0643\062A\0631\0648\0646\064A')
,p_source=>'EMAIL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>255
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
 p_id=>wwv_flow_imp.id(930000000000002187)
,p_name=>'P11003_WEBSITE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0645\0648\0642\0639 \0627\0644\0625\0644\0643\062A\0631\0648\0646\064A')
,p_source=>'WEBSITE'
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
 p_id=>wwv_flow_imp.id(930000000000002188)
,p_name=>'P11003_ADDRESS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0627\0644\0639\0646\0648\0627\0646')
,p_source=>'ADDRESS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
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
 p_id=>wwv_flow_imp.id(930000000000002189)
,p_name=>'P11003_NOTES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'NOTES'
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
 p_id=>wwv_flow_imp.id(930000000000002190)
,p_name=>'P11003_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
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
 p_id=>wwv_flow_imp.id(930000000000002191)
,p_name=>'P11003_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002173)
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
 p_id=>wwv_flow_imp.id(930000000000002192)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_button_name=>'BACK'
,p_static_id=>'back-2192'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:11002:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002193)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_button_name=>'DELETE'
,p_static_id=>'delete-2193'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062D\0630\0641 \0627\0644\062C\0647\0629 \0648\062C\0647\0627\062A \0627\062A\0635\0627\0644\0647\0627\061F (\0644\0627 \062A\064F\062D\0630\0641 \0625\0646 \0643\0627\0646\062A \0644\0647\0627 \062C\0647\0627\062A \0641\0631\0639\064A\0629)')
,p_confirm_style=>'danger'
,p_button_condition=>':P11003_ENTITY_ID is not null and MOINFO_NWS.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002194)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_button_name=>'SAVE'
,p_static_id=>'save-2194'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P11003_ENTITY_ID is not null and MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002195)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000002173)
,p_button_name=>'CREATE'
,p_static_id=>'create-2195'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>':P11003_ENTITY_ID is null and MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002196)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000002173)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Entity'
,p_static_id=>'init-2196'
,p_internal_uid=>930000000000002196
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002197)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000002173)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Entity'
,p_static_id=>'dml-2197'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000002197
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002198)
,p_plug_name=>unistr('\0627\0644\062C\0647\0627\062A \0627\0644\0641\0631\0639\064A\0629')
,p_static_id=>'r930000000000002198'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ENTITY_ID, ENTITY_PATH_AR, ENTITY_TYPE_AR, CATEGORY_AR, COUNTRY_AR, GOVERNORATE_AR, WILAYAT_AR, PHONE, EMAIL,',
'       CHILDREN_COUNT, CONTACTS_COUNT',
'  from MOINFO_NWS_V_ENTITIES',
' where PARENT_ID = :P11003_ENTITY_ID',
' order by SORT_ORDER, NAME_AR'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P11003_ENTITY_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000002199)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:11003:&SESSION.::&DEBUG.:11003:P11003_ENTITY_ID:#ENTITY_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002199
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002200)
,p_db_column_name=>'ENTITY_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ENTITY_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002201)
,p_db_column_name=>'ENTITY_PATH_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002202)
,p_db_column_name=>'ENTITY_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002203)
,p_db_column_name=>'CATEGORY_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\062A\0635\0646\064A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002204)
,p_db_column_name=>'COUNTRY_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062F\0648\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002205)
,p_db_column_name=>'GOVERNORATE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\062D\0627\0641\0638\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002206)
,p_db_column_name=>'WILAYAT_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0648\0644\0627\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002207)
,p_db_column_name=>'PHONE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002208)
,p_db_column_name=>'EMAIL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002209)
,p_db_column_name=>'CHILDREN_COUNT'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\062C\0647\0627\062A \0641\0631\0639\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002210)
,p_db_column_name=>'CONTACTS_COUNT'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\062C\0647\0627\062A \0627\0644\0627\062A\0635\0627\0644')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002211)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2212'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ENTITY_PATH_AR:ENTITY_TYPE_AR:CATEGORY_AR:COUNTRY_AR:GOVERNORATE_AR:WILAYAT_AR:PHONE:EMAIL:CHILDREN_COUNT:CONTACTS_COUNT:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002213)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002198)
,p_button_name=>'ADD_CHILD'
,p_static_id=>'add-child-2213'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062C\0647\0629 \0641\0631\0639\064A\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:11003:&SESSION.::&DEBUG.:11003:P11003_PARENT_ID:&P11003_ENTITY_ID.'
,p_button_condition=>'MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002214)
,p_plug_name=>unistr('\062C\0647\0627\062A \0627\0644\0627\062A\0635\0627\0644')
,p_static_id=>'r930000000000002214'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select CONTACT_ID, NAME, DESIGNATION, ENTITY_PATH_AR, ENTITY_TYPE_AR, COUNTRY_AR, REGION_AR, GOVERNORATE_AR,',
'       WILAYAT_AR, CITY, MOBILE1, MOBILE2, TEL, OFFICE_NO, EMAIL, REMARKS',
'  from MOINFO_NWS_V_CONTACTS',
' where ENTITY_ID = :P11003_ENTITY_ID',
' order by NAME'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P11003_ENTITY_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000002215)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:11004:&SESSION.::&DEBUG.:11004:P11004_CONTACT_ID:#CONTACT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002215
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002216)
,p_db_column_name=>'CONTACT_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'CONTACT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002217)
,p_db_column_name=>'NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002218)
,p_db_column_name=>'DESIGNATION'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0633\0645\0649')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002219)
,p_db_column_name=>'ENTITY_PATH_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002220)
,p_db_column_name=>'ENTITY_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0646\0648\0639 \0627\0644\062C\0647\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002221)
,p_db_column_name=>'COUNTRY_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062F\0648\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002222)
,p_db_column_name=>'REGION_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0625\0642\0644\064A\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002223)
,p_db_column_name=>'GOVERNORATE_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0645\062D\0627\0641\0638\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002224)
,p_db_column_name=>'WILAYAT_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0648\0644\0627\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002225)
,p_db_column_name=>'CITY'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0645\062F\064A\0646\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002226)
,p_db_column_name=>'MOBILE1'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641 1')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002227)
,p_db_column_name=>'MOBILE2'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0647\0627\062A\0641 2')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002228)
,p_db_column_name=>'TEL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0627\0644\062B\0627\0628\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002229)
,p_db_column_name=>'OFFICE_NO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('\0627\0644\0645\0643\062A\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002230)
,p_db_column_name=>'EMAIL'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002231)
,p_db_column_name=>'REMARKS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002232)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2233'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:DESIGNATION:ENTITY_PATH_AR:ENTITY_TYPE_AR:COUNTRY_AR:REGION_AR:GOVERNORATE_AR:WILAYAT_AR:CITY:MOBILE1:MOBILE2:TEL:OFFICE_NO:EMAIL:REMARKS:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002234)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002214)
,p_button_name=>'ADD_CONTACT'
,p_static_id=>'add-contact-2234'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:11004:&SESSION.::&DEBUG.:11004:P11004_ENTITY_ID:&P11003_ENTITY_ID.'
,p_button_condition=>'MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002235)
,p_branch_name=>'Go To Page 11002'
,p_branch_action=>'f?p=&APP_ID.:11002:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000002193)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002236)
,p_branch_name=>'Go To Page 11003'
,p_branch_action=>'f?p=&APP_ID.:11003:&SESSION.::&DEBUG.::P11003_ENTITY_ID:&P11003_ENTITY_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_11004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11004);
end;
/

prompt --application/pages/page_11004
begin
wwv_flow_imp_page.create_page(
 p_id=>11004
,p_name=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644')
,p_alias=>'NWS-CONTACT'
,p_step_title=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000017)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002237)
,p_plug_name=>unistr('\062C\0647\0629 \0627\062A\0635\0627\0644')
,p_static_id=>'r930000000000002237'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_NWS_CONTACTS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002238)
,p_name=>'P11004_CONTACT_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_source=>'CONTACT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002239)
,p_name=>'P11004_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\0627\0633\0645')
,p_source=>'NAME'
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
 p_id=>wwv_flow_imp.id(930000000000002240)
,p_name=>'P11004_DESIGNATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\0645\0633\0645\0649')
,p_source=>'DESIGNATION'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
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
 p_id=>wwv_flow_imp.id(930000000000002241)
,p_name=>'P11004_ENTITY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\062C\0647\0629')
,p_source=>'ENTITY_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'NWS_ENTITIES'
,p_lov_display_null=>'YES'
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
 p_id=>wwv_flow_imp.id(930000000000002242)
,p_name=>'P11004_COUNTRY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0623\0648 \0627\0644\062F\0648\0644\0629')
,p_source=>'COUNTRY_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'COUNTRIES'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0644\0645\0646 \0644\0627 \064A\062A\0628\0639 \062C\0647\0629 \0645\062D\062F\062F\0629\060C \0645\062B\0644 \0627\0644\0645\0631\0627\0633\0644\064A\0646')
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
 p_id=>wwv_flow_imp.id(930000000000002243)
,p_name=>'P11004_MOBILE1'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\0647\0627\062A\0641 1')
,p_source=>'MOBILE1'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000002244)
,p_name=>'P11004_MOBILE2'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\0647\0627\062A\0641 2')
,p_source=>'MOBILE2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000002245)
,p_name=>'P11004_TEL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\062B\0627\0628\062A')
,p_source=>'TEL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000002246)
,p_name=>'P11004_OFFICE_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\0645\0643\062A\0628')
,p_source=>'OFFICE_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
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
 p_id=>wwv_flow_imp.id(930000000000002247)
,p_name=>'P11004_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\0628\0631\064A\062F \0627\0644\0625\0644\0643\062A\0631\0648\0646\064A')
,p_source=>'EMAIL'
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
 p_id=>wwv_flow_imp.id(930000000000002248)
,p_name=>'P11004_CITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_prompt=>unistr('\0627\0644\0645\062F\064A\0646\0629')
,p_source=>'CITY'
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
 p_id=>wwv_flow_imp.id(930000000000002249)
,p_name=>'P11004_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
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
 p_id=>wwv_flow_imp.id(930000000000002250)
,p_name=>'P11004_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002237)
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
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000002251)
,p_validation_name=>'Entity or country'
,p_static_id=>'entity-or-country-2251'
,p_validation_sequence=>10
,p_validation=>':P11004_ENTITY_ID is not null or :P11004_COUNTRY_ID is not null'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\0627\062E\062A\0631 \0627\0644\062C\0647\0629 \0623\0648 \0627\0644\062F\0648\0644\0629')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002252)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_button_name=>'BACK'
,p_static_id=>'back-2252'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:11001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002253)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_button_name=>'DELETE'
,p_static_id=>'delete-2253'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\062D\0630\0641 \062C\0647\0629 \0627\0644\0627\062A\0635\0627\0644\061F')
,p_confirm_style=>'danger'
,p_button_condition=>':P11004_CONTACT_ID is not null and MOINFO_NWS.IS_MANAGER = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002254)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_button_name=>'SAVE'
,p_static_id=>'save-2254'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>':P11004_CONTACT_ID is not null and MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002255)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000002237)
,p_button_name=>'CREATE'
,p_static_id=>'create-2255'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>':P11004_CONTACT_ID is null and MOINFO_NWS.CAN_EDIT = ''Y'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002256)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000002237)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Contact'
,p_static_id=>'init-2256'
,p_internal_uid=>930000000000002256
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002257)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000002237)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Contact'
,p_static_id=>'dml-2257'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000002257
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002258)
,p_branch_name=>'Go To Page 11003'
,p_branch_action=>'f?p=&APP_ID.:11003:&SESSION.::&DEBUG.::P11003_ENTITY_ID:&P11004_ENTITY_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P11004_ENTITY_ID'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002259)
,p_branch_name=>'Go To Page 11001'
,p_branch_action=>'f?p=&APP_ID.:11001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_11005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11005);
end;
/

prompt --application/pages/page_11005
begin
wwv_flow_imp_page.create_page(
 p_id=>11005
,p_name=>unistr('\0627\0644\062F\0648\0644 \0648\0627\0644\0623\0642\0627\0644\064A\0645')
,p_alias=>'NWS-COUNTRIES'
,p_step_title=>unistr('\0627\0644\062F\0648\0644 \0648\0627\0644\0623\0642\0627\0644\064A\0645')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000017)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002260)
,p_plug_name=>unistr('\0627\0644\062F\0648\0644')
,p_static_id=>'r930000000000002260'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.COUNTRY_ID, c.NAME_AR, c.NAME_EN, c.REGION_AR,',
'       (select count(*) from MOINFO_NWS_ENTITIES e where e.COUNTRY_ID = c.COUNTRY_ID) as ENTITIES_COUNT,',
'       (select count(*) from MOINFO_NWS_V_CONTACTS x where x.COUNTRY_ID = c.COUNTRY_ID) as CONTACTS_COUNT',
'  from MOINFO_V_COUNTRIES c',
' where c.IS_ACTIVE = ''Y''',
' order by c.REGION_AR nulls last, c.NAME_AR'))
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
 p_id=>wwv_flow_imp.id(930000000000002261)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000002261
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002262)
,p_db_column_name=>'COUNTRY_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'COUNTRY_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002263)
,p_db_column_name=>'NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062F\0648\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002264)
,p_db_column_name=>'NAME_EN'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002265)
,p_db_column_name=>'REGION_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0625\0642\0644\064A\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002266)
,p_db_column_name=>'ENTITIES_COUNT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002267)
,p_db_column_name=>'CONTACTS_COUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\062C\0647\0627\062A \0627\0644\0627\062A\0635\0627\0644')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002268)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2269'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME_AR:NAME_EN:REGION_AR:ENTITIES_COUNT:CONTACTS_COUNT:'
);
end;
/

prompt --application/pages/delete_11006
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11006);
end;
/

prompt --application/pages/page_11006
begin
wwv_flow_imp_page.create_page(
 p_id=>11006
,p_name=>unistr('\0642\0648\0627\0626\0645 \0627\0644\062F\0644\064A\0644')
,p_alias=>'P11006'
,p_step_title=>unistr('\0642\0648\0627\0626\0645 \0627\0644\062F\0644\064A\0644')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000028)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002270)
,p_plug_name=>unistr('\0642\0648\0627\0626\0645 \0627\0644\062F\0644\064A\0644')
,p_static_id=>'r930000000000002270'
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
' where l.LOOKUP_TYPE in (''NWS_ENTITY_TYPE'', ''NWS_CATEGORY'', ''WORLD_REGION'')',
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
 p_id=>wwv_flow_imp.id(930000000000002271)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:11007:&SESSION.::&DEBUG.:11007:P11007_LOOKUP_ID:#LOOKUP_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000002271
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002272)
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
 p_id=>wwv_flow_imp.id(930000000000002273)
,p_db_column_name=>'TYPE_NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002274)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0642\064A\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002275)
,p_db_column_name=>'NAME_EN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000002276)
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
 p_id=>wwv_flow_imp.id(930000000000002277)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0646\0634\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000002278)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2279'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TYPE_NAME_AR:NAME_AR:NAME_EN:SORT_ORDER:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002280)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002270)
,p_button_name=>'CREATE'
,p_static_id=>'create-2280'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:11007:&SESSION.::&DEBUG.:11007::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_11007
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11007);
end;
/

prompt --application/pages/page_11007
begin
wwv_flow_imp_page.create_page(
 p_id=>11007
,p_name=>unistr('\0642\064A\0645\0629')
,p_alias=>'P11007'
,p_step_title=>unistr('\0642\064A\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000028)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000002281)
,p_plug_name=>unistr('\0642\064A\0645\0629')
,p_static_id=>'r930000000000002281'
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
 p_id=>wwv_flow_imp.id(930000000000002282)
,p_name=>'P11007_LOOKUP_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_source=>'LOOKUP_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000002283)
,p_name=>'P11007_LOOKUP_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_prompt=>unistr('\0627\0644\0642\0627\0626\0645\0629')
,p_source=>'LOOKUP_TYPE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'NWS_LIST_TYPES'
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
 p_id=>wwv_flow_imp.id(930000000000002284)
,p_name=>'P11007_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002281)
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
 p_id=>wwv_flow_imp.id(930000000000002285)
,p_name=>'P11007_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002281)
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
 p_id=>wwv_flow_imp.id(930000000000002286)
,p_name=>'P11007_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002281)
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
 p_id=>wwv_flow_imp.id(930000000000002287)
,p_name=>'P11007_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000002281)
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
 p_id=>wwv_flow_imp.id(930000000000002288)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-2288'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:11006:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002289)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_button_name=>'DELETE'
,p_static_id=>'delete-2289'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0627 \0627\0644\0633\062C\0644\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P11007_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002290)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_button_name=>'SAVE'
,p_static_id=>'save-2290'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P11007_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000002291)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000002281)
,p_button_name=>'CREATE'
,p_static_id=>'create-2291'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621')
,p_button_position=>'CREATE'
,p_button_condition=>'P11007_LOOKUP_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002292)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000002281)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0642\064A\0645\0629')
,p_static_id=>'init-2292'
,p_internal_uid=>930000000000002292
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000002293)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000002281)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0642\064A\0645\0629')
,p_static_id=>'dml-2293'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000002293
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000002294)
,p_branch_name=>'Go To Page 11006'
,p_branch_action=>'f?p=&APP_ID.:11006:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
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
