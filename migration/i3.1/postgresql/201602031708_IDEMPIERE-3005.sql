-- IDEMPIERE-3005 Copy view and view components
-- Feb 1, 2016 4:04:17 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Target table must not have view components',0,0,'Y',TO_TIMESTAMP('2016-02-01 16:04:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-02-01 16:04:16','YYYY-MM-DD HH24:MI:SS'),100,200397,'ErrorCopyView','D','9e9efdf9-cafd-4857-b4d5-37055b0d0786')
;

-- Feb 1, 2016 4:28:54 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202975,0,0,'Y',TO_TIMESTAMP('2016-02-01 16:28:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-02-01 16:28:53','YYYY-MM-DD HH24:MI:SS'),100,'CopyComponentsFromView','Copy Components From View','Copy Components From View','D','667adbfe-8e70-450b-9c45-e042c12f518a')
;

-- Feb 1, 2016 4:30:59 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200086,0,0,'Y',TO_TIMESTAMP('2016-02-01 16:30:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-02-01 16:30:59','YYYY-MM-DD HH24:MI:SS'),100,'Copy Components From View','Create dictionary view components for a table taking another as base','N','AD_Table_CopyComponentsFromView','N','org.compiere.process.CopyComponentsFromView','4','D',0,0,'N','N','Y','N','ebc55ee4-a02a-4505-9063-ae687e37ed6c')
;

-- Feb 1, 2016 4:32:56 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200155,0,0,'Y',TO_TIMESTAMP('2016-02-01 16:32:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-02-01 16:32:56','YYYY-MM-DD HH24:MI:SS'),100,'Table','Database Table information','The Database Table provides the information of the table definition',200086,10,19,'N',0,'Y','AD_Table_ID','Y','D',126,'ce32a1c1-2820-4610-ac00-109ed3ac5b03','N')
;

-- Feb 1, 2016 4:33:43 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212637,0,'Copy Components From View',100,'CopyComponentsFromView',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2016-02-01 16:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-02-01 16:33:42','YYYY-MM-DD HH24:MI:SS'),100,202975,'Y',200086,'N','D','N','N','N','Y','c9a6c992-0cac-4559-b3e3-b9981cb5db4f','Y',0,'Y','N')
;

-- Feb 1, 2016 4:33:49 PM CET
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200004, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200004)
;

-- Feb 1, 2016 4:33:49 PM CET
ALTER TABLE AD_Table ADD COLUMN CopyComponentsFromView CHAR(1) DEFAULT NULL 
;

-- Feb 1, 2016 4:34:53 PM CET
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200005, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200005)
;

-- Feb 1, 2016 4:34:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204137,'Copy Components From View',100,212637,'Y',1,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-02-01 16:34:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-02-01 16:34:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','063d15a1-b7df-4f27-8d37-23360fae8f83','Y',190,2,2)
;

-- Feb 1, 2016 4:35:53 PM CET
UPDATE AD_Field SET DisplayLogic='@IsView@=''Y''',Updated=TO_TIMESTAMP('2016-02-01 16:35:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204137
;

-- Feb 3, 2016 5:06:14 PM CET
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200088,'AD_Table is View','S','AD_Table.IsView=''Y''',0,0,'Y',TO_TIMESTAMP('2016-02-03 17:06:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-02-03 17:06:14','YYYY-MM-DD HH24:MI:SS'),100,'D','84fba66f-4489-4993-8ea9-84fec646dd42')
;

-- Feb 3, 2016 5:06:28 PM CET
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200088,Updated=TO_TIMESTAMP('2016-02-03 17:06:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200155
;

SELECT register_migration_script('201602031708_IDEMPIERE-3005.sql') FROM dual
;

