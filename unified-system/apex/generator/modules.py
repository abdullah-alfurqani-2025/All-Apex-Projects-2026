"""Module pages: HR (1000), EVT (2000), MED (3000), TSK (4000), ATT (5000), HD (6000), shared catalog (100-109)."""
from gen_app import *

DML = 'CREATE,SAVE,DELETE'

# ------------------------------------------------------------------------------
# Authorizations, LOVs, menu entries
# ------------------------------------------------------------------------------
def authorizations():
    calls = []
    for code in ['HR', 'EVT', 'MED', 'TSK', 'ATT', 'HD', 'PRC']:
        calls.append(authorization(f'{code}_MANAGER', f"return MOINFO_SEC.HAS_ROLE('{code}', 'MANAGER');",
                                   'هذه الصفحة للمشرفين في الوحدة'))
    calls.append(authorization('CAT_MANAGER', """return MOINFO_SEC.IS_ADMIN
    or MOINFO_SEC.HAS_ROLE('HD', 'MANAGER')
    or MOINFO_SEC.HAS_ROLE('PRC', 'MANAGER')
    or MOINFO_SEC.HAS_ROLE('STD', 'MANAGER');""", 'الكتالوج المشترك لمشرفي الدعم الفني والمشتريات والمخزن'))
    calls.append(authorization('PRC_PURCHASER', "return MOINFO_SEC.HAS_ROLE('PRC', 'ADMIN');",
                               'هذه الصفحة لقسم المشتريات'))
    calls.append(authorization('HAS_EMPLOYEE', 'return MOINFO_HR.MY_EMPLOYEE_ID is not null;',
                               'حسابك غير مرتبط بموظف'))
    return calls

def lookup_lov(type_code):
    return lov(f'LK_{type_code}', f"""select NAME_AR d, LOOKUP_ID r
  from MOINFO_LOOKUPS
 where LOOKUP_TYPE = '{type_code}' and IS_ACTIVE = 'Y'
 order by SORT_ORDER, NAME_AR""")

def lovs():
    out = []
    for t in ['HR_MARITAL_STATUS', 'HR_RELIGION', 'HR_APPOINTMENT_TYPE', 'HR_QUALIFICATION', 'HR_BANK',
              'HR_EMP_STATUS', 'EVT_TYPE', 'MED_EVENT', 'MED_EVENT_TYPE', 'TSK_STATUS', 'TSK_TYPE',
              'TSK_CATEGORY', 'ATT_CATEGORY', 'HD_DEVICE_STATUS', 'HD_REQUEST_STATUS', 'PRC_REQUEST_STATUS']:
        out.append(lookup_lov(t))
    out.append(lov('COUNTRIES', "select NAME_AR d, COUNTRY_ID r from MOINFO_COUNTRIES where IS_ACTIVE = 'Y' order by SORT_ORDER, NAME_AR"))
    out.append(lov('WILAYATS', """select g.NAME_AR || ' - ' || w.NAME_AR d, w.WILAYAT_ID r
  from MOINFO_WILAYATS w join MOINFO_GOVERNORATES g on g.GOVERNORATE_ID = w.GOVERNORATE_ID
 where w.IS_ACTIVE = 'Y'
 order by g.SORT_ORDER, w.SORT_ORDER, w.NAME_AR"""))
    out.append(lov('MED_CHANNELS', "select NAME_AR d, CHANNEL_ID r from MOINFO_MED_CHANNELS where IS_ACTIVE = 'Y' order by SORT_ORDER, NAME_AR"))
    out.append(lov('MED_PROGRAMS', """select NAME_AR d, PROGRAM_ID r from MOINFO_MED_PROGRAMS
 where IS_ACTIVE = 'Y' and CHANNEL_ID = :P3002_CHANNEL_ID
 order by SORT_ORDER, NAME_AR"""))
    out.append(lov('EVT_EMPLOYEES', """select e.NAME_AR || nvl2(e.EMPLOYEE_NO, ' - ' || e.EMPLOYEE_NO, '') d, e.EMPLOYEE_ID r
  from MOINFO_EMPLOYEES e
 where e.IS_ACTIVE = 'Y' and MOINFO_EVT.CAN_SEE(e.EMPLOYEE_ID) = 'Y'
 order by e.NAME_AR"""))
    out.append(lov('CAT_PRODUCT_TYPES', "select NAME_AR d, PRODUCT_TYPE_ID r from MOINFO_CAT_PRODUCT_TYPES where IS_ACTIVE = 'Y' order by SORT_ORDER, NAME_AR"))
    out.append(lov('CAT_BRANDS', "select NAME d, BRAND_ID r from MOINFO_CAT_BRANDS where IS_ACTIVE = 'Y' order by NAME"))
    out.append(lov('CAT_MODELS', """select FULL_NAME || nvl2(PRODUCT_TYPE_AR, ' (' || PRODUCT_TYPE_AR || ')', '') d, MODEL_ID r
  from MOINFO_CAT_V_MODELS where IS_ACTIVE = 'Y' order by BRAND_NAME, MODEL_NAME"""))
    out.append(lov('CAT_SUPPLIERS', "select NAME_AR d, SUPPLIER_ID r from MOINFO_CAT_SUPPLIERS where IS_ACTIVE = 'Y' order by NAME_AR"))
    out.append(lov('CAT_WARRANTY_TYPES', "select NAME_AR d, WARRANTY_TYPE_ID r from MOINFO_CAT_WARRANTY_TYPES where IS_ACTIVE = 'Y' order by MONTHS"))
    out.append(lov('HD_PURCHASE_ORDERS', "select PO_NO || nvl2(PO_NAME, ' - ' || PO_NAME, '') d, PO_ID r from MOINFO_HD_PURCHASE_ORDERS where IS_ACTIVE = 'Y' order by PO_DATE desc nulls last, PO_NO"))
    out.append(lov('HD_REQUEST_DEVICES', """select SERIAL_NO || ' - ' || nvl(DEVICE_NAME, BRAND_NAME || ' ' || MODEL_NAME) d, DEVICE_ID r
  from MOINFO_HD_V_DEVICES
 where IS_ACTIVE = 'Y'
   and (MOINFO_HD.IS_MANAGER = 'Y' or CURRENT_EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID)
 order by SERIAL_NO"""))
    out.append(lov('PRC_MODELS_BY_BRAND', """select NAME d, MODEL_ID r from MOINFO_CAT_MODELS
 where IS_ACTIVE = 'Y' and BRAND_ID = :P7003_BRAND_ID
 order by NAME"""))
    out.append(static_lov('PRC_ITEM_DECISION', [('معتمد', 'Y'), ('مرفوض', 'N')]))
    out.append(static_lov('MED_CREW_ROLE', [('مصور', 'PHOTOGRAPHER'), ('مونتاج', 'EDITOR'), ('مراسل', 'REPORTER')]))
    out.append(static_lov('TSK_PRIORITY', [('منخفضة', 'LOW'), ('عادية', 'NORMAL'), ('عالية', 'HIGH'), ('عاجلة', 'URGENT')]))
    return out

MODULE_MENU = [
    ('HR', 'الموارد البشرية', 'fa-users', [
        ('الموظفون', 1001, '1001,1002', 'MOD_HR'),
        ('دليل الهواتف', 1003, '1003,1004', None),
        ('البيانات الناقصة', 1005, '1005', 'HR_MANAGER'),
        ('الوثائق المنتهية', 1006, '1006', 'HR_MANAGER'),
        ('سجل البصمة', 1007, '1007', 'HR_MANAGER'),
    ]),
    ('EVT', 'مشاركات الموظفين', 'fa-calendar', [
        ('المشاركات', 2001, '2001,2002', 'MOD_EVT'),
        ('المشاركات المتداخلة', 2003, '2003', 'EVT_MANAGER'),
        ('ملخص الموظفين', 2004, '2004', 'MOD_EVT'),
    ]),
    ('MED', 'التغطيات الإعلامية', 'fa-video-camera', [
        ('التغطيات', 3001, '3001,3002,3003', 'MOD_MED'),
        ('الإحصائيات', 3004, '3004', 'MOD_MED'),
        ('عمل الفريق', 3005, '3005', 'MOD_MED'),
        ('القنوات', 3010, '3010,3011', 'MED_MANAGER'),
        ('البرامج', 3012, '3012,3013', 'MED_MANAGER'),
    ]),
    ('TSK', 'المهام', 'fa-tasks', [
        ('المهام', 4001, '4001,4002', 'MOD_TSK'),
        ('إحصائيات المهام', 4003, '4003', 'MOD_TSK'),
    ]),
    ('ATT', 'المرفقات والقوالب', 'fa-paperclip', [
        ('المستندات', 5001, '5001,5002', 'MOD_ATT'),
    ]),
    ('HD', 'الدعم الفني', 'fa-life-ring', [
        ('طلبات الدعم', 6001, '6001,6002', 'MOD_HD'),
        ('أجهزتي', 6009, '6009', 'HAS_EMPLOYEE'),
        ('الأجهزة', 6003, '6003,6004,6005', 'HD_MANAGER'),
        ('أوامر الشراء', 6006, '6006,6007', 'HD_MANAGER'),
        ('الضمان', 6008, '6008', 'HD_MANAGER'),
    ]),
    ('PRC', 'المشتريات', 'fa-shopping-cart', [
        ('طلبات الشراء', 7001, '7001,7002,7003', 'MOD_PRC'),
        ('بانتظار الاعتماد', 7005, '7005', 'PRC_MANAGER'),
        ('الشراء والاستلام', 7006, '7006', 'PRC_PURCHASER'),
        ('الإحصائيات', 7007, '7007', 'MOD_PRC'),
    ]),
    ('CAT', 'الكتالوج المشترك', 'fa-tags', [
        ('أنواع المنتجات', 100, '100,101', 'CAT_MANAGER'),
        ('الماركات', 102, '102,103', 'CAT_MANAGER'),
        ('الموديلات', 104, '104,105', 'CAT_MANAGER'),
        ('الموردون', 106, '106,107', 'CAT_MANAGER'),
        ('أنواع الضمان', 108, '108,109', 'CAT_MANAGER'),
    ]),
]

# authorization of each menu group (default MOD_<code>)
GROUP_AUTHZ = {'HR': None, 'CAT': 'CAT_MANAGER'}

def menu_items():
    items = [dict(text='بياناتي', page=1010, icon='fa-user-circle', authz='HAS_EMPLOYEE', current='1010', static='my-data')]
    for code, name, icon, children in MODULE_MENU:
        items.append(dict(text=name, target='#', icon=icon, key=f'm-{code}', authz=GROUP_AUTHZ.get(code, f'MOD_{code}'),
                          static=f'mod-{code.lower()}'))
        for text, page, current, az in children:
            items.append(dict(text=text, page=page, parent=f'm-{code}', authz=az, current=current,
                              static=f'mod-{code.lower()}-{page}'))
    return items

def home_cards():
    descr = {
        'HR': 'الموظفون، ودليل الهواتف، والوثائق، والبصمة',
        'EVT': 'الدورات وورش العمل والمؤتمرات',
        'MED': 'التغطيات والقنوات والبرامج وفريق العمل',
        'TSK': 'المهام وسجل المتابعة والإحصائيات',
        'ATT': 'المناوبات والمحاضر ونماذج الخطابات',
        'HD': 'طلبات الدعم والأجهزة والتسليم والضمان',
        'PRC': 'طلبات الشراء والاعتماد والشراء والاستلام',
        'CAT': 'الماركات والموديلات والموردون وأنواع الضمان',
    }
    out = [dict(text='بياناتي', page=1010, icon='fa-user-circle', authz='HAS_EMPLOYEE', desc='بياناتك الوظيفية والشخصية',
                static='home-my')]
    for code, name, icon, children in MODULE_MENU:
        out.append(dict(text=name, page=children[0][1], icon=icon, authz=GROUP_AUTHZ.get(code) or f'MOD_{code}', desc=descr[code],
                        static=f'home-mod-{code.lower()}'))
    return out

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
def guard(page, check, msg):
    page.plsql_process('Row access check', f"""if {check} then
    raise_application_error(-20100, '{msg}');
end if;""", point='BEFORE_HEADER', seq=1)

def child_ir(fp, title, sql, columns, pk, link_page, link_item, parent_item, add_page, add_item, add_label, seq=30):
    reg = fp.ir_region(title, sql, columns, pk=pk, link_page=link_page, link_item=link_item, seq=seq,
                       cond=('ITEM_IS_NOT_NULL', parent_item))
    fp.button(reg, 'ADD_CHILD', add_label, action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
              redirect=f"f?p=&APP_ID.:{add_page}:&SESSION.::&DEBUG.:{add_page}:{add_item}:&{parent_item}.", icon='fa-plus')
    return reg

def child_form(pid, title, table, pk, parent_col, parent_page, parent_item, fields, authz):
    p = Page(pid, title, authz=authz)
    r = p.form_region(title, table)
    p.item(r, f'P{pid}_{pk}', display='HIDDEN', source=pk, source_region=r, dtype='NUMBER', pk=True, seq=5)
    p.item(r, f'P{pid}_{parent_col}', display='HIDDEN', source=parent_col, source_region=r, dtype='NUMBER', seq=6)
    seq = 10
    for f in fields:
        p.item(r, f"P{pid}_{f['col']}", label=f['label'], display=f.get('display', 'TEXT'), source=f['col'],
               source_region=r, dtype=f.get('dtype', 'VARCHAR2'), seq=seq, required=f.get('required', False),
               lov=f.get('lov'), null_text=f.get('null_text'), maxlen=f.get('maxlen'), default=f.get('default'))
        seq += 10
    back = f"f?p=&APP_ID.:{parent_page}:&SESSION.::&DEBUG.::{parent_item}:&P{pid}_{parent_col}."
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10, redirect=back, exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_item=f'P{pid}_{pk}', cond_type='ITEM_IS_NOT_NULL',
             db_action='DELETE', confirm='هل تريد الحذف؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item=f'P{pid}_{pk}',
             cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إضافة', position='CREATE', hot=True, seq=40, cond_item=f'P{pid}_{pk}',
             cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.form_processes(r, title)
    p.branch(parent_page, seq=100, items=(parent_item, f'&P{pid}_{parent_col}.'))
    return p

YN = "case {c} when 'Y' then 'نعم' else 'لا' end"

# ------------------------------------------------------------------------------
# HR
# ------------------------------------------------------------------------------
def hr_pages():
    pages = []
    # 1001 employees (HR view)
    p = Page(1001, 'الموظفون - الموارد البشرية', authz='MOD_HR', alias='HR-EMPLOYEES')
    p.ir_region('الموظفون', f"""select e.EMPLOYEE_ID, e.EMPLOYEE_NO, e.NAME_AR, e.UNIT_PATH_AR, e.TITLE_NAME_AR,
       e.EMP_STATUS_AR, e.MOBILE, e.PHONE_EXT, e.EMAIL, e.HIRE_DATE, e.USERNAME
  from MOINFO_HR_V_EMPLOYEES e
 where e.IS_ACTIVE = 'Y'
   and (MOINFO_SEC.CAN_SEE_UNIT('HR', e.UNIT_ID) = 'Y' or e.EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID)""",
        [('EMPLOYEE_ID', None, 'NUMBER'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'), ('NAME_AR', 'الاسم', 'STRING'),
         ('UNIT_PATH_AR', 'الوحدة التنظيمية', 'STRING'), ('TITLE_NAME_AR', 'المسمى', 'STRING'),
         ('EMP_STATUS_AR', 'الحالة', 'STRING'), ('MOBILE', 'الجوال', 'STRING'), ('PHONE_EXT', 'التحويلة', 'STRING'),
         ('EMAIL', 'البريد', 'STRING'), ('HIRE_DATE', 'تاريخ التعيين', 'DATE'), ('USERNAME', 'اسم المستخدم', 'STRING')],
        pk='EMPLOYEE_ID', link_page=1002, link_item='P1002_EMPLOYEE_ID')
    pages.append(p)

    # 1002 employee details (sensitive)
    p = Page(1002, 'البيانات التفصيلية للموظف', authz='HR_MANAGER', alias='HR-EMPLOYEE-DETAILS')
    guard(p, "MOINFO_HR.CAN_VIEW_DETAILS(:P1002_EMPLOYEE_ID) = 'N'", 'لا تملك صلاحية على بيانات هذا الموظف')
    p.plsql_process('Ensure details row', """insert into MOINFO_HR_EMPLOYEE_DETAILS (EMPLOYEE_ID)
select :P1002_EMPLOYEE_ID from dual
 where :P1002_EMPLOYEE_ID is not null
   and not exists (select 1 from MOINFO_HR_EMPLOYEE_DETAILS where EMPLOYEE_ID = :P1002_EMPLOYEE_ID);
select NAME_AR || nvl2(EMPLOYEE_NO, ' - ' || EMPLOYEE_NO, '') into :P1002_EMP_NAME
  from MOINFO_EMPLOYEES where EMPLOYEE_ID = :P1002_EMPLOYEE_ID;""", point='BEFORE_HEADER', seq=2)
    r = p.form_region('البيانات التفصيلية', 'MOINFO_HR_EMPLOYEE_DETAILS', edit_ops='u')
    p.item(r, 'P1002_EMPLOYEE_ID', display='HIDDEN', source='EMPLOYEE_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P1002_EMP_NAME', label='الموظف', display='DISPLAY', seq=2)
    fields = [
        ('E_EMPLOYEE_NO', 'الرقم الإلكتروني', 'TEXT', None, 'VARCHAR2', True),
        ('EMP_STATUS_ID', 'حالة الموظف', 'SELECT', 'LK_HR_EMP_STATUS', 'NUMBER', False),
        ('GRADE', 'الدرجة', 'TEXT', None, 'VARCHAR2', True),
        ('POSITION_CODE', 'رمز الوظيفة', 'TEXT', None, 'VARCHAR2', False),
        ('APPOINTMENT_TYPE_ID', 'نوع التعيين', 'SELECT', 'LK_HR_APPOINTMENT_TYPE', 'NUMBER', True),
        ('UPGRADE_DATE', 'تاريخ الترقية', 'DATE', None, 'DATE', False),
        ('BUDGET_NO', 'رقم الموازنة', 'TEXT', None, 'VARCHAR2', True),
        ('BUDGET_NAME', 'اسم الموازنة', 'TEXT', None, 'VARCHAR2', False),
        ('BIRTH_DATE', 'تاريخ الميلاد', 'DATE', None, 'DATE', True),
        ('BIRTH_PLACE', 'مكان الميلاد', 'TEXT', None, 'VARCHAR2', False),
        ('NATIONALITY_ID', 'الجنسية', 'POPUP', 'COUNTRIES', 'NUMBER', True),
        ('MARITAL_STATUS_ID', 'الحالة الاجتماعية', 'SELECT', 'LK_HR_MARITAL_STATUS', 'NUMBER', False),
        ('RELIGION_ID', 'الديانة', 'SELECT', 'LK_HR_RELIGION', 'NUMBER', True),
        ('QUALIFICATION_ID', 'المؤهل', 'SELECT', 'LK_HR_QUALIFICATION', 'NUMBER', False),
        ('QUALIFICATION_DETAILS', 'تفاصيل المؤهل', 'TEXT', None, 'VARCHAR2', True),
        ('CIVIL_ID_NO', 'رقم البطاقة المدنية', 'TEXT', None, 'VARCHAR2', True),
        ('CIVIL_ID_ISSUE_DATE', 'تاريخ إصدار البطاقة', 'DATE', None, 'DATE', False),
        ('CIVIL_ID_EXPIRY_DATE', 'تاريخ انتهاء البطاقة', 'DATE', None, 'DATE', False),
        ('PASSPORT_NO', 'رقم الجواز', 'TEXT', None, 'VARCHAR2', True),
        ('PASSPORT_ISSUE_PLACE', 'مكان إصدار الجواز', 'TEXT', None, 'VARCHAR2', False),
        ('PASSPORT_ISSUE_DATE', 'تاريخ إصدار الجواز', 'DATE', None, 'DATE', False),
        ('PASSPORT_EXPIRY_DATE', 'تاريخ انتهاء الجواز', 'DATE', None, 'DATE', False),
        ('ADDRESS', 'العنوان', 'TEXT', None, 'VARCHAR2', True),
        ('ADDRESS2', 'عنوان آخر', 'TEXT', None, 'VARCHAR2', False),
        ('MOBILE2', 'جوال آخر', 'TEXT', None, 'VARCHAR2', True),
        ('BASIC_SALARY', 'الراتب الأساسي', 'NUMBER', None, 'NUMBER', False),
        ('BANK_ID', 'البنك', 'SELECT', 'LK_HR_BANK', 'NUMBER', True),
        ('BANK_BRANCH', 'الفرع', 'TEXT', None, 'VARCHAR2', False),
        ('BANK_ACCOUNT_NO', 'رقم الحساب', 'TEXT', None, 'VARCHAR2', False),
        ('LEAVE_BALANCE_1', 'رصيد الإجازة 1', 'NUMBER', None, 'NUMBER', True),
        ('LEAVE_BALANCE_2', 'رصيد الإجازة 2', 'NUMBER', None, 'NUMBER', False),
        ('DATA_VERIFIED_AT', 'تاريخ تأكيد البيانات', 'DATE', None, 'DATE', True),
        ('REMARKS', 'ملاحظات', 'TEXTAREA', None, 'VARCHAR2', True),
    ]
    seq = 10
    for col, label, disp, lv, dt, nl in fields:
        p.item(r, f'P1002_{col}', label=label, display=disp, source=col, source_region=r, dtype=dt, seq=seq,
               lov=lv, null_text='- -' if disp == 'SELECT' else ('' if disp == 'POPUP' else None), new_line=nl)
        seq += 10
    p.button(r, 'CANCEL', 'رجوع', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:1001:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, db_action='UPDATE')
    p.form_processes(r, 'Employee details')
    p.branch(1001, seq=100)
    pages.append(p)

    # 1003 directory (all authenticated users)
    p = Page(1003, 'دليل الهواتف', alias='DIRECTORY')
    p.ir_region('دليل الهواتف', """select EMPLOYEE_ID, NAME_AR, UNIT_PATH_AR, TITLE_NAME_AR, PHONE_EXT, PHONE_EXT2, MOBILE,
       TEL1, TEL2, FAX1, EMAIL, OFFICE_DEVICE
  from MOINFO_HR_V_DIRECTORY""",
        [('EMPLOYEE_ID', None, 'NUMBER'), ('NAME_AR', 'الاسم', 'STRING'), ('UNIT_PATH_AR', 'الوحدة', 'STRING'),
         ('TITLE_NAME_AR', 'المسمى', 'STRING'), ('PHONE_EXT', 'التحويلة', 'STRING'), ('PHONE_EXT2', 'تحويلة 2', 'STRING'),
         ('MOBILE', 'الجوال', 'STRING'), ('TEL1', 'هاتف', 'STRING'), ('TEL2', 'هاتف 2', 'STRING'),
         ('FAX1', 'فاكس', 'STRING'), ('EMAIL', 'البريد', 'STRING'), ('OFFICE_DEVICE', 'الجهاز', 'STRING')],
        pk='EMPLOYEE_ID', link_page=1004, link_item='P1004_EMPLOYEE_ID')
    pages.append(p)

    # 1004 directory entry (HR managers)
    p = Page(1004, 'بيانات الدليل', authz='HR_MANAGER', alias='DIRECTORY-ENTRY')
    guard(p, "MOINFO_HR.CAN_VIEW_DETAILS(:P1004_EMPLOYEE_ID) = 'N'", 'لا تملك صلاحية على هذا الموظف')
    p.plsql_process('Ensure directory row', """insert into MOINFO_HR_DIRECTORY (EMPLOYEE_ID)
select :P1004_EMPLOYEE_ID from dual
 where :P1004_EMPLOYEE_ID is not null
   and not exists (select 1 from MOINFO_HR_DIRECTORY where EMPLOYEE_ID = :P1004_EMPLOYEE_ID);
select NAME_AR into :P1004_EMP_NAME from MOINFO_EMPLOYEES where EMPLOYEE_ID = :P1004_EMPLOYEE_ID;""",
                    point='BEFORE_HEADER', seq=2)
    r = p.form_region('بيانات الدليل', 'MOINFO_HR_DIRECTORY', edit_ops='u')
    p.item(r, 'P1004_EMPLOYEE_ID', display='HIDDEN', source='EMPLOYEE_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P1004_EMP_NAME', label='الموظف', display='DISPLAY', seq=2)
    seq = 10
    for col, label, nl in [('PHONE_EXT2', 'تحويلة 2', True), ('TEL1', 'هاتف', True), ('TEL2', 'هاتف 2', False),
                           ('FAX1', 'فاكس', True), ('FAX2', 'فاكس 2', False), ('OFFICE_DEVICE', 'الجهاز', True),
                           ('REMARKS', 'ملاحظات', True)]:
        p.item(r, f'P1004_{col}', label=label, source=col, source_region=r, seq=seq, new_line=nl)
        seq += 10
    p.item(r, 'P1004_SHOW_IN_DIRECTORY', label='يظهر في الدليل', display='YESNO', source='SHOW_IN_DIRECTORY',
           source_region=r, seq=seq)
    p.button(r, 'CANCEL', 'رجوع', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:1003:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'SAVE', 'حفظ', position='CHANGE', hot=True, seq=30, db_action='UPDATE')
    p.form_processes(r, 'Directory')
    p.branch(1003, seq=100)
    pages.append(p)

    # 1005 incomplete, 1006 expiring docs, 1007 attendance
    p = Page(1005, 'البيانات الناقصة', authz='HR_MANAGER', alias='HR-INCOMPLETE')
    p.ir_region('البيانات الناقصة', """select i.EMPLOYEE_ID, i.EMPLOYEE_NO, i.NAME_AR, i.UNIT_PATH_AR, i.MISSING_FIELDS
  from MOINFO_HR_V_INCOMPLETE i join MOINFO_EMPLOYEES e on e.EMPLOYEE_ID = i.EMPLOYEE_ID
 where MOINFO_SEC.CAN_SEE_UNIT('HR', e.UNIT_ID) = 'Y'""",
        [('EMPLOYEE_ID', None, 'NUMBER'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'), ('NAME_AR', 'الاسم', 'STRING'),
         ('UNIT_PATH_AR', 'الوحدة', 'STRING'), ('MISSING_FIELDS', 'الحقول الناقصة', 'STRING')],
        pk='EMPLOYEE_ID', link_page=1002, link_item='P1002_EMPLOYEE_ID')
    pages.append(p)

    p = Page(1006, 'الوثائق المنتهية والقريبة من الانتهاء', authz='HR_MANAGER', alias='HR-EXPIRING')
    p.ir_region('الوثائق', """select x.EMPLOYEE_ID, x.EMPLOYEE_NO, x.NAME_AR, x.UNIT_PATH_AR, x.DOC_TYPE_AR, x.DOC_NO,
       x.EXPIRY_DATE, x.DAYS_LEFT,
       case when x.DAYS_LEFT < 0 then 'منتهية' else 'قريبة من الانتهاء' end as STATE_AR
  from MOINFO_HR_V_EXPIRING_DOCS x join MOINFO_EMPLOYEES e on e.EMPLOYEE_ID = x.EMPLOYEE_ID
 where MOINFO_SEC.CAN_SEE_UNIT('HR', e.UNIT_ID) = 'Y'
 order by x.EXPIRY_DATE""",
        [('EMPLOYEE_ID', None, 'NUMBER'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'), ('NAME_AR', 'الاسم', 'STRING'),
         ('UNIT_PATH_AR', 'الوحدة', 'STRING'), ('DOC_TYPE_AR', 'الوثيقة', 'STRING'), ('DOC_NO', 'الرقم', 'STRING'),
         ('EXPIRY_DATE', 'تاريخ الانتهاء', 'DATE'), ('DAYS_LEFT', 'الأيام المتبقية', 'NUMBER'),
         ('STATE_AR', 'الحالة', 'STRING')],
        pk='EMPLOYEE_ID', link_page=1002, link_item='P1002_EMPLOYEE_ID')
    pages.append(p)

    p = Page(1007, 'سجل البصمة', authz='HR_MANAGER', alias='HR-ATTENDANCE')
    p.ir_region('سجل البصمة', """select a.LOG_ID, a.ATTENDANCE_PIN, a.NAME_AR,
       to_char(a.CHECK_TIME, 'DD/MM/YYYY HH24:MI') as CHECK_TIME_TXT, a.CHECK_DATE, a.CHECK_TYPE, a.DEVICE_SN, a.LOCATION
  from MOINFO_HR_V_ATTENDANCE a
 where a.UNIT_ID is null or MOINFO_SEC.CAN_SEE_UNIT('HR', a.UNIT_ID) = 'Y'
 order by a.CHECK_TIME desc""",
        [('LOG_ID', None, 'NUMBER'), ('ATTENDANCE_PIN', 'الرقم الوظيفي', 'STRING'), ('NAME_AR', 'الاسم', 'STRING'),
         ('CHECK_TIME_TXT', 'الوقت', 'STRING'), ('CHECK_DATE', 'التاريخ', 'DATE'), ('CHECK_TYPE', 'النوع', 'STRING'),
         ('DEVICE_SN', 'الجهاز', 'STRING'), ('LOCATION', 'الموقع', 'STRING')])
    pages.append(p)

    # 1010 my data
    p = Page(1010, 'بياناتي', authz='HAS_EMPLOYEE', alias='MY-DATA')
    p.plsql_process('Load my employee', ":P1010_EMPLOYEE_ID := MOINFO_HR.MY_EMPLOYEE_ID;", point='BEFORE_HEADER', seq=1)
    r = p.form_region('بياناتي', 'MOINFO_HR_V_EMPLOYEE_DETAILS', edit_ops='u')
    p.item(r, 'P1010_EMPLOYEE_ID', display='HIDDEN', source='EMPLOYEE_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    seq = 10
    for col, label, dt, nl in [
            ('NAME_AR', 'الاسم', 'VARCHAR2', True), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'VARCHAR2', False),
            ('UNIT_PATH_AR', 'الوحدة التنظيمية', 'VARCHAR2', True), ('TITLE_NAME_AR', 'المسمى', 'VARCHAR2', False),
            ('EMP_STATUS_AR', 'الحالة', 'VARCHAR2', True), ('GRADE', 'الدرجة', 'VARCHAR2', False),
            ('HIRE_DATE', 'تاريخ التعيين', 'DATE', True), ('APPOINTMENT_TYPE_AR', 'نوع التعيين', 'VARCHAR2', False),
            ('MOBILE', 'الجوال', 'VARCHAR2', True), ('EMAIL', 'البريد', 'VARCHAR2', False),
            ('CIVIL_ID_NO', 'البطاقة المدنية', 'VARCHAR2', True), ('CIVIL_ID_EXPIRY_DATE', 'انتهاء البطاقة', 'DATE', False),
            ('PASSPORT_NO', 'الجواز', 'VARCHAR2', True), ('PASSPORT_EXPIRY_DATE', 'انتهاء الجواز', 'DATE', False),
            ('QUALIFICATION_AR', 'المؤهل', 'VARCHAR2', True), ('NATIONALITY_AR', 'الجنسية', 'VARCHAR2', False),
            ('BANK_AR', 'البنك', 'VARCHAR2', True), ('BANK_ACCOUNT_NO', 'رقم الحساب', 'VARCHAR2', False),
            ('LEAVE_BALANCE_1', 'رصيد الإجازة 1', 'NUMBER', True), ('LEAVE_BALANCE_2', 'رصيد الإجازة 2', 'NUMBER', False),
            ('DATA_VERIFIED_AT', 'آخر تأكيد للبيانات', 'DATE', True)]:
        p.item(r, f'P1010_{col}', label=label, display='DISPLAY', source=col, source_region=r, dtype=dt, seq=seq, new_line=nl)
        seq += 10
    confirm = p.button(r, 'CONFIRM_DATA', 'أؤكد صحة بياناتي', position='NEXT', hot=True, seq=10)
    p.plsql_process('Confirm data', """merge into MOINFO_HR_EMPLOYEE_DETAILS d
using (select :P1010_EMPLOYEE_ID as EMPLOYEE_ID from dual) s
   on (d.EMPLOYEE_ID = s.EMPLOYEE_ID)
 when matched then update set d.DATA_VERIFIED_AT = trunc(sysdate)
 when not matched then insert (EMPLOYEE_ID, DATA_VERIFIED_AT) values (s.EMPLOYEE_ID, trunc(sysdate));""",
                    seq=10, when_button=confirm, success='شكرًا، تم تسجيل تأكيد بياناتك. لتصحيح أي بيان تواصل مع الموارد البشرية.')
    # only the init process; no DML on the view
    i = nid()
    p.calls.append(call("wwv_flow_imp_page.create_page_process", [
        ("p_id", rid(i)), ("p_process_sequence", "10"), ("p_process_point", lit('BEFORE_HEADER')),
        ("p_region_id", rid(r)), ("p_process_type", lit('NATIVE_FORM_INIT')),
        ("p_process_name", lit('Initialize my data')), ("p_static_id", lit(f"init-{i % 100000}")),
        ("p_internal_uid", str(i))]))
    p.branch(1010, seq=100)
    pages.append(p)
    return pages

# ------------------------------------------------------------------------------
# EVT
# ------------------------------------------------------------------------------
def evt_pages():
    pages = []
    p = Page(2001, 'المشاركات', authz='MOD_EVT', alias='EVENTS')
    reg = p.ir_region('المشاركات', f"""select v.EVENT_ID, v.EMPLOYEE_NO, v.EMPLOYEE_NAME_AR, v.UNIT_PATH_AR, v.EVENT_TYPE_AR, v.TITLE,
       v.PLACE, v.COUNTRY_AR, v.START_DATE, v.END_DATE, v.DURATION_DAYS, v.EVENT_YEAR, v.LETTER_NO, v.LETTER_DATE,
       {YN.format(c='v.IS_ACTIVE')} as IS_ACTIVE_AR
  from MOINFO_EVT_V_EVENTS v
 where MOINFO_EVT.CAN_SEE(v.EMPLOYEE_ID) = 'Y'""",
        [('EVENT_ID', None, 'NUMBER'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'), ('EMPLOYEE_NAME_AR', 'الموظف', 'STRING'),
         ('UNIT_PATH_AR', 'الوحدة', 'STRING'), ('EVENT_TYPE_AR', 'النوع', 'STRING'), ('TITLE', 'المشاركة', 'STRING'),
         ('PLACE', 'المكان', 'STRING'), ('COUNTRY_AR', 'الدولة', 'STRING'), ('START_DATE', 'من', 'DATE'),
         ('END_DATE', 'إلى', 'DATE'), ('DURATION_DAYS', 'الأيام', 'NUMBER'), ('EVENT_YEAR', 'السنة', 'NUMBER'),
         ('LETTER_NO', 'رقم الخطاب', 'STRING'), ('LETTER_DATE', 'تاريخ الخطاب', 'DATE'), ('IS_ACTIVE_AR', 'نشطة', 'STRING')],
        pk='EVENT_ID', link_page=2002, link_item='P2002_EVENT_ID')
    p.button(reg, 'CREATE', 'إضافة مشاركة', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:2002:&SESSION.::&DEBUG.:2002::', icon='fa-plus')
    pages.append(p)

    p = Page(2002, 'مشاركة', authz='MOD_EVT', alias='EVENT')
    p.plsql_process('Row access check', """declare
    l_emp number;
begin
    if :P2002_EVENT_ID is not null then
        select EMPLOYEE_ID into l_emp from MOINFO_EVT_EVENTS where EVENT_ID = :P2002_EVENT_ID;
        if MOINFO_EVT.CAN_SEE(l_emp) = 'N' then
            raise_application_error(-20100, 'لا تملك صلاحية على هذه المشاركة');
        end if;
    end if;
end;""", point='BEFORE_HEADER', seq=1)
    r = p.form_region('مشاركة', 'MOINFO_EVT_EVENTS')
    p.item(r, 'P2002_EVENT_ID', display='HIDDEN', source='EVENT_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    emp = p.item(r, 'P2002_EMPLOYEE_ID', label='الموظف', display='POPUP', source='EMPLOYEE_ID', source_region=r, dtype='NUMBER',
                 lov='EVT_EMPLOYEES', null_text='', required=True, seq=10, default_expr='MOINFO_HR.MY_EMPLOYEE_ID')
    p.item(r, 'P2002_EVENT_TYPE_ID', label='نوع المشاركة', display='SELECT', source='EVENT_TYPE_ID', source_region=r,
           dtype='NUMBER', lov='LK_EVT_TYPE', null_text='- اختر -', required=True, seq=20)
    p.item(r, 'P2002_TITLE', label='عنوان المشاركة', source='TITLE', source_region=r, required=True, maxlen=500, seq=30)
    p.item(r, 'P2002_PLACE', label='المكان', source='PLACE', source_region=r, maxlen=200, seq=40)
    p.item(r, 'P2002_COUNTRY_ID', label='الدولة', display='POPUP', source='COUNTRY_ID', source_region=r, dtype='NUMBER',
           lov='COUNTRIES', null_text='', seq=50, new_line=False)
    sd = p.item(r, 'P2002_START_DATE', label='من تاريخ', display='DATE', source='START_DATE', source_region=r, dtype='DATE',
                required=True, seq=60)
    ed = p.item(r, 'P2002_END_DATE', label='إلى تاريخ', display='DATE', source='END_DATE', source_region=r, dtype='DATE',
                required=True, seq=70, new_line=False)
    p.item(r, 'P2002_LETTER_NO', label='رقم الخطاب', source='LETTER_NO', source_region=r, maxlen=50, seq=80)
    p.item(r, 'P2002_LETTER_DATE', label='تاريخ الخطاب', display='DATE', source='LETTER_DATE', source_region=r, dtype='DATE',
           seq=90, new_line=False)
    p.item(r, 'P2002_COMMENTS', label='ملاحظات', display='TEXTAREA', source='COMMENTS', source_region=r, seq=100)
    p.item(r, 'P2002_IS_ACTIVE', label='نشطة', display='YESNO', source='IS_ACTIVE', source_region=r, default='Y', seq=110)
    p.validation('Employee in scope', 'EXPRESSION', "MOINFO_EVT.CAN_SEE(:P2002_EMPLOYEE_ID) = 'Y'",
                 'لا يمكنك تسجيل مشاركة لهذا الموظف', item=emp, seq=10, expr2='PLSQL')
    p.validation('Dates order', 'EXPRESSION',
                 "to_date(:P2002_END_DATE, 'DD/MM/YYYY') >= to_date(:P2002_START_DATE, 'DD/MM/YYYY')",
                 'تاريخ النهاية يجب أن يكون بعد تاريخ البداية أو مساويًا له', item=ed, seq=20, expr2='PLSQL')
    p.validation('No overlap', 'FUNC_BODY_RETURNING_ERR_TEXT', """if :REQUEST = 'DELETE' or :P2002_IS_ACTIVE = 'N' then return null; end if;
return MOINFO_EVT.OVERLAP_MESSAGE(
    :P2002_EMPLOYEE_ID,
    to_date(:P2002_START_DATE, 'DD/MM/YYYY'),
    to_date(:P2002_END_DATE, 'DD/MM/YYYY'),
    :P2002_EVENT_ID);""", None, item=sd, seq=30, expr2='PLSQL')
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:2001:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_item='P2002_EVENT_ID', cond_type='ITEM_IS_NOT_NULL',
             db_action='DELETE', confirm='هل تريد حذف هذه المشاركة؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item='P2002_EVENT_ID',
             cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إضافة', position='CREATE', hot=True, seq=40, cond_item='P2002_EVENT_ID',
             cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.form_processes(r, 'Event')
    p.branch(2001, seq=100)
    pages.append(p)

    p = Page(2003, 'المشاركات المتداخلة', authz='EVT_MANAGER', alias='EVENT-OVERLAPS')
    p.ir_region('المشاركات المتداخلة', """select o.EMPLOYEE_ID, o.EMPLOYEE_NO, o.EMPLOYEE_NAME_AR, o.TITLE_1, o.START_DATE_1, o.END_DATE_1,
       o.TITLE_2, o.START_DATE_2, o.END_DATE_2, o.OVERLAP_DAYS
  from MOINFO_EVT_V_OVERLAPS o
 where MOINFO_EVT.CAN_SEE(o.EMPLOYEE_ID) = 'Y'""",
        [('EMPLOYEE_ID', None, 'NUMBER'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'), ('EMPLOYEE_NAME_AR', 'الموظف', 'STRING'),
         ('TITLE_1', 'المشاركة الأولى', 'STRING'), ('START_DATE_1', 'من', 'DATE'), ('END_DATE_1', 'إلى', 'DATE'),
         ('TITLE_2', 'المشاركة الثانية', 'STRING'), ('START_DATE_2', 'من', 'DATE'), ('END_DATE_2', 'إلى', 'DATE'),
         ('OVERLAP_DAYS', 'أيام التداخل', 'NUMBER')])
    pages.append(p)

    p = Page(2004, 'ملخص الموظفين', authz='MOD_EVT', alias='EVENT-SUMMARY')
    p.ir_region('ملخص سنوي لكل موظف', """select s.EMPLOYEE_ID, s.EMPLOYEE_NO, s.EMPLOYEE_NAME_AR, s.UNIT_PATH_AR, s.EVENT_YEAR,
       s.EVENTS_COUNT, s.TOTAL_DAYS
  from MOINFO_EVT_V_EMPLOYEE_SUMMARY s
 where MOINFO_EVT.CAN_SEE(s.EMPLOYEE_ID) = 'Y'
 order by s.EVENT_YEAR desc, s.TOTAL_DAYS desc""",
        [('EMPLOYEE_ID', None, 'NUMBER'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'), ('EMPLOYEE_NAME_AR', 'الموظف', 'STRING'),
         ('UNIT_PATH_AR', 'الوحدة', 'STRING'), ('EVENT_YEAR', 'السنة', 'NUMBER'), ('EVENTS_COUNT', 'عدد المشاركات', 'NUMBER'),
         ('TOTAL_DAYS', 'إجمالي الأيام', 'NUMBER')])
    pages.append(p)
    return pages

# ------------------------------------------------------------------------------
# MED
# ------------------------------------------------------------------------------
def med_pages():
    pages = []
    p = Page(3001, 'التغطيات', authz='MOD_MED', alias='COVERAGES')
    reg = p.ir_region('التغطيات', """select c.COVERAGE_ID, c.COVERAGE_DATE, c.COVERAGE_YEAR, c.EVENT_AR, c.EVENT_TYPE_AR, c.GOVERNORATE_AR,
       c.WILAYAT_AR, c.PLACE_NAME, c.CHANNEL_AR, c.PROGRAM_AR, c.PHOTOGRAPHERS, c.EDITORS, c.REPORTERS, c.REMARKS
  from MOINFO_MED_V_COVERAGES c
 where c.IS_ACTIVE = 'Y'
 order by c.COVERAGE_DATE desc""",
        [('COVERAGE_ID', None, 'NUMBER'), ('COVERAGE_DATE', 'التاريخ', 'DATE'), ('COVERAGE_YEAR', 'السنة', 'NUMBER'),
         ('EVENT_AR', 'المناسبة', 'STRING'), ('EVENT_TYPE_AR', 'نوع التغطية', 'STRING'), ('GOVERNORATE_AR', 'المحافظة', 'STRING'),
         ('WILAYAT_AR', 'الولاية', 'STRING'), ('PLACE_NAME', 'المكان', 'STRING'), ('CHANNEL_AR', 'القناة', 'STRING'),
         ('PROGRAM_AR', 'البرنامج', 'STRING'), ('PHOTOGRAPHERS', 'المصورون', 'STRING'), ('EDITORS', 'المونتاج', 'STRING'),
         ('REPORTERS', 'المراسلون', 'STRING'), ('REMARKS', 'ملاحظات', 'STRING')],
        pk='COVERAGE_ID', link_page=3002, link_item='P3002_COVERAGE_ID')
    p.button(reg, 'CREATE', 'إضافة تغطية', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:3002:&SESSION.::&DEBUG.:3002::', icon='fa-plus')
    pages.append(p)

    p = Page(3002, 'تغطية', authz='MOD_MED', alias='COVERAGE')
    r = p.form_region('تغطية', 'MOINFO_MED_COVERAGES')
    p.item(r, 'P3002_COVERAGE_ID', display='HIDDEN', source='COVERAGE_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P3002_COVERAGE_DATE', label='التاريخ', display='DATE', source='COVERAGE_DATE', source_region=r, dtype='DATE',
           required=True, seq=10)
    p.item(r, 'P3002_EVENT_ID', label='المناسبة', display='SELECT', source='EVENT_ID', source_region=r, dtype='NUMBER',
           lov='LK_MED_EVENT', null_text='- -', seq=20)
    p.item(r, 'P3002_EVENT_TYPE_ID', label='نوع التغطية', display='SELECT', source='EVENT_TYPE_ID', source_region=r,
           dtype='NUMBER', lov='LK_MED_EVENT_TYPE', null_text='- -', seq=30, new_line=False)
    p.item(r, 'P3002_WILAYAT_ID', label='الولاية', display='POPUP', source='WILAYAT_ID', source_region=r, dtype='NUMBER',
           lov='WILAYATS', null_text='', seq=40)
    p.item(r, 'P3002_PLACE_NAME', label='المكان', source='PLACE_NAME', source_region=r, maxlen=250, seq=50, new_line=False)
    p.item(r, 'P3002_CHANNEL_ID', label='القناة', display='SELECT', source='CHANNEL_ID', source_region=r, dtype='NUMBER',
           lov='MED_CHANNELS', null_text='- -', seq=60)
    p.item(r, 'P3002_PROGRAM_ID', label='البرنامج', display='SELECT', source='PROGRAM_ID', source_region=r, dtype='NUMBER',
           lov='MED_PROGRAMS', null_text='- -', seq=70, new_line=False, cascade='P3002_CHANNEL_ID')
    p.item(r, 'P3002_REMARKS', label='ملاحظات', display='TEXTAREA', source='REMARKS', source_region=r, seq=80)
    p.item(r, 'P3002_IS_ACTIVE', label='نشطة', display='YESNO', source='IS_ACTIVE', source_region=r, default='Y', seq=90)
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:3001:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_item='P3002_COVERAGE_ID', cond_type='ITEM_IS_NOT_NULL',
             db_action='DELETE', confirm='هل تريد حذف هذه التغطية وفريقها؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item='P3002_COVERAGE_ID',
             cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إضافة', position='CREATE', hot=True, seq=40, cond_item='P3002_COVERAGE_ID',
             cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.form_processes(r, 'Coverage')
    # after create stay on the page to add the crew
    p.branch(3002, seq=90, items=('P3002_COVERAGE_ID', '&P3002_COVERAGE_ID.'), cond=('REQUEST_IN_CONDITION', 'CREATE,SAVE'))
    child_ir(p, 'فريق التغطية', """select c.CREW_ID,
       case c.CREW_ROLE when 'PHOTOGRAPHER' then 'مصور' when 'EDITOR' then 'مونتاج' else 'مراسل' end as CREW_ROLE_AR,
       e.NAME_AR, e.EMPLOYEE_NO
  from MOINFO_MED_CREW c join MOINFO_EMPLOYEES e on e.EMPLOYEE_ID = c.EMPLOYEE_ID
 where c.COVERAGE_ID = :P3002_COVERAGE_ID""",
             [('CREW_ID', None, 'NUMBER'), ('CREW_ROLE_AR', 'الدور', 'STRING'), ('NAME_AR', 'الموظف', 'STRING'),
              ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING')],
             'CREW_ID', 3003, 'P3003_CREW_ID', 'P3002_COVERAGE_ID', 3003, 'P3003_COVERAGE_ID', 'إضافة عضو', seq=30)
    pages.append(p)

    pages.append(child_form(3003, 'عضو في فريق التغطية', 'MOINFO_MED_CREW', 'CREW_ID', 'COVERAGE_ID', 3002,
                            'P3002_COVERAGE_ID',
                            [dict(col='CREW_ROLE', label='الدور', display='SELECT', lov='MED_CREW_ROLE', null_text='- اختر -',
                                  required=True),
                             dict(col='EMPLOYEE_ID', label='الموظف', display='POPUP', lov='EMPLOYEES', null_text='',
                                  dtype='NUMBER', required=True)], 'MOD_MED'))

    p = Page(3004, 'إحصائيات التغطيات', authz='MOD_MED', alias='COVERAGE-STATS')
    p.ir_region('إحصائيات التغطيات', """select COVERAGE_YEAR, CHANNEL_AR, EVENT_TYPE_AR, COVERAGES_COUNT, ADDED_TODAY
  from MOINFO_MED_V_STATS order by COVERAGE_YEAR desc, COVERAGES_COUNT desc""",
        [('COVERAGE_YEAR', 'السنة', 'NUMBER'), ('CHANNEL_AR', 'القناة', 'STRING'), ('EVENT_TYPE_AR', 'نوع التغطية', 'STRING'),
         ('COVERAGES_COUNT', 'عدد التغطيات', 'NUMBER'), ('ADDED_TODAY', 'أضيف اليوم', 'NUMBER')])
    pages.append(p)

    p = Page(3005, 'عمل الفريق', authz='MOD_MED', alias='CREW-WORKLOAD')
    p.ir_region('عدد التغطيات لكل موظف', """select EMPLOYEE_ID, EMPLOYEE_NAME_AR, CREW_ROLE_AR, COVERAGE_YEAR, COVERAGES_COUNT
  from MOINFO_MED_V_CREW_WORKLOAD order by COVERAGE_YEAR desc, COVERAGES_COUNT desc""",
        [('EMPLOYEE_ID', None, 'NUMBER'), ('EMPLOYEE_NAME_AR', 'الموظف', 'STRING'), ('CREW_ROLE_AR', 'الدور', 'STRING'),
         ('COVERAGE_YEAR', 'السنة', 'NUMBER'), ('COVERAGES_COUNT', 'عدد التغطيات', 'NUMBER')])
    pages.append(p)

    pages += crud(3010, 3011, 'القنوات', 'قناة', 'MOINFO_MED_CHANNELS', 'CHANNEL_ID',
        f"""select CHANNEL_ID, NAME_AR, NAME_EN, SORT_ORDER, {YN.format(c='IS_ACTIVE')} as IS_ACTIVE_AR from MOINFO_MED_CHANNELS""",
        [('CHANNEL_ID', None, 'NUMBER'), ('NAME_AR', 'القناة', 'STRING'), ('NAME_EN', 'بالإنجليزية', 'STRING'),
         ('SORT_ORDER', 'الترتيب', 'NUMBER'), ('IS_ACTIVE_AR', 'نشطة', 'STRING')],
        [dict(col='NAME_AR', label='القناة بالعربية', required=True, maxlen=150),
         dict(col='NAME_EN', label='بالإنجليزية', maxlen=150),
         dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER'),
         dict(col='IS_ACTIVE', label='نشطة', display='YESNO', default='Y', new_line=False)],
        'MED_MANAGER', delete=False)
    pages += crud(3012, 3013, 'البرامج', 'برنامج', 'MOINFO_MED_PROGRAMS', 'PROGRAM_ID',
        f"""select p.PROGRAM_ID, c.NAME_AR as CHANNEL_AR, p.NAME_AR, p.NAME_EN, p.SORT_ORDER, {YN.format(c='p.IS_ACTIVE')} as IS_ACTIVE_AR
  from MOINFO_MED_PROGRAMS p join MOINFO_MED_CHANNELS c on c.CHANNEL_ID = p.CHANNEL_ID""",
        [('PROGRAM_ID', None, 'NUMBER'), ('CHANNEL_AR', 'القناة', 'STRING'), ('NAME_AR', 'البرنامج', 'STRING'),
         ('NAME_EN', 'بالإنجليزية', 'STRING'), ('SORT_ORDER', 'الترتيب', 'NUMBER'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
        [dict(col='CHANNEL_ID', label='القناة', display='SELECT', lov='MED_CHANNELS', null_text='- اختر -', dtype='NUMBER',
              required=True),
         dict(col='NAME_AR', label='البرنامج بالعربية', required=True, maxlen=150),
         dict(col='NAME_EN', label='بالإنجليزية', maxlen=150),
         dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER'),
         dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
        'MED_MANAGER', delete=False)
    return pages

# ------------------------------------------------------------------------------
# TSK
# ------------------------------------------------------------------------------
def tsk_pages():
    pages = []
    p = Page(4001, 'المهام', authz='MOD_TSK', alias='TASKS')
    reg = p.ir_region('المهام', """select t.TASK_ID, t.REF_NO, t.TITLE, t.STATUS_AR, t.PRIORITY_AR, t.TASK_TYPE_AR, t.TASK_CATEGORY_AR,
       t.ASSIGNED_NAME_AR, t.REQUESTER_NAME_AR, t.REQUESTER_UNIT_AR, t.RECEIVED_DATE, t.DUE_DATE, t.CLOSED_DATE,
       t.DURATION_DAYS, case t.IS_LATE when 'Y' then 'متأخرة' end as LATE_AR, t.IS_CLOSED
  from MOINFO_TSK_V_TASKS t
 where t.IS_ACTIVE = 'Y'
   and MOINFO_TSK.CAN_SEE(t.TASK_ID) = 'Y'
 order by t.RECEIVED_DATE desc, t.TASK_ID desc""",
        [('TASK_ID', None, 'NUMBER'), ('REF_NO', 'الرقم المرجعي', 'STRING'), ('TITLE', 'المهمة', 'STRING'),
         ('STATUS_AR', 'الحالة', 'STRING'), ('PRIORITY_AR', 'الأولوية', 'STRING'), ('TASK_TYPE_AR', 'النوع', 'STRING'),
         ('TASK_CATEGORY_AR', 'التصنيف', 'STRING'), ('ASSIGNED_NAME_AR', 'المكلّف', 'STRING'),
         ('REQUESTER_NAME_AR', 'صاحب الطلب', 'STRING'), ('REQUESTER_UNIT_AR', 'جهة الطلب', 'STRING'),
         ('RECEIVED_DATE', 'الاستلام', 'DATE'), ('DUE_DATE', 'الاستحقاق', 'DATE'), ('CLOSED_DATE', 'الإغلاق', 'DATE'),
         ('DURATION_DAYS', 'المدة (أيام)', 'NUMBER'), ('LATE_AR', 'التأخير', 'STRING'), ('IS_CLOSED', None, 'STRING')],
        pk='TASK_ID', link_page=4002, link_item='P4002_TASK_ID')
    p.button(reg, 'CREATE', 'مهمة جديدة', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:4002:&SESSION.::&DEBUG.:4002::', icon='fa-plus')
    pages.append(p)

    p = Page(4002, 'مهمة', authz='MOD_TSK', alias='TASK')
    guard(p, ":P4002_TASK_ID is not null and MOINFO_TSK.CAN_SEE(:P4002_TASK_ID) = 'N'", 'لا تملك صلاحية على هذه المهمة')
    r = p.form_region('مهمة', 'MOINFO_TSK_TASKS')
    p.item(r, 'P4002_TASK_ID', display='HIDDEN', source='TASK_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P4002_TITLE', label='المهمة', source='TITLE', source_region=r, required=True, maxlen=500, seq=10)
    p.item(r, 'P4002_REF_NO', label='الرقم المرجعي', source='REF_NO', source_region=r, maxlen=50, seq=20)
    p.item(r, 'P4002_PRIORITY', label='الأولوية', display='SELECT', source='PRIORITY', source_region=r, lov='TSK_PRIORITY',
           default='NORMAL', required=True, seq=30, new_line=False)
    p.item(r, 'P4002_STATUS_ID', label='الحالة', display='SELECT', source='STATUS_ID', source_region=r, dtype='NUMBER',
           lov='LK_TSK_STATUS', required=True, seq=40, default_expr="MOINFO_TSK.GET_STATUS_ID('NEW')")
    p.item(r, 'P4002_TASK_TYPE_ID', label='النوع', display='SELECT', source='TASK_TYPE_ID', source_region=r, dtype='NUMBER',
           lov='LK_TSK_TYPE', null_text='- -', seq=50, new_line=False)
    p.item(r, 'P4002_TASK_CATEGORY_ID', label='التصنيف', display='SELECT', source='TASK_CATEGORY_ID', source_region=r,
           dtype='NUMBER', lov='LK_TSK_CATEGORY', null_text='- -', seq=60, new_line=False)
    p.item(r, 'P4002_ASSIGNED_EMPLOYEE_ID', label='المكلّف', display='POPUP', source='ASSIGNED_EMPLOYEE_ID', source_region=r,
           dtype='NUMBER', lov='EMPLOYEES', null_text='', seq=70, default_expr='MOINFO_HR.MY_EMPLOYEE_ID')
    p.item(r, 'P4002_REQUESTER_EMPLOYEE_ID', label='صاحب الطلب (موظف)', display='POPUP', source='REQUESTER_EMPLOYEE_ID',
           source_region=r, dtype='NUMBER', lov='EMPLOYEES', null_text='', seq=80)
    p.item(r, 'P4002_REQUESTER_NAME', label='أو اسم صاحب الطلب', source='REQUESTER_NAME', source_region=r, maxlen=300,
           seq=90, new_line=False, help='لصاحب طلب من خارج الجهة أو غير مسجل كموظف')
    p.item(r, 'P4002_RECEIVED_DATE', label='تاريخ الاستلام', display='DATE', source='RECEIVED_DATE', source_region=r,
           dtype='DATE', required=True, seq=100, default_expr="to_char(sysdate, 'DD/MM/YYYY')")
    p.item(r, 'P4002_DUE_DATE', label='تاريخ الاستحقاق', display='DATE', source='DUE_DATE', source_region=r, dtype='DATE',
           seq=110, new_line=False)
    p.item(r, 'P4002_CLOSED_DATE', label='تاريخ الإغلاق', display='DISPLAY', source='CLOSED_DATE', source_region=r,
           dtype='DATE', seq=120, new_line=False)
    p.item(r, 'P4002_DESCRIPTION', label='التفاصيل', display='TEXTAREA', source='DESCRIPTION', source_region=r, seq=130)
    p.item(r, 'P4002_ACTION_TAKEN', label='الإجراء المتخذ', display='TEXTAREA', source='ACTION_TAKEN', source_region=r, seq=140)
    p.item(r, 'P4002_IS_ACTIVE', label='نشطة', display='YESNO', source='IS_ACTIVE', source_region=r, default='Y', seq=150)
    p.validation('Due after received', 'EXPRESSION',
                 ":P4002_DUE_DATE is null or to_date(:P4002_DUE_DATE, 'DD/MM/YYYY') >= to_date(:P4002_RECEIVED_DATE, 'DD/MM/YYYY')",
                 'تاريخ الاستحقاق يجب ألا يسبق تاريخ الاستلام', seq=10, expr2='PLSQL')
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:4001:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_item='P4002_TASK_ID', cond_type='ITEM_IS_NOT_NULL',
             db_action='DELETE', confirm='هل تريد حذف هذه المهمة؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item='P4002_TASK_ID',
             cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إضافة', position='CREATE', hot=True, seq=40, cond_item='P4002_TASK_ID',
             cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.form_processes(r, 'Task', dml_cond=DML)
    # follow-up notes
    nr = p.static_region('إضافة متابعة', None, seq=20, cond=('ITEM_IS_NOT_NULL', 'P4002_TASK_ID'))
    note = p.item(nr, 'P4002_NOTE_TEXT', label='ملاحظة المتابعة', display='TEXTAREA', seq=10)
    p.item(nr, 'P4002_NOTE_STATUS_ID', label='تغيير الحالة إلى', display='SELECT', lov='LK_TSK_STATUS',
           null_text='- بدون تغيير -', seq=20, new_line=False)
    add = p.button(nr, 'ADD_NOTE', 'إضافة المتابعة', position='NEXT', hot=True, seq=10)
    p.validation('Note required', 'ITEM_NOT_NULL', 'P4002_NOTE_TEXT', 'اكتب نص المتابعة', item=note, seq=40, when_button=add)
    p.plsql_process('Add note', """MOINFO_TSK.ADD_NOTE(:P4002_TASK_ID, :P4002_NOTE_TEXT, :P4002_NOTE_STATUS_ID);
:P4002_NOTE_TEXT := null;
:P4002_NOTE_STATUS_ID := null;""", seq=30, when_button=add, success='أُضيفت المتابعة')
    p.ir_region('سجل المتابعة', """select NOTE_ID, to_char(cast(CREATED_AT as date), 'DD/MM/YYYY HH24:MI') as CREATED_AT_TXT,
       CREATED_BY_NAME, NOTE_TEXT, STATUS_AR
  from MOINFO_TSK_V_NOTES
 where TASK_ID = :P4002_TASK_ID
 order by CREATED_AT desc""",
        [('NOTE_ID', None, 'NUMBER'), ('CREATED_AT_TXT', 'الوقت', 'STRING'), ('CREATED_BY_NAME', 'بواسطة', 'STRING'),
         ('NOTE_TEXT', 'المتابعة', 'STRING'), ('STATUS_AR', 'الحالة الجديدة', 'STRING')],
        seq=30, cond=('ITEM_IS_NOT_NULL', 'P4002_TASK_ID'))
    p.branch(4002, seq=50, items=('P4002_TASK_ID', '&P4002_TASK_ID.'), when_button=add)
    p.branch(4001, seq=100)
    pages.append(p)

    p = Page(4003, 'إحصائيات المهام', authz='MOD_TSK', alias='TASK-STATS')
    p.ir_region('المهام لكل موظف حسب الشهر', """select s.ASSIGNED_NAME_AR, to_char(s.RECEIVED_MONTH, 'YYYY-MM') as MONTH_TXT, s.TASKS_COUNT,
       s.DONE_COUNT, s.OPEN_COUNT, s.AVG_DAYS_TO_CLOSE
  from MOINFO_TSK_V_STATS s
 where MOINFO_SEC.DATA_SCOPE('TSK') = 'ALL'
    or (s.ASSIGNED_UNIT_ID is not null and MOINFO_SEC.CAN_SEE_UNIT('TSK', s.ASSIGNED_UNIT_ID) = 'Y')
    or s.ASSIGNED_EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID
 order by s.RECEIVED_MONTH desc, s.TASKS_COUNT desc""",
        [('ASSIGNED_NAME_AR', 'الموظف', 'STRING'), ('MONTH_TXT', 'الشهر', 'STRING'), ('TASKS_COUNT', 'المهام', 'NUMBER'),
         ('DONE_COUNT', 'المنجزة', 'NUMBER'), ('OPEN_COUNT', 'المفتوحة', 'NUMBER'),
         ('AVG_DAYS_TO_CLOSE', 'متوسط أيام الإنجاز', 'NUMBER')])
    pages.append(p)
    return pages

# ------------------------------------------------------------------------------
# ATT
# ------------------------------------------------------------------------------
def att_pages():
    pages = []
    p = Page(5001, 'المستندات', authz='MOD_ATT', alias='DOCUMENTS')
    reg = p.ir_region('المستندات', """select d.DOCUMENT_ID, d.CATEGORY_AR, d.TITLE, d.DOCUMENT_DATE, d.OWNER_UNIT_AR,
       case when d.LATEST_ATTACHMENT_ID is not null then
            '<a href="' || apex_page.get_url(p_page => 5003, p_items => 'P5003_ATTACHMENT_ID', p_values => d.LATEST_ATTACHMENT_ID)
            || '"><span class="fa fa-download"></span> ' || apex_escape.html(d.LATEST_FILE_NAME) || '</a>'
       end as LATEST_FILE,
       d.LATEST_FILE_SIZE, d.FILES_COUNT,
       to_char(cast(d.LATEST_UPLOADED_AT as date), 'DD/MM/YYYY HH24:MI') as UPLOADED_TXT,
       d.REMARKS
  from MOINFO_ATT_V_DOCUMENTS d
 where d.IS_ACTIVE = 'Y'
   and MOINFO_ATT.CAN_SEE(d.DOCUMENT_ID) = 'Y'""",
        [('DOCUMENT_ID', None, 'NUMBER'), ('CATEGORY_AR', 'التصنيف', 'STRING'), ('TITLE', 'العنوان', 'STRING'),
         ('DOCUMENT_DATE', 'التاريخ', 'DATE'), ('OWNER_UNIT_AR', 'الوحدة', 'STRING'), ('LATEST_FILE', 'آخر ملف', 'HTML'),
         ('LATEST_FILE_SIZE', 'الحجم', 'STRING'), ('FILES_COUNT', 'عدد الملفات', 'NUMBER'),
         ('UPLOADED_TXT', 'وقت الرفع', 'STRING'), ('REMARKS', 'ملاحظات', 'STRING')],
        pk='DOCUMENT_ID', link_page=5002, link_item='P5002_DOCUMENT_ID')
    p.button(reg, 'CREATE', 'مستند جديد', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:5002:&SESSION.::&DEBUG.:5002::', icon='fa-plus')
    pages.append(p)

    p = Page(5002, 'مستند', authz='MOD_ATT', alias='DOCUMENT')
    guard(p, ":P5002_DOCUMENT_ID is not null and MOINFO_ATT.CAN_SEE(:P5002_DOCUMENT_ID) = 'N'", 'لا تملك صلاحية على هذا المستند')
    r = p.form_region('مستند', 'MOINFO_ATT_DOCUMENTS')
    p.item(r, 'P5002_DOCUMENT_ID', display='HIDDEN', source='DOCUMENT_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P5002_CATEGORY_ID', label='التصنيف', display='SELECT', source='CATEGORY_ID', source_region=r, dtype='NUMBER',
           lov='LK_ATT_CATEGORY', null_text='- اختر -', required=True, seq=10)
    p.item(r, 'P5002_TITLE', label='العنوان', source='TITLE', source_region=r, required=True, maxlen=500, seq=20)
    p.item(r, 'P5002_DOCUMENT_DATE', label='التاريخ', display='DATE', source='DOCUMENT_DATE', source_region=r, dtype='DATE',
           seq=30)
    p.item(r, 'P5002_OWNER_UNIT_ID', label='الوحدة المالكة', display='POPUP', source='OWNER_UNIT_ID', source_region=r,
           dtype='NUMBER', lov='UNITS', null_text='', seq=40, new_line=False)
    p.item(r, 'P5002_REMARKS', label='ملاحظات', display='TEXTAREA', source='REMARKS', source_region=r, seq=50)
    p.item(r, 'P5002_IS_ACTIVE', label='نشط', display='YESNO', source='IS_ACTIVE', source_region=r, default='Y', seq=60)
    p.item(r, 'P5002_FILES', label='إرفاق ملفات', display='FILE', seq=70, multiple=True)
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:5001:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_item='P5002_DOCUMENT_ID', cond_type='ITEM_IS_NOT_NULL',
             db_action='DELETE', confirm='هل تريد حذف هذا المستند؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ', position='CHANGE', hot=True, seq=30, cond_item='P5002_DOCUMENT_ID',
             cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إضافة', position='CREATE', hot=True, seq=40, cond_item='P5002_DOCUMENT_ID',
             cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.form_processes(r, 'Document')
    p.plsql_process('Default owner unit', """if :P5002_DOCUMENT_ID is null and :P5002_OWNER_UNIT_ID is null then
    for r in (select UNIT_ID from MOINFO_EMPLOYEES where EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID) loop
        :P5002_OWNER_UNIT_ID := r.UNIT_ID;
    end loop;
end if;""", point='BEFORE_HEADER', seq=20)
    p.plsql_process('Store files', """declare
    l_n number;
begin
    l_n := MOINFO_FILES.ADD_FROM_APEX('ATT', 'MOINFO_ATT_DOCUMENTS', :P5002_DOCUMENT_ID, :P5002_FILES);
end;""", seq=30, cond=('REQUEST_IN_CONDITION', 'CREATE,SAVE'))
    p.ir_region('ملفات المستند', """select a.ATTACHMENT_ID,
       '<a href="' || apex_page.get_url(p_page => 5003, p_items => 'P5003_ATTACHMENT_ID', p_values => a.ATTACHMENT_ID)
       || '"><span class="fa fa-download"></span> ' || apex_escape.html(a.FILE_NAME) || '</a>' as FILE_LINK,
       a.FILE_SIZE_TEXT, a.CREATED_BY_NAME, to_char(cast(a.CREATED_AT as date), 'DD/MM/YYYY HH24:MI') as CREATED_AT_TXT
  from MOINFO_V_ATTACHMENTS a
 where a.ENTITY_NAME = 'MOINFO_ATT_DOCUMENTS' and a.ENTITY_ID = :P5002_DOCUMENT_ID
 order by a.CREATED_AT desc""",
        [('ATTACHMENT_ID', None, 'NUMBER'), ('FILE_LINK', 'الملف', 'HTML'), ('FILE_SIZE_TEXT', 'الحجم', 'STRING'),
         ('CREATED_BY_NAME', 'رفعه', 'STRING'), ('CREATED_AT_TXT', 'الوقت', 'STRING')],
        seq=30, cond=('ITEM_IS_NOT_NULL', 'P5002_DOCUMENT_ID'))
    p.branch(5001, seq=100)
    pages.append(p)

    # 5003 download
    p = Page(5003, 'تنزيل ملف', authz='MOD_ATT', alias='DOWNLOAD')
    dr = p.static_region('تنزيل', None, seq=10)
    p.item(dr, 'P5003_ATTACHMENT_ID', display='HIDDEN', seq=10)
    p.plsql_process('Download', "MOINFO_FILES.DOWNLOAD(:P5003_ATTACHMENT_ID);", point='BEFORE_HEADER', seq=10)
    pages.append(p)
    return pages

# ------------------------------------------------------------------------------
# Shared catalog (100-109)
# ------------------------------------------------------------------------------
def cat_pages():
    pages = []
    pages += crud(100, 101, 'أنواع المنتجات', 'نوع منتج', 'MOINFO_CAT_PRODUCT_TYPES', 'PRODUCT_TYPE_ID',
        f"""select PRODUCT_TYPE_ID, NAME_AR, NAME_EN, SORT_ORDER, {YN.format(c='IS_ACTIVE')} as IS_ACTIVE_AR from MOINFO_CAT_PRODUCT_TYPES""",
        [('PRODUCT_TYPE_ID', None, 'NUMBER'), ('NAME_AR', 'النوع', 'STRING'), ('NAME_EN', 'بالإنجليزية', 'STRING'),
         ('SORT_ORDER', 'الترتيب', 'NUMBER'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
        [dict(col='NAME_AR', label='النوع بالعربية', required=True, maxlen=150),
         dict(col='NAME_EN', label='بالإنجليزية', maxlen=150),
         dict(col='SORT_ORDER', label='الترتيب', display='NUMBER', dtype='NUMBER'),
         dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
        'CAT_MANAGER')
    pages += crud(102, 103, 'الماركات', 'ماركة', 'MOINFO_CAT_BRANDS', 'BRAND_ID',
        f"""select b.BRAND_ID, b.NAME, (select count(*) from MOINFO_CAT_MODELS m where m.BRAND_ID = b.BRAND_ID) as MODELS_COUNT,
       {YN.format(c='b.IS_ACTIVE')} as IS_ACTIVE_AR
  from MOINFO_CAT_BRANDS b""",
        [('BRAND_ID', None, 'NUMBER'), ('NAME', 'الماركة', 'STRING'), ('MODELS_COUNT', 'عدد الموديلات', 'NUMBER'),
         ('IS_ACTIVE_AR', 'نشطة', 'STRING')],
        [dict(col='NAME', label='الماركة', required=True, maxlen=150),
         dict(col='IS_ACTIVE', label='نشطة', display='YESNO', default='Y', new_line=False)],
        'CAT_MANAGER')
    pages += crud(104, 105, 'الموديلات', 'موديل', 'MOINFO_CAT_MODELS', 'MODEL_ID',
        f"""select m.MODEL_ID, m.BRAND_NAME, m.MODEL_NAME, m.PRODUCT_TYPE_AR, {YN.format(c='m.IS_ACTIVE')} as IS_ACTIVE_AR
  from MOINFO_CAT_V_MODELS m""",
        [('MODEL_ID', None, 'NUMBER'), ('BRAND_NAME', 'الماركة', 'STRING'), ('MODEL_NAME', 'الموديل', 'STRING'),
         ('PRODUCT_TYPE_AR', 'نوع المنتج', 'STRING'), ('IS_ACTIVE_AR', 'نشط', 'STRING')],
        [dict(col='BRAND_ID', label='الماركة', display='SELECT', lov='CAT_BRANDS', null_text='- اختر -', dtype='NUMBER',
              required=True),
         dict(col='NAME', label='الموديل', required=True, maxlen=150),
         dict(col='PRODUCT_TYPE_ID', label='نوع المنتج', display='SELECT', lov='CAT_PRODUCT_TYPES', null_text='- -',
              dtype='NUMBER'),
         dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
        'CAT_MANAGER')
    pages += crud(106, 107, 'الموردون', 'مورد', 'MOINFO_CAT_SUPPLIERS', 'SUPPLIER_ID',
        f"""select SUPPLIER_ID, NAME_AR, NAME_EN, CONTACT_PERSON, PHONE, EMAIL, {YN.format(c='IS_ACTIVE')} as IS_ACTIVE_AR
  from MOINFO_CAT_SUPPLIERS""",
        [('SUPPLIER_ID', None, 'NUMBER'), ('NAME_AR', 'المورد', 'STRING'), ('NAME_EN', 'بالإنجليزية', 'STRING'),
         ('CONTACT_PERSON', 'المسؤول', 'STRING'), ('PHONE', 'الهاتف', 'STRING'), ('EMAIL', 'البريد', 'STRING'),
         ('IS_ACTIVE_AR', 'نشط', 'STRING')],
        [dict(col='NAME_AR', label='المورد بالعربية', required=True, maxlen=200),
         dict(col='NAME_EN', label='بالإنجليزية', maxlen=200),
         dict(col='CONTACT_PERSON', label='الشخص المسؤول', maxlen=200),
         dict(col='PHONE', label='الهاتف', maxlen=30, new_line=False),
         dict(col='EMAIL', label='البريد الإلكتروني', maxlen=255, new_line=False),
         dict(col='ADDRESS', label='العنوان', display='TEXTAREA'),
         dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y')],
        'CAT_MANAGER')
    pages += crud(108, 109, 'أنواع الضمان', 'نوع ضمان', 'MOINFO_CAT_WARRANTY_TYPES', 'WARRANTY_TYPE_ID',
        f"""select WARRANTY_TYPE_ID, NAME_AR, MONTHS, {YN.format(c='IS_ACTIVE')} as IS_ACTIVE_AR from MOINFO_CAT_WARRANTY_TYPES""",
        [('WARRANTY_TYPE_ID', None, 'NUMBER'), ('NAME_AR', 'نوع الضمان', 'STRING'), ('MONTHS', 'المدة (أشهر)', 'NUMBER'),
         ('IS_ACTIVE_AR', 'نشط', 'STRING')],
        [dict(col='NAME_AR', label='نوع الضمان', required=True, maxlen=100),
         dict(col='MONTHS', label='المدة بالأشهر', display='NUMBER', dtype='NUMBER', required=True,
              help='تُحسب نهاية الضمان تلقائيًا من تاريخ البداية وهذه المدة'),
         dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y', new_line=False)],
        'CAT_MANAGER')
    return pages

# ------------------------------------------------------------------------------
# HD
# ------------------------------------------------------------------------------
HD_MGR = "MOINFO_HD.IS_MANAGER = 'Y'"

def hd_pages():
    pages = []
    req_cols = [('REQUEST_ID', 'رقم الطلب', 'NUMBER'), ('TITLE', 'الطلب', 'STRING'), ('STATUS_AR', 'الحالة', 'STRING'),
                ('REQUESTER_AR', 'صاحب الطلب', 'STRING'), ('REQUESTER_UNIT_AR', 'الجهة', 'STRING'),
                ('REQUESTER_EXT', 'التحويلة', 'STRING'), ('SERIAL_NO', 'الجهاز', 'STRING'),
                ('ASSIGNED_AR', 'الفني', 'STRING'), ('REQUEST_DATE', 'تاريخ الطلب', 'DATE'),
                ('CLOSED_DATE', 'تاريخ الإغلاق', 'DATE'), ('DURATION_DAYS', 'المدة (أيام)', 'NUMBER'),
                ('IS_CLOSED', None, 'STRING')]
    req_sel = """select r.REQUEST_ID, r.TITLE, r.STATUS_AR, r.REQUESTER_AR, r.REQUESTER_UNIT_AR, r.REQUESTER_EXT, r.SERIAL_NO,
       r.ASSIGNED_AR, r.REQUEST_DATE, r.CLOSED_DATE, r.DURATION_DAYS, r.IS_CLOSED
  from MOINFO_HD_V_REQUESTS r"""

    # 6001 requests
    p = Page(6001, 'طلبات الدعم', authz='MOD_HD', alias='HD-REQUESTS')
    reg = p.ir_region('طلبات الدعم', req_sel + """
 where r.IS_ACTIVE = 'Y'
   and MOINFO_HD.CAN_SEE_REQUEST(r.REQUEST_ID) = 'Y'
 order by r.IS_CLOSED, r.REQUEST_DATE desc, r.REQUEST_ID desc""", req_cols,
        pk='REQUEST_ID', link_page=6002, link_item='P6002_REQUEST_ID')
    p.button(reg, 'CREATE', 'طلب دعم جديد', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:6002:&SESSION.::&DEBUG.:6002::', icon='fa-plus')
    pages.append(p)

    # 6002 request form
    p = Page(6002, 'طلب دعم', authz='MOD_HD', alias='HD-REQUEST')
    guard(p, ":P6002_REQUEST_ID is not null and MOINFO_HD.CAN_SEE_REQUEST(:P6002_REQUEST_ID) = 'N'",
          'لا تملك صلاحية على هذا الطلب')
    r = p.form_region('طلب دعم', 'MOINFO_HD_REQUESTS')
    mgr = ('EXPRESSION', HD_MGR, 'PLSQL')
    p.item(r, 'P6002_REQUEST_ID', display='HIDDEN', source='REQUEST_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P6002_TITLE', label='عنوان المشكلة', source='TITLE', source_region=r, required=True, maxlen=300, seq=10)
    p.item(r, 'P6002_DEVICE_ID', label='الجهاز', display='POPUP', source='DEVICE_ID', source_region=r, dtype='NUMBER',
           lov='HD_REQUEST_DEVICES', null_text='', seq=20, help='اختياري: الجهاز الذي فيه المشكلة')
    p.item(r, 'P6002_DESCRIPTION', label='وصف المشكلة', display='TEXTAREA', source='DESCRIPTION', source_region=r, seq=30)
    p.item(r, 'P6002_REQUESTER_EMPLOYEE_ID', label='صاحب الطلب', display='POPUP', source='REQUESTER_EMPLOYEE_ID',
           source_region=r, dtype='NUMBER', lov='EMPLOYEES', null_text='', seq=40, cond=mgr,
           default_expr='MOINFO_HR.MY_EMPLOYEE_ID')
    p.item(r, 'P6002_REQUEST_DATE', label='تاريخ الطلب', display='DATE', source='REQUEST_DATE', source_region=r,
           dtype='DATE', seq=50, new_line=False, cond=mgr, default_expr="to_char(sysdate, 'DD/MM/YYYY')")
    p.item(r, 'P6002_STATUS_ID', label='الحالة', display='SELECT', source='STATUS_ID', source_region=r, dtype='NUMBER',
           lov='LK_HD_REQUEST_STATUS', seq=60, cond=mgr, default_expr="MOINFO_HD.LOOKUP_ID('HD_REQUEST_STATUS', 'NEW')")
    p.item(r, 'P6002_ASSIGNED_EMPLOYEE_ID', label='الفني المتابع', display='POPUP', source='ASSIGNED_EMPLOYEE_ID',
           source_region=r, dtype='NUMBER', lov='EMPLOYEES', null_text='', seq=70, new_line=False, cond=mgr)
    p.item(r, 'P6002_SOLUTION', label='الحل', display='TEXTAREA', source='SOLUTION', source_region=r, seq=80, cond=mgr)
    p.item(r, 'P6002_CLOSED_DATE', label='تاريخ الإغلاق', display='DISPLAY', source='CLOSED_DATE', source_region=r,
           dtype='DATE', seq=90, cond=('ITEM_IS_NOT_NULL', 'P6002_REQUEST_ID'))
    # read-only summary for the requester
    info = ('EXPRESSION', ":P6002_REQUEST_ID is not null and MOINFO_HD.IS_MANAGER = 'N'", 'PLSQL')
    p.item(r, 'P6002_INFO_STATUS', label='الحالة', display='DISPLAY', seq=100, cond=info)
    p.item(r, 'P6002_INFO_ASSIGNED', label='الفني المتابع', display='DISPLAY', seq=110, new_line=False, cond=info)
    p.item(r, 'P6002_INFO_SOLUTION', label='الحل', display='DISPLAY', seq=120, cond=info)
    p.plsql_process('Load request info', """for x in (select STATUS_AR, ASSIGNED_AR, SOLUTION from MOINFO_HD_V_REQUESTS
           where REQUEST_ID = :P6002_REQUEST_ID) loop
    :P6002_INFO_STATUS := x.STATUS_AR;
    :P6002_INFO_ASSIGNED := x.ASSIGNED_AR;
    :P6002_INFO_SOLUTION := x.SOLUTION;
end loop;""", point='BEFORE_HEADER', seq=20, cond=('ITEM_IS_NOT_NULL', 'P6002_REQUEST_ID'))
    p.validation('Requester known', 'EXPRESSION',
                 'nvl(:P6002_REQUESTER_EMPLOYEE_ID, MOINFO_HR.MY_EMPLOYEE_ID) is not null',
                 'حدد صاحب الطلب (حسابك غير مرتبط بموظف)', seq=10, expr2='PLSQL')
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:6001:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_type='EXPRESSION',
             cond_item=":P6002_REQUEST_ID is not null and " + HD_MGR, cond_lang='PLSQL',
             db_action='DELETE', confirm='هل تريد حذف هذا الطلب؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item='P6002_REQUEST_ID',
             cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إرسال الطلب', position='CREATE', hot=True, seq=40, cond_item='P6002_REQUEST_ID',
             cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.plsql_process('Default requester', """if :P6002_REQUEST_ID is null and :P6002_REQUESTER_EMPLOYEE_ID is null then
    :P6002_REQUESTER_EMPLOYEE_ID := MOINFO_HR.MY_EMPLOYEE_ID;
end if;""", seq=15, cond=('REQUEST_EQUALS_CONDITION', 'CREATE'))
    p.form_processes(r, 'Request', dml_cond=DML, success='تم حفظ الطلب')
    # follow-up notes
    nr = p.static_region('إضافة متابعة', None, seq=20, cond=('ITEM_IS_NOT_NULL', 'P6002_REQUEST_ID'))
    note = p.item(nr, 'P6002_NOTE_TEXT', label='ملاحظة المتابعة', display='TEXTAREA', seq=10)
    p.item(nr, 'P6002_NOTE_STATUS_ID', label='تغيير الحالة إلى', display='SELECT', lov='LK_HD_REQUEST_STATUS',
           null_text='- بدون تغيير -', seq=20, new_line=False, cond=mgr)
    add = p.button(nr, 'ADD_NOTE', 'إضافة المتابعة', position='NEXT', hot=True, seq=10)
    p.validation('Note required', 'ITEM_NOT_NULL', 'P6002_NOTE_TEXT', 'اكتب نص المتابعة', item=note, seq=40, when_button=add)
    p.plsql_process('Add note', """MOINFO_HD.ADD_NOTE(:P6002_REQUEST_ID, :P6002_NOTE_TEXT,
                  case when MOINFO_HD.IS_MANAGER = 'Y' then :P6002_NOTE_STATUS_ID end);
:P6002_NOTE_TEXT := null;
:P6002_NOTE_STATUS_ID := null;""", seq=30, when_button=add, success='أُضيفت المتابعة')
    p.ir_region('سجل المتابعة', """select NOTE_ID, to_char(cast(CREATED_AT as date), 'DD/MM/YYYY HH24:MI') as CREATED_AT_TXT,
       CREATED_BY_NAME, NOTE_TEXT, STATUS_AR
  from MOINFO_HD_V_REQUEST_NOTES
 where REQUEST_ID = :P6002_REQUEST_ID
 order by CREATED_AT desc""",
        [('NOTE_ID', None, 'NUMBER'), ('CREATED_AT_TXT', 'الوقت', 'STRING'), ('CREATED_BY_NAME', 'بواسطة', 'STRING'),
         ('NOTE_TEXT', 'المتابعة', 'STRING'), ('STATUS_AR', 'الحالة الجديدة', 'STRING')],
        seq=30, cond=('ITEM_IS_NOT_NULL', 'P6002_REQUEST_ID'))
    p.branch(6002, seq=50, items=('P6002_REQUEST_ID', '&P6002_REQUEST_ID.'), when_button=add)
    p.branch(6001, seq=100)
    pages.append(p)

    # 6003 devices
    dev_cols = [('DEVICE_ID', None, 'NUMBER'), ('SERIAL_NO', 'الرقم التسلسلي', 'STRING'),
                ('SERVICE_TAG', 'Service Tag', 'STRING'), ('DEVICE_NAME', 'اسم الجهاز', 'STRING'),
                ('PRODUCT_TYPE_AR', 'النوع', 'STRING'), ('BRAND_NAME', 'الماركة', 'STRING'),
                ('MODEL_NAME', 'الموديل', 'STRING'), ('STATUS_AR', 'الحالة', 'STRING'),
                ('CURRENT_EMPLOYEE_AR', 'المستلم', 'STRING'), ('CURRENT_UNIT_AR', 'الجهة', 'STRING'),
                ('SUPPLIER_AR', 'المورد', 'STRING'), ('PO_NO', 'أمر الشراء', 'STRING'),
                ('WARRANTY_END', 'نهاية الضمان', 'DATE'), ('WARRANTY_STATE_AR', 'الضمان', 'STRING'),
                ('PARTS_COUNT', 'قطع الغيار', 'NUMBER'), ('REQUESTS_COUNT', 'طلبات الدعم', 'NUMBER')]
    p = Page(6003, 'الأجهزة', authz='HD_MANAGER', alias='HD-DEVICES')
    reg = p.ir_region('الأجهزة', """select DEVICE_ID, SERIAL_NO, SERVICE_TAG, DEVICE_NAME, PRODUCT_TYPE_AR, BRAND_NAME, MODEL_NAME,
       STATUS_AR, CURRENT_EMPLOYEE_AR, CURRENT_UNIT_AR, SUPPLIER_AR, PO_NO, WARRANTY_END, WARRANTY_STATE_AR,
       PARTS_COUNT, REQUESTS_COUNT
  from MOINFO_HD_V_DEVICES
 where IS_ACTIVE = 'Y'
 order by SERIAL_NO""", dev_cols, pk='DEVICE_ID', link_page=6004, link_item='P6004_DEVICE_ID')
    p.button(reg, 'CREATE', 'جهاز جديد', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:6004:&SESSION.::&DEBUG.:6004::', icon='fa-plus')
    pages.append(p)

    # 6004 device form
    p = Page(6004, 'جهاز', authz='HD_MANAGER', alias='HD-DEVICE')
    r = p.form_region('جهاز', 'MOINFO_HD_DEVICES')
    p.item(r, 'P6004_DEVICE_ID', display='HIDDEN', source='DEVICE_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P6004_SERIAL_NO', label='الرقم التسلسلي', source='SERIAL_NO', source_region=r, required=True, maxlen=100, seq=10)
    p.item(r, 'P6004_SERVICE_TAG', label='Service Tag', source='SERVICE_TAG', source_region=r, maxlen=100, seq=20,
           new_line=False)
    p.item(r, 'P6004_DEVICE_NAME', label='اسم الجهاز', source='DEVICE_NAME', source_region=r, maxlen=150, seq=30,
           new_line=False)
    p.item(r, 'P6004_MODEL_ID', label='الموديل', display='POPUP', source='MODEL_ID', source_region=r, dtype='NUMBER',
           lov='CAT_MODELS', null_text='', seq=40)
    p.item(r, 'P6004_STATUS_ID', label='الحالة', display='SELECT', source='STATUS_ID', source_region=r, dtype='NUMBER',
           lov='LK_HD_DEVICE_STATUS', required=True, seq=50, new_line=False,
           default_expr="MOINFO_HD.LOOKUP_ID('HD_DEVICE_STATUS', 'IN_STOCK')",
           help='التسليم والاسترجاع يغيّران الحالة تلقائيًا')
    p.item(r, 'P6004_SUPPLIER_ID', label='المورد', display='SELECT', source='SUPPLIER_ID', source_region=r, dtype='NUMBER',
           lov='CAT_SUPPLIERS', null_text='- -', seq=60)
    p.item(r, 'P6004_PO_ID', label='أمر الشراء', display='SELECT', source='PO_ID', source_region=r, dtype='NUMBER',
           lov='HD_PURCHASE_ORDERS', null_text='- -', seq=70, new_line=False)
    p.item(r, 'P6004_WARRANTY_TYPE_ID', label='نوع الضمان', display='SELECT', source='WARRANTY_TYPE_ID', source_region=r,
           dtype='NUMBER', lov='CAT_WARRANTY_TYPES', null_text='- -', seq=80)
    p.item(r, 'P6004_WARRANTY_START', label='بداية الضمان', display='DATE', source='WARRANTY_START', source_region=r,
           dtype='DATE', seq=90, new_line=False)
    p.item(r, 'P6004_WARRANTY_END', label='نهاية الضمان', display='DATE', source='WARRANTY_END', source_region=r,
           dtype='DATE', seq=100, new_line=False, help='اتركه فارغًا ليُحسب من نوع الضمان وتاريخ البداية')
    p.item(r, 'P6004_HOLDER', label='المستلم الحالي', display='DISPLAY', seq=110,
           cond=('ITEM_IS_NOT_NULL', 'P6004_DEVICE_ID'))
    p.item(r, 'P6004_REMARKS', label='ملاحظات', display='TEXTAREA', source='REMARKS', source_region=r, seq=120)
    p.item(r, 'P6004_IS_ACTIVE', label='نشط', display='YESNO', source='IS_ACTIVE', source_region=r, default='Y', seq=130)
    p.plsql_process('Load holder', """for x in (select CURRENT_EMPLOYEE_AR, CURRENT_UNIT_AR from MOINFO_HD_V_DEVICES
           where DEVICE_ID = :P6004_DEVICE_ID) loop
    :P6004_HOLDER := nvl(x.CURRENT_EMPLOYEE_AR || nvl2(x.CURRENT_UNIT_AR, ' - ' || x.CURRENT_UNIT_AR, ''), 'في المخزن');
end loop;""", point='BEFORE_HEADER', seq=20, cond=('ITEM_IS_NOT_NULL', 'P6004_DEVICE_ID'))
    p.validation('Warranty dates', 'EXPRESSION',
                 ":P6004_WARRANTY_END is null or :P6004_WARRANTY_START is null or "
                 "to_date(:P6004_WARRANTY_END, 'DD/MM/YYYY') >= to_date(:P6004_WARRANTY_START, 'DD/MM/YYYY')",
                 'نهاية الضمان يجب ألا تسبق بدايته', seq=10, expr2='PLSQL')
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:6003:&SESSION.::&DEBUG.:::', exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_item='P6004_DEVICE_ID', cond_type='ITEM_IS_NOT_NULL',
             db_action='DELETE', confirm='هل تريد حذف هذا الجهاز وسجل تسليمه وقطع غياره؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ التعديلات', position='CHANGE', hot=True, seq=30, cond_item='P6004_DEVICE_ID',
             cond_type='ITEM_IS_NOT_NULL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إضافة', position='CREATE', hot=True, seq=40, cond_item='P6004_DEVICE_ID',
             cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.form_processes(r, 'Device', dml_cond=DML)
    # assign / return
    ar = p.static_region('تسليم الجهاز', None, seq=20, cond=('ITEM_IS_NOT_NULL', 'P6004_DEVICE_ID'))
    emp = p.item(ar, 'P6004_ASSIGN_EMPLOYEE_ID', label='تسليم إلى الموظف', display='POPUP', dtype='NUMBER',
                 lov='EMPLOYEES', null_text='', seq=10)
    p.item(ar, 'P6004_ASSIGN_UNIT_ID', label='أو إلى الجهة', display='POPUP', dtype='NUMBER', lov='UNITS', null_text='',
           seq=20, new_line=False, help='إن تُركت فارغة تؤخذ جهة الموظف')
    p.item(ar, 'P6004_ASSIGN_DATE', label='التاريخ', display='DATE', dtype='DATE', seq=30, new_line=False,
           default_expr="to_char(sysdate, 'DD/MM/YYYY')")
    p.item(ar, 'P6004_ASSIGN_REMARKS', label='ملاحظات التسليم', seq=40, maxlen=1000)
    assign = p.button(ar, 'ASSIGN', 'تسليم', position='NEXT', hot=True, seq=10, icon='fa-sign-out')
    ret = p.button(ar, 'RETURN', 'استرجاع إلى المخزن', position='NEXT', seq=20, icon='fa-sign-in',
                   cond_type='EXISTS', exec_val=False,
                   cond_item='select 1 from MOINFO_HD_ASSIGNMENTS where DEVICE_ID = :P6004_DEVICE_ID and RETURN_DATE is null',
                   confirm='استرجاع الجهاز إلى المخزن؟')
    p.validation('Assign target', 'EXPRESSION',
                 ':P6004_ASSIGN_EMPLOYEE_ID is not null or :P6004_ASSIGN_UNIT_ID is not null',
                 'اختر الموظف أو الجهة', item=emp, seq=40, expr2='PLSQL', when_button=assign)
    p.plsql_process('Assign device', """MOINFO_HD.ASSIGN_DEVICE(:P6004_DEVICE_ID, :P6004_ASSIGN_EMPLOYEE_ID, :P6004_ASSIGN_UNIT_ID,
                         nvl(to_date(:P6004_ASSIGN_DATE, 'DD/MM/YYYY'), trunc(sysdate)), :P6004_ASSIGN_REMARKS);
:P6004_ASSIGN_EMPLOYEE_ID := null;
:P6004_ASSIGN_UNIT_ID := null;
:P6004_ASSIGN_REMARKS := null;""", seq=30, when_button=assign, success='تم تسليم الجهاز')
    p.plsql_process('Return device', """MOINFO_HD.RETURN_DEVICE(:P6004_DEVICE_ID,
                         nvl(to_date(:P6004_ASSIGN_DATE, 'DD/MM/YYYY'), trunc(sysdate)), :P6004_ASSIGN_REMARKS);
:P6004_ASSIGN_REMARKS := null;""", seq=40, when_button=ret, success='تم استرجاع الجهاز')
    p.ir_region('سجل التسليم', """select ASSIGNMENT_ID, EMPLOYEE_AR, EMPLOYEE_NO, UNIT_AR, ASSIGNED_DATE, RETURN_DATE, DAYS_HELD,
       case IS_CURRENT when 'Y' then 'الحالي' end as CURRENT_AR, REMARKS
  from MOINFO_HD_V_ASSIGNMENTS
 where DEVICE_ID = :P6004_DEVICE_ID
 order by ASSIGNED_DATE desc, ASSIGNMENT_ID desc""",
        [('ASSIGNMENT_ID', None, 'NUMBER'), ('EMPLOYEE_AR', 'الموظف', 'STRING'), ('EMPLOYEE_NO', 'الرقم الوظيفي', 'STRING'),
         ('UNIT_AR', 'الجهة', 'STRING'), ('ASSIGNED_DATE', 'تاريخ التسليم', 'DATE'),
         ('RETURN_DATE', 'تاريخ الاسترجاع', 'DATE'), ('DAYS_HELD', 'المدة (أيام)', 'NUMBER'),
         ('CURRENT_AR', 'الحالي', 'STRING'), ('REMARKS', 'ملاحظات', 'STRING')],
        seq=30, cond=('ITEM_IS_NOT_NULL', 'P6004_DEVICE_ID'))
    child_ir(p, 'قطع الغيار', """select p.PART_ID, p.PART_NAME, p.PART_SN, s.NAME_AR as SUPPLIER_AR, p.WARRANTY_END,
       p.DELIVERY_DATE, case p.IS_DELIVERED when 'Y' then 'نعم' else 'لا' end as DELIVERED_AR, p.REMARKS
  from MOINFO_HD_SPARE_PARTS p
  left join MOINFO_CAT_SUPPLIERS s on s.SUPPLIER_ID = p.SUPPLIER_ID
 where p.DEVICE_ID = :P6004_DEVICE_ID""",
        [('PART_ID', None, 'NUMBER'), ('PART_NAME', 'القطعة', 'STRING'), ('PART_SN', 'الرقم التسلسلي', 'STRING'),
         ('SUPPLIER_AR', 'المورد', 'STRING'), ('WARRANTY_END', 'نهاية الضمان', 'DATE'),
         ('DELIVERY_DATE', 'تاريخ التوريد', 'DATE'), ('DELIVERED_AR', 'تم التوريد', 'STRING'), ('REMARKS', 'ملاحظات', 'STRING')],
        'PART_ID', 6005, 'P6005_PART_ID', 'P6004_DEVICE_ID', 6005, 'P6005_DEVICE_ID', 'إضافة قطعة', seq=40)
    p.ir_region('طلبات الدعم على الجهاز', req_sel + """
 where r.DEVICE_ID = :P6004_DEVICE_ID
 order by r.REQUEST_DATE desc""", req_cols, pk='REQUEST_ID', link_page=6002, link_item='P6002_REQUEST_ID', seq=50,
        cond=('ITEM_IS_NOT_NULL', 'P6004_DEVICE_ID'))
    p.branch(6004, seq=50, items=('P6004_DEVICE_ID', '&P6004_DEVICE_ID.'), when_button=assign)
    p.branch(6004, seq=60, items=('P6004_DEVICE_ID', '&P6004_DEVICE_ID.'), when_button=ret)
    p.branch(6003, seq=100)
    pages.append(p)

    # 6005 spare part
    pages.append(child_form(6005, 'قطعة غيار', 'MOINFO_HD_SPARE_PARTS', 'PART_ID', 'DEVICE_ID', 6004, 'P6004_DEVICE_ID', [
        dict(col='PART_NAME', label='القطعة', required=True, maxlen=200),
        dict(col='PART_SN', label='الرقم التسلسلي', maxlen=100),
        dict(col='SUPPLIER_ID', label='المورد', display='SELECT', lov='CAT_SUPPLIERS', null_text='- -', dtype='NUMBER'),
        dict(col='WARRANTY_TYPE_ID', label='نوع الضمان', display='SELECT', lov='CAT_WARRANTY_TYPES', null_text='- -',
             dtype='NUMBER'),
        dict(col='WARRANTY_START', label='بداية الضمان', display='DATE', dtype='DATE'),
        dict(col='WARRANTY_END', label='نهاية الضمان', display='DATE', dtype='DATE'),
        dict(col='DELIVERY_DATE', label='تاريخ التوريد', display='DATE', dtype='DATE'),
        dict(col='IS_DELIVERED', label='تم التوريد', display='YESNO', default='N'),
        dict(col='REMARKS', label='ملاحظات', display='TEXTAREA'),
    ], 'HD_MANAGER'))

    # 6006/6007 purchase orders
    pages += crud(6006, 6007, 'أوامر الشراء', 'أمر شراء', 'MOINFO_HD_PURCHASE_ORDERS', 'PO_ID',
        f"""select po.PO_ID, po.PO_NO, po.PO_NAME, po.PO_DATE, s.NAME_AR as SUPPLIER_AR,
       (select count(*) from MOINFO_HD_DEVICES d where d.PO_ID = po.PO_ID) as DEVICES_COUNT,
       {YN.format(c='po.IS_ACTIVE')} as IS_ACTIVE_AR
  from MOINFO_HD_PURCHASE_ORDERS po
  left join MOINFO_CAT_SUPPLIERS s on s.SUPPLIER_ID = po.SUPPLIER_ID""",
        [('PO_ID', None, 'NUMBER'), ('PO_NO', 'رقم الأمر', 'STRING'), ('PO_NAME', 'الوصف', 'STRING'),
         ('PO_DATE', 'التاريخ', 'DATE'), ('SUPPLIER_AR', 'المورد', 'STRING'), ('DEVICES_COUNT', 'عدد الأجهزة', 'NUMBER'),
         ('IS_ACTIVE_AR', 'نشط', 'STRING')],
        [dict(col='PO_NO', label='رقم أمر الشراء', required=True, maxlen=100),
         dict(col='PO_DATE', label='التاريخ', display='DATE', dtype='DATE', new_line=False),
         dict(col='PO_NAME', label='الوصف', maxlen=300),
         dict(col='SUPPLIER_ID', label='المورد', display='SELECT', lov='CAT_SUPPLIERS', null_text='- -', dtype='NUMBER'),
         dict(col='REMARKS', label='ملاحظات', display='TEXTAREA'),
         dict(col='IS_ACTIVE', label='نشط', display='YESNO', default='Y')],
        'HD_MANAGER')

    # 6008 warranty
    p = Page(6008, 'الضمان', authz='HD_MANAGER', alias='HD-WARRANTY')
    p.ir_region('الأجهزة والقطع التي ينتهي ضمانها قريبًا أو انتهى', """select DEVICE_ID, ITEM_KIND_AR, SERIAL_NO, ITEM_NAME, SUPPLIER_AR, WARRANTY_END, DAYS_LEFT,
       case when DAYS_LEFT < 0 then 'منتهي' else 'ينتهي قريبًا' end as STATE_AR, CURRENT_EMPLOYEE_AR
  from MOINFO_HD_V_WARRANTY_EXPIRING
 order by WARRANTY_END""",
        [('DEVICE_ID', None, 'NUMBER'), ('ITEM_KIND_AR', 'النوع', 'STRING'), ('SERIAL_NO', 'الرقم التسلسلي', 'STRING'),
         ('ITEM_NAME', 'الصنف', 'STRING'), ('SUPPLIER_AR', 'المورد', 'STRING'), ('WARRANTY_END', 'نهاية الضمان', 'DATE'),
         ('DAYS_LEFT', 'الأيام المتبقية', 'NUMBER'), ('STATE_AR', 'الحالة', 'STRING'),
         ('CURRENT_EMPLOYEE_AR', 'المستلم', 'STRING')],
        pk='DEVICE_ID', link_page=6004, link_item='P6004_DEVICE_ID')
    pages.append(p)

    # 6009 my devices
    p = Page(6009, 'أجهزتي', authz='HAS_EMPLOYEE', alias='HD-MY-DEVICES')
    reg = p.ir_region('الأجهزة المسلّمة لي', """select DEVICE_ID, SERIAL_NO, SERVICE_TAG, DEVICE_NAME, PRODUCT_TYPE_AR, BRAND_NAME, MODEL_NAME,
       WARRANTY_END, WARRANTY_STATE_AR, REQUESTS_COUNT
  from MOINFO_HD_V_DEVICES
 where CURRENT_EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID
 order by SERIAL_NO""",
        [('DEVICE_ID', None, 'NUMBER'), ('SERIAL_NO', 'الرقم التسلسلي', 'STRING'), ('SERVICE_TAG', 'Service Tag', 'STRING'),
         ('DEVICE_NAME', 'اسم الجهاز', 'STRING'), ('PRODUCT_TYPE_AR', 'النوع', 'STRING'), ('BRAND_NAME', 'الماركة', 'STRING'),
         ('MODEL_NAME', 'الموديل', 'STRING'), ('WARRANTY_END', 'نهاية الضمان', 'DATE'),
         ('WARRANTY_STATE_AR', 'الضمان', 'STRING'), ('REQUESTS_COUNT', 'طلبات الدعم', 'NUMBER')])
    p.button(reg, 'CREATE', 'طلب دعم جديد', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:6002:&SESSION.::&DEBUG.:6002::', icon='fa-life-ring')
    p.ir_region('سجل الأجهزة التي استلمتها', """select ASSIGNMENT_ID, SERIAL_NO, DEVICE_NAME, ASSIGNED_DATE, RETURN_DATE, DAYS_HELD, REMARKS
  from MOINFO_HD_V_ASSIGNMENTS
 where EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID
 order by ASSIGNED_DATE desc""",
        [('ASSIGNMENT_ID', None, 'NUMBER'), ('SERIAL_NO', 'الرقم التسلسلي', 'STRING'), ('DEVICE_NAME', 'الجهاز', 'STRING'),
         ('ASSIGNED_DATE', 'تاريخ الاستلام', 'DATE'), ('RETURN_DATE', 'تاريخ الإرجاع', 'DATE'),
         ('DAYS_HELD', 'المدة (أيام)', 'NUMBER'), ('REMARKS', 'ملاحظات', 'STRING')], seq=20)
    pages.append(p)
    return pages

# ------------------------------------------------------------------------------
# PRC (7000)
# ------------------------------------------------------------------------------
def prc_pages():
    pages = []
    req_cols = [('REQUEST_ID', None, 'NUMBER'), ('REQUEST_NO', 'رقم الطلب', 'STRING'), ('SUBJECT', 'الموضوع', 'STRING'),
                ('REQUEST_DATE', 'التاريخ', 'DATE'), ('REQUESTER_AR', 'صاحب الطلب', 'STRING'), ('UNIT_AR', 'الجهة', 'STRING'),
                ('STATUS_AR', 'الحالة', 'STRING'), ('ITEMS_COUNT', 'الأصناف', 'NUMBER'),
                ('TOTAL_AMOUNT', 'الإجمالي', 'NUMBER'), ('APPROVED_AMOUNT', 'المعتمد', 'NUMBER'),
                ('PO_NO', 'أمر الشراء', 'STRING'), ('PURCHASED_DATE', 'تاريخ الشراء', 'DATE'),
                ('DELIVERED_DATE', 'تاريخ الاستلام', 'DATE')]
    req_sel = """select REQUEST_ID, REQUEST_NO, SUBJECT, REQUEST_DATE, REQUESTER_AR, UNIT_AR, STATUS_AR, ITEMS_COUNT,
       TOTAL_AMOUNT, APPROVED_AMOUNT, PO_NO, PURCHASED_DATE, DELIVERED_DATE
  from MOINFO_PRC_V_REQUESTS"""

    def list_page(pid, title, alias, authz, where, create=False):
        p = Page(pid, title, authz=authz, alias=alias)
        reg = p.ir_region(title, req_sel + "\n where IS_ACTIVE = 'Y'\n   and " + where + "\n order by REQUEST_DATE desc, REQUEST_ID desc",
                          req_cols, pk='REQUEST_ID', link_page=7002, link_item='P7002_REQUEST_ID')
        if create:
            p.button(reg, 'CREATE', 'طلب شراء جديد', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
                     redirect='f?p=&APP_ID.:7002:&SESSION.::&DEBUG.:7002::', icon='fa-plus')
        return p

    pages.append(list_page(7001, 'طلبات الشراء', 'PRC-REQUESTS', 'MOD_PRC', "MOINFO_PRC.CAN_SEE(REQUEST_ID) = 'Y'", True))
    pages.append(list_page(7005, 'بانتظار الاعتماد', 'PRC-PENDING', 'PRC_MANAGER',
                           "STATUS_CODE = 'SUBMITTED' and MOINFO_PRC.CAN_DECIDE(REQUEST_ID) = 'Y'"))
    pages.append(list_page(7006, 'الشراء والاستلام', 'PRC-PURCHASING', 'PRC_PURCHASER',
                           "STATUS_CODE in ('APPROVED', 'PURCHASED')"))

    # 7002 request
    p = Page(7002, 'طلب شراء', authz='MOD_PRC', alias='PRC-REQUEST')
    guard(p, ":P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7002_REQUEST_ID) = 'N'", 'لا تملك صلاحية على هذا الطلب')
    r = p.form_region('طلب شراء', 'MOINFO_PRC_REQUESTS')
    mgr = ('EXPRESSION', "MOINFO_SEC.HAS_ROLE('PRC', 'MANAGER')", 'PLSQL')
    editable = ":P7002_REQUEST_ID is null or MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = 'Y'"
    p.item(r, 'P7002_REQUEST_ID', display='HIDDEN', source='REQUEST_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P7002_REQUEST_NO', label='رقم الطلب', display='DISPLAY', source='REQUEST_NO', source_region=r, seq=5,
           cond=('ITEM_IS_NOT_NULL', 'P7002_REQUEST_ID'))
    p.item(r, 'P7002_STATUS_TXT', label='الحالة', display='DISPLAY', seq=6, new_line=False,
           cond=('ITEM_IS_NOT_NULL', 'P7002_REQUEST_ID'))
    p.item(r, 'P7002_SUBJECT', label='الموضوع', source='SUBJECT', source_region=r, required=True, maxlen=300, seq=10)
    p.item(r, 'P7002_REQUEST_DATE', label='التاريخ', display='DATE', source='REQUEST_DATE', source_region=r, dtype='DATE',
           seq=20, default_expr="to_char(sysdate, 'DD/MM/YYYY')")
    p.item(r, 'P7002_REQUESTER_EMPLOYEE_ID', label='صاحب الطلب', display='POPUP', source='REQUESTER_EMPLOYEE_ID',
           source_region=r, dtype='NUMBER', lov='EMPLOYEES', null_text='', seq=30, new_line=False, cond=mgr,
           default_expr='MOINFO_HR.MY_EMPLOYEE_ID')
    p.item(r, 'P7002_UNIT_ID', label='الجهة الطالبة', display='POPUP', source='UNIT_ID', source_region=r, dtype='NUMBER',
           lov='UNITS', null_text='', seq=40, cond=mgr, help='إن تُركت فارغة تؤخذ جهة صاحب الطلب')
    p.item(r, 'P7002_JUSTIFICATION', label='المبررات', display='TEXTAREA', source='JUSTIFICATION', source_region=r, seq=50)
    p.item(r, 'P7002_REMARKS', label='ملاحظات', display='TEXTAREA', source='REMARKS', source_region=r, seq=60)
    p.item(r, 'P7002_DECISION_TXT', label='القرار', display='DISPLAY', seq=70,
           cond=('ITEM_IS_NOT_NULL', 'P7002_DECISION_TXT'))
    p.item(r, 'P7002_PURCHASE_TXT', label='الشراء والاستلام', display='DISPLAY', seq=80, new_line=False,
           cond=('ITEM_IS_NOT_NULL', 'P7002_PURCHASE_TXT'))
    p.plsql_process('Load request info', """for x in (select STATUS_AR, STATUS_CODE, DECIDED_BY_NAME, DECIDED_AT, DECISION_REASON, PO_NO,
                 PURCHASED_DATE, DELIVERED_DATE
            from MOINFO_PRC_V_REQUESTS where REQUEST_ID = :P7002_REQUEST_ID) loop
    :P7002_STATUS_TXT := x.STATUS_AR;
    if x.DECIDED_AT is not null or x.DECISION_REASON is not null then
        :P7002_DECISION_TXT := x.DECIDED_BY_NAME
            || nvl2(x.DECIDED_AT, ' - ' || to_char(cast(x.DECIDED_AT as date), 'DD/MM/YYYY HH24:MI'), '')
            || nvl2(x.DECISION_REASON, ': ' || x.DECISION_REASON, '');
    end if;
    if x.PURCHASED_DATE is not null then
        :P7002_PURCHASE_TXT := 'الشراء ' || to_char(x.PURCHASED_DATE, 'DD/MM/YYYY')
            || nvl2(x.PO_NO, ' (أمر ' || x.PO_NO || ')', '')
            || nvl2(x.DELIVERED_DATE, ' - الاستلام ' || to_char(x.DELIVERED_DATE, 'DD/MM/YYYY'), '');
    end if;
end loop;""", point='BEFORE_HEADER', seq=20, cond=('ITEM_IS_NOT_NULL', 'P7002_REQUEST_ID'))
    p.validation('Requester known', 'EXPRESSION',
                 'nvl(:P7002_REQUESTER_EMPLOYEE_ID, MOINFO_HR.MY_EMPLOYEE_ID) is not null',
                 'حدد صاحب الطلب (حسابك غير مرتبط بموظف)', seq=10, expr2='PLSQL')
    p.plsql_process('Default requester', """if :P7002_REQUEST_ID is null and :P7002_REQUESTER_EMPLOYEE_ID is null then
    :P7002_REQUESTER_EMPLOYEE_ID := MOINFO_HR.MY_EMPLOYEE_ID;
end if;""", seq=15, cond=('REQUEST_EQUALS_CONDITION', 'CREATE'))
    p.button(r, 'BACK', 'رجوع', action='REDIRECT_PAGE', position='CLOSE', seq=10,
             redirect='f?p=&APP_ID.:7001:&SESSION.::&DEBUG.:::', exec_val=False)
    delete = p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_type='EXPRESSION',
                      cond_item=":P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = 'Y'",
                      cond_lang='PLSQL', db_action='DELETE', confirm='هل تريد حذف هذا الطلب وأصنافه؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ', position='CHANGE', seq=30, cond_type='EXPRESSION',
             cond_item=":P7002_REQUEST_ID is not null and MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = 'Y'", cond_lang='PLSQL',
             db_action='UPDATE')
    create = p.button(r, 'CREATE', 'إنشاء وإضافة الأصناف', position='CREATE', hot=True, seq=40, cond_item='P7002_REQUEST_ID',
                      cond_type='ITEM_IS_NULL', db_action='INSERT')
    p.form_processes(r, 'Request', dml_cond=DML, success='تم الحفظ')

    # workflow actions
    ar = p.static_region('الإجراءات', None, seq=15, cond=('ITEM_IS_NOT_NULL', 'P7002_REQUEST_ID'))
    st = lambda codes: f"MOINFO_PRC.STATUS_CODE(:P7002_REQUEST_ID) in ({codes})"
    decide = f"MOINFO_PRC.CAN_DECIDE(:P7002_REQUEST_ID) = 'Y'"
    purch = "MOINFO_PRC.IS_PURCHASER = 'Y'"
    st_open = st("'DRAFT','SUBMITTED','APPROVED'")
    st_buy = st("'APPROVED','PURCHASED'")
    st_appr = st("'APPROVED'")
    st_purch = st("'PURCHASED'")
    reason = p.item(ar, 'P7002_ACTION_REASON', label='السبب / الملاحظة', display='TEXTAREA', seq=10, height=2,
                    cond=('EXPRESSION', f"{decide} or {st_open}", 'PLSQL'))
    p.item(ar, 'P7002_ACTION_DATE', label='التاريخ', display='DATE', dtype='DATE', seq=20,
           default_expr="to_char(sysdate, 'DD/MM/YYYY')",
           cond=('EXPRESSION', f"{purch} and {st_buy}", 'PLSQL'))
    p.item(ar, 'P7002_ACTION_PO_ID', label='أمر الشراء', display='SELECT', dtype='NUMBER', lov='HD_PURCHASE_ORDERS',
           null_text='- -', seq=30, new_line=False,
           cond=('EXPRESSION', f"{purch} and {st_appr}", 'PLSQL'))
    btns = {}
    def action(name, label, cond, seq, icon, confirm=None, hot=False, exec_val=False):
        btns[name] = p.button(ar, name, label, position='NEXT', seq=seq, icon=icon, hot=hot, confirm=confirm,
                              cond_type='EXPRESSION', cond_item=cond, cond_lang='PLSQL', exec_val=exec_val)
        return btns[name]
    action('SUBMIT', 'تقديم للاعتماد', f"MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = 'Y'", 10, 'fa-send', hot=True,
           confirm='تقديم الطلب للاعتماد؟ لن تتمكن من تعديل الأصناف بعدها')
    action('APPROVE', 'اعتماد', decide, 20, 'fa-check', hot=True, confirm='اعتماد الطلب؟')
    action('REJECT', 'رفض', decide, 30, 'fa-times', confirm='رفض الطلب؟', exec_val=True)
    action('REOPEN', 'إعادة إلى مسودة', st("'REJECTED'"), 40, 'fa-undo')
    action('PURCHASE', 'تسجيل الشراء', f"{purch} and {st_appr}", 50, 'fa-shopping-cart', hot=True)
    action('DELIVER', 'تسجيل الاستلام', f"{purch} and {st_purch}", 60, 'fa-truck', hot=True)
    action('CANCEL_REQ', 'إلغاء الطلب', st("'DRAFT','SUBMITTED','APPROVED'"), 70, 'fa-ban', confirm='إلغاء الطلب نهائيًا؟')
    p.validation('Reject reason', 'ITEM_NOT_NULL', 'P7002_ACTION_REASON', 'اكتب سبب الرفض', item=reason, seq=50,
                 when_button=btns['REJECT'])
    calls = {
        'SUBMIT': ("MOINFO_PRC.SUBMIT(:P7002_REQUEST_ID);", 'قُدّم الطلب للاعتماد'),
        'APPROVE': ("MOINFO_PRC.APPROVE(:P7002_REQUEST_ID, :P7002_ACTION_REASON);", 'اعتُمد الطلب'),
        'REJECT': ("MOINFO_PRC.REJECT(:P7002_REQUEST_ID, :P7002_ACTION_REASON);", 'رُفض الطلب'),
        'REOPEN': ("MOINFO_PRC.REOPEN(:P7002_REQUEST_ID);", 'عاد الطلب مسودة'),
        'PURCHASE': ("MOINFO_PRC.PURCHASE(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, 'DD/MM/YYYY'), :P7002_ACTION_PO_ID);",
                     'سُجّل الشراء'),
        'DELIVER': ("MOINFO_PRC.DELIVER(:P7002_REQUEST_ID, to_date(:P7002_ACTION_DATE, 'DD/MM/YYYY'));", 'سُجّل الاستلام'),
        'CANCEL_REQ': ("MOINFO_PRC.CANCEL(:P7002_REQUEST_ID, :P7002_ACTION_REASON);", 'أُلغي الطلب'),
    }
    seq = 30
    for name, (code, msg) in calls.items():
        p.plsql_process(f'Action {name}', code + "\n:P7002_ACTION_REASON := null;\n:P7002_ACTION_DATE := null;\n:P7002_ACTION_PO_ID := null;",
                        seq=seq, when_button=btns[name],
                        success=msg)
        seq += 1

    # items
    ir = p.ir_region('الأصناف', """select ITEM_ID, ITEM_NAME, PRODUCT_TYPE_AR, BRAND_NAME, MODEL_NAME, SUPPLIER_AR, QUANTITY, UNIT_PRICE,
       LINE_TOTAL, APPROVAL_AR, REJECT_REASON, DESCRIPTION
  from MOINFO_PRC_V_ITEMS
 where REQUEST_ID = :P7002_REQUEST_ID
 order by SORT_ORDER nulls last, ITEM_ID""",
        [('ITEM_ID', None, 'NUMBER'), ('ITEM_NAME', 'الصنف', 'STRING'), ('PRODUCT_TYPE_AR', 'النوع', 'STRING'),
         ('BRAND_NAME', 'الماركة', 'STRING'), ('MODEL_NAME', 'الموديل', 'STRING'), ('SUPPLIER_AR', 'المورد', 'STRING'),
         ('QUANTITY', 'الكمية', 'NUMBER'), ('UNIT_PRICE', 'سعر الوحدة', 'NUMBER'), ('LINE_TOTAL', 'الإجمالي', 'NUMBER'),
         ('APPROVAL_AR', 'القرار', 'STRING'), ('REJECT_REASON', 'سبب الرفض', 'STRING'), ('DESCRIPTION', 'الوصف', 'STRING')],
        pk='ITEM_ID', link_page=7003, link_item='P7003_ITEM_ID', seq=30, cond=('ITEM_IS_NOT_NULL', 'P7002_REQUEST_ID'))
    p.button(ir, 'ADD_ITEM', 'إضافة صنف', action='REDIRECT_PAGE', position='RIGHT_OF_IR_SEARCH_BAR', hot=True,
             redirect='f?p=&APP_ID.:7003:&SESSION.::&DEBUG.:7003:P7003_REQUEST_ID:&P7002_REQUEST_ID.', icon='fa-plus',
             cond_type='EXPRESSION', cond_item="MOINFO_PRC.CAN_EDIT(:P7002_REQUEST_ID) = 'Y'", cond_lang='PLSQL')

    # attachments
    fr = p.static_region('المرفقات', None, seq=40, cond=('ITEM_IS_NOT_NULL', 'P7002_REQUEST_ID'))
    files = p.item(fr, 'P7002_FILES', label='إرفاق ملفات (عرض سعر، فاتورة ...)', display='FILE', seq=10, multiple=True)
    up = p.button(fr, 'UPLOAD', 'رفع', position='NEXT', seq=10, icon='fa-upload', exec_val=False)
    p.plsql_process('Store files', """declare
    l_n number;
begin
    if MOINFO_PRC.CAN_SEE(:P7002_REQUEST_ID) = 'N' then
        raise_application_error(-20100, 'لا تملك صلاحية على هذا الطلب');
    end if;
    l_n := MOINFO_FILES.ADD_FROM_APEX('PRC', 'MOINFO_PRC_REQUESTS', :P7002_REQUEST_ID, :P7002_FILES);
end;""", seq=60, when_button=up, success='رُفعت الملفات')
    p.ir_region('ملفات الطلب', """select a.ATTACHMENT_ID,
       '<a href="' || apex_page.get_url(p_page => 7004, p_items => 'P7004_ATTACHMENT_ID', p_values => a.ATTACHMENT_ID)
       || '"><span class="fa fa-download"></span> ' || apex_escape.html(a.FILE_NAME) || '</a>' as FILE_LINK,
       a.FILE_SIZE_TEXT, a.CREATED_BY_NAME, to_char(cast(a.CREATED_AT as date), 'DD/MM/YYYY HH24:MI') as CREATED_AT_TXT
  from MOINFO_V_ATTACHMENTS a
 where a.ENTITY_NAME = 'MOINFO_PRC_REQUESTS' and a.ENTITY_ID = :P7002_REQUEST_ID
 order by a.CREATED_AT desc""",
        [('ATTACHMENT_ID', None, 'NUMBER'), ('FILE_LINK', 'الملف', 'HTML'), ('FILE_SIZE_TEXT', 'الحجم', 'STRING'),
         ('CREATED_BY_NAME', 'رفعه', 'STRING'), ('CREATED_AT_TXT', 'الوقت', 'STRING')],
        seq=50, cond=('ITEM_IS_NOT_NULL', 'P7002_REQUEST_ID'))
    p.branch(7001, seq=10, when_button=delete)
    p.branch(7002, seq=100, items=('P7002_REQUEST_ID', '&P7002_REQUEST_ID.'))
    pages.append(p)

    # 7003 item
    p = Page(7003, 'صنف', authz='MOD_PRC', alias='PRC-ITEM')
    guard(p, ":P7003_REQUEST_ID is not null and MOINFO_PRC.CAN_SEE(:P7003_REQUEST_ID) = 'N'", 'لا تملك صلاحية على هذا الطلب')
    r = p.form_region('صنف', 'MOINFO_PRC_REQUEST_ITEMS')
    p.item(r, 'P7003_ITEM_ID', display='HIDDEN', source='ITEM_ID', source_region=r, dtype='NUMBER', pk=True, seq=1)
    p.item(r, 'P7003_REQUEST_ID', display='HIDDEN', source='REQUEST_ID', source_region=r, dtype='NUMBER', seq=2)
    p.item(r, 'P7003_ITEM_NAME', label='الصنف', source='ITEM_NAME', source_region=r, required=True, maxlen=300, seq=10)
    p.item(r, 'P7003_PRODUCT_TYPE_ID', label='النوع', display='SELECT', source='PRODUCT_TYPE_ID', source_region=r,
           dtype='NUMBER', lov='CAT_PRODUCT_TYPES', null_text='- -', seq=20)
    p.item(r, 'P7003_BRAND_ID', label='الماركة', display='SELECT', source='BRAND_ID', source_region=r, dtype='NUMBER',
           lov='CAT_BRANDS', null_text='- -', seq=30, new_line=False)
    p.item(r, 'P7003_MODEL_ID', label='الموديل', display='SELECT', source='MODEL_ID', source_region=r, dtype='NUMBER',
           lov='PRC_MODELS_BY_BRAND', null_text='- -', seq=40, new_line=False, cascade='P7003_BRAND_ID')
    p.item(r, 'P7003_SUPPLIER_ID', label='المورد المقترح', display='SELECT', source='SUPPLIER_ID', source_region=r,
           dtype='NUMBER', lov='CAT_SUPPLIERS', null_text='- -', seq=50)
    p.item(r, 'P7003_QUANTITY', label='الكمية', display='NUMBER', source='QUANTITY', source_region=r, dtype='NUMBER',
           required=True, default='1', seq=60)
    p.item(r, 'P7003_UNIT_PRICE', label='سعر الوحدة', display='NUMBER', source='UNIT_PRICE', source_region=r,
           dtype='NUMBER', seq=70, new_line=False)
    p.item(r, 'P7003_SORT_ORDER', label='الترتيب', display='NUMBER', source='SORT_ORDER', source_region=r, dtype='NUMBER',
           seq=80, new_line=False)
    p.item(r, 'P7003_DESCRIPTION', label='الوصف والمواصفات', display='TEXTAREA', source='DESCRIPTION', source_region=r,
           seq=90)
    dec = ('EXPRESSION', "MOINFO_PRC.CAN_DECIDE(:P7003_REQUEST_ID) = 'Y'", 'PLSQL')
    p.item(r, 'P7003_IS_APPROVED', label='قرار الاعتماد', display='SELECT', source='IS_APPROVED', source_region=r,
           lov='PRC_ITEM_DECISION', null_text='- لم يُحدد -', seq=100, cond=dec)
    p.item(r, 'P7003_REJECT_REASON', label='سبب رفض الصنف', source='REJECT_REASON', source_region=r, maxlen=500, seq=110,
           new_line=False, cond=dec)
    back = "f?p=&APP_ID.:7002:&SESSION.::&DEBUG.::P7002_REQUEST_ID:&P7003_REQUEST_ID."
    can_edit = "MOINFO_PRC.CAN_EDIT(:P7003_REQUEST_ID) = 'Y'"
    p.button(r, 'CANCEL', 'إلغاء', action='REDIRECT_PAGE', position='CLOSE', seq=10, redirect=back, exec_val=False)
    p.button(r, 'DELETE', 'حذف', position='DELETE', seq=20, cond_type='EXPRESSION',
             cond_item=f":P7003_ITEM_ID is not null and {can_edit}", cond_lang='PLSQL',
             db_action='DELETE', confirm='حذف الصنف؟', exec_val=False)
    p.button(r, 'SAVE', 'حفظ', position='CHANGE', hot=True, seq=30, cond_type='EXPRESSION',
             cond_item=f":P7003_ITEM_ID is not null and ({can_edit} or MOINFO_PRC.CAN_DECIDE(:P7003_REQUEST_ID) = 'Y')",
             cond_lang='PLSQL', db_action='UPDATE')
    p.button(r, 'CREATE', 'إضافة', position='CREATE', hot=True, seq=40, cond_type='EXPRESSION',
             cond_item=f":P7003_ITEM_ID is null and {can_edit}", cond_lang='PLSQL', db_action='INSERT')
    p.form_processes(r, 'Item', dml_cond=DML)
    p.branch(7002, seq=100, items=('P7002_REQUEST_ID', '&P7003_REQUEST_ID.'))
    pages.append(p)

    # 7004 download
    p = Page(7004, 'تنزيل ملف', authz='MOD_PRC', alias='PRC-DOWNLOAD')
    dr = p.static_region('تنزيل', None, seq=10)
    p.item(dr, 'P7004_ATTACHMENT_ID', display='HIDDEN', seq=10)
    p.plsql_process('Download', """for a in (select ENTITY_ID from MOINFO_ATTACHMENTS
           where ATTACHMENT_ID = :P7004_ATTACHMENT_ID and ENTITY_NAME = 'MOINFO_PRC_REQUESTS') loop
    if MOINFO_PRC.CAN_SEE(a.ENTITY_ID) = 'Y' then
        MOINFO_FILES.DOWNLOAD(:P7004_ATTACHMENT_ID);
    end if;
end loop;
raise_application_error(-20100, 'الملف غير متاح');""", point='BEFORE_HEADER', seq=10)
    pages.append(p)

    # 7007 statistics
    p = Page(7007, 'إحصائيات المشتريات', authz='MOD_PRC', alias='PRC-STATS')
    p.ir_region('الطلبات حسب الشهر والجهة والحالة', """select to_char(REQUEST_MONTH, 'YYYY-MM') as MONTH_TXT, UNIT_AR, STATUS_AR, REQUESTS_COUNT, ITEMS_COUNT,
       TOTAL_AMOUNT, APPROVED_AMOUNT
  from MOINFO_PRC_V_STATS
 where MOINFO_SEC.DATA_SCOPE('PRC') = 'ALL'
    or (UNIT_ID is not null and MOINFO_SEC.CAN_SEE_UNIT('PRC', UNIT_ID) = 'Y')
 order by REQUEST_MONTH desc, UNIT_AR, STATUS_AR""",
        [('MONTH_TXT', 'الشهر', 'STRING'), ('UNIT_AR', 'الجهة', 'STRING'), ('STATUS_AR', 'الحالة', 'STRING'),
         ('REQUESTS_COUNT', 'الطلبات', 'NUMBER'), ('ITEMS_COUNT', 'الأصناف', 'NUMBER'),
         ('TOTAL_AMOUNT', 'الإجمالي', 'NUMBER'), ('APPROVED_AMOUNT', 'المعتمد', 'NUMBER')])
    pages.append(p)
    return pages

def all_pages():
    return hr_pages() + evt_pages() + med_pages() + tsk_pages() + att_pages() + hd_pages() + cat_pages() + prc_pages()

