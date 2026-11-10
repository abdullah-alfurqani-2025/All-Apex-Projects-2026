-- اختبار وحدة القسم التجاري (ADV) بعد تشغيل 12_moinfo_adv.sql
-- يُشغَّل في SQL Commands كاملًا مرة واحدة. يضيف مستخدم المساحة الحالي مديرًا مؤقتًا في MOINFO_USERS
-- ليعمل التحقق من الصلاحيات، ثم يتراجع عن كل البيانات (ROLLBACK).
-- النتيجة المتوقعة: كل الأسطر PASS.
declare
    ag number; co number; co2 number; c1 number; c2 number; d number; n number; x varchar2(400);
    procedure ok(p varchar2, c boolean) is
    begin
        dbms_output.put_line(case when c then 'PASS ' else 'FAIL ' end || p);
    end;
    procedure expect(p varchar2, code number, got number) is
    begin
        ok(p || ' (' || got || ')', got = code);
    end;
    function lk(t varchar2, c varchar2) return number is
        l number;
    begin
        select lookup_id into l from moinfo_lookups where lookup_type = t and lookup_code = c;
        return l;
    end;
begin
    insert into moinfo_users (username, display_name, is_sys_admin)
    values (upper(trim(v('APP_USER'))), 'ZZ اختبار', 'Y');
    ok('test user ' || v('APP_USER'), moinfo_adv.is_manager = 'Y');

    for o in (select object_name || ' ' || object_type t from user_objects
               where object_name like 'MOINFO\_ADV%' escape '\' and status <> 'VALID') loop
        ok('invalid ' || o.t, false);
    end loop;

    insert into moinfo_adv_accounts (account_type, name, agency_id) values ('AGENCY', 'ZZ وكالة', null) returning account_id into ag;
    insert into moinfo_adv_accounts (name, agency_id) values ('ZZ شركة', ag) returning account_id into co;
    insert into moinfo_adv_accounts (name) values ('ZZ شركة2') returning account_id into co2;
    insert into moinfo_adv_contacts (account_id, name, is_primary) values (co, 'ZZ جهة1', 'Y') returning contact_id into c1;
    insert into moinfo_adv_contacts (account_id, name) values (co2, 'ZZ جهة2') returning contact_id into c2;
    select clients_count into n from moinfo_adv_v_accounts where account_id = ag; ok('agency clients', n = 1);
    select primary_contact into x from moinfo_adv_v_accounts where account_id = co; ok('primary contact', x = 'ZZ جهة1');

    update moinfo_adv_accounts set agency_id = co2 where account_id = ag;
    select agency_id into n from moinfo_adv_accounts where account_id = ag; ok('agency has no agency', n is null);

    insert into moinfo_adv_deals (title, advertiser_id, contact_id) values ('ZZ فرصة', co, c1) returning deal_id into d;
    select status_code || '/' || agency_id into x from moinfo_adv_v_deals where deal_id = d;
    ok('deal defaults ' || x, x = 'NEW/' || ag);
    begin insert into moinfo_adv_deals (title, advertiser_id) values ('ZZ x', ag); ok('agency as advertiser blocked', false);
    exception when others then expect('agency as advertiser blocked', -20091, sqlcode); end;
    begin update moinfo_adv_deals set contact_id = c2 where deal_id = d; ok('foreign contact blocked', false);
    exception when others then expect('foreign contact blocked', -20093, sqlcode); end;

    moinfo_adv.add_activity(d, 'ZZ اتصال', lk('ADV_ACTIVITY_TYPE', 'CALL'), trunc(sysdate), trunc(sysdate) - 0, lk('ADV_DEAL_STATUS', 'IN_PROGRESS'));
    select status_code || '/' || followup_state_ar into x from moinfo_adv_v_deals where deal_id = d;
    ok('activity updates deal ' || x, x = 'IN_PROGRESS/اليوم');
    begin moinfo_adv.add_activity(d, 'ZZ', p_date => trunc(sysdate), p_next_date => trunc(sysdate) - 1); ok('next before date blocked', false);
    exception when others then expect('next before date blocked', -20096, sqlcode); end;
    moinfo_adv.add_activity(d, 'ZZ تعاقد', p_status_id => lk('ADV_DEAL_STATUS', 'WON'), p_next_date => trunc(sysdate) + 5);
    select is_closed || '/' || nvl(to_char(closed_date), '-') || '/' || nvl(to_char(next_followup_date), '-') into x
      from moinfo_adv_v_deals where deal_id = d;
    ok('won closes deal ' || x, x like 'Y/%' and x not like 'Y/-/%' and x like '%/-');
    select count(*) into n from moinfo_adv_v_activities where deal_id = d; ok('activities 2', n = 2);
    select count(*) into n from moinfo_adv_v_stats where status_code = 'WON'; ok('stats', n >= 1);

    delete from moinfo_adv_contacts where contact_id = c1;
    select contact_id into n from moinfo_adv_deals where deal_id = d; ok('contact delete sets null', n is null);
    delete from moinfo_adv_deals where deal_id = d;
    select count(*) into n from moinfo_adv_activities where deal_id = d; ok('cascade activities', n = 0);

    rollback;
    select count(*) into n from moinfo_adv_accounts; ok('rolled back', n = 0);
end;
