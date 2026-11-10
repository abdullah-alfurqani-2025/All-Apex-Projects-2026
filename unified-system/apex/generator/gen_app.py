#!/usr/bin/env python3
"""
Generator for the MOINFO unified APEX application (app 145032, APEX 26.2.1).
Builds an application export file from page/component definitions, using the
theme/template IDs of the target application.
"""
import os, sys

BASE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'base')
APP_ID = 145032
WS_ID = 12399410469927812686
OWNER = 'WKSP_ABDULLAHALFURQANI2025'

# ---- Universal Theme template IDs of app 145032 -------------------------------
T_PAGE_STD = 4075783602716660119
T_PAGE_DIALOG = 2103835248774687739
T_PAGE_LOGIN = 2104585595298951431
T_REG_STD = 4075786578761660127
T_REG_IR = 2103954283454391425
T_REG_HERO = 2677445476673898083
T_REG_LOGIN = 2677585639786677191
T_REG_BLANK = 4504868307683981366
T_REG_BUTTONS = 2129856781885180476
T_REG_CARDS_CONT = 2076152157930740558
T_LIST_CARDS = 2890197131116233323
T_LIST_SIDE_NAV = 2471166859590295591
T_LIST_NAVBAR = 2850970698196720012
T_BTN_TEXT = 4075790603270660137
T_BTN_ICON_TEXT = 2086257187394300437
T_LBL_HIDDEN = 2044213549383960320
T_LBL_OPT = 1612549609962752680      # Optional - Floating
T_LBL_REQ = 1612549789555753698      # Required - Floating

# ---- IDs ---------------------------------------------------------------------
_next = [930000000000000000]
def nid():
    _next[0] += 1
    return _next[0]
def rid(n):
    return f"wwv_flow_imp.id({n})"

# ---- literals ----------------------------------------------------------------
def lit(s):
    """PL/SQL literal like APEX exports: plain for ASCII, unistr() otherwise."""
    if s is None:
        return 'null'
    s = str(s)
    if all(ord(c) < 128 for c in s):
        return "'" + s.replace("'", "''") + "'"
    out = []
    for c in s:
        o = ord(c)
        if c == '\\':
            out.append('\\005C')
        elif c == "'":
            out.append("''")
        elif o < 128:
            out.append(c)
        else:
            out.append('\\%04X' % o)
    return "unistr('" + ''.join(out) + "')"

def lines(text):
    """Multi-line text as wwv_flow_string.join(wwv_flow_t_varchar2(...))."""
    ls = text.strip('\n').split('\n')
    return "wwv_flow_string.join(wwv_flow_t_varchar2(\n" + ",\n".join(lit(l) for l in ls) + "))"

def attrs(d):
    items = sorted(d.items())
    body = ",\n".join(f"  {lit(k)}, {lit(v)}" for k, v in items)
    return "wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(\n" + body + ")).to_clob"

def call(proc, params):
    """params: list of (name, rendered_value) ; None values skipped"""
    ps = [(k, v) for k, v in params if v is not None]
    s = f"{proc}(\n " + "\n,".join(f"{k}=>{v}" for k, v in ps) + "\n);"
    return s

def block(prompt, calls):
    return f"prompt --application/{prompt}\nbegin\n" + "\n".join(calls) + "\nend;\n/\n"

def num(v):
    return None if v is None else str(v)

def slug(s):
    import re
    s = re.sub(r'[^a-z0-9]+', '-', str(s).lower()).strip('-')
    return s or 'x'

# ==============================================================================
# Shared components
# ==============================================================================
AUTH_ID = nid()
AUTHZ = {}          # name -> id
LOVS = {}           # name -> id
LISTS = {}

def authorization(name, plsql, msg):
    i = nid()
    AUTHZ[name] = i
    return call("wwv_flow_imp_shared.create_security_scheme", [
        ("p_id", rid(i)),
        ("p_name", lit(name)),
        ("p_static_id", lit(slug(name))),
        ("p_scheme_type", lit('NATIVE_FUNCTION_BODY')),
        ("p_attributes", attrs({'plsql_function_body': plsql})),
        ("p_error_message", lit(msg)),
        ("p_caching", lit('BY_USER_BY_PAGE_VIEW')),
    ])

def lov(name, sql):
    i = nid()
    LOVS[name] = i
    return block(f"shared_components/user_interface/lovs/{slug(name).replace('-', '_')}", [call(
        "wwv_flow_imp_shared.create_list_of_values", [
            ("p_id", rid(i)),
            ("p_lov_name", lit(name)),
            ("p_static_id", lit(slug(name))),
            ("p_lov_query", lines(sql)),
            ("p_source_type", lit('SQL')),
            ("p_location", lit('LOCAL')),
            ("p_return_column_name", lit('R')),
            ("p_display_column_name", lit('D')),
        ])])

def static_lov(name, pairs):
    i = nid()
    LOVS[name] = i
    calls = [call("wwv_flow_imp_shared.create_list_of_values", [
        ("p_id", rid(i)),
        ("p_lov_name", lit(name)),
        ("p_static_id", lit(slug(name))),
        ("p_lov_query", f"'.'||{rid(i)}||'.'"),
        ("p_location", lit('STATIC')),
    ])]
    for seq, (d, r) in enumerate(pairs, 1):
        calls.append(call("wwv_flow_imp_shared.create_static_lov_data", [
            ("p_id", rid(nid())),
            ("p_lov_disp_sequence", str(seq)),
            ("p_lov_disp_value", lit(d)),
            ("p_lov_return_value", lit(r)),
            ("p_static_id", lit(slug(r) + f"-{seq}")),
        ]))
    return block(f"shared_components/user_interface/lovs/{slug(name).replace('-', '_')}", calls)

def list_component(name, items, prompt_name):
    """items: list of dict(text, page, icon, authz, parent(optional key), key, desc)"""
    i = nid()
    LISTS[name] = i
    calls = [call("wwv_flow_imp_shared.create_list", [
        ("p_id", rid(i)),
        ("p_name", lit(name)),
        ("p_static_id", lit(slug(prompt_name))),
    ])]
    keys = {}
    for seq, it in enumerate(items, 1):
        iid = nid()
        if it.get('key'):
            keys[it['key']] = iid
        target = it.get('target') or (f"f?p=&APP_ID.:{it['page']}:&APP_SESSION.::&DEBUG.:::" if it.get('page') is not None else None)
        params = [
            ("p_id", rid(iid)),
            ("p_list_item_display_sequence", str(seq * 10)),
            ("p_list_item_link_text", lit(it['text'])),
            ("p_static_id", lit(it.get('static') or f"{slug(prompt_name)}-{seq}")),
            ("p_list_item_link_target", lit(target) if target else None),
            ("p_list_item_icon", lit(it['icon']) if it.get('icon') else None),
            ("p_list_text_01", lit(it['desc']) if it.get('desc') else None),
            ("p_list_text_02", lit(it['text02']) if it.get('text02') else None),
            ("p_list_item_disp_cond_type", lit(it['cond_type']) if it.get('cond_type') else None),
            ("p_parent_list_item_id", rid(keys[it['parent']]) if it.get('parent') else None),
            ("p_security_scheme", rid(AUTHZ[it['authz']]) if it.get('authz') else None),
            ("p_list_item_current_type", lit('TARGET_PAGE') if target and target.startswith('f?p') else None),
            ("p_list_item_current_for_pages", lit(it['current']) if it.get('current') else None),
        ]
        if it.get('current'):
            params = [(k, v) if k != "p_list_item_current_type" else (k, lit('COLON_DELIMITED_PAGE_LIST')) for k, v in params]
        calls.append(call("wwv_flow_imp_shared.create_list_item", params))
    return block(f"shared_components/navigation/lists/{prompt_name}", calls)

# ==============================================================================
# Page builders
# ==============================================================================
class Page:
    def __init__(self, pid, name, title=None, mode='NORMAL', authz=None, public=False, template=None, group=None, alias=None):
        self.alias = alias
        self.pid = pid
        self.name = name
        self.title = title or name
        self.mode = mode
        self.authz = authz
        self.public = public
        self.template = template or (T_PAGE_DIALOG if mode == 'MODAL' else T_PAGE_STD)
        self.calls = []
        self.group = group
        self.inline_css = None

    def header(self):
        return call("wwv_flow_imp_page.create_page", [
            ("p_id", str(self.pid)),
            ("p_name", lit(self.name)),
            ("p_alias", lit(self.alias or f"P{self.pid}") if self.pid != 0 else None),
            ("p_page_mode", lit('MODAL') if self.mode == 'MODAL' else None),
            ("p_step_title", lit(self.title)),
            ("p_autocomplete_on_off", lit('OFF')),
            ("p_group_id", rid(self.group) if self.group else None),
            ("p_inline_css", lines(self.inline_css) if self.inline_css else None),
            ("p_step_template", str(self.template)),
            ("p_page_template_options", lit('#DEFAULT#')),
            ("p_required_role", rid(AUTHZ[self.authz]) if self.authz else None),
            ("p_page_is_public_y_n", lit('Y') if self.public else None),
            ("p_protection_level", lit('C')),
        ])

    def render(self):
        return block(f"pages/page_{self.pid:05d}", [self.header()] + self.calls)

    # ---- regions -------------------------------------------------------------
    def static_region(self, name, html, template=T_REG_STD, seq=10, options='#DEFAULT#', position=None, cond=None):
        i = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_plug", [
            ("p_id", rid(i)),
            ("p_plug_name", lit(name)),
            ("p_static_id", lit(f"r{i}")),
            ("p_region_template_options", lit(options)),
            ("p_escape_on_http_output", lit('Y')),
            ("p_plug_template", str(template)),
            ("p_plug_display_sequence", str(seq)),
            ("p_plug_display_point", lit(position) if position else None),
            ("p_plug_item_display_point", lit('ABOVE')),
            ("p_plug_source", lines(html) if html else None),
            ("p_plug_query_num_rows", "15"),
            ("p_plug_display_condition_type", lit(cond[0]) if cond else None),
            ("p_plug_display_when_condition", lit(cond[1]) if cond else None),
            ("p_attributes", attrs({'expand_shortcuts': 'N', 'output_as': 'HTML'})),
        ]))
        return i

    def list_region(self, name, list_name, template=T_LIST_CARDS, seq=20, options='#DEFAULT#:u-colors:t-Cards--featured:t-Cards--block:t-Cards--displayIcons:t-Cards--3cols:t-Cards--animColorFill'):
        i = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_plug", [
            ("p_id", rid(i)),
            ("p_plug_name", lit(name)),
            ("p_static_id", lit(f"r{i}")),
            ("p_region_template_options", lit('#DEFAULT#:t-Region--noBorder:t-Region--hideHeader js-addHiddenHeadingRoleDesc')),
            ("p_component_template_options", lit(options)),
            ("p_plug_template", str(T_REG_STD)),
            ("p_plug_display_sequence", str(seq)),
            ("p_list_id", rid(LISTS[list_name])),
            ("p_plug_source_type", lit('NATIVE_LIST')),
            ("p_list_template_id", str(template)),
            ("p_plug_query_num_rows", "15"),
        ]))
        return i

    def ir_region(self, name, sql, columns, pk=None, link_page=None, link_item=None, seq=10, region_name=None, cond=None, extra_link_items=None):
        """columns: list of (db_column, label, type) ; type STRING/NUMBER/DATE ; hidden if label is None"""
        reg = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_plug", [
            ("p_id", rid(reg)),
            ("p_plug_name", lit(name)),
            ("p_static_id", lit(f"r{reg}")),
            ("p_region_template_options", lit('#DEFAULT#')),
            ("p_escape_on_http_output", lit('N')),
            ("p_plug_template", str(T_REG_IR)),
            ("p_plug_display_sequence", str(seq)),
            ("p_plug_item_display_point", lit('ABOVE')),
            ("p_query_type", lit('SQL')),
            ("p_plug_source", lines(sql)),
            ("p_plug_source_type", lit('NATIVE_IR')),
            ("p_plug_display_condition_type", lit(cond[0]) if cond else None),
            ("p_plug_display_when_condition", lit(cond[1]) if cond else None),
            ("p_plug_query_headings_type", lit('COLON_DELMITED_LIST')),
            ("p_prn_content_disposition", lit('ATTACHMENT')),
            ("p_prn_units", lit('INCHES')),
            ("p_prn_paper_size", lit('A4')),
            ("p_prn_width", "11.69"),
            ("p_prn_height", "8.27"),
            ("p_prn_orientation", lit('HORIZONTAL')),
        ]))
        ws = nid()
        detail = None
        if link_page and pk:
            detail = f"f?p=&APP_ID.:{link_page}:&SESSION.::&DEBUG.:{link_page}:{link_item}:#{pk}#"
        self.calls.append(call("wwv_flow_imp_page.create_worksheet", [
            ("p_id", rid(ws)),
            ("p_max_row_count", lit('1000000')),
            ("p_pagination_type", lit('ROWS_X_TO_Y')),
            ("p_pagination_display_pos", lit('BOTTOM_RIGHT')),
            ("p_report_list_mode", lit('TABS')),
            ("p_lazy_loading", "false"),
            ("p_show_detail_link", lit('C') if detail else lit('N')),
            ("p_show_notify", lit('Y')),
            ("p_download_formats", lit('CSV:HTML:XLSX:PDF')),
            ("p_enable_mail_download", lit('Y')),
            ("p_detail_link", lit(detail) if detail else None),
            ("p_detail_link_text", lit('<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>') if detail else None),
            ("p_internal_uid", str(ws)),
        ]))
        letters = []
        def ident(n):
            s = ''
            n += 1
            while n:
                n, r = divmod(n - 1, 26)
                s = chr(65 + r) + s
            return s
        visible = []
        for idx, (col, label, typ) in enumerate(columns):
            hidden = label is None
            params = [
                ("p_id", rid(nid())),
                ("p_db_column_name", lit(col)),
                ("p_display_order", str((idx + 1) * 10)),
                ("p_is_primary_key", lit('Y') if col == pk else None),
                ("p_column_identifier", lit(ident(idx))),
                ("p_column_label", lit(label or col)),
                ("p_column_type", lit(typ)),
                ("p_display_text_as", lit('HIDDEN_ESCAPE_SC') if hidden else None),
                ("p_heading_alignment", lit('RIGHT') if typ == 'NUMBER' else lit('LEFT')),
                ("p_column_alignment", lit('RIGHT') if typ == 'NUMBER' else None),
                ("p_format_mask", lit('DD/MM/YYYY') if typ == 'DATE' else None),
                ("p_tz_dependent", lit('N') if typ == 'DATE' else None),
                ("p_use_as_row_header", lit('N')),
            ]
            self.calls.append(call("wwv_flow_imp_page.create_worksheet_column", params))
            if not hidden:
                visible.append(col)
        self.calls.append(call("wwv_flow_imp_page.create_worksheet_rpt", [
            ("p_id", rid(nid())),
            ("p_application_user", lit('APXWS_DEFAULT')),
            ("p_report_seq", "10"),
            ("p_report_alias", lit(str(nid() % 1000000000))),
            ("p_status", lit('PUBLIC')),
            ("p_is_default", lit('Y')),
            ("p_report_columns", lit(':'.join(visible) + ':')),
        ]))
        return reg

    def form_region(self, name, table, seq=10, edit_ops='i:u:d'):
        i = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_plug", [
            ("p_id", rid(i)),
            ("p_plug_name", lit(name)),
            ("p_static_id", lit(f"r{i}")),
            ("p_region_template_options", lit('#DEFAULT#:t-Region--scrollBody')),
            ("p_plug_template", str(T_REG_STD)),
            ("p_plug_display_sequence", str(seq)),
            ("p_plug_item_display_point", lit('ABOVE')),
            ("p_query_type", lit('TABLE')),
            ("p_query_table", lit(table)),
            ("p_include_rowid_column", "false"),
            ("p_is_editable", "true"),
            ("p_edit_operations", lit(edit_ops)),
            ("p_lost_update_check_type", lit('VALUES')),
            ("p_plug_source_type", lit('NATIVE_FORM')),
        ]))
        return i

    # ---- buttons -------------------------------------------------------------
    def button(self, region, name, label, action='SUBMIT', position='NEXT', hot=False, seq=10,
               redirect=None, cond_item=None, cond_type=None, db_action=None, confirm=None, icon=None, exec_val=True):
        i = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_button", [
            ("p_id", rid(i)),
            ("p_button_sequence", str(seq)),
            ("p_button_plug_id", rid(region)),
            ("p_button_name", lit(name)),
            ("p_static_id", lit(slug(name) + f"-{i % 100000}")),
            ("p_button_action", lit(action)),
            ("p_button_template_options", lit('#DEFAULT#' + (':t-Button--iconLeft' if icon else ''))),
            ("p_button_template_id", str(T_BTN_ICON_TEXT if icon else T_BTN_TEXT)),
            ("p_button_is_hot", lit('Y') if hot else None),
            ("p_button_image_alt", lit(label)),
            ("p_button_position", lit(position)),
            ("p_button_redirect_url", lit(redirect) if redirect else None),
            ("p_button_execute_validations", lit('N') if not exec_val else None),
            ("p_confirm_message", lit(confirm) if confirm else None),
            ("p_confirm_style", lit('danger') if confirm else None),
            ("p_button_condition", lit(cond_item) if cond_item else None),
            ("p_button_condition_type", lit(cond_type) if cond_type else None),
            ("p_icon_css_classes", lit(icon) if icon else None),
            ("p_database_action", lit(db_action) if db_action else None),
        ]))
        return i

    # ---- items ---------------------------------------------------------------
    def item(self, region, name, label=None, display='TEXT', source=None, source_region=None, dtype='VARCHAR2',
             seq=10, required=False, pk=False, lov=None, null_text=None, maxlen=None, width=None, height=None,
             new_line=True, default=None, cond=None, read_only=False, help=None, pwd_autocomplete=None,
             placeholder=None, icon=None, label_template=None):
        i = nid()
        da = {
            'TEXT': 'NATIVE_TEXT_FIELD', 'TEXTAREA': 'NATIVE_TEXTAREA', 'SELECT': 'NATIVE_SELECT_LIST',
            'POPUP': 'NATIVE_POPUP_LOV', 'DATE': 'NATIVE_DATE_PICKER_APEX', 'NUMBER': 'NATIVE_NUMBER_FIELD',
            'YESNO': 'NATIVE_YES_NO', 'HIDDEN': 'NATIVE_HIDDEN', 'PASSWORD': 'NATIVE_PASSWORD',
            'DISPLAY': 'NATIVE_DISPLAY_ONLY',
        }[display]
        a = {}
        if display == 'TEXT':
            a = {'disabled': 'N', 'submit_when_enter_pressed': 'N', 'subtype': 'TEXT', 'trim_spaces': 'BOTH'}
        elif display == 'TEXTAREA':
            a = {'auto_height': 'N', 'character_counter': 'N', 'resizable': 'Y', 'trim_spaces': 'BOTH'}
        elif display == 'SELECT':
            a = {'execute_validations': 'Y', 'page_action_on_selection': 'NONE'}
        elif display == 'POPUP':
            a = {'case_sensitive': 'N', 'display_as': 'POPUP', 'fetch_on_search': 'N', 'initial_fetch': 'FIRST_ROWSET',
                 'manual_entry': 'N', 'match_type': 'CONTAINS', 'min_chars': '0'}
        elif display == 'DATE':
            a = {'display_as': 'POPUP', 'max_date': 'NONE', 'min_date': 'NONE', 'multiple_months': 'N',
                 'show_time': 'N', 'use_defaults': 'Y'}
        elif display == 'NUMBER':
            a = {'number_alignment': 'left', 'virtual_keyboard': 'decimal'}
        elif display == 'YESNO':
            a = {'use_defaults': 'Y'}
        elif display == 'HIDDEN':
            a = {'value_protected': 'Y'}
        elif display == 'PASSWORD':
            a = {'submit_when_enter_pressed': 'N'}
        elif display == 'DISPLAY':
            a = {'based_on': 'VALUE', 'format': 'PLAIN', 'send_on_page_submit': 'Y', 'show_line_breaks': 'Y'}
        if display == 'TEXT' and read_only:
            a['disabled'] = 'Y'
        if display == 'HIDDEN':
            label_tpl = None
        else:
            label_tpl = label_template or (T_LBL_REQ if required else T_LBL_OPT)
        params = [
            ("p_id", rid(i)),
            ("p_name", lit(name)),
            ("p_source_data_type", lit(dtype) if source_region else None),
            ("p_is_required", "true" if required and display != 'HIDDEN' else None),
            ("p_is_primary_key", "true" if pk else None),
            ("p_item_sequence", str(seq)),
            ("p_item_plug_id", rid(region)),
            ("p_item_source_plug_id", rid(source_region) if source_region else None),
            ("p_use_cache_before_default", lit('NO') if not source_region and display == 'HIDDEN' else None),
            ("p_item_default", lit(default) if default is not None else None),
            ("p_prompt", lit(label) if label and display != 'HIDDEN' else None),
            ("p_placeholder", lit(placeholder) if placeholder else None),
            ("p_format_mask", lit('DD/MM/YYYY') if display == 'DATE' else None),
            ("p_source", lit(source) if source else None),
            ("p_source_type", lit('ALWAYS_NULL') if not source and not source_region else None),
            ("p_display_as", lit(da)),
            ("p_named_lov", lit(lov) if lov else None),
            ("p_lov_display_null", lit('YES') if lov and null_text is not None else None),
            ("p_lov_null_text", lit(null_text) if lov and null_text else None),
            ("p_cSize", str(width) if width else ("30" if display in ('TEXT', 'NUMBER', 'DATE', 'PASSWORD') else ("60" if display == 'TEXTAREA' else None))),
            ("p_cMaxlength", str(maxlen) if maxlen else None),
            ("p_cHeight", str(height) if height else ("4" if display == 'TEXTAREA' else ("1" if display == 'SELECT' else None))),
            ("p_tag_attributes", lit(f'autocomplete="{pwd_autocomplete}"') if pwd_autocomplete else None),
            ("p_begin_on_new_line", lit('N') if not new_line else None),
            ("p_display_when", lit(cond[1]) if cond else None),
            ("p_display_when_type", lit(cond[0]) if cond else None),
            ("p_field_template", str(label_tpl) if label_tpl else None),
            ("p_item_icon_css_classes", lit(icon) if icon else None),
            ("p_item_template_options", lit('#DEFAULT#') if display != 'HIDDEN' else None),
            ("p_lov_display_extra", lit('NO') if lov else None),
            ("p_is_persistent", lit('N') if source_region else None),
            ("p_protection_level", lit('S') if display == 'HIDDEN' else None),
            ("p_inline_help_text", lit(help) if help else None),
            ("p_attributes", attrs(a)),
        ]
        self.calls.append(call("wwv_flow_imp_page.create_page_item", params))
        return i

    # ---- validations / processes / branches -----------------------------------
    def validation(self, name, vtype, expr, msg, item=None, seq=10, expr2=None, when_button=None):
        i = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_validation", [
            ("p_id", rid(i)),
            ("p_validation_name", lit(name)),
            ("p_static_id", lit(slug(name) + f"-{i % 100000}")),
            ("p_validation_sequence", str(seq)),
            ("p_validation", lines(expr) if '\n' in expr else lit(expr)),
            ("p_validation2", lit(expr2) if expr2 else None),
            ("p_validation_type", lit(vtype)),
            ("p_error_message", lit(msg) if msg else None),
            ("p_when_button_pressed", rid(when_button) if when_button else None),
            ("p_associated_item", rid(item) if item else None),
            ("p_error_display_location", lit('INLINE_WITH_FIELD_AND_NOTIFICATION') if item else lit('INLINE_IN_NOTIFICATION')),
        ]))

    def plsql_process(self, name, code, point='AFTER_SUBMIT', seq=10, when_button=None, success=None,
                      cond=None):
        i = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_process", [
            ("p_id", rid(i)),
            ("p_process_sequence", str(seq)),
            ("p_process_point", lit(point)),
            ("p_process_type", lit('NATIVE_PLSQL')),
            ("p_process_name", lit(name)),
            ("p_static_id", lit(slug(name) + f"-{i % 100000}")),
            ("p_process_sql_clob", lines(code)),
            ("p_process_clob_language", lit('PLSQL')),
            ("p_error_display_location", lit('INLINE_IN_NOTIFICATION')),
            ("p_process_when_button_id", rid(when_button) if when_button else None),
            ("p_process_when", lit(cond[1]) if cond else None),
            ("p_process_when_type", lit(cond[0]) if cond else None),
            ("p_process_success_message", lit(success) if success else None),
            ("p_internal_uid", str(i)),
        ]))

    def form_processes(self, region, name, success=None):
        i = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_process", [
            ("p_id", rid(i)),
            ("p_process_sequence", "10"),
            ("p_process_point", lit('BEFORE_HEADER')),
            ("p_region_id", rid(region)),
            ("p_process_type", lit('NATIVE_FORM_INIT')),
            ("p_process_name", lit('Initialize form ' + name)),
            ("p_static_id", lit(f"init-{i % 100000}")),
            ("p_internal_uid", str(i)),
        ]))
        j = nid()
        self.calls.append(call("wwv_flow_imp_page.create_page_process", [
            ("p_id", rid(j)),
            ("p_process_sequence", "20"),
            ("p_process_point", lit('AFTER_SUBMIT')),
            ("p_region_id", rid(region)),
            ("p_process_type", lit('NATIVE_FORM_DML')),
            ("p_process_name", lit('Process form ' + name)),
            ("p_static_id", lit(f"dml-{j % 100000}")),
            ("p_attributes", attrs({'lock_row': 'Y', 'prevent_lost_updates': 'Y',
                                    'return_primary_keys_after_insert': 'Y', 'target_type': 'REGION_SOURCE'})),
            ("p_error_display_location", lit('INLINE_IN_NOTIFICATION')),
            ("p_process_success_message", lit(success or 'تم الحفظ بنجاح')),
            ("p_internal_uid", str(j)),
        ]))

    def branch(self, page, seq=10, items=None, when_button=None):
        i = nid()
        target = f"f?p=&APP_ID.:{page}:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#"
        if items:
            target = f"f?p=&APP_ID.:{page}:&SESSION.::&DEBUG.::{items[0]}:{items[1]}&success_msg=#SUCCESS_MSG#"
        self.calls.append(call("wwv_flow_imp_page.create_page_branch", [
            ("p_id", rid(i)),
            ("p_branch_name", lit(f"Go To Page {page}")),
            ("p_branch_action", lit(target)),
            ("p_branch_point", lit('AFTER_PROCESSING')),
            ("p_branch_type", lit('REDIRECT_URL')),
            ("p_branch_when_button_id", rid(when_button) if when_button else None),
            ("p_branch_sequence", str(seq)),
        ]))


# ---- helpers to build CRUD pairs ---------------------------------------------
def crud(list_pid, form_pid, title_list, title_form, table, pk, sql, columns, fields, authz,
         form_extra=None, list_extra=None, delete=True, create_label='إضافة', allow_create=True, pk_dtype='NUMBER',
         pk_field=None):
    """fields: list of dict(col,label,display,required,lov,null_text,dtype,maxlen,default,new_line,help)"""
    lp = Page(list_pid, title_list, authz=authz)
    reg = lp.ir_region(title_list, sql, columns, pk=pk, link_page=form_pid, link_item=f"P{form_pid}_{pk}")
    if allow_create:
        lp.button(reg, 'CREATE', create_label, action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
                  redirect=f"f?p=&APP_ID.:{form_pid}:&SESSION.::&DEBUG.:{form_pid}::", icon='fa-plus')
    if list_extra:
        list_extra(lp, reg)

    fp = Page(form_pid, title_form, authz=authz)
    freg = fp.form_region(title_form, table)
    if pk_field:
        fp.item(freg, f"P{form_pid}_{pk}", label=pk_field, display='TEXT', source=pk, source_region=freg, dtype=pk_dtype,
                pk=True, seq=5, required=True, read_only=not allow_create)
    else:
        fp.item(freg, f"P{form_pid}_{pk}", display='HIDDEN', source=pk, source_region=freg, dtype=pk_dtype, pk=True, seq=5)
    seq = 10
    for f in fields:
        fp.item(freg, f"P{form_pid}_{f['col']}", label=f['label'], display=f.get('display', 'TEXT'),
                source=f['col'], source_region=freg, dtype=f.get('dtype', 'VARCHAR2'), seq=seq,
                required=f.get('required', False), lov=f.get('lov'), null_text=f.get('null_text'),
                maxlen=f.get('maxlen'), default=f.get('default'), new_line=f.get('new_line', True),
                help=f.get('help'), height=f.get('height'))
        seq += 10
    cancel = fp.button(freg, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10,
                       redirect=f"f?p=&APP_ID.:{list_pid}:&SESSION.::&DEBUG.:::", exec_val=False)
    if delete:
        fp.button(freg, 'DELETE', 'حذف', position='DELETE', seq=20, cond_item=f"P{form_pid}_{pk}",
                  cond_type='ITEM_IS_NOT_NULL', db_action='DELETE', confirm='هل تريد حذف هذا السجل؟', exec_val=False)
    fp.button(freg, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item=f"P{form_pid}_{pk}",
              cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    if allow_create:
        fp.button(freg, 'CREATE', 'إنشاء', position='CREATE', hot=True, seq=40, cond_item=f"P{form_pid}_{pk}",
                  cond_type='ITEM_IS_NULL', db_action='INSERT')
    if form_extra:
        form_extra(fp, freg)
    fp.form_processes(freg, title_form)
    fp.branch(list_pid, seq=100)
    return [lp, fp]
