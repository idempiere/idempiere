-- IDEMPIERE-1575 Increase some columns length
-- Dec 18, 2020, 4:37:11 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2020-12-18 16:40:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54257
;

-- Dec 18, 2020, 4:40:26 PM CET
INSERT INTO t_alter_column values('ad_rule','Script','VARCHAR(4000)',null,'NULL')
;

-- Dec 18, 2020, 4:41:04 PM CET
UPDATE AD_Column SET FieldLength=1000, SeqNoSelection=10,Updated=TO_TIMESTAMP('2020-12-18 16:41:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13024
;

-- Dec 18, 2020, 4:41:09 PM CET
INSERT INTO t_alter_column values('ad_changelog','TrxName','VARCHAR(1000)',null,'NULL')
;

-- Dec 18, 2020, 4:41:40 PM CET
UPDATE AD_Column SET FieldLength=4000, SeqNoSelection=10,Updated=TO_TIMESTAMP('2020-12-18 16:41:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50196
;

-- Dec 18, 2020, 4:41:46 PM CET
INSERT INTO t_alter_column values('ad_sysconfig','Value','VARCHAR(4000)',null,null)
;

SELECT register_migration_script('202012181642_IDEMPIERE-1575.sql') FROM dual
;

