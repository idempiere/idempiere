-- Adding Override User field to Workflow Responsible User from Client Side
-- 02-Feb-2024, 8:59:49 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203907,0,0,'Y',TO_TIMESTAMP('2024-02-02 20:59:48','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2024-02-02 20:59:48','YYYY-MM-DD HH24:MI:SS'),0,'Override_ID','Overridden WF Responsible','Overridden WF Responsible','D','6c2430de-745a-4894-80da-42118699f186')
;

-- 02-Feb-2024, 9:00:43 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200265,'AD_WF_Responsible','T',0,0,'Y',TO_TIMESTAMP('2024-02-02 21:00:42','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2024-02-02 21:00:42','YYYY-MM-DD HH24:MI:SS'),0,'D','N','87e21ecf-cbf6-4034-b06d-2876f1c0c080')
;

-- 02-Feb-2024, 9:01:14 PM IST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200265,646,10483,10475,'AD_WF_Responsible.AD_Client_ID=0',0,0,'Y',TO_TIMESTAMP('2024-02-02 21:01:14','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2024-02-02 21:01:14','YYYY-MM-DD HH24:MI:SS'),0,'N','D','b4f0db4c-438d-43d9-bafa-316306726ded')
;

-- 02-Feb-2024, 9:01:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216473,0,'Overridden WF Responsible',646,'Override_ID',10,'N','N','N','N','N',0,'N',30,200265,0,0,'Y',TO_TIMESTAMP('2024-02-02 21:01:24','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2024-02-02 21:01:24','YYYY-MM-DD HH24:MI:SS'),0,203907,'Y','N','D','N','N','N','Y','59aa0e57-6c6d-4cd0-a2df-420f9bde9783','Y',0,'N','N','N','N')
;

-- 02-Feb-2024, 9:01:29 PM IST
UPDATE AD_Column SET FKConstraintName='Override_ADWFResponsible', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-02-02 21:01:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=216473
;

-- 02-Feb-2024, 9:01:29 PM IST
ALTER TABLE AD_WF_Responsible ADD COLUMN Override_ID NUMERIC(10) DEFAULT NULL 
;

-- 02-Feb-2024, 9:01:29 PM IST
ALTER TABLE AD_WF_Responsible ADD CONSTRAINT Override_ADWFResponsible FOREIGN KEY (Override_ID) REFERENCES ad_wf_responsible(ad_wf_responsible_id) DEFERRABLE INITIALLY DEFERRED
;

-- 02-Feb-2024, 9:01:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208378,'Overridden WF Responsible',578,216473,'Y',10,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-02-02 21:01:56','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2024-02-02 21:01:56','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','6500cf64-5099-4cc8-9e2a-9b13e5842910','Y',110,2)
;

-- 02-Feb-2024, 9:02:24 PM IST
UPDATE AD_Field SET DisplayLogic='@#AD_Client_ID@>0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-02-02 21:02:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=208378
;

-- 21-Nov-2024, 4:22:37 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The workflow configuration is incomplete, the responsible "{0}" must be overridden in tenant',0,0,'Y',TO_TIMESTAMP('2024-11-21 16:22:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-21 16:22:36','YYYY-MM-DD HH24:MI:SS'),100,200912,'IncompeteWorkflowResponsible','D','d8ef68ec-492c-4ee1-87a1-da65413197ce')
;

SELECT register_migration_script('202402020915_IDEMPIERE-6028.sql') FROM dual
;