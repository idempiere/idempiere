-- IDEMPIERE-4863
SELECT register_migration_script('202205021837_IDEMPIERE-4863.sql') FROM dual;

-- May 2, 2022, 6:37:46 PM CEST
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2022-05-02 18:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214540
;

-- May 2, 2022, 6:37:47 PM CEST
INSERT INTO t_alter_column values('ad_wlistbox_customization','Custom','VARCHAR(4000)',null,null)
;

