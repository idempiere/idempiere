SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2999 Attribute, Table Direct and date field support
-- Mar 3, 2016 11:15:59 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200352,'Reference','Reference',326,'R',0,0,'Y',TO_DATE('2016-03-03 11:15:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 11:15:58','YYYY-MM-DD HH24:MI:SS'),100,'D','57503d9a-9bd2-4eb9-b2cf-1f43dc144dcc')
;

-- Mar 3, 2016 11:16:56 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212643,0,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',562,'AD_Reference_ID',22,'N','N','N','N','N',0,'N',18,1,0,0,'Y',TO_DATE('2016-03-03 11:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 11:16:55','YYYY-MM-DD HH24:MI:SS'),100,120,'Y','N','D','N','N','N','Y','30425bec-829d-4fdd-9781-be453810859b','Y',0,'N','N','N')
;

-- Mar 3, 2016 11:16:59 AM IST
UPDATE AD_Column SET FKConstraintName='ADReference_MAttribute', FKConstraintType='N',Updated=TO_DATE('2016-03-03 11:16:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212643
;

-- Mar 3, 2016 11:16:59 AM IST
ALTER TABLE M_Attribute ADD AD_Reference_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2016 11:16:59 AM IST
ALTER TABLE M_Attribute ADD CONSTRAINT ADReference_MAttribute FOREIGN KEY (AD_Reference_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2016 11:17:19 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212644,0,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',562,115,'AD_Reference_Value_ID',22,'N','N','N','N','N',0,'N',18,4,0,0,'Y',TO_DATE('2016-03-03 11:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 11:17:19','YYYY-MM-DD HH24:MI:SS'),100,121,'Y','N','D','N','N','N','Y','4773b14c-3fd5-4a27-b612-f2c055e30906','Y',0,'N','N','N')
;

-- Mar 3, 2016 11:17:28 AM IST
UPDATE AD_Column SET FKConstraintName='ADReferenceValue_MAttribute', FKConstraintType='N',Updated=TO_DATE('2016-03-03 11:17:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212644
;

-- Mar 3, 2016 11:17:28 AM IST
ALTER TABLE M_Attribute ADD AD_Reference_Value_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2016 11:17:28 AM IST
ALTER TABLE M_Attribute ADD CONSTRAINT ADReferenceValue_MAttribute FOREIGN KEY (AD_Reference_Value_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2016 11:25:44 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204143,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',462,212643,'Y','@AttributeValueType@=''R''',0,90,0,'N','N','N','N',0,0,'Y',TO_DATE('2016-03-03 11:25:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 11:25:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6662da7e-b41c-44d0-aa42-edc15857a9f3','Y',100,1,1,1,'N','N','N')
;

-- Mar 3, 2016 11:38:57 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204144,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',462,212644,'Y','@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 & @AttributeValueType@=''R''',0,100,0,'N','N','N','N',0,0,'Y',TO_DATE('2016-03-03 11:38:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 11:38:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0ac3e965-019d-4da4-a8c5-7fa0ced885fa','Y',110,1,1,1,'N','N','N')
;

-- Mar 3, 2016 11:39:18 AM IST
UPDATE AD_Field SET SeqNo=90, ColumnSpan=2,Updated=TO_DATE('2016-03-03 11:39:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204143
;

-- Mar 3, 2016 11:39:18 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4, ColumnSpan=2,Updated=TO_DATE('2016-03-03 11:39:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Mar 3, 2016 11:40:04 AM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200090,'AD_Reference Attribute','S','AD_Reference_ID IN (10,11,12,13,14,15,16,17,18,19,20,22,24,25,27,29,30,31,32,33,34,36,37,38,39,40)',0,0,'Y',TO_DATE('2016-03-03 11:40:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 11:40:03','YYYY-MM-DD HH24:MI:SS'),100,'D','df9e32eb-59df-49b8-a7fa-a6fb9c1f6786')
;

-- Mar 3, 2016 11:40:25 AM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200090,Updated=TO_DATE('2016-03-03 11:40:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212643
;

-- Sep 18, 2020, 10:02:10 PM IST
UPDATE AD_Tab SET ReadOnlyLogic='@AttributeValueType@!L',Updated=TO_DATE('2020-09-18 22:02:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=463
;

-- Sep 21, 2020, 3:02:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214317,0,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',562,'AD_Val_Rule_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2020-09-21 15:02:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-21 15:02:00','YYYY-MM-DD HH24:MI:SS'),100,139,'Y','N','D','N','N','N','Y','6e0bea95-2518-4833-b8c4-3c65f94b07ea','Y',0,'N','N','N','N')
;

-- Sep 21, 2020, 3:02:14 PM IST
UPDATE AD_Column SET FKConstraintName='ADValRule_MAttribute', FKConstraintType='N',Updated=TO_DATE('2020-09-21 15:02:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214317
;

-- Sep 21, 2020, 3:02:14 PM IST
ALTER TABLE M_Attribute ADD AD_Val_Rule_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 21, 2020, 3:02:14 PM IST
ALTER TABLE M_Attribute ADD CONSTRAINT ADValRule_MAttribute FOREIGN KEY (AD_Val_Rule_ID) REFERENCES ad_val_rule(ad_val_rule_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 21, 2020, 3:04:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206510,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',462,214317,'Y','@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 & @AttributeValueType@=''R''',0,110,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-21 15:04:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-21 15:04:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','544966ca-d50d-4481-ae43-cc56b1a0c478','Y',120,4,2,1,'N','N','N')
;

-- Sep 21, 2020, 3:04:50 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-21 15:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Sep 21, 2020, 3:04:50 PM IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-21 15:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206510
;

-- Sep 21, 2020, 3:04:50 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-21 15:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204868
;

-- Sep 21, 2020, 3:09:42 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-21 15:09:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Sep 21, 2020, 3:09:42 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-21 15:09:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203472
;

SELECT register_migration_script('201602171713_IDEMPIERE-2999.sql') FROM dual
;
