-- IDEMPIERE-7213 - Allow creation of View Components from an existing Database View (reverse of DatabaseViewValidate)
SELECT register_migration_script('202611191451_IDEMPIERE-7213.sql') FROM dual;

-- Nov 19, 2026, 2:51:19 PM CET
UPDATE AD_Field SET NumLines=2,Updated=TO_TIMESTAMP('2026-11-19 14:51:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206665
;

-- Nov 19, 2026, 2:51:55 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2026-11-19 14:51:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210547
;

-- Nov 19, 2026, 2:51:57 PM CET
INSERT INTO t_alter_column values('ad_indexcolumn','ColumnSQL','VARCHAR(4000)',null,'NULL')
;

-- Nov 19, 2026, 2:52:09 PM CET
UPDATE AD_Field SET NumLines=2,Updated=TO_TIMESTAMP('2026-11-19 14:52:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202219
;

-- Nov 19, 2026, 2:52:26 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2026-11-19 14:52:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210586
;

-- Nov 19, 2026, 2:52:27 PM CET
INSERT INTO t_alter_column values('ad_viewcolumn','ColumnSQL','VARCHAR(4000)',null,'NULL')
;

-- Nov 19, 2026, 2:52:42 PM CET
UPDATE AD_Field SET NumLines=2,Updated=TO_TIMESTAMP('2026-11-19 14:52:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202247
;

