-- DateAct do not set from Journal in GL Journal Batch
-- 29-Jan-2022, 5:14:32 PM IST
UPDATE AD_Field SET DefaultValue='@1|DateAcct@', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-29 17:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1293
;


SELECT register_migration_script('202201300826_IDEMPIERE-5175.sql') FROM dual
;