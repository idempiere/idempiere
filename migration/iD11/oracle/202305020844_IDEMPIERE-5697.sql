-- IDEMPIERE-5697
-- add PInstanceLogType to AD_PInstance_Log
SELECT register_migration_script('202305020844_IDEMPIERE-5697.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 2, 2023, 8:44:21 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203809,0,0,'Y',TO_TIMESTAMP('2023-05-02 08:44:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-02 08:44:21','YYYY-MM-DD HH24:MI:SS'),100,'PInstanceLogType','Log Type','Process Audit Log Type','Log Type','D','7925b5b3-a3ae-434c-9d72-f9f55f97c44e')
;

-- May 2, 2023, 8:45:02 AM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200242,'AD_PInstance PInstanceLogType','L',0,0,'Y',TO_TIMESTAMP('2023-05-02 08:45:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-02 08:45:02','YYYY-MM-DD HH24:MI:SS'),100,'D','N','6a5f9e08-d4c5-4724-a9dc-8e981e734eaa','N')
;

-- May 2, 2023, 8:46:13 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200637,'Status','Shows the current status of a process metric, e.g. progress in percents.',200242,'S',0,0,'Y',TO_TIMESTAMP('2023-05-02 08:46:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-02 08:46:13','YYYY-MM-DD HH24:MI:SS'),100,'D','c168a678-1b2b-4fe2-9270-8aeb29b635c3')
;

-- May 2, 2023, 8:47:11 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200638,'Progress','Logs, that are created continuously during the execution of the process.',200242,'P',0,0,'Y',TO_TIMESTAMP('2023-05-02 08:47:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-02 08:47:11','YYYY-MM-DD HH24:MI:SS'),100,'D','2cc965b7-abf2-413a-930e-eff43afd5f81')
;

-- May 2, 2023, 8:47:50 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200639,'Result','Logs created after the process is executed.',200242,'R',0,0,'Y',TO_TIMESTAMP('2023-05-02 08:47:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-02 08:47:49','YYYY-MM-DD HH24:MI:SS'),100,'D','aadce9f4-214c-4c52-b89d-d2696649172b')
;

-- May 2, 2023, 8:47:56 AM CEST
UPDATE AD_Ref_List SET Description='Logs created continuously during the execution of the process.',Updated=TO_TIMESTAMP('2023-05-02 08:47:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200638
;

-- May 2, 2023, 8:48:39 AM CEST
UPDATE AD_Reference SET Name='AD_PInstance_Log PInstanceLogType',Updated=TO_TIMESTAMP('2023-05-02 08:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200242
;

-- May 2, 2023, 8:49:30 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215837,0,'Log Type','Process Audit Log Type',578,'PInstanceLogType',3,'N','N','N','N','N',0,'N',17,200242,0,0,'Y',TO_TIMESTAMP('2023-05-02 08:49:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-02 08:49:30','YYYY-MM-DD HH24:MI:SS'),100,203809,'Y','N','D','N','N','N','Y','066ccbf0-3e44-407a-bdc0-d8b0ae888998','Y',0,'N','N','N')
;

-- May 2, 2023, 8:49:50 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207622,'Log Type','Process Audit Log Type',665,215837,'Y',3,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-05-02 08:49:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-02 08:49:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ba79279a-3101-45e7-86f5-17b6ef3991d5','Y',90,2)
;

-- May 2, 2023, 9:10:25 AM CEST
ALTER TABLE AD_PInstance_Log ADD PInstanceLogType VARCHAR2(3 CHAR) DEFAULT 'R' 
;

-- May 15, 2023, 10:36:39 AM CEST
UPDATE AD_Column SET IsKey='N',Updated=TO_TIMESTAMP('2023-05-15 10:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8779
;

-- May 15, 2023, 10:42:19 AM CEST
UPDATE AD_Column SET AD_Reference_ID=11,Updated=TO_TIMESTAMP('2023-05-15 10:42:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8779
;

-- May 15, 2023, 10:49:33 AM CEST
UPDATE AD_TableIndex SET Name='ad_pinstance_log_uu', IsKey='Y',Updated=TO_TIMESTAMP('2023-05-15 10:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=200138
;

-- May 15, 2023, 10:49:54 AM CEST
ALTER TABLE AD_PInstance_Log DROP CONSTRAINT ad_pinstance_log_uu_idx CASCADE
;

-- May 15, 2023, 10:49:54 AM CEST
ALTER TABLE AD_PInstance_Log DROP PRIMARY KEY
;

-- May 15, 2023, 10:50:19 AM CEST
ALTER TABLE AD_PInstance_Log ADD CONSTRAINT ad_pinstance_log_uu UNIQUE (AD_PInstance_Log_UU)
;

-- May 15, 2023, 3:03:52 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201246,'f348e791-5d5e-40f2-89bd-7f8be0850217',TO_TIMESTAMP('2023-05-15 15:03:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_pinstance_id_log_id',TO_TIMESTAMP('2023-05-15 15:03:52','YYYY-MM-DD HH24:MI:SS'),100,578,'Y','Y','N','N')
;

-- May 15, 2023, 3:04:03 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201684,'ecebad1f-2b24-4cae-afbf-dfed57ed4071',TO_TIMESTAMP('2023-05-15 15:04:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-15 15:04:03','YYYY-MM-DD HH24:MI:SS'),100,8780,201246,10)
;

-- May 15, 2023, 3:04:08 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201685,'b83c67d5-260d-4b8a-9978-3bd823ecedb5',TO_TIMESTAMP('2023-05-15 15:04:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-15 15:04:07','YYYY-MM-DD HH24:MI:SS'),100,8779,201246,20)
;

-- May 15, 2023, 3:04:13 PM CEST
ALTER TABLE AD_PInstance_Log ADD CONSTRAINT ad_pinstance_id_log_id UNIQUE (AD_PInstance_ID,Log_ID)
;

-- May 29, 2023, 12:06:17 PM CEST
UPDATE AD_Column SET DefaultValue='R',Updated=TO_TIMESTAMP('2023-05-29 12:06:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215837
;

