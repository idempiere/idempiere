-- IDEMPIERE-6902  Configuring workflow per Document type
SELECT register_migration_script('202603301707_IDEMPIERE-6902.sql') FROM dual;

-- 30/03/2026 17:07:30 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217473,0,'Workflow','Workflow or combination of tasks','The Workflow field identifies a unique Workflow in the system.',217,'AD_Workflow_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-30 17:07:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 17:07:29','YYYY-MM-DD HH24:MI:SS'),100,144,'Y','N','D','N','N','N','Y','a6bbde52-0c7e-4da5-b543-00440bce4bf9','N',0,'N','N','C','N','N')
;

-- 30/03/2026 17:07:48 IST
UPDATE AD_Column SET FKConstraintName='ADWorkflow_CDocType', FKConstraintType='C',Updated=TO_TIMESTAMP('2026-03-30 17:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217473
;

-- 30/03/2026 17:07:48 IST
ALTER TABLE C_DocType ADD COLUMN AD_Workflow_ID NUMERIC(10) DEFAULT NULL 
;

-- 30/03/2026 17:07:48 IST
ALTER TABLE C_DocType ADD CONSTRAINT ADWorkflow_CDocType FOREIGN KEY (AD_Workflow_ID) REFERENCES ad_workflow(ad_workflow_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

-- 30/03/2026 17:10:29 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209079,'Workflow','Workflow or combination of tasks','The Workflow field identifies a unique Workflow in the system.',167,217473,'Y',22,480,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-30 17:10:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 17:10:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6acf31b9-5907-4e50-9b9e-0c0c1cb21a0c','Y',410,2)
;


