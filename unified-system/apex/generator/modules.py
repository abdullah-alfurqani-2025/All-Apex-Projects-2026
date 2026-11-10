"""Module pages: HR (1000), EVT (2000), MED (3000), TSK (4000), ATT (5000)."""
from gen_app import *

DML = 'CREATE,SAVE,DELETE'

# ------------------------------------------------------------------------------
# Authorizations, LOVs, menu entries
# ------------------------------------------------------------------------------
def authorizations():
    calls = []
    for code in ['HR', 'EVT', 'MED', 'TSK', 'ATT']:
        calls.append(authorization(f'{code}_MANAGER', f"return MOINFO_SEC.HAS_ROLE('{code}', 'MANAGER');",
                                   'هذه الصفحة للمشرفين في الوحدة'))
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
              'TSK_CATEGORY', 'ATT_CATEGORY']:
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
]

def menu_items():
    items = [dict(text='بياناتي', page=1010, icon='fa-user-circle', authz='HAS_EMPLOYEE', current='1010', static='my-data')]
    for code, name, icon, children in MODULE_MENU:
        items.append(dict(text=name, target='#', icon=icon, key=f'm-{code}', authz=f'MOD_{code}' if code != 'HR' else None,
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
    }
    out = [dict(text='بياناتي', page=1010, icon='fa-user-circle', authz='HAS_EMPLOYEE', desc='بياناتك الوظيفية والشخصية',
                static='home-my')]
    for code, name, icon, children in MODULE_MENU:
        out.append(dict(text=name, page=children[0][1], icon=icon, authz=f'MOD_{code}', desc=descr[code],
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
    guard(p, ":P2002_EVENT_ID is not null and MOINFO_EVT.CAN_SEE((select EMPLOYEE_ID from MOINFO_EVT_EVENTS where EVENT_ID = :P2002_EVENT_ID)) = 'N'",
          'لا تملك صلاحية على هذه المشاركة')
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
         ('DURATION_DAYS', 'المدة (أيام)', 'NUMBER'), ('LATE_AR', 'التأخير', 'STRING'), ('IS_CLOSED', 'مغلقة', 'STRING')],
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
           dtype='NUMBER', lov='UNITS', null_text='', seq=40, new_line=False,
           default_expr='(select UNIT_ID from MOINFO_EMPLOYEES where EMPLOYEE_ID = MOINFO_HR.MY_EMPLOYEE_ID)')
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

def all_pages():
    return hr_pages() + evt_pages() + med_pages() + tsk_pages() + att_pages()
