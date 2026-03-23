-- IDEMPIERE-6712 Improve algorithm for password salt (DAD-103)
SELECT register_migration_script('202510301124_IDEMPIERE-6712.sql') FROM dual;

-- Oct 30, 2025, 11:24:10 AM CET
UPDATE AD_Column SET FieldLength=32,Updated=TO_TIMESTAMP('2025-10-30 11:24:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213175
;

-- Oct 30, 2025, 11:24:23 AM CET
UPDATE AD_Column SET FieldLength=32,Updated=TO_TIMESTAMP('2025-10-30 11:24:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212110
;

-- Oct 30, 2025, 11:24:29 AM CET
UPDATE AD_Column SET FieldLength=32,Updated=TO_TIMESTAMP('2025-10-30 11:24:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=61756
;

-- Oct 30, 2025, 11:24:40 AM CET
INSERT INTO t_alter_column values('ad_password_history','Salt','VARCHAR(32)',null,'NULL')
;

-- Oct 30, 2025, 11:24:46 AM CET
INSERT INTO t_alter_column values('ad_user','Salt','VARCHAR(32)',null,'NULL')
;

