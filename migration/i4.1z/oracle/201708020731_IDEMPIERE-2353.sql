SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2353 Please, add to WLocationDialog & C_Location new field Address5
-- 24.07.2017 20:26:19 MSK
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213143,1,'Flat/Office','Address Line 5 for the location','The Address 5 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.',200102,'Address5',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2017-07-24 20:26:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-07-24 20:26:19','YYYY-MM-DD HH24:MI:SS'),100,203117,'Y','N','D','N','N','N','Y','1d76a532-ff6f-4a10-a6f8-f09a4cf881e5','Y','N','N','N')
;

-- 24.07.2017 20:27:20 MSK
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213144,0,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',200102,'Comments',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2017-07-24 20:27:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-07-24 20:27:19','YYYY-MM-DD HH24:MI:SS'),100,230,'Y','N','D','N','N','N','Y','40cdc476-a73a-4822-bc8a-c17937bc9078','Y',0,'N','N')
;

-- 24.07.2017 20:27:27 MSK
ALTER TABLE C_AddressTransaction ADD Comments VARCHAR2(2000) DEFAULT NULL 
;

-- 24.07.2017 20:27:43 MSK
ALTER TABLE C_AddressTransaction ADD Address5 VARCHAR2(60) DEFAULT NULL 
;

-- 24.07.2017 20:29:51 MSK
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205139,'Flat/Office','Address Line 5 for the location','The Address 5 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.',200111,213143,'Y',22,160,'N','N','N','N',0,0,'Y',TO_DATE('2017-07-24 20:29:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-07-24 20:29:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','274fb6ef-ff02-4d8f-aabd-06f2c0165640','Y',70,1,2,1,'N','N','N')
;

-- 24.07.2017 20:30:52 MSK
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205140,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',200111,213144,'Y',0,170,0,'N','N','N','N',0,0,'Y',TO_DATE('2017-07-24 20:30:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-07-24 20:30:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9dd4eef9-4dac-4d13-9862-390ca03ea8e0','Y',160,1,1,1,'N','N','N')
;

-- 24.07.2017 20:32:17 MSK
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205139
;

-- 24.07.2017 20:32:17 MSK
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202460
;

-- 24.07.2017 20:32:17 MSK
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202459
;

-- 24.07.2017 20:32:18 MSK
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202468
;

-- 24.07.2017 20:32:18 MSK
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202464
;

-- 24.07.2017 20:32:18 MSK
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202463
;

-- 24.07.2017 20:32:18 MSK
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202465
;

-- 24.07.2017 20:32:18 MSK
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202462
;

-- 24.07.2017 20:32:18 MSK
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=5, NumLines=3, IsToolbarButton=NULL,Updated=TO_DATE('2017-07-24 20:32:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205140
;

SELECT register_migration_script('201708020731_IDEMPIERE-2353.sql') FROM dual
;

