# MOINFO — النظام الموحد

دمج أنظمة Oracle APEX السابقة في تطبيق واحد على APEX 26.2.1، مع قاعدة بيانات واحدة.

## الملفات

| الملف | الوصف |
|---|---|
| `sql/00_moinfo_core_drop.sql` | حذف كائنات النواة لإعادة التثبيت. يتوقف تلقائيًا إن لم يكن الـ Schema هو Schema النظام الموحد |
| `sql/01_moinfo_core.sql` | النواة المشتركة: الجداول، وحزم MOINFO_UTIL وMOINFO_AUTH وMOINFO_SEC، والبيانات الأولية |
| `sql/01a_fix_packages.sql` | إصلاح لمن شغّل النسخة الأولى من 01: يعيد إنشاء MOINFO_AUTH وMOINFO_SEC وينشئ ADMIN |
| `sql/02_moinfo_core_additions.sql` | إضافات للنواة: القوائم المرجعية العامة، واستثناء جداول من التدقيق، وحزمة MOINFO_ADMIN لإدارة المستخدمين |
| `sql/03_moinfo_hr.sql` | وحدة الموارد البشرية: البيانات التفصيلية للموظف، ودليل الهواتف، وسجل البصمة، والتقارير |
| `sql/03a_fix_hr_pin.sql` | إصلاح لمن شغّل النسخة الأولى من 03: رقم البصمة هو الرقم الوظيفي |
| `sql/04_moinfo_evt.sql` | وحدة مشاركات الموظفين: تدمج Events (f700) وEngineering Training (f600) |
| `sql/05_moinfo_med.sql` | وحدة التغطيات الإعلامية: بديل Al-Rustaq Events (f1100) |
| `sql/06_moinfo_tsk.sql` | وحدة المهام: تدمج Core Tasks (f200) ومهام ServiceDesk |
| `sql/07_moinfo_att.sql` | حزمة MOINFO_FILES لرفع الملفات وتنزيلها (للنواة)، ووحدة المرفقات والقوالب بديل Attachments (f300) |
| `sql/08_moinfo_cat_hd.sql` | الكتالوج المشترك (أنواع المنتجات، الماركات، الموديلات، الموردون، أنواع الضمان) ووحدة الدعم الفني بديل Help Desk (f800) |
| `sql/08a_hd_patch.sql` | تعديل لمن شغّل النسخة الأولى من 08: الحالات الافتراضية والدالة MOINFO_HD.IS_MANAGER |
| `sql/09_moinfo_prc.sql` | وحدة المشتريات بديل Purchases (f900) |
| `sql/09a_prc_fix_lock.sql` | إصلاح Trigger قفل الأصناف لمن شغّل النسخة الأولى من 09 |
| `sql/10_moinfo_error_handler.sql` | دالة رسائل الأخطاء العربية للتطبيق |
| `apex/f145032.sql` | التطبيق: النواة والمكونات المشتركة وصفحات الإدارة. تثبيته يستبدل التطبيق 145032 كاملًا |
| `apex/f145032_modules.sql` و`f145032_modules2.sql` | صفحات الوحدات، تُثبَّت بالترتيب بعد f145032.sql دائمًا |
| `apex/generator/` | سكربتات Python التي تولّد ملفي التطبيق |
| `apex/f145032_empty_base.sql` | تصدير التطبيق الفارغ Unified-System (145032)، وهو الأساس الذي ستُبنى عليه الصفحات |
| `docs/apex-inventory.md` | جرد الأنظمة القديمة، ونتائج المقارنة، والقرارات المعتمدة |

## التثبيت

1. أنشئ Workspace بـ Schema جديد ومخصص للنظام الموحد.
2. شغّل السكربتات بالترتيب (01 ثم 02 ثم 03 ...) من SQL Workshop ← SQL Scripts.
3. تأكد أن الاستعلام الأخير لا يعرض كائنات INVALID.
4. ثبّت `apex/f145032.sql` ثم `apex/f145032_modules.sql` ثم `apex/f145032_modules2.sql` من SQL Scripts.
5. ادخل بالمستخدم `ADMIN` وكلمة المرور الأولية `Admin#2026`، وسيُطلب تغييرها.
