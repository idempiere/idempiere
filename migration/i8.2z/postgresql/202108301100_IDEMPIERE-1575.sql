-- IDEMPIERE-1575 with regards to IDEMPIERE-4724
-- 31.08.2021, 08:57:56 MESZ
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2021-08-31 08:57:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4704
;

-- 31.08.2021, 08:58:02 MESZ
INSERT INTO t_alter_column values('ad_impformat_row','Callout','VARCHAR(4000)',null,'NULL')
;

SELECT register_migration_script('202108301100_IDEMPIERE-1575.sql') FROM dual
;
