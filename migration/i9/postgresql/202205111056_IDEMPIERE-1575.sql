-- IDEMPIERE-1575
SELECT register_migration_script('202205111056_IDEMPIERE-1575.sql') FROM dual;

-- May 11, 2022, 10:56:45 AM CEST
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2022-05-11 10:56:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14922
;

-- May 11, 2022, 10:56:47 AM CEST
INSERT INTO t_alter_column values('ad_system','ProfileInfo','VARCHAR(4000)',null,'NULL')
;

