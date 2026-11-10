# جرد أنظمة APEX — مرحلة التحليل الأولى

تاريخ التحليل: 8 نوفمبر 2026. المصدر: 14 ملف تصدير تطبيقات مع Supporting Objects.

## ملخص

- 13 نظامًا فعليًا. ملفا ServiceDesk متطابقان في المحتوى (Supporting Objects والصفحات)، والفرق إصدار APEX فقط (26.1.3 و26.2.1). اعتمدنا الأحدث.
- 12 نظامًا على APEX 20.1، صُدّرت في أبريل 2025، كلها في Schema واحد هو `ABDULLAH` وتميّزها البادئات.
- ServiceDesk على APEX 26.2.1 في Workspace مختلف (`WKSP_ABDULLAHALFURQANI2024`)، ويبدو أنه على apex.oracle.com.
- الإجمالي: 391 صفحة، 171 جدولًا، 16 View، 177 Trigger، 96 كائن PL/SQL.

| التطبيق | الاسم | البادئة | الصفحات | الجداول |
|---|---|---|---|---|
| f100 | HrSystem | PRT_HR_ | 45 | 7 |
| f200 | Core Tasks | TASKS_ | 12 | 5 |
| f300 | Attachments | ATTACH_ | 10 | 4 |
| f400 | Commercial Department System | PRT_ADV_ | 28 | 13 |
| f500 | StudioStore | PRT_STD_ | 49 | 10 |
| f600 | Engineering Training Committee Events | ENGTR_ | 20 | 17 |
| f700 | Events | PRT_EVENT_ | 16 | 7 |
| f800 | Help Desk | PRT_HD_ | 52 | 18 |
| f900 | Purchases | PRT_PRCH_ | 42 | 13 |
| f1000 | OmanInfo | MOI_ | 17 | 11 |
| f1100 | Al-Rustaq Events | PRT_RSQ_ | 23 | 10 |
| f1200 | News | NEWS_ | 46 | 20 |
| f194952 | ServiceDesk | MOINFO_ | 31 | 36 |

## مجموعات التداخل

1. **المستخدمون والدخول**: كل نظام له جدول مستخدمين، وسجل دخول، ودالة مصادقة، وتغيير كلمة مرور، وجدول صلاحيات خاص به (13 نسخة).
2. **الهيكل التنظيمي (قطاع ← دائرة ← قسم)**: موجود في HR وPurchases وEngineering Training وHelp Desk (بنسخة _IT)، وEvents (أقسام فقط). ServiceDesk عمّمه في `MOINFO_UNITS` + `MOINFO_LEVELS` بهيكل شجري.
3. **الموظفون**: HR (السجل الكامل، 71 عمودًا)، وPurchases وEvents وEngineering Training وAl-Rustaq وOmanInfo. سكربت Purchases ينسخ القطاعات والدوائر والأقسام والموظفين من جداول HR، أي أن البيانات الأساسية تُكرَّر بالنسخ حاليًا.
4. **الأصناف والأصول**: Help Desk (منتجات، ماركات، موديلات، موردون، أجهزة، ضمانات، أوامر شراء)، وPurchases (ماركات، موديلات، موردون، أصناف)، وStudioStore (ماركات، أنواع أصول، مواقع). Purchases ينسخ الماركات والمنتجات والموردين من Help Desk.
5. **الفعاليات**: Events وEngineering Training وAl-Rustaq Events، وصفحات الفعاليات 3033–3036 داخل HR تقرأ جداول `PRT_EVENT_*`.
6. **المهام**: Core Tasks (`TASKS_`) وServiceDesk (`MOINFO_TSK_`).
7. **المرفقات**: Attachments و`PRT_PRCH_ATTACHMENTS`.
8. **وحدات مستقلة بلا تداخل يُذكر**: News (دليل جهات واتصالات)، Commercial (إعلانات ووكالات)، OmanInfo (تسجيل الموظفين والأجهزة).
9. **Help Desk موجود مرتين**: `PRT_HD_*` في f800، و`MOINFO_HD_*` في ServiceDesk (سكربت create-hd بحالة NEVER، ولا توجد صفحات HD بعد).

## ملاحظات فنية

### كلمات المرور
- MD5 عبر `DBMS_OBFUSCATION_TOOLKIT`: HR وStudioStore وEvents وHelp Desk وPurchases وOmanInfo وAl-Rustaq. هذه الحزمة متوقفة الدعم في الإصدارات الحديثة من Oracle.
- نص صريح بلا تشفير: Core Tasks وAttachments وCommercial وEngineering Training وNews.
- ServiceDesk: `DBMS_UTILITY.GET_HASH_VALUE`، وهي دالة غير تشفيرية (30 بت) ولا تصلح لكلمات المرور.
- النتيجة: لا يمكن نقل كلمات المرور كما هي إلى نظام موحد. الحل: دالة تجزئة واحدة قوية (مثلًا `STANDARD_HASH` بـ SHA-256 مع Salt عشوائي لكل مستخدم). كلمات المرور الصريحة تُجزّأ أثناء الترحيل. أما MD5 فتُتحقق بالطريقة القديمة عند أول دخول ثم يُعاد تخزينها بالطريقة الجديدة، أو يُفرض تغييرها.

### البنية
- أسماء الأعمدة غير موحدة: `CREATED_ON` و`CREATEDON`، و`IS_ACTIVE` و`ISACTIVE`، و`DEPT_CODE` و`DEPARTMENT_CODE` و`DEPTCODE`، مع خليط من NVARCHAR2 وVARCHAR2.
- المفاتيح: Sequence + Trigger لكل جدول (177 Trigger).
- ثلاثة أساليب تدقيق: جداول `_HIST` بالـ Triggers في Engineering Training، و`_AUDIT` في OmanInfo وStudioStore، ومولّد عام في ServiceDesk (`MOINFO_CREATE_AUDIT_TABLES/TRIGGERS`). الأخير هو الأنسب للتعميم.
- الحذف الناعم: أعمدة `IS_DELETED` و`ACTION_DELETE/RESTORE` في أنظمة PRT_.
- تكرار داخل النظام نفسه: f400 فيه `PRT_ADV_ADVERTISEMENT` و`PRT_ADV_ADVERTISEMENTS`، و`PRT_ADV_CONTACT` و`PRT_ADV_CONTACTS`، وكلاهما مستخدم في الصفحات.
- Views قديمة بتواريخ 2015 في HR (`PRT_HR_VIEW_ALL_EMPS_05NOV2015` وغيرها)، يُرجّح أنها قابلة للحذف.
- HR يحتوي على بيانات حساسة (الراتب، الجواز، البطاقة المدنية، الحساب البنكي)، وتحتاج في النظام الموحد صلاحيات مستقلة.

### الواجهات
- ترقيم صفحات متعارض: معظم الأنظمة تستخدم 1 و101. HR وCommercial استخدما ترقيمًا وحدويًا (1000، 2001–2003، 30xx)، وهذا نمط جيد للتعميم.
- كل نظام له Authentication Scheme مخصص (NATIVE_CUSTOM)، وبعضها فيه مخططات تجريبية زائدة (Core Tasks فيه 6).

## كائنات مستخدمة في الصفحات وغير موجودة في Supporting Objects

| التطبيق | الكائن | أين يُستخدم |
|---|---|---|
| f900 | `PRT_PRCH_PURCHASE_ORDERS` | الصفحتان 8 و9 |
| f400 | `PRT_ADV_CATEGORIES` | LOV adv_industries |
| f400 | `PRT_ADV_ORGANIZATION` | LOV adv_companies |
| f400 | `PRT_USERS`، `PRT_LOGINHISTORY` | الصفحتان 1000 و2003 (يُرجّح أنها بقايا قديمة) |
| f100 | `PRT_LOGINHISTORY` | الصفحة 2003 |
| f800 | `PRT_HD_CATEGORIES` | LOV categories_dynamic (تعريفه معلّق بتعليق في السكربت) |
| ServiceDesk | `MOINFO_STATUS`، `MOINFO_TASK_TYPES`، `MOINFO_TASK_CATEGORIES` | LOVs (أسماء قديمة غالبًا، والحالية `MOINFO_TSK_*`) |
| ServiceDesk | `MOI_UNITS` | الصفحة 22 |
| ServiceDesk | `MOINFO_COUNTRIES`، `MOINFO_CONTINENTS` | فيها بيانات في السكربت، دون CREATE TABLE |

جداول `MOINFO_*_AUDIT` تُنشأ ديناميكيًا بالمولّد، وليست ناقصة.

## مقارنة ServiceDesk بالقاعدة الفعلية (9 نوفمبر 2026)

المصدر: نتيجة `user_tab_columns` من Workspace الخاص بـ ServiceDesk. القاعدة `ABDULLAH` (الأنظمة الـ 12) لم تُقارن بعد.

- الأنواع والأطوال متطابقة مع السكربت. طول NVARCHAR2 في `user_tab_columns` بالبايت (ضعف عدد الحروف).
- غير موجودة في القاعدة رغم وجودها في السكربت: كل جداول `MOINFO_HD_*` (12 جدولًا)، و`PRT_HD_CATEGORIES/REMARKS/REQUESTS/SPARE_PARTS`، و`TMP_*`، و`MOINFO_EXCLUDECOPY`، و`MOI_TCOUNTTABLESRECORDS`. الخلاصة: وحدة Help Desk لم تُنشأ في ServiceDesk.
- تأكد غياب `MOI_UNITS` و`MOINFO_STATUS` و`MOINFO_TASK_TYPES` و`MOINFO_TASK_CATEGORIES` و`MOINFO_COUNTRIES/CONTINENTS`، فالصفحة 22 وقوائم الاختيار المعتمدة عليها معطلة أو بقايا قديمة.
- أعمدة في القاعدة وليست في السكربت: `MOINFO_USERS.USERNAME_OLD` و`EMPLOYEE_NO`، و`MOINFO_TSK_TASKS.USERNAME_OLD` و`COPY`، و`MOINFO_UNITS.COPY`. يظهر أن USERNAME أُعيدت تسميته إلى USERNAME_OLD ثم أُضيف عمود USERNAME جديد. القيد UNIQUE والـ FK بين المهام والمستخدمين ينتقلان مع إعادة التسمية، فيُرجّح أنهما الآن على USERNAME_OLD. يحتاج تحققًا.
- `MOINFO_USERS_AUDIT` لا يحتوي على الأعمدة الجديدة، أي أن جداول التدقيق لا تتحدث تلقائيًا مع الجدول الأصلي.
- جداول في القاعدة غير موجودة في أي تصدير: `MOINFO_EMPLOYEES` و`EMP_TMP` وجداول أخطاء `ERR$`، ومجموعة `ST_*` (ST_PROFILES، ST_TASKS، ST_TASK_AUDIT، ST_TASK_STATUSES، ST_TASK_TYPES، ST_CORRESPONDENCE_TYPES، ST_APP_SETTINGS، ST_LOGIN_FAILURES، ST_ACTING، ST_V_TASKS).
- مجموعة ST_ هي الأحدث تصميمًا: كلمة مرور بـ Hash وSalt، وتدقيق بصيغة JSON (OLD_DATA/NEW_DATA)، وحذف ناعم (DELETED_AT/BY)، وطوابع زمنية بالمنطقة الزمنية، وتسجيل محاولات الدخول الفاشلة، وجدول إعدادات.

## مقارنة Schema ABDULLAH بالسكربتات (9 نوفمبر 2026)

المصدر: ملف DDL مصدّر (126 جدولًا، 124 Sequence، بلا Triggers وViews وحزم PL/SQL). عدد السجلات صفر في كل الجداول.

- القاعدة تطابق السكربتات التي تعمل عند التثبيت (غير NEVER) تطابقًا تامًا في الجداول والأعمدة والأنواع. يبدو أنها تثبيت جديد من الـ Supporting Objects.
- غير مثبت: Help Desk (f800) بالكامل (18 جدولًا)، و`MOI_TERMINALS` و`MOI_FIXED_TERMINALS` وجداول تدقيقها (سكربتها NEVER)، و`PRT_PRCH_ATTACHMENTS` (NEVER).
- الجداول التي تستخدمها الصفحات وليست في السكربتات غير موجودة في القاعدة أيضًا (`PRT_PRCH_PURCHASE_ORDERS`، `PRT_ADV_CATEGORIES`، `PRT_ADV_ORGANIZATION`، `PRT_USERS`، `PRT_LOGINHISTORY`)، فصفحاتها معطلة.
- نواة `MOINFO` موجودة هنا أيضًا، لكن جداول `ST_*` و`MOINFO_EMPLOYEES` موجودة فقط في Schema الخاص بـ ServiceDesk.

## قرارات عبدالله (9 نوفمبر 2026)

- إصدار APEX المستهدف: 26.2.1.
- تفعيل كل الأنظمة في النظام الموحد.
- ليس كل المستخدمين يستخدمون كل الأنظمة، فيلزم ربط صلاحيات كل مستخدم بالوحدات.
- ملف f600 هو Engineering Training Committee Events، وكان الخطأ في تسمية الملف فقط.
- عدد السجلات صفر.
- توجد بيانات حقيقية قديمة في مكان آخر، لكن العمل يبدأ بقاعدة فارغة دون ترحيل حاليًا.
- جداول `ST_*` لنظام تجريبي، وتبقى خارج الدمج.
- f600 وf700 (ومعهما صفحات الفعاليات في HR) تُدمج في وحدة واحدة لمشاركات الموظفين (EVT).
- f1100 (Al-Rustaq) نظام مختلف لتسجيل التغطيات الإعلامية، ويبقى وحدة مستقلة (MED).

## التصميم المعتمد للنواة (السكربت 01)

- Schema جديد ومنفصل للنظام الموحد، وتطبيق APEX واحد.
- البادئة `MOINFO_` للنواة، و`MOINFO_<رمز الوحدة>_` لجداول الوحدات.
- رموز الوحدات ونطاقات صفحاتها: CORE 1–999، HR 1000، EVT 2000، MED 3000، TSK 4000، ATT 5000، HD 6000، PRC 7000، STD 8000، ADV 9000، OMI 10000، NWS 11000.
- جداول النواة: SETTINGS، MODULES، LEVELS، UNITS (شجري)، TITLES، COUNTRIES، GOVERNORATES، WILAYATS، EMPLOYEES (البيانات الأساسية فقط)، ROLES (عامة أو خاصة بوحدة، مع ROLE_RANK)، USERS، USER_CREDENTIALS، USER_MODULES (دور ونطاق بيانات ALL/UNIT/OWN لكل وحدة)، LOGIN_HISTORY، AUDIT_LOG (JSON)، ATTACHMENTS (عامة).
- الحزم: MOINFO_UTIL (الإعدادات، سجل التدقيق، مولّد Trigger واحد لكل جدول)، MOINFO_AUTH (SHA-256 مع Salt و1000 تكرار، وقفل الحساب بعد محاولات فاشلة)، MOINFO_SEC (HAS_MODULE وHAS_ROLE وCAN_SEE_UNIT).

## السكربتان 02 و03 (9 نوفمبر 2026)

- 02: جدولا `MOINFO_LOOKUP_TYPES` و`MOINFO_LOOKUPS` للقوائم البسيطة، والإعداد `AUDIT_EXCLUDE_TABLES`، وحزمة `MOINFO_ADMIN` (CREATE_USER، GRANT_MODULE، REVOKE_MODULE، RESET_PASSWORD، UNLOCK_USER).
- 03 (HR): `MOINFO_HR_EMPLOYEE_DETAILS` للبيانات الشخصية والحساسة، و`MOINFO_HR_DIRECTORY` لدليل الهواتف، و`MOINFO_HR_ATTENDANCE_LOG` لسجل بصمة ZK.
- Views الوحدة: V_EMPLOYEES، V_EMPLOYEE_DETAILS، V_DIRECTORY، V_INCOMPLETE، V_EXPIRING_DOCS، V_ATTENDANCE.
- حزمة `MOINFO_HR`: MY_EMPLOYEE_ID، وCAN_VIEW_DETAILS التي تسمح للموظف ببياناته، ولمن له دور MANAGER فأعلى ضمن نطاقه.
- LEAVES وLEAVES2 حُفظا باسم LEAVE_BALANCE_1/2، وقرار عبدالله: تبقى كما هي حاليًا.
- رقم البصمة PIN في أجهزة ZK هو الرقم الوظيفي EMPLOYEE_NO، فسجل البصمة يُربط بالموظف عبره (السكربت 03a يصلح النسخة الأولى).

## السكربت 04: مشاركات الموظفين (EVT)

- جدول `MOINFO_EVT_EVENTS` يدمج PRT_EVENT_EVENTDETAILS وENGTR_EVENTS، وأنواع المشاركة في القوائم المرجعية (EVT_TYPE).
- أدوار رئيس القسم والدائرة والقطاع تحل محلها صلاحية MANAGER بنطاق UNIT. لجنة التدريب الهندسي نطاقها وحدة القطاع الهندسي.
- حزمة `MOINFO_EVT`: CAN_SEE، وHAS_OVERLAP، وOVERLAP_MESSAGE لـ Validation التداخل.
- Views: V_EVENTS، وV_OVERLAPS، وV_EMPLOYEE_SUMMARY.

## السكربت 05: التغطيات الإعلامية (MED)

- `MOINFO_MED_COVERAGES` بديل PRT_RSQ_REG_EVENTS، و`MOINFO_MED_CHANNELS` و`MOINFO_MED_PROGRAMS` (قيد مركب يضمن أن البرنامج يتبع قناة التغطية).
- أعمدة PHOTOGRAPHER وMONTAGE وREPORTER كانت أسماء مستخدمين مفصولة بـ ":"، فصارت جدول `MOINFO_MED_CREW` (سطر لكل موظف ودوره). افتراض: الأعمدة الثلاثة كلها قوائم موظفين.
- المناسبات وأنواع التغطية في القوائم المرجعية (MED_EVENT، MED_EVENT_TYPE)، والمنطقة والمدينة صارتا المحافظة والولاية في النواة.
- حزمة `MOINFO_MED`: SET_CREW وGET_CREW_IDS وGET_CREW_NAMES. وViews: V_COVERAGES، وV_STATS، وV_CREW_WORKLOAD.
- الولايات غير معبأة في النواة (المحافظات فقط).

## السكربت 06: المهام (TSK)

- `MOINFO_TSK_TASKS` يدمج مهام ServiceDesk وCore Tasks: رقم مرجعي، والمهندس المكلّف، وصاحب الطلب (موظف أو اسم نصي)، والنوع والتصنيف والحالة (قوائم مرجعية)، والأولوية، وتاريخ الاستلام والاستحقاق والإغلاق.
- `MOINFO_TSK_NOTES` سجل متابعة بديل TASKS_MONITOR.
- Trigger منفصل `MOINFO_TSK_TASKS_CLOSE_BIU` يعبّئ تاريخ الإغلاق للحالتين DONE وCANCELLED، ويمسحه عند إعادة فتح المهمة.
- حزمة `MOINFO_TSK`: CAN_SEE (المكلّف أو المنشئ، ثم نطاق الوحدة)، وGET_STATUS_ID، وADD_NOTE. وViews: V_TASKS، وV_NOTES، وV_STATS.
- ServiceDesk القديم فيه 776 مهمة حقيقية، ولم تُرحّل بعد.
- لم يرد عبدالله على افتراض أن المونتاج والمراسل قوائم موظفين، ولا على تعبئة الولايات، فبقي الافتراض قائمًا والولايات فارغة.

## السكربت 07: الملفات والمرفقات (ATT)

- حزمة نواة `MOINFO_FILES`: ADD_FROM_APEX (من APEX_APPLICATION_TEMP_FILES إلى MOINFO_ATTACHMENTS)، وDOWNLOAD (بعد التحقق من صلاحية الوحدة، مع دعم الأسماء العربية)، وREMOVE، وFORMAT_SIZE. وView `MOINFO_V_ATTACHMENTS`.
- وحدة ATT: `MOINFO_ATT_DOCUMENTS` (تصنيف، وعنوان، وتاريخ، ووحدة مالكة)، والملفات في MOINFO_ATTACHMENTS، فيمكن أن يكون للمستند أكثر من ملف.
- التصنيفات (ATT_CATEGORY): جداول المناوبات، ومحاضر الاجتماعات، ونماذج الخطابات والمذكرات.
- `MOINFO_ATT.CAN_SEE`، و`MOINFO_ATT_V_DOCUMENTS` مع آخر ملف لكل مستند وعدد ملفاته.

## الحالة (10 نوفمبر 2026)

- نُفّذت بنجاح في WKSP_ABDULLAHALFURQANI2025: السكربتات 01 و01a و02 و03 و04 و05 و06 و07 (نُفّذ 07 في 10 نوفمبر عبر المتصفح). كل الكائنات VALID.
- اختبار وظيفي `tests/t01_functional.sql`: نجحت فحوصه الـ 38 كلها في 10 نوفمبر، وحُذفت بيانات الاختبار.
- التطبيق الفارغ: Unified-System، رقمه 145032، على APEX 26.2.1، ولغته en.
- التطبيق يُولَّد بسكربت Python (`apex/generator/build_app.py` و`gen_app.py`) بصيغة تصدير APEX 26.2.1، ويُثبَّت بتشغيل الملف من SQL Workshop ← SQL Scripts. هذا يستبدل التطبيق 145032 كاملًا وينهي الجلسات المفتوحة.
- الدفعة 1 مثبتة في 10 نوفمبر (23 صفحة): الدخول (9999) بمصادقة MOINFO_AUTH، والرئيسية (1)، وتغيير كلمة المرور (10)، والمستخدمون (20/21) ومنح الوحدات (23)، والهيكل التنظيمي (30/31)، والمسميات (40/41)، والموظفون (50/51)، والقوائم المرجعية (60/61)، والدول (62/63)، والولايات (64/65)، وسجل التدقيق (70)، وسجل الدخول (71)، والإعدادات (80/81).
- مُختبر في المتصفح: الدخول، وفرض تغيير كلمة المرور، وإضافة وحدات تنظيمية بالتسلسل الشجري، وإضافة موظف، والتحقق من كلمة مرور المستخدم الجديد، ومنح وحدة وسحبها، وسجل التدقيق. كل الصفحات تُفتح بلا أخطاء.
- لم يُختبر: إنشاء مستخدم بكلمة مرور مؤقتة، لأن Claude لا يُدخل كلمات مرور. يختبره عبدالله بنفسه.
- اللغة عربية وRTL، والمنطقة الزمنية تلقائية من المتصفح (Asia/Muscat).
- قوالب Universal Theme في التطبيق تُشار إليها بأرقام ثابتة، مسجلة في gen_app.py.
- الدفعة 2 مثبتة في 10 نوفمبر: صفحات HR وEVT وMED وTSK وATT (27 صفحة)، في ملف ثانٍ `apex/f145032_modules.sql` يُثبَّت كمكونات فوق التطبيق. حد SQL Scripts هو 500KB للملف.
- ترتيب التثبيت: `f145032.sql` ثم `f145032_modules.sql`. تثبيت الأول يحذف التطبيق ويعيد إنشاءه، فيجب تشغيل الثاني بعده دائمًا. تثبيت الثاني وحده لا ينهي الجلسات.
- الصفحات: HR (1001 الموظفون، 1002 البيانات التفصيلية، 1003/1004 دليل الهواتف، 1005 الناقص، 1006 الوثائق، 1007 البصمة، 1010 بياناتي)، EVT (2001/2002، 2003 التداخل، 2004 الملخص)، MED (3001/3002 + 3003 الفريق، 3004 الإحصائيات، 3005 عمل الفريق، 3010-3013 القنوات والبرامج)، TSK (4001/4002 مع المتابعة، 4003)، ATT (5001/5002 مع الرفع، 5003 التنزيل).
- Authorization: MOD_<code> لكل وحدة، و<code>_MANAGER، وHAS_EMPLOYEE.
- مُختبر في المتصفح بحساب ADMIN: البيانات التفصيلية والدليل (يُنشأ السطر تلقائيًا)، وتقارير الناقص والوثائق، ومنع المشاركة المتداخلة والتواريخ المعكوسة، وقوائم البرامج حسب القناة، وفريق التغطية، والمهمة مع متابعة تغلقها وتعبّئ تاريخ الإغلاق، والمستند، والتنزيل بالاسم العربي. حُذفت بيانات الاختبار.
- مفتوح ليختبره عبدالله: رفع الملفات (لا يستطيع Claude اختيار ملف من جهازه)، والصلاحيات بحساب غير مدير.

## السكربت 08: الكتالوج المشترك (CAT) والدعم الفني (HD) — 10 نوفمبر 2026

- الكتالوج المشترك بديل النسخ الثلاث في HD والمشتريات والمخزن: `MOINFO_CAT_PRODUCT_TYPES`، و`MOINFO_CAT_BRANDS`، و`MOINFO_CAT_MODELS` (ماركة ونوع منتج)، و`MOINFO_CAT_SUPPLIERS`، و`MOINFO_CAT_WARRANTY_TYPES` (مدة بالأشهر). View `MOINFO_CAT_V_MODELS`.
- HD: `MOINFO_HD_PURCHASE_ORDERS`، و`MOINFO_HD_DEVICES` (الرقم التسلسلي فريد، والحامل الحالي، والحالة من HD_DEVICE_STATUS)، و`MOINFO_HD_ASSIGNMENTS` (سجل تسليم واسترجاع كامل بدل آخر تسليم، مع فهرس يمنع أكثر من تسليم مفتوح للجهاز)، و`MOINFO_HD_SPARE_PARTS`، و`MOINFO_HD_REQUESTS` و`MOINFO_HD_REQUEST_NOTES`.
- Triggers قواعد: نهاية الضمان تُحسب من البداية ونوع الضمان إن تُركت فارغة (للأجهزة والقطع)، والحالة الافتراضية IN_STOCK للجهاز وNEW للطلب، وتاريخ إغلاق الطلب يُعبّأ عند DONE/CANCELLED ويُمسح عند إعادة الفتح.
- حزمة `MOINFO_HD`: LOOKUP_ID، وASSIGN_DEVICE، وRETURN_DEVICE، وIS_MANAGER (صالحة في SQL)، وCAN_SEE_REQUEST (صاحب الطلب أو الفني أو المنشئ، ثم نطاق الوحدة)، وADD_NOTE.
- Views: V_DEVICES، وV_ASSIGNMENTS، وV_WARRANTY_EXPIRING (الإعداد HD_WARRANTY_ALERT_DAYS، الافتراضي 60 يومًا)، وV_REQUESTS، وV_REQUEST_NOTES.
- 08a: تعديل لمن نفّذ 08 قبل إضافة الحالات الافتراضية وIS_MANAGER. التثبيت الجديد يكفيه 08.
- أنواع المنتجات فارغة (لا بيانات أولية)، وأنواع الضمان معبأة: بدون، سنة، سنتان، ثلاث، خمس.

## الدفعة 3 من الصفحات — 10 نوفمبر 2026 (69 صفحة الآن)

- الكتالوج (100–109، صلاحية CAT_MANAGER: المدير أو مشرف HD أو PRC أو STD): أنواع المنتجات، والماركات، والموديلات، والموردون، وأنواع الضمان.
- HD: 6001/6002 طلبات الدعم مع المتابعة، و6003/6004 الأجهزة مع التسليم والاسترجاع وسجل التسليم وقطع الغيار وطلبات الجهاز، و6005 قطعة غيار، و6006/6007 أوامر الشراء، و6008 الضمان، و6009 أجهزتي.
- الموظف العادي (USER) يرفع الطلب ويتابعه فقط، والحالة والفني والحل وحذف الطلب لمن له IS_MANAGER. المولّد يدعم الآن شروط PL/SQL للعناصر والمناطق والأزرار والعمليات.
- مُختبر في المتصفح بحساب ADMIN: ماركة وموديل ومورد، وجهاز بضمان محسوب، وتسليم لموظف ثم استرجاع، وقطعة غيار بضمان محسوب، وطلب دعم مع متابعة تغلقه، وتقرير الضمان، وأمر شراء. حُذفت بيانات الاختبار.
- ملف الصفحات `f145032_modules.sql` حجمه 440KB، والوحدات القادمة تحتاج ملفًا ثالثًا.

## السكربت 09: المشتريات (PRC) — 10 نوفمبر 2026

- `MOINFO_PRC_REQUESTS` (رقم تلقائي PR-السنة-التسلسل من الإعداد PRC_REQUEST_NO_PREFIX والـ Sequence `MOINFO_PRC_REQUEST_NO_SEQ`، والجهة الافتراضية جهة صاحب الطلب، وأمر الشراء من `MOINFO_HD_PURCHASE_ORDERS`) و`MOINFO_PRC_REQUEST_ITEMS` (الكمية والسعر والإجمالي عمود Virtual، وقرار اعتماد لكل صنف).
- أصناف الطلب وماركاتها وموديلاتها ومورّدوها من الكتالوج المشترك، والمرفقات في MOINFO_ATTACHMENTS.
- دورة الطلب بحالة واحدة (PRC_REQUEST_STATUS): DRAFT ← SUBMITTED ← APPROVED أو REJECTED ← PURCHASED ← DELIVERED، وCANCELLED، وREJECTED تعود DRAFT.
- Trigger يمنع إضافة الأصناف أو تعديلها بعد التقديم، إلا قرار الاعتماد على الصنف وقت SUBMITTED.
- حزمة `MOINFO_PRC`: CAN_SEE، وCAN_EDIT، وCAN_DECIDE (MANAGER على جهة الطلب)، وIS_PURCHASER (دور ADMIN في PRC)، وSUBMIT، وAPPROVE (يعتمد الأصناف التي بلا قرار)، وREJECT (السبب إلزامي)، وREOPEN، وCANCEL، وPURCHASE، وDELIVER.
- Views: V_ITEMS، وV_REQUESTS (الإجمالي والمعتمد)، وV_STATS.
- 09a: إصلاح Trigger القفل (DECODE لا تعمل داخل PL/SQL).
- الصفحات: 7001 الطلبات، و7002 الطلب مع الإجراءات والأصناف والمرفقات، و7003 الصنف (الموديل يتبع الماركة)، و7004 التنزيل، و7005 بانتظار الاعتماد، و7006 الشراء والاستلام، و7007 الإحصائيات. Authorization جديدة: PRC_PURCHASER.
- مُختبر في المتصفح: منع التقديم بلا أصناف، ورفض صنف، والاعتماد، والشراء، والاستلام، والإحصائيات.

## السكربت 10: رسائل الأخطاء

- `MOINFO_APEX_ERROR_HANDLER` مربوطة بالتطبيق: أخطاء RAISE_APPLICATION_ERROR تظهر بالنص العربي وحده بلا ORA-، وأخطاء القيود (التكرار، والحذف المرتبط، والقيمة المرتبطة، وقيد CHECK، والحقل المطلوب) برسائل عربية.

## التثبيت (10 نوفمبر 2026)

- ملفات التطبيق ثلاثة الآن: `f145032.sql` ثم `f145032_modules.sql` ثم `f145032_modules2.sql`. المولّد يقسم صفحات الوحدات تلقائيًا بحيث يبقى كل ملف تحت 470KB.
- ثبّت عبدالله ملفي الوحدات بنفسه في 10 نوفمبر، لأن الاتصال بالمتصفح انقطع. والمطلوب منه بعدها: حذف بيانات اختبار المشتريات، وإعادة إنشاء الـ Sequence، واختبار الرفض والإعادة إلى مسودة.

## السكربت 11: مخزن الاستوديو (STD) — 10 نوفمبر 2026

- `MOINFO_STD_ITEMS`: باركود فريد (تلقائي من `MOINFO_STD_BARCODE_SEQ` بدءًا من 100001)، والنوع والماركة والموديل من الكتالوج، والحالة والموقع والرف من القوائم (STD_ITEM_STATUS وSTD_LOCATION وSTD_BIN)، ورصيد المخزن والحد الأدنى للتنبيه ونهاية الضمان.
- `MOINFO_STD_MOVEMENTS` بديل PRT_STD_ITEMS_AUDIT: IN استلام، وOUT صرف، وRETURN إرجاع، وADJUST تسوية، مع الكمية والرصيد بعدها، والمستلم (موظف أو اسم نصي)، والمفوِّض، وتاريخ الإرجاع المتوقع.
- الرصيد لا يتغير إلا عبر حزمة `MOINFO_STD` (RECEIVE، وISSUE، وRETURN_ITEM، وADJUST، وITEM_BY_CODE، وCAN_MOVE، وIS_MANAGER). Trigger يمنع التعديل المباشر، والكمية الافتتاحية عند الإضافة تُسجَّل حركة استلام.
- Views: V_ITEMS (في المخزن، والمصروف، والإجمالي، والنقص)، وV_MOVEMENTS، وV_OUTSTANDING (ما لدى كل مستلم والمتأخر حسب الإعداد STD_OVERDUE_DAYS).
- الأدوار: VIEWER للاطلاع، وUSER للحركات، وMANAGER للمعدات والتسوية والقوائم. Authorization جديدة: STD_USER.
- الصفحات: 8001 المعدات، و8002 المعدة مع تسجيل الحركة وسجلها، و8003 الصرف والاستلام بالباركود، و8004 لدى المستلمين، و8005 سجل الحركات، و8006 النواقص، و8007/8008 قوائم المخزن.
- الاختبار `tests/t02_std.sql` في SQL Commands. لا يمكن إنشاء جلسة APEX من SQL Commands (Access to session state is disabled)، فالاختبار يضيف مستخدم المساحة مديرًا مؤقتًا ثم يتراجع.
- نفّذ عبدالله 11 والاختبار وملفات التطبيق الثلاثة في 10 نوفمبر.

## السكربت 12: القسم التجاري (ADV) — 10 نوفمبر 2026

- المساران القديمان (الشركات المباشرة، والوكالات وعملاؤها) دُمجا: `MOINFO_ADV_ACCOUNTS` (شركة أو وكالة، والشركة قد تمثّلها وكالة AGENCY_ID)، و`MOINFO_ADV_CONTACTS` لأي حساب، و`MOINFO_ADV_DEALS` الفرص الإعلانية بدل ADVERTISEMENT/ADVERTISEMENTS، و`MOINFO_ADV_ACTIVITIES` سجل متابعة بدل حقل FOLLOWUP.
- القوائم: ADV_SECTOR، وADV_INDUSTRY، وADV_MEDIA، وADV_DEAL_STATUS (WON وLOST تغلق الفرصة)، وADV_ACTIVITY_TYPE.
- Triggers: حساب الوكالة بلا وكيل، والمعلن شركة والوكالة وكالة (والوكالة الافتراضية وكيل المعلن)، وجهة الاتصال من المعلن أو الوكالة. التحقق يتم عند تغيّر الحقل فقط لتجنّب ORA-04091 مع الحذف المتسلسل.
- حزمة `MOINFO_ADV`: CAN_SEE (المندوب المسؤول أو المنشئ ثم نطاق الوحدة)، وIS_MANAGER، وADD_ACTIVITY.
- الصفحات 9001–9009، والاختبار `tests/t03_adv.sql`. نفّذه عبدالله.

## السكربت 13: تسجيل البصمة (OMI) — 10 نوفمبر 2026

- `MOINFO_OMI_PERSONS` بديل MOI_EMPLOYEES (ربط اختياري بموظف النواة، والرقم المدني فريد)، مع IS_REGISTERED وREGISTERED_AT ونقطة التسجيل والجهاز، وIS_UPLOADED وUPLOADED_AT للرفع إلى Alpeta.
- `MOINFO_OMI_TERMINALS` يدمج MOI_TERMINALS وMOI_FIXED_TERMINALS. والقوائم OMI_SITE (مسقط، صلالة) وOMI_REG_POINT.
- حزمة `MOINFO_OMI`: REGISTER_PERSON، وUNREGISTER_PERSON، وMARK_UPLOADED، وMARK_ALL_UPLOADED. وViews: V_PERSONS، وV_TERMINALS، وV_DAILY، وV_SUMMARY.
- اسم الوحدة في النواة صار «تسجيل البصمة».
- الصفحات 10001–10011 (منها التسجيل السريع 10011)، والاختبار `tests/t04_omi.sql`. نفّذه عبدالله.

## السكربت 14: دليل الجهات (NWS) — 10 نوفمبر 2026

- عشرون جدولًا في f1200 صارت جدولين: `MOINFO_NWS_ENTITIES` شجرة جهات (وزارات، وأقسام، ومكاتب في المحافظات والولايات، وسفارات في السلطنة، وسفارات عمانية، ومؤسسات، ووسائل إعلام)، و`MOINFO_NWS_CONTACTS` جهات الاتصال لجهة أو لدولة.
- الدول والمحافظات والولايات من النواة. أُضيف للنواة عمود `MOINFO_COUNTRIES.REGION_ID` (القائمة WORLD_REGION) وView `MOINFO_V_COUNTRIES`، وصفحة الدول 62/63 تعرض الإقليم.
- Views: V_ENTITIES (المسار الكامل والعمق)، وV_CONTACTS (الدليل). وحزمة `MOINFO_NWS` (CAN_EDIT، وIS_MANAGER).
- الصفحات 11001–11007، والاختبار `tests/t05_nws.sql`.
- بهذا اكتملت كل الوحدات. ملف `f145032_modules2.sql` قرب 466KB.

## التوجه المبدئي

نواة ServiceDesk (`MOINFO_USERS/UNITS/LEVELS/ROLES/TITLES/PRIVILEGES` + مولّد التدقيق) هي الأنضج بين الأنظمة، وتصلح أساسًا للمنصة الموحدة. تُضاف إليها بقية الأنظمة كوحدات ببادئات، بعد توحيد البيانات المشتركة (المستخدمون، الهيكل التنظيمي، الموظفون، الماركات/الموديلات/الموردون، الفعاليات).

## تفاصيل الجداول لكل نظام

(الرقم بين القوسين عدد الأعمدة)

### f100 — HrSystem - 2025

الصفحات: 45 | الجداول: 7 | Views: 13 | Triggers: 7 | PL/SQL: 7 | FK: 7

الجداول: `PRT_HR_DEPARTMENTS` (14), `PRT_HR_EMPLOYEES` (71), `PRT_HR_LOGINHISTORY` (6), `PRT_HR_SECTIONS` (16), `PRT_HR_SECTORS` (13), `PRT_HR_USERSTYPES` (12), `PRT_HR_ZK_CHECKINOUT` (9)

### f200 — Core Tasks - 2025

الصفحات: 12 | الجداول: 5 | Views: 0 | Triggers: 5 | PL/SQL: 5 | FK: 3

الجداول: `TASKS_LOGINHISTORY` (3), `TASKS_MONITOR` (9), `TASKS_STATUS` (2), `TASKS_TASKS` (2), `TASKS_USERS_MST` (7)

### f300 — Attachments - 2025

الصفحات: 10 | الجداول: 4 | Views: 0 | Triggers: 4 | PL/SQL: 4 | FK: 1

الجداول: `ATTACH_ATTACHMENTS` (11), `ATTACH_PARTPRIVILEGES` (2), `ATTACH_TEMPLATES` (6), `ATTACH_USERS_MST` (7)

### f400 — Commercial Department System - 2025

الصفحات: 28 | الجداول: 13 | Views: 0 | Triggers: 13 | PL/SQL: 3 | FK: 10

الجداول: `PRT_ADV_ADVERTISEMENT` (17), `PRT_ADV_ADVERTISEMENTS` (17), `PRT_ADV_AGENCIES` (12), `PRT_ADV_AGENCYCLIENTS` (13), `PRT_ADV_COMPANIES` (14), `PRT_ADV_CONTACT` (16), `PRT_ADV_CONTACTS` (16), `PRT_ADV_INDUSTRIES` (12), `PRT_ADV_LOGINHISTORY` (6), `PRT_ADV_MEDIA` (12), `PRT_ADV_PRIVILEGES` (12), `PRT_ADV_SECTOR` (12), `PRT_ADV_USERS` (17)

### f500 — StudioStore - 2025

الصفحات: 49 | الجداول: 10 | Views: 3 | Triggers: 10 | PL/SQL: 6 | FK: 6

الجداول: `PRT_STD_ASSET_TYPES` (12), `PRT_STD_BRANDS` (12), `PRT_STD_ITEMS` (27), `PRT_STD_ITEMS_AUDIT` (9), `PRT_STD_LOCATIONS` (12), `PRT_STD_LOGINHISTORY` (6), `PRT_STD_PIN_LOCATIONS` (12), `PRT_STD_PRIVILEGES` (12), `PRT_STD_STATUS` (12), `PRT_STD_USERS` (17)

### f600 — Engineering Training Committee Events - 2025

الصفحات: 20 | الجداول: 17 | Views: 0 | Triggers: 25 | PL/SQL: 2 | FK: 7

الجداول: `ENGTR_DEPARTMENTS` (10), `ENGTR_DEPT_HIST` (14), `ENGTR_EMPLOYEES` (20), `ENGTR_EMP_HIST` (24), `ENGTR_EVENTS` (15), `ENGTR_EVENTSTYPES` (9), `ENGTR_EVENTSTYPES_HIST` (13), `ENGTR_EVENTS_HIST` (19), `ENGTR_LOGINHISTORY` (3), `ENGTR_PRIVILEGES` (9), `ENGTR_PRIVILEGES_HIST` (13), `ENGTR_ROLES` (9), `ENGTR_ROLES_HIST` (13), `ENGTR_SECTIONS` (10), `ENGTR_SECTIONS_HIST` (14), `ENGTR_SECTORS` (9), `ENGTR_SECTORS_HIST` (13)

### f700 — Events - 2025

الصفحات: 16 | الجداول: 7 | Views: 0 | Triggers: 7 | PL/SQL: 5 | FK: 5

الجداول: `PRT_EVENT_EMPLOYEES` (21), `PRT_EVENT_EVENTDETAILS` (21), `PRT_EVENT_EVENTSTYPES` (12), `PRT_EVENT_LOGINHISTORY` (6), `PRT_EVENT_PRIVILEGES` (12), `PRT_EVENT_ROLES` (12), `PRT_EVENT_SECTIONS` (12)

### f800 — Help Desk - 2025

الصفحات: 52 | الجداول: 18 | Views: 0 | Triggers: 18 | PL/SQL: 8 | FK: 18

الجداول: `PRT_HD_BRANDS` (7), `PRT_HD_DELIVERY` (10), `PRT_HD_DEPARTMENTS_IT` (7), `PRT_HD_DEVICES` (16), `PRT_HD_LOGINHISTORY` (6), `PRT_HD_MODEL` (7), `PRT_HD_PRIVILEGES` (6), `PRT_HD_PRODUCT` (6), `PRT_HD_PURCHASE_ORDER` (7), `PRT_HD_REMARKS` (5), `PRT_HD_REQUESTS` (10), `PRT_HD_SECTIONS_IT` (7), `PRT_HD_SECTORS_IT` (6), `PRT_HD_SPARE_PARTS` (16), `PRT_HD_STATUS` (6), `PRT_HD_SUPPLIERS` (8), `PRT_HD_USER_INFO` (15), `PRT_HD_WARRANTIES` (7)

### f900 — Purchases - 2025

الصفحات: 42 | الجداول: 13 | Views: 0 | Triggers: 13 | PL/SQL: 6 | FK: 10

الجداول: `PRT_PRCH_ATTACHMENTS` (6), `PRT_PRCH_BRANDS` (12), `PRT_PRCH_DEPARTMENTS` (13), `PRT_PRCH_EMPLOYEES` (23), `PRT_PRCH_ITEMS` (23), `PRT_PRCH_ITEMS_CATEGORIES` (12), `PRT_PRCH_LOGINHISTORY` (7), `PRT_PRCH_MODELS` (13), `PRT_PRCH_PURCHASE_REQUESTS` (23), `PRT_PRCH_SECTIONS` (14), `PRT_PRCH_SECTORS` (12), `PRT_PRCH_SUPPLIERS` (14), `PRT_PRCH_USERSTYPES` (12)

### f1000 — OmanInfo - 2025

الصفحات: 17 | الجداول: 11 | Views: 0 | Triggers: 11 | PL/SQL: 6 | FK: 3

الجداول: `MOI_EMPLOYEES` (16), `MOI_EMPLOYEES_AUDIT` (16), `MOI_FIXED_TERMINALS` (12), `MOI_FIXED_TERMINALS_AUDIT` (16), `MOI_LOGINHISTORY` (7), `MOI_PRIVILEGES` (3), `MOI_REGISTRATION_LOCATIONS` (3), `MOI_REGISTRATION_LOCATIONS_AUDIT` (7), `MOI_TERMINALS` (8), `MOI_TERMINALS_AUDIT` (12), `MOI_USERS` (7)

### f1100 — Al-Rustaq Events - 2025

الصفحات: 23 | الجداول: 10 | Views: 0 | Triggers: 10 | PL/SQL: 5 | FK: 8

الجداول: `PRT_RSQ_CHANNELS` (6), `PRT_RSQ_CITY` (7), `PRT_RSQ_EMPLOYEES` (11), `PRT_RSQ_EVENTS` (6), `PRT_RSQ_EVENTS_TYPE` (6), `PRT_RSQ_LOGINHISTORY` (8), `PRT_RSQ_PRIVILEGE` (7), `PRT_RSQ_PROGRAMS` (7), `PRT_RSQ_REGION` (6), `PRT_RSQ_REG_EVENTS` (16)

### f1200 — News  - 2025

الصفحات: 46 | الجداول: 20 | Views: 0 | Triggers: 20 | PL/SQL: 3 | FK: 18

الجداول: `NEWS_AFFAIRS_OUT_USER` (13), `NEWS_CATORG` (6), `NEWS_CATORG_AFFAIRS` (7), `NEWS_COUNTRIES` (7), `NEWS_EMBASSY_IN` (7), `NEWS_EMBASSY_OMAN` (7), `NEWS_EMP` (13), `NEWS_GOVERNATES` (7), `NEWS_IN_OUT_ARBIC_USER` (13), `NEWS_MIN_AFFAIRS` (7), `NEWS_MIN_AFFAIRS_USER` (13), `NEWS_MIN_INTERIOR` (7), `NEWS_MIN_INT_OFFICE` (13), `NEWS_MIN_INT_USER` (13), `NEWS_ORG` (8), `NEWS_PRIVILEGES` (6), `NEWS_REGIONS` (6), `NEWS_TOWN` (7), `NEWS_TYPE_INTERIOR` (7), `NEWS_USER_INFO` (10)

### f194952 — ServiceDesk

الصفحات: 31 | الجداول: 36 | Views: 0 | Triggers: 34 | PL/SQL: 36 | FK: 47

الجداول: `MOINFO_DBTABLES` (3), `MOINFO_EXCLUDEAUDIT` (1), `MOINFO_EXCLUDECOPY` (1), `MOINFO_HD_BRANDS` (5), `MOINFO_HD_CATEGORIES` (3), `MOINFO_HD_DELIVERY` (10), `MOINFO_HD_DEVICES` (16), `MOINFO_HD_MODELS` (5), `MOINFO_HD_PRODUCTS` (4), `MOINFO_HD_PURCHASE_ORDER` (6), `MOINFO_HD_REMARKS` (5), `MOINFO_HD_REQUESTS` (6), `MOINFO_HD_SPARE_PARTS` (12), `MOINFO_HD_SUPPLIERS` (6), `MOINFO_HD_WARRANTIES` (5), `MOINFO_LEVELS` (4), `MOINFO_LOGINHISTORY` (7), `MOINFO_PRIVILEGES` (4), `MOINFO_REORDER` (5), `MOINFO_ROLES` (4), `MOINFO_TITLES` (4), `MOINFO_TOTALTABLESRECORDS` (6), `MOINFO_TSK_STATUS` (4), `MOINFO_TSK_TASKS` (12), `MOINFO_TSK_TASK_CATEGORIES` (4), `MOINFO_TSK_TASK_TYPES` (4), `MOINFO_UNITS` (6), `MOINFO_USERS` (14), `MOI_TCOUNTTABLESRECORDS` (4), `PRT_HD_CATEGORIES` (2), `PRT_HD_REMARKS` (5), `PRT_HD_REQUESTS` (10), `PRT_HD_SPARE_PARTS` (16), `TMP_ORDER` (5), `TMP_TERMINALS_1` (4), `TMP_TERMINALS_2` (4)
