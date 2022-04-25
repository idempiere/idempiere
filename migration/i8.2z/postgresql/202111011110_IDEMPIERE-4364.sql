-- IDEMPIERE-4364 Advanced Search - Allow select column from window tabs
-- Nov 1, 2021, 11:09:11 AM CET
UPDATE AD_Column SET FieldLength=4000, AD_Reference_ID=10,Updated=TO_TIMESTAMP('2021-11-01 11:09:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14361
;

-- Nov 1, 2021, 11:09:14 AM CET
INSERT INTO t_alter_column values('ad_userquery','Code','VARCHAR(4000)',null,'NULL')
;

SELECT register_migration_script('202111011110_IDEMPIERE-4364.sql') FROM dual
;
