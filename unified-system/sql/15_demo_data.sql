--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- السكربت 15: بيانات تجريبية لكل الوحدات
--
-- يُشغَّل بعد 01 إلى 14، من SQL Workshop ← SQL Scripts.
--
-- الجزء أ: بيانات مرجعية دائمة تُضاف فقط إن كانت القائمة فارغة
--          (الدول، والولايات، والمسميات، والقوائم التي لم تُعبّأ مثل البنوك وأنواع المهام).
--          هذه لا تُحذف مع البيانات التجريبية، ويمكن تعديلها من صفحاتها.
-- الجزء ب: بيانات تجريبية وهمية (هيكل تنظيمي، و30 موظفًا، وسجلات في كل وحدة).
--          كل سطر يُسجَّل في MOINFO_DEMO_LOG، وتحذفها كلها بالسكربت 15z_demo_clean.sql.
--
-- كل الأسماء وأرقام الهواتف والأرقام المدنية والبريد وهمية. البريد على النطاق example.com المحجوز.
--
-- مستخدمو التجربة (اختياري): لإنشائهم ضع كلمة مرور مؤقتة في السطر المعلَّم بـ «ضع كلمة المرور هنا»
-- في الجزء ب قبل التشغيل (8 أحرف على الأقل، فيها حروف وأرقام). يُطلب تغييرها عند أول دخول.
-- إن تُركت كما هي يُتخطى إنشاء المستخدمين وتُنشأ بقية البيانات.
--------------------------------------------------------------------------------


--==============================================================================
-- 0) سجل البيانات التجريبية وحذفها
--==============================================================================
CREATE TABLE MOINFO_DEMO_LOG (
    LOG_ID      NUMBER GENERATED ALWAYS AS IDENTITY,
    TABLE_NAME  VARCHAR2(128) NOT NULL,
    ROW_ID      NUMBER        NOT NULL,
    LOGGED_AT   TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT MOINFO_DEMO_LOG_PK PRIMARY KEY (LOG_ID)
);

CREATE OR REPLACE PACKAGE MOINFO_DEMO AS
    -- يسجّل سطرًا تجريبيًا ليُحذف لاحقًا
    PROCEDURE LOG_ROW (p_table IN VARCHAR2, p_id IN NUMBER);
    -- يحذف كل البيانات التجريبية بعكس ترتيب إضافتها، ويُرجع عدد السطور المحذوفة
    FUNCTION CLEAN RETURN NUMBER;
    -- دوال مساعدة للسكربت (عامة لتُستخدم داخل SQL)
    FUNCTION LK (p_type IN VARCHAR2, p_code IN VARCHAR2) RETURN NUMBER;
    FUNCTION LKN (p_type IN VARCHAR2, p_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION D (p_days IN NUMBER) RETURN DATE;
    FUNCTION COUNTRY (p_iso IN VARCHAR2) RETURN NUMBER;
    FUNCTION WILAYAT (p_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION GOVERNORATE (p_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION TITLE (p_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION MODEL_OF (p_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION WARRANTY (p_months IN NUMBER) RETURN NUMBER;
    FUNCTION SUPPLIER (p_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION PTYPE (p_en IN VARCHAR2) RETURN NUMBER;
    FUNCTION BRAND (p_name IN VARCHAR2) RETURN NUMBER;
END MOINFO_DEMO;
/

CREATE OR REPLACE PACKAGE BODY MOINFO_DEMO AS

    PROCEDURE LOG_ROW (p_table IN VARCHAR2, p_id IN NUMBER) IS
    BEGIN
        IF p_id IS NOT NULL THEN
            INSERT INTO MOINFO_DEMO_LOG (TABLE_NAME, ROW_ID) VALUES (UPPER(p_table), p_id);
        END IF;
    END LOG_ROW;

    FUNCTION PK_COLUMN (p_table IN VARCHAR2) RETURN VARCHAR2 IS
        l_col VARCHAR2(128);
    BEGIN
        SELECT MIN(cc.COLUMN_NAME) INTO l_col
          FROM USER_CONSTRAINTS c
          JOIN USER_CONS_COLUMNS cc ON cc.CONSTRAINT_NAME = c.CONSTRAINT_NAME
         WHERE c.TABLE_NAME = p_table AND c.CONSTRAINT_TYPE = 'P';
        RETURN l_col;
    END PK_COLUMN;

    FUNCTION CLEAN RETURN NUMBER IS
        l_total NUMBER := 0;
        l_left  NUMBER;
    BEGIN
        -- محاولتان: ما يفشل لارتباطه بسطر آخر يُحذف في المحاولة الثانية
        FOR pass IN 1 .. 3 LOOP
            FOR r IN (SELECT LOG_ID, TABLE_NAME, ROW_ID FROM MOINFO_DEMO_LOG ORDER BY LOG_ID DESC) LOOP
                BEGIN
                    EXECUTE IMMEDIATE 'DELETE FROM "' || r.TABLE_NAME || '" WHERE "' || PK_COLUMN(r.TABLE_NAME) || '" = :1'
                        USING r.ROW_ID;
                    l_total := l_total + SQL%ROWCOUNT;
                    DELETE FROM MOINFO_DEMO_LOG WHERE LOG_ID = r.LOG_ID;
                EXCEPTION
                    WHEN OTHERS THEN
                        IF pass = 3 THEN
                            DBMS_OUTPUT.PUT_LINE('لم يُحذف ' || r.TABLE_NAME || ' ' || r.ROW_ID || ': ' || SQLERRM);
                        END IF;
                END;
            END LOOP;
            SELECT COUNT(*) INTO l_left FROM MOINFO_DEMO_LOG;
            EXIT WHEN l_left = 0;
        END LOOP;
        RETURN l_total;
    END CLEAN;

    FUNCTION LK (p_type IN VARCHAR2, p_code IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(LOOKUP_ID) INTO l FROM MOINFO_LOOKUPS WHERE LOOKUP_TYPE = p_type AND LOOKUP_CODE = p_code;
        RETURN l;
    END;

    FUNCTION LKN (p_type IN VARCHAR2, p_name IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(LOOKUP_ID) INTO l FROM MOINFO_LOOKUPS WHERE LOOKUP_TYPE = p_type AND NAME_AR = p_name;
        RETURN l;
    END;

    FUNCTION D (p_days IN NUMBER) RETURN DATE IS
    BEGIN
        RETURN TRUNC(SYSDATE) + p_days;
    END;

    FUNCTION COUNTRY (p_iso IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(COUNTRY_ID) INTO l FROM MOINFO_COUNTRIES WHERE ISO2 = p_iso;
        RETURN l;
    END;

    FUNCTION WILAYAT (p_name IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(WILAYAT_ID) INTO l FROM MOINFO_WILAYATS WHERE NAME_AR = p_name;
        RETURN l;
    END;

    FUNCTION GOVERNORATE (p_name IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(GOVERNORATE_ID) INTO l FROM MOINFO_GOVERNORATES WHERE NAME_AR = p_name;
        RETURN l;
    END;

    FUNCTION TITLE (p_name IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(TITLE_ID) INTO l FROM MOINFO_TITLES WHERE TITLE_NAME_AR = p_name;
        RETURN l;
    END;

    FUNCTION MODEL_OF (p_name IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(MODEL_ID) INTO l FROM MOINFO_CAT_MODELS WHERE NAME = p_name;
        RETURN l;
    END;

    FUNCTION WARRANTY (p_months IN NUMBER) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(WARRANTY_TYPE_ID) INTO l FROM MOINFO_CAT_WARRANTY_TYPES WHERE MONTHS = p_months;
        RETURN l;
    END;

    FUNCTION SUPPLIER (p_name IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(SUPPLIER_ID) INTO l FROM MOINFO_CAT_SUPPLIERS WHERE NAME_AR = p_name;
        RETURN l;
    END;

    FUNCTION PTYPE (p_en IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(PRODUCT_TYPE_ID) INTO l FROM MOINFO_CAT_PRODUCT_TYPES WHERE NAME_EN = p_en;
        RETURN l;
    END;

    FUNCTION BRAND (p_name IN VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(BRAND_ID) INTO l FROM MOINFO_CAT_BRANDS WHERE UPPER(NAME) = UPPER(p_name);
        RETURN l;
    END;

END MOINFO_DEMO;
/


--==============================================================================
-- 0ب) إصلاح في النواة: رمز تلقائي للقيمة المرجعية التي تُضاف بلا رمز
--     القيد الفريد (LOOKUP_TYPE, LOOKUP_CODE) يرفض قيمتين بلا رمز في القائمة نفسها،
--     فتُعطى القيمة الجديدة بلا رمز الرمز L<رقمها>. (صفحات القوائم لا تطلب الرمز)
--==============================================================================
CREATE OR REPLACE TRIGGER MOINFO_LOOKUPS_CODE_BI
BEFORE INSERT OR UPDATE OF LOOKUP_CODE ON MOINFO_LOOKUPS
FOR EACH ROW
BEGIN
    IF TRIM(:NEW.LOOKUP_CODE) IS NULL THEN
        :NEW.LOOKUP_CODE := 'L' || NVL(TO_CHAR(:NEW.LOOKUP_ID), RAWTOHEX(SYS_GUID()));
    ELSE
        :NEW.LOOKUP_CODE := UPPER(TRIM(:NEW.LOOKUP_CODE));
    END IF;
END;
/


--==============================================================================
-- الجزء أ: بيانات مرجعية دائمة (تُضاف إن كانت فارغة فقط)
--==============================================================================
DECLARE
    l_n NUMBER;

    PROCEDURE lk (p_type VARCHAR2, p_ar VARCHAR2, p_en VARCHAR2, p_sort NUMBER, p_code VARCHAR2 DEFAULT NULL) IS
    BEGIN
        INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER)
        VALUES (p_type, p_code, p_ar, p_en, p_sort);
    END;

    FUNCTION empty (p_type VARCHAR2) RETURN BOOLEAN IS
        l NUMBER;
    BEGIN
        SELECT COUNT(*) INTO l FROM MOINFO_LOOKUPS WHERE LOOKUP_TYPE = p_type;
        RETURN l = 0;
    END;

    PROCEDURE country (p_iso VARCHAR2, p_ar VARCHAR2, p_en VARCHAR2, p_nat VARCHAR2, p_region VARCHAR2, p_sort NUMBER) IS
    BEGIN
        INSERT INTO MOINFO_COUNTRIES (ISO2, NAME_AR, NAME_EN, NATIONALITY_AR, SORT_ORDER, REGION_ID)
        VALUES (p_iso, p_ar, p_en, p_nat, p_sort,
                (SELECT LOOKUP_ID FROM MOINFO_LOOKUPS WHERE LOOKUP_TYPE = 'WORLD_REGION' AND LOOKUP_CODE = p_region));
    END;

    PROCEDURE wilayats (p_gov VARCHAR2, p_list VARCHAR2) IS
        l_gov NUMBER;
        l_items APEX_T_VARCHAR2 := APEX_STRING.SPLIT(p_list, ',');
    BEGIN
        SELECT MIN(GOVERNORATE_ID) INTO l_gov FROM MOINFO_GOVERNORATES WHERE NAME_AR = p_gov;
        IF l_gov IS NULL THEN
            RETURN;
        END IF;
        FOR i IN 1 .. l_items.COUNT LOOP
            INSERT INTO MOINFO_WILAYATS (GOVERNORATE_ID, NAME_AR, SORT_ORDER) VALUES (l_gov, TRIM(l_items(i)), i);
        END LOOP;
    END;
BEGIN
    -- الدول
    SELECT COUNT(*) INTO l_n FROM MOINFO_COUNTRIES;
    IF l_n = 0 THEN
        country('OM', 'سلطنة عُمان', 'Oman', 'عماني', 'GCC', 1);
        country('AE', 'الإمارات العربية المتحدة', 'United Arab Emirates', 'إماراتي', 'GCC', 2);
        country('SA', 'المملكة العربية السعودية', 'Saudi Arabia', 'سعودي', 'GCC', 3);
        country('QA', 'قطر', 'Qatar', 'قطري', 'GCC', 4);
        country('KW', 'الكويت', 'Kuwait', 'كويتي', 'GCC', 5);
        country('BH', 'البحرين', 'Bahrain', 'بحريني', 'GCC', 6);
        country('EG', 'مصر', 'Egypt', 'مصري', 'ARAB', 10);
        country('JO', 'الأردن', 'Jordan', 'أردني', 'ARAB', 11);
        country('LB', 'لبنان', 'Lebanon', 'لبناني', 'ARAB', 12);
        country('MA', 'المغرب', 'Morocco', 'مغربي', 'ARAB', 13);
        country('TN', 'تونس', 'Tunisia', 'تونسي', 'ARAB', 14);
        country('SD', 'السودان', 'Sudan', 'سوداني', 'ARAB', 15);
        country('YE', 'اليمن', 'Yemen', 'يمني', 'ARAB', 16);
        country('IN', 'الهند', 'India', 'هندي', 'ASIA', 20);
        country('PK', 'باكستان', 'Pakistan', 'باكستاني', 'ASIA', 21);
        country('BD', 'بنغلاديش', 'Bangladesh', 'بنغلاديشي', 'ASIA', 22);
        country('PH', 'الفلبين', 'Philippines', 'فلبيني', 'ASIA', 23);
        country('CN', 'الصين', 'China', 'صيني', 'ASIA', 24);
        country('JP', 'اليابان', 'Japan', 'ياباني', 'ASIA', 25);
        country('KR', 'كوريا الجنوبية', 'South Korea', 'كوري', 'ASIA', 26);
        country('IR', 'إيران', 'Iran', 'إيراني', 'ASIA', 27);
        country('TR', 'تركيا', 'Turkey', 'تركي', 'EUROPE', 30);
        country('GB', 'المملكة المتحدة', 'United Kingdom', 'بريطاني', 'EUROPE', 31);
        country('FR', 'فرنسا', 'France', 'فرنسي', 'EUROPE', 32);
        country('DE', 'ألمانيا', 'Germany', 'ألماني', 'EUROPE', 33);
        country('IT', 'إيطاليا', 'Italy', 'إيطالي', 'EUROPE', 34);
        country('RU', 'روسيا', 'Russia', 'روسي', 'EUROPE', 35);
        country('US', 'الولايات المتحدة', 'United States', 'أمريكي', 'AMERICAS', 40);
        country('CA', 'كندا', 'Canada', 'كندي', 'AMERICAS', 41);
        country('BR', 'البرازيل', 'Brazil', 'برازيلي', 'AMERICAS', 42);
        country('KE', 'كينيا', 'Kenya', 'كيني', 'AFRICA', 50);
        country('TZ', 'تنزانيا', 'Tanzania', 'تنزاني', 'AFRICA', 51);
        country('ZA', 'جنوب أفريقيا', 'South Africa', 'جنوب أفريقي', 'AFRICA', 52);
        country('AU', 'أستراليا', 'Australia', 'أسترالي', 'OCEANIA', 60);
    END IF;

    -- الولايات
    SELECT COUNT(*) INTO l_n FROM MOINFO_WILAYATS;
    IF l_n = 0 THEN
        wilayats('مسقط', 'مسقط,مطرح,بوشر,السيب,العامرات,قريات');
        wilayats('ظفار', 'صلالة,طاقة,مرباط,رخيوت,ثمريت,ضلكوت,المزيونة,مقشن,شليم وجزر الحلانيات,سدح');
        wilayats('مسندم', 'خصب,دبا,بخا,مدحاء');
        wilayats('البريمي', 'البريمي,محضة,السنينة');
        wilayats('الداخلية', 'نزوى,بهلاء,منح,الحمراء,أدم,إزكي,سمائل,بدبد,الجبل الأخضر');
        wilayats('شمال الباطنة', 'صحار,شناص,لوى,صحم,الخابورة,السويق');
        wilayats('جنوب الباطنة', 'الرستاق,العوابي,نخل,وادي المعاول,بركاء,المصنعة');
        wilayats('جنوب الشرقية', 'صور,الكامل والوافي,جعلان بني بو حسن,جعلان بني بو علي,مصيرة');
        wilayats('شمال الشرقية', 'إبراء,المضيبي,بدية,القابل,وادي بني خالد,دماء والطائيين');
        wilayats('الظاهرة', 'عبري,ينقل,ضنك');
        wilayats('الوسطى', 'هيماء,محوت,الدقم,الجازر');
    END IF;

    -- المسميات الوظيفية
    SELECT COUNT(*) INTO l_n FROM MOINFO_TITLES;
    IF l_n = 0 THEN
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('مدير عام', 'Director General', 1);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('مدير دائرة', 'Department Director', 2);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('رئيس قسم', 'Section Head', 3);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('مهندس', 'Engineer', 4);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('أخصائي', 'Specialist', 5);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('فني', 'Technician', 6);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('محاسب', 'Accountant', 7);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('مصور', 'Cameraman', 8);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('محرر أخبار', 'News Editor', 9);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('مندوب مبيعات', 'Sales Representative', 10);
        INSERT INTO MOINFO_TITLES (TITLE_NAME_AR, TITLE_NAME_EN, SORT_ORDER) VALUES ('موظف إداري', 'Administrative Officer', 11);
    END IF;

    -- القوائم الفارغة
    IF empty('HR_RELIGION') THEN
        lk('HR_RELIGION', 'مسلم', 'Muslim', 1);
        lk('HR_RELIGION', 'مسيحي', 'Christian', 2);
        lk('HR_RELIGION', 'أخرى', 'Other', 3);
    END IF;
    IF empty('HR_APPOINTMENT_TYPE') THEN
        lk('HR_APPOINTMENT_TYPE', 'دائم', 'Permanent', 1);
        lk('HR_APPOINTMENT_TYPE', 'عقد', 'Contract', 2);
        lk('HR_APPOINTMENT_TYPE', 'مؤقت', 'Temporary', 3);
    END IF;
    IF empty('HR_BANK') THEN
        lk('HR_BANK', 'بنك مسقط', 'Bank Muscat', 1);
        lk('HR_BANK', 'البنك الوطني العماني', 'National Bank of Oman', 2);
        lk('HR_BANK', 'بنك ظفار', 'Bank Dhofar', 3);
        lk('HR_BANK', 'بنك صحار الدولي', 'Sohar International', 4);
        lk('HR_BANK', 'البنك الأهلي', 'Ahli Bank', 5);
    END IF;
    IF empty('TSK_TYPE') THEN
        lk('TSK_TYPE', 'طلب دعم', 'Support Request', 1);
        lk('TSK_TYPE', 'تركيب', 'Installation', 2);
        lk('TSK_TYPE', 'صيانة', 'Maintenance', 3);
        lk('TSK_TYPE', 'مشروع', 'Project', 4);
        lk('TSK_TYPE', 'مراسلة', 'Correspondence', 5);
    END IF;
    IF empty('TSK_CATEGORY') THEN
        lk('TSK_CATEGORY', 'أجهزة', 'Hardware', 1);
        lk('TSK_CATEGORY', 'برامج', 'Software', 2);
        lk('TSK_CATEGORY', 'شبكات', 'Network', 3);
        lk('TSK_CATEGORY', 'بريد إلكتروني', 'Email', 4);
        lk('TSK_CATEGORY', 'أنظمة البث', 'Broadcast Systems', 5);
    END IF;
    IF empty('MED_EVENT') THEN
        lk('MED_EVENT', 'العيد الوطني', 'National Day', 1);
        lk('MED_EVENT', 'مهرجان خريف ظفار', 'Khareef Festival', 2);
        lk('MED_EVENT', 'زيارة رسمية', 'Official Visit', 3);
        lk('MED_EVENT', 'فعالية رياضية', 'Sports Event', 4);
        lk('MED_EVENT', 'معرض', 'Exhibition', 5);
    END IF;
    IF empty('MED_EVENT_TYPE') THEN
        lk('MED_EVENT_TYPE', 'تغطية مباشرة', 'Live', 1);
        lk('MED_EVENT_TYPE', 'تقرير مسجل', 'Recorded Report', 2);
        lk('MED_EVENT_TYPE', 'لقاء', 'Interview', 3);
    END IF;
    IF empty('ADV_INDUSTRY') THEN
        lk('ADV_INDUSTRY', 'اتصالات', 'Telecom', 1);
        lk('ADV_INDUSTRY', 'بنوك وتأمين', 'Banking', 2);
        lk('ADV_INDUSTRY', 'تجزئة', 'Retail', 3);
        lk('ADV_INDUSTRY', 'سيارات', 'Automotive', 4);
        lk('ADV_INDUSTRY', 'عقارات', 'Real Estate', 5);
        lk('ADV_INDUSTRY', 'سياحة وضيافة', 'Tourism', 6);
    END IF;
    IF empty('STD_LOCATION') THEN
        lk('STD_LOCATION', 'المخزن الرئيسي', 'Main Store', 1);
        lk('STD_LOCATION', 'استوديو 1', 'Studio 1', 2);
        lk('STD_LOCATION', 'استوديو 2', 'Studio 2', 3);
        lk('STD_LOCATION', 'وحدة البث الخارجي', 'OB Van', 4);
    END IF;
    IF empty('STD_BIN') THEN
        lk('STD_BIN', 'رف A1', 'A1', 1);
        lk('STD_BIN', 'رف A2', 'A2', 2);
        lk('STD_BIN', 'رف B1', 'B1', 3);
        lk('STD_BIN', 'خزانة الكاميرات', 'Camera Cabinet', 4);
    END IF;

    SELECT COUNT(*) INTO l_n FROM MOINFO_CAT_PRODUCT_TYPES;
    IF l_n = 0 THEN
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('حاسب مكتبي', 'Desktop', 1);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('حاسب محمول', 'Laptop', 2);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('شاشة', 'Monitor', 3);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('طابعة', 'Printer', 4);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('جهاز شبكة', 'Network Device', 5);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('كاميرا', 'Camera', 6);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('ميكروفون', 'Microphone', 7);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('إضاءة', 'Lighting', 8);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('حامل وملحقات', 'Tripod & Accessories', 9);
        INSERT INTO MOINFO_CAT_PRODUCT_TYPES (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('مستلزمات مكتبية', 'Office Supplies', 10);
    END IF;

    COMMIT;
END;
/


--==============================================================================
-- الجزء ب: البيانات التجريبية (تُسجَّل في MOINFO_DEMO_LOG وتُحذف بالسكربت 15z)
--==============================================================================
DECLARE
    -- لإنشاء مستخدمي التجربة: ضع كلمة مرور مؤقتة بين علامتي التنصيص (8 أحرف فأكثر، حروف وأرقام)
    c_password CONSTANT VARCHAR2(100) := 'ضع كلمة المرور هنا';

    TYPE t_num IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    emp   t_num;
    unit  t_num;
    dev   t_num;
    sitm  t_num;
    acc   t_num;
    cont  t_num;
    ent   t_num;
    l_id  NUMBER;
    l_id2 NUMBER;
    l_ret NUMBER;
    v1    NUMBER;
    v2    NUMBER;
    l_crew VARCHAR2(100);
    l_n   NUMBER;
    l_om  NUMBER;
    l_me  VARCHAR2(255) := UPPER(TRIM(V('APP_USER')));
    l_temp_admin BOOLEAN := FALSE;
    l_can_move   BOOLEAN := FALSE;

    PROCEDURE dlog (p_table VARCHAR2, p_id NUMBER) IS
    BEGIN
        MOINFO_DEMO.LOG_ROW(p_table, p_id);
    END;








    FUNCTION add_unit (p_parent NUMBER, p_depth NUMBER, p_code VARCHAR2, p_ar VARCHAR2, p_en VARCHAR2, p_sort NUMBER)
        RETURN NUMBER IS
        l NUMBER;
        lv NUMBER;
    BEGIN
        SELECT MIN(LEVEL_ID) INTO lv FROM MOINFO_LEVELS WHERE LEVEL_DEPTH = p_depth;
        INSERT INTO MOINFO_UNITS (PARENT_ID, LEVEL_ID, UNIT_CODE, UNIT_NAME_AR, UNIT_NAME_EN, SORT_ORDER)
        VALUES (p_parent, lv, p_code, p_ar, p_en, p_sort)
        RETURNING UNIT_ID INTO l;
        dlog('MOINFO_UNITS', l);
        RETURN l;
    END;

    PROCEDURE add_emp (p_i PLS_INTEGER, p_ar VARCHAR2, p_en VARCHAR2, p_gender VARCHAR2, p_unit PLS_INTEGER, p_title VARCHAR2) IS
    BEGIN
        INSERT INTO MOINFO_EMPLOYEES (EMPLOYEE_NO, NAME_AR, NAME_EN, UNIT_ID, TITLE_ID, GENDER, HIRE_DATE, EMAIL, MOBILE, PHONE_EXT)
        VALUES (TO_CHAR(99000 + p_i), p_ar, p_en, unit(p_unit), MOINFO_DEMO.TITLE(p_title), p_gender,
                ADD_MONTHS(DATE '2008-01-01', MOD(p_i * 17, 180)),
                'demo' || p_i || '@example.com', '9000' || LPAD(p_i, 4, '0'), TO_CHAR(2100 + p_i))
        RETURNING EMPLOYEE_ID INTO l_ret;
        emp(p_i) := l_ret;
        dlog('MOINFO_EMPLOYEES', emp(p_i));
    END;

    FUNCTION add_brand (p_name VARCHAR2) RETURN NUMBER IS
        l NUMBER;
    BEGIN
        SELECT MIN(BRAND_ID) INTO l FROM MOINFO_CAT_BRANDS WHERE UPPER(NAME) = UPPER(p_name);
        IF l IS NULL THEN
            INSERT INTO MOINFO_CAT_BRANDS (NAME) VALUES (p_name) RETURNING BRAND_ID INTO l;
            dlog('MOINFO_CAT_BRANDS', l);
        END IF;
        RETURN l;
    END;

    FUNCTION add_model (p_brand VARCHAR2, p_name VARCHAR2, p_type_en VARCHAR2) RETURN NUMBER IS
        l NUMBER;
        b NUMBER := add_brand(p_brand);
        t NUMBER;
    BEGIN
        SELECT MIN(MODEL_ID) INTO l FROM MOINFO_CAT_MODELS WHERE BRAND_ID = b AND UPPER(NAME) = UPPER(p_name);
        IF l IS NULL THEN
            SELECT MIN(PRODUCT_TYPE_ID) INTO t FROM MOINFO_CAT_PRODUCT_TYPES WHERE NAME_EN = p_type_en;
            INSERT INTO MOINFO_CAT_MODELS (BRAND_ID, PRODUCT_TYPE_ID, NAME) VALUES (b, t, p_name) RETURNING MODEL_ID INTO l;
            dlog('MOINFO_CAT_MODELS', l);
        END IF;
        RETURN l;
    END;






    PROCEDURE add_user (p_username VARCHAR2, p_display VARCHAR2, p_emp PLS_INTEGER, p_home VARCHAR2) IS
        l NUMBER;
    BEGIN
        l := MOINFO_ADMIN.CREATE_USER(p_username, p_display, c_password, emp(p_emp), 'demo' || p_emp || '@example.com', p_home);
        dlog('MOINFO_USERS', l);
        l_id := l;
    END;

    PROCEDURE grant_mod (p_module VARCHAR2, p_role VARCHAR2, p_scope VARCHAR2, p_unit PLS_INTEGER DEFAULT NULL) IS
    BEGIN
        MOINFO_ADMIN.GRANT_MODULE(l_id, p_module, p_role, p_scope, CASE WHEN p_unit IS NOT NULL THEN unit(p_unit) END);
    END;
BEGIN
    SELECT COUNT(*) INTO l_n FROM MOINFO_DEMO_LOG;
    IF l_n > 0 THEN
        RAISE_APPLICATION_ERROR(-20900, 'البيانات التجريبية موجودة من قبل. شغّل 15z_demo_clean.sql أولًا إن أردت إعادة إنشائها');
    END IF;

    -- مدير مؤقت باسم مستخدم مساحة العمل، لتسمح الحزم بحركات المخزن (يُحذف في النهاية)
    IF l_me IS NOT NULL THEN
        SELECT COUNT(*) INTO l_n FROM MOINFO_USERS WHERE USERNAME = l_me;
        IF l_n = 0 THEN
            INSERT INTO MOINFO_USERS (USERNAME, DISPLAY_NAME, IS_SYS_ADMIN) VALUES (l_me, 'مدير مؤقت للبيانات التجريبية', 'Y');
            l_temp_admin := TRUE;
        END IF;
        l_can_move := MOINFO_STD.CAN_MOVE = 'Y';
    END IF;

    l_om := MOINFO_DEMO.COUNTRY('OM');

    ----------------------------------------------------------------------------
    -- الهيكل التنظيمي
    ----------------------------------------------------------------------------
    unit(1)  := add_unit(NULL,     1, 'DEMO-S1',  'قطاع الشؤون الإدارية والمالية', 'Admin & Finance Sector', 1);
    unit(2)  := add_unit(unit(1),  2, 'DEMO-D1',  'دائرة الموارد البشرية', 'Human Resources Dept.', 1);
    unit(3)  := add_unit(unit(2),  3, 'DEMO-C1',  'قسم شؤون الموظفين', 'Personnel Section', 1);
    unit(4)  := add_unit(unit(2),  3, 'DEMO-C2',  'قسم التدريب', 'Training Section', 2);
    unit(5)  := add_unit(unit(1),  2, 'DEMO-D2',  'دائرة الشؤون المالية', 'Finance Dept.', 2);
    unit(6)  := add_unit(unit(5),  3, 'DEMO-C3',  'قسم المشتريات', 'Purchasing Section', 1);
    unit(7)  := add_unit(unit(5),  3, 'DEMO-C4',  'قسم الحسابات', 'Accounts Section', 2);
    unit(8)  := add_unit(NULL,     1, 'DEMO-S2',  'قطاع الهندسة والتقنية', 'Engineering & Technology Sector', 2);
    unit(9)  := add_unit(unit(8),  2, 'DEMO-D3',  'دائرة تقنية المعلومات', 'IT Dept.', 1);
    unit(10) := add_unit(unit(9),  3, 'DEMO-C5',  'قسم الدعم الفني', 'Technical Support Section', 1);
    unit(11) := add_unit(unit(9),  3, 'DEMO-C6',  'قسم الأنظمة والشبكات', 'Systems & Networks Section', 2);
    unit(12) := add_unit(unit(8),  2, 'DEMO-D4',  'دائرة الهندسة الإذاعية', 'Broadcast Engineering Dept.', 2);
    unit(13) := add_unit(unit(12), 3, 'DEMO-C7',  'قسم الاستوديوهات', 'Studios Section', 1);
    unit(14) := add_unit(NULL,     1, 'DEMO-S3',  'قطاع البرامج والأخبار', 'Programs & News Sector', 3);
    unit(15) := add_unit(unit(14), 2, 'DEMO-D5',  'دائرة الأخبار', 'News Dept.', 1);
    unit(16) := add_unit(unit(15), 3, 'DEMO-C8',  'قسم التغطيات الميدانية', 'Field Coverage Section', 1);
    unit(17) := add_unit(unit(14), 2, 'DEMO-D6',  'دائرة التسويق والإعلان', 'Marketing & Advertising Dept.', 2);
    unit(18) := add_unit(unit(17), 3, 'DEMO-C9',  'قسم المبيعات', 'Sales Section', 1);

    ----------------------------------------------------------------------------
    -- الموظفون (أسماء وهمية)
    ----------------------------------------------------------------------------
    add_emp(1,  'سالم بن خميس الحارثي',      'Salim Al Harthy',     'M', 2,  'مدير دائرة');
    add_emp(2,  'مريم بنت سعيد البلوشية',     'Maryam Al Balushi',   'F', 3,  'رئيس قسم');
    add_emp(3,  'خالد بن علي الهنائي',        'Khalid Al Hinai',     'M', 3,  'موظف إداري');
    add_emp(4,  'فاطمة بنت ناصر الكندية',     'Fatma Al Kindi',      'F', 4,  'أخصائي');
    add_emp(5,  'يوسف بن محمد الريامي',       'Yousuf Al Riyami',    'M', 5,  'مدير دائرة');
    add_emp(6,  'عائشة بنت حمد الشكيلية',     'Aisha Al Shukaili',   'F', 6,  'رئيس قسم');
    add_emp(7,  'ناصر بن سيف المعمري',        'Nasser Al Maamari',   'M', 6,  'موظف إداري');
    add_emp(8,  'هدى بنت عبدالله الرواحية',    'Huda Al Rawahi',      'F', 7,  'محاسب');
    add_emp(9,  'أحمد بن سالم العبري',         'Ahmed Al Abri',       'M', 9,  'مدير دائرة');
    add_emp(10, 'سعيد بن راشد السيابي',        'Saeed Al Siyabi',     'M', 10, 'رئيس قسم');
    add_emp(11, 'محمد بن عيسى الغافري',        'Mohammed Al Ghafri',  'M', 10, 'فني');
    add_emp(12, 'زينب بنت خلفان الشحية',       'Zainab Al Shehhi',    'F', 10, 'فني');
    add_emp(13, 'بدر بن حمود اليحيائي',        'Badr Al Yahyai',      'M', 11, 'مهندس');
    add_emp(14, 'ريم بنت مبارك الوهيبية',      'Reem Al Wahaibi',     'F', 11, 'مهندس');
    add_emp(15, 'طلال بن سليمان الفارسي',      'Talal Al Farsi',      'M', 12, 'مدير دائرة');
    add_emp(16, 'هيثم بن جمعة الزدجالي',       'Haitham Al Zadjali',  'M', 13, 'رئيس قسم');
    add_emp(17, 'مازن بن عبدالرحمن الحسني',    'Mazin Al Hasani',     'M', 13, 'فني');
    add_emp(18, 'شيماء بنت سالم المقبالية',    'Shaima Al Maqbali',   'F', 13, 'فني');
    add_emp(19, 'عبدالعزيز بن يحيى الرحبي',    'Abdulaziz Al Rahbi',  'M', 15, 'مدير دائرة');
    add_emp(20, 'نورة بنت حارب العامرية',      'Noora Al Amri',       'F', 16, 'رئيس قسم');
    add_emp(21, 'حمد بن علي السعدي',           'Hamad Al Saadi',      'M', 16, 'مصور');
    add_emp(22, 'إبراهيم بن خميس الجابري',     'Ibrahim Al Jabri',    'M', 16, 'مصور');
    add_emp(23, 'أسماء بنت ماجد الحوسنية',     'Asma Al Hosni',       'F', 15, 'محرر أخبار');
    add_emp(24, 'قيس بن ناصر التوبي',          'Qais Al Toobi',       'M', 15, 'محرر أخبار');
    add_emp(25, 'منى بنت سعود الهاشمية',       'Muna Al Hashmi',      'F', 17, 'مدير دائرة');
    add_emp(26, 'فيصل بن مسعود الشبلي',        'Faisal Al Shibli',    'M', 18, 'رئيس قسم');
    add_emp(27, 'لمياء بنت عامر الشامسية',     'Lamya Al Shamsi',     'F', 18, 'مندوب مبيعات');
    add_emp(28, 'وليد بن سالم الكلباني',       'Waleed Al Kalbani',   'M', 18, 'مندوب مبيعات');
    add_emp(29, 'حسن بن علي اللواتي',          'Hassan Al Lawati',    'M', 14, 'مدير عام');
    add_emp(30, 'سلمى بنت راشد الراشدية',      'Salma Al Rashdi',     'F', 8,  'مدير عام');

    ----------------------------------------------------------------------------
    -- HR: البيانات التفصيلية، ودليل الهواتف، وسجل البصمة
    ----------------------------------------------------------------------------
    FOR i IN 1 .. 30 LOOP
        IF i <= 27 THEN  -- الثلاثة الأخيرون بلا بيانات تفصيلية لتظهر في تقرير الناقص
            INSERT INTO MOINFO_HR_EMPLOYEE_DETAILS (
                EMPLOYEE_ID, GRADE, APPOINTMENT_TYPE_ID, BIRTH_DATE, BIRTH_PLACE, NATIONALITY_ID, MARITAL_STATUS_ID,
                RELIGION_ID, QUALIFICATION_ID, CIVIL_ID_NO, CIVIL_ID_ISSUE_DATE, CIVIL_ID_EXPIRY_DATE,
                PASSPORT_NO, PASSPORT_ISSUE_PLACE, PASSPORT_ISSUE_DATE, PASSPORT_EXPIRY_DATE, ADDRESS,
                BANK_ID, LEAVE_BALANCE_1, EMP_STATUS_ID, REMARKS)
            VALUES (
                emp(i), TO_CHAR(MOD(i, 8) + 4), MOINFO_DEMO.LKN('HR_APPOINTMENT_TYPE', CASE WHEN MOD(i, 7) = 0 THEN 'عقد' ELSE 'دائم' END),
                ADD_MONTHS(DATE '1972-03-01', MOD(i * 41, 330)), 'مسقط', l_om,
                MOINFO_DEMO.LK('HR_MARITAL_STATUS', CASE WHEN MOD(i, 3) = 0 THEN 'SINGLE' ELSE 'MARRIED' END),
                MOINFO_DEMO.LKN('HR_RELIGION', 'مسلم'),
                MOINFO_DEMO.LK('HR_QUALIFICATION', CASE MOD(i, 5) WHEN 0 THEN 'MASTER' WHEN 1 THEN 'BACHELOR' WHEN 2 THEN 'DIPLOMA'
                                                       WHEN 3 THEN 'BACHELOR' ELSE 'SECONDARY' END),
                TO_CHAR(10000000 + i * 271828), ADD_MONTHS(TRUNC(SYSDATE), -60 + MOD(i, 30)),
                CASE WHEN i IN (2, 5, 11) THEN MOINFO_DEMO.D(10 + i) ELSE ADD_MONTHS(TRUNC(SYSDATE), 6 + MOD(i * 7, 50)) END,
                'P' || LPAD(i * 3571, 7, '0'), 'مسقط', ADD_MONTHS(TRUNC(SYSDATE), -48 + MOD(i, 20)),
                CASE WHEN i IN (7, 14) THEN MOINFO_DEMO.D(40 + i) ELSE ADD_MONTHS(TRUNC(SYSDATE), 12 + MOD(i * 5, 60)) END,
                CASE MOD(i, 4) WHEN 0 THEN 'السيب' WHEN 1 THEN 'بوشر' WHEN 2 THEN 'مطرح' ELSE 'العامرات' END,
                MOINFO_DEMO.LKN('HR_BANK', CASE MOD(i, 3) WHEN 0 THEN 'بنك مسقط' WHEN 1 THEN 'البنك الوطني العماني' ELSE 'بنك ظفار' END),
                30 - MOD(i, 15), MOINFO_DEMO.LK('HR_EMP_STATUS', CASE WHEN i = 24 THEN 'LEAVE' ELSE 'ACTIVE' END),
                'بيانات تجريبية');
            dlog('MOINFO_HR_EMPLOYEE_DETAILS', emp(i));
        END IF;

        INSERT INTO MOINFO_HR_DIRECTORY (EMPLOYEE_ID, TEL1, SHOW_IN_DIRECTORY)
        VALUES (emp(i), '2400' || LPAD(i, 4, '0'), 'Y');
        dlog('MOINFO_HR_DIRECTORY', emp(i));
    END LOOP;

    FOR i IN 1 .. 20 LOOP
        FOR k IN 1 .. 5 LOOP
            INSERT INTO MOINFO_HR_ATTENDANCE_LOG (ATTENDANCE_PIN, CHECK_TIME, CHECK_TYPE, VERIFY_CODE, DEVICE_SN, LOCATION)
            VALUES (TO_CHAR(99000 + i), CAST(MOINFO_DEMO.D(-k) AS TIMESTAMP) + NUMTODSINTERVAL(7 * 60 + 20 + MOD(i * k * 7, 40), 'MINUTE'),
                    'I', 1, 'DEMO-ZK-01', 'المبنى الرئيسي')
            RETURNING LOG_ID INTO l_id;
            dlog('MOINFO_HR_ATTENDANCE_LOG', l_id);
            INSERT INTO MOINFO_HR_ATTENDANCE_LOG (ATTENDANCE_PIN, CHECK_TIME, CHECK_TYPE, VERIFY_CODE, DEVICE_SN, LOCATION)
            VALUES (TO_CHAR(99000 + i), CAST(MOINFO_DEMO.D(-k) AS TIMESTAMP) + NUMTODSINTERVAL(14 * 60 + 30 + MOD(i * k * 11, 50), 'MINUTE'),
                    'O', 1, 'DEMO-ZK-01', 'المبنى الرئيسي')
            RETURNING LOG_ID INTO l_id;
            dlog('MOINFO_HR_ATTENDANCE_LOG', l_id);
        END LOOP;
    END LOOP;

    ----------------------------------------------------------------------------
    -- EVT: مشاركات الموظفين
    ----------------------------------------------------------------------------
    FOR r IN (
        SELECT 1 e, 'COURSE' t, 'دورة القيادة الإدارية' ti, 'معهد الإدارة العامة' pl, 'OM' c, -120 s, 4 n FROM DUAL UNION ALL
        SELECT 4, 'WORKSHOP', 'ورشة تخطيط المسار الوظيفي', 'مسقط', 'OM', -45, 1 FROM DUAL UNION ALL
        SELECT 9, 'CONFERENCE', 'مؤتمر التحول الرقمي', 'دبي', 'AE', -30, 3 FROM DUAL UNION ALL
        SELECT 13, 'COURSE', 'دورة أمن الشبكات المتقدمة', 'لندن', 'GB', -70, 5 FROM DUAL UNION ALL
        SELECT 14, 'COURSE', 'دورة الحوسبة السحابية', 'مسقط', 'OM', 10, 5 FROM DUAL UNION ALL
        SELECT 15, 'CONFERENCE', 'معرض تقنيات البث', 'أمستردام', 'DE', 25, 4 FROM DUAL UNION ALL
        SELECT 19, 'WORKSHOP', 'ورشة التحرير الإخباري', 'القاهرة', 'EG', -15, 2 FROM DUAL UNION ALL
        SELECT 21, 'COURSE', 'دورة التصوير التلفزيوني', 'مسقط', 'OM', -90, 10 FROM DUAL UNION ALL
        SELECT 23, 'WORKSHOP', 'ورشة صحافة البيانات', 'عمّان', 'JO', 40, 3 FROM DUAL UNION ALL
        SELECT 25, 'CONFERENCE', 'منتدى الإعلان والتسويق', 'الرياض', 'SA', -5, 2 FROM DUAL UNION ALL
        SELECT 26, 'COURSE', 'دورة مهارات البيع', 'مسقط', 'OM', 60, 3 FROM DUAL UNION ALL
        SELECT 10, 'OTHER', 'زيارة ميدانية لمركز البيانات', 'صحار', 'OM', -10, 1 FROM DUAL)
    LOOP
        INSERT INTO MOINFO_EVT_EVENTS (EMPLOYEE_ID, EVENT_TYPE_ID, TITLE, PLACE, COUNTRY_ID, START_DATE, END_DATE,
                                       LETTER_NO, LETTER_DATE, COMMENTS)
        VALUES (emp(r.e), MOINFO_DEMO.LK('EVT_TYPE', r.t), r.ti, r.pl, MOINFO_DEMO.COUNTRY(r.c), MOINFO_DEMO.D(r.s), MOINFO_DEMO.D(r.s + r.n - 1),
                'DEMO/' || r.e || '/2026', MOINFO_DEMO.D(r.s - 14), 'مشاركة تجريبية')
        RETURNING EVENT_ID INTO l_id;
        dlog('MOINFO_EVT_EVENTS', l_id);
    END LOOP;

    ----------------------------------------------------------------------------
    -- MED: القنوات والبرامج والتغطيات
    ----------------------------------------------------------------------------
    INSERT INTO MOINFO_MED_CHANNELS (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('القناة العامة (تجريبي)', 'General Channel', 1) RETURNING CHANNEL_ID INTO l_id;
    dlog('MOINFO_MED_CHANNELS', l_id);
    INSERT INTO MOINFO_MED_PROGRAMS (CHANNEL_ID, NAME_AR, SORT_ORDER) VALUES (l_id, 'النشرة الرئيسية', 1) RETURNING PROGRAM_ID INTO l_id2;
    dlog('MOINFO_MED_PROGRAMS', l_id2);
    INSERT INTO MOINFO_MED_PROGRAMS (CHANNEL_ID, NAME_AR, SORT_ORDER) VALUES (l_id, 'تقارير من المحافظات', 2) RETURNING PROGRAM_ID INTO l_id2;
    dlog('MOINFO_MED_PROGRAMS', l_id2);
    INSERT INTO MOINFO_MED_CHANNELS (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('القناة الرياضية (تجريبي)', 'Sports Channel', 2) RETURNING CHANNEL_ID INTO l_id;
    dlog('MOINFO_MED_CHANNELS', l_id);
    INSERT INTO MOINFO_MED_PROGRAMS (CHANNEL_ID, NAME_AR, SORT_ORDER) VALUES (l_id, 'الملعب', 1) RETURNING PROGRAM_ID INTO l_id2;
    dlog('MOINFO_MED_PROGRAMS', l_id2);
    INSERT INTO MOINFO_MED_CHANNELS (NAME_AR, NAME_EN, SORT_ORDER) VALUES ('الإذاعة العامة (تجريبي)', 'General Radio', 3) RETURNING CHANNEL_ID INTO l_id;
    dlog('MOINFO_MED_CHANNELS', l_id);
    INSERT INTO MOINFO_MED_PROGRAMS (CHANNEL_ID, NAME_AR, SORT_ORDER) VALUES (l_id, 'صباح الوطن', 1) RETURNING PROGRAM_ID INTO l_id2;
    dlog('MOINFO_MED_PROGRAMS', l_id2);

    FOR r IN (
        SELECT -50 dd, 'العيد الوطني' ev, 'تغطية مباشرة' ty, 'مسقط' wi, 'ساحة الاحتفالات' pl, 'القناة العامة (تجريبي)' ch, 'النشرة الرئيسية' pr, '21:22' ph, '23' ed, '24' rp FROM DUAL UNION ALL
        SELECT -42, 'مهرجان خريف ظفار', 'تقرير مسجل', 'صلالة', 'منتزه المهرجان', 'القناة العامة (تجريبي)', 'تقارير من المحافظات', '22', '23', '24' FROM DUAL UNION ALL
        SELECT -35, 'فعالية رياضية', 'تغطية مباشرة', 'السيب', 'المجمع الرياضي', 'القناة الرياضية (تجريبي)', 'الملعب', '21', '24', '23' FROM DUAL UNION ALL
        SELECT -28, 'معرض', 'تقرير مسجل', 'بوشر', 'مركز المعارض', 'القناة العامة (تجريبي)', 'تقارير من المحافظات', '22', '23', '23' FROM DUAL UNION ALL
        SELECT -21, 'زيارة رسمية', 'لقاء', 'مسقط', 'مقر الوزارة', 'الإذاعة العامة (تجريبي)', 'صباح الوطن', NULL, '24', '23' FROM DUAL UNION ALL
        SELECT -14, 'فعالية رياضية', 'تقرير مسجل', 'صحار', 'الملعب الرياضي', 'القناة الرياضية (تجريبي)', 'الملعب', '21:22', '24', '24' FROM DUAL UNION ALL
        SELECT -7, 'معرض', 'تغطية مباشرة', 'نزوى', 'قلعة نزوى', 'القناة العامة (تجريبي)', 'النشرة الرئيسية', '21', '23', '24' FROM DUAL UNION ALL
        SELECT -3, 'زيارة رسمية', 'تقرير مسجل', 'صور', 'الميناء', 'القناة العامة (تجريبي)', 'تقارير من المحافظات', '22', '23', '23' FROM DUAL UNION ALL
        SELECT 0, 'معرض', 'لقاء', 'مطرح', 'سوق مطرح', 'الإذاعة العامة (تجريبي)', 'صباح الوطن', NULL, '24', '24' FROM DUAL UNION ALL
        SELECT 5, 'العيد الوطني', 'تغطية مباشرة', 'مسقط', 'ميدان الاحتفال', 'القناة العامة (تجريبي)', 'النشرة الرئيسية', '21:22', '23', '24' FROM DUAL)
    LOOP
        SELECT MIN(c.CHANNEL_ID), MIN(p.PROGRAM_ID) INTO l_id, l_id2
          FROM MOINFO_MED_CHANNELS c JOIN MOINFO_MED_PROGRAMS p ON p.CHANNEL_ID = c.CHANNEL_ID
         WHERE c.NAME_AR = r.ch AND p.NAME_AR = r.pr;
        INSERT INTO MOINFO_MED_COVERAGES (COVERAGE_DATE, EVENT_ID, EVENT_TYPE_ID, WILAYAT_ID, PLACE_NAME, CHANNEL_ID, PROGRAM_ID, REMARKS)
        VALUES (MOINFO_DEMO.D(r.dd), MOINFO_DEMO.LKN('MED_EVENT', r.ev), MOINFO_DEMO.LKN('MED_EVENT_TYPE', r.ty), MOINFO_DEMO.WILAYAT(r.wi), r.pl, l_id, l_id2, 'تغطية تجريبية')
        RETURNING COVERAGE_ID INTO l_id;
        dlog('MOINFO_MED_COVERAGES', l_id);
        IF r.ph IS NOT NULL THEN
            l_crew := CASE r.ph WHEN '21:22' THEN emp(21) || ':' || emp(22)
                                WHEN '21' THEN TO_CHAR(emp(21)) ELSE TO_CHAR(emp(22)) END;
            MOINFO_MED.SET_CREW(l_id, 'PHOTOGRAPHER', l_crew);
        END IF;
        MOINFO_MED.SET_CREW(l_id, 'EDITOR', TO_CHAR(emp(TO_NUMBER(r.ed))));
        MOINFO_MED.SET_CREW(l_id, 'REPORTER', TO_CHAR(emp(TO_NUMBER(r.rp))));
    END LOOP;

    ----------------------------------------------------------------------------
    -- TSK: المهام وملاحظاتها
    ----------------------------------------------------------------------------
    FOR r IN (
        SELECT 1 n, 'تعطل الطابعة في قسم الحسابات' ti, 'طلب دعم' ty, 'أجهزة' ca, 'DONE' st, 'NORMAL' pr, 11 asg, 8 req, -20 rd, -18 du FROM DUAL UNION ALL
        SELECT 2, 'إعداد بريد إلكتروني لموظف جديد', 'طلب دعم', 'بريد إلكتروني', 'DONE', 'NORMAL', 12, 3, -15, -14 FROM DUAL UNION ALL
        SELECT 3, 'تركيب شاشات غرفة الأخبار', 'تركيب', 'أجهزة', 'IN_PROGRESS', 'HIGH', 11, 19, -6, 2 FROM DUAL UNION ALL
        SELECT 4, 'بطء الشبكة في الطابق الثاني', 'صيانة', 'شبكات', 'IN_PROGRESS', 'URGENT', 13, 20, -2, 0 FROM DUAL UNION ALL
        SELECT 5, 'تحديث برنامج المونتاج', 'صيانة', 'برامج', 'NEW', 'NORMAL', 12, 22, -1, 6 FROM DUAL UNION ALL
        SELECT 6, 'مشروع نقل الخوادم إلى الموقع الجديد', 'مشروع', 'شبكات', 'IN_PROGRESS', 'HIGH', 14, 9, -40, 30 FROM DUAL UNION ALL
        SELECT 7, 'صلاحيات نظام الأرشيف لقسم الأخبار', 'طلب دعم', 'برامج', 'ON_HOLD', 'LOW', 13, 23, -12, -2 FROM DUAL UNION ALL
        SELECT 8, 'صيانة وحدة البث الخارجي', 'صيانة', 'أنظمة البث', 'NEW', 'HIGH', 17, 15, 0, 3 FROM DUAL UNION ALL
        SELECT 9, 'تجهيز قاعة الاجتماعات لعرض تقديمي', 'تركيب', 'أجهزة', 'DONE', 'NORMAL', 11, 25, -9, -8 FROM DUAL UNION ALL
        SELECT 10, 'استبدال حاسب قديم في قسم التدريب', 'طلب دعم', 'أجهزة', 'CANCELLED', 'LOW', 12, 4, -30, -25 FROM DUAL UNION ALL
        SELECT 11, 'مراسلة المورد بشأن الضمان', 'مراسلة', 'أجهزة', 'NEW', 'NORMAL', 10, NULL, -3, 4 FROM DUAL UNION ALL
        SELECT 12, 'تفعيل الشبكة اللاسلكية للضيوف', 'تركيب', 'شبكات', 'DONE', 'NORMAL', 13, 29, -25, -20 FROM DUAL UNION ALL
        SELECT 13, 'مشكلة في دخول نظام الموارد البشرية', 'طلب دعم', 'برامج', 'IN_PROGRESS', 'HIGH', 12, 2, -1, 1 FROM DUAL UNION ALL
        SELECT 14, 'نسخ احتياطي لأرشيف الفيديو', 'مشروع', 'أنظمة البث', 'NEW', 'NORMAL', 14, 16, -4, 20 FROM DUAL UNION ALL
        SELECT 15, 'تركيب كاميرات مراقبة المخزن', 'تركيب', 'أجهزة', 'NEW', 'LOW', 11, 16, 0, 14 FROM DUAL)
    LOOP
        v1 := CASE WHEN r.req IS NOT NULL THEN emp(r.req) END;
        INSERT INTO MOINFO_TSK_TASKS (REF_NO, TITLE, DESCRIPTION, TASK_TYPE_ID, TASK_CATEGORY_ID, STATUS_ID, PRIORITY,
                                      ASSIGNED_EMPLOYEE_ID, REQUESTER_EMPLOYEE_ID, REQUESTER_NAME, RECEIVED_DATE, DUE_DATE,
                                      ACTION_TAKEN)
        VALUES ('DEMO-' || LPAD(r.n, 3, '0'), r.ti, 'وصف تجريبي: ' || r.ti, MOINFO_DEMO.LKN('TSK_TYPE', r.ty), MOINFO_DEMO.LKN('TSK_CATEGORY', r.ca),
                MOINFO_TSK.GET_STATUS_ID('NEW'), r.pr, emp(r.asg),
                v1,
                CASE WHEN r.req IS NULL THEN 'شركة المستقبل للحاسبات (وهمي)' END,
                MOINFO_DEMO.D(r.rd), MOINFO_DEMO.D(r.du),
                CASE WHEN r.st = 'DONE' THEN 'تم الحل وإبلاغ صاحب الطلب' END)
        RETURNING TASK_ID INTO l_id;
        dlog('MOINFO_TSK_TASKS', l_id);
        INSERT INTO MOINFO_TSK_NOTES (TASK_ID, NOTE_TEXT) VALUES (l_id, 'استُلم الطلب وبدأ العمل عليه') RETURNING NOTE_ID INTO l_id2;
        dlog('MOINFO_TSK_NOTES', l_id2);
        IF r.st <> 'NEW' THEN
            INSERT INTO MOINFO_TSK_NOTES (TASK_ID, NOTE_TEXT, STATUS_ID)
            VALUES (l_id, CASE r.st WHEN 'DONE' THEN 'أُنجزت المهمة' WHEN 'CANCELLED' THEN 'أُلغيت بطلب من صاحبها'
                                    WHEN 'ON_HOLD' THEN 'بانتظار موافقة الدائرة' ELSE 'العمل جارٍ' END,
                    MOINFO_TSK.GET_STATUS_ID(r.st))
            RETURNING NOTE_ID INTO l_id2;
            dlog('MOINFO_TSK_NOTES', l_id2);
            UPDATE MOINFO_TSK_TASKS SET STATUS_ID = MOINFO_TSK.GET_STATUS_ID(r.st) WHERE TASK_ID = l_id;
        END IF;
    END LOOP;

    ----------------------------------------------------------------------------
    -- ATT: المستندات (بلا ملفات)
    ----------------------------------------------------------------------------
    FOR r IN (
        SELECT 'DUTY_ROSTER' c, 'جدول مناوبات الدعم الفني - الشهر الحالي' ti, 0 dd, 10 u FROM DUAL UNION ALL
        SELECT 'DUTY_ROSTER', 'جدول مناوبات غرفة الأخبار', -3, 15 FROM DUAL UNION ALL
        SELECT 'MINUTES', 'محضر اجتماع لجنة المشتريات', -12, 6 FROM DUAL UNION ALL
        SELECT 'MINUTES', 'محضر اجتماع تقنية المعلومات الأسبوعي', -5, 9 FROM DUAL UNION ALL
        SELECT 'TEMPLATES', 'نموذج طلب إجازة', -60, 2 FROM DUAL UNION ALL
        SELECT 'TEMPLATES', 'نموذج خطاب رسمي', -90, 1 FROM DUAL)
    LOOP
        INSERT INTO MOINFO_ATT_DOCUMENTS (CATEGORY_ID, TITLE, DOCUMENT_DATE, OWNER_UNIT_ID, REMARKS)
        VALUES (MOINFO_DEMO.LK('ATT_CATEGORY', r.c), r.ti, MOINFO_DEMO.D(r.dd), unit(r.u), 'مستند تجريبي بلا ملف')
        RETURNING DOCUMENT_ID INTO l_id;
        dlog('MOINFO_ATT_DOCUMENTS', l_id);
    END LOOP;

    ----------------------------------------------------------------------------
    -- الكتالوج: الموديلات والموردون
    ----------------------------------------------------------------------------
    l_id := add_model('Dell', 'OptiPlex 7010', 'Desktop');
    l_id := add_model('Dell', 'Latitude 5440', 'Laptop');
    l_id := add_model('Dell', 'P2422H', 'Monitor');
    l_id := add_model('HP', 'LaserJet Pro M404', 'Printer');
    l_id := add_model('Lenovo', 'ThinkPad E14', 'Laptop');
    l_id := add_model('Epson', 'EcoTank L3250', 'Printer');
    l_id := add_model('Cisco', 'Catalyst 9200', 'Network Device');
    l_id := add_model('Sony', 'PXW-Z190', 'Camera');
    l_id := add_model('Canon', 'EOS R6', 'Camera');
    l_id := add_model('Sennheiser', 'EW 112P G4', 'Microphone');
    l_id := add_model('Manfrotto', '504X', 'Tripod & Accessories');
    l_id := add_model('Aputure', 'LS 300X', 'Lighting');

    INSERT INTO MOINFO_CAT_SUPPLIERS (NAME_AR, NAME_EN, CONTACT_PERSON, PHONE, EMAIL)
    VALUES ('شركة المستقبل للحاسبات (وهمي)', 'Future Computers (Demo)', 'سامي بن علي', '24000101', 'sales@future.example.com')
    RETURNING SUPPLIER_ID INTO l_id;
    dlog('MOINFO_CAT_SUPPLIERS', l_id);
    INSERT INTO MOINFO_CAT_SUPPLIERS (NAME_AR, NAME_EN, CONTACT_PERSON, PHONE, EMAIL)
    VALUES ('مؤسسة الضوء للأنظمة (وهمي)', 'Light Systems (Demo)', 'راشد بن حمد', '24000102', 'info@light.example.com')
    RETURNING SUPPLIER_ID INTO l_id;
    dlog('MOINFO_CAT_SUPPLIERS', l_id);
    INSERT INTO MOINFO_CAT_SUPPLIERS (NAME_AR, NAME_EN, CONTACT_PERSON, PHONE, EMAIL)
    VALUES ('شركة الصوت والصورة (وهمي)', 'Sound & Vision (Demo)', 'هلال بن سعيد', '24000103', 'av@sv.example.com')
    RETURNING SUPPLIER_ID INTO l_id;
    dlog('MOINFO_CAT_SUPPLIERS', l_id);

    ----------------------------------------------------------------------------
    -- HD: أوامر الشراء، والأجهزة وتسليمها، وقطع الغيار، وطلبات الدعم
    ----------------------------------------------------------------------------
    INSERT INTO MOINFO_HD_PURCHASE_ORDERS (PO_NO, PO_NAME, PO_DATE, SUPPLIER_ID)
    VALUES ('PO-DEMO-001', 'توريد حواسيب مكتبية ومحمولة', ADD_MONTHS(TRUNC(SYSDATE), -34), MOINFO_DEMO.SUPPLIER('شركة المستقبل للحاسبات (وهمي)'))
    RETURNING PO_ID INTO l_id;
    dlog('MOINFO_HD_PURCHASE_ORDERS', l_id);
    INSERT INTO MOINFO_HD_PURCHASE_ORDERS (PO_NO, PO_NAME, PO_DATE, SUPPLIER_ID)
    VALUES ('PO-DEMO-002', 'توريد طابعات وشاشات', ADD_MONTHS(TRUNC(SYSDATE), -11), MOINFO_DEMO.SUPPLIER('مؤسسة الضوء للأنظمة (وهمي)'))
    RETURNING PO_ID INTO l_id;
    dlog('MOINFO_HD_PURCHASE_ORDERS', l_id);
    INSERT INTO MOINFO_HD_PURCHASE_ORDERS (PO_NO, PO_NAME, PO_DATE, SUPPLIER_ID)
    VALUES ('PO-DEMO-003', 'توريد أجهزة شبكة', ADD_MONTHS(TRUNC(SYSDATE), -3), MOINFO_DEMO.SUPPLIER('مؤسسة الضوء للأنظمة (وهمي)'))
    RETURNING PO_ID INTO l_id;
    dlog('MOINFO_HD_PURCHASE_ORDERS', l_id);

    FOR r IN (
        SELECT 1 n, 'OptiPlex 7010' m, 'PO-DEMO-001' po, 36 w, -35 ws, 3 holder FROM DUAL UNION ALL
        SELECT 2, 'OptiPlex 7010', 'PO-DEMO-001', 36, -35, 8 FROM DUAL UNION ALL
        SELECT 3, 'OptiPlex 7010', 'PO-DEMO-001', 36, -35, 23 FROM DUAL UNION ALL
        SELECT 4, 'Latitude 5440', 'PO-DEMO-001', 36, -34, 9 FROM DUAL UNION ALL
        SELECT 5, 'Latitude 5440', 'PO-DEMO-001', 36, -34, 19 FROM DUAL UNION ALL
        SELECT 6, 'ThinkPad E14', 'PO-DEMO-001', 24, -23, 25 FROM DUAL UNION ALL
        SELECT 7, 'ThinkPad E14', 'PO-DEMO-001', 24, -23, NULL FROM DUAL UNION ALL
        SELECT 8, 'P2422H', 'PO-DEMO-002', 36, -11, 3 FROM DUAL UNION ALL
        SELECT 9, 'P2422H', 'PO-DEMO-002', 36, -11, 23 FROM DUAL UNION ALL
        SELECT 10, 'P2422H', 'PO-DEMO-002', 36, -11, NULL FROM DUAL UNION ALL
        SELECT 11, 'LaserJet Pro M404', 'PO-DEMO-002', 12, -11, NULL FROM DUAL UNION ALL
        SELECT 12, 'EcoTank L3250', 'PO-DEMO-002', 12, -11, NULL FROM DUAL UNION ALL
        SELECT 13, 'Catalyst 9200', 'PO-DEMO-003', 60, -3, NULL FROM DUAL UNION ALL
        SELECT 14, 'Catalyst 9200', 'PO-DEMO-003', 60, -3, NULL FROM DUAL UNION ALL
        SELECT 15, 'Latitude 5440', 'PO-DEMO-001', 36, -34, 27 FROM DUAL UNION ALL
        SELECT 16, 'OptiPlex 7010', 'PO-DEMO-001', 36, -35, 2 FROM DUAL)
    LOOP
        SELECT MIN(PO_ID), MIN(SUPPLIER_ID) INTO l_id, l_id2 FROM MOINFO_HD_PURCHASE_ORDERS WHERE PO_NO = r.po;
        INSERT INTO MOINFO_HD_DEVICES (SERIAL_NO, SERVICE_TAG, DEVICE_NAME, MODEL_ID, SUPPLIER_ID, PO_ID, WARRANTY_TYPE_ID,
                                       WARRANTY_START)
        VALUES ('DEMO-SN-' || LPAD(r.n, 4, '0'), 'TAG' || LPAD(r.n * 7919, 6, '0'), 'جهاز ' || LPAD(r.n, 2, '0'),
                MOINFO_DEMO.MODEL_OF(r.m), l_id2, l_id, MOINFO_DEMO.WARRANTY(r.w), ADD_MONTHS(TRUNC(SYSDATE), r.ws))
        RETURNING DEVICE_ID INTO l_ret;
        dev(r.n) := l_ret;
        dlog('MOINFO_HD_DEVICES', dev(r.n));
        IF r.holder IS NOT NULL THEN
            MOINFO_HD.ASSIGN_DEVICE(dev(r.n), emp(r.holder), NULL, ADD_MONTHS(TRUNC(SYSDATE), r.ws) + 14, 'تسليم تجريبي');
        END IF;
    END LOOP;
    -- جهاز تنقّل بين موظفَين، وجهاز تحت الصيانة، وطابعة مسلّمة لقسم كامل
    MOINFO_HD.RETURN_DEVICE(dev(7), MOINFO_DEMO.D(-60), 'أُعيد بعد انتهاء المشروع');
    MOINFO_HD.ASSIGN_DEVICE(dev(7), emp(14), NULL, MOINFO_DEMO.D(-30), 'تسليم بعد الإرجاع');
    MOINFO_HD.ASSIGN_DEVICE(dev(11), NULL, unit(7), MOINFO_DEMO.D(-200), 'طابعة قسم الحسابات');
    UPDATE MOINFO_HD_DEVICES SET STATUS_ID = MOINFO_HD.LOOKUP_ID('HD_DEVICE_STATUS', 'REPAIR'), REMARKS = 'عطل في اللوحة الأم'
     WHERE DEVICE_ID = dev(12);

    INSERT INTO MOINFO_HD_SPARE_PARTS (DEVICE_ID, PART_NAME, PART_SN, SUPPLIER_ID, WARRANTY_TYPE_ID, WARRANTY_START, DELIVERY_DATE, IS_DELIVERED)
    VALUES (dev(1), 'ذاكرة 16GB', 'DEMO-RAM-01', MOINFO_DEMO.SUPPLIER('شركة المستقبل للحاسبات (وهمي)'), MOINFO_DEMO.WARRANTY(12), MOINFO_DEMO.D(-340), MOINFO_DEMO.D(-340), 'Y')
    RETURNING PART_ID INTO l_id;
    dlog('MOINFO_HD_SPARE_PARTS', l_id);
    INSERT INTO MOINFO_HD_SPARE_PARTS (DEVICE_ID, PART_NAME, PART_SN, SUPPLIER_ID, WARRANTY_TYPE_ID, WARRANTY_START, DELIVERY_DATE, IS_DELIVERED)
    VALUES (dev(4), 'قرص SSD سعة 1TB', 'DEMO-SSD-01', MOINFO_DEMO.SUPPLIER('شركة المستقبل للحاسبات (وهمي)'), MOINFO_DEMO.WARRANTY(36), MOINFO_DEMO.D(-90), MOINFO_DEMO.D(-90), 'Y')
    RETURNING PART_ID INTO l_id;
    dlog('MOINFO_HD_SPARE_PARTS', l_id);
    INSERT INTO MOINFO_HD_SPARE_PARTS (DEVICE_ID, PART_NAME, PART_SN, SUPPLIER_ID, WARRANTY_TYPE_ID, WARRANTY_START, IS_DELIVERED)
    VALUES (dev(12), 'لوحة أم بديلة', NULL, MOINFO_DEMO.SUPPLIER('مؤسسة الضوء للأنظمة (وهمي)'), MOINFO_DEMO.WARRANTY(12), NULL, 'N')
    RETURNING PART_ID INTO l_id;
    dlog('MOINFO_HD_SPARE_PARTS', l_id);

    FOR r IN (
        SELECT 23 rq, 3 dv, 'الحاسب لا يعمل بعد التحديث' ti, 'DONE' st, 11 asg, -10 dd FROM DUAL UNION ALL
        SELECT 8, 2, 'بطء شديد في الحاسب', 'IN_PROGRESS', 12, -3 FROM DUAL UNION ALL
        SELECT 19, 5, 'البطارية لا تشحن', 'NEW', NULL, -1 FROM DUAL UNION ALL
        SELECT 25, 6, 'طلب تثبيت برنامج التصميم', 'IN_PROGRESS', 11, -2 FROM DUAL UNION ALL
        SELECT 3, 8, 'الشاشة تومض', 'DONE', 12, -20 FROM DUAL UNION ALL
        SELECT 9, 4, 'مشكلة في الاتصال بالشبكة اللاسلكية', 'DONE', 11, -15 FROM DUAL UNION ALL
        SELECT 27, 15, 'لوحة المفاتيح لا تستجيب', 'NEW', NULL, 0 FROM DUAL UNION ALL
        SELECT 2, 16, 'طلب نقل الحاسب إلى مكتب آخر', 'CANCELLED', 12, -8 FROM DUAL UNION ALL
        SELECT 21, NULL, 'تعذّر الدخول إلى البريد', 'IN_PROGRESS', 12, -1 FROM DUAL UNION ALL
        SELECT 14, 7, 'تحديث نظام التشغيل', 'NEW', 11, 0 FROM DUAL)
    LOOP
        v1 := CASE WHEN r.dv IS NOT NULL THEN dev(r.dv) END;
        v2 := CASE WHEN r.asg IS NOT NULL THEN emp(r.asg) END;
        INSERT INTO MOINFO_HD_REQUESTS (REQUESTER_EMPLOYEE_ID, DEVICE_ID, TITLE, DESCRIPTION, ASSIGNED_EMPLOYEE_ID, REQUEST_DATE)
        VALUES (emp(r.rq), v1, r.ti, 'وصف تجريبي: ' || r.ti, v2, MOINFO_DEMO.D(r.dd))
        RETURNING REQUEST_ID INTO l_id;
        dlog('MOINFO_HD_REQUESTS', l_id);
        IF r.st <> 'NEW' THEN
            MOINFO_HD.ADD_NOTE(l_id, 'بدأ الفني بمعالجة الطلب', MOINFO_HD.LOOKUP_ID('HD_REQUEST_STATUS', 'IN_PROGRESS'));
        END IF;
        IF r.st IN ('DONE', 'CANCELLED') THEN
            MOINFO_HD.ADD_NOTE(l_id, CASE r.st WHEN 'DONE' THEN 'حُلّت المشكلة وتأكد صاحب الطلب' ELSE 'أُلغي بطلب صاحبه' END,
                               MOINFO_HD.LOOKUP_ID('HD_REQUEST_STATUS', r.st));
            IF r.st = 'DONE' THEN
                UPDATE MOINFO_HD_REQUESTS SET SOLUTION = 'تحديث التعريفات وإعادة الضبط' WHERE REQUEST_ID = l_id;
            END IF;
        END IF;
    END LOOP;

    ----------------------------------------------------------------------------
    -- PRC: طلبات الشراء بحالات مختلفة
    ----------------------------------------------------------------------------
    FOR r IN (
        SELECT 1 n, 23 e, 'مستلزمات غرفة الأخبار' s, 'DRAFT' st, NULL rs FROM DUAL UNION ALL
        SELECT 2, 21, 'معدات تصوير ميداني', 'SUBMITTED', NULL FROM DUAL UNION ALL
        SELECT 3, 13, 'أجهزة شبكة للطابق الثالث', 'APPROVED', 'ضمن ميزانية الربع الحالي' FROM DUAL UNION ALL
        SELECT 4, 26, 'هدايا ترويجية للعملاء', 'REJECTED', 'غير مدرج في الخطة السنوية' FROM DUAL UNION ALL
        SELECT 5, 11, 'حواسيب محمولة للدعم الفني', 'PURCHASED', 'موافق' FROM DUAL UNION ALL
        SELECT 6, 3, 'أثاث مكتبي لقسم شؤون الموظفين', 'DELIVERED', 'موافق' FROM DUAL)
    LOOP
        INSERT INTO MOINFO_PRC_REQUESTS (SUBJECT, REQUEST_DATE, REQUESTER_EMPLOYEE_ID, JUSTIFICATION)
        VALUES (r.s, MOINFO_DEMO.D(-40 + r.n * 5), emp(r.e), 'مبررات تجريبية: ' || r.s)
        RETURNING REQUEST_ID INTO l_id;
        dlog('MOINFO_PRC_REQUESTS', l_id);

        IF r.n IN (1, 4, 6) THEN
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, QUANTITY, UNIT_PRICE, SORT_ORDER)
            VALUES (l_id, CASE r.n WHEN 1 THEN 'دفاتر وأقلام' WHEN 4 THEN 'أقلام بشعار المؤسسة' ELSE 'مكاتب خشبية' END,
                    MOINFO_DEMO.PTYPE('Office Supplies'), CASE r.n WHEN 6 THEN 4 ELSE 50 END, CASE r.n WHEN 6 THEN 85 ELSE 1.5 END, 1)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, QUANTITY, UNIT_PRICE, SORT_ORDER)
            VALUES (l_id, CASE r.n WHEN 1 THEN 'سبورة بيضاء' WHEN 4 THEN 'حقائب قماشية' ELSE 'كراسٍ مكتبية' END,
                    MOINFO_DEMO.PTYPE('Office Supplies'), CASE r.n WHEN 6 THEN 8 ELSE 2 END, CASE r.n WHEN 6 THEN 35 ELSE 25 END, 2)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
        ELSIF r.n = 2 THEN
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, BRAND_ID, MODEL_ID, SUPPLIER_ID, QUANTITY, UNIT_PRICE, SORT_ORDER)
            VALUES (l_id, 'كاميرا تلفزيونية', MOINFO_DEMO.PTYPE('Camera'), MOINFO_DEMO.BRAND('Sony'), MOINFO_DEMO.MODEL_OF('PXW-Z190'),
                    MOINFO_DEMO.SUPPLIER('شركة الصوت والصورة (وهمي)'), 2, 2450, 1)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, BRAND_ID, MODEL_ID, QUANTITY, UNIT_PRICE, SORT_ORDER)
            VALUES (l_id, 'حامل كاميرا', MOINFO_DEMO.PTYPE('Tripod & Accessories'), MOINFO_DEMO.BRAND('Manfrotto'), MOINFO_DEMO.MODEL_OF('504X'), 2, 380, 2)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, BRAND_ID, MODEL_ID, QUANTITY, UNIT_PRICE, SORT_ORDER)
            VALUES (l_id, 'ميكروفون لاسلكي', MOINFO_DEMO.PTYPE('Microphone'), MOINFO_DEMO.BRAND('Sennheiser'), MOINFO_DEMO.MODEL_OF('EW 112P G4'), 4, 210, 3)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
        ELSIF r.n = 3 THEN
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, BRAND_ID, MODEL_ID, SUPPLIER_ID, QUANTITY, UNIT_PRICE, IS_APPROVED, SORT_ORDER)
            VALUES (l_id, 'مبدّل شبكة 48 منفذ', MOINFO_DEMO.PTYPE('Network Device'), MOINFO_DEMO.BRAND('Cisco'), MOINFO_DEMO.MODEL_OF('Catalyst 9200'),
                    MOINFO_DEMO.SUPPLIER('مؤسسة الضوء للأنظمة (وهمي)'), 2, 1850, 'Y', 1)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, QUANTITY, UNIT_PRICE, IS_APPROVED, REJECT_REASON, SORT_ORDER)
            VALUES (l_id, 'خزانة شبكة', MOINFO_DEMO.PTYPE('Network Device'), 1, 420, 'N', 'متوفرة في المخزن', 2)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
        ELSE
            INSERT INTO MOINFO_PRC_REQUEST_ITEMS (REQUEST_ID, ITEM_NAME, PRODUCT_TYPE_ID, BRAND_ID, MODEL_ID, SUPPLIER_ID, QUANTITY, UNIT_PRICE, IS_APPROVED, SORT_ORDER)
            VALUES (l_id, 'حاسب محمول', MOINFO_DEMO.PTYPE('Laptop'), MOINFO_DEMO.BRAND('Dell'), MOINFO_DEMO.MODEL_OF('Latitude 5440'),
                    MOINFO_DEMO.SUPPLIER('شركة المستقبل للحاسبات (وهمي)'), 3, 520, 'Y', 1)
            RETURNING ITEM_ID INTO l_id2;
            dlog('MOINFO_PRC_REQUEST_ITEMS', l_id2);
        END IF;

        IF r.st <> 'DRAFT' THEN
            UPDATE MOINFO_PRC_REQUESTS
               SET STATUS_ID       = MOINFO_PRC.STATUS_ID(r.st),
                   SUBMITTED_AT    = CAST(MOINFO_DEMO.D(-38 + r.n * 5) AS TIMESTAMP),
                   DECIDED_BY      = CASE WHEN r.st NOT IN ('SUBMITTED') THEN 'DEMO_HEAD' END,
                   DECIDED_AT      = CASE WHEN r.st NOT IN ('SUBMITTED') THEN CAST(MOINFO_DEMO.D(-36 + r.n * 5) AS TIMESTAMP) END,
                   DECISION_REASON = r.rs,
                   PO_ID           = CASE WHEN r.st IN ('PURCHASED', 'DELIVERED') THEN
                                         (SELECT MIN(PO_ID) FROM MOINFO_HD_PURCHASE_ORDERS WHERE PO_NO = 'PO-DEMO-002') END,
                   PURCHASED_DATE  = CASE WHEN r.st IN ('PURCHASED', 'DELIVERED') THEN MOINFO_DEMO.D(-30 + r.n * 5) END,
                   DELIVERED_DATE  = CASE WHEN r.st = 'DELIVERED' THEN MOINFO_DEMO.D(-28 + r.n * 5) END
             WHERE REQUEST_ID = l_id;
        END IF;
    END LOOP;

    ----------------------------------------------------------------------------
    -- STD: معدات الاستوديو وحركاتها
    ----------------------------------------------------------------------------
    FOR r IN (
        SELECT 1 n, 'كاميرا تلفزيونية' nm, 'Camera' ty, 'Sony' br, 'PXW-Z190' md, 'خزانة الكاميرات' bn, 4 q, 1 mn FROM DUAL UNION ALL
        SELECT 2, 'كاميرا تصوير فوتوغرافي', 'Camera', 'Canon', 'EOS R6', 'خزانة الكاميرات', 3, 1 FROM DUAL UNION ALL
        SELECT 3, 'حامل كاميرا', 'Tripod & Accessories', 'Manfrotto', '504X', 'رف A1', 6, 2 FROM DUAL UNION ALL
        SELECT 4, 'ميكروفون لاسلكي', 'Microphone', 'Sennheiser', 'EW 112P G4', 'رف A2', 8, 2 FROM DUAL UNION ALL
        SELECT 5, 'إضاءة LED', 'Lighting', 'Aputure', 'LS 300X', 'رف B1', 5, 1 FROM DUAL UNION ALL
        SELECT 6, 'بطارية كاميرا', 'Camera', NULL, NULL, 'خزانة الكاميرات', 20, 10 FROM DUAL UNION ALL
        SELECT 7, 'بطاقة ذاكرة 128GB', 'Camera', NULL, NULL, 'خزانة الكاميرات', 15, 20 FROM DUAL UNION ALL
        SELECT 8, 'كابل XLR بطول 10 م', 'Microphone', NULL, NULL, 'رف A2', 30, 10 FROM DUAL UNION ALL
        SELECT 9, 'سماعة رأس للمراقبة', 'Microphone', NULL, NULL, 'رف A2', 10, 3 FROM DUAL UNION ALL
        SELECT 10, 'حقيبة كاميرا', 'Tripod & Accessories', NULL, NULL, 'رف A1', 6, 2 FROM DUAL UNION ALL
        SELECT 11, 'عاكس ضوء', 'Lighting', NULL, NULL, 'رف B1', 4, 1 FROM DUAL UNION ALL
        SELECT 12, 'شاشة مراقبة ميدانية', 'Monitor', NULL, NULL, 'رف B1', 3, 1 FROM DUAL)
    LOOP
        INSERT INTO MOINFO_STD_ITEMS (ITEM_NAME, SERIAL_NO, PRODUCT_TYPE_ID, BRAND_ID, MODEL_ID, LOCATION_ID, BIN_ID,
                                      QTY_IN_STOCK, MIN_QTY, DESCRIPTION)
        VALUES (r.nm, CASE WHEN r.md IS NOT NULL THEN 'DEMO-STD-' || LPAD(r.n, 3, '0') END, MOINFO_DEMO.PTYPE(r.ty),
                CASE WHEN r.br IS NOT NULL THEN MOINFO_DEMO.BRAND(r.br) END, CASE WHEN r.md IS NOT NULL THEN MOINFO_DEMO.MODEL_OF(r.md) END,
                MOINFO_DEMO.LKN('STD_LOCATION', 'المخزن الرئيسي'), MOINFO_DEMO.LKN('STD_BIN', r.bn), r.q, r.mn, 'معدة تجريبية')
        RETURNING ITEM_ID INTO l_ret;
        sitm(r.n) := l_ret;
        dlog('MOINFO_STD_ITEMS', sitm(r.n));
    END LOOP;
    UPDATE MOINFO_STD_ITEMS SET STATUS_ID = MOINFO_DEMO.LK('STD_ITEM_STATUS', 'REPAIR') WHERE ITEM_ID = sitm(11);

    IF l_can_move THEN
        MOINFO_STD.ISSUE(sitm(1), 2, emp(21), NULL, emp(20), MOINFO_DEMO.D(2), SYSDATE - 1, 'تغطية العيد الوطني');
        MOINFO_STD.ISSUE(sitm(3), 2, emp(21), NULL, emp(20), MOINFO_DEMO.D(2), SYSDATE - 1, 'تغطية العيد الوطني');
        MOINFO_STD.ISSUE(sitm(4), 3, emp(22), NULL, emp(20), NULL, SYSDATE - 12, 'تغطية المعرض');
        MOINFO_STD.RETURN_ITEM(sitm(4), 2, emp(22), NULL, SYSDATE - 9, 'أُرجعت بعد التغطية');
        MOINFO_STD.ISSUE(sitm(2), 1, NULL, 'فريق الإنتاج الخارجي (وهمي)', emp(16), MOINFO_DEMO.D(-2), SYSDATE - 6, 'تصوير برنامج وثائقي');
        MOINFO_STD.ISSUE(sitm(6), 6, emp(22), NULL, NULL, NULL, SYSDATE - 3, NULL);
        MOINFO_STD.ISSUE(sitm(7), 4, emp(21), NULL, NULL, NULL, SYSDATE - 3, NULL);
        MOINFO_STD.RECEIVE(sitm(8), 20, SYSDATE - 20, 'توريد جديد');
        MOINFO_STD.ADJUST(sitm(9), 9, 'جرد شهري: سماعة تالفة', SYSDATE - 15);
    END IF;

    ----------------------------------------------------------------------------
    -- ADV: الحسابات وجهات الاتصال والفرص ومتابعتها
    ----------------------------------------------------------------------------
    INSERT INTO MOINFO_ADV_ACCOUNTS (ACCOUNT_TYPE, NAME, SECTOR_ID, PHONE, EMAIL)
    VALUES ('AGENCY', 'وكالة الأفق للإعلان (وهمي)', MOINFO_DEMO.LK('ADV_SECTOR', 'PRIVATE'), '24000201', 'info@ofoq.example.com')
    RETURNING ACCOUNT_ID INTO l_ret;
    acc(1) := l_ret;
    INSERT INTO MOINFO_ADV_ACCOUNTS (ACCOUNT_TYPE, NAME, SECTOR_ID, PHONE, EMAIL)
    VALUES ('AGENCY', 'وكالة المدار الإعلامية (وهمي)', MOINFO_DEMO.LK('ADV_SECTOR', 'PRIVATE'), '24000202', 'info@madar.example.com')
    RETURNING ACCOUNT_ID INTO l_ret;
    acc(2) := l_ret;
    FOR r IN (
        SELECT 3 n, 'شركة الواحة للتجارة (وهمي)' nm, 1 ag, 'PRIVATE' se, 'تجزئة' ind FROM DUAL UNION ALL
        SELECT 4, 'مجموعة النخيل القابضة (وهمي)', 1, 'PRIVATE', 'عقارات' FROM DUAL UNION ALL
        SELECT 5, 'شركة البحر الأزرق للاتصالات (وهمي)', 2, 'PRIVATE', 'اتصالات' FROM DUAL UNION ALL
        SELECT 6, 'مصرف الأمان (وهمي)', NULL, 'PRIVATE', 'بنوك وتأمين' FROM DUAL UNION ALL
        SELECT 7, 'وكالة الصحراء للسيارات (وهمي)', 2, 'PRIVATE', 'سيارات' FROM DUAL UNION ALL
        SELECT 8, 'منتجع الشاطئ الذهبي (وهمي)', NULL, 'SEMI', 'سياحة وضيافة' FROM DUAL)
    LOOP
        v1 := CASE WHEN r.ag IS NOT NULL THEN acc(r.ag) END;
        INSERT INTO MOINFO_ADV_ACCOUNTS (ACCOUNT_TYPE, NAME, AGENCY_ID, SECTOR_ID, INDUSTRY_ID, PHONE, EMAIL)
        VALUES ('COMPANY', r.nm, v1, MOINFO_DEMO.LK('ADV_SECTOR', r.se), MOINFO_DEMO.LKN('ADV_INDUSTRY', r.ind),
                '2400030' || r.n, 'marketing' || r.n || '@example.com')
        RETURNING ACCOUNT_ID INTO l_ret;
    acc(r.n) := l_ret;
    END LOOP;
    FOR i IN 1 .. 8 LOOP
        dlog('MOINFO_ADV_ACCOUNTS', acc(i));
    END LOOP;

    FOR r IN (
        SELECT 1 n, 1 a, 'خالد بن سعيد (وهمي)' nm, 'مدير الحسابات' jt, 'Y' pr FROM DUAL UNION ALL
        SELECT 2, 2, 'سارة بنت علي (وهمي)', 'مديرة التخطيط الإعلامي', 'Y' FROM DUAL UNION ALL
        SELECT 3, 3, 'ماجد بن حمد (وهمي)', 'مدير التسويق', 'Y' FROM DUAL UNION ALL
        SELECT 4, 4, 'ليلى بنت ناصر (وهمي)', 'مسؤولة العلامة التجارية', 'Y' FROM DUAL UNION ALL
        SELECT 5, 5, 'عمر بن سالم (وهمي)', 'رئيس الاتصال المؤسسي', 'Y' FROM DUAL UNION ALL
        SELECT 6, 5, 'هند بنت راشد (وهمي)', 'منسقة الحملات', 'N' FROM DUAL UNION ALL
        SELECT 7, 6, 'يحيى بن خلفان (وهمي)', 'مدير التسويق', 'Y' FROM DUAL UNION ALL
        SELECT 8, 7, 'جمال بن عبدالله (وهمي)', 'مدير المبيعات', 'Y' FROM DUAL UNION ALL
        SELECT 9, 8, 'رحمة بنت سيف (وهمي)', 'مديرة الحجوزات', 'Y' FROM DUAL)
    LOOP
        INSERT INTO MOINFO_ADV_CONTACTS (ACCOUNT_ID, NAME, JOB_TITLE, MOBILE, EMAIL, IS_PRIMARY)
        VALUES (acc(r.a), r.nm, r.jt, '9001' || LPAD(r.n, 4, '0'), 'contact' || r.n || '@example.com', r.pr)
        RETURNING CONTACT_ID INTO l_ret;
        cont(r.n) := l_ret;
        dlog('MOINFO_ADV_CONTACTS', cont(r.n));
    END LOOP;

    FOR r IN (
        SELECT 1 n, 'حملة الصيف التلفزيونية' ti, 3 adv, 3 ct, 'TV' md, 'PROPOSAL' st, 27 ow, -20 dd, 12000 am, 3 nx FROM DUAL UNION ALL
        SELECT 2, 'رعاية برنامج صباحي', 4, 4, 'RADIO', 'IN_PROGRESS', 27, -12, 6000, 0 FROM DUAL UNION ALL
        SELECT 3, 'إعلانات المنصات الرقمية', 5, 5, 'DIGITAL', 'WON', 28, -45, 18000, NULL FROM DUAL UNION ALL
        SELECT 4, 'إطلاق منتج مصرفي جديد', 6, 7, 'TV', 'NEW', 28, -2, 25000, 5 FROM DUAL UNION ALL
        SELECT 5, 'عرض السيارات الجديدة', 7, 8, 'TV', 'LOST', 26, -60, 9000, NULL FROM DUAL UNION ALL
        SELECT 6, 'ترويج موسم السياحة', 8, 9, 'DIGITAL', 'IN_PROGRESS', 27, -8, 7500, -2 FROM DUAL UNION ALL
        SELECT 7, 'رعاية النشرة الرياضية', 5, 6, 'TV', 'PROPOSAL', 28, -15, 14000, 1 FROM DUAL UNION ALL
        SELECT 8, 'حملة رمضان الإذاعية', 3, 1, 'RADIO', 'WON', 26, -90, 5500, NULL FROM DUAL UNION ALL
        SELECT 9, 'إعلانات اليوم الوطني', 4, NULL, 'TV', 'NEW', 27, 0, 11000, 7 FROM DUAL)
    LOOP
        v1 := CASE WHEN r.ct IS NOT NULL THEN cont(r.ct) END;
        INSERT INTO MOINFO_ADV_DEALS (TITLE, ADVERTISER_ID, CONTACT_ID, MEDIA_ID, OWNER_EMPLOYEE_ID, DEAL_DATE,
                                      EXPECTED_AMOUNT, SALES_HISTORY, OBJECTIONS, NOTES)
        VALUES (r.ti, acc(r.adv), v1, MOINFO_DEMO.LK('ADV_MEDIA', r.md), emp(r.ow), MOINFO_DEMO.D(r.dd),
                r.am, 'تعامل سابق في حملة العام الماضي', CASE WHEN r.st = 'LOST' THEN 'السعر أعلى من الميزانية' END, 'فرصة تجريبية')
        RETURNING DEAL_ID INTO l_id;
        dlog('MOINFO_ADV_DEALS', l_id);
        INSERT INTO MOINFO_ADV_ACTIVITIES (DEAL_ID, ACTIVITY_TYPE_ID, ACTIVITY_DATE, NOTE_TEXT)
        VALUES (l_id, MOINFO_DEMO.LK('ADV_ACTIVITY_TYPE', 'CALL'), MOINFO_DEMO.D(r.dd), 'اتصال أولي وعرض الباقات')
        RETURNING ACTIVITY_ID INTO l_id2;
        dlog('MOINFO_ADV_ACTIVITIES', l_id2);
        IF r.st <> 'NEW' THEN
            INSERT INTO MOINFO_ADV_ACTIVITIES (DEAL_ID, ACTIVITY_TYPE_ID, ACTIVITY_DATE, NOTE_TEXT, NEXT_FOLLOWUP_DATE, STATUS_ID)
            VALUES (l_id, MOINFO_DEMO.LK('ADV_ACTIVITY_TYPE', CASE WHEN r.st IN ('WON', 'LOST') THEN 'MEETING' ELSE 'VISIT' END),
                    LEAST(MOINFO_DEMO.D(r.dd + 5), TRUNC(SYSDATE)),
                    CASE r.st WHEN 'WON' THEN 'وُقّع العقد' WHEN 'LOST' THEN 'اعتذر العميل' ELSE 'زيارة وتقديم عرض سعر' END,
                    CASE WHEN r.nx IS NOT NULL THEN MOINFO_DEMO.D(r.nx) END, MOINFO_DEMO.LK('ADV_DEAL_STATUS', r.st))
            RETURNING ACTIVITY_ID INTO l_id2;
            dlog('MOINFO_ADV_ACTIVITIES', l_id2);
        END IF;
        UPDATE MOINFO_ADV_DEALS
           SET STATUS_ID = MOINFO_DEMO.LK('ADV_DEAL_STATUS', r.st),
               NEXT_FOLLOWUP_DATE = CASE WHEN r.nx IS NOT NULL THEN MOINFO_DEMO.D(r.nx) END
         WHERE DEAL_ID = l_id;
    END LOOP;

    ----------------------------------------------------------------------------
    -- OMI: أجهزة البصمة والأشخاص وتسجيلهم
    ----------------------------------------------------------------------------
    FOR r IN (
        SELECT 1 n, 'جهاز التسجيل الرئيسي' nm, 'REG' pt, 'MCT' st, 'Y' fx FROM DUAL UNION ALL
        SELECT 2, 'البوابة الرئيسية - دخول', 'GATE_IN', 'MCT', 'Y' FROM DUAL UNION ALL
        SELECT 3, 'البوابة الرئيسية - خروج', 'GATE_OUT', 'MCT', 'Y' FROM DUAL UNION ALL
        SELECT 4, 'جهاز صلالة المتنقل', 'REG', 'SLL', 'N' FROM DUAL)
    LOOP
        INSERT INTO MOINFO_OMI_TERMINALS (SERIAL_NO, NAME, MAC_ADDRESS, IP_ADDRESS, SITE_ID, REG_POINT_ID, IS_FIXED, IS_CONNECTED)
        VALUES ('DEMO-BIO-' || LPAD(r.n, 2, '0'), r.nm, '00:17:61:00:00:0' || r.n, '10.0.50.' || (10 + r.n),
                MOINFO_DEMO.LK('OMI_SITE', r.st), MOINFO_DEMO.LK('OMI_REG_POINT', r.pt), r.fx, CASE WHEN r.n = 4 THEN 'N' ELSE 'Y' END)
        RETURNING TERMINAL_ID INTO l_id;
        dlog('MOINFO_OMI_TERMINALS', l_id);
        dev(100 + r.n) := l_id;
    END LOOP;

    FOR i IN 1 .. 24 LOOP
        IF i <= 10 THEN
            INSERT INTO MOINFO_OMI_PERSONS (EMPLOYEE_ID, SITE_ID) VALUES (emp(i), MOINFO_DEMO.LK('OMI_SITE', 'MCT'))
            RETURNING PERSON_ID INTO l_id;
        ELSE
            INSERT INTO MOINFO_OMI_PERSONS (NAME_AR, NAME_EN, EMP_NO, WORK_ID, CIVIL_NO, SITE_ID)
            VALUES (CASE MOD(i, 7) WHEN 0 THEN 'عامر' WHEN 1 THEN 'سيف' WHEN 2 THEN 'هلال' WHEN 3 THEN 'جميلة'
                                   WHEN 4 THEN 'رقية' WHEN 5 THEN 'سليمان' ELSE 'نادية' END
                    || ' ' || CASE MOD(i, 5) WHEN 0 THEN 'بن مسلم' WHEN 1 THEN 'بن حمدان' WHEN 2 THEN 'بنت عوض'
                                             WHEN 3 THEN 'بن ربيع' ELSE 'بنت مرهون' END || ' (وهمي)',
                    'Demo Person ' || i, 'X' || LPAD(i, 4, '0'), 'W' || LPAD(i * 13, 5, '0'), '9' || LPAD(i * 1013, 7, '0'),
                    MOINFO_DEMO.LK('OMI_SITE', CASE WHEN i > 18 THEN 'SLL' ELSE 'MCT' END))
            RETURNING PERSON_ID INTO l_id;
        END IF;
        dlog('MOINFO_OMI_PERSONS', l_id);
        IF i <= 17 THEN
            v1 := dev(100 + CASE WHEN MOD(i, 4) = 0 THEN 2 ELSE 1 END);
            UPDATE MOINFO_OMI_PERSONS
               SET IS_REGISTERED = 'Y',
                   REGISTERED_AT = CASE WHEN i IN (3, 8, 12, 16) THEN TRUNC(SYSDATE) + (MOD(i, 3) + 1) / 96 ELSE SYSDATE - MOD(i, 9) - 1 END,
                   TERMINAL_ID   = v1,
                   REG_POINT_ID  = MOINFO_DEMO.LK('OMI_REG_POINT', CASE WHEN MOD(i, 4) = 0 THEN 'GATE_IN' ELSE 'REG' END)
             WHERE PERSON_ID = l_id;
            IF i <= 11 THEN
                UPDATE MOINFO_OMI_PERSONS SET IS_UPLOADED = 'Y' WHERE PERSON_ID = l_id;
            END IF;
        END IF;
    END LOOP;

    ----------------------------------------------------------------------------
    -- NWS: شجرة الجهات وجهات الاتصال
    ----------------------------------------------------------------------------
    FOR r IN (
        SELECT 1 n, NULL p, 'وزارة الخارجية' nm, 'MINISTRY' ty, 'GOV' ca, 'OM' co, NULL gv, NULL wl FROM DUAL UNION ALL
        SELECT 2, 1, 'دائرة المراسم', 'DEPARTMENT', 'GOV', 'OM', NULL, NULL FROM DUAL UNION ALL
        SELECT 3, 2, 'سفارة جمهورية مصر العربية', 'EMBASSY_IN', 'DIPLO', 'EG', NULL, NULL FROM DUAL UNION ALL
        SELECT 4, 2, 'سفارة المملكة المتحدة', 'EMBASSY_IN', 'DIPLO', 'GB', NULL, NULL FROM DUAL UNION ALL
        SELECT 5, 2, 'سفارة جمهورية الهند', 'EMBASSY_IN', 'DIPLO', 'IN', NULL, NULL FROM DUAL UNION ALL
        SELECT 6, 1, 'سفارة سلطنة عُمان في القاهرة', 'EMBASSY_OMAN', 'DIPLO', 'EG', NULL, NULL FROM DUAL UNION ALL
        SELECT 7, 1, 'سفارة سلطنة عُمان في لندن', 'EMBASSY_OMAN', 'DIPLO', 'GB', NULL, NULL FROM DUAL UNION ALL
        SELECT 8, NULL, 'وزارة الداخلية', 'MINISTRY', 'GOV', 'OM', NULL, NULL FROM DUAL UNION ALL
        SELECT 9, 8, 'مكتب محافظ ظفار', 'OFFICE', 'GOV', NULL, 'ظفار', NULL FROM DUAL UNION ALL
        SELECT 10, 9, 'مكتب والي صلالة', 'OFFICE', 'GOV', NULL, NULL, 'صلالة' FROM DUAL UNION ALL
        SELECT 11, 8, 'مكتب محافظ مسقط', 'OFFICE', 'GOV', NULL, 'مسقط', NULL FROM DUAL UNION ALL
        SELECT 12, 11, 'مكتب والي السيب', 'OFFICE', 'GOV', NULL, NULL, 'السيب' FROM DUAL UNION ALL
        SELECT 13, NULL, 'وكالة الأنباء التجريبية', 'MEDIA', 'GOV', 'OM', NULL, NULL FROM DUAL UNION ALL
        SELECT 14, NULL, 'صحيفة الخبر اليومي (وهمي)', 'MEDIA', 'PRIVATE', 'OM', NULL, NULL FROM DUAL UNION ALL
        SELECT 15, NULL, 'المنظمة العربية للإعلام (وهمي)', 'ORG', 'INTL', 'EG', NULL, NULL FROM DUAL)
    LOOP
        v1 := CASE WHEN r.p IS NOT NULL THEN ent(r.p) END;
        INSERT INTO MOINFO_NWS_ENTITIES (PARENT_ID, NAME_AR, ENTITY_TYPE_ID, CATEGORY_ID, COUNTRY_ID, GOVERNORATE_ID, WILAYAT_ID,
                                         PHONE, EMAIL, SORT_ORDER)
        VALUES (v1, r.nm, MOINFO_DEMO.LK('NWS_ENTITY_TYPE', r.ty), MOINFO_DEMO.LK('NWS_CATEGORY', r.ca),
                CASE WHEN r.co IS NOT NULL THEN MOINFO_DEMO.COUNTRY(r.co) END,
                CASE WHEN r.gv IS NOT NULL THEN MOINFO_DEMO.GOVERNORATE(r.gv) END,
                CASE WHEN r.wl IS NOT NULL THEN MOINFO_DEMO.WILAYAT(r.wl) END,
                '2400040' || LPAD(r.n, 2, '0'), 'entity' || r.n || '@example.com', r.n)
        RETURNING ENTITY_ID INTO l_ret;
        ent(r.n) := l_ret;
        dlog('MOINFO_NWS_ENTITIES', ent(r.n));
    END LOOP;

    FOR r IN (
        SELECT 1 n, 2 e, NULL c, 'منصور بن علي (وهمي)' nm, 'مدير دائرة المراسم' ds FROM DUAL UNION ALL
        SELECT 2, 3, NULL, 'أحمد عبدالحميد (وهمي)', 'المستشار الإعلامي' FROM DUAL UNION ALL
        SELECT 3, 4, NULL, 'John Smith (Demo)', 'Press Attaché' FROM DUAL UNION ALL
        SELECT 4, 5, NULL, 'Ravi Kumar (Demo)', 'Second Secretary' FROM DUAL UNION ALL
        SELECT 5, 6, NULL, 'سعود بن ناصر (وهمي)', 'الملحق الإعلامي' FROM DUAL UNION ALL
        SELECT 6, 7, NULL, 'عبدالله بن مسعود (وهمي)', 'السكرتير الأول' FROM DUAL UNION ALL
        SELECT 7, 9, NULL, 'حمدان بن سالم (وهمي)', 'مدير مكتب المحافظ' FROM DUAL UNION ALL
        SELECT 8, 10, NULL, 'مسلم بن عوض (وهمي)', 'مسؤول الإعلام' FROM DUAL UNION ALL
        SELECT 9, 11, NULL, 'سالم بن حمد (وهمي)', 'مدير مكتب المحافظ' FROM DUAL UNION ALL
        SELECT 10, 12, NULL, 'خليفة بن سعيد (وهمي)', 'مسؤول العلاقات العامة' FROM DUAL UNION ALL
        SELECT 11, 13, NULL, 'نوال بنت خميس (وهمي)', 'رئيسة التحرير' FROM DUAL UNION ALL
        SELECT 12, 14, NULL, 'طارق بن يوسف (وهمي)', 'مدير الأخبار' FROM DUAL UNION ALL
        SELECT 13, 15, NULL, 'منى عادل (وهمي)', 'منسقة البرامج' FROM DUAL UNION ALL
        SELECT 14, NULL, 'JO', 'رامي الخطيب (وهمي)', 'مراسل' FROM DUAL UNION ALL
        SELECT 15, NULL, 'TN', 'سلمى بن عمر (وهمي)', 'مراسلة' FROM DUAL)
    LOOP
        v1 := CASE WHEN r.e IS NOT NULL THEN ent(r.e) END;
        INSERT INTO MOINFO_NWS_CONTACTS (ENTITY_ID, COUNTRY_ID, NAME, DESIGNATION, MOBILE1, TEL, EMAIL)
        VALUES (v1, CASE WHEN r.c IS NOT NULL THEN MOINFO_DEMO.COUNTRY(r.c) END,
                r.nm, r.ds, '9002' || LPAD(r.n, 4, '0'), '2400050' || LPAD(r.n, 2, '0'), 'person' || r.n || '@example.com')
        RETURNING CONTACT_ID INTO l_id;
        dlog('MOINFO_NWS_CONTACTS', l_id);
    END LOOP;

    ----------------------------------------------------------------------------
    -- مستخدمو التجربة (إن وُضعت كلمة مرور)
    ----------------------------------------------------------------------------
    IF MOINFO_AUTH.VALIDATE_PASSWORD_RULES(c_password) IS NULL THEN
        add_user('DEMO_HR', 'سالم الحارثي (تجربة)', 1, 'HR');
        grant_mod('HR', 'MANAGER', 'ALL');
        grant_mod('EVT', 'MANAGER', 'ALL');
        grant_mod('ATT', 'USER', 'UNIT');

        add_user('DEMO_IT', 'سعيد السيابي (تجربة)', 10, 'HD');
        grant_mod('HD', 'MANAGER', 'ALL');
        grant_mod('TSK', 'MANAGER', 'ALL');
        grant_mod('OMI', 'MANAGER', 'ALL');
        grant_mod('ATT', 'USER', 'UNIT');

        add_user('DEMO_EMP', 'أسماء الحوسنية (تجربة)', 23, 'HD');
        grant_mod('HD', 'USER', 'OWN');
        grant_mod('PRC', 'USER', 'OWN');
        grant_mod('TSK', 'USER', 'OWN');
        grant_mod('EVT', 'USER', 'OWN');
        grant_mod('NWS', 'VIEWER', 'ALL');

        add_user('DEMO_HEAD', 'عبدالعزيز الرحبي (تجربة)', 19, 'PRC');
        grant_mod('PRC', 'MANAGER', 'UNIT', 15);
        grant_mod('MED', 'MANAGER', 'ALL');
        grant_mod('EVT', 'MANAGER', 'UNIT', 15);
        grant_mod('NWS', 'MANAGER', 'ALL');

        add_user('DEMO_PURCH', 'ناصر المعمري (تجربة)', 7, 'PRC');
        grant_mod('PRC', 'ADMIN', 'ALL');

        add_user('DEMO_STORE', 'هيثم الزدجالي (تجربة)', 16, 'STD');
        grant_mod('STD', 'MANAGER', 'ALL');

        add_user('DEMO_SALES', 'لمياء الشامسية (تجربة)', 27, 'ADV');
        grant_mod('ADV', 'USER', 'OWN');
    END IF;

    IF l_temp_admin THEN
        DELETE FROM MOINFO_USERS WHERE USERNAME = l_me;
    END IF;

    COMMIT;

    SELECT COUNT(*) INTO l_n FROM MOINFO_DEMO_LOG;
    DBMS_OUTPUT.PUT_LINE('أُضيفت البيانات التجريبية: ' || l_n || ' سطرًا مسجلًا');
    IF NOT l_can_move THEN
        DBMS_OUTPUT.PUT_LINE('تنبيه: لم تُسجَّل حركات المخزن لأن اسم المستخدم الحالي غير متاح في هذه الجلسة');
    END IF;
    IF MOINFO_AUTH.VALIDATE_PASSWORD_RULES(c_password) IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('لم يُنشأ مستخدمو التجربة: كلمة المرور غير محددة أو لا تحقق الشروط');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

SELECT TABLE_NAME, COUNT(*) AS ROWS_ADDED
  FROM MOINFO_DEMO_LOG
 GROUP BY TABLE_NAME
 ORDER BY TABLE_NAME;
