-- IDEMPIERE-2716 Bank Register Report - add Bank Account Parameter
-- Jul 7, 2015 10:28:19 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200082,'C_BankAccount by Bank','S','C_BankAccount.C_Bank_ID=@C_Bank_ID@',0,0,'Y',TO_TIMESTAMP('2015-07-07 10:28:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-07-07 10:28:18','YYYY-MM-DD HH24:MI:SS'),100,'C','923bb7a8-b071-4f8a-85de-794e06e43490')
;

-- Jul 7, 2015 10:28:27 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200139,0,0,'Y',TO_TIMESTAMP('2015-07-07 10:28:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-07-07 10:28:26','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200035,15,19,'N',200082,10,'N','C_BankAccount_ID','Y','D',836,'c852e4f4-417c-4955-b1ec-26d73d79b81c','N')
;

SELECT register_migration_script('201512121213_IDEMPIERE-2716.sql') FROM dual
;

