-- اختبار وحدة دليل الجهات (NWS) بعد تشغيل 14_moinfo_nws.sql
-- يُشغَّل في SQL Commands كاملًا مرة واحدة، ثم يتراجع عن كل البيانات (ROLLBACK).
-- النتيجة المتوقعة: كل الأسطر PASS.
declare
    om number; fr number; g number; w number; m number; d number; o number; c1 number; c2 number; n number; x varchar2(1000);
    procedure ok(p varchar2, c boolean) is
    begin
        dbms_output.put_line(case when c then 'PASS ' else 'FAIL ' end || p);
    end;
begin
    insert into moinfo_users (username, display_name, is_sys_admin)
    values (upper(trim(v('APP_USER'))), 'ZZ اختبار', 'Y');
    ok('test user ' || v('APP_USER'), moinfo_nws.is_manager = 'Y');

    for o in (select object_name || ' ' || object_type t from user_objects
               where (object_name like 'MOINFO\_NWS%' escape '\' or object_name in ('MOINFO_V_COUNTRIES', 'MOINFO_COUNTRIES_BIUD'))
                 and status <> 'VALID') loop
        ok('invalid ' || o.t, false);
    end loop;

    -- دول ومحافظة وولاية للاختبار (تُحذف مع ROLLBACK)
    select min(country_id) into om from moinfo_countries where iso2 = 'OM';
    if om is null then
        insert into moinfo_countries (iso2, name_ar) values ('OM', 'ZZ عُمان') returning country_id into om;
    end if;
    insert into moinfo_countries (name_ar, region_id)
    values ('ZZ دولة', (select lookup_id from moinfo_lookups where lookup_type = 'WORLD_REGION' and lookup_code = 'EUROPE'))
    returning country_id into fr;
    select region_ar into x from moinfo_v_countries where country_id = fr; ok('country region ' || x, x = 'أوروبا');
    insert into moinfo_governorates (name_ar) values ('ZZ محافظة') returning governorate_id into g;
    insert into moinfo_wilayats (governorate_id, name_ar) values (g, 'ZZ ولاية') returning wilayat_id into w;

    insert into moinfo_nws_entities (name_ar, country_id) values ('ZZ وزارة', om) returning entity_id into m;
    insert into moinfo_nws_entities (name_ar, parent_id) values ('ZZ دائرة', m) returning entity_id into d;
    insert into moinfo_nws_entities (name_ar, parent_id, wilayat_id) values ('ZZ مكتب', d, w) returning entity_id into o;
    select governorate_id || '/' || country_id into x from moinfo_nws_entities where entity_id = o;
    ok('wilayat sets governorate and Oman', x = g || '/' || om);
    select entity_path_ar || '|' || tree_depth || '|' || root_id into x from moinfo_nws_v_entities where entity_id = o;
    ok('path ' || x, x = 'ZZ وزارة » ZZ دائرة » ZZ مكتب|3|' || m);
    select children_count into n from moinfo_nws_v_entities where entity_id = m; ok('children', n = 1);

    insert into moinfo_nws_contacts (entity_id, name, mobile1) values (o, 'ZZ موظف المكتب', '99000000') returning contact_id into c1;
    insert into moinfo_nws_contacts (country_id, name) values (fr, 'ZZ مراسل') returning contact_id into c2;
    select wilayat_ar || '/' || entity_path_ar into x from moinfo_nws_v_contacts where contact_id = c1;
    ok('contact entity ' || x, x = 'ZZ ولاية/ZZ وزارة » ZZ دائرة » ZZ مكتب');
    select country_ar || '/' || region_ar into x from moinfo_nws_v_contacts where contact_id = c2;
    ok('contact country only ' || x, x = 'ZZ دولة/أوروبا');
    begin
        insert into moinfo_nws_contacts (name) values ('ZZ بلا جهة');
        ok('contact needs entity or country', false);
    exception when others then ok('contact needs entity or country (' || sqlcode || ')', sqlcode = -2290);
    end;
    begin
        delete from moinfo_nws_entities where entity_id = d;
        ok('delete parent with children blocked', false);
    exception when others then ok('delete parent with children blocked (' || sqlcode || ')', sqlcode = -2292);
    end;
    delete from moinfo_nws_entities where entity_id = o;
    select count(*) into n from moinfo_nws_contacts where contact_id = c1; ok('cascade contacts', n = 0);

    rollback;
    select count(*) into n from moinfo_nws_entities; ok('rolled back', n = 0);
end;
