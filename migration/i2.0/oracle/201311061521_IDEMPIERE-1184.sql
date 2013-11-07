SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 6, 2013 3:18:14 PM COT
-- IDEMPIERE-1184 Register browser information available on AD_Session
UPDATE AD_Column SET AD_Reference_ID=14,Updated=TO_DATE('2013-11-06 15:18:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54349
;

-- Nov 6, 2013 3:18:29 PM COT
UPDATE AD_Field SET NumLines=8,Updated=TO_DATE('2013-11-06 15:18:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54393
;

SELECT register_migration_script('201311061521_IDEMPIERE-1184.sql') FROM dual
;

