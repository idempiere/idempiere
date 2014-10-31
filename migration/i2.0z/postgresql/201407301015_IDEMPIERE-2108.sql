-- Jul 30, 2014 10:11:38 AM CEST
-- IDEMPIERE-2108 add an option for a minimum amount to create invoices process
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,Created) VALUES ('N',200107,'5dd9e63d-e70d-41c4-97ea-e6bb37015368',119,'N','D','Minimum Amt','MinimumAmt','Minimum Amount in Document Currency',22,'Y',60,'Y',100,TO_TIMESTAMP('2014-07-30 10:11:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,2177,12,TO_TIMESTAMP('2014-07-30 10:11:37','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201407301015_IDEMPIERE-2108.sql') FROM dual
;

