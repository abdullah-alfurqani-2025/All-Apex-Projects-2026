prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد: صفحات الوحدات (يُشغَّل بعد f145032.sql)
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

prompt --application/pages/delete_01001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1001);
end;
/

prompt --application/pages/page_01001
begin
wwv_flow_imp_page.create_page(
 p_id=>1001
,p_name=>unistr('\0627\0644\0645\0648\0638\0641\0648\0646 - \0627\0644\0645\0648\0627\0631\062F \0627\0644\0628\0634\0631\064A\0629')
,p_alias=>'HR-EMPLOYEES'
,p_step_title=>unistr('\0627\0644\0645\0648\0638\0641\0648\0646 - \0627\0644\0645\0648\0627\0631\062F \0627\0644\0628\0634\0631\064A\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000007)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000415)
,p_plug_name=>unistr('\0627\0644\0645\0648\0638\0641\0648\0646')
,p_static_id=>'r930000000000000415'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.EMPLOYEE_ID, e.EMPLOYEE_NO, e.NAME_AR, e.UNIT_PATH_AR, e.TITLE_NAME_AR,',
'       e.EMP_STATUS_AR, e.MOBILE, e.PHONE_EXT, e.EMAIL, e.HIRE_DATE, e.USERNAME',
'  from MOINFO_HR_V_EMPLOYEES e',
' where e.IS_ACTIVE = ''Y''',
'   and (MOINFO_SEC.CAN_SEE_UNIT(''HR'', e.UNIT_ID) = ''Y'' or e.EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID)'))
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
 p_id=>wwv_flow_imp.id(930000000000000416)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:1002:&SESSION.::&DEBUG.:1002:P1002_EMPLOYEE_ID:#EMPLOYEE_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000416
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000417)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'EMPLOYEE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000418)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000419)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000420)
,p_db_column_name=>'UNIT_PATH_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\062D\062F\0629 \0627\0644\062A\0646\0638\064A\0645\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000421)
,p_db_column_name=>'TITLE_NAME_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0645\0633\0645\0649')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000422)
,p_db_column_name=>'EMP_STATUS_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000423)
,p_db_column_name=>'MOBILE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\062C\0648\0627\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000424)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000425)
,p_db_column_name=>'EMAIL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000426)
,p_db_column_name=>'HIRE_DATE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\062A\0627\0631\064A\062E \0627\0644\062A\0639\064A\064A\0646')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000427)
,p_db_column_name=>'USERNAME'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0633\0645 \0627\0644\0645\0633\062A\062E\062F\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000428)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'429'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_NO:NAME_AR:UNIT_PATH_AR:TITLE_NAME_AR:EMP_STATUS_AR:MOBILE:PHONE_EXT:EMAIL:HIRE_DATE:USERNAME:'
);
end;
/

prompt --application/pages/delete_01002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1002);
end;
/

prompt --application/pages/page_01002
begin
wwv_flow_imp_page.create_page(
 p_id=>1002
,p_name=>unistr('\0627\0644\0628\064A\0627\0646\0627\062A \0627\0644\062A\0641\0635\064A\0644\064A\0629 \0644\0644\0645\0648\0638\0641')
,p_alias=>'HR-EMPLOYEE-DETAILS'
,p_step_title=>unistr('\0627\0644\0628\064A\0627\0646\0627\062A \0627\0644\062A\0641\0635\064A\0644\064A\0629 \0644\0644\0645\0648\0638\0641')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000018)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000430)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-430'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if MOINFO_HR.CAN_VIEW_DETAILS(:P1002_EMPLOYEE_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0628\064A\0627\0646\0627\062A \0647\0630\0627 \0627\0644\0645\0648\0638\0641'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000430
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000431)
,p_process_sequence=>2
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Ensure details row'
,p_static_id=>'ensure-details-row-431'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into MOINFO_HR_EMPLOYEE_DETAILS (EMPLOYEE_ID)',
'select :P1002_EMPLOYEE_ID from dual',
' where :P1002_EMPLOYEE_ID is not null',
'   and not exists (select 1 from MOINFO_HR_EMPLOYEE_DETAILS where EMPLOYEE_ID = :P1002_EMPLOYEE_ID);',
'select NAME_AR || nvl2(EMPLOYEE_NO, '' - '' || EMPLOYEE_NO, '''') into :P1002_EMP_NAME',
'  from MOINFO_EMPLOYEES where EMPLOYEE_ID = :P1002_EMPLOYEE_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000431
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000432)
,p_plug_name=>unistr('\0627\0644\0628\064A\0627\0646\0627\062A \0627\0644\062A\0641\0635\064A\0644\064A\0629')
,p_static_id=>'r930000000000000432'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_HR_EMPLOYEE_DETAILS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000433)
,p_name=>'P1002_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_source=>'EMPLOYEE_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000434)
,p_name=>'P1002_EMP_NAME'
,p_item_sequence=>2
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\0645\0648\0638\0641')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000435)
,p_name=>'P1002_E_EMPLOYEE_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0625\0644\0643\062A\0631\0648\0646\064A')
,p_source=>'E_EMPLOYEE_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000436)
,p_name=>'P1002_EMP_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062D\0627\0644\0629 \0627\0644\0645\0648\0638\0641')
,p_source=>'EMP_STATUS_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_HR_EMP_STATUS'
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
 p_id=>wwv_flow_imp.id(930000000000000437)
,p_name=>'P1002_GRADE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\062F\0631\062C\0629')
,p_source=>'GRADE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000438)
,p_name=>'P1002_POSITION_CODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0631\0645\0632 \0627\0644\0648\0638\064A\0641\0629')
,p_source=>'POSITION_CODE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000439)
,p_name=>'P1002_APPOINTMENT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0646\0648\0639 \0627\0644\062A\0639\064A\064A\0646')
,p_source=>'APPOINTMENT_TYPE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_HR_APPOINTMENT_TYPE'
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
 p_id=>wwv_flow_imp.id(930000000000000440)
,p_name=>'P1002_UPGRADE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\062A\0631\0642\064A\0629')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'UPGRADE_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000441)
,p_name=>'P1002_BUDGET_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\0645\0648\0627\0632\0646\0629')
,p_source=>'BUDGET_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000442)
,p_name=>'P1002_BUDGET_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0633\0645 \0627\0644\0645\0648\0627\0632\0646\0629')
,p_source=>'BUDGET_NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000443)
,p_name=>'P1002_BIRTH_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\0645\064A\0644\0627\062F')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'BIRTH_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000444)
,p_name=>'P1002_BIRTH_PLACE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0645\0643\0627\0646 \0627\0644\0645\064A\0644\0627\062F')
,p_source=>'BIRTH_PLACE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000445)
,p_name=>'P1002_NATIONALITY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\062C\0646\0633\064A\0629')
,p_source=>'NATIONALITY_ID'
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
 p_id=>wwv_flow_imp.id(930000000000000446)
,p_name=>'P1002_MARITAL_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\062D\0627\0644\0629 \0627\0644\0627\062C\062A\0645\0627\0639\064A\0629')
,p_source=>'MARITAL_STATUS_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_HR_MARITAL_STATUS'
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
 p_id=>wwv_flow_imp.id(930000000000000447)
,p_name=>'P1002_RELIGION_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\062F\064A\0627\0646\0629')
,p_source=>'RELIGION_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_HR_RELIGION'
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
 p_id=>wwv_flow_imp.id(930000000000000448)
,p_name=>'P1002_QUALIFICATION_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\0645\0624\0647\0644')
,p_source=>'QUALIFICATION_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_HR_QUALIFICATION'
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
 p_id=>wwv_flow_imp.id(930000000000000449)
,p_name=>'P1002_QUALIFICATION_DETAILS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0641\0627\0635\064A\0644 \0627\0644\0645\0624\0647\0644')
,p_source=>'QUALIFICATION_DETAILS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000450)
,p_name=>'P1002_CIVIL_ID_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\0628\0637\0627\0642\0629 \0627\0644\0645\062F\0646\064A\0629')
,p_source=>'CIVIL_ID_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000451)
,p_name=>'P1002_CIVIL_ID_ISSUE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0625\0635\062F\0627\0631 \0627\0644\0628\0637\0627\0642\0629')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'CIVIL_ID_ISSUE_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000452)
,p_name=>'P1002_CIVIL_ID_EXPIRY_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0646\062A\0647\0627\0621 \0627\0644\0628\0637\0627\0642\0629')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'CIVIL_ID_EXPIRY_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000453)
,p_name=>'P1002_PASSPORT_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\062C\0648\0627\0632')
,p_source=>'PASSPORT_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000454)
,p_name=>'P1002_PASSPORT_ISSUE_PLACE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0645\0643\0627\0646 \0625\0635\062F\0627\0631 \0627\0644\062C\0648\0627\0632')
,p_source=>'PASSPORT_ISSUE_PLACE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000455)
,p_name=>'P1002_PASSPORT_ISSUE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0625\0635\062F\0627\0631 \0627\0644\062C\0648\0627\0632')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'PASSPORT_ISSUE_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000456)
,p_name=>'P1002_PASSPORT_EXPIRY_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0646\062A\0647\0627\0621 \0627\0644\062C\0648\0627\0632')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'PASSPORT_EXPIRY_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000457)
,p_name=>'P1002_ADDRESS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\0639\0646\0648\0627\0646')
,p_source=>'ADDRESS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000458)
,p_name=>'P1002_ADDRESS2'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0639\0646\0648\0627\0646 \0622\062E\0631')
,p_source=>'ADDRESS2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000459)
,p_name=>'P1002_MOBILE2'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062C\0648\0627\0644 \0622\062E\0631')
,p_source=>'MOBILE2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000460)
,p_name=>'P1002_BASIC_SALARY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\0631\0627\062A\0628 \0627\0644\0623\0633\0627\0633\064A')
,p_source=>'BASIC_SALARY'
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
 p_id=>wwv_flow_imp.id(930000000000000461)
,p_name=>'P1002_BANK_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\0628\0646\0643')
,p_source=>'BANK_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_HR_BANK'
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
 p_id=>wwv_flow_imp.id(930000000000000462)
,p_name=>'P1002_BANK_BRANCH'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0627\0644\0641\0631\0639')
,p_source=>'BANK_BRANCH'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000463)
,p_name=>'P1002_BANK_ACCOUNT_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\062D\0633\0627\0628')
,p_source=>'BANK_ACCOUNT_NO'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000464)
,p_name=>'P1002_LEAVE_BALANCE_1'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0631\0635\064A\062F \0627\0644\0625\062C\0627\0632\0629 1')
,p_source=>'LEAVE_BALANCE_1'
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
 p_id=>wwv_flow_imp.id(930000000000000465)
,p_name=>'P1002_LEAVE_BALANCE_2'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\0631\0635\064A\062F \0627\0644\0625\062C\0627\0632\0629 2')
,p_source=>'LEAVE_BALANCE_2'
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
 p_id=>wwv_flow_imp.id(930000000000000466)
,p_name=>'P1002_DATA_VERIFIED_AT'
,p_source_data_type=>'DATE'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \062A\0623\0643\064A\062F \0627\0644\0628\064A\0627\0646\0627\062A')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DATA_VERIFIED_AT'
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
 p_id=>wwv_flow_imp.id(930000000000000467)
,p_name=>'P1002_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000432)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000468)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-468'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:1001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000469)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000432)
,p_button_name=>'SAVE'
,p_static_id=>'save-469'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000470)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000432)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Employee details'
,p_static_id=>'init-470'
,p_internal_uid=>930000000000000470
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000471)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000432)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Employee details'
,p_static_id=>'dml-471'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000471
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000472)
,p_branch_name=>'Go To Page 1001'
,p_branch_action=>'f?p=&APP_ID.:1001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_01003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1003);
end;
/

prompt --application/pages/page_01003
begin
wwv_flow_imp_page.create_page(
 p_id=>1003
,p_name=>unistr('\062F\0644\064A\0644 \0627\0644\0647\0648\0627\062A\0641')
,p_alias=>'DIRECTORY'
,p_step_title=>unistr('\062F\0644\064A\0644 \0627\0644\0647\0648\0627\062A\0641')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000473)
,p_plug_name=>unistr('\062F\0644\064A\0644 \0627\0644\0647\0648\0627\062A\0641')
,p_static_id=>'r930000000000000473'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select EMPLOYEE_ID, NAME_AR, UNIT_PATH_AR, TITLE_NAME_AR, PHONE_EXT, PHONE_EXT2, MOBILE,',
'       TEL1, TEL2, FAX1, EMAIL, OFFICE_DEVICE',
'  from MOINFO_HR_V_DIRECTORY'))
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
 p_id=>wwv_flow_imp.id(930000000000000474)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:1004:&SESSION.::&DEBUG.:1004:P1004_EMPLOYEE_ID:#EMPLOYEE_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000474
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000475)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'EMPLOYEE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000476)
,p_db_column_name=>'NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000477)
,p_db_column_name=>'UNIT_PATH_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0648\062D\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000478)
,p_db_column_name=>'TITLE_NAME_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0633\0645\0649')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000479)
,p_db_column_name=>'PHONE_EXT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062A\062D\0648\064A\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000480)
,p_db_column_name=>'PHONE_EXT2'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\062A\062D\0648\064A\0644\0629 2')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000481)
,p_db_column_name=>'MOBILE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\062C\0648\0627\0644')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000482)
,p_db_column_name=>'TEL1'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0647\0627\062A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000483)
,p_db_column_name=>'TEL2'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0647\0627\062A\0641 2')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000484)
,p_db_column_name=>'FAX1'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0641\0627\0643\0633')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000485)
,p_db_column_name=>'EMAIL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0628\0631\064A\062F')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000486)
,p_db_column_name=>'OFFICE_DEVICE'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\0632')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000487)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'488'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME_AR:UNIT_PATH_AR:TITLE_NAME_AR:PHONE_EXT:PHONE_EXT2:MOBILE:TEL1:TEL2:FAX1:EMAIL:OFFICE_DEVICE:'
);
end;
/

prompt --application/pages/delete_01004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1004);
end;
/

prompt --application/pages/page_01004
begin
wwv_flow_imp_page.create_page(
 p_id=>1004
,p_name=>unistr('\0628\064A\0627\0646\0627\062A \0627\0644\062F\0644\064A\0644')
,p_alias=>'DIRECTORY-ENTRY'
,p_step_title=>unistr('\0628\064A\0627\0646\0627\062A \0627\0644\062F\0644\064A\0644')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000018)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000489)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-489'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if MOINFO_HR.CAN_VIEW_DETAILS(:P1004_EMPLOYEE_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0645\0648\0638\0641'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000489
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000490)
,p_process_sequence=>2
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Ensure directory row'
,p_static_id=>'ensure-directory-row-490'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into MOINFO_HR_DIRECTORY (EMPLOYEE_ID)',
'select :P1004_EMPLOYEE_ID from dual',
' where :P1004_EMPLOYEE_ID is not null',
'   and not exists (select 1 from MOINFO_HR_DIRECTORY where EMPLOYEE_ID = :P1004_EMPLOYEE_ID);',
'select NAME_AR into :P1004_EMP_NAME from MOINFO_EMPLOYEES where EMPLOYEE_ID = :P1004_EMPLOYEE_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000490
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000491)
,p_plug_name=>unistr('\0628\064A\0627\0646\0627\062A \0627\0644\062F\0644\064A\0644')
,p_static_id=>'r930000000000000491'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_HR_DIRECTORY'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000492)
,p_name=>'P1004_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_source=>'EMPLOYEE_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000493)
,p_name=>'P1004_EMP_NAME'
,p_item_sequence=>2
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\0627\0644\0645\0648\0638\0641')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000494)
,p_name=>'P1004_PHONE_EXT2'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\062A\062D\0648\064A\0644\0629 2')
,p_source=>'PHONE_EXT2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000495)
,p_name=>'P1004_TEL1'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\0647\0627\062A\0641')
,p_source=>'TEL1'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000496)
,p_name=>'P1004_TEL2'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\0647\0627\062A\0641 2')
,p_source=>'TEL2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000497)
,p_name=>'P1004_FAX1'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\0641\0627\0643\0633')
,p_source=>'FAX1'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000498)
,p_name=>'P1004_FAX2'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\0641\0627\0643\0633 2')
,p_source=>'FAX2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000499)
,p_name=>'P1004_OFFICE_DEVICE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\0627\0644\062C\0647\0627\0632')
,p_source=>'OFFICE_DEVICE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000500)
,p_name=>'P1004_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'REMARKS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(930000000000000501)
,p_name=>'P1004_SHOW_IN_DIRECTORY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_prompt=>unistr('\064A\0638\0647\0631 \0641\064A \0627\0644\062F\0644\064A\0644')
,p_source=>'SHOW_IN_DIRECTORY'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000502)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-502'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0631\062C\0648\0639')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:1003:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000503)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000491)
,p_button_name=>'SAVE'
,p_static_id=>'save-503'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000504)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000491)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Directory'
,p_static_id=>'init-504'
,p_internal_uid=>930000000000000504
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000505)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000491)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Directory'
,p_static_id=>'dml-505'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000505
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000506)
,p_branch_name=>'Go To Page 1003'
,p_branch_action=>'f?p=&APP_ID.:1003:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_01005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1005);
end;
/

prompt --application/pages/page_01005
begin
wwv_flow_imp_page.create_page(
 p_id=>1005
,p_name=>unistr('\0627\0644\0628\064A\0627\0646\0627\062A \0627\0644\0646\0627\0642\0635\0629')
,p_alias=>'HR-INCOMPLETE'
,p_step_title=>unistr('\0627\0644\0628\064A\0627\0646\0627\062A \0627\0644\0646\0627\0642\0635\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000018)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000507)
,p_plug_name=>unistr('\0627\0644\0628\064A\0627\0646\0627\062A \0627\0644\0646\0627\0642\0635\0629')
,p_static_id=>'r930000000000000507'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.EMPLOYEE_ID, i.EMPLOYEE_NO, i.NAME_AR, i.UNIT_PATH_AR, i.MISSING_FIELDS',
'  from MOINFO_HR_V_INCOMPLETE i join MOINFO_EMPLOYEES e on e.EMPLOYEE_ID = i.EMPLOYEE_ID',
' where MOINFO_SEC.CAN_SEE_UNIT(''HR'', e.UNIT_ID) = ''Y'''))
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
 p_id=>wwv_flow_imp.id(930000000000000508)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:1002:&SESSION.::&DEBUG.:1002:P1002_EMPLOYEE_ID:#EMPLOYEE_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000508
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000509)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'EMPLOYEE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000510)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000511)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000512)
,p_db_column_name=>'UNIT_PATH_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\062D\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000513)
,p_db_column_name=>'MISSING_FIELDS'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062D\0642\0648\0644 \0627\0644\0646\0627\0642\0635\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000514)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'515'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_NO:NAME_AR:UNIT_PATH_AR:MISSING_FIELDS:'
);
end;
/

prompt --application/pages/delete_01006
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1006);
end;
/

prompt --application/pages/page_01006
begin
wwv_flow_imp_page.create_page(
 p_id=>1006
,p_name=>unistr('\0627\0644\0648\062B\0627\0626\0642 \0627\0644\0645\0646\062A\0647\064A\0629 \0648\0627\0644\0642\0631\064A\0628\0629 \0645\0646 \0627\0644\0627\0646\062A\0647\0627\0621')
,p_alias=>'HR-EXPIRING'
,p_step_title=>unistr('\0627\0644\0648\062B\0627\0626\0642 \0627\0644\0645\0646\062A\0647\064A\0629 \0648\0627\0644\0642\0631\064A\0628\0629 \0645\0646 \0627\0644\0627\0646\062A\0647\0627\0621')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000018)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000516)
,p_plug_name=>unistr('\0627\0644\0648\062B\0627\0626\0642')
,p_static_id=>'r930000000000000516'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.EMPLOYEE_ID, x.EMPLOYEE_NO, x.NAME_AR, x.UNIT_PATH_AR, x.DOC_TYPE_AR, x.DOC_NO,',
'       x.EXPIRY_DATE, x.DAYS_LEFT,',
unistr('       case when x.DAYS_LEFT < 0 then ''\0645\0646\062A\0647\064A\0629'' else ''\0642\0631\064A\0628\0629 \0645\0646 \0627\0644\0627\0646\062A\0647\0627\0621'' end as STATE_AR'),
'  from MOINFO_HR_V_EXPIRING_DOCS x join MOINFO_EMPLOYEES e on e.EMPLOYEE_ID = x.EMPLOYEE_ID',
' where MOINFO_SEC.CAN_SEE_UNIT(''HR'', e.UNIT_ID) = ''Y''',
' order by x.EXPIRY_DATE'))
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
 p_id=>wwv_flow_imp.id(930000000000000517)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:1002:&SESSION.::&DEBUG.:1002:P1002_EMPLOYEE_ID:#EMPLOYEE_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000517
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000518)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'EMPLOYEE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000519)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000520)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000521)
,p_db_column_name=>'UNIT_PATH_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\062D\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000522)
,p_db_column_name=>'DOC_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\062B\064A\0642\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000523)
,p_db_column_name=>'DOC_NO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0631\0642\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000524)
,p_db_column_name=>'EXPIRY_DATE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\062A\0627\0631\064A\062E \0627\0644\0627\0646\062A\0647\0627\0621')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000525)
,p_db_column_name=>'DAYS_LEFT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0623\064A\0627\0645 \0627\0644\0645\062A\0628\0642\064A\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000526)
,p_db_column_name=>'STATE_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000527)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'528'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_NO:NAME_AR:UNIT_PATH_AR:DOC_TYPE_AR:DOC_NO:EXPIRY_DATE:DAYS_LEFT:STATE_AR:'
);
end;
/

prompt --application/pages/delete_01007
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1007);
end;
/

prompt --application/pages/page_01007
begin
wwv_flow_imp_page.create_page(
 p_id=>1007
,p_name=>unistr('\0633\062C\0644 \0627\0644\0628\0635\0645\0629')
,p_alias=>'HR-ATTENDANCE'
,p_step_title=>unistr('\0633\062C\0644 \0627\0644\0628\0635\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000018)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000529)
,p_plug_name=>unistr('\0633\062C\0644 \0627\0644\0628\0635\0645\0629')
,p_static_id=>'r930000000000000529'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.LOG_ID, a.ATTENDANCE_PIN, a.NAME_AR,',
'       to_char(a.CHECK_TIME, ''DD/MM/YYYY HH24:MI'') as CHECK_TIME_TXT, a.CHECK_DATE, a.CHECK_TYPE, a.DEVICE_SN, a.LOCATION',
'  from MOINFO_HR_V_ATTENDANCE a',
' where a.UNIT_ID is null or MOINFO_SEC.CAN_SEE_UNIT(''HR'', a.UNIT_ID) = ''Y''',
' order by a.CHECK_TIME desc'))
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
 p_id=>wwv_flow_imp.id(930000000000000530)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000530
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000531)
,p_db_column_name=>'LOG_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'LOG_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000532)
,p_db_column_name=>'ATTENDANCE_PIN'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000533)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0627\0633\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000534)
,p_db_column_name=>'CHECK_TIME_TXT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\0642\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000535)
,p_db_column_name=>'CHECK_DATE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000536)
,p_db_column_name=>'CHECK_TYPE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000537)
,p_db_column_name=>'DEVICE_SN'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\062C\0647\0627\0632')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000538)
,p_db_column_name=>'LOCATION'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0645\0648\0642\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000539)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'540'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ATTENDANCE_PIN:NAME_AR:CHECK_TIME_TXT:CHECK_DATE:CHECK_TYPE:DEVICE_SN:LOCATION:'
);
end;
/

prompt --application/pages/delete_01010
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1010);
end;
/

prompt --application/pages/page_01010
begin
wwv_flow_imp_page.create_page(
 p_id=>1010
,p_name=>unistr('\0628\064A\0627\0646\0627\062A\064A')
,p_alias=>'MY-DATA'
,p_step_title=>unistr('\0628\064A\0627\0646\0627\062A\064A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000023)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000541)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load my employee'
,p_static_id=>'load-my-employee-541'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P1010_EMPLOYEE_ID := MOINFO_HR.MY_EMPLOYEE_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000541
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000542)
,p_plug_name=>unistr('\0628\064A\0627\0646\0627\062A\064A')
,p_static_id=>'r930000000000000542'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_HR_V_EMPLOYEE_DETAILS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000543)
,p_name=>'P1010_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_source=>'EMPLOYEE_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000544)
,p_name=>'P1010_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0627\0633\0645')
,p_source=>'NAME_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000545)
,p_name=>'P1010_EMPLOYEE_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_source=>'EMPLOYEE_NO'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000546)
,p_name=>'P1010_UNIT_PATH_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0648\062D\062F\0629 \0627\0644\062A\0646\0638\064A\0645\064A\0629')
,p_source=>'UNIT_PATH_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000547)
,p_name=>'P1010_TITLE_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0645\0633\0645\0649')
,p_source=>'TITLE_NAME_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000548)
,p_name=>'P1010_EMP_STATUS_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\062D\0627\0644\0629')
,p_source=>'EMP_STATUS_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000549)
,p_name=>'P1010_GRADE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\062F\0631\062C\0629')
,p_source=>'GRADE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000550)
,p_name=>'P1010_HIRE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\062A\0639\064A\064A\0646')
,p_source=>'HIRE_DATE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000551)
,p_name=>'P1010_APPOINTMENT_TYPE_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0646\0648\0639 \0627\0644\062A\0639\064A\064A\0646')
,p_source=>'APPOINTMENT_TYPE_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000552)
,p_name=>'P1010_MOBILE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\062C\0648\0627\0644')
,p_source=>'MOBILE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000553)
,p_name=>'P1010_EMAIL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0628\0631\064A\062F')
,p_source=>'EMAIL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000554)
,p_name=>'P1010_CIVIL_ID_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0628\0637\0627\0642\0629 \0627\0644\0645\062F\0646\064A\0629')
,p_source=>'CIVIL_ID_NO'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000555)
,p_name=>'P1010_CIVIL_ID_EXPIRY_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0646\062A\0647\0627\0621 \0627\0644\0628\0637\0627\0642\0629')
,p_source=>'CIVIL_ID_EXPIRY_DATE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000556)
,p_name=>'P1010_PASSPORT_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\062C\0648\0627\0632')
,p_source=>'PASSPORT_NO'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000557)
,p_name=>'P1010_PASSPORT_EXPIRY_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0646\062A\0647\0627\0621 \0627\0644\062C\0648\0627\0632')
,p_source=>'PASSPORT_EXPIRY_DATE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000558)
,p_name=>'P1010_QUALIFICATION_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0645\0624\0647\0644')
,p_source=>'QUALIFICATION_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000559)
,p_name=>'P1010_NATIONALITY_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\062C\0646\0633\064A\0629')
,p_source=>'NATIONALITY_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000560)
,p_name=>'P1010_BANK_AR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0627\0644\0628\0646\0643')
,p_source=>'BANK_AR'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000561)
,p_name=>'P1010_BANK_ACCOUNT_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\062D\0633\0627\0628')
,p_source=>'BANK_ACCOUNT_NO'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000562)
,p_name=>'P1010_LEAVE_BALANCE_1'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0631\0635\064A\062F \0627\0644\0625\062C\0627\0632\0629 1')
,p_source=>'LEAVE_BALANCE_1'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
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
 p_id=>wwv_flow_imp.id(930000000000000563)
,p_name=>'P1010_LEAVE_BALANCE_2'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0631\0635\064A\062F \0627\0644\0625\062C\0627\0632\0629 2')
,p_source=>'LEAVE_BALANCE_2'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000564)
,p_name=>'P1010_DATA_VERIFIED_AT'
,p_source_data_type=>'DATE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_prompt=>unistr('\0622\062E\0631 \062A\0623\0643\064A\062F \0644\0644\0628\064A\0627\0646\0627\062A')
,p_source=>'DATA_VERIFIED_AT'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000565)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000542)
,p_button_name=>'CONFIRM_DATA'
,p_static_id=>'confirm-data-565'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0623\0624\0643\062F \0635\062D\0629 \0628\064A\0627\0646\0627\062A\064A')
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000566)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Confirm data'
,p_static_id=>'confirm-data-566'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'merge into MOINFO_HR_EMPLOYEE_DETAILS d',
'using (select :P1010_EMPLOYEE_ID as EMPLOYEE_ID from dual) s',
'   on (d.EMPLOYEE_ID = s.EMPLOYEE_ID)',
' when matched then update set d.DATA_VERIFIED_AT = trunc(sysdate)',
' when not matched then insert (EMPLOYEE_ID, DATA_VERIFIED_AT) values (s.EMPLOYEE_ID, trunc(sysdate));'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000000565)
,p_process_success_message=>unistr('\0634\0643\0631\064B\0627\060C \062A\0645 \062A\0633\062C\064A\0644 \062A\0623\0643\064A\062F \0628\064A\0627\0646\0627\062A\0643. \0644\062A\0635\062D\064A\062D \0623\064A \0628\064A\0627\0646 \062A\0648\0627\0635\0644 \0645\0639 \0627\0644\0645\0648\0627\0631\062F \0627\0644\0628\0634\0631\064A\0629.')
,p_internal_uid=>930000000000000566
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000567)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000542)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize my data'
,p_static_id=>'init-567'
,p_internal_uid=>930000000000000567
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000568)
,p_branch_name=>'Go To Page 1010'
,p_branch_action=>'f?p=&APP_ID.:1010:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_02001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2001);
end;
/

prompt --application/pages/page_02001
begin
wwv_flow_imp_page.create_page(
 p_id=>2001
,p_name=>unistr('\0627\0644\0645\0634\0627\0631\0643\0627\062A')
,p_alias=>'EVENTS'
,p_step_title=>unistr('\0627\0644\0645\0634\0627\0631\0643\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000008)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000569)
,p_plug_name=>unistr('\0627\0644\0645\0634\0627\0631\0643\0627\062A')
,p_static_id=>'r930000000000000569'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select v.EVENT_ID, v.EMPLOYEE_NO, v.EMPLOYEE_NAME_AR, v.UNIT_PATH_AR, v.EVENT_TYPE_AR, v.TITLE,',
'       v.PLACE, v.COUNTRY_AR, v.START_DATE, v.END_DATE, v.DURATION_DAYS, v.EVENT_YEAR, v.LETTER_NO, v.LETTER_DATE,',
unistr('       case v.IS_ACTIVE when ''Y'' then ''\0646\0639\0645'' else ''\0644\0627'' end as IS_ACTIVE_AR'),
'  from MOINFO_EVT_V_EVENTS v',
' where MOINFO_EVT.CAN_SEE(v.EMPLOYEE_ID) = ''Y'''))
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
 p_id=>wwv_flow_imp.id(930000000000000570)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:2002:&SESSION.::&DEBUG.:2002:P2002_EVENT_ID:#EVENT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000570
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000571)
,p_db_column_name=>'EVENT_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'EVENT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000572)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000573)
,p_db_column_name=>'EMPLOYEE_NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0648\0638\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000574)
,p_db_column_name=>'UNIT_PATH_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\062D\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000575)
,p_db_column_name=>'EVENT_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000576)
,p_db_column_name=>'TITLE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\0634\0627\0631\0643\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000577)
,p_db_column_name=>'PLACE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0643\0627\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000578)
,p_db_column_name=>'COUNTRY_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\062F\0648\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000579)
,p_db_column_name=>'START_DATE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0645\0646')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000580)
,p_db_column_name=>'END_DATE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0625\0644\0649')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000581)
,p_db_column_name=>'DURATION_DAYS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0623\064A\0627\0645')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000582)
,p_db_column_name=>'EVENT_YEAR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0633\0646\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000583)
,p_db_column_name=>'LETTER_NO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0631\0642\0645 \0627\0644\062E\0637\0627\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000584)
,p_db_column_name=>'LETTER_DATE'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('\062A\0627\0631\064A\062E \0627\0644\062E\0637\0627\0628')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000585)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0646\0634\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000586)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'587'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_NO:EMPLOYEE_NAME_AR:UNIT_PATH_AR:EVENT_TYPE_AR:TITLE:PLACE:COUNTRY_AR:START_DATE:END_DATE:DURATION_DAYS:EVENT_YEAR:LETTER_NO:LETTER_DATE:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000588)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000569)
,p_button_name=>'CREATE'
,p_static_id=>'create-588'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629 \0645\0634\0627\0631\0643\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:2002:&SESSION.::&DEBUG.:2002::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_02002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2002);
end;
/

prompt --application/pages/page_02002
begin
wwv_flow_imp_page.create_page(
 p_id=>2002
,p_name=>unistr('\0645\0634\0627\0631\0643\0629')
,p_alias=>'EVENT'
,p_step_title=>unistr('\0645\0634\0627\0631\0643\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000008)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000589)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-589'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P2002_EVENT_ID is not null and MOINFO_EVT.CAN_SEE((select EMPLOYEE_ID from MOINFO_EVT_EVENTS where EVENT_ID = :P2002_EVENT_ID)) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0647 \0627\0644\0645\0634\0627\0631\0643\0629'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000589
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000590)
,p_plug_name=>unistr('\0645\0634\0627\0631\0643\0629')
,p_static_id=>'r930000000000000590'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_EVT_EVENTS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000591)
,p_name=>'P2002_EVENT_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_source=>'EVENT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000592)
,p_name=>'P2002_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_default=>'MOINFO_HR.MY_EMPLOYEE_ID'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\0645\0648\0638\0641')
,p_source=>'EMPLOYEE_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EVT_EMPLOYEES'
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
 p_id=>wwv_flow_imp.id(930000000000000593)
,p_name=>'P2002_EVENT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0646\0648\0639 \0627\0644\0645\0634\0627\0631\0643\0629')
,p_source=>'EVENT_TYPE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_EVT_TYPE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0627\062E\062A\0631 -')
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
 p_id=>wwv_flow_imp.id(930000000000000594)
,p_name=>'P2002_TITLE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0639\0646\0648\0627\0646 \0627\0644\0645\0634\0627\0631\0643\0629')
,p_source=>'TITLE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
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
 p_id=>wwv_flow_imp.id(930000000000000595)
,p_name=>'P2002_PLACE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0627\0644\0645\0643\0627\0646')
,p_source=>'PLACE'
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
 p_id=>wwv_flow_imp.id(930000000000000596)
,p_name=>'P2002_COUNTRY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0627\0644\062F\0648\0644\0629')
,p_source=>'COUNTRY_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'COUNTRIES'
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
 p_id=>wwv_flow_imp.id(930000000000000597)
,p_name=>'P2002_START_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0645\0646 \062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'START_DATE'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1612549789555753698
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
 p_id=>wwv_flow_imp.id(930000000000000598)
,p_name=>'P2002_END_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0625\0644\0649 \062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'END_DATE'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1612549789555753698
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
 p_id=>wwv_flow_imp.id(930000000000000599)
,p_name=>'P2002_LETTER_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0631\0642\0645 \0627\0644\062E\0637\0627\0628')
,p_source=>'LETTER_NO'
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
 p_id=>wwv_flow_imp.id(930000000000000600)
,p_name=>'P2002_LETTER_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\062E\0637\0627\0628')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'LETTER_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000601)
,p_name=>'P2002_COMMENTS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_source=>'COMMENTS'
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
 p_id=>wwv_flow_imp.id(930000000000000602)
,p_name=>'P2002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000590)
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
 p_id=>wwv_flow_imp.id(930000000000000603)
,p_validation_name=>'Employee in scope'
,p_static_id=>'employee-in-scope-603'
,p_validation_sequence=>10
,p_validation=>'MOINFO_EVT.CAN_SEE(:P2002_EMPLOYEE_ID) = ''Y'''
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\0644\0627 \064A\0645\0643\0646\0643 \062A\0633\062C\064A\0644 \0645\0634\0627\0631\0643\0629 \0644\0647\0630\0627 \0627\0644\0645\0648\0638\0641')
,p_associated_item=>wwv_flow_imp.id(930000000000000592)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000000604)
,p_validation_name=>'Dates order'
,p_static_id=>'dates-order-604'
,p_validation_sequence=>20
,p_validation=>'to_date(:P2002_END_DATE, ''DD/MM/YYYY'') >= to_date(:P2002_START_DATE, ''DD/MM/YYYY'')'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\062A\0627\0631\064A\062E \0627\0644\0646\0647\0627\064A\0629 \064A\062C\0628 \0623\0646 \064A\0643\0648\0646 \0628\0639\062F \062A\0627\0631\064A\062E \0627\0644\0628\062F\0627\064A\0629 \0623\0648 \0645\0633\0627\0648\064A\064B\0627 \0644\0647')
,p_associated_item=>wwv_flow_imp.id(930000000000000598)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000000605)
,p_validation_name=>'No overlap'
,p_static_id=>'no-overlap-605'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :REQUEST = ''DELETE'' or :P2002_IS_ACTIVE = ''N'' then return null; end if;',
'return MOINFO_EVT.OVERLAP_MESSAGE(',
'    :P2002_EMPLOYEE_ID,',
'    to_date(:P2002_START_DATE, ''DD/MM/YYYY''),',
'    to_date(:P2002_END_DATE, ''DD/MM/YYYY''),',
'    :P2002_EVENT_ID);'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_imp.id(930000000000000597)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000606)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-606'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:2001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000607)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_button_name=>'DELETE'
,p_static_id=>'delete-607'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0647 \0627\0644\0645\0634\0627\0631\0643\0629\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P2002_EVENT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000608)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_button_name=>'SAVE'
,p_static_id=>'save-608'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P2002_EVENT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000609)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000000590)
,p_button_name=>'CREATE'
,p_static_id=>'create-609'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>'P2002_EVENT_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000610)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000590)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Event'
,p_static_id=>'init-610'
,p_internal_uid=>930000000000000610
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000611)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000590)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Event'
,p_static_id=>'dml-611'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000611
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000612)
,p_branch_name=>'Go To Page 2001'
,p_branch_action=>'f?p=&APP_ID.:2001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_02003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2003);
end;
/

prompt --application/pages/page_02003
begin
wwv_flow_imp_page.create_page(
 p_id=>2003
,p_name=>unistr('\0627\0644\0645\0634\0627\0631\0643\0627\062A \0627\0644\0645\062A\062F\0627\062E\0644\0629')
,p_alias=>'EVENT-OVERLAPS'
,p_step_title=>unistr('\0627\0644\0645\0634\0627\0631\0643\0627\062A \0627\0644\0645\062A\062F\0627\062E\0644\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000019)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000613)
,p_plug_name=>unistr('\0627\0644\0645\0634\0627\0631\0643\0627\062A \0627\0644\0645\062A\062F\0627\062E\0644\0629')
,p_static_id=>'r930000000000000613'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.EMPLOYEE_ID, o.EMPLOYEE_NO, o.EMPLOYEE_NAME_AR, o.TITLE_1, o.START_DATE_1, o.END_DATE_1,',
'       o.TITLE_2, o.START_DATE_2, o.END_DATE_2, o.OVERLAP_DAYS',
'  from MOINFO_EVT_V_OVERLAPS o',
' where MOINFO_EVT.CAN_SEE(o.EMPLOYEE_ID) = ''Y'''))
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
 p_id=>wwv_flow_imp.id(930000000000000614)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000614
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000615)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'EMPLOYEE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000616)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000617)
,p_db_column_name=>'EMPLOYEE_NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0648\0638\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000618)
,p_db_column_name=>'TITLE_1'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0634\0627\0631\0643\0629 \0627\0644\0623\0648\0644\0649')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000619)
,p_db_column_name=>'START_DATE_1'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0645\0646')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000620)
,p_db_column_name=>'END_DATE_1'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0625\0644\0649')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000621)
,p_db_column_name=>'TITLE_2'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0645\0634\0627\0631\0643\0629 \0627\0644\062B\0627\0646\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000622)
,p_db_column_name=>'START_DATE_2'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0645\0646')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000623)
,p_db_column_name=>'END_DATE_2'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0625\0644\0649')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000624)
,p_db_column_name=>'OVERLAP_DAYS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0623\064A\0627\0645 \0627\0644\062A\062F\0627\062E\0644')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000625)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'626'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_NO:EMPLOYEE_NAME_AR:TITLE_1:START_DATE_1:END_DATE_1:TITLE_2:START_DATE_2:END_DATE_2:OVERLAP_DAYS:'
);
end;
/

prompt --application/pages/delete_02004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2004);
end;
/

prompt --application/pages/page_02004
begin
wwv_flow_imp_page.create_page(
 p_id=>2004
,p_name=>unistr('\0645\0644\062E\0635 \0627\0644\0645\0648\0638\0641\064A\0646')
,p_alias=>'EVENT-SUMMARY'
,p_step_title=>unistr('\0645\0644\062E\0635 \0627\0644\0645\0648\0638\0641\064A\0646')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000008)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000627)
,p_plug_name=>unistr('\0645\0644\062E\0635 \0633\0646\0648\064A \0644\0643\0644 \0645\0648\0638\0641')
,p_static_id=>'r930000000000000627'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.EMPLOYEE_ID, s.EMPLOYEE_NO, s.EMPLOYEE_NAME_AR, s.UNIT_PATH_AR, s.EVENT_YEAR,',
'       s.EVENTS_COUNT, s.TOTAL_DAYS',
'  from MOINFO_EVT_V_EMPLOYEE_SUMMARY s',
' where MOINFO_EVT.CAN_SEE(s.EMPLOYEE_ID) = ''Y''',
' order by s.EVENT_YEAR desc, s.TOTAL_DAYS desc'))
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
 p_id=>wwv_flow_imp.id(930000000000000628)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000628
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000629)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'EMPLOYEE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000630)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000631)
,p_db_column_name=>'EMPLOYEE_NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0648\0638\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000632)
,p_db_column_name=>'UNIT_PATH_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0648\062D\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000633)
,p_db_column_name=>'EVENT_YEAR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0633\0646\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000634)
,p_db_column_name=>'EVENTS_COUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0639\062F\062F \0627\0644\0645\0634\0627\0631\0643\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000635)
,p_db_column_name=>'TOTAL_DAYS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0625\062C\0645\0627\0644\064A \0627\0644\0623\064A\0627\0645')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000636)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'637'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_NO:EMPLOYEE_NAME_AR:UNIT_PATH_AR:EVENT_YEAR:EVENTS_COUNT:TOTAL_DAYS:'
);
end;
/

prompt --application/pages/delete_03001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3001);
end;
/

prompt --application/pages/page_03001
begin
wwv_flow_imp_page.create_page(
 p_id=>3001
,p_name=>unistr('\0627\0644\062A\063A\0637\064A\0627\062A')
,p_alias=>'COVERAGES'
,p_step_title=>unistr('\0627\0644\062A\063A\0637\064A\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000009)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000638)
,p_plug_name=>unistr('\0627\0644\062A\063A\0637\064A\0627\062A')
,p_static_id=>'r930000000000000638'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.COVERAGE_ID, c.COVERAGE_DATE, c.COVERAGE_YEAR, c.EVENT_AR, c.EVENT_TYPE_AR, c.GOVERNORATE_AR,',
'       c.WILAYAT_AR, c.PLACE_NAME, c.CHANNEL_AR, c.PROGRAM_AR, c.PHOTOGRAPHERS, c.EDITORS, c.REPORTERS, c.REMARKS',
'  from MOINFO_MED_V_COVERAGES c',
' where c.IS_ACTIVE = ''Y''',
' order by c.COVERAGE_DATE desc'))
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
 p_id=>wwv_flow_imp.id(930000000000000639)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:3002:&SESSION.::&DEBUG.:3002:P3002_COVERAGE_ID:#COVERAGE_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000639
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000640)
,p_db_column_name=>'COVERAGE_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'COVERAGE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000641)
,p_db_column_name=>'COVERAGE_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000642)
,p_db_column_name=>'COVERAGE_YEAR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0633\0646\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000643)
,p_db_column_name=>'EVENT_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0646\0627\0633\0628\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000644)
,p_db_column_name=>'EVENT_TYPE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0646\0648\0639 \0627\0644\062A\063A\0637\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000645)
,p_db_column_name=>'GOVERNORATE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0645\062D\0627\0641\0638\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000646)
,p_db_column_name=>'WILAYAT_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\0648\0644\0627\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000647)
,p_db_column_name=>'PLACE_NAME'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0645\0643\0627\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000648)
,p_db_column_name=>'CHANNEL_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0627\0644\0642\0646\0627\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000649)
,p_db_column_name=>'PROGRAM_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0627\0644\0628\0631\0646\0627\0645\062C')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000650)
,p_db_column_name=>'PHOTOGRAPHERS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0645\0635\0648\0631\0648\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000651)
,p_db_column_name=>'EDITORS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0645\0648\0646\062A\0627\062C')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000652)
,p_db_column_name=>'REPORTERS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0627\0644\0645\0631\0627\0633\0644\0648\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000653)
,p_db_column_name=>'REMARKS'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000654)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'655'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COVERAGE_DATE:COVERAGE_YEAR:EVENT_AR:EVENT_TYPE_AR:GOVERNORATE_AR:WILAYAT_AR:PLACE_NAME:CHANNEL_AR:PROGRAM_AR:PHOTOGRAPHERS:EDITORS:REPORTERS:REMARKS:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000656)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000638)
,p_button_name=>'CREATE'
,p_static_id=>'create-656'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629 \062A\063A\0637\064A\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:3002:&SESSION.::&DEBUG.:3002::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_03002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3002);
end;
/

prompt --application/pages/page_03002
begin
wwv_flow_imp_page.create_page(
 p_id=>3002
,p_name=>unistr('\062A\063A\0637\064A\0629')
,p_alias=>'COVERAGE'
,p_step_title=>unistr('\062A\063A\0637\064A\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000009)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000657)
,p_plug_name=>unistr('\062A\063A\0637\064A\0629')
,p_static_id=>'r930000000000000657'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_MED_COVERAGES'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000658)
,p_name=>'P3002_COVERAGE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_source=>'COVERAGE_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000659)
,p_name=>'P3002_COVERAGE_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_prompt=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'COVERAGE_DATE'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1612549789555753698
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
 p_id=>wwv_flow_imp.id(930000000000000660)
,p_name=>'P3002_EVENT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_prompt=>unistr('\0627\0644\0645\0646\0627\0633\0628\0629')
,p_source=>'EVENT_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_MED_EVENT'
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
 p_id=>wwv_flow_imp.id(930000000000000661)
,p_name=>'P3002_EVENT_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_prompt=>unistr('\0646\0648\0639 \0627\0644\062A\063A\0637\064A\0629')
,p_source=>'EVENT_TYPE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_MED_EVENT_TYPE'
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
 p_id=>wwv_flow_imp.id(930000000000000662)
,p_name=>'P3002_WILAYAT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_prompt=>unistr('\0627\0644\0648\0644\0627\064A\0629')
,p_source=>'WILAYAT_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'WILAYATS'
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
 p_id=>wwv_flow_imp.id(930000000000000663)
,p_name=>'P3002_PLACE_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_prompt=>unistr('\0627\0644\0645\0643\0627\0646')
,p_source=>'PLACE_NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>250
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
 p_id=>wwv_flow_imp.id(930000000000000664)
,p_name=>'P3002_CHANNEL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_prompt=>unistr('\0627\0644\0642\0646\0627\0629')
,p_source=>'CHANNEL_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'MED_CHANNELS'
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
 p_id=>wwv_flow_imp.id(930000000000000665)
,p_name=>'P3002_PROGRAM_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_prompt=>unistr('\0627\0644\0628\0631\0646\0627\0645\062C')
,p_source=>'PROGRAM_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'MED_PROGRAMS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_lov_cascade_parent_items=>'P3002_CHANNEL_ID'
,p_ajax_optimize_refresh=>'Y'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000666)
,p_name=>'P3002_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
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
 p_id=>wwv_flow_imp.id(930000000000000667)
,p_name=>'P3002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000657)
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
 p_id=>wwv_flow_imp.id(930000000000000668)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-668'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:3001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000669)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_button_name=>'DELETE'
,p_static_id=>'delete-669'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0647 \0627\0644\062A\063A\0637\064A\0629 \0648\0641\0631\064A\0642\0647\0627\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P3002_COVERAGE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000670)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_button_name=>'SAVE'
,p_static_id=>'save-670'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P3002_COVERAGE_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000671)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000000657)
,p_button_name=>'CREATE'
,p_static_id=>'create-671'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>'P3002_COVERAGE_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000672)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000657)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Coverage'
,p_static_id=>'init-672'
,p_internal_uid=>930000000000000672
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000673)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000657)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Coverage'
,p_static_id=>'dml-673'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000673
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000674)
,p_branch_name=>'Go To Page 3002'
,p_branch_action=>'f?p=&APP_ID.:3002:&SESSION.::&DEBUG.::P3002_COVERAGE_ID:&P3002_COVERAGE_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'CREATE,SAVE'
,p_branch_sequence=>90
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000675)
,p_plug_name=>unistr('\0641\0631\064A\0642 \0627\0644\062A\063A\0637\064A\0629')
,p_static_id=>'r930000000000000675'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.CREW_ID,',
unistr('       case c.CREW_ROLE when ''PHOTOGRAPHER'' then ''\0645\0635\0648\0631'' when ''EDITOR'' then ''\0645\0648\0646\062A\0627\062C'' else ''\0645\0631\0627\0633\0644'' end as CREW_ROLE_AR,'),
'       e.NAME_AR, e.EMPLOYEE_NO',
'  from MOINFO_MED_CREW c join MOINFO_EMPLOYEES e on e.EMPLOYEE_ID = c.EMPLOYEE_ID',
' where c.COVERAGE_ID = :P3002_COVERAGE_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P3002_COVERAGE_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000000676)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:3003:&SESSION.::&DEBUG.:3003:P3003_CREW_ID:#CREW_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000676
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000677)
,p_db_column_name=>'CREW_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'CREW_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000678)
,p_db_column_name=>'CREW_ROLE_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062F\0648\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000679)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0648\0638\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000680)
,p_db_column_name=>'EMPLOYEE_NO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0648\0638\064A\0641\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000681)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'682'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CREW_ROLE_AR:NAME_AR:EMPLOYEE_NO:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000683)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000675)
,p_button_name=>'ADD_CHILD'
,p_static_id=>'add-child-683'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629 \0639\0636\0648')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:3003:&SESSION.::&DEBUG.:3003:P3003_COVERAGE_ID:&P3002_COVERAGE_ID.'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_03003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3003);
end;
/

prompt --application/pages/page_03003
begin
wwv_flow_imp_page.create_page(
 p_id=>3003
,p_name=>unistr('\0639\0636\0648 \0641\064A \0641\0631\064A\0642 \0627\0644\062A\063A\0637\064A\0629')
,p_alias=>'P3003'
,p_step_title=>unistr('\0639\0636\0648 \0641\064A \0641\0631\064A\0642 \0627\0644\062A\063A\0637\064A\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000009)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000684)
,p_plug_name=>unistr('\0639\0636\0648 \0641\064A \0641\0631\064A\0642 \0627\0644\062A\063A\0637\064A\0629')
,p_static_id=>'r930000000000000684'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_MED_CREW'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000685)
,p_name=>'P3003_CREW_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_source=>'CREW_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000686)
,p_name=>'P3003_COVERAGE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>6
,p_item_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_source=>'COVERAGE_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000687)
,p_name=>'P3003_CREW_ROLE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_prompt=>unistr('\0627\0644\062F\0648\0631')
,p_source=>'CREW_ROLE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'MED_CREW_ROLE'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0627\062E\062A\0631 -')
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
 p_id=>wwv_flow_imp.id(930000000000000688)
,p_name=>'P3003_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_prompt=>unistr('\0627\0644\0645\0648\0638\0641')
,p_source=>'EMPLOYEE_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000689)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-689'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:3002:&SESSION.::&DEBUG.::P3002_COVERAGE_ID:&P3003_COVERAGE_ID.'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000690)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_button_name=>'DELETE'
,p_static_id=>'delete-690'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \0627\0644\062D\0630\0641\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P3003_CREW_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000691)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_button_name=>'SAVE'
,p_static_id=>'save-691'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P3003_CREW_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000692)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000000684)
,p_button_name=>'CREATE'
,p_static_id=>'create-692'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>'P3003_CREW_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000693)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000684)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0639\0636\0648 \0641\064A \0641\0631\064A\0642 \0627\0644\062A\063A\0637\064A\0629')
,p_static_id=>'init-693'
,p_internal_uid=>930000000000000693
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000694)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000684)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0639\0636\0648 \0641\064A \0641\0631\064A\0642 \0627\0644\062A\063A\0637\064A\0629')
,p_static_id=>'dml-694'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000694
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000695)
,p_branch_name=>'Go To Page 3002'
,p_branch_action=>'f?p=&APP_ID.:3002:&SESSION.::&DEBUG.::P3002_COVERAGE_ID:&P3003_COVERAGE_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_03004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3004);
end;
/

prompt --application/pages/page_03004
begin
wwv_flow_imp_page.create_page(
 p_id=>3004
,p_name=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\062A\063A\0637\064A\0627\062A')
,p_alias=>'COVERAGE-STATS'
,p_step_title=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\062A\063A\0637\064A\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000009)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000696)
,p_plug_name=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\062A\063A\0637\064A\0627\062A')
,p_static_id=>'r930000000000000696'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select COVERAGE_YEAR, CHANNEL_AR, EVENT_TYPE_AR, COVERAGES_COUNT, ADDED_TODAY',
'  from MOINFO_MED_V_STATS order by COVERAGE_YEAR desc, COVERAGES_COUNT desc'))
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
 p_id=>wwv_flow_imp.id(930000000000000697)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000697
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000698)
,p_db_column_name=>'COVERAGE_YEAR'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\0633\0646\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000699)
,p_db_column_name=>'CHANNEL_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0646\0627\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000700)
,p_db_column_name=>'EVENT_TYPE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0646\0648\0639 \0627\0644\062A\063A\0637\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000701)
,p_db_column_name=>'COVERAGES_COUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0639\062F\062F \0627\0644\062A\063A\0637\064A\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000702)
,p_db_column_name=>'ADDED_TODAY'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0623\0636\064A\0641 \0627\0644\064A\0648\0645')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000703)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'704'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COVERAGE_YEAR:CHANNEL_AR:EVENT_TYPE_AR:COVERAGES_COUNT:ADDED_TODAY:'
);
end;
/

prompt --application/pages/delete_03005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3005);
end;
/

prompt --application/pages/page_03005
begin
wwv_flow_imp_page.create_page(
 p_id=>3005
,p_name=>unistr('\0639\0645\0644 \0627\0644\0641\0631\064A\0642')
,p_alias=>'CREW-WORKLOAD'
,p_step_title=>unistr('\0639\0645\0644 \0627\0644\0641\0631\064A\0642')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000009)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000705)
,p_plug_name=>unistr('\0639\062F\062F \0627\0644\062A\063A\0637\064A\0627\062A \0644\0643\0644 \0645\0648\0638\0641')
,p_static_id=>'r930000000000000705'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select EMPLOYEE_ID, EMPLOYEE_NAME_AR, CREW_ROLE_AR, COVERAGE_YEAR, COVERAGES_COUNT',
'  from MOINFO_MED_V_CREW_WORKLOAD order by COVERAGE_YEAR desc, COVERAGES_COUNT desc'))
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
 p_id=>wwv_flow_imp.id(930000000000000706)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000706
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000707)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'EMPLOYEE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000708)
,p_db_column_name=>'EMPLOYEE_NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0645\0648\0638\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000709)
,p_db_column_name=>'CREW_ROLE_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062F\0648\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000710)
,p_db_column_name=>'COVERAGE_YEAR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0633\0646\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000711)
,p_db_column_name=>'COVERAGES_COUNT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0639\062F\062F \0627\0644\062A\063A\0637\064A\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000712)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'713'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_NAME_AR:CREW_ROLE_AR:COVERAGE_YEAR:COVERAGES_COUNT:'
);
end;
/

prompt --application/pages/delete_03010
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3010);
end;
/

prompt --application/pages/page_03010
begin
wwv_flow_imp_page.create_page(
 p_id=>3010
,p_name=>unistr('\0627\0644\0642\0646\0648\0627\062A')
,p_alias=>'P3010'
,p_step_title=>unistr('\0627\0644\0642\0646\0648\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000020)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000714)
,p_plug_name=>unistr('\0627\0644\0642\0646\0648\0627\062A')
,p_static_id=>'r930000000000000714'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select CHANNEL_ID, NAME_AR, NAME_EN, SORT_ORDER, case IS_ACTIVE when ''Y'' then ''\0646\0639\0645'' else ''\0644\0627'' end as IS_ACTIVE_AR from MOINFO_MED_CHANNELS')))
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
 p_id=>wwv_flow_imp.id(930000000000000715)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:3011:&SESSION.::&DEBUG.:3011:P3011_CHANNEL_ID:#CHANNEL_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000715
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000716)
,p_db_column_name=>'CHANNEL_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'CHANNEL_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000717)
,p_db_column_name=>'NAME_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0646\0627\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000718)
,p_db_column_name=>'NAME_EN'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000719)
,p_db_column_name=>'SORT_ORDER'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\062A\0631\062A\064A\0628')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000720)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0646\0634\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000721)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'722'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME_AR:NAME_EN:SORT_ORDER:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000723)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000714)
,p_button_name=>'CREATE'
,p_static_id=>'create-723'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:3011:&SESSION.::&DEBUG.:3011::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_03011
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3011);
end;
/

prompt --application/pages/page_03011
begin
wwv_flow_imp_page.create_page(
 p_id=>3011
,p_name=>unistr('\0642\0646\0627\0629')
,p_alias=>'P3011'
,p_step_title=>unistr('\0642\0646\0627\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000020)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000724)
,p_plug_name=>unistr('\0642\0646\0627\0629')
,p_static_id=>'r930000000000000724'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_MED_CHANNELS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000725)
,p_name=>'P3011_CHANNEL_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_source=>'CHANNEL_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000726)
,p_name=>'P3011_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_prompt=>unistr('\0627\0644\0642\0646\0627\0629 \0628\0627\0644\0639\0631\0628\064A\0629')
,p_source=>'NAME_AR'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>150
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
 p_id=>wwv_flow_imp.id(930000000000000727)
,p_name=>'P3011_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_prompt=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_source=>'NAME_EN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>150
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
 p_id=>wwv_flow_imp.id(930000000000000728)
,p_name=>'P3011_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000724)
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
 p_id=>wwv_flow_imp.id(930000000000000729)
,p_name=>'P3011_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000724)
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
 p_id=>wwv_flow_imp.id(930000000000000730)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-730'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:3010:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000731)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_button_name=>'SAVE'
,p_static_id=>'save-731'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P3011_CHANNEL_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000732)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000000724)
,p_button_name=>'CREATE'
,p_static_id=>'create-732'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621')
,p_button_position=>'CREATE'
,p_button_condition=>'P3011_CHANNEL_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000733)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000724)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0642\0646\0627\0629')
,p_static_id=>'init-733'
,p_internal_uid=>930000000000000733
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000734)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000724)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0642\0646\0627\0629')
,p_static_id=>'dml-734'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000734
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000735)
,p_branch_name=>'Go To Page 3010'
,p_branch_action=>'f?p=&APP_ID.:3010:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_03012
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3012);
end;
/

prompt --application/pages/page_03012
begin
wwv_flow_imp_page.create_page(
 p_id=>3012
,p_name=>unistr('\0627\0644\0628\0631\0627\0645\062C')
,p_alias=>'P3012'
,p_step_title=>unistr('\0627\0644\0628\0631\0627\0645\062C')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000020)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000736)
,p_plug_name=>unistr('\0627\0644\0628\0631\0627\0645\062C')
,p_static_id=>'r930000000000000736'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select p.PROGRAM_ID, c.NAME_AR as CHANNEL_AR, p.NAME_AR, p.NAME_EN, p.SORT_ORDER, case p.IS_ACTIVE when ''Y'' then ''\0646\0639\0645'' else ''\0644\0627'' end as IS_ACTIVE_AR'),
'  from MOINFO_MED_PROGRAMS p join MOINFO_MED_CHANNELS c on c.CHANNEL_ID = p.CHANNEL_ID'))
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
 p_id=>wwv_flow_imp.id(930000000000000737)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:3013:&SESSION.::&DEBUG.:3013:P3013_PROGRAM_ID:#PROGRAM_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000737
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000738)
,p_db_column_name=>'PROGRAM_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'PROGRAM_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000739)
,p_db_column_name=>'CHANNEL_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0642\0646\0627\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000740)
,p_db_column_name=>'NAME_AR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0628\0631\0646\0627\0645\062C')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000741)
,p_db_column_name=>'NAME_EN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000742)
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
 p_id=>wwv_flow_imp.id(930000000000000743)
,p_db_column_name=>'IS_ACTIVE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0646\0634\0637')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000744)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'745'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CHANNEL_AR:NAME_AR:NAME_EN:SORT_ORDER:IS_ACTIVE_AR:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000746)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000736)
,p_button_name=>'CREATE'
,p_static_id=>'create-746'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:3013:&SESSION.::&DEBUG.:3013::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_03013
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3013);
end;
/

prompt --application/pages/page_03013
begin
wwv_flow_imp_page.create_page(
 p_id=>3013
,p_name=>unistr('\0628\0631\0646\0627\0645\062C')
,p_alias=>'P3013'
,p_step_title=>unistr('\0628\0631\0646\0627\0645\062C')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000020)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000747)
,p_plug_name=>unistr('\0628\0631\0646\0627\0645\062C')
,p_static_id=>'r930000000000000747'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_MED_PROGRAMS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000748)
,p_name=>'P3013_PROGRAM_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_source=>'PROGRAM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000749)
,p_name=>'P3013_CHANNEL_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_prompt=>unistr('\0627\0644\0642\0646\0627\0629')
,p_source=>'CHANNEL_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'MED_CHANNELS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0627\062E\062A\0631 -')
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
 p_id=>wwv_flow_imp.id(930000000000000750)
,p_name=>'P3013_NAME_AR'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_prompt=>unistr('\0627\0644\0628\0631\0646\0627\0645\062C \0628\0627\0644\0639\0631\0628\064A\0629')
,p_source=>'NAME_AR'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>150
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
 p_id=>wwv_flow_imp.id(930000000000000751)
,p_name=>'P3013_NAME_EN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_prompt=>unistr('\0628\0627\0644\0625\0646\062C\0644\064A\0632\064A\0629')
,p_source=>'NAME_EN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>150
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
 p_id=>wwv_flow_imp.id(930000000000000752)
,p_name=>'P3013_SORT_ORDER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000747)
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
 p_id=>wwv_flow_imp.id(930000000000000753)
,p_name=>'P3013_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_item_default=>'Y'
,p_prompt=>unistr('\0646\0634\0637')
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
 p_id=>wwv_flow_imp.id(930000000000000754)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-754'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:3012:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000755)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_button_name=>'SAVE'
,p_static_id=>'save-755'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P3013_PROGRAM_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000756)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000000747)
,p_button_name=>'CREATE'
,p_static_id=>'create-756'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0646\0634\0627\0621')
,p_button_position=>'CREATE'
,p_button_condition=>'P3013_PROGRAM_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000757)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000747)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form \0628\0631\0646\0627\0645\062C')
,p_static_id=>'init-757'
,p_internal_uid=>930000000000000757
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000758)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000747)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form \0628\0631\0646\0627\0645\062C')
,p_static_id=>'dml-758'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000758
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000759)
,p_branch_name=>'Go To Page 3012'
,p_branch_action=>'f?p=&APP_ID.:3012:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_04001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>4001);
end;
/

prompt --application/pages/page_04001
begin
wwv_flow_imp_page.create_page(
 p_id=>4001
,p_name=>unistr('\0627\0644\0645\0647\0627\0645')
,p_alias=>'TASKS'
,p_step_title=>unistr('\0627\0644\0645\0647\0627\0645')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000010)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000760)
,p_plug_name=>unistr('\0627\0644\0645\0647\0627\0645')
,p_static_id=>'r930000000000000760'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.TASK_ID, t.REF_NO, t.TITLE, t.STATUS_AR, t.PRIORITY_AR, t.TASK_TYPE_AR, t.TASK_CATEGORY_AR,',
'       t.ASSIGNED_NAME_AR, t.REQUESTER_NAME_AR, t.REQUESTER_UNIT_AR, t.RECEIVED_DATE, t.DUE_DATE, t.CLOSED_DATE,',
unistr('       t.DURATION_DAYS, case t.IS_LATE when ''Y'' then ''\0645\062A\0623\062E\0631\0629'' end as LATE_AR, t.IS_CLOSED'),
'  from MOINFO_TSK_V_TASKS t',
' where t.IS_ACTIVE = ''Y''',
'   and MOINFO_TSK.CAN_SEE(t.TASK_ID) = ''Y''',
' order by t.RECEIVED_DATE desc, t.TASK_ID desc'))
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
 p_id=>wwv_flow_imp.id(930000000000000761)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:4002:&SESSION.::&DEBUG.:4002:P4002_TASK_ID:#TASK_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000761
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000762)
,p_db_column_name=>'TASK_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'TASK_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000763)
,p_db_column_name=>'REF_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\0631\062C\0639\064A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000764)
,p_db_column_name=>'TITLE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0647\0645\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000765)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000766)
,p_db_column_name=>'PRIORITY_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0623\0648\0644\0648\064A\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000767)
,p_db_column_name=>'TASK_TYPE_AR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0627\0644\0646\0648\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000768)
,p_db_column_name=>'TASK_CATEGORY_AR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\062A\0635\0646\064A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000769)
,p_db_column_name=>'ASSIGNED_NAME_AR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0627\0644\0645\0643\0644\0651\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000770)
,p_db_column_name=>'REQUESTER_NAME_AR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0635\0627\062D\0628 \0627\0644\0637\0644\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000771)
,p_db_column_name=>'REQUESTER_UNIT_AR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\062C\0647\0629 \0627\0644\0637\0644\0628')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000772)
,p_db_column_name=>'RECEIVED_DATE'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('\0627\0644\0627\0633\062A\0644\0627\0645')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000773)
,p_db_column_name=>'DUE_DATE'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('\0627\0644\0627\0633\062A\062D\0642\0627\0642')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000774)
,p_db_column_name=>'CLOSED_DATE'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('\0627\0644\0625\063A\0644\0627\0642')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000775)
,p_db_column_name=>'DURATION_DAYS'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('\0627\0644\0645\062F\0629 (\0623\064A\0627\0645)')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000776)
,p_db_column_name=>'LATE_AR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('\0627\0644\062A\0623\062E\064A\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000777)
,p_db_column_name=>'IS_CLOSED'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('\0645\063A\0644\0642\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000778)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'779'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REF_NO:TITLE:STATUS_AR:PRIORITY_AR:TASK_TYPE_AR:TASK_CATEGORY_AR:ASSIGNED_NAME_AR:REQUESTER_NAME_AR:REQUESTER_UNIT_AR:RECEIVED_DATE:DUE_DATE:CLOSED_DATE:DURATION_DAYS:LATE_AR:IS_CLOSED:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000780)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000760)
,p_button_name=>'CREATE'
,p_static_id=>'create-780'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0645\0647\0645\0629 \062C\062F\064A\062F\0629')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:4002:&SESSION.::&DEBUG.:4002::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_04002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>4002);
end;
/

prompt --application/pages/page_04002
begin
wwv_flow_imp_page.create_page(
 p_id=>4002
,p_name=>unistr('\0645\0647\0645\0629')
,p_alias=>'TASK'
,p_step_title=>unistr('\0645\0647\0645\0629')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000010)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000781)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-781'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P4002_TASK_ID is not null and MOINFO_TSK.CAN_SEE(:P4002_TASK_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0647 \0627\0644\0645\0647\0645\0629'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000781
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000782)
,p_plug_name=>unistr('\0645\0647\0645\0629')
,p_static_id=>'r930000000000000782'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_TSK_TASKS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000783)
,p_name=>'P4002_TASK_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_source=>'TASK_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000784)
,p_name=>'P4002_TITLE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0627\0644\0645\0647\0645\0629')
,p_source=>'TITLE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
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
 p_id=>wwv_flow_imp.id(930000000000000785)
,p_name=>'P4002_REF_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0627\0644\0631\0642\0645 \0627\0644\0645\0631\062C\0639\064A')
,p_source=>'REF_NO'
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
 p_id=>wwv_flow_imp.id(930000000000000786)
,p_name=>'P4002_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_default=>'NORMAL'
,p_prompt=>unistr('\0627\0644\0623\0648\0644\0648\064A\0629')
,p_source=>'PRIORITY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TSK_PRIORITY'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1612549789555753698
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000787)
,p_name=>'P4002_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_default=>'MOINFO_TSK.GET_STATUS_ID(''NEW'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\062D\0627\0644\0629')
,p_source=>'STATUS_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_TSK_STATUS'
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
 p_id=>wwv_flow_imp.id(930000000000000788)
,p_name=>'P4002_TASK_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0627\0644\0646\0648\0639')
,p_source=>'TASK_TYPE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_TSK_TYPE'
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
 p_id=>wwv_flow_imp.id(930000000000000789)
,p_name=>'P4002_TASK_CATEGORY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0627\0644\062A\0635\0646\064A\0641')
,p_source=>'TASK_CATEGORY_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_TSK_CATEGORY'
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
 p_id=>wwv_flow_imp.id(930000000000000790)
,p_name=>'P4002_ASSIGNED_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_default=>'MOINFO_HR.MY_EMPLOYEE_ID'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\0645\0643\0644\0651\0641')
,p_source=>'ASSIGNED_EMPLOYEE_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
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
 p_id=>wwv_flow_imp.id(930000000000000791)
,p_name=>'P4002_REQUESTER_EMPLOYEE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0635\0627\062D\0628 \0627\0644\0637\0644\0628 (\0645\0648\0638\0641)')
,p_source=>'REQUESTER_EMPLOYEE_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'EMPLOYEES'
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
 p_id=>wwv_flow_imp.id(930000000000000792)
,p_name=>'P4002_REQUESTER_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0623\0648 \0627\0633\0645 \0635\0627\062D\0628 \0627\0644\0637\0644\0628')
,p_source=>'REQUESTER_NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>300
,p_begin_on_new_line=>'N'
,p_field_template=>1612549609962752680
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_inline_help_text=>unistr('\0644\0635\0627\062D\0628 \0637\0644\0628 \0645\0646 \062E\0627\0631\062C \0627\0644\062C\0647\0629 \0623\0648 \063A\064A\0631 \0645\0633\062C\0644 \0643\0645\0648\0638\0641')
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000793)
,p_name=>'P4002_RECEIVED_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_default=>'to_char(sysdate, ''DD/MM/YYYY'')'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\0627\0633\062A\0644\0627\0645')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'RECEIVED_DATE'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1612549789555753698
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
 p_id=>wwv_flow_imp.id(930000000000000794)
,p_name=>'P4002_DUE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\0627\0633\062A\062D\0642\0627\0642')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DUE_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000795)
,p_name=>'P4002_CLOSED_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\062A\0627\0631\064A\062E \0627\0644\0625\063A\0644\0627\0642')
,p_source=>'CLOSED_DATE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(930000000000000796)
,p_name=>'P4002_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0627\0644\062A\0641\0627\0635\064A\0644')
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
 p_id=>wwv_flow_imp.id(930000000000000797)
,p_name=>'P4002_ACTION_TAKEN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_prompt=>unistr('\0627\0644\0625\062C\0631\0627\0621 \0627\0644\0645\062A\062E\0630')
,p_source=>'ACTION_TAKEN'
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
 p_id=>wwv_flow_imp.id(930000000000000798)
,p_name=>'P4002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000782)
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
 p_id=>wwv_flow_imp.id(930000000000000799)
,p_validation_name=>'Due after received'
,p_static_id=>'due-after-received-799'
,p_validation_sequence=>10
,p_validation=>':P4002_DUE_DATE is null or to_date(:P4002_DUE_DATE, ''DD/MM/YYYY'') >= to_date(:P4002_RECEIVED_DATE, ''DD/MM/YYYY'')'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>unistr('\062A\0627\0631\064A\062E \0627\0644\0627\0633\062A\062D\0642\0627\0642 \064A\062C\0628 \0623\0644\0627 \064A\0633\0628\0642 \062A\0627\0631\064A\062E \0627\0644\0627\0633\062A\0644\0627\0645')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000800)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-800'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:4001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000801)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_button_name=>'DELETE'
,p_static_id=>'delete-801'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0647 \0627\0644\0645\0647\0645\0629\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P4002_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000802)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_button_name=>'SAVE'
,p_static_id=>'save-802'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638 \0627\0644\062A\0639\062F\064A\0644\0627\062A')
,p_button_position=>'CHANGE'
,p_button_condition=>'P4002_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000803)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000000782)
,p_button_name=>'CREATE'
,p_static_id=>'create-803'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>'P4002_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000804)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000782)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Task'
,p_static_id=>'init-804'
,p_internal_uid=>930000000000000804
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000805)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000782)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Task'
,p_static_id=>'dml-805'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000000805
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000806)
,p_plug_name=>unistr('\0625\0636\0627\0641\0629 \0645\062A\0627\0628\0639\0629')
,p_static_id=>'r930000000000000806'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_plug_query_num_rows=>15
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P4002_TASK_ID'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000807)
,p_name=>'P4002_NOTE_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000806)
,p_prompt=>unistr('\0645\0644\0627\062D\0638\0629 \0627\0644\0645\062A\0627\0628\0639\0629')
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
 p_id=>wwv_flow_imp.id(930000000000000808)
,p_name=>'P4002_NOTE_STATUS_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000806)
,p_prompt=>unistr('\062A\063A\064A\064A\0631 \0627\0644\062D\0627\0644\0629 \0625\0644\0649')
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_TSK_STATUS'
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
 p_id=>wwv_flow_imp.id(930000000000000809)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000806)
,p_button_name=>'ADD_NOTE'
,p_static_id=>'add-note-809'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629 \0627\0644\0645\062A\0627\0628\0639\0629')
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(930000000000000810)
,p_validation_name=>'Note required'
,p_static_id=>'note-required-810'
,p_validation_sequence=>40
,p_validation=>'P4002_NOTE_TEXT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\0627\0643\062A\0628 \0646\0635 \0627\0644\0645\062A\0627\0628\0639\0629')
,p_when_button_pressed=>wwv_flow_imp.id(930000000000000809)
,p_associated_item=>wwv_flow_imp.id(930000000000000807)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000811)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Add note'
,p_static_id=>'add-note-811'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_TSK.ADD_NOTE(:P4002_TASK_ID, :P4002_NOTE_TEXT, :P4002_NOTE_STATUS_ID);',
':P4002_NOTE_TEXT := null;',
':P4002_NOTE_STATUS_ID := null;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(930000000000000809)
,p_process_success_message=>unistr('\0623\064F\0636\064A\0641\062A \0627\0644\0645\062A\0627\0628\0639\0629')
,p_internal_uid=>930000000000000811
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000812)
,p_plug_name=>unistr('\0633\062C\0644 \0627\0644\0645\062A\0627\0628\0639\0629')
,p_static_id=>'r930000000000000812'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select NOTE_ID, to_char(cast(CREATED_AT as date), ''DD/MM/YYYY HH24:MI'') as CREATED_AT_TXT,',
'       CREATED_BY_NAME, NOTE_TEXT, STATUS_AR',
'  from MOINFO_TSK_V_NOTES',
' where TASK_ID = :P4002_TASK_ID',
' order by CREATED_AT desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P4002_TASK_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000000813)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000813
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000814)
,p_db_column_name=>'NOTE_ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'NOTE_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000815)
,p_db_column_name=>'CREATED_AT_TXT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0648\0642\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000816)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0628\0648\0627\0633\0637\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000817)
,p_db_column_name=>'NOTE_TEXT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\062A\0627\0628\0639\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000818)
,p_db_column_name=>'STATUS_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\062D\0627\0644\0629 \0627\0644\062C\062F\064A\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000819)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'820'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CREATED_AT_TXT:CREATED_BY_NAME:NOTE_TEXT:STATUS_AR:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000821)
,p_branch_name=>'Go To Page 4002'
,p_branch_action=>'f?p=&APP_ID.:4002:&SESSION.::&DEBUG.::P4002_TASK_ID:&P4002_TASK_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(930000000000000809)
,p_branch_sequence=>50
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000822)
,p_branch_name=>'Go To Page 4001'
,p_branch_action=>'f?p=&APP_ID.:4001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_04003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>4003);
end;
/

prompt --application/pages/page_04003
begin
wwv_flow_imp_page.create_page(
 p_id=>4003
,p_name=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\0645\0647\0627\0645')
,p_alias=>'TASK-STATS'
,p_step_title=>unistr('\0625\062D\0635\0627\0626\064A\0627\062A \0627\0644\0645\0647\0627\0645')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000010)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000823)
,p_plug_name=>unistr('\0627\0644\0645\0647\0627\0645 \0644\0643\0644 \0645\0648\0638\0641 \062D\0633\0628 \0627\0644\0634\0647\0631')
,p_static_id=>'r930000000000000823'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.ASSIGNED_NAME_AR, to_char(s.RECEIVED_MONTH, ''YYYY-MM'') as MONTH_TXT, s.TASKS_COUNT,',
'       s.DONE_COUNT, s.OPEN_COUNT, s.AVG_DAYS_TO_CLOSE',
'  from MOINFO_TSK_V_STATS s',
' where MOINFO_SEC.DATA_SCOPE(''TSK'') = ''ALL''',
'    or (s.ASSIGNED_UNIT_ID is not null and MOINFO_SEC.CAN_SEE_UNIT(''TSK'', s.ASSIGNED_UNIT_ID) = ''Y'')',
'    or s.ASSIGNED_EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID',
' order by s.RECEIVED_MONTH desc, s.TASKS_COUNT desc'))
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
 p_id=>wwv_flow_imp.id(930000000000000824)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000824
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000825)
,p_db_column_name=>'ASSIGNED_NAME_AR'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('\0627\0644\0645\0648\0638\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000826)
,p_db_column_name=>'MONTH_TXT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\0634\0647\0631')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000827)
,p_db_column_name=>'TASKS_COUNT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0645\0647\0627\0645')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000828)
,p_db_column_name=>'DONE_COUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\0645\0646\062C\0632\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000829)
,p_db_column_name=>'OPEN_COUNT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0645\0641\062A\0648\062D\0629')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000830)
,p_db_column_name=>'AVG_DAYS_TO_CLOSE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0645\062A\0648\0633\0637 \0623\064A\0627\0645 \0627\0644\0625\0646\062C\0627\0632')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000831)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'832'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ASSIGNED_NAME_AR:MONTH_TXT:TASKS_COUNT:DONE_COUNT:OPEN_COUNT:AVG_DAYS_TO_CLOSE:'
);
end;
/

prompt --application/pages/delete_05001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5001);
end;
/

prompt --application/pages/page_05001
begin
wwv_flow_imp_page.create_page(
 p_id=>5001
,p_name=>unistr('\0627\0644\0645\0633\062A\0646\062F\0627\062A')
,p_alias=>'DOCUMENTS'
,p_step_title=>unistr('\0627\0644\0645\0633\062A\0646\062F\0627\062A')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000011)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000833)
,p_plug_name=>unistr('\0627\0644\0645\0633\062A\0646\062F\0627\062A')
,p_static_id=>'r930000000000000833'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d.DOCUMENT_ID, d.CATEGORY_AR, d.TITLE, d.DOCUMENT_DATE, d.OWNER_UNIT_AR,',
'       case when d.LATEST_ATTACHMENT_ID is not null then',
'            ''<a href="'' || apex_page.get_url(p_page => 5003, p_items => ''P5003_ATTACHMENT_ID'', p_values => d.LATEST_ATTACHMENT_ID)',
'            || ''"><span class="fa fa-download"></span> '' || apex_escape.html(d.LATEST_FILE_NAME) || ''</a>''',
'       end as LATEST_FILE,',
'       d.LATEST_FILE_SIZE, d.FILES_COUNT,',
'       to_char(cast(d.LATEST_UPLOADED_AT as date), ''DD/MM/YYYY HH24:MI'') as UPLOADED_TXT,',
'       d.REMARKS',
'  from MOINFO_ATT_V_DOCUMENTS d',
' where d.IS_ACTIVE = ''Y''',
'   and MOINFO_ATT.CAN_SEE(d.DOCUMENT_ID) = ''Y'''))
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
 p_id=>wwv_flow_imp.id(930000000000000834)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:5002:&SESSION.::&DEBUG.:5002:P5002_DOCUMENT_ID:#DOCUMENT_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_internal_uid=>930000000000000834
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000835)
,p_db_column_name=>'DOCUMENT_ID'
,p_display_order=>10
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'DOCUMENT_ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000836)
,p_db_column_name=>'CATEGORY_AR'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('\0627\0644\062A\0635\0646\064A\0641')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000837)
,p_db_column_name=>'TITLE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\0639\0646\0648\0627\0646')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000838)
,p_db_column_name=>'DOCUMENT_DATE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/YYYY'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000839)
,p_db_column_name=>'OWNER_UNIT_AR'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\062D\062F\0629')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000840)
,p_db_column_name=>'LATEST_FILE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('\0622\062E\0631 \0645\0644\0641')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000841)
,p_db_column_name=>'LATEST_FILE_SIZE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('\0627\0644\062D\062C\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000842)
,p_db_column_name=>'FILES_COUNT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('\0639\062F\062F \0627\0644\0645\0644\0641\0627\062A')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000843)
,p_db_column_name=>'UPLOADED_TXT'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('\0648\0642\062A \0627\0644\0631\0641\0639')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000844)
,p_db_column_name=>'REMARKS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('\0645\0644\0627\062D\0638\0627\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000845)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'846'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'CATEGORY_AR:TITLE:DOCUMENT_DATE:OWNER_UNIT_AR:LATEST_FILE:LATEST_FILE_SIZE:FILES_COUNT:UPLOADED_TXT:REMARKS:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000847)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000833)
,p_button_name=>'CREATE'
,p_static_id=>'create-847'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2086257187394300437
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0645\0633\062A\0646\062F \062C\062F\064A\062F')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:5002:&SESSION.::&DEBUG.:5002::'
,p_icon_css_classes=>'fa-plus'
);
end;
/

prompt --application/pages/delete_05002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5002);
end;
/

prompt --application/pages/page_05002
begin
wwv_flow_imp_page.create_page(
 p_id=>5002
,p_name=>unistr('\0645\0633\062A\0646\062F')
,p_alias=>'DOCUMENT'
,p_step_title=>unistr('\0645\0633\062A\0646\062F')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000011)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000848)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Row access check'
,p_static_id=>'row-access-check-848'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P5002_DOCUMENT_ID is not null and MOINFO_ATT.CAN_SEE(:P5002_DOCUMENT_ID) = ''N'' then',
unistr('    raise_application_error(-20100, ''\0644\0627 \062A\0645\0644\0643 \0635\0644\0627\062D\064A\0629 \0639\0644\0649 \0647\0630\0627 \0627\0644\0645\0633\062A\0646\062F'');'),
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000848
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000849)
,p_plug_name=>unistr('\0645\0633\062A\0646\062F')
,p_static_id=>'r930000000000000849'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4075786578761660127
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'MOINFO_ATT_DOCUMENTS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000850)
,p_name=>'P5002_DOCUMENT_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_source=>'DOCUMENT_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000851)
,p_name=>'P5002_CATEGORY_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_prompt=>unistr('\0627\0644\062A\0635\0646\064A\0641')
,p_source=>'CATEGORY_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LK_ATT_CATEGORY'
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- \0627\062E\062A\0631 -')
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
 p_id=>wwv_flow_imp.id(930000000000000852)
,p_name=>'P5002_TITLE'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_prompt=>unistr('\0627\0644\0639\0646\0648\0627\0646')
,p_source=>'TITLE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>500
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
 p_id=>wwv_flow_imp.id(930000000000000853)
,p_name=>'P5002_DOCUMENT_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_prompt=>unistr('\0627\0644\062A\0627\0631\064A\062E')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DOCUMENT_DATE'
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
 p_id=>wwv_flow_imp.id(930000000000000854)
,p_name=>'P5002_OWNER_UNIT_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_default=>'(select UNIT_ID from MOINFO_EMPLOYEES where EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID)'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>unistr('\0627\0644\0648\062D\062F\0629 \0627\0644\0645\0627\0644\0643\0629')
,p_source=>'OWNER_UNIT_ID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'UNITS'
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
 p_id=>wwv_flow_imp.id(930000000000000855)
,p_name=>'P5002_REMARKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000849)
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
 p_id=>wwv_flow_imp.id(930000000000000856)
,p_name=>'P5002_IS_ACTIVE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_item_source_plug_id=>wwv_flow_imp.id(930000000000000849)
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
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(930000000000000857)
,p_name=>'P5002_FILES'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_prompt=>unistr('\0625\0631\0641\0627\0642 \0645\0644\0641\0627\062A')
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
 p_id=>wwv_flow_imp.id(930000000000000858)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel-858'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\0625\0644\063A\0627\0621')
,p_button_position=>'CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:5001:&SESSION.::&DEBUG.:::'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000859)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_button_name=>'DELETE'
,p_static_id=>'delete-859'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_image_alt=>unistr('\062D\0630\0641')
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_confirm_message=>unistr('\0647\0644 \062A\0631\064A\062F \062D\0630\0641 \0647\0630\0627 \0627\0644\0645\0633\062A\0646\062F\061F')
,p_confirm_style=>'danger'
,p_button_condition=>'P5002_DOCUMENT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000860)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_button_name=>'SAVE'
,p_static_id=>'save-860'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\062D\0641\0638')
,p_button_position=>'CHANGE'
,p_button_condition=>'P5002_DOCUMENT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(930000000000000861)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(930000000000000849)
,p_button_name=>'CREATE'
,p_static_id=>'create-861'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4075790603270660137
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\0625\0636\0627\0641\0629')
,p_button_position=>'CREATE'
,p_button_condition=>'P5002_DOCUMENT_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000862)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(930000000000000849)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Document'
,p_static_id=>'init-862'
,p_internal_uid=>930000000000000862
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000863)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(930000000000000849)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Document'
,p_static_id=>'dml-863'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('\062A\0645 \0627\0644\062D\0641\0638 \0628\0646\062C\0627\062D')
,p_internal_uid=>930000000000000863
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000864)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Store files'
,p_static_id=>'store-files-864'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_n number;',
'begin',
'    l_n := MOINFO_FILES.ADD_FROM_APEX(''ATT'', ''MOINFO_ATT_DOCUMENTS'', :P5002_DOCUMENT_ID, :P5002_FILES);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>930000000000000864
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000865)
,p_plug_name=>unistr('\0645\0644\0641\0627\062A \0627\0644\0645\0633\062A\0646\062F')
,p_static_id=>'r930000000000000865'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_plug_template=>2103954283454391425
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.ATTACHMENT_ID,',
'       ''<a href="'' || apex_page.get_url(p_page => 5003, p_items => ''P5003_ATTACHMENT_ID'', p_values => a.ATTACHMENT_ID)',
'       || ''"><span class="fa fa-download"></span> '' || apex_escape.html(a.FILE_NAME) || ''</a>'' as FILE_LINK,',
'       a.FILE_SIZE_TEXT, a.CREATED_BY_NAME, to_char(cast(a.CREATED_AT as date), ''DD/MM/YYYY HH24:MI'') as CREATED_AT_TXT',
'  from MOINFO_V_ATTACHMENTS a',
' where a.ENTITY_NAME = ''MOINFO_ATT_DOCUMENTS'' and a.ENTITY_ID = :P5002_DOCUMENT_ID',
' order by a.CREATED_AT desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P5002_DOCUMENT_ID'
,p_plug_query_headings_type=>'COLON_DELMITED_LIST'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'A4'
,p_prn_width=>11.69
,p_prn_height=>8.27
,p_prn_orientation=>'HORIZONTAL'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(930000000000000866)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>930000000000000866
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000867)
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
 p_id=>wwv_flow_imp.id(930000000000000868)
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
 p_id=>wwv_flow_imp.id(930000000000000869)
,p_db_column_name=>'FILE_SIZE_TEXT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('\0627\0644\062D\062C\0645')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000870)
,p_db_column_name=>'CREATED_BY_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('\0631\0641\0639\0647')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(930000000000000871)
,p_db_column_name=>'CREATED_AT_TXT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('\0627\0644\0648\0642\062A')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(930000000000000872)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'873'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FILE_LINK:FILE_SIZE_TEXT:CREATED_BY_NAME:CREATED_AT_TXT:'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(930000000000000874)
,p_branch_name=>'Go To Page 5001'
,p_branch_action=>'f?p=&APP_ID.:5001:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>100
);
end;
/

prompt --application/pages/delete_05003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5003);
end;
/

prompt --application/pages/page_05003
begin
wwv_flow_imp_page.create_page(
 p_id=>5003
,p_name=>unistr('\062A\0646\0632\064A\0644 \0645\0644\0641')
,p_alias=>'DOWNLOAD'
,p_step_title=>unistr('\062A\0646\0632\064A\0644 \0645\0644\0641')
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4075783602716660119
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(930000000000000011)
,p_protection_level=>'C'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(930000000000000875)
,p_plug_name=>unistr('\062A\0646\0632\064A\0644')
,p_static_id=>'r930000000000000875'
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
 p_id=>wwv_flow_imp.id(930000000000000876)
,p_name=>'P5003_ATTACHMENT_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(930000000000000875)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(930000000000000877)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download'
,p_static_id=>'download-877'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MOINFO_FILES.DOWNLOAD(:P5003_ATTACHMENT_ID);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>930000000000000877
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
