-- IDEMPIERE-5746 Bank Statement and Production cannot use Overwrite Date/Seq on Complete
SELECT register_migration_script('202306061239_IDEMPIERE-5746.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 6, 2023, 12:39:58 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200177,'C_DocType Production','S','C_DocType.DocBaseType=''MMP'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:39:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:39:58','YYYY-MM-DD HH24:MI:SS'),100,'D','deadd34c-62f0-46dc-a2e0-39098ac73e01')
;

-- Jun 6, 2023, 12:40:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215846,0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',325,200177,'C_DocType_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-06-06 12:40:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:40:44','YYYY-MM-DD HH24:MI:SS'),100,196,'N','N','D','N','N','N','Y','ef7d222d-4904-4a05-82e2-e031e63f38a2','Y',0,'N','N','N')
;

-- Jun 6, 2023, 12:40:46 PM CEST
UPDATE AD_Column SET FKConstraintName='CDocType_MProduction', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-06-06 12:40:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215846
;

-- Jun 6, 2023, 12:40:46 PM CEST
ALTER TABLE M_Production ADD C_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 6, 2023, 12:40:46 PM CEST
ALTER TABLE M_Production ADD CONSTRAINT CDocType_MProduction FOREIGN KEY (C_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

UPDATE M_Production
SET C_DocType_ID=(SELECT C_DocType_ID FROM C_DocType dt WHERE dt.AD_Client_ID=M_Production.AD_Client_ID AND DocBaseType='MMP' ORDER BY C_DocType_ID FETCH FIRST 1 ROWS ONLY)
WHERE C_DocType_ID IS NULL
;

-- Jun 6, 2023, 12:43:14 PM CEST
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='Y',Updated=TO_TIMESTAMP('2023-06-06 12:43:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215846
;

-- Jun 6, 2023, 12:43:15 PM CEST
ALTER TABLE M_Production MODIFY C_DocType_ID NUMBER(10)
;

-- Jun 6, 2023, 12:43:15 PM CEST
ALTER TABLE M_Production MODIFY C_DocType_ID NOT NULL
;

-- Jun 6, 2023, 12:44:40 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207633,'Reversal ID','ID of document reversal',53344,211207,'Y',10,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:44:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:44:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','94a06e64-f219-42f7-879f-ba539b263eac','Y',300,2)
;

-- Jun 6, 2023, 12:44:40 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207634,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',53344,215846,'Y',22,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:44:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:44:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0ec67c76-e8c0-46fc-b9e0-a5d94b306317','Y',310,2)
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207634
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59742
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59745
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59741
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59740
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59744
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59752
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59743
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206081
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59754
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62015
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59756
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202852
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59736
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62017
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62018
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206801
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59755
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59737
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59738
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59757
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59758
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59759
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202853
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, XPosition=4,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59749
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59748
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204950
;

-- Jun 6, 2023, 12:46:05 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207633
;

-- Jun 6, 2023, 12:46:32 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207635,'Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',319,59049,'Y',20,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:32','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','7b6c3314-4970-438b-9dca-f31e80189628','Y',260,2)
;

-- Jun 6, 2023, 12:46:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207636,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',319,59962,'Y',22,210,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d8e2a03a-a0b6-43d5-a8a8-7a37fefceffc','Y',270,2)
;

-- Jun 6, 2023, 12:46:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207637,'Locator','Warehouse Locator','The Locator indicates where in a Warehouse a product is located.',319,59963,'Y',10,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','73335d9a-ef56-4ec1-8543-4d48a0cef3d5','Y',280,2)
;

-- Jun 6, 2023, 12:46:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207638,'Production Quantity','Quantity of products to produce','The Production Quantity identifies the number of products to produce',319,59964,'Y',10,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','daa4c75f-00c0-49fb-9a65-dd8dbacf7854','Y',290,2)
;

-- Jun 6, 2023, 12:46:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207639,'Date Promised','Date Order was promised','The Date Promised indicates the date, if any, that an Order was promised for.',319,59966,'Y',7,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','35ed0056-dac7-47b6-8649-1c4b28f76469','Y',300,2)
;

-- Jun 6, 2023, 12:46:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207640,'M_Production_UU',319,60928,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dfb77a2a-6597-4c0c-b931-34f40213b89a','N',2)
;

-- Jun 6, 2023, 12:46:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207641,'Complete','It is complete','Indication that this is complete',319,61940,'Y',1,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','27e3e0c9-a47a-4085-bf4e-ac91e45d0270','Y',310,2,2)
;

-- Jun 6, 2023, 12:46:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207642,'Sales Order Line','Sales Order Line','The Sales Order Line is a unique identifier for a line in an order.',319,61941,'Y',10,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','095d9a3f-85dd-4ece-82ce-be9ae1fd65f9','Y',320,2)
;

-- Jun 6, 2023, 12:46:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207643,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',319,61942,'Y',10,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','75931f0d-0ff0-4afe-bfd6-4e4e5bdd24d0','Y',330,2)
;

-- Jun 6, 2023, 12:46:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207644,'Reversal ID','ID of document reversal',319,211207,'Y',10,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e2ff9a7-f1b6-4682-bec1-cda9cb084943','Y',340,2)
;

-- Jun 6, 2023, 12:46:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207645,'Project Phase','Phase of a Project',319,211817,'Y',10,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f8904c06-782f-48de-b982-cb5c214acaf6','Y',350,2)
;

-- Jun 6, 2023, 12:46:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207646,'Project Task','Actual Project Task in a Phase','A Project Task in a Project Phase represents the actual work.',319,211818,'Y',10,300,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','57fb25b7-9c30-4a28-8c41-d86cec465710','Y',360,2)
;

-- Jun 6, 2023, 12:46:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207647,'BOM & Formula','BOM & Formula',319,213948,'Y',22,310,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','250832f7-f0b8-4b59-a371-506ff5ab1f29','Y',370,2)
;

-- Jun 6, 2023, 12:46:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207648,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',319,214619,'Y',22,320,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','addbf796-6d3b-4029-8c3f-159f8abc87f5','Y',380,2)
;

-- Jun 6, 2023, 12:46:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207649,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',319,215846,'Y',22,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f29b716e-03c8-4f83-bf18-734021b4d559','Y',390,2)
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207649
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202854
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3786
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3787
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3785
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3788
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202849
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3791
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202850
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7817
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7820
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7821
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7818
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7822
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7819
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3790
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202851
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5145
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207647
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207643
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207641
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207639
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207637
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207640
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207635
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207636
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207638
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207645
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207646
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207644
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207642
;

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207648
;

-- Jun 6, 2023, 12:48:08 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207648
;

-- Jun 6, 2023, 12:48:08 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207647
;

-- Jun 6, 2023, 12:48:08 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207646
;

-- Jun 6, 2023, 12:48:08 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207645
;

-- Jun 6, 2023, 12:48:08 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207644
;

-- Jun 6, 2023, 12:48:08 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207643
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207642
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207641
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207639
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207638
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207637
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207636
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207635
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3789
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3782
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3783
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202628
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3784
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3786
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3787
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3785
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3788
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7817
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=70,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7820
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=80,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7821
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=90,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7818
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=100,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7822
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=110,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7819
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=120,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3790
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=130,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3791
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=140,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5145
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=150,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202849
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=160,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202850
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=170,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202851
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=180,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207649
;

-- Jun 6, 2023, 12:48:09 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=190,Updated=TO_TIMESTAMP('2023-06-06 12:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202854
;

-- Jun 6, 2023, 12:48:45 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59746
;

-- Jun 6, 2023, 12:48:45 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207633
;

-- Jun 6, 2023, 12:48:45 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2023-06-06 12:48:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207634
;

-- Jun 6, 2023, 12:49:05 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2023-06-06 12:49:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59746
;

-- Jun 6, 2023, 12:49:05 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2023-06-06 12:49:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207634
;

-- Jun 6, 2023, 12:49:05 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2023-06-06 12:49:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59742
;

-- Jun 6, 2023, 12:49:05 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2023-06-06 12:49:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59745
;

-- Jun 6, 2023, 12:49:05 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2023-06-06 12:49:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59741
;

-- Jun 6, 2023, 12:49:05 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2023-06-06 12:49:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59736
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=70,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59740
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=80,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59744
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=90,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59752
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=100,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59743
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=110,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206081
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=120,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59754
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=130,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62015
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=140,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62016
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=150,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202852
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=160,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59756
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=170,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59737
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=180,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59749
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=190,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59748
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=200,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59755
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=210,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59738
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=220,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62017
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=230,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62018
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=240,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206801
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=250,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59757
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=260,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59758
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=270,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59759
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=280,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202853
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=290,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203487
;

-- Jun 6, 2023, 12:49:06 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=300,Updated=TO_TIMESTAMP('2023-06-06 12:49:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203488
;

-- Jun 6, 2023, 12:51:47 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200178,'C_DocType Bank Statement','S','C_DocType.DocBaseType=''CMB'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:51:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:51:47','YYYY-MM-DD HH24:MI:SS'),100,'D','afea2403-ccc2-40db-a60b-94ae80593b81')
;

-- Jun 6, 2023, 12:52:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215847,0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',392,200178,'C_DocType_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-06-06 12:52:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:52:09','YYYY-MM-DD HH24:MI:SS'),100,196,'N','N','D','N','N','N','Y','8918a65f-2382-40d4-8a96-d93a5302797f','Y',0,'N','N','N')
;

-- Jun 6, 2023, 12:52:22 PM CEST
UPDATE AD_Column SET FKConstraintName='CDocType_CBankStatement', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-06-06 12:52:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215847
;

-- Jun 6, 2023, 12:52:22 PM CEST
ALTER TABLE C_BankStatement ADD C_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 6, 2023, 12:52:22 PM CEST
ALTER TABLE C_BankStatement ADD CONSTRAINT CDocType_CBankStatement FOREIGN KEY (C_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

UPDATE C_BankStatement
SET C_DocType_ID=(SELECT C_DocType_ID FROM C_DocType dt WHERE dt.AD_Client_ID=C_BankStatement.AD_Client_ID AND DocBaseType='CMB' ORDER BY C_DocType_ID FETCH FIRST 1 ROWS ONLY)
WHERE C_DocType_ID IS NULL
;

-- Jun 6, 2023, 12:53:05 PM CEST
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='Y',Updated=TO_TIMESTAMP('2023-06-06 12:53:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215847
;

-- Jun 6, 2023, 12:53:07 PM CEST
ALTER TABLE C_BankStatement MODIFY C_DocType_ID NUMBER(10)
;

-- Jun 6, 2023, 12:53:07 PM CEST
ALTER TABLE C_BankStatement MODIFY C_DocType_ID NOT NULL
;

-- Jun 6, 2023, 12:54:35 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215848,1,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',392,'DocumentNo',60,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-06-06 12:54:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:54:34','YYYY-MM-DD HH24:MI:SS'),100,290,'N','Y','D','N','N','N','Y','56b08193-781a-4e18-b6cf-73aa89358238','Y',10,'N','N','N')
;

-- Jun 6, 2023, 12:55:26 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2023-06-06 12:55:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215848
;

-- Jun 6, 2023, 12:55:28 PM CEST
ALTER TABLE C_BankStatement ADD DocumentNo VARCHAR2(60 CHAR) DEFAULT NULL 
;

UPDATE C_BankStatement
SET DocumentNo=Name WHERE DocumentNo IS NULL
;

-- Jun 6, 2023, 12:55:43 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-06-06 12:55:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215848
;

-- Jun 6, 2023, 12:55:44 PM CEST
ALTER TABLE C_BankStatement MODIFY DocumentNo VARCHAR2(60 CHAR)
;

-- Jun 6, 2023, 12:55:44 PM CEST
ALTER TABLE C_BankStatement MODIFY DocumentNo NOT NULL
;

-- Jun 6, 2023, 12:57:02 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207650,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',328,215847,'Y',22,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:57:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:57:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9eb62046-814e-42ad-9b23-994f43d42504','Y',200,2)
;

-- Jun 6, 2023, 12:57:02 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207651,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',328,215848,'Y',60,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:57:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:57:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b6fda95d-b4c1-4e30-ae6e-5d370caa6785','Y',210,5)
;

-- Jun 6, 2023, 12:57:30 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:57:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207650
;

-- Jun 6, 2023, 12:57:30 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-06-06 12:57:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207651
;

-- Jun 6, 2023, 12:57:30 PM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2023-06-06 12:57:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4120
;

-- Jun 6, 2023, 12:57:30 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-06-06 12:57:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4002
;

-- Jun 6, 2023, 12:57:30 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2023-06-06 12:57:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=61967
;

-- Jun 6, 2023, 12:57:30 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-06-06 12:57:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3996
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3998
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4119
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3993
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4365
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201691
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4003
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8933
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200599
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3997
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8686
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8687
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10585
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10586
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10587
;

-- Jun 6, 2023, 12:57:31 PM CEST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2023-06-06 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3999
;

