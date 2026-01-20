-- IDEMPIERE-6815
SELECT register_migration_script('202601130707_IDEMPIERE-6815.sql') FROM dual;

-- Jan 13, 2026, 7:07:15 AM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-01-13 07:07:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=4607
;

-- Jan 13, 2026, 7:07:16 AM CET
INSERT INTO t_alter_column values('ad_form','Classname','VARCHAR(255)',null,'NULL')
;

-- Jan 13, 2026, 7:07:43 AM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-01-13 07:07:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=10776
;

-- Jan 13, 2026, 7:07:44 AM CET
INSERT INTO t_alter_column values('c_bankstatementmatcher','Classname','VARCHAR(255)',null,null)
;

-- Jan 13, 2026, 7:07:57 AM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-01-13 07:07:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=12684
;

-- Jan 13, 2026, 7:07:57 AM CET
INSERT INTO t_alter_column values('pa_sla_criteria','Classname','VARCHAR(255)',null,'NULL')
;

