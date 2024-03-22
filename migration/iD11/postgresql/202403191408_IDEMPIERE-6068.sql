-- IDEMPIERE-6068 Proposal to Add C_UOM.UNCEFACT column 
SELECT register_migration_script('202403191408_IDEMPIERE-6068.sql') FROM dual;

-- Mar 19, 2024, 2:08:24 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203927,0,0,'Y',TO_TIMESTAMP('2024-03-19 14:05:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-19 14:05:35','YYYY-MM-DD HH24:MI:SS'),100,'UNCEFACT','UN/CEFACT Code','Code for Units of Measure used in International Trade','As defined at United Nations Centre for Trade Facilitation and Electronic Business.  https://service.unece.org/trade/uncefact/vocabulary/rec20/','UN/CEFACT','D','3ea9966d-6a75-4872-9ab7-1c92115cfe23')
;

-- Mar 19, 2024, 2:10:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216583,0,'UN/CEFACT Code','Code for Units of Measure used in International Trade','As defined at United Nations Centre for Trade Facilitation and Electronic Business.  https://service.unece.org/trade/uncefact/vocabulary/rec20/',146,'UNCEFACT',10,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-03-19 14:10:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-19 14:10:36','YYYY-MM-DD HH24:MI:SS'),100,203927,'Y','N','D','N','N','N','Y','569a4ed0-51db-4802-91e4-7fa61590fb84','Y',0,'N','N','N','N')
;

-- Mar 19, 2024, 2:10:40 PM CET
ALTER TABLE C_UOM ADD COLUMN UNCEFACT VARCHAR(10) DEFAULT NULL 
;

-- Mar 19, 2024, 2:11:22 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208473,'UN/CEFACT Code','Code for Units of Measure used in International Trade','As defined at United Nations Centre for Trade Facilitation and Electronic Business.  https://service.unece.org/trade/uncefact/vocabulary/rec20/',133,216583,'Y',10,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-03-19 14:11:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-19 14:11:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','753b240c-e56e-4fa4-bff7-dd1cd6d9d500','Y',120,2)
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208473
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=452
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=453
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=454
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58028
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=455
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3208
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=456
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=457
;

-- Mar 19, 2024, 2:11:47 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-03-19 14:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204823
;

-- Mar 19, 2024, 2:12:44 PM CET
UPDATE C_UOM SET UNCEFACT='DAY',Updated=TO_TIMESTAMP('2024-03-19 14:12:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=102
;

-- Mar 19, 2024, 2:13:59 PM CET
UPDATE C_UOM SET UNCEFACT='EA',Updated=TO_TIMESTAMP('2024-03-19 14:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=100
;

-- Mar 19, 2024, 2:14:15 PM CET
UPDATE C_UOM SET UNCEFACT='HUR',Updated=TO_TIMESTAMP('2024-03-19 14:14:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=101
;

-- Mar 19, 2024, 2:14:37 PM CET
UPDATE C_UOM SET UNCEFACT='MIN',Updated=TO_TIMESTAMP('2024-03-19 14:14:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=103
;

-- Mar 19, 2024, 2:14:49 PM CET
UPDATE C_UOM SET UNCEFACT='MON',Updated=TO_TIMESTAMP('2024-03-19 14:14:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=106
;

-- Mar 19, 2024, 2:15:00 PM CET
UPDATE C_UOM SET UNCEFACT='WEE',Updated=TO_TIMESTAMP('2024-03-19 14:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=105
;

-- Mar 19, 2024, 2:15:22 PM CET
UPDATE C_UOM SET UNCEFACT='E49',Updated=TO_TIMESTAMP('2024-03-19 14:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=104
;

-- Mar 19, 2024, 2:15:30 PM CET
UPDATE C_UOM SET UNCEFACT='WM',Updated=TO_TIMESTAMP('2024-03-19 14:15:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=107
;

-- Mar 19, 2024, 2:15:43 PM CET
UPDATE C_UOM SET UNCEFACT='ANN',Updated=TO_TIMESTAMP('2024-03-19 14:15:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=108
;

-- Mar 19, 2024, 2:17:20 PM CET
UPDATE C_UOM SET UNCEFACT='P6',Updated=TO_TIMESTAMP('2024-03-19 14:17:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=109
;

-- Mar 19, 2024, 2:17:43 PM CET
UPDATE C_UOM SET UNCEFACT='CMT',Updated=TO_TIMESTAMP('2024-03-19 14:17:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=200001
;

-- Mar 19, 2024, 2:18:24 PM CET
UPDATE C_UOM SET UNCEFACT='KGM',Updated=TO_TIMESTAMP('2024-03-19 14:18:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=50001
;

-- Mar 19, 2024, 2:18:56 PM CET
UPDATE C_UOM SET UNCEFACT='MLT',Updated=TO_TIMESTAMP('2024-03-19 14:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=50000
;

-- Mar 19, 2024, 2:24:31 PM CET
UPDATE C_UOM SET UNCEFACT='MGM',Updated=TO_TIMESTAMP('2024-03-19 14:24:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=50002
;

