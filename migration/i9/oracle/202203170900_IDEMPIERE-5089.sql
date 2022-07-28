SELECT register_migration_script('202203170900_IDEMPIERE-5089.sql') FROM dual
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5089 Add MSysConfig.ALLOW_REVERSAL_OF_RECONCILED_PAYMENT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Updated,Value,AD_SysConfig_UU,IsActive,Name,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID) VALUES (200087,'D','C',TO_DATE('2022-03-17 17:52:01','YYYY-MM-DD HH24:MI:SS'),'Y','3c4b2107-ee12-44f4-9adb-1a4acbdac692','Y','ALLOW_REVERSAL_OF_RECONCILED_PAYMENT',TO_DATE('2022-03-17 17:52:01','YYYY-MM-DD HH24:MI:SS'),0,100,100,0)
;

-- Mar 17, 2022 6:03:46 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Updated,Value,IsActive,CreatedBy,AD_Org_ID,AD_Client_ID,Created,UpdatedBy,EntityType) VALUES ('E','You can''t reverse a payment that have been reconciled',200415,'667a6f6d-9a96-4519-a576-03e606101d08',TO_DATE('2022-03-17 18:03:45','YYYY-MM-DD HH24:MI:SS'),'NotAllowReversalOfReconciledPayment','Y',100,0,0,TO_DATE('2022-03-17 18:03:45','YYYY-MM-DD HH24:MI:SS'),100,'D')
;

-- Mar 17, 2022, 6:19:51 PM MYT
UPDATE AD_SysConfig SET Description='Y/N - Define if user is allow to reverse a payment that have been reconciled',Updated=TO_TIMESTAMP('2022-03-17 18:19:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200087
;

