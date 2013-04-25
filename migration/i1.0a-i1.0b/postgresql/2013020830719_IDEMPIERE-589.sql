-- Feb 8, 2013 4:58:19 PM COT
--  
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,AD_Val_Rule_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',287,200050,'c0dce1df-786b-44cc-b78f-408e2d1bed5a','You find the current status in the Document Status field. The options are listed in a popup',219,17,219,'N',135,'D','Action','DocAction','The targeted status of the document',1,'Y',35,'PR','Y',0,TO_TIMESTAMP('2013-02-07 11:41:38','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-02-07 11:39:00','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Feb 8, 2013 4:58:19 PM COT
--  
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200050 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Feb 14, 2013 12:49:13 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_WorkflowProcessor SET DateNextRun=TO_TIMESTAMP('2013-02-14 14:49:13','YYYY-MM-DD HH24:MI:SS'), DateLastRun=TO_TIMESTAMP('2013-02-14 12:49:13','YYYY-MM-DD HH24:MI:SS'),Updated=TO_TIMESTAMP('2013-02-14 12:49:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WorkflowProcessor_ID=100
;

-- Feb 14, 2013 12:49:13 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET AD_Val_Rule_ID=52027, DefaultValue=NULL,Updated=TO_TIMESTAMP('2013-02-14 12:49:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200050
;

-- Feb 14, 2013 12:49:46 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=110,Updated=TO_TIMESTAMP('2013-02-14 12:49:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53378
;

-- Feb 14, 2013 12:49:49 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=100,Updated=TO_TIMESTAMP('2013-02-14 12:49:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53377
;

-- Feb 14, 2013 12:49:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=90,Updated=TO_TIMESTAMP('2013-02-14 12:49:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53376
;

-- Feb 14, 2013 12:49:58 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=80,Updated=TO_TIMESTAMP('2013-02-14 12:49:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53375
;

-- Feb 14, 2013 12:50:02 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=70,Updated=TO_TIMESTAMP('2013-02-14 12:50:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53374
;

-- Feb 14, 2013 12:50:06 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=60,Updated=TO_TIMESTAMP('2013-02-14 12:50:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=327
;

-- Feb 14, 2013 12:50:10 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=50,Updated=TO_TIMESTAMP('2013-02-14 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=337
;

-- Feb 14, 2013 12:50:14 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET SeqNo=40,Updated=TO_TIMESTAMP('2013-02-14 12:50:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200050
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Element SET Name='Document Action',Updated=TO_TIMESTAMP('2013-02-14 13:26:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=287
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=287
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Column SET ColumnName='DocAction', Name='Document Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Element_ID=287
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET ColumnName='DocAction', Name='Document Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup', AD_Element_ID=287 WHERE UPPER(ColumnName)='DOCACTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Process_Para SET ColumnName='DocAction', Name='Document Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Element_ID=287 AND IsCentrallyMaintained='Y'
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_InfoColumn SET ColumnName='DocAction', Name='Document Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Element_ID=287 AND IsCentrallyMaintained='Y'
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_Field SET Name='Document Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=287) AND IsCentrallyMaintained='Y'
;

-- Feb 14, 2013 1:26:53 PM COT
-- IDEMPIERE-589 Add DocAction to Import Inventory
UPDATE AD_PrintFormatItem SET PrintName='Doc Action', Name='Document Action' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=287)
;

SELECT register_migration_script('2013020830719_IDEMPIERE-589.sql') FROM dual
;
