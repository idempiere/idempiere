SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 26, 2013 12:22:23 PM MYT
-- IDEMPIERE-1644 Length 22 for AD_PrintFormatItem.FormatPattern is too short
UPDATE AD_Column SET FieldLength=60,Updated=TO_DATE('2013-12-26 12:22:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56351
;

-- Dec 26, 2013 12:22:34 PM MYT
-- IDEMPIERE-1644 Length 22 for AD_PrintFormatItem.FormatPattern is too short
ALTER TABLE AD_PrintFormatItem MODIFY FormatPattern VARCHAR2(60) DEFAULT NULL 
;

SELECT register_migration_script('201312260552_IDEMPIERE-1644.sql') FROM dual
;

