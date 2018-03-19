-- May 28, 2012 9:45:40 PM COT
-- IDEMPIERE-281 Extend Import Inventory to support also internal use
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200187,572,'D',1.000000000000,'N','N','N',0,'N',60,'Y',10,'N','N',2098,'N','Y','N','Y','N','DocTypeName','Name of the Document Type','Document Type Name','Y',100,TO_DATE('2012-05-28 21:45:38','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-05-28 21:45:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 28, 2012 9:45:40 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200187 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 28, 2012 9:45:45 PM COT
ALTER TABLE I_Inventory ADD DocTypeName NVARCHAR2(60) DEFAULT NULL 
;

-- May 28, 2012 9:50:24 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200188,572,'D',1.000000000000,'N','N','N',0,'The Document Type determines document sequence and processing rules','N',22,'N',19,'N',209,'N',196,'N','Y','N','Y','N','C_DocType_ID','Document type or rules','Document Type','Y',100,TO_DATE('2012-05-28 21:50:24','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-05-28 21:50:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 28, 2012 9:50:24 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200188 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 28, 2012 9:50:27 PM COT
ALTER TABLE I_Inventory ADD C_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- May 28, 2012 9:52:23 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200189,572,'D',1.000000000000,'N','N','N',0,'Quantity of product inventory used internally (positive if taken out - negative if returned)','N',22,'N',29,'N','N',2654,'N','Y','N','Y','N','QtyInternalUse','Internal Use Quantity removed from Inventory','Internal Use Qty','Y',100,TO_DATE('2012-05-28 21:52:22','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-05-28 21:52:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 28, 2012 9:52:23 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200189 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 28, 2012 9:52:25 PM COT
ALTER TABLE I_Inventory ADD QtyInternalUse NUMBER DEFAULT NULL 
;

-- May 28, 2012 9:56:11 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',20,'Y','N','N',200187,'N',250,'Y',481,200135,'N','D','Name of the Document Type','Document Type Name',100,0,'Y',TO_DATE('2012-05-28 21:56:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-05-28 21:56:09','YYYY-MM-DD HH24:MI:SS'))
;

-- May 28, 2012 9:56:11 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200135 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 28, 2012 9:56:40 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',14,'Y','Y','N',200188,'N',260,'Y',481,200136,'N','The Document Type determines document sequence and processing rules','D','Document type or rules','Document Type',100,0,'Y',TO_DATE('2012-05-28 21:56:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-05-28 21:56:40','YYYY-MM-DD HH24:MI:SS'))
;

-- May 28, 2012 9:56:40 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200136 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 28, 2012 9:58:41 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',26,'Y','N','N',200189,'N',270,'Y',481,200137,'N','Quantity of product inventory used internally (positive if taken out - negative if returned)',102,'D','Internal Use Quantity removed from Inventory','Internal Use Qty',100,0,'Y',TO_DATE('2012-05-28 21:58:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-05-28 21:58:39','YYYY-MM-DD HH24:MI:SS'))
;

-- May 28, 2012 9:58:41 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200137 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200135
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200136
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=8192
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=6701
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=6709
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=6702
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=6707
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=7064
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=6699
;

-- May 28, 2012 9:59:12 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=6704
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=6708
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=6710
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=6698
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=6711
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=6705
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=6703
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200137
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=6706
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=58565
;

-- May 28, 2012 9:59:13 PM COT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=6697
;

-- May 28, 2012 10:56:49 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200190,572,'D',0,'N','N','N',0,'The Charge indicates a type of Charge (Handling, Shipping, Restocking)','N',10,'N',19,'N','N',968,'N','Y','N','Y','N','C_Charge_ID','Additional document charges','Charge','Y',100,TO_DATE('2012-05-28 22:56:48','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-05-28 22:56:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 28, 2012 10:56:49 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200190 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 28, 2012 10:56:52 PM COT
ALTER TABLE I_Inventory ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- May 28, 2012 10:57:41 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200191,572,'D',0,'N','N','N',0,'N',60,'Y',10,'N','N',2096,'N','Y','N','Y','N','ChargeName','Name of the Charge','Charge Name','Y',100,TO_DATE('2012-05-28 22:57:41','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-05-28 22:57:41','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 28, 2012 10:57:41 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200191 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 28, 2012 10:57:44 PM COT
ALTER TABLE I_Inventory ADD ChargeName NVARCHAR2(60) DEFAULT NULL 
;

-- May 28, 2012 10:58:52 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',20,'Y','N','N',200191,'N',280,'Y',481,200138,'N','D','Name of the Charge','Charge Name',100,0,'Y',TO_DATE('2012-05-28 22:58:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-05-28 22:58:51','YYYY-MM-DD HH24:MI:SS'))
;

-- May 28, 2012 10:58:52 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200138 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 28, 2012 10:59:05 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',14,'Y','Y','N',200190,'N',290,'Y',481,200139,'N','The Charge indicates a type of Charge (Handling, Shipping, Restocking)','D','Additional document charges','Charge',100,0,'Y',TO_DATE('2012-05-28 22:59:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-05-28 22:59:04','YYYY-MM-DD HH24:MI:SS'))
;

-- May 28, 2012 10:59:05 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200139 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 28, 2012 10:59:19 PM COT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200138
;

-- May 28, 2012 10:59:19 PM COT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200139
;

-- May 28, 2012 10:59:19 PM COT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=6706
;

-- May 28, 2012 10:59:19 PM COT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=58565
;

-- May 28, 2012 10:59:19 PM COT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=6697
;

-- May 28, 2012 10:41:18 PM COT
INSERT INTO AD_ImpFormat (Processing,AD_ImpFormat_ID,AD_Table_ID,FormatType,Description,Name,Updated,Created,CreatedBy,AD_Client_ID,UpdatedBy,IsActive,AD_Org_ID) VALUES ('N',200000,572,'C','Example Inventory for Garden World','Example Inventory',TO_DATE('2012-05-28 22:41:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-05-28 22:41:17','YYYY-MM-DD HH24:MI:SS'),100,11,100,'Y',0)
;

-- May 28, 2012 10:49:35 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (10,0,'S',200000,1,200187,'.','N',200000,'Document Type Name ',TO_DATE('2012-05-28 22:49:34','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 22:49:34','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 10:51:35 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (20,0,'S',200001,2,8826,'.','N',200000,'Line Description',TO_DATE('2012-05-28 22:51:34','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 22:51:34','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 10:51:51 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (30,0,'S',200002,3,8824,'.','N',200000,'Product Value',TO_DATE('2012-05-28 22:51:50','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 22:51:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 10:52:35 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (40,0,'S',200003,4,8989,'.','N',200000,'Locator Value',TO_DATE('2012-05-28 22:52:35','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 22:52:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 11:02:56 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (50,0,'S',200004,5,200191,'.','N',200000,'Charge Name',TO_DATE('2012-05-28 23:02:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 23:02:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 11:03:15 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (60,0,'N',200005,0,8825,'.','N',200000,'Qty Book',TO_DATE('2012-05-28 23:03:15','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 23:03:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 11:03:19 PM COT
UPDATE AD_ImpFormat_Row SET StartNo=6,Updated=TO_DATE('2012-05-28 23:03:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ImpFormat_Row_ID=200005
;

-- May 28, 2012 11:03:35 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (70,0,'N',200006,7,8823,'.','N',200000,'Qty Count',TO_DATE('2012-05-28 23:03:35','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 23:03:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 11:03:48 PM COT
INSERT INTO AD_ImpFormat_Row (SeqNo,EndNo,DataType,AD_ImpFormat_Row_ID,StartNo,AD_Column_ID,DecimalPoint,DivideBy100,AD_ImpFormat_ID,Name,Updated,AD_Org_ID,Created,CreatedBy,IsActive,AD_Client_ID,UpdatedBy) VALUES (80,0,'N',200007,8,200189,'.','N',200000,'Qty Internal Use',TO_DATE('2012-05-28 23:03:47','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-05-28 23:03:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',11,100)
;

-- May 28, 2012 11:39:52 PM COT
-- IDEMPIERE-281 Extend Import Inventory to support also internal use
UPDATE AD_Process_Para SET DefaultValue='@C_AcctSchema_ID@',Updated=TO_DATE('2012-05-28 23:39:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53375
;

UPDATE AD_System
  SET LastMigrationScriptApplied='844-IDEMPIERE-281.sql'
WHERE LastMigrationScriptApplied<'844-IDEMPIERE-281.sql'
   OR LastMigrationScriptApplied IS NULL
;

