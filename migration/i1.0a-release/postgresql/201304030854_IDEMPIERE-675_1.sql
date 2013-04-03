-- Mar 24, 2013 8:53:58 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DocSubTypeInv',202506,'D','DocSubTypeInventory','DocSubTypeInventory','d3568eab-af69-4fb7-a82a-6395a74baf98',0,TO_TIMESTAMP('2013-03-24 08:53:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-24 08:53:56','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 24, 2013 8:53:58 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202506 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 24, 2013 8:57:22 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Element SET Description='M_Inventory Sub Type',Updated=TO_TIMESTAMP('2013-03-24 08:57:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202506
;

-- Mar 24, 2013 8:57:22 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202506
;

-- Mar 24, 2013 8:57:22 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Column SET ColumnName='DocSubTypeInv', Name='DocSubTypeInventory', Description='M_Inventory Sub Type', Help=NULL WHERE AD_Element_ID=202506
;

-- Mar 24, 2013 8:57:23 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Process_Para SET ColumnName='DocSubTypeInv', Name='DocSubTypeInventory', Description='M_Inventory Sub Type', Help=NULL, AD_Element_ID=202506 WHERE UPPER(ColumnName)='DOCSUBTYPEINV' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 24, 2013 8:57:23 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Process_Para SET ColumnName='DocSubTypeInv', Name='DocSubTypeInventory', Description='M_Inventory Sub Type', Help=NULL WHERE AD_Element_ID=202506 AND IsCentrallyMaintained='Y'
;

-- Mar 24, 2013 8:57:23 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_InfoColumn SET ColumnName='DocSubTypeInv', Name='DocSubTypeInventory', Description='M_Inventory Sub Type', Help=NULL WHERE AD_Element_ID=202506 AND IsCentrallyMaintained='Y'
;

-- Mar 24, 2013 8:57:23 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET Name='DocSubTypeInventory', Description='M_Inventory Sub Type', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202506) AND IsCentrallyMaintained='Y'
;

-- Mar 24, 2013 9:09:50 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200068,'C_DocType SubTypeInv','U','ec3ef1fd-81f7-4bf9-8cf8-1769edaf24dc','N','M_Inventory Types list','L',0,0,100,TO_TIMESTAMP('2013-03-24 09:09:49','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2013-03-24 09:09:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2013 9:09:50 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Mar 24, 2013 9:10:05 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200137,200068,'D','Physical Inventory','2d7053e2-3c03-4387-896a-d377e841c4fc','PI',TO_TIMESTAMP('2013-03-24 09:10:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-24 09:10:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Mar 24, 2013 9:10:05 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200137 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Mar 24, 2013 9:10:22 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200138,200068,'D','Internal Use Inventory','7a90eeb2-d13e-4742-92a4-c6c53ead1acd','IU',TO_TIMESTAMP('2013-03-24 09:10:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-24 09:10:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Mar 24, 2013 9:10:22 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200138 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Mar 24, 2013 9:10:32 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Reference SET EntityType='D',Updated=TO_TIMESTAMP('2013-03-24 09:10:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200068
;

-- Mar 24, 2013 9:10:47 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES ('N',1,217,210208,'U',200068,'N','N','N',0,'N',2,'N',17,'N',202506,'N','Y','7e147816-760d-478f-9971-41afe6888840','Y','DocSubTypeInv','M_Inventory Sub Type','DocSubTypeInventory','Y',TO_TIMESTAMP('2013-03-24 09:10:46','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-24 09:10:46','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 24, 2013 9:10:47 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210208 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 24, 2013 9:10:54 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
ALTER TABLE C_DocType ADD COLUMN DocSubTypeInv VARCHAR(2) DEFAULT NULL 
;

-- Mar 24, 2013 9:17:50 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Field (ColumnSpan,NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,'N',167,14,'Y','N',210208,330,'Y',201886,'N','@DocBaseType@=''MII''','U','M_Inventory Sub Type','DocSubTypeInventory','Y','N','df15de21-562a-462d-be02-1da207183400',100,0,TO_TIMESTAMP('2013-03-24 09:17:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 09:17:49','YYYY-MM-DD HH24:MI:SS'),'Y','Y',120,4,'N')
;

-- Mar 24, 2013 9:17:50 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201886 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=201886
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=3075
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=3072
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=3071
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=3073
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=807
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=808
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=54233
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=54230
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=54232
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=10345
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=10346
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=10481
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=10480
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=58859
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=10371
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=10528
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=10340
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=200004
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=6567
;

-- Mar 24, 2013 9:18:10 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=3125
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=793
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2033
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=795
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=796
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=2081
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=2080
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=794
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=3126
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=812
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=3317
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=2079
;

-- Mar 24, 2013 9:18:25 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=2581
;

-- Mar 24, 2013 9:19:34 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2013-03-24 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201886
;

-- Mar 24, 2013 10:45:41 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('C_DocType.DocBaseType=''MMI'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND C_DocType.DocSubTypeInv=''PI''',200033,'D','C_DocType Physical Inventory','S','815be7ad-8832-4084-86ed-e15e7f6f3447',100,100,TO_TIMESTAMP('2013-03-24 10:45:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-24 10:45:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Mar 24, 2013 10:45:52 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('C_DocType.DocBaseType=''MMI'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND C_DocType.DocSubTypeInv=''IU''',200034,'U','C_DocType Internal Use','S','7e14253e-0d40-45aa-ac59-7570aa4e7171',100,100,TO_TIMESTAMP('2013-03-24 10:45:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-24 10:45:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Mar 24, 2013 10:46:24 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET AD_Reference_ID=19, AD_Val_Rule_ID=200033,Updated=TO_TIMESTAMP('2013-03-24 10:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10812
;

-- Mar 24, 2013 10:46:48 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET AD_Reference_ID=19, AD_Val_Rule_ID=200034,Updated=TO_TIMESTAMP('2013-03-24 10:46:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10969
;

-- Mar 24, 2013 10:48:53 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''MMI''',Updated=TO_TIMESTAMP('2013-03-24 10:48:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201886
;

-- Mar 24, 2013 10:49:19 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE C_DocType SET DocSubTypeInv='PI',Updated=TO_TIMESTAMP('2013-03-24 10:49:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_DocType_ID=144
;

-- Mar 24, 2013 10:49:34 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO C_DocType (GL_Category_ID,C_DocType_ID,IsDefault,DocBaseType,IsSOTrx,DocumentCopies,IsCreateCounter,IsIndexed,IsShipConfirm,IsSplitWhenDifference,IsDefaultCounterDoc,IsInTransit,IsPickQAConfirm,IsOverwriteDateOnComplete,IsOverwriteSeqOnComplete,C_DocType_UU,IsPrepareSplitDocument,PrintName,Name,IsDocNoControlled,HasCharges,HasProforma,CreatedBy,UpdatedBy,Updated,AD_Org_ID,IsActive,Created,AD_Client_ID,IsChargeOrProductMandatory,DocSubTypeInv) VALUES (108,200000,'N','MMI','N',0,'Y','Y','N','N','N','N','N','N','N','f59521af-43f8-4f21-9951-4eb4b553ae0b','Y','Internal Use Inventory','Internal Use Inventory','N','N','N',100,100,TO_TIMESTAMP('2013-03-24 10:49:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-24 10:49:34','YYYY-MM-DD HH24:MI:SS'),11,'N','IU')
;

-- Mar 24, 2013 10:49:34 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO C_DocType_Trl (AD_Language,C_DocType_ID, DocumentNote,PrintName,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_DocType_Trl_UU ) SELECT l.AD_Language,t.C_DocType_ID, t.DocumentNote,t.PrintName,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, C_DocType t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_DocType_ID=200000 AND NOT EXISTS (SELECT * FROM C_DocType_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_DocType_ID=t.C_DocType_ID)
;

-- Mar 24, 2013 10:49:45 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO M_Inventory (GenerateList,Posted,UpdateQty,M_Inventory_ID,Processed,M_Warehouse_ID,C_DocType_ID,IsApproved,DocStatus,ApprovalAmt,MovementDate,DocumentNo,Created,CreatedBy,IsActive,Processing,UpdatedBy,AD_Client_ID,M_Inventory_UU,AD_Org_ID,Updated,DocAction) VALUES ('N','N','N',200000,'N',50002,200000,'N','DR',0,TO_TIMESTAMP('2013-03-24','YYYY-MM-DD'),'10000001',TO_TIMESTAMP('2013-03-24 10:49:44','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',100,11,'70e98c40-a782-4651-a443-d4a53146bb6b',50001,TO_TIMESTAMP('2013-03-24 10:49:44','YYYY-MM-DD HH24:MI:SS'),'CO')
;

-- Mar 24, 2013 10:49:58 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE M_Inventory SET C_DocType_ID=144,Updated=TO_TIMESTAMP('2013-03-24 10:49:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Inventory_ID=200000
;

-- Mar 24, 2013 10:50:08 AM ICT
-- Bug Fix IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
INSERT INTO M_Inventory (GenerateList,Posted,UpdateQty,M_Inventory_ID,Processed,M_Warehouse_ID,C_DocType_ID,IsApproved,DocStatus,ApprovalAmt,MovementDate,DocumentNo,Created,CreatedBy,IsActive,Processing,UpdatedBy,AD_Client_ID,M_Inventory_UU,AD_Org_ID,Updated,DocAction) VALUES ('N','N','N',200001,'N',50002,144,'N','DR',0,TO_TIMESTAMP('2013-03-24','YYYY-MM-DD'),'10000002',TO_TIMESTAMP('2013-03-24 10:50:07','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',100,11,'6486b648-fdea-49d2-a2b2-9d87c2598e44',50001,TO_TIMESTAMP('2013-03-24 10:50:07','YYYY-MM-DD HH24:MI:SS'),'CO')
;

SELECT register_migration_script('201304030854_IDEMPIERE-675_1.sql') FROM dual
;

