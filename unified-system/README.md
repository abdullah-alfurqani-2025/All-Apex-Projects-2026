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
| `docs/apex-inventory.md` | جرد الأنظمة القديمة، ونتائج المقارنة، والقرارات المعتمدة |

## التثبيت

1. أنشئ Workspace بـ Schema جديد ومخصص للنظام الموحد.
2. شغّل السكربتات بالترتيب (01 ثم 02 ثم 03 ...) من SQL Workshop ← SQL Scripts.
3. تأكد أن الاستعلام الأخير لا يعرض كائنات INVALID.
4. ادخل بالمستخدم `ADMIN` وكلمة المرور الأولية `Admin#2026`، وسيُطلب تغييرها.
