-- May 19, 2018 11:01:06 PM CEST
-- IDEMPIERE-3716 Extend the length of the Column SQL field in AD_ViewColumn to allow more advanced queries	
UPDATE AD_Column SET FieldLength=2000,Updated=TO_TIMESTAMP('2018-05-19 23:01:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210586
;

-- May 21, 2018 1:37:18 PM CEST
INSERT INTO t_alter_column values('ad_viewcolumn','ColumnSQL','VARCHAR(2000)',null,'NULL')
;

SELECT register_migration_script('201805200007_IDEMPIERE-3716.sql') FROM dual
;
