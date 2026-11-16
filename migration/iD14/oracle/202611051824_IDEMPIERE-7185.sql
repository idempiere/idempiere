-- IDEMPIERE-7185 Performance: Implement lazy Generation of DocumentNo from Sequence
SELECT register_migration_script('202611051824_IDEMPIERE-7185.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 5, 2026, 6:24:58 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200338,0,0,TO_TIMESTAMP('2026-11-05 18:24:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-11-05 18:24:57','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','LAZY_GENERATE_DOCUMENTNO_FROM_SEQUENCE','N','Defer generation of DocumentNo from sequence to transaction pre-commit (Y/N, default N)','D','C','01a1ab3d-84fb-73d4-92fb-58e73fa2e9ba')
;

-- Nov 5, 2026, 6:32:19 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204135,0,0,'Y',TO_TIMESTAMP('2026-11-05 18:32:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-05 18:32:19','YYYY-MM-DD HH24:MI:SS'),100,'IsLazyGenerateDocNo','Lazy Generate Document No','Defer generation of Document No from sequence until transaction pre-commit','When set to Yes, saving a new document assigns a temporary Document No and defers generating the actual Document No from the sequence until just before the transaction commits (or when the Document No is read), reducing lock contention on the sequence. When set to No, the Document No is generated immediately when the record is saved. Leave empty to use the LAZY_GENERATE_DOCUMENTNO_FROM_SEQUENCE system configurator setting','Lazy Generate Document No','D','01a1ab44-42f6-78df-b4fb-d69201430801')
;

-- Nov 5, 2026, 6:35:52 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217672,0,'Lazy Generate Document No','Defer generation of Document No from sequence until transaction pre-commit','When set to Yes, saving a new document assigns a temporary Document No and defers generating the actual Document No from the sequence until just before the transaction commits (or when the Document No is read), reducing lock contention on the sequence. When set to No, the Document No is generated immediately when the record is saved. Leave empty to use the LAZY_GENERATE_DOCUMENTNO_FROM_SEQUENCE system configurator setting',217,'IsLazyGenerateDocNo',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_TIMESTAMP('2026-11-05 18:35:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-05 18:35:51','YYYY-MM-DD HH24:MI:SS'),100,204135,'Y','N','D','N','N','N','Y','01a1ab47-8127-73cd-9fc7-4d94cb12c4ab','Y',0,'N','N','N','N')
;

-- Nov 5, 2026, 6:36:02 PM MYT
ALTER TABLE C_DocType ADD IsLazyGenerateDocNo CHAR(1) DEFAULT NULL 
;

-- Nov 5, 2026, 6:44:55 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (209256,'Lazy Generate Document No','Defer generation of Document No from sequence until transaction pre-commit','When set to Yes, saving a new document assigns a temporary Document No and defers generating the actual Document No from the sequence until just before the transaction commits (or when the Document No is read), reducing lock contention on the sequence. When set to No, the Document No is generated immediately when the record is saved. Leave empty to use the LAZY_GENERATE_DOCUMENTNO_FROM_SEQUENCE system configurator setting',167,217672,'Y','@IsDocNoControlled@=Y & @IsOverwriteSeqOnComplete@=N',0,390,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-11-05 18:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-05 18:44:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a1ab4f-cc2b-7cc2-a72e-93f2f2fd3a4e','Y',380,1,2,1,'N','N','N','N','N')
;

