-- Apr 18, 2013 11:58:53 AM SGT
-- Ticket #1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET IsActive='N',Updated=TO_DATE('2013-04-18 11:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200060
;

-- Apr 18, 2013 11:59:39 AM SGT
-- Ticket #1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID) VALUES ('Y',263,200066,'953cd99e-3a51-4597-b156-31951d313c68','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200037,15,'N','D','Account Date','DateAcct','Accounting Date',0,'Y',60,'Y',100,TO_DATE('2013-04-18 11:59:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-04-18 11:59:38','YYYY-MM-DD HH24:MI:SS'),0,'N',0)
;

-- Apr 18, 2013 11:59:39 AM SGT
-- Ticket #1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

SELECT register_migration_script('201304181211_TICKET-1001763_FactView.sql') FROM dual
;