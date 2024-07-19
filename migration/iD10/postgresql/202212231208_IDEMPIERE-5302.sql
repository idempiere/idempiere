-- IDEMPIERE-5302 Drill Assistant Feature + IDEMPIERE-5523
SELECT register_migration_script('202212231208_IDEMPIERE-5302.sql') FROM dual;

-- Dec 23, 2022, 12:08:41 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-12-23 12:08:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214730
;

-- Dec 23, 2022, 12:08:43 PM CET
INSERT INTO t_alter_column values('ad_process_drillrule','Name','VARCHAR(255)',null,null)
;

