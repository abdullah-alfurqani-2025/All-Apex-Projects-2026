--------------------------------------------------------------------------------
-- MOINFO - النظام الموحد
-- السكربت 07: الملفات (للنواة) ووحدة المرفقات والقوالب (ATT) — بديل Attachments (f300)
--
-- يُشغَّل بعد 01 إلى 06 في نفس الـ Schema.
--
-- الجزء الأول: حزمة MOINFO_FILES للنواة، لرفع الملفات إلى MOINFO_ATTACHMENTS
--              وتنزيلها. تستخدمها كل الوحدات (المهام، المشتريات، المشاركات ...).
-- الجزء الثاني: مكتبة مستندات القسم، بديل Attachments:
--   ATTACH_TEMPLATES   ← MOINFO_LOOKUPS (النوع ATT_CATEGORY)
--   ATTACH_ATTACHMENTS ← MOINFO_ATT_DOCUMENTS (بيانات المستند)
--                        + MOINFO_ATTACHMENTS (الملف نفسه، ويمكن أن يكون للمستند أكثر من ملف)
--   ATTACH_USERS_MST / ATTACH_PARTPRIVILEGES ← النواة
--
-- الصلاحيات في هذه الوحدة:
--   USER    + UNIT : يرى مستندات وحدته ويضيف إليها
--   ADMIN   + ALL  : كل المستندات
--------------------------------------------------------------------------------


--==============================================================================
-- الجزء الأول: MOINFO_FILES (النواة)
--
-- الرفع من صفحة APEX (عنصر File Browse بتخزين APEX_APPLICATION_TEMP_FILES):
--   :P5002_FILES_COUNT := MOINFO_FILES.ADD_FROM_APEX(
--       p_module_code => 'ATT',
--       p_entity_name => 'MOINFO_ATT_DOCUMENTS',
--       p_entity_id   => :P5002_DOCUMENT_ID,
--       p_file_names  => :P5002_FILES);
--
-- التنزيل: صفحة أو Application Process يستدعي
--   MOINFO_FILES.DOWNLOAD(:P5003_ATTACHMENT_ID);
--==============================================================================
CREATE OR REPLACE PACKAGE MOINFO_FILES AS

    -- ينقل الملفات المرفوعة من APEX_APPLICATION_TEMP_FILES إلى MOINFO_ATTACHMENTS.
    -- p_file_names: قيمة عنصر File Browse (أسماء مفصولة بـ : عند رفع أكثر من ملف).
    -- يُرجع عدد الملفات المنقولة.
    FUNCTION ADD_FROM_APEX (
        p_module_code IN VARCHAR2,
        p_entity_name IN VARCHAR2,
        p_entity_id   IN NUMBER,
        p_file_names  IN VARCHAR2,
        p_description IN VARCHAR2 DEFAULT NULL
    ) RETURN NUMBER;

    -- يرسل الملف للمتصفح. يتحقق أن للمستخدم صلاحية على وحدة الملف.
    PROCEDURE DOWNLOAD (p_attachment_id IN NUMBER, p_inline IN VARCHAR2 DEFAULT 'N');

    -- إيقاف المرفق (حذف ناعم)
    PROCEDURE REMOVE (p_attachment_id IN NUMBER);

    -- حجم مقروء مثل: 2.4 MB
    FUNCTION FORMAT_SIZE (p_bytes IN NUMBER) RETURN VARCHAR2;

END MOINFO_FILES;
/

CREATE OR REPLACE PACKAGE BODY MOINFO_FILES AS

    FUNCTION ADD_FROM_APEX (
        p_module_code IN VARCHAR2,
        p_entity_name IN VARCHAR2,
        p_entity_id   IN NUMBER,
        p_file_names  IN VARCHAR2,
        p_description IN VARCHAR2 DEFAULT NULL
    ) RETURN NUMBER IS
        l_names  APEX_T_VARCHAR2 := APEX_STRING.SPLIT(p_file_names, ':');
        l_count  NUMBER := 0;
        l_module VARCHAR2(10)  := UPPER(p_module_code);
        l_entity VARCHAR2(128) := UPPER(p_entity_name);
        l_name   VARCHAR2(400);
    BEGIN
        IF p_file_names IS NULL THEN
            RETURN 0;
        END IF;

        FOR i IN 1 .. l_names.COUNT LOOP
            l_name := l_names(i);
            IF l_name IS NOT NULL THEN
                INSERT INTO MOINFO_ATTACHMENTS
                       (MODULE_CODE, ENTITY_NAME, ENTITY_ID, FILE_NAME, MIME_TYPE, FILE_SIZE, FILE_BLOB, DESCRIPTION)
                SELECT l_module,
                       l_entity,
                       p_entity_id,
                       SUBSTR(f.FILENAME, 1, 400),
                       f.MIME_TYPE,
                       DBMS_LOB.GETLENGTH(f.BLOB_CONTENT),
                       f.BLOB_CONTENT,
                       p_description
                  FROM APEX_APPLICATION_TEMP_FILES f
                 WHERE f.NAME = l_name;
                l_count := l_count + SQL%ROWCOUNT;
            END IF;
        END LOOP;

        RETURN l_count;
    END ADD_FROM_APEX;

    PROCEDURE DOWNLOAD (p_attachment_id IN NUMBER, p_inline IN VARCHAR2 DEFAULT 'N') IS
        l_blob   BLOB;
        l_mime   MOINFO_ATTACHMENTS.MIME_TYPE%TYPE;
        l_name   MOINFO_ATTACHMENTS.FILE_NAME%TYPE;
        l_module MOINFO_ATTACHMENTS.MODULE_CODE%TYPE;
    BEGIN
        SELECT FILE_BLOB, MIME_TYPE, FILE_NAME, MODULE_CODE
          INTO l_blob, l_mime, l_name, l_module
          FROM MOINFO_ATTACHMENTS
         WHERE ATTACHMENT_ID = p_attachment_id
           AND IS_ACTIVE = 'Y';

        IF NOT MOINFO_SEC.HAS_MODULE(l_module) THEN
            RAISE_APPLICATION_ERROR(-20030, 'لا تملك صلاحية تنزيل هذا الملف');
        END IF;

        SYS.HTP.INIT;
        SYS.OWA_UTIL.MIME_HEADER(NVL(l_mime, 'application/octet-stream'), FALSE);
        SYS.HTP.P('Content-Length: ' || DBMS_LOB.GETLENGTH(l_blob));
        -- filename* يحافظ على الأسماء العربية
        SYS.HTP.P('Content-Disposition: '
                  || CASE WHEN p_inline = 'Y' THEN 'inline' ELSE 'attachment' END
                  || '; filename="file"; filename*=UTF-8''''' || UTL_URL.ESCAPE(l_name, TRUE, 'UTF-8'));
        SYS.OWA_UTIL.HTTP_HEADER_CLOSE;
        SYS.WPG_DOCLOAD.DOWNLOAD_FILE(l_blob);
        APEX_APPLICATION.STOP_APEX_ENGINE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20031, 'الملف غير موجود');
    END DOWNLOAD;

    PROCEDURE REMOVE (p_attachment_id IN NUMBER) IS
    BEGIN
        UPDATE MOINFO_ATTACHMENTS
           SET IS_ACTIVE = 'N'
         WHERE ATTACHMENT_ID = p_attachment_id;
    END REMOVE;

    FUNCTION FORMAT_SIZE (p_bytes IN NUMBER) RETURN VARCHAR2 IS
    BEGIN
        RETURN CASE
                   WHEN p_bytes IS NULL          THEN NULL
                   WHEN p_bytes < 1024           THEN p_bytes || ' B'
                   WHEN p_bytes < 1024 * 1024    THEN ROUND(p_bytes / 1024, 1) || ' KB'
                   ELSE ROUND(p_bytes / 1024 / 1024, 1) || ' MB'
               END;
    END FORMAT_SIZE;

END MOINFO_FILES;
/

-- كل المرفقات النشطة بلا محتوى الملف (للتقارير وقوائم التنزيل في كل الوحدات)
CREATE OR REPLACE VIEW MOINFO_V_ATTACHMENTS AS
SELECT a.ATTACHMENT_ID,
       a.MODULE_CODE,
       a.ENTITY_NAME,
       a.ENTITY_ID,
       a.FILE_NAME,
       a.MIME_TYPE,
       a.FILE_SIZE,
       MOINFO_FILES.FORMAT_SIZE(a.FILE_SIZE) AS FILE_SIZE_TEXT,
       a.DESCRIPTION,
       a.CREATED_BY,
       NVL(u.DISPLAY_NAME, a.CREATED_BY) AS CREATED_BY_NAME,
       a.CREATED_AT
  FROM MOINFO_ATTACHMENTS a
  LEFT JOIN MOINFO_USERS u ON u.USERNAME = a.CREATED_BY
 WHERE a.IS_ACTIVE = 'Y';


--==============================================================================
-- الجزء الثاني: وحدة المرفقات والقوالب (ATT)
--==============================================================================

-- 1) تصنيفات المستندات (من الصفحة الرئيسية في النظام القديم)
INSERT INTO MOINFO_LOOKUP_TYPES (LOOKUP_TYPE, MODULE_CODE, TYPE_NAME_AR, TYPE_NAME_EN)
VALUES ('ATT_CATEGORY', 'ATT', 'تصنيف المستند', 'Document Category');

INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('ATT_CATEGORY', 'DUTY_ROSTER', 'جداول المناوبات',            'Duty Roster',              1);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('ATT_CATEGORY', 'MINUTES',     'محاضر الاجتماعات',           'Minutes of Meeting',       2);
INSERT INTO MOINFO_LOOKUPS (LOOKUP_TYPE, LOOKUP_CODE, NAME_AR, NAME_EN, SORT_ORDER) VALUES ('ATT_CATEGORY', 'TEMPLATES',   'نماذج الخطابات والمذكرات',   'Letter & Memo Templates',  3);

COMMIT;


-- 2) المستندات
CREATE TABLE MOINFO_ATT_DOCUMENTS (
    DOCUMENT_ID     NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    CATEGORY_ID     NUMBER                      NOT NULL,
    TITLE           VARCHAR2(500 CHAR)          NOT NULL,
    DOCUMENT_DATE   DATE,
    OWNER_UNIT_ID   NUMBER,
    REMARKS         VARCHAR2(1000 CHAR),
    IS_ACTIVE       VARCHAR2(1) DEFAULT ON NULL 'Y' NOT NULL,
    CREATED_BY      VARCHAR2(255),
    CREATED_AT      TIMESTAMP WITH LOCAL TIME ZONE,
    UPDATED_BY      VARCHAR2(255),
    UPDATED_AT      TIMESTAMP WITH LOCAL TIME ZONE,
    CONSTRAINT MOINFO_ATT_DOCUMENTS_PK PRIMARY KEY (DOCUMENT_ID),
    CONSTRAINT MOINFO_ATT_DOC_CAT_FK FOREIGN KEY (CATEGORY_ID) REFERENCES MOINFO_LOOKUPS (LOOKUP_ID),
    CONSTRAINT MOINFO_ATT_DOC_UNIT_FK FOREIGN KEY (OWNER_UNIT_ID) REFERENCES MOINFO_UNITS (UNIT_ID),
    CONSTRAINT MOINFO_ATT_DOC_ACTIVE_CK CHECK (IS_ACTIVE IN ('Y','N'))
);
CREATE INDEX MOINFO_ATT_DOC_CAT_IX  ON MOINFO_ATT_DOCUMENTS (CATEGORY_ID);
CREATE INDEX MOINFO_ATT_DOC_UNIT_IX ON MOINFO_ATT_DOCUMENTS (OWNER_UNIT_ID);


-- 3) MOINFO_ATT: دوال الوحدة
CREATE OR REPLACE PACKAGE MOINFO_ATT AS

    -- 'Y' إن كان يحق للمستخدم الحالي رؤية المستند
    -- مثال: WHERE MOINFO_ATT.CAN_SEE(DOCUMENT_ID) = 'Y'
    FUNCTION CAN_SEE (p_document_id IN NUMBER) RETURN VARCHAR2;

END MOINFO_ATT;
/

CREATE OR REPLACE PACKAGE BODY MOINFO_ATT AS

    FUNCTION CAN_SEE (p_document_id IN NUMBER) RETURN VARCHAR2 IS
        l_scope      VARCHAR2(10);
        l_unit_id    NUMBER;
        l_created_by VARCHAR2(255);
        l_me         VARCHAR2(255) := UPPER(TRIM(V('APP_USER')));
    BEGIN
        l_scope := MOINFO_SEC.DATA_SCOPE('ATT');

        IF l_scope = 'ALL' THEN
            RETURN 'Y';
        ELSIF l_scope IS NULL THEN
            RETURN 'N';
        END IF;

        SELECT OWNER_UNIT_ID, CREATED_BY
          INTO l_unit_id, l_created_by
          FROM MOINFO_ATT_DOCUMENTS
         WHERE DOCUMENT_ID = p_document_id;

        IF UPPER(l_created_by) = l_me THEN
            RETURN 'Y';
        END IF;

        -- مستند بلا وحدة مالكة مرئي لكل من له صلاحية الوحدة
        IF l_scope = 'UNIT' THEN
            IF l_unit_id IS NULL THEN
                RETURN 'Y';
            END IF;
            RETURN MOINFO_SEC.CAN_SEE_UNIT('ATT', l_unit_id);
        END IF;

        RETURN 'N';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'N';
    END CAN_SEE;

END MOINFO_ATT;
/


-- 4) Views

-- المستندات مع آخر ملف مرفوع لكل مستند وعدد ملفاته
CREATE OR REPLACE VIEW MOINFO_ATT_V_DOCUMENTS AS
SELECT d.DOCUMENT_ID,
       d.CATEGORY_ID,
       cat.NAME_AR AS CATEGORY_AR,
       d.TITLE,
       d.DOCUMENT_DATE,
       d.OWNER_UNIT_ID,
       u.UNIT_PATH_AR AS OWNER_UNIT_AR,
       d.REMARKS,
       d.IS_ACTIVE,
       f.ATTACHMENT_ID AS LATEST_ATTACHMENT_ID,
       f.FILE_NAME     AS LATEST_FILE_NAME,
       f.FILE_SIZE_TEXT AS LATEST_FILE_SIZE,
       f.CREATED_AT    AS LATEST_UPLOADED_AT,
       NVL(fc.FILES_COUNT, 0) AS FILES_COUNT,
       d.CREATED_BY,
       d.CREATED_AT,
       d.UPDATED_BY,
       d.UPDATED_AT
  FROM MOINFO_ATT_DOCUMENTS d
  JOIN MOINFO_LOOKUPS cat     ON cat.LOOKUP_ID = d.CATEGORY_ID
  LEFT JOIN MOINFO_V_UNITS u  ON u.UNIT_ID = d.OWNER_UNIT_ID
  LEFT JOIN (SELECT ENTITY_ID,
                    ATTACHMENT_ID,
                    FILE_NAME,
                    FILE_SIZE_TEXT,
                    CREATED_AT,
                    ROW_NUMBER() OVER (PARTITION BY ENTITY_ID ORDER BY CREATED_AT DESC, ATTACHMENT_ID DESC) AS RN
               FROM MOINFO_V_ATTACHMENTS
              WHERE ENTITY_NAME = 'MOINFO_ATT_DOCUMENTS') f
         ON f.ENTITY_ID = d.DOCUMENT_ID
        AND f.RN = 1
  LEFT JOIN (SELECT ENTITY_ID, COUNT(*) AS FILES_COUNT
               FROM MOINFO_V_ATTACHMENTS
              WHERE ENTITY_NAME = 'MOINFO_ATT_DOCUMENTS'
              GROUP BY ENTITY_ID) fc
         ON fc.ENTITY_ID = d.DOCUMENT_ID;


-- 5) Triggers
BEGIN
    MOINFO_UTIL.CREATE_ALL_TRIGGERS('MOINFO\_ATT\_%');
END;
/


-- 6) التحقق
SELECT OBJECT_TYPE, OBJECT_NAME, STATUS
  FROM USER_OBJECTS
 WHERE (OBJECT_NAME LIKE 'MOINFO\_ATT%' ESCAPE '\'
        OR OBJECT_NAME IN ('MOINFO_FILES', 'MOINFO_V_ATTACHMENTS'))
   AND OBJECT_TYPE IN ('TABLE', 'PACKAGE', 'PACKAGE BODY', 'TRIGGER', 'VIEW')
 ORDER BY STATUS DESC, OBJECT_TYPE, OBJECT_NAME;
