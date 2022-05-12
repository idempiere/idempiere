SELECT register_migration_script('202204280337_IDEMPIERE-5260.sql') FROM dual
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 27, 2022 6:33:58 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203079,'FixedPrice',TO_DATE('2022-04-27 18:33:57','YYYY-MM-DD HH24:MI:SS'),'Fixed Price','Fixed Price for Product','Fixed Price','9b4054b1-0202-4025-92a1-0778028c124e','Y',TO_DATE('2022-04-27 18:33:57','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 27, 2022 6:35:29 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213025,0,'N',0,'N','N','N',0,'N',10,'N','N','N','Y','670c6edf-b9f2-4a6f-9dd4-4af4daea32ac',TO_DATE('2022-04-27 18:35:28','YYYY-MM-DD HH24:MI:SS'),'Y','FixedPrice','Fixed Price for Product','Fixed Price','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-27 18:35:28','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203079,476,37,'N')
;

-- Apr 27, 2022 6:35:37 PM GMT+08:00
ALTER TABLE M_DiscountSchemaBreak ADD FixedPrice NUMBER DEFAULT 0 
;

-- Apr 27, 2022 6:37:03 PM GMT+08:00
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204441,'N',0,'N','N',110,'Y','N',0,TO_DATE('2022-04-27 18:37:02','YYYY-MM-DD HH24:MI:SS'),'Fixed Price for Product','Fixed Price','d1c77e14-5d3d-4b0f-97f3-b800db7063b4','Y','N',100,100,'Y','Y',110,1,'N',0,TO_DATE('2022-04-27 18:37:02','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213025,'D',406)
;

-- Apr 27, 2022 6:37:59 PM GMT+08:00
UPDATE AD_Field SET SeqNo=100, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=1, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-27 18:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5279
;

-- Apr 27, 2022 6:39:22 PM GMT+08:00
UPDATE AD_Field SET DisplayLogic='@IsBPartnerFlatDiscount@=N&@FixedPrice@=0', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-27 18:39:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5279
;

-- Apr 27, 2022 6:40:12 PM GMT+08:00
UPDATE AD_Field SET DisplayLogic='@IsBPartnerFlatDiscount@=N&@BreakDiscount@=0', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-27 18:40:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204441
;

-- Apr 27, 2022 6:40:25 PM GMT+08:00
UPDATE AD_Column SET DefaultValue='0',Updated=TO_DATE('2022-04-27 18:40:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213025
;

