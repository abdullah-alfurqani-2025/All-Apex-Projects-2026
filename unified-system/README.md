# MOINFO — النظام الموحد

دمج أنظمة Oracle APEX السابقة في تطبيق واحد على APEX 26.2.1، مع قاعدة بيانات واحدة.

## الملفات

| الملف | الوصف |
|---|---|
| `sql/00_moinfo_core_drop.sql` | حذف كائنات النواة لإعادة التثبيت. يتوقف تلقائيًا إن لم يكن الـ Schema هو Schema النظام الموحد |
| `sql/01_moinfo_core.sql` | النواة المشتركة: الجداول، وحزم MOINFO_UTIL وMOINFO_AUTH وMOINFO_SEC، والبيانات الأولية |
| `sql/01a_fix_packages.sql` | إصلاح لمن شغّل النسخة الأولى من 01: يعيد إنشاء MOINFO_AUTH وMOINFO_SEC وينشئ ADMIN |
| `docs/apex-inventory.md` | جرد الأنظمة القديمة، ونتائج المقارنة، والقرارات المعتمدة |

## التثبيت

1. أنشئ Workspace بـ Schema جديد ومخصص للنظام الموحد.
2. شغّل `sql/01_moinfo_core.sql` من SQL Workshop ← SQL Scripts.
3. تأكد أن الاستعلام الأخير لا يعرض كائنات INVALID.
4. ادخل بالمستخدم `ADMIN` وكلمة المرور الأولية `Admin#2026`، وسيُطلب تغييرها.
