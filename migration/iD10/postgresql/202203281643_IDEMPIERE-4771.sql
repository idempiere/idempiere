-- IDEMPIERE-4771_fixMessage
SELECT register_migration_script('202203281643_IDEMPIERE-4771.sql') FROM dual;

-- Mar 28, 2022, 4:43:24 PM CEST
UPDATE AD_Message SET Value='UploadSuccess',Updated=TO_TIMESTAMP('2022-03-28 16:43:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200679
;

