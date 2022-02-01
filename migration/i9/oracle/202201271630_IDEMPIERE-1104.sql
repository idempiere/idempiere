SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1104
-- Jan 27, 2022, 4:33:43 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The date on line {0} is not in the same period as header''''s date',0,0,'Y',TO_DATE('2022-01-27 16:33:43','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-27 16:33:43','YYYY-MM-DD HH24:MI:SS'),0,200725,'BankStatementLinePeriodNotSameAsHeader','D','2d919960-34f1-4ef4-a159-f0ae40e4d3bc')
;

-- Jan 27, 2022, 4:34:08 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200192,0,0,TO_DATE('2022-01-27 16:34:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-01-27 16:34:07','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','BANK_STATEMENT_POST_WITH_DATE_FROM_LINE','N','Setting it to Y can lead to potential issues if a bank statement cover several periods (see https://idempiere.atlassian.net/browse/IDEMPIERE-480 and https://idempiere.atlassian.net/browse/IDEMPIERE-1104)','D','C','2c5f249e-2e08-4e02-a390-f7573443e0fe')
;

SELECT register_migration_script('202201271630_IDEMPIERE-1104.sql') FROM dual
;
