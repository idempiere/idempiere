-- Feb 11, 2014 2:29:31 AM ICT
-- IDEMPIERE-1606:initial client testing > email improvements
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Process_ID) VALUES ('N',200074,'a9304d73-8f35-487a-a020-fd24c98bb9db',10,'N','D','Administrative User Email','AdminUserEmail',60,'N',45,NULL,'Y',100,TO_TIMESTAMP('2014-02-11 02:29:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-02-11 02:29:30','YYYY-MM-DD HH24:MI:SS'),0,'N',0,53161)
;

-- Feb 11, 2014 2:32:28 AM ICT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Process_ID) VALUES ('N',200075,'422bd18a-9354-4bb6-9fcd-9c7be9985f9a',10,'N','D','Normal User Email','NormalUserEmail',60,'N',55,NULL,'Y',100,TO_TIMESTAMP('2014-02-11 02:32:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-02-11 02:32:28','YYYY-MM-DD HH24:MI:SS'),0,'N',0,53161)
;

SELECT register_migration_script('201402111604-IDEMPIERE-1606.sql') FROM dual
;
