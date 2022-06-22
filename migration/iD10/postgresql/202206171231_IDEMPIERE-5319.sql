-- IDEMPIERE-5319
SELECT register_migration_script('202206171231_IDEMPIERE-5319.sql') FROM dual;

-- Jun 17, 2022, 12:31:33 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203602,0,0,'Y',TO_TIMESTAMP('2022-06-17 12:31:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-17 12:31:33','YYYY-MM-DD HH24:MI:SS'),100,'DeleteConfirmationLogic','Delete Confirmation Logic','Delete Confirmation Logic','D','1ffaa85d-527c-4e37-9472-3f9e74d8fd1e')
;

-- Jun 17, 2022, 12:33:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214937,0,'Delete Confirmation Logic',106,'DeleteConfirmationLogic',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-06-17 12:33:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-17 12:33:31','YYYY-MM-DD HH24:MI:SS'),100,203602,'Y','N','D','N','N','N','Y','c478ffba-25a8-4010-b77b-007286df5403','Y',0,'N','N','N','N')
;

-- Jun 17, 2022, 12:34:23 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214938,0,'Delete Confirmation Logic',466,'DeleteConfirmationLogic',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-06-17 12:34:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-17 12:34:23','YYYY-MM-DD HH24:MI:SS'),100,203602,'Y','N','D','N','N','N','Y','124d81e0-1c59-4583-8c94-d2983184bc92','Y',0,'N','N','N','N')
;

-- Jun 17, 2022, 2:14:19 PM CEST
ALTER TABLE AD_Tab ADD COLUMN DeleteConfirmationLogic VARCHAR(255) DEFAULT NULL 
;

-- Jun 17, 2022, 2:14:42 PM CEST
ALTER TABLE AD_UserDef_Tab ADD COLUMN DeleteConfirmationLogic VARCHAR(255) DEFAULT NULL 
;

-- Jun 17, 2022, 2:27:18 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207079,'Delete Confirmation Logic',106,214937,'Y',0,390,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-17 14:27:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-17 14:27:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','58f3879f-6b9b-4f75-8f84-b3c654eff5f2','Y',360,1,1,1,'N','N','N','N')
;

-- Jun 17, 2022, 2:28:56 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207079
;

-- Jun 17, 2022, 2:28:57 PM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1548
;

-- Jun 17, 2022, 2:28:57 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1550
;

-- Jun 17, 2022, 2:28:57 PM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1549
;

-- Jun 17, 2022, 2:28:57 PM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4956
;

-- Jun 17, 2022, 2:28:57 PM CEST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

-- Jun 17, 2022, 2:28:57 PM CEST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5131
;

-- Jun 17, 2022, 2:28:57 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:28:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3205
;

-- Jun 17, 2022, 2:29:57 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207080,'Delete Confirmation Logic',394,214938,'Y',0,190,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-17 14:29:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-17 14:29:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','77efa46f-f83b-4ca8-87cc-375e26d3084f','Y',190,1,1,1,'N','N','N','N')
;

-- Jun 17, 2022, 2:30:46 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207080
;

-- Jun 17, 2022, 2:30:46 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205833
;

-- Jun 17, 2022, 2:30:46 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200003
;

-- Jun 17, 2022, 2:30:46 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205828
;

-- Jun 17, 2022, 2:30:46 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-17 14:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205830
;

-- Jun 17, 2022, 2:50:13 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do you want to delete the record?<br />
Please confirm by typing: <b>{0}<b/>',0,0,'Y',TO_TIMESTAMP('2022-06-17 14:50:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-17 14:50:13','YYYY-MM-DD HH24:MI:SS'),100,200763,'DeleteRecordWithConfirm?','D','f95200bf-125c-4d7e-a157-79cd1971905d')
;

-- Jun 21, 2022, 10:32:12 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do you want to delete {0} (selected) items?<br />
Please confirm by typing: <b>{1}<b/>',0,0,'Y',TO_TIMESTAMP('2022-06-21 10:32:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 10:32:11','YYYY-MM-DD HH24:MI:SS'),100,200764,'DeleteSelectionWithConfirm?','D','850eaab7-0ae9-48db-8232-80af712b5024')
;

-- Jun 22, 2022, 1:16:31 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Entered Value Is Not Correct',0,0,'Y',TO_TIMESTAMP('2022-06-22 13:16:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-22 13:16:30','YYYY-MM-DD HH24:MI:SS'),100,200765,'ValueNotCorrect','D','a8be89f0-367c-4f4b-8df8-62b6da3f3f2e')
;

