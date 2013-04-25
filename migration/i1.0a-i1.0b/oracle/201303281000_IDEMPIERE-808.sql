-- Mar 28, 2013 5:57:29 PM MYT
-- IDEMPIERE-808 Organization Type window - new record allows user to select System Client
UPDATE AD_Column SET AD_Val_Rule_ID=116,Updated=TO_DATE('2013-03-28 17:57:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11270
;

SELECT register_migration_script('201303281000_IDEMPIERE-808.sql') FROM dual
;

