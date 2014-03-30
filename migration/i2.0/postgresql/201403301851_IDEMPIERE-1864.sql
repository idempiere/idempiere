-- Mar 30, 2014 6:50:49 PM COT
-- IDEMPIERE-1864 Allow negative tax rate
UPDATE AD_Column SET ValueMin=NULL,Updated=TO_TIMESTAMP('2014-03-30 18:50:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3693
;

SELECT register_migration_script('201403301851_IDEMPIERE-1864.sql') FROM dual
;

