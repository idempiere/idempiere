-- IDEMPIERE-2981 - Implement JSON Field type
SELECT register_migration_script('202402261354_IDEMPIERE-2981.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 26, 2024, 1:54:35 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203924,0,0,'Y',TO_TIMESTAMP('2024-02-26 13:54:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-26 13:54:35','YYYY-MM-DD HH24:MI:SS'),100,'JsonData','JSON Data','The json field stores json data.','JSON Data','D','c4ea7a81-96a9-4a5d-bb87-e913e1c8ed48')
;

-- Feb 26, 2024, 1:55:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216570,0,'JSON Data','The json field stores json data.',135,'JsonData',0,'N','N','N','N','N',0,'N',200267,0,0,'Y',TO_TIMESTAMP('2024-02-26 13:55:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-26 13:55:36','YYYY-MM-DD HH24:MI:SS'),100,203924,'Y','N','D','N','N','N','Y','927b83df-d161-4332-ad44-8ffed99e8cf4','Y',0,'N','N','N','N')
;

-- Feb 28, 2024, 5:41:55 PM CET
ALTER TABLE Test ADD JsonData CLOB DEFAULT NULL CONSTRAINT test_jsondata_ij CHECK (JsonData IS JSON)
;

-- Feb 26, 2024, 1:56:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208472,'JSON Data','The json field stores json data.',152,216570,'Y',100,310,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-02-26 13:56:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-26 13:56:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e47ef529-71ba-4f9b-9014-b188e17e8ef4','Y',290,5)
;

-- Feb 29, 2024, 1:52:50 PM CET
UPDATE AD_Field SET NumLines=5,Updated=TO_TIMESTAMP('2024-02-29 13:52:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208472
;

-- Feb 29, 2024, 2:07:30 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invalid JSON',0,0,'Y',TO_TIMESTAMP('2024-02-29 14:07:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-29 14:07:30','YYYY-MM-DD HH24:MI:SS'),100,200876,'InvalidJSON','D','a263376f-a12e-4943-92f1-7d7ce8a67a2b')
;

