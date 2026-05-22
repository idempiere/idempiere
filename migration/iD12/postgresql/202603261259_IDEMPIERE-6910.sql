-- IDEMPIERE-6910 Add ExternalTraceId to core audit changelog
SELECT register_migration_script('202603261259_IDEMPIERE-6910.sql') FROM dual;

-- Mar 26, 2026, 12:59:58 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204060,0,0,'Y',TO_TIMESTAMP('2026-03-26 12:59:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 12:59:57','YYYY-MM-DD HH24:MI:SS'),100,'ExternalTraceId','External Trace ID','External identifier used for audit tracing','External Trace ID','D','019d2883-78ff-70c4-b12f-d0a135e1f1b4')
;

-- Mar 26, 2026, 1:27:31 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217471,0,'External Trace ID','External identifier used for audit tracing',580,'ExternalTraceId',100,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-26 13:27:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 13:27:31','YYYY-MM-DD HH24:MI:SS'),100,204060,'Y','N','D','N','N','N','Y','019d289c-b587-71b4-95df-db90ea33ea5f','Y',0,'N','N','N','N')
;

-- Mar 26, 2026, 1:27:42 PM MYT
ALTER TABLE AD_ChangeLog ADD COLUMN ExternalTraceId VARCHAR(100) DEFAULT NULL 
;

-- Mar 26, 2026, 1:28:51 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217472,0,'External Trace ID','External identifier used for audit tracing',282,'ExternalTraceId',100,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-26 13:28:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 13:28:50','YYYY-MM-DD HH24:MI:SS'),100,204060,'Y','N','D','N','N','N','Y','019d289d-ec35-7fad-9cc7-159182801968','Y',0,'N','N','N','N','N')
;

-- Mar 26, 2026, 1:28:56 PM MYT
ALTER TABLE AD_PInstance ADD COLUMN ExternalTraceId VARCHAR(100) DEFAULT NULL 
;

-- Mar 26, 2026, 1:30:37 PM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201310,'019d289f-8b26-73d1-9259-048ab85278a6',TO_TIMESTAMP('2026-03-26 13:30:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_changelog_externaltraceid',TO_TIMESTAMP('2026-03-26 13:30:37','YYYY-MM-DD HH24:MI:SS'),100,580,'N','N','N','N','N')
;

-- Mar 26, 2026, 1:31:17 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201806,'019d28a0-24cc-7b80-9c23-892ce5f509e4',TO_TIMESTAMP('2026-03-26 13:31:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-26 13:31:16','YYYY-MM-DD HH24:MI:SS'),100,217471,201310,10)
;

-- Mar 26, 2026, 1:31:24 PM MYT
CREATE INDEX ad_changelog_externaltraceid ON AD_ChangeLog (ExternalTraceId)
;

-- Mar 26, 2026, 1:31:48 PM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201311,'019d28a0-9ef0-7be4-a8fc-e7331735faa7',TO_TIMESTAMP('2026-03-26 13:31:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_pinstance_externaltraceid',TO_TIMESTAMP('2026-03-26 13:31:47','YYYY-MM-DD HH24:MI:SS'),100,282,'N','N','N','N')
;

-- Mar 26, 2026, 1:31:59 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201807,'019d28a0-cba0-7e22-9635-5eaf84ef9162',TO_TIMESTAMP('2026-03-26 13:31:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-26 13:31:59','YYYY-MM-DD HH24:MI:SS'),100,217472,201311,10)
;

-- Mar 26, 2026, 1:32:03 PM MYT
CREATE INDEX ad_pinstance_externaltraceid ON AD_PInstance (ExternalTraceId)
;

-- Mar 26, 2026, 1:32:50 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209075,'External Trace ID','External identifier used for audit tracing',488,217471,'Y',100,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-26 13:32:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 13:32:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d28a1-91ae-773d-acb2-477f2f77669a','Y',200,5)
;

-- Mar 26, 2026, 1:34:50 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209076,'External Trace ID','External identifier used for audit tracing',487,217471,'Y',100,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-26 13:34:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 13:34:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d28a3-6648-736d-be48-adebb1971262','Y',200,5)
;

-- Mar 26, 2026, 1:35:32 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209077,'External Trace ID','External identifier used for audit tracing',663,217472,'Y',100,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-26 13:35:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 13:35:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d28a4-091d-7202-9f19-9953e2bb6f4a','Y',210,5)
;

-- Mar 26, 2026, 1:37:31 PM MYT
UPDATE AD_Field SET SeqNo=95, SeqNoGrid=75,Updated=TO_TIMESTAMP('2026-03-26 13:37:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209077
;

-- Mar 26, 2026, 1:42:10 PM MYT
UPDATE AD_Column SET IsSelectionColumn='Y', SeqNoSelection=20,Updated=TO_TIMESTAMP('2026-03-26 13:42:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217471
;

-- Mar 26, 2026, 1:42:46 PM MYT
UPDATE AD_Column SET IsSelectionColumn='Y', SeqNoSelection=10,Updated=TO_TIMESTAMP('2026-03-26 13:42:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217472
;

-- Mar 26, 2026, 1:48:40 PM MYT
UPDATE AD_Column SET SeqNoSelection=10,Updated=TO_TIMESTAMP('2026-03-26 13:48:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2781
;

-- Mar 26, 2026, 1:48:49 PM MYT
UPDATE AD_Column SET SeqNoSelection=20,Updated=TO_TIMESTAMP('2026-03-26 13:48:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5951
;

-- Mar 26, 2026, 1:48:57 PM MYT
UPDATE AD_Column SET SeqNoSelection=30,Updated=TO_TIMESTAMP('2026-03-26 13:48:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217472
;

