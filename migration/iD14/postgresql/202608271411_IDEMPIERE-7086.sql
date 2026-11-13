-- IDEMPIERE-7086 Restrict Purchase of Selected Products to Approved Vendors
SELECT register_migration_script('202608271411_IDEMPIERE-7086.sql') FROM dual;

-- Aug 27, 2026, 2:11:45 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,Help,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200289,'Approved Vendor Requirement','Determines whether purchasing this product requires an approved vendor.','Use Product Category applies the approved-vendor requirement defined by the product category. Required allows the product to be purchased only from vendors explicitly approved for it. Not Required permits purchasing from any vendor, regardless of the product-category setting.','L',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:11:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:11:45','YYYY-MM-DD HH24:MI:SS'),100,'D','N','01a04322-2332-79e1-a48b-d6cf1084c1dc','N')
;

-- Aug 27, 2026, 2:12:32 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200779,'Use Product Category','Apply the approved-vendor requirement defined by the product category.',200289,'C',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:12:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:12:32','YYYY-MM-DD HH24:MI:SS'),100,'D','01a04322-d92b-7e1b-9bff-c8cf4835854c')
;

-- Aug 27, 2026, 2:13:18 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200780,'Required','The product may only be purchased from an approved vendor.',200289,'Y',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:13:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:13:17','YYYY-MM-DD HH24:MI:SS'),100,'D','01a04323-8b50-753d-9bfa-3df870346f17')
;

-- Aug 27, 2026, 2:14:39 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200781,'Not Required','The product may be purchased without an approved-vendor restriction.',200289,'N',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:14:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:14:39','YYYY-MM-DD HH24:MI:SS'),100,'D','01a04324-ca42-74e1-b3db-c63197123e05')
;

-- Aug 27, 2026, 2:18:09 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204122,0,0,'Y',TO_TIMESTAMP('2026-08-27 14:18:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:18:09','YYYY-MM-DD HH24:MI:SS'),100,'IsApprovedVendorRequired','Approved Vendor Required','Products in this category must normally be purchased from an approved vendor.','When selected, products in this category may only be purchased from vendors explicitly approved for the respective product. Individual products can override this setting.','Approved Vendor Required','D','01a04327-fd8b-7112-82f3-445c7bdafc39')
;

-- Aug 27, 2026, 2:20:49 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204123,0,0,'Y',TO_TIMESTAMP('2026-08-27 14:20:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:20:49','YYYY-MM-DD HH24:MI:SS'),100,'ApprovedVendorRequirement','Approved Vendor Requirement','Defines whether an approved vendor is required for purchasing this product.','Determines whether this product may only be purchased from an approved vendor. Use Product Category applies the setting from the product category. Required enforces vendor approval, while Not Required permits purchasing from any vendor.','Approved Vendor Requirement','D','01a0432a-6fbc-7f2c-b1e3-8b05bdefb2d0')
;

-- Aug 27, 2026, 2:22:46 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204124,0,0,'Y',TO_TIMESTAMP('2026-08-27 14:22:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:22:45','YYYY-MM-DD HH24:MI:SS'),100,'IsApprovedVendor','Approved Vendor','Indicates that this vendor is approved to supply this product when approved vendor purchasing is required.','Select this option to approve the vendor for supplying this product. This setting is independent of Current Vendor. It is evaluated only when the product requires an approved vendor. Inactive or discontinued purchasing records are not considered approved.','Approved Vendor','D','01a0432c-361f-762c-a072-49cab7b24326')
;

-- Aug 27, 2026, 2:24:59 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217656,0,'Approved Vendor Required','Products in this category must normally be purchased from an approved vendor.','When selected, products in this category may only be purchased from vendors explicitly approved for the respective product. Individual products can override this setting.',209,'IsApprovedVendorRequired','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-08-27 14:24:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:24:59','YYYY-MM-DD HH24:MI:SS'),100,204122,'Y','N','D','N','N','N','Y','01a0432e-4044-72ec-beee-8d61649b76c0','Y',0,'N','N','N','N')
;

-- Aug 27, 2026, 2:25:39 PM CEST
ALTER TABLE M_Product_Category ADD COLUMN IsApprovedVendorRequired CHAR(1) DEFAULT 'N' CHECK (IsApprovedVendorRequired IN ('Y','N')) NOT NULL
;

-- Aug 27, 2026, 2:28:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217657,0,'Approved Vendor Requirement','Defines whether an approved vendor is required for purchasing this product.','Determines whether this product may only be purchased from an approved vendor. Use Product Category applies the setting from the product category. Required enforces vendor approval, while Not Required permits purchasing from any vendor.',208,'ApprovedVendorRequirement','C',1,'N','N','Y','N','N',0,'N',17,200289,0,0,'Y',TO_TIMESTAMP('2026-08-27 14:28:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:28:38','YYYY-MM-DD HH24:MI:SS'),100,204123,'Y','N','D','N','N','N','Y','01a04331-9926-78b5-b6f9-26f070f67d8d','Y',0,'N','N','N','N')
;

-- Aug 27, 2026, 2:29:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217658,0,'Approved Vendor','Indicates that this vendor is approved to supply this product when approved vendor purchasing is required.','Select this option to approve the vendor for supplying this product. This setting is independent of Current Vendor. It is evaluated only when the product requires an approved vendor. Inactive or discontinued purchasing records are not considered approved.',210,'IsApprovedVendor','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-08-27 14:29:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:29:39','YYYY-MM-DD HH24:MI:SS'),100,204124,'Y','N','D','N','N','N','Y','01a04332-86fc-701b-9424-05ab4a8f1a21','Y',0,'N','N','N','N')
;

-- Aug 27, 2026, 2:29:43 PM CEST
ALTER TABLE M_Product_PO ADD COLUMN IsApprovedVendor CHAR(1) DEFAULT 'N' CHECK (IsApprovedVendor IN ('Y','N')) NOT NULL
;

-- Aug 27, 2026, 2:30:15 PM CEST
ALTER TABLE M_Product ADD COLUMN ApprovedVendorRequirement CHAR(1) DEFAULT 'C' NOT NULL
;

-- Aug 27, 2026, 2:31:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209241,'Approved Vendor Required','Products in this category must normally be purchased from an approved vendor.','When selected, products in this category may only be purchased from vendors explicitly approved for the respective product. Individual products can override this setting.',189,217656,'Y',1,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:31:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:31:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a04333-f68d-76d4-b52c-d84cb9e534bd','Y',130,2,2)
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50181
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11203
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=5,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209241
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3748
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8614
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4459
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6134
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10261
;

-- Aug 27, 2026, 2:32:49 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-08-27 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204948
;

-- Aug 27, 2026, 2:33:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209242,'Approved Vendor Requirement','Defines whether an approved vendor is required for purchasing this product.','Determines whether this product may only be purchased from an approved vendor. Use Product Category applies the setting from the product category. Required enforces vendor approval, while Not Required permits purchasing from any vendor.',180,217657,'Y',1,630,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:33:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a04336-3d75-70f8-b329-10db22e6f64f','Y',630,2)
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=470, XPosition=1,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209242
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=480,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1568
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=490,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1569
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=500,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5381
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=510,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5383
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12418
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=530,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5910
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=540,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5911
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=550,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6130
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=560,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8307
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=570,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6343
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=580,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6344
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=590,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58973
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=600,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8608
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=610,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8613
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=620,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52015
;

-- Aug 27, 2026, 2:36:18 PM CEST
UPDATE AD_Field SET SeqNo=630,Updated=TO_TIMESTAMP('2026-08-27 14:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52016
;

-- Aug 27, 2026, 2:38:19 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209243,'Approved Vendor','Indicates that this vendor is approved to supply this product when approved vendor purchasing is required.','Select this option to approve the vendor for supplying this product. This setting is independent of Current Vendor. It is evaluated only when the product requires an approved vendor. Inactive or discontinued purchasing records are not considered approved.',239,217658,'Y',1,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:38:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:38:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a0433a-7363-7cdd-a20c-450844c2de5d','Y',270,2,2)
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=5,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209243
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3818
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2898
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2322
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2899
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2900
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5912
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2321
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5333
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2310
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2319
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2320
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3291
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3290
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3289
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2314
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2313
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5913
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2311
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2312
;

-- Aug 27, 2026, 2:39:42 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-08-27 14:39:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202930
;

-- Aug 27, 2026, 2:41:18 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Product "{0}" must be purchased from an approved vendor. Vendor "{1}" is not approved for this product.',0,0,'Y',TO_TIMESTAMP('2026-08-27 14:41:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-27 14:41:18','YYYY-MM-DD HH24:MI:SS'),100,201054,'ProductNotApprovedForVendor','D','01a0433d-2f29-7f59-a266-70986668c002')
;

-- Aug 27, 2026, 2:44:00 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsPurchased@=''Y''',Updated=TO_TIMESTAMP('2026-08-27 14:44:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209242
;
