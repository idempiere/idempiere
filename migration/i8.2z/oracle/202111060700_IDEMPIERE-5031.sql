SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5031 Implement auto produce upon shipment for mfg light
-- Nov 6, 2021, 11:00:18 AM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203548,0,0,'Y',TO_DATE('2021-11-06 11:00:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-06 11:00:17','YYYY-MM-DD HH24:MI:SS'),100,'IsAutoProduce','Auto Produce','Auto create production to fulfill shipment','Auto Produce','D','49d2748d-90c3-44d6-94e0-7cb5b9e98f29')
;

-- Nov 6, 2021, 11:00:55 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214618,0,'Auto Produce','Auto create production to fulfill shipment',208,'IsAutoProduce','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-11-06 11:00:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-06 11:00:54','YYYY-MM-DD HH24:MI:SS'),100,203548,'Y','N','D','N','N','N','Y','0837aa88-8aff-4f8a-ad1e-cdb9089bb87c','Y',0,'N','N','N','N')
;

-- Nov 6, 2021, 11:01:00 AM MYT
ALTER TABLE M_Product ADD IsAutoProduce CHAR(1) DEFAULT 'N' CHECK (IsAutoProduce IN ('Y','N')) NOT NULL
;

-- Nov 6, 2021, 11:02:58 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206800,'Auto Produce','Auto create production to fulfill shipment',180,214618,'Y',0,610,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-06 11:02:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-06 11:02:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4626cd57-543b-4e69-8d3c-88800ac77396','Y',600,5,2,1,'N','N','N','N')
;

-- Nov 6, 2021, 11:03:28 AM MYT
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206800
;

-- Nov 6, 2021, 11:03:28 AM MYT
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3744
;

-- Nov 6, 2021, 11:03:28 AM MYT
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3745
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1027
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1028
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1568
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1569
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5381
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5383
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12418
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=9286
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5910
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5911
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6130
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8307
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6343
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6344
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=58973
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=580,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8608
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=590,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8613
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=600,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=52015
;

-- Nov 6, 2021, 11:03:29 AM MYT
UPDATE AD_Field SET SeqNo=610,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=52016
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206800
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3744
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3745
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1027
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1028
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=430,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1568
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=440,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1569
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=450,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5381
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=460,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5383
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=470,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=9286
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=480,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12418
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=490,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5910
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=500,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5911
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=510,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6130
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=520,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8307
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=530,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6343
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=540,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6344
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=550,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8608
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=560,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8613
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=570,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=52015
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=580,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=52016
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=590,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=58973
;

-- Nov 6, 2021, 11:03:45 AM MYT
UPDATE AD_Field SET SeqNoGrid=600,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206544
;

-- Nov 6, 2021, 11:04:09 AM MYT
UPDATE AD_Field SET DisplayLogic='@IsBOM@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-06 11:04:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206800
;

-- Nov 6, 2021, 11:13:36 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214619,0,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',325,'M_InOutLine_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2021-11-06 11:13:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-06 11:13:36','YYYY-MM-DD HH24:MI:SS'),100,1026,'N','N','D','N','N','N','Y','7932af9e-bccb-4a61-a541-f16ecd5d95b2','N',0,'N','N','N')
;

-- Nov 6, 2021, 11:13:42 AM MYT
UPDATE AD_Column SET FKConstraintName='MInOutLine_MProduction', FKConstraintType='N',Updated=TO_DATE('2021-11-06 11:13:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214619
;

-- Nov 6, 2021, 11:13:42 AM MYT
ALTER TABLE M_Production ADD M_InOutLine_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 6, 2021, 11:13:42 AM MYT
ALTER TABLE M_Production ADD CONSTRAINT MInOutLine_MProduction FOREIGN KEY (M_InOutLine_ID) REFERENCES m_inoutline(m_inoutline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 6, 2021, 11:14:43 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206801,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',53344,214619,'Y',0,280,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-06 11:14:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-06 11:14:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','2725993e-b462-48c7-adf3-f09f715de63b','Y',250,1,2,1,'N','N','N','N')
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=203487
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=203488
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206081
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59754
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=62015
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59756
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=202852
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59736
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=62017
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=62018
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206801
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59755
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59737
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59738
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59757
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59758
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59759
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=202853
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59749
;

-- Nov 6, 2021, 11:14:56 AM MYT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59748
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59739
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=202629
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59746
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59742
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59745
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59741
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59736
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59740
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59744
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59752
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59743
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206081
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=202852
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59756
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59737
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59749
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59748
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59755
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59738
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=62017
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=62018
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206801
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59757
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59758
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59759
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=202853
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=203487
;

-- Nov 6, 2021, 11:15:05 AM MYT
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=203488
;

-- Nov 6, 2021, 2:16:03 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214620,0,'Auto Produce','Auto create production to fulfill shipment',320,'IsAutoProduce','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-11-06 14:16:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-06 14:16:02','YYYY-MM-DD HH24:MI:SS'),100,203548,'N','N','D','N','N','N','Y','e6e53b6d-f1f6-46fe-9809-462e4d7fbd71','N',0,'N','N','N','N')
;

-- Nov 6, 2021, 2:16:10 PM MYT
ALTER TABLE M_InOutLine ADD IsAutoProduce CHAR(1) DEFAULT 'N' CHECK (IsAutoProduce IN ('Y','N'))
;

-- Nov 6, 2021, 2:19:34 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206802,'Auto Produce','Auto create production to fulfill shipment',258,214620,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-06 14:19:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-06 14:19:33','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','68fb70d6-058c-41f3-8353-d0a407811541','Y',260,5,2,1,'N','N','N','N')
;

-- Nov 6, 2021, 2:21:06 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-06 14:21:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206802
;

SELECT register_migration_script('202111060700_IDEMPIERE-5031.sql') FROM dual
;

