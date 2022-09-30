-- IDEMPIERE-5434
SELECT register_migration_script('202209290713_IDEMPIERE-5434.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 29, 2022, 7:13:48 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,AD_InfoWindow_ID) VALUES (215407,0,'Distinct','Select Distinct',200087,'IsDistinct','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-09-29 07:13:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-29 07:13:47','YYYY-MM-DD HH24:MI:SS'),100,202186,'Y','N','D','N','N','N','Y','14b4fad8-0f5d-415e-8c55-e8d2490952ea','Y',0,'N','N','N',200000)
;

-- Sep 29, 2022, 7:13:52 AM CEST
ALTER TABLE AD_ViewComponent ADD IsDistinct CHAR(1) DEFAULT 'N' CHECK (IsDistinct IN ('Y','N')) NOT NULL
;

-- Sep 29, 2022, 7:14:09 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207286,'Distinct','Select Distinct',200098,215407,'Y',1,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-29 07:14:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-29 07:14:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ba2ad5f7-84c3-4e71-b78b-186094505a91','Y',130,2,2)
;

-- Sep 29, 2022, 7:14:26 AM CEST
UPDATE AD_Field SET SeqNo=90, ColumnSpan=1,Updated=TO_TIMESTAMP('2022-09-29 07:14:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206814
;

-- Sep 29, 2022, 7:14:26 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=6, ColumnSpan=1,Updated=TO_TIMESTAMP('2022-09-29 07:14:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207286
;

-- Sep 29, 2022, 7:14:26 AM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2022-09-29 07:14:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202235
;

-- Sep 29, 2022, 7:14:26 AM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2022-09-29 07:14:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202234
;

-- Sep 29, 2022, 7:14:26 AM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2022-09-29 07:14:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202231
;

-- Sep 29, 2022, 7:14:26 AM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2022-09-29 07:14:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202229
;

-- Sep 29, 2022, 7:14:26 AM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2022-09-29 07:14:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202232
;

