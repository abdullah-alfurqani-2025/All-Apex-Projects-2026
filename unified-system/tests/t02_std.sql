-- اختبار وحدة مخزن الاستوديو (STD) بعد تشغيل 11_moinfo_std.sql
-- يُشغَّل في SQL Commands كاملًا مرة واحدة. ينشئ جلسة APEX باسم ADMIN ليعمل التحقق من الصلاحيات،
-- ثم يتراجع عن كل البيانات (ROLLBACK) ويعيد Sequence الباركود إلى بدايته.
-- النتيجة المتوقعة: كل الأسطر PASS.
declare
    e number; it number; n number; x varchar2(400); b varchar2(50);
    procedure ok(p varchar2, c boolean) is
    begin
        dbms_output.put_line(case when c then 'PASS ' else 'FAIL ' end || p);
    end;
    procedure expect(p varchar2, code number) is
    begin
        ok(p || ' (' || sqlcode || ')', sqlcode = code);
    end;
begin
    apex_session.create_session(p_app_id => 145032, p_page_id => 1, p_username => 'ADMIN');

    for o in (select object_name || ' ' || object_type t from user_objects
               where object_name like 'MOINFO\_STD%' escape '\' and status <> 'VALID') loop
        ok('invalid ' || o.t, false);
    end loop;

    insert into moinfo_employees (name_ar, employee_no) values ('ZZ موظف المخزن', 'ZZ1') returning employee_id into e;
    insert into moinfo_std_items (item_name, qty_in_stock) values ('ZZ كاميرا', 5) returning item_id, barcode into it, b;
    select status_code || '/' || qty_in_stock into x from moinfo_std_v_items where item_id = it;
    ok('item defaults barcode=' || b || ' ' || x, b is not null and x = 'GOOD/5');
    select count(*) into n from moinfo_std_movements where item_id = it and movement_type = 'IN' and qty_change = 5;
    ok('opening movement', n = 1);
    ok('item by barcode', moinfo_std.item_by_code(lower(b)) = it);

    begin
        update moinfo_std_items set qty_in_stock = 9 where item_id = it;
        ok('direct qty update blocked', false);
    exception when others then expect('direct qty update blocked', -20082);
    end;

    moinfo_std.issue(it, 2, e);
    select qty_in_stock into n from moinfo_std_items where item_id = it; ok('issue 2 -> stock ' || n, n = 3);
    begin moinfo_std.issue(it, 10, e); ok('over-issue blocked', false);
    exception when others then expect('over-issue blocked', -20072); end;
    begin moinfo_std.issue(it, 1); ok('issue needs recipient', false);
    exception when others then expect('issue needs recipient', -20075); end;
    begin moinfo_std.return_item(it, 3, e); ok('over-return blocked', false);
    exception when others then expect('over-return blocked', -20077); end;

    moinfo_std.return_item(it, 1, e);
    select qty_out into n from moinfo_std_v_outstanding where item_id = it and employee_id = e; ok('outstanding 1', n = 1);
    moinfo_std.issue(it, 1, null, 'ZZ ضيف', p_expected_return => trunc(sysdate) + 3);
    select count(*) into n from moinfo_std_v_outstanding where item_id = it; ok('two recipients', n = 2);
    select is_overdue into x from moinfo_std_v_outstanding where item_id = it and employee_id is null; ok('not overdue', x = 'N');

    begin moinfo_std.adjust(it, 10, null); ok('adjust needs reason', false);
    exception when others then expect('adjust needs reason', -20080); end;
    moinfo_std.adjust(it, 10, 'ZZ جرد');
    select qty_in_stock || '/' || qty_out || '/' || qty_total into x from moinfo_std_v_items where item_id = it;
    ok('after adjust ' || x, x = '10/2/12');
    select balance_after into n from moinfo_std_movements where item_id = it and movement_type = 'ADJUST';
    ok('balance after adjust', n = 10);

    update moinfo_std_items set min_qty = 20 where item_id = it;
    select is_low into x from moinfo_std_v_items where item_id = it; ok('low stock flag', x = 'Y');
    select count(*) into n from moinfo_std_v_movements where item_id = it; ok('movements view ' || n, n = 5);

    delete from moinfo_std_items where item_id = it;
    select count(*) into n from moinfo_std_movements where item_id = it; ok('cascade delete', n = 0);

    rollback;
    select count(*) into n from moinfo_std_items; ok('rolled back', n = 0);

    execute immediate 'drop sequence MOINFO_STD_BARCODE_SEQ';
    execute immediate 'create sequence MOINFO_STD_BARCODE_SEQ start with 100001 increment by 1 nocache';
    execute immediate 'alter trigger MOINFO_STD_ITEMS_RULES_BIU compile';
    apex_session.delete_session;
end;
