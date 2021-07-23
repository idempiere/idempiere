SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1994 Ability to organise process and report parameters by Field Group functionality
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213251,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','3bcbe6d5-bc98-4fde-b930-f45c3fc2e870',TO_DATE('2017-09-20 16:53:48','YYYY-MM-DD HH24:MI:SS'),'Y','AD_FieldGroup_ID','Logical grouping of fields','The Field Group indicates the logical group that this field belongs to (History, Amounts, Quantities)','Field Group','Y','Y',100,100,'N',0,0,TO_DATE('2017-09-20 16:53:48','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',1500,285,19,'N')
;

-- Sep 20, 2017 4:53:56 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200007, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200007)
;

-- Sep 20, 2017 4:53:57 PM SGT
UPDATE AD_Column SET FKConstraintName='ADFieldGroup_ADProcessPara', FKConstraintType='N',Updated=TO_DATE('2017-09-20 16:53:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213251
;

-- Sep 20, 2017 4:53:57 PM SGT
ALTER TABLE AD_Process_Para ADD AD_FieldGroup_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 20, 2017 4:53:58 PM SGT
ALTER TABLE AD_Process_Para ADD CONSTRAINT ADFieldGroup_ADProcessPara FOREIGN KEY (AD_FieldGroup_ID) REFERENCES ad_fieldgroup(ad_fieldgroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 20, 2017 4:55:11 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200008, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200008)
;

-- Sep 20, 2017 4:55:13 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205238,'N',22,'N','N',280,'Y','N','The Field Group indicates the logical group that this field belongs to (History, Amounts, Quantities)',0,TO_DATE('2017-09-20 16:55:12','YYYY-MM-DD HH24:MI:SS'),'Logical grouping of fields','Field Group','50a7d3df-4713-4f7e-b030-7256d0f14c0c','Y','N',100,100,'Y','Y',280,0,TO_DATE('2017-09-20 16:55:12','YYYY-MM-DD HH24:MI:SS'),2,213251,'D',246)
;

-- Sep 20, 2017 4:56:16 PM SGT
UPDATE AD_Field SET SeqNo=125, AD_Val_Rule_ID=NULL, SeqNoGrid=135, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-09-20 16:56:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205238
;

-- Jul 23, 2021, 11:03:55 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214564,0,'Field Group','Logical grouping of fields','The Field Group indicates the logical group that this field belongs to (History, Amounts, Quantities)',200233,'AD_FieldGroup_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-07-23 11:03:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-23 11:03:54','YYYY-MM-DD HH24:MI:SS'),100,1500,'Y','N','D','N','N','N','Y','5ba627b6-8511-4f2e-82ba-d7fbf6a8a2fd','Y',0,'N','N','N','N')
;

-- Jul 23, 2021, 11:04:09 AM MYT
UPDATE AD_Column SET FKConstraintName='ADFieldGroup_ADUserDefProcPara', FKConstraintType='N',Updated=TO_DATE('2021-07-23 11:04:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214564
;

-- Jul 23, 2021, 11:04:09 AM MYT
ALTER TABLE AD_UserDef_Proc_Parameter ADD AD_FieldGroup_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2021, 11:04:09 AM MYT
ALTER TABLE AD_UserDef_Proc_Parameter ADD CONSTRAINT ADFieldGroup_ADUserDefProcPara FOREIGN KEY (AD_FieldGroup_ID) REFERENCES ad_fieldgroup(ad_fieldgroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 23, 2021, 11:05:29 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206734,'Field Group','Logical grouping of fields','The Field Group indicates the logical group that this field belongs to (History, Amounts, Quantities)',200235,214564,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-23 11:05:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-23 11:05:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6a5df652-cd30-4f11-aa94-a66f14379cdb','Y',260,1,2,1,'N','N','N','N')
;

SELECT register_migration_script('202107230228_IDEMPIERE-1994.sql') FROM dual
;
