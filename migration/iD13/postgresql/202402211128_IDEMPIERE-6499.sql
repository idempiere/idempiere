-- Adding Approval Column into Node of Workflow
-- 21-Feb-2024, 11:28:12 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203920,0,0,'Y',TO_TIMESTAMP('2024-02-21 11:28:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-21 11:28:11','YYYY-MM-DD HH24:MI:SS'),100,'ApprovalColumn_ID','Approval Column','Specify the boolean type column which marked on approval','Approval Column','D','0e632229-e3f4-467a-aa0d-4b5cfa9854f6')
;

-- 21-Feb-2024, 11:29:28 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216566,0,'Approval Column','Specify the boolean type column which marked on approval',129,100,'ApprovalColumn_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-02-21 11:29:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-21 11:29:28','YYYY-MM-DD HH24:MI:SS'),100,203920,'Y','N','D','N','N','N','Y','42735284-f080-4223-beaf-1c1a9fbba3df','Y',0,'N','N','N')
;

-- 21-Feb-2024, 11:29:32 AM IST
ALTER TABLE AD_WF_Node ADD COLUMN ApprovalColumn_ID NUMERIC(10) DEFAULT NULL 
;

-- 21-Feb-2024, 11:29:46 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208471,'Approval Column','Specify the boolean type column which marked on approval',122,216566,'Y',22,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-02-21 11:29:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-21 11:29:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','07ccb5a0-28ab-4522-92f6-d1f043f1313f','Y',410,2)
;

-- 21-Feb-2024, 11:36:00 AM IST
UPDATE AD_Field SET SeqNo=185, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-02-21 11:36:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208471
;

-- 21-Feb-2024, 11:36:48 AM IST
UPDATE AD_Field SET DisplayLogic='@Action@=C', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=185, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-02-21 11:36:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208471
;

-- 21-Feb-2024, 11:38:39 AM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200266,'AD_Column - Approval Column','T',0,0,'Y',TO_TIMESTAMP('2024-02-21 11:38:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-21 11:38:38','YYYY-MM-DD HH24:MI:SS'),100,'D','N','3d5bfb69-0a13-4733-a046-0defb7803987')
;

-- 21-Feb-2024, 11:40:33 AM IST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200266,101,109,111,'',0,0,'Y',TO_TIMESTAMP('2024-02-21 11:40:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-21 11:40:33','YYYY-MM-DD HH24:MI:SS'),100,'N','D','96002bc9-a73a-4dfe-9aad-7e29ec9f7892')
;

-- 21-Feb-2024, 11:41:01 AM IST
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=200266,Updated=TO_TIMESTAMP('2024-02-21 11:41:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216566
;

-- 21-Feb-2024, 11:41:06 AM IST
UPDATE AD_Column SET FKConstraintName='ApprovalColumn_ADWFNode', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-02-21 11:41:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216566
;

-- 21-Feb-2024, 11:41:06 AM IST
ALTER TABLE AD_WF_Node ADD CONSTRAINT ApprovalColumn_ADWFNode FOREIGN KEY (ApprovalColumn_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('202402211128_IDEMPIERE-6499.sql') FROM dual
;
