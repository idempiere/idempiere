-- IDEMPIERE-4490 Set default Contact/User in SO, Invoice, M_InOut
-- Oct 7, 2020, 12:56:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214323,0,'Ship Address','Business Partner Shipment Address','If the Ship Address is selected, the location is used to ship goods to a customer or receive goods from a vendor.',114,'IsShipTo','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2020-10-07 12:56:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-07 12:56:31','YYYY-MM-DD HH24:MI:SS'),100,929,'N','N','D','N','N','N','Y','1ad8957b-5518-4c91-89e1-3364402c1908','Y',0,'N','N','N')
;

-- Oct 7, 2020, 12:56:47 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214324,0,'Invoice Address','Business Partner Invoice/Bill Address','If the Invoice Address is selected, the location is used to send invoices to a customer or receive invoices from a vendor.',114,'IsBillTo','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2020-10-07 12:56:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-07 12:56:46','YYYY-MM-DD HH24:MI:SS'),100,916,'N','N','D','N','N','N','Y','cefbc8a2-14fb-43e0-8d14-7ff5e505f36b','Y',0,'N','N','N')
;

-- Oct 7, 2020, 12:56:52 PM CEST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2020-10-07 12:56:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214324
;

-- Oct 7, 2020, 12:57:19 PM CEST
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='Y',Updated=TO_TIMESTAMP('2020-10-07 12:57:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214323
;

-- Oct 7, 2020, 12:57:28 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2020-10-07 12:57:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214324
;

-- Oct 7, 2020, 12:57:56 PM CEST
ALTER TABLE AD_User ADD COLUMN IsBillTo CHAR(1) DEFAULT 'N' CHECK (IsBillTo IN ('Y','N')) NOT NULL
;

-- Oct 7, 2020, 12:58:05 PM CEST
ALTER TABLE AD_User ADD COLUMN IsShipTo CHAR(1) DEFAULT 'N' CHECK (IsShipTo IN ('Y','N')) NOT NULL
;

-- Oct 7, 2020, 1:02:50 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206515,'Invoice Address','Business Partner Invoice/Bill Address','If the Invoice Address is selected, the location is used to send invoices to a customer or receive invoices from a vendor.',118,214324,'Y',0,440,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-10-07 13:02:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-07 13:02:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','760d9248-fae6-41a5-a422-1599e483a4c5','Y',420,1,1,1,'N','N','N')
;

-- Oct 7, 2020, 1:03:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206516,'Ship Address','Business Partner Shipment Address','If the Ship Address is selected, the location is used to ship goods to a customer or receive goods from a vendor.',118,214323,'Y',0,450,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-10-07 13:03:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-07 13:03:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','28f0a50b-47e1-4504-a0a7-64ae64293299','Y',430,1,1,1,'N','N','N')
;

-- Oct 7, 2020, 1:04:01 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206515
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206516
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4260
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=302
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6521
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6515
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12323
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6517
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6514
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6518
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11679
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12324
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52010
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5883
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5884
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4261
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10491
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205948
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6511
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200072
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6513
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11525
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202876
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202875
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6520
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8342
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6519
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200474
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205827
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Oct 7, 2020, 1:04:02 PM CEST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- Oct 7, 2020, 1:04:53 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206515
;

-- Oct 7, 2020, 1:04:58 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206516
;

-- Oct 7, 2020, 1:05:33 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:05:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206516
;

-- Oct 7, 2020, 1:05:39 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:05:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206515
;

-- Oct 7, 2020, 1:06:28 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206517,'Ship Address','Business Partner Shipment Address','If the Ship Address is selected, the location is used to ship goods to a customer or receive goods from a vendor.',496,214323,'Y',0,240,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-10-07 13:06:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-07 13:06:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','0e3bb576-8daf-4e3a-a163-ba665c08442c','Y',240,1,1,1,'N','N','N')
;

-- Oct 7, 2020, 1:06:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206518,'Invoice Address','Business Partner Invoice/Bill Address','If the Invoice Address is selected, the location is used to send invoices to a customer or receive invoices from a vendor.',496,214324,'Y',0,250,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-10-07 13:06:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-07 13:06:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c0301624-3d0d-4f04-840d-1c01d47212aa','Y',250,1,1,1,'N','N','N')
;

-- Oct 7, 2020, 1:06:55 PM CEST
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206517
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7023
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206517
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206518
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7020
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7028
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7022
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7024
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7021
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7025
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11681
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12321
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12320
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11526
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8255
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7027
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7026
;

-- Oct 7, 2020, 1:08:42 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204608
;

-- Oct 7, 2020, 1:17:54 PM CEST
UPDATE AD_Field SET Name='Ship Contact', Description='Business Partner Shipment Contact', Help='If the Ship Contact is selected, the contact is used for notification.', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206516
;

-- Oct 7, 2020, 1:18:41 PM CEST
UPDATE AD_Field SET Name='Invoice Contact', Description='Business Partner Invoice/Bill Contact', Help='If the Invoice Contact is selected, the contact is used to send notifications about invoices to a customer or a vendor.', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:18:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206515
;

-- Oct 7, 2020, 1:17:54 PM CEST
UPDATE AD_Field SET Name='Ship Contact', Description='Business Partner Shipment Contact', Help='If the Ship Contact is selected, the contact is used for notification.', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206517
;

-- Oct 7, 2020, 1:18:41 PM CEST
UPDATE AD_Field SET Name='Invoice Contact', Description='Business Partner Invoice/Bill Contact', Help='If the Invoice Contact is selected, the contact is used to send notifications about invoices to a customer or a vendor.', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-10-07 13:18:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206518
;

SELECT register_migration_script('202010071405_IDEMPIERE-4490.sql') FROM dual
;
