-- IDEMPIERE-4452
-- Sep 17, 2020, 8:08:18 AM UTC
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203439,0,0,'Y',TO_TIMESTAMP('2020-09-17 08:08:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-17 08:08:17','YYYY-MM-DD HH24:MI:SS'),100,'IsIgnoreIsCurrentVendor','Ignore Current Vendor Flag','take all PO prices into account','will use PO price even if it is not marked as current vendor','Ignore Current Vendor Flag','D','2db796b8-1da0-4c9f-b49f-7c63659b5de3')
;

-- Sep 17, 2020, 8:15:42 AM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214315,0,'Ignore Current Vendor Flag','take all PO prices into account','will use PO price even if it is not marked as current vendor',477,'IsIgnoreIsCurrentVendor','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2020-09-17 08:15:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-17 08:15:41','YYYY-MM-DD HH24:MI:SS'),100,203439,'Y','N','D','N','N','N','Y','713ddf8e-f924-46a7-a9c2-11003c399dad','Y',0,'N','N','N','N')
;

-- Sep 17, 2020, 8:16:18 AM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214316,0,'Partner Category','Product Category of the Business Partner','The Business Partner Category identifies the category used by the Business Partner for this product.',477,'VendorCategory',30,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2020-09-17 08:16:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-17 08:16:18','YYYY-MM-DD HH24:MI:SS'),100,622,'Y','N','D','N','N','N','Y','d3bd3b17-d48d-43d7-9d79-f58aad219bcc','Y',0,'N','N','N')
;

-- Sep 17, 2020, 8:19:51 AM UTC
ALTER TABLE M_DiscountSchemaLine ADD COLUMN IsIgnoreIsCurrentVendor CHAR(1) DEFAULT 'N' CHECK (IsIgnoreIsCurrentVendor IN ('Y','N')) NOT NULL
;

-- Sep 17, 2020, 8:20:37 AM UTC
ALTER TABLE M_DiscountSchemaLine ADD COLUMN VendorCategory VARCHAR(30) DEFAULT NULL 
;


-- Sep 17, 2020, 8:22:08 AM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206508,'Ignore Current Vendor Flag','take all PO prices into account','will use PO price even if it is not marked as current vendor',405,214315,'Y',1,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-17 08:22:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-17 08:22:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0474c725-58a1-48ec-8f41-b82b3d058aeb','Y',350,2,2)
;

-- Sep 17, 2020, 8:22:09 AM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206509,'Partner Category','Product Category of the Business Partner','The Business Partner Category identifies the category used by the Business Partner for this product.',405,214316,'Y',30,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-17 08:22:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-17 08:22:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e6507320-a3e5-4188-b57a-63ff234e2e26','Y',360,2)
;

-- Sep 17, 2020, 8:25:08 AM UTC
UPDATE AD_Field SET SeqNo=95, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=85, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-17 08:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206508
;

-- Sep 17, 2020, 8:29:13 AM UTC
UPDATE AD_Field SET DisplayLogic='@DiscountType@=P & @C_BPartner_ID@!0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-17 08:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206508
;

-- Sep 17, 2020, 8:30:14 AM UTC
UPDATE AD_Field SET SeqNo=145, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=135, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-17 08:30:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206509
;

-- Sep 17, 2020, 8:45:45 AM UTC
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-17 08:45:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206508
;

SELECT register_migration_script('202009171400_IDEMPIERE-4452.sql') FROM dual
;
