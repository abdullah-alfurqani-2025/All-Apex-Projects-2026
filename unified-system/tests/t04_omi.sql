-- اختبار وحدة تسجيل البصمة (OMI) بعد تشغيل 13_moinfo_omi.sql
-- يُشغَّل في SQL Commands كاملًا مرة واحدة. يضيف مستخدم المساحة الحالي مديرًا مؤقتًا في MOINFO_USERS
-- ليعمل التحقق من الصلاحيات، ثم يتراجع عن كل البيانات (ROLLBACK).
-- النتيجة المتوقعة: كل الأسطر PASS.
declare
    e number; t number; p1 number; p2 number; site number; pt number; n number; x varchar2(400);
    procedure ok(p varchar2, c boolean) is
    begin
        dbms_output.put_line(case when c then 'PASS ' else 'FAIL ' end || p);
    end;
    procedure expect(p varchar2, code number, got number) is
    begin
        ok(p || ' (' || got || ')', got = code);
    end;
begin
    insert into moinfo_users (username, display_name, is_sys_admin)
    values (upper(trim(v('APP_USER'))), 'ZZ اختبار', 'Y');
    ok('test user ' || v('APP_USER'), moinfo_omi.is_manager = 'Y');

    for o in (select object_name || ' ' || object_type t from user_objects
               where object_name like 'MOINFO\_OMI%' escape '\' and status <> 'VALID') loop
        ok('invalid ' || o.t, false);
    end loop;

    select lookup_id into site from moinfo_lookups where lookup_type = 'OMI_SITE' and lookup_code = 'SLL';
    select lookup_id into pt from moinfo_lookups where lookup_type = 'OMI_REG_POINT' and lookup_code = 'GATE_IN';
    insert into moinfo_omi_terminals (serial_no, name, reg_point_id) values ('ZZSN1', 'ZZ جهاز', pt) returning terminal_id into t;

    insert into moinfo_employees (name_ar, name_en, employee_no) values ('ZZ موظف', 'ZZ Emp', 'ZZ77') returning employee_id into e;
    insert into moinfo_omi_persons (employee_id, site_id) values (e, site) returning person_id into p1;
    select name_ar || '/' || emp_no into x from moinfo_omi_persons where person_id = p1;
    ok('name from employee ' || x, x = 'ZZ موظف/ZZ77');
    insert into moinfo_omi_persons (name_ar, civil_no) values ('ZZ خارجي', ' 9999 ') returning person_id into p2;
    select civil_no into x from moinfo_omi_persons where person_id = p2; ok('civil trimmed', x = '9999');

    begin moinfo_omi.mark_uploaded(p1); ok('upload before register blocked', false);
    exception when others then expect('upload before register blocked', -20113, sqlcode); end;

    moinfo_omi.register_person(p1, p_terminal_id => t);
    select is_registered || '/' || reg_point_id || '/' || nvl2(registered_at, 'D', '-') into x from moinfo_omi_persons where person_id = p1;
    ok('registered with terminal point ' || x, x = 'Y/' || pt || '/D');
    select count(*) into n from moinfo_omi_v_persons where trunc(registered_at) = trunc(sysdate) and person_id = p1; ok('today', n = 1);

    moinfo_omi.register_person(p2);
    n := moinfo_omi.mark_all_uploaded(site);
    ok('upload all for site ' || n, n = 1);
    select is_uploaded into x from moinfo_omi_persons where person_id = p2; ok('other site not uploaded', x = 'N');
    select not_uploaded_count into n from moinfo_omi_v_summary where site_id is null; ok('summary not uploaded', n >= 1);

    moinfo_omi.unregister_person(p1);
    select is_registered || is_uploaded || nvl2(uploaded_at, 'D', '-') into x from moinfo_omi_persons where person_id = p1;
    ok('unregister clears upload ' || x, x = 'NN-');
    select persons_count into n from moinfo_omi_v_terminals where terminal_id = t; ok('terminal count', n = 0);

    rollback;
    select count(*) into n from moinfo_omi_persons; ok('rolled back', n = 0);
end;
