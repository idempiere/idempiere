SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3855 Implement AD_Tree.IsValueDisplayed
-- Dec 26, 2018, 2:00:58 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (213822,0,'Display Value','Displays Value column with the Display column','The Display Value checkbox indicates if the value column will display with the display column.',288,'IsValueDisplayed','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2018-12-26 14:00:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-12-26 14:00:58','YYYY-MM-DD HH24:MI:SS'),100,284,'Y','N','D','N','N','N','Y','2894fcac-3036-489d-8976-2f8bb178ecae','Y',0,'N','N','N')
;

-- Dec 26, 2018, 2:01:02 PM CET
ALTER TABLE AD_Tree ADD IsValueDisplayed CHAR(1) DEFAULT 'N' CHECK (IsValueDisplayed IN ('Y','N')) NOT NULL
;

-- Dec 26, 2018, 2:02:36 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205898,'Display Value','Displays Value column with the Display column','The Display Value checkbox indicates if the value column will display with the display column.',243,213822,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2018-12-26 14:02:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-12-26 14:02:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1f428273-321c-4514-8f62-29d600deda79','Y',120,2,2)
;

-- Dec 26, 2018, 2:03:06 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-26 14:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205898
;

-- Dec 26, 2018, 2:03:06 PM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-26 14:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5228
;

-- Dec 26, 2018, 2:03:06 PM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-26 14:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12421
;

-- Dec 26, 2018, 2:03:06 PM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-26 14:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204379
;

-- Dec 26, 2018, 2:03:06 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-26 14:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8371
;

-- Dec 26, 2018, 2:03:54 PM CET
UPDATE AD_Field SET Name='Display Search Key', Description='Displays Search Key in the tree', Help='The Display Search Key checkbox indicates if the Search Key will display in the tree before the Name', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-26 14:03:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205898
;

UPDATE AD_Tree SET IsValueDisplayed='Y' WHERE IsValueDisplayed='N' AND IsTreeDrivenByValue='Y';

SELECT register_migration_script('201812261404_IDEMPIERE-3855.sql') FROM dual
;

