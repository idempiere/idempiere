-- IDEMPIERE-4479
-- Jun 3, 2021, 1:36:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214499,0,'Column SQL','Virtual Column (r/o)','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days',107,'ColumnSQL',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-06-03 13:36:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-03 13:36:38','YYYY-MM-DD HH24:MI:SS'),100,2699,'Y','N','D','N','N','N','Y','5726e9db-774b-4257-956e-ae067fb23f33','Y',0,'N','N','N')
;

-- Jun 3, 2021, 1:36:42 PM CEST
ALTER TABLE AD_Field ADD COLUMN ColumnSQL VARCHAR(255) DEFAULT NULL 
;

-- Jun 3, 2021, 1:37:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206665,'Column SQL','Virtual Column (r/o)','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days',107,214499,'Y',255,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-06-03 13:37:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-03 13:37:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f2dc4a54-a4c2-4be4-83b4-0134783c12cd','Y',490,5)
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=924
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=133
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206665
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=500, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

SELECT Register_Migration_Script ('202106031340_IDEMPIERE-4479.sql') FROM DUAL
;
