#!/usr/bin/env python3
"""Builds f145032.sql — MOINFO unified app, batch 1 (core / administration)."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gen_app import *

OUT = sys.argv[1] if len(sys.argv) > 1 else 'f145032.sql'

def rd(name):
    return open(os.path.join(BASE, name), encoding='utf-8').read()

parts = []

# ------------------------------------------------------------------------------
# 1) Header + application
# ------------------------------------------------------------------------------
NAV_MENU = nid()
NAV_BAR = nid()
HOME_CARDS = nid()
PG_ADMIN = nid()

parts.append(f"""prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- Application 145032 (Unified-System) — APEX 26.2.1
-- Generated from build_app.py
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.04.07'
,p_release=>'26.2.1'
,p_default_workspace_id=>{WS_ID}
,p_default_application_id=>{APP_ID}
,p_default_id_offset=>0
,p_default_owner=>'{OWNER}'
);
end;
/
prompt --application/delete_application
begin
wwv_flow_imp.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'{OWNER}')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Unified-System')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'UNIFIED-SYSTEM')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'AC8D7C8F7700E7ED7F1AA62531C1B0FAD52EA4DF6E7DCEE867674ABDFC934CA4'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'26.1'
,p_flow_language=>'ar'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'N'
,p_date_format=>'DD/MM/YYYY'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_flow_image_prefix=>nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication_id=>{rid(AUTH_ID)}
,p_application_tab_set=>0
,p_logo_type=>'T'
,p_logo_text=>{lit('النظام الموحد')}
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>{lit('النظام الموحد')}
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>2461354184302
,p_print_server_type=>'INSTANCE'
,p_file_storage=>'DB'
,p_is_pwa=>'Y'
,p_pwa_is_installable=>'N'
,p_pwa_is_push_enabled=>'N'
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_id=>{rid(NAV_MENU)}
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>{T_LIST_SIDE_NAV}
,p_nav_list_template_options=>'#DEFAULT#:t-TreeNav--styleA:js-navCollapsed--hidden'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>{rid(NAV_BAR)}
,p_nav_bar_list_template_id=>{T_LIST_NAVBAR}
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
""")
parts.append(rd('plugin_settings.sql'))

# ------------------------------------------------------------------------------
# 2) Authorization schemes
# ------------------------------------------------------------------------------
authz_calls = [
    authorization('ADMIN', 'return MOINFO_SEC.IS_ADMIN;', 'هذه الصفحة لمدير النظام فقط'),
]
for code in ['HR', 'EVT', 'MED', 'TSK', 'ATT', 'HD', 'PRC', 'STD', 'ADV', 'OMI', 'NWS']:
    authz_calls.append(authorization(f'MOD_{code}', f"return MOINFO_SEC.HAS_MODULE('{code}');",
                                     'لا تملك صلاحية على هذه الوحدة'))
# list entries reference authorizations, so they come first
parts.append(block("shared_components/security/authorizations/moinfo", authz_calls))

# ------------------------------------------------------------------------------
# 3) Lists (navigation)
# ------------------------------------------------------------------------------
LISTS['Navigation Bar'] = NAV_BAR
LISTS['Navigation Menu'] = NAV_MENU

def list_with_id(lid, name, items, prompt_name):
    blk = list_component(name, items, prompt_name)
    # replace auto id with the fixed one
    auto = LISTS[name]
    LISTS[name] = lid
    return blk.replace(rid(auto), rid(lid), 1)

ADMIN_ITEMS = [
    dict(text='المستخدمون والصلاحيات', page=20, icon='fa-users', authz='ADMIN', current='20,21,23',
         desc='الحسابات، وكلمات المرور، والوحدات الممنوحة لكل مستخدم'),
    dict(text='الهيكل التنظيمي', page=30, icon='fa-sitemap', authz='ADMIN', current='30,31',
         desc='القطاعات والدوائر والأقسام'),
    dict(text='الموظفون', page=50, icon='fa-id-badge', authz='ADMIN', current='50,51',
         desc='البيانات الأساسية المشتركة للموظفين'),
    dict(text='المسميات الوظيفية', page=40, icon='fa-briefcase', authz='ADMIN', current='40,41'),
    dict(text='القوائم المرجعية', page=60, icon='fa-list-ul', authz='ADMIN', current='60,61',
         desc='الحالات والأنواع والتصنيفات لكل الوحدات'),
    dict(text='الدول', page=62, icon='fa-globe', authz='ADMIN', current='62,63'),
    dict(text='الولايات', page=64, icon='fa-map-marker', authz='ADMIN', current='64,65'),
    dict(text='الإعدادات', page=80, icon='fa-sliders', authz='ADMIN', current='80,81'),
    dict(text='سجل التدقيق', page=70, icon='fa-history', authz='ADMIN', current='70',
         desc='كل الإضافات والتعديلات والحذف'),
    dict(text='سجل الدخول', page=71, icon='fa-sign-in', authz='ADMIN', current='71'),
]

menu_items = [dict(text='الرئيسية', page=1, icon='fa-home', static='home', key='home')]
menu_items.append(dict(text='إدارة النظام', target='#', icon='fa-cogs', key='admin', authz='ADMIN', static='admin'))
for it in ADMIN_ITEMS:
    d = dict(it); d['parent'] = 'admin'; d.pop('desc', None)
    menu_items.append(d)
parts.append(list_with_id(NAV_MENU, 'Navigation Menu', menu_items, 'navigation_menu'))

bar_items = [
    dict(text='&APP_USER.', target='#', icon='fa-user', text02='has-username', key='user', static='app-user'),
    dict(text='تغيير كلمة المرور', page=10, icon='fa-key', parent='user', static='change-password',
         cond_type='USER_IS_NOT_PUBLIC_USER'),
    dict(text='---', target='separator', parent='user', static='sep', cond_type='USER_IS_NOT_PUBLIC_USER'),
    dict(text='تسجيل الخروج', target='&LOGOUT_URL.', icon='fa-sign-out', parent='user', static='sign-out',
         cond_type='USER_IS_NOT_PUBLIC_USER'),
]
parts.append(list_with_id(NAV_BAR, 'Navigation Bar', bar_items, 'navigation_bar'))

home_items = [dict(it, static=f"home-{i}") for i, it in enumerate(ADMIN_ITEMS)]
parts.append(list_component('Home Admin Cards', home_items, 'home_admin_cards'))

# ------------------------------------------------------------------------------
# 4) Files, LOVs, groups, theme, build options, authentication
# ------------------------------------------------------------------------------
parts.append(rd('app_files.sql'))
parts.append(rd('lov_boolean.sql'))
parts.append(lov('MODULES', "select MODULE_NAME_AR d, MODULE_CODE r from MOINFO_MODULES where IS_ACTIVE = 'Y' order by SORT_ORDER"))
parts.append(lov('ROLES', """select r.ROLE_NAME_AR || nvl2(m.MODULE_NAME_AR, ' (' || m.MODULE_NAME_AR || ')', '') d, r.ROLE_ID r
  from MOINFO_ROLES r left join MOINFO_MODULES m on m.MODULE_CODE = r.MODULE_CODE
 where r.IS_ACTIVE = 'Y'
 order by r.MODULE_CODE nulls first, r.ROLE_RANK"""))
parts.append(lov('UNITS', "select UNIT_PATH_AR d, UNIT_ID r from MOINFO_V_UNITS where IS_ACTIVE = 'Y'"))
parts.append(lov('LEVELS', "select LEVEL_NAME_AR d, LEVEL_ID r from MOINFO_LEVELS where IS_ACTIVE = 'Y' order by LEVEL_DEPTH"))
parts.append(lov('TITLES', "select TITLE_NAME_AR d, TITLE_ID r from MOINFO_TITLES where IS_ACTIVE = 'Y' order by SORT_ORDER, TITLE_NAME_AR"))
parts.append(lov('EMPLOYEES', """select e.NAME_AR || nvl2(e.EMPLOYEE_NO, ' - ' || e.EMPLOYEE_NO, '') d, e.EMPLOYEE_ID r
  from MOINFO_EMPLOYEES e where e.IS_ACTIVE = 'Y' order by e.NAME_AR"""))
parts.append(lov('LOOKUP_TYPES', "select TYPE_NAME_AR || ' (' || LOOKUP_TYPE || ')' d, LOOKUP_TYPE r from MOINFO_LOOKUP_TYPES where IS_ACTIVE = 'Y' order by MODULE_CODE, TYPE_NAME_AR"))
parts.append(lov('GOVERNORATES', "select NAME_AR d, GOVERNORATE_ID r from MOINFO_GOVERNORATES where IS_ACTIVE = 'Y' order by SORT_ORDER, NAME_AR"))
parts.append(static_lov('GENDER', [('ذكر', 'M'), ('أنثى', 'F')]))
parts.append(static_lov('DATA_SCOPE', [('كل البيانات', 'ALL'), ('وحدته التنظيمية وما تحتها', 'UNIT'), ('سجلاته فقط', 'OWN')]))

parts.append(block("pages/page_groups", [call("wwv_flow_imp_page.create_page_group", [
    ("p_id", rid(PG_ADMIN)), ("p_group_name", lit('Administration')), ("p_static_id", lit('administration'))])]))
parts.append(rd('theme.sql'))
parts.append(rd('build_options.sql'))
parts.append(block("shared_components/security/authentications/moinfo_auth", [call(
    "wwv_flow_imp_shared.create_authentication", [
        ("p_id", rid(AUTH_ID)),
        ("p_name", lit('MOINFO_AUTH')),
        ("p_static_id", lit('moinfo-auth')),
        ("p_scheme_type", lit('NATIVE_CUSTOM')),
        ("p_attributes", attrs({'authentication_function': 'MOINFO_AUTH.AUTHENTICATE',
                                'enable_legacy_attributes': 'N',
                                'post_logout_procedure': 'MOINFO_AUTH.POST_LOGOUT'})),
        ("p_invalid_session_type", lit('LOGIN')),
        ("p_post_auth_process", lit('MOINFO_AUTH.POST_AUTH')),
        ("p_use_secure_cookie_yn", lit('N')),
        ("p_ras_mode", "0"),
    ])]))

# ------------------------------------------------------------------------------
# 5) Pages
# ------------------------------------------------------------------------------
pages = []

# 0 - Global
p0 = Page(0, 'Global Page')
pages.append(p0)

# 1 - Home
p1 = Page(1, 'الرئيسية', title='النظام الموحد', alias='HOME')
p1.static_region('النظام الموحد', '<p>مرحبًا &APP_USER.</p>', template=T_REG_HERO, seq=10, position='REGION_POSITION_01')
p1.list_region('إدارة النظام', 'Home Admin Cards', seq=20)
p1.plsql_process('Force password change', """if MOINFO_AUTH.MUST_CHANGE_PASSWORD(:APP_USER) then
    apex_util.redirect_url(apex_page.get_url(p_page => 10));
end if;""", point='BEFORE_HEADER', seq=10)
pages.append(p1)

# 9999 - Login
pl = Page(9999, 'تسجيل الدخول', title='النظام الموحد - تسجيل الدخول', public=True, template=T_PAGE_LOGIN, alias='LOGIN')
lreg = pl.static_region('النظام الموحد', None, template=T_REG_LOGIN, seq=10)
u = pl.item(lreg, 'P9999_USERNAME', label='اسم المستخدم', display='TEXT', seq=10, placeholder='اسم المستخدم',
            icon='fa-user', label_template=T_LBL_HIDDEN, maxlen=100, width=40, pwd_autocomplete='username')
pw = pl.item(lreg, 'P9999_PASSWORD', label='كلمة المرور', display='PASSWORD', seq=20, placeholder='كلمة المرور',
             icon='fa-key', label_template=T_LBL_HIDDEN, maxlen=100, width=40, pwd_autocomplete='current-password')
pl.button(lreg, 'LOGIN', 'تسجيل الدخول', position='NEXT', hot=True, seq=40)
pl.plsql_process('Login', "apex_authentication.login(p_username => :P9999_USERNAME, p_password => :P9999_PASSWORD);",
                 seq=20)
pl.calls.append(call("wwv_flow_imp_page.create_page_process", [
    ("p_id", rid(nid())), ("p_process_sequence", "30"), ("p_process_point", lit('AFTER_SUBMIT')),
    ("p_process_type", lit('NATIVE_SESSION_STATE')), ("p_process_name", lit('Clear Page(s) Cache')),
    ("p_static_id", lit('clear-page-s-cache')),
    ("p_attributes", attrs({'type': 'CLEAR_CACHE_CURRENT_PAGE'})),
    ("p_error_display_location", lit('INLINE_IN_NOTIFICATION')),
]))
pages.append(pl)

# 10 - Change password
p10 = Page(10, 'تغيير كلمة المرور', alias='CHANGE-PASSWORD')
r10 = p10.static_region('تغيير كلمة المرور', '<p>يجب أن تتكون كلمة المرور من 8 أحرف على الأقل، وتحتوي على حروف وأرقام.</p>', seq=10)
old = p10.item(r10, 'P10_OLD_PASSWORD', label='كلمة المرور الحالية', display='PASSWORD', seq=10, required=True,
               maxlen=100, pwd_autocomplete='current-password')
new = p10.item(r10, 'P10_NEW_PASSWORD', label='كلمة المرور الجديدة', display='PASSWORD', seq=20, required=True,
               maxlen=100, pwd_autocomplete='new-password')
cnf = p10.item(r10, 'P10_CONFIRM_PASSWORD', label='تأكيد كلمة المرور الجديدة', display='PASSWORD', seq=30,
               required=True, maxlen=100, pwd_autocomplete='new-password')
p10.button(r10, 'CHANGE', 'تغيير كلمة المرور', position='NEXT', hot=True, seq=10)
p10.validation('Password rules', 'FUNC_BODY_RETURNING_ERR_TEXT',
               'return MOINFO_AUTH.VALIDATE_PASSWORD_RULES(:P10_NEW_PASSWORD);', None, item=new, seq=10, expr2='PLSQL')
p10.validation('Passwords match', 'EXPRESSION', ':P10_NEW_PASSWORD = :P10_CONFIRM_PASSWORD',
               'كلمتا المرور غير متطابقتين', item=cnf, seq=20, expr2='PLSQL')
p10.validation('New differs from old', 'EXPRESSION', ':P10_NEW_PASSWORD <> :P10_OLD_PASSWORD',
               'كلمة المرور الجديدة يجب أن تختلف عن الحالية', item=new, seq=30, expr2='PLSQL')
p10.plsql_process('Change password', """if not MOINFO_AUTH.CHANGE_PASSWORD(:APP_USER, :P10_OLD_PASSWORD, :P10_NEW_PASSWORD) then
    apex_error.add_error(
        p_message          => 'كلمة المرور الحالية غير صحيحة',
        p_display_location => apex_error.c_inline_in_notification);
end if;""", seq=10, success='تم تغيير كلمة المرور')
p10.branch(1, seq=10)
pages.append(p10)

# 20/21 - Users
def users_form_extra(fp, freg):
    pid = fp.pid
    pwd = fp.item(freg, f'P{pid}_NEW_PASSWORD', label='كلمة مرور مؤقتة', display='PASSWORD', seq=200, maxlen=100,
                  pwd_autocomplete='new-password',
                  help='مطلوبة عند الإنشاء. عند التعديل اتركها فارغة للإبقاء على كلمة المرور الحالية. يُطلب من المستخدم تغييرها عند أول دخول.')
    fp.validation('Password required on create', 'EXPRESSION',
                  f':P{pid}_USER_ID is not null or :P{pid}_NEW_PASSWORD is not null',
                  'أدخل كلمة مرور مؤقتة للمستخدم الجديد', item=pwd, seq=10, expr2='PLSQL')
    fp.validation('Password rules', 'FUNC_BODY_RETURNING_ERR_TEXT',
                  f"if :P{pid}_NEW_PASSWORD is null then return null; end if;\nreturn MOINFO_AUTH.VALIDATE_PASSWORD_RULES(:P{pid}_NEW_PASSWORD);",
                  None, item=pwd, seq=20, expr2='PLSQL')
    unlock = fp.button(freg, 'UNLOCK', 'فك القفل وتصفير المحاولات', position='EDIT', seq=25,
                       cond_item=f'P{pid}_USER_ID', cond_type='ITEM_IS_NOT_NULL', exec_val=False)
    fp.plsql_process('Normalize username', f":P{pid}_USERNAME := upper(trim(:P{pid}_USERNAME));", seq=5,
                     cond=('REQUEST_NOT_EQUAL_CONDITION', 'DELETE'))
    fp.plsql_process('Set password', f"""if :P{pid}_NEW_PASSWORD is not null then
    MOINFO_AUTH.SET_PASSWORD(:P{pid}_USER_ID, :P{pid}_NEW_PASSWORD, 'Y');
end if;""", seq=30, cond=('REQUEST_NOT_EQUAL_CONDITION', 'DELETE'))
    fp.plsql_process('Unlock', f"MOINFO_ADMIN.UNLOCK_USER(:P{pid}_USER_ID);", seq=40, when_button=unlock,
                     success='تم فك القفل')
    # granted modules
    g = fp.ir_region('الوحدات الممنوحة', f"""select um.USER_MODULE_ID,
       m.MODULE_NAME_AR,
       r.ROLE_NAME_AR,
       case um.DATA_SCOPE when 'ALL' then 'كل البيانات' when 'UNIT' then 'الوحدة التنظيمية' else 'سجلاته فقط' end as DATA_SCOPE_AR,
       u.UNIT_PATH_AR,
       case um.IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR
  from MOINFO_USER_MODULES um
  join MOINFO_MODULES m on m.MODULE_CODE = um.MODULE_CODE
  join MOINFO_ROLES r on r.ROLE_ID = um.ROLE_ID
  left join MOINFO_V_UNITS u on u.UNIT_ID = um.SCOPE_UNIT_ID
 where um.USER_ID = :P{pid}_USER_ID""",
        [('USER_MODULE_ID', None, 'NUMBER'), ('MODULE_NAME_AR', 'الوحدة', 'STRING'), ('ROLE_NAME_AR', 'الدور', 'STRING'),
         ('DATA_SCOPE_AR', 'نطاق البيانات', 'STRING'), ('UNIT_PATH_AR', 'الوحدة التنظيمية للنطاق', 'STRING'),
         ('IS_ACTIVE_AR', 'نشط', 'STRING')],
        pk='USER_MODULE_ID', link_page=23, link_item='P23_USER_MODULE_ID', seq=20,
        cond=('ITEM_IS_NOT_NULL', f'P{pid}_USER_ID'))
    fp.button(g, 'ADD_MODULE', 'منح وحدة', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
              redirect=f"f?p=&APP_ID.:23:&SESSION.::&DEBUG.:23:P23_USER_ID:&P{pid}_USER_ID.", icon='fa-plus')

pages += crud(20, 21, 'المستخدمون', 'المستخدم', 'MOINFO_USERS', 'USER_ID',
    """select u.USER_ID, u.USERNAME, u.DISPLAY_NAME, e.NAME_AR as EMPLOYEE_NAME, u.EMAIL,
       case u.IS_SYS_ADMIN when 'Y' then 'نعم' else 'لا' end as IS_SYS_ADMIN_AR,
       case u.IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR,
       case when c.LOCKED_UNTIL > systimestamp then 'مقفل' end as LOCK_STATUS,
       to_char(cast(c.LAST_LOGIN_AT as date), 'DD/MM/YYYY HH24:MI') as LAST_LOGIN,
       (select listagg(m.MODULE_NAME_AR, '، ') within group (order by m.SORT_ORDER)
          from MOINFO_USER_MODULES um join MOINFO_MODULES m on m.MODULE_CODE = um.MODULE_CODE
         where um.USER_ID = u.USER_ID and um.IS_ACTIVE = 'Y') as MODULES
  from MOINFO_USERS u
  left join MOINFO_EMPLOYEES e on e.EMPLOYEE_ID = u.EMPLOYEE_ID
  left join MOINFO_USER_CREDENTIALS c on c.USER_ID = u.USER_ID""",
    [('USER_ID', None, 'NUMBER'), ('USERNAME', 'اسم المستخدم', 'STRING'), ('DISPLAY_NAME', 'الاسم', 'STRING'),
     ('EMPLOYEE_NAME', 'الموظف', 'STRING'), ('EMAIL', 'البريد', 'STRING'), ('MODULES', 'الوحدات', 'STRING'),
     ('IS_SYS_ADMIN_AR', 'مدير النظام', 'STRING'), ('IS_ACTIVE_AR', 'نشط', 'STRING'),
     ('LOCK_STATUS', 'القفل', 'STRING'), ('LAST_LOGIN', 'آخر دخول', 'STRING')],
    [dict(col='USERNAME', label='اسم المستخدم', required=True, maxlen=100),
     dict(col='DISPLAY_NAME', label='الاسم الظاهر', required=True, maxlen=300),
     dict(col='EMPLOYEE_ID', label='الموظف المرتبط', display='POPUP', lov='EMPLOYEES', null_text='', dtype='NUMBER'),
     dict(col='EMAIL', label='البريد الإلكتروني', maxlen=255),
     dict(col='HOME_MODULE', label='الوحدة الافتراضية', display='SELECT', lov='MODULES', null_text='- بلا -'),
     dict(col='IS_SYS_ADMIN', label='مدير النظام', display='YESNO', default='N'),
     dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
    'ADMIN', form_extra=users_form_extra, delete=False)

# 23 - Grant module
p23 = Page(23, 'منح وحدة', authz='ADMIN')
r23 = p23.form_region('منح وحدة', 'MOINFO_USER_MODULES')
p23.item(r23, 'P23_USER_MODULE_ID', display='HIDDEN', source='USER_MODULE_ID', source_region=r23, dtype='NUMBER', pk=True, seq=5)
p23.item(r23, 'P23_USER_ID', display='HIDDEN', source='USER_ID', source_region=r23, dtype='NUMBER', seq=6)
p23.item(r23, 'P23_MODULE_CODE', label='الوحدة', display='SELECT', source='MODULE_CODE', source_region=r23, lov='MODULES',
         null_text='- اختر -', required=True, seq=10)
p23.item(r23, 'P23_ROLE_ID', label='الدور', display='SELECT', source='ROLE_ID', source_region=r23, lov='ROLES', dtype='NUMBER',
         null_text='- اختر -', required=True, seq=20)
p23.item(r23, 'P23_DATA_SCOPE', label='نطاق البيانات', display='SELECT', source='DATA_SCOPE', source_region=r23, lov='DATA_SCOPE',
         required=True, default='UNIT', seq=30)
p23.item(r23, 'P23_SCOPE_UNIT_ID', label='الوحدة التنظيمية للنطاق', display='POPUP', source='SCOPE_UNIT_ID', source_region=r23,
         lov='UNITS', null_text='', dtype='NUMBER', seq=40,
         help='للنطاق "الوحدة التنظيمية": إن تُركت فارغة تُستخدم وحدة الموظف المرتبط بالحساب.')
p23.item(r23, 'P23_IS_ACTIVE', label='نشط', display='YESNO', source='IS_ACTIVE', source_region=r23, default='Y', seq=50)
back = "f?p=&APP_ID.:21:&SESSION.::&DEBUG.::P21_USER_ID:&P23_USER_ID."
p23.button(r23, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10, redirect=back, exec_val=False)
p23.button(r23, 'DELETE', 'سحب الوحدة', position='DELETE', seq=20, cond_item='P23_USER_MODULE_ID', cond_type='ITEM_IS_NOT_NULL',
           db_action='DELETE', confirm='هل تريد سحب هذه الوحدة من المستخدم؟', exec_val=False)
p23.button(r23, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item='P23_USER_MODULE_ID',
           cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
p23.button(r23, 'CREATE', 'منح', position='CREATE', hot=True, seq=40, cond_item='P23_USER_MODULE_ID',
           cond_type='ITEM_IS_NULL', db_action='INSERT')
p23.form_processes(r23, 'Grant')
p23.branch(21, seq=100, items=('P21_USER_ID', '&P23_USER_ID.'))
pages.append(p23)

# 30/31 - Units
pages += crud(30, 31, 'الهيكل التنظيمي', 'وحدة تنظيمية', 'MOINFO_UNITS', 'UNIT_ID',
    """select v.UNIT_ID, v.UNIT_PATH_AR, v.UNIT_NAME_AR, v.LEVEL_NAME_AR, v.UNIT_CODE, v.TREE_DEPTH, v.SORT_ORDER,
       case v.IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR,
       (select count(*) from MOINFO_EMPLOYEES e where e.UNIT_ID = v.UNIT_ID) as EMPLOYEES_COUNT
  from MOINFO_V_UNITS v""",
    [('UNIT_ID', None, 'NUMBER'), ('UNIT_PATH_AR', 'المسار', 'STRING'), ('UNIT_NAME_AR', 'الاسم', 'STRING'),
     ('LEVEL_NAME_AR', 'المستوى', 'STRING'), ('UNIT_CODE', 'الرمز', 'STRING'), ('TREE_DEPTH', 'العمق', 'NUMBER'),
     ('SORT_ORDER', 'الترتيب', 'NUMBER'), ('EMPLOYEES_COUNT', 'الموظفون', 'NUMBER'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
    [dict(col='PARENT_ID', label='تتبع الوحدة', display='POPUP', lov='UNITS', null_text='', dtype='NUMBER',
          help='اتركها فارغة للوحدات العليا (القطاعات)'),
     dict(col='LEVEL_ID', label='المستوى', display='SELECT', lov='LEVELS', null_text='- اختر -', dtype='NUMBER', required=True),
     dict(col='UNIT_NAME_AR', label='الاسم بالعربية', required=True, maxlen=255),
     dict(col='UNIT_NAME_EN', label='الاسم بالإنجليزية', maxlen=255),
     dict(col='UNIT_CODE', label='الرمز', maxlen=30),
     dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER', new_line=False),
     dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y')],
    'ADMIN')

# 40/41 - Titles
pages += crud(40, 41, 'المسميات الوظيفية', 'مسمى وظيفي', 'MOINFO_TITLES', 'TITLE_ID',
    """select TITLE_ID, TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER,
       case IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR
  from MOINFO_TITLES""",
    [('TITLE_ID', None, 'NUMBER'), ('TITLE_NAME_AR', 'المسمى', 'STRING'), ('TITLE_NAME_EN', 'بالإنجليزية', 'STRING'),
     ('SORT_ORDER', 'الترتيب', 'NUMBER'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
    [dict(col='TITLE_NAME_AR', label='المسمى بالعربية', required=True, maxlen=255),
     dict(col='TITLE_NAME_EN', label='المسمى بالإنجليزية', maxlen=255),
     dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER'),
     dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
    'ADMIN')

# 50/51 - Employees
pages += crud(50, 51, 'الموظفون', 'موظف', 'MOINFO_EMPLOYEES', 'EMPLOYEE_ID',
    """select e.EMPLOYEE_ID, e.EMPLOYEE_NO, e.NAME_AR, e.NAME_EN, u.UNIT_PATH_AR, t.TITLE_NAME_AR,
       e.MOBILE, e.PHONE_EXT, e.EMAIL, e.HIRE_DATE,
       case e.IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR
  from MOINFO_EMPLOYEES e
  left join MOINFO_V_UNITS u on u.UNIT_ID = e.UNIT_ID
  left join MOINFO_TITLES t on t.TITLE_ID = e.TITLE_ID""",
    [('EMPLOYEE_ID', None, 'NUMBER'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'), ('NAME_AR', 'الاسم', 'STRING'),
     ('NAME_EN', 'الاسم بالإنجليزية', 'STRING'), ('UNIT_PATH_AR', 'الوحدة التنظيمية', 'STRING'),
     ('TITLE_NAME_AR', 'المسمى', 'STRING'), ('MOBILE', 'الجوال', 'STRING'), ('PHONE_EXT', 'التحويلة', 'STRING'),
     ('EMAIL', 'البريد', 'STRING'), ('HIRE_DATE', 'تاريخ التعيين', 'DATE'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
    [dict(col='EMPLOYEE_NO', label='الرقم الوظيفي', maxlen=30),
     dict(col='NAME_AR', label='الاسم بالعربية', required=True, maxlen=300),
     dict(col='NAME_EN', label='الاسم بالإنجليزية', maxlen=300),
     dict(col='UNIT_ID', label='الوحدة التنظيمية', display='POPUP', lov='UNITS', null_text='', dtype='NUMBER'),
     dict(col='TITLE_ID', label='المسمى الوظيفي', display='SELECT', lov='TITLES', null_text='- بلا -', dtype='NUMBER'),
     dict(col='GENDER', label='الجنس', display='SELECT', lov='GENDER', null_text='- -'),
     dict(col='HIRE_DATE', label='تاريخ التعيين', display='DATE', dtype='DATE', new_line=False),
     dict(col='MOBILE', label='الجوال', maxlen=30),
     dict(col='PHONE_EXT', label='التحويلة', maxlen=20, new_line=False),
     dict(col='EMAIL', label='البريد الإلكتروني', maxlen=255),
     dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y')],
    'ADMIN')

# 60/61 - Lookups
pages += crud(60, 61, 'القوائم المرجعية', 'قيمة مرجعية', 'MOINFO_LOOKUPS', 'LOOKUP_ID',
    """select l.LOOKUP_ID, m.MODULE_NAME_AR, t.TYPE_NAME_AR, l.LOOKUP_TYPE, l.LOOKUP_CODE, l.NAME_AR, l.NAME_EN, l.SORT_ORDER,
       case l.IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR
  from MOINFO_LOOKUPS l
  join MOINFO_LOOKUP_TYPES t on t.LOOKUP_TYPE = l.LOOKUP_TYPE
  join MOINFO_MODULES m on m.MODULE_CODE = t.MODULE_CODE""",
    [('LOOKUP_ID', None, 'NUMBER'), ('MODULE_NAME_AR', 'الوحدة', 'STRING'), ('TYPE_NAME_AR', 'القائمة', 'STRING'),
     ('LOOKUP_TYPE', 'رمز القائمة', 'STRING'), ('LOOKUP_CODE', 'الرمز', 'STRING'), ('NAME_AR', 'الاسم', 'STRING'),
     ('NAME_EN', 'بالإنجليزية', 'STRING'), ('SORT_ORDER', 'الترتيب', 'NUMBER'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
    [dict(col='LOOKUP_TYPE', label='القائمة', display='SELECT', lov='LOOKUP_TYPES', null_text='- اختر -', required=True),
     dict(col='NAME_AR', label='الاسم بالعربية', required=True, maxlen=255),
     dict(col='NAME_EN', label='الاسم بالإنجليزية', maxlen=255),
     dict(col='LOOKUP_CODE', label='الرمز', maxlen=50,
          help='اختياري. بعض القيم يعتمد عليها النظام برمزها، مثل حالات المهام DONE وCANCELLED، فلا تغيّر رموزها.'),
     dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER', new_line=False),
     dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y')],
    'ADMIN', delete=False)

# 62/63 - Countries
pages += crud(62, 63, 'الدول', 'دولة', 'MOINFO_COUNTRIES', 'COUNTRY_ID',
    """select COUNTRY_ID, ISO2, NAME_AR, NAME_EN, NATIONALITY_AR, SORT_ORDER,
       case IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR
  from MOINFO_COUNTRIES""",
    [('COUNTRY_ID', None, 'NUMBER'), ('ISO2', 'الرمز', 'STRING'), ('NAME_AR', 'الدولة', 'STRING'),
     ('NAME_EN', 'بالإنجليزية', 'STRING'), ('NATIONALITY_AR', 'الجنسية', 'STRING'), ('SORT_ORDER', 'الترتيب', 'NUMBER'),
     ('IS_ACTIVE_AR', 'نشط', 'STRING')],
    [dict(col='NAME_AR', label='الدولة بالعربية', required=True, maxlen=150),
     dict(col='NAME_EN', label='بالإنجليزية', maxlen=150),
     dict(col='NATIONALITY_AR', label='الجنسية', maxlen=150),
     dict(col='ISO2', label='رمز ISO', maxlen=2, new_line=False),
     dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER'),
     dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
    'ADMIN')

# 64/65 - Wilayats
pages += crud(64, 65, 'الولايات', 'ولاية', 'MOINFO_WILAYATS', 'WILAYAT_ID',
    """select w.WILAYAT_ID, g.NAME_AR as GOVERNORATE_AR, w.NAME_AR, w.NAME_EN, w.SORT_ORDER,
       case w.IS_ACTIVE when 'Y' then 'نعم' else 'لا' end as IS_ACTIVE_AR
  from MOINFO_WILAYATS w join MOINFO_GOVERNORATES g on g.GOVERNORATE_ID = w.GOVERNORATE_ID""",
    [('WILAYAT_ID', None, 'NUMBER'), ('GOVERNORATE_AR', 'المحافظة', 'STRING'), ('NAME_AR', 'الولاية', 'STRING'),
     ('NAME_EN', 'بالإنجليزية', 'STRING'), ('SORT_ORDER', 'الترتيب', 'NUMBER'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
    [dict(col='GOVERNORATE_ID', label='المحافظة', display='SELECT', lov='GOVERNORATES', null_text='- اختر -',
          dtype='NUMBER', required=True),
     dict(col='NAME_AR', label='الولاية بالعربية', required=True, maxlen=150),
     dict(col='NAME_EN', label='بالإنجليزية', maxlen=150),
     dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER'),
     dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
    'ADMIN')

# 70 - Audit log
p70 = Page(70, 'سجل التدقيق', authz='ADMIN')
p70.ir_region('سجل التدقيق', """select a.AUDIT_ID,
       to_char(cast(a.CHANGED_AT as date), 'DD/MM/YYYY HH24:MI:SS') as CHANGED_AT_TXT,
       a.CHANGED_BY,
       a.TABLE_NAME,
       a.ROW_PK,
       case a.ACTION when 'I' then 'إضافة' when 'U' then 'تعديل' else 'حذف' end as ACTION_AR,
       dbms_lob.substr(a.OLD_DATA, 1500, 1) as OLD_DATA,
       dbms_lob.substr(a.NEW_DATA, 1500, 1) as NEW_DATA
  from MOINFO_AUDIT_LOG a
 order by a.AUDIT_ID desc""",
    [('AUDIT_ID', 'الرقم', 'NUMBER'), ('CHANGED_AT_TXT', 'الوقت', 'STRING'), ('CHANGED_BY', 'المستخدم', 'STRING'),
     ('TABLE_NAME', 'الجدول', 'STRING'), ('ROW_PK', 'رقم السجل', 'STRING'), ('ACTION_AR', 'العملية', 'STRING'),
     ('OLD_DATA', 'قبل', 'STRING'), ('NEW_DATA', 'بعد', 'STRING')])
pages.append(p70)

# 71 - Login history
p71 = Page(71, 'سجل الدخول', authz='ADMIN')
p71.ir_region('سجل الدخول', """select h.LOGIN_ID,
       to_char(cast(h.LOGIN_AT as date), 'DD/MM/YYYY HH24:MI:SS') as LOGIN_AT_TXT,
       to_char(cast(h.LOGOUT_AT as date), 'DD/MM/YYYY HH24:MI:SS') as LOGOUT_AT_TXT,
       h.USERNAME,
       case h.IS_SUCCESS when 'Y' then 'ناجح' else 'فاشل' end as RESULT_AR,
       case h.FAILURE_REASON
            when 'USER_NOT_FOUND' then 'مستخدم غير موجود'
            when 'INACTIVE' then 'حساب غير نشط'
            when 'LOCKED' then 'حساب مقفل'
            when 'WRONG_PASSWORD' then 'كلمة مرور خاطئة'
       end as REASON_AR,
       h.IP_ADDRESS
  from MOINFO_LOGIN_HISTORY h
 order by h.LOGIN_ID desc""",
    [('LOGIN_ID', 'الرقم', 'NUMBER'), ('LOGIN_AT_TXT', 'وقت الدخول', 'STRING'), ('LOGOUT_AT_TXT', 'وقت الخروج', 'STRING'),
     ('USERNAME', 'المستخدم', 'STRING'), ('RESULT_AR', 'النتيجة', 'STRING'), ('REASON_AR', 'السبب', 'STRING'),
     ('IP_ADDRESS', 'عنوان IP', 'STRING')])
pages.append(p71)

# 80/81 - Settings
pages += crud(80, 81, 'الإعدادات', 'إعداد', 'MOINFO_SETTINGS', 'SETTING_KEY',
    """select SETTING_KEY, DESCRIPTION, SETTING_VALUE from MOINFO_SETTINGS""",
    [('SETTING_KEY', 'المفتاح', 'STRING'), ('DESCRIPTION', 'الوصف', 'STRING'), ('SETTING_VALUE', 'القيمة', 'STRING')],
    [dict(col='DESCRIPTION', label='الوصف', display='DISPLAY'),
     dict(col='SETTING_VALUE', label='القيمة', display='TEXTAREA', height=3)],
    'ADMIN', delete=False, allow_create=False, pk_dtype='VARCHAR2')

for p in pages:
    if p.authz == 'ADMIN' and p.pid not in (1,):
        p.group = PG_ADMIN
    parts.append(p.render())

# ------------------------------------------------------------------------------
# 6) Footer
# ------------------------------------------------------------------------------
parts.append("""prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
""")

open(OUT, 'w', encoding='utf-8').write('\n'.join(parts))
print(OUT, sum(len(x) for x in parts), 'chars,', len(pages), 'pages')
