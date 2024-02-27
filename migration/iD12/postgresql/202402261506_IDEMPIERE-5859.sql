-- IDEMPIERE-5859
SELECT register_migration_script('202402261506_IDEMPIERE-5859.sql') FROM dual;

-- Feb 26, 2024, 3:06:26 PM CET
UPDATE AD_Column SET FieldLength=255, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-02-26 15:06:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8501
;

-- Feb 26, 2024, 3:06:29 PM CET
INSERT INTO t_alter_column values('m_attributeinstance','Value','VARCHAR(255)',null,'NULL')
;

-- Feb 26, 2024, 3:07:17 PM CET
UPDATE AD_Column SET FieldLength=1023, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-02-26 15:07:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8479
;

-- Feb 26, 2024, 3:07:19 PM CET
INSERT INTO t_alter_column values('m_attributesetinstance','Description','VARCHAR(1023)',null,'NULL')
;

