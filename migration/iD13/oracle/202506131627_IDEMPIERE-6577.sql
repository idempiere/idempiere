-- IDEMPIERE-6577 - Import Payment and Import Invoice
SELECT register_migration_script('202506131627_IDEMPIERE-6577.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 13, 2025, 4:28:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217116,0,'Description','Optional short description of the record','A description is limited to 255 characters.',597,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:23','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','7869ace2-5c1b-4a82-a8e2-3f2c308398ac','Y',10,'N','N','N','N','N')
;

-- Jun 13, 2025, 4:28:25 PM IST
ALTER TABLE I_Payment ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jun 13, 2025, 4:28:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217117,0,'Activity','Business Activity','Activities indicate tasks that are performed and used to utilize Activity based Costing',597,'C_Activity_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:25','YYYY-MM-DD HH24:MI:SS'),100,1005,'Y','N','D','Y','N','N','Y','f9e85ece-c9ce-4a60-baf9-b8597ab7a4b2','Y',0,'N','N','CActivity_IPayment','N','N','N')
;

-- Jun 13, 2025, 4:28:25 PM IST
ALTER TABLE I_Payment ADD C_Activity_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 13, 2025, 4:28:28 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217120,1,'Activity Key','Text key for Activity',597,'ActivityValue',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:27','YYYY-MM-DD HH24:MI:SS'),100,53222,'Y','N','D','Y','N','N','N','cc3302a6-4eb1-4416-89e1-30e2c69700c9','Y','N','N','N','N','N')
;

-- Jun 13, 2025, 4:28:28 PM IST
ALTER TABLE I_Payment ADD ActivityValue VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Jun 13, 2025, 4:28:33 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208779,'Description','Optional short description of the record','A description is limited to 255 characters.',511,217116,'Y',255,95,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b42cd2e0-4f77-41f1-9f8d-feac2477ec68','Y',550,1,5,1,'N','N','N','N')
;

-- Jun 13, 2025, 4:28:34 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208780,'Activity Key','Text key for Activity',511,217120,'Y',40,560,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0c7c9029-aad7-47a9-8562-0563781e7d90','Y',590,1,2,1,'N','N','N','N')
;

-- Jun 13, 2025, 4:28:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208781,'Activity','Business Activity','Activities indicate tasks that are performed and used to utilize Activity based Costing',511,217117,'Y',22,570,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2c06f8de-3b32-47e8-b90f-9679bc4ad4fb','Y',560,4,2,1,'N','N','N','N')
;

-- Jun 13, 2025, 4:28:40 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217123,0,'ISO Currency Code','Three letter ISO 4217 Code of the Currency','For details - http://www.unece.org/trade/rec/rec09en.htm',598,'ISO_Code',3,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:39','YYYY-MM-DD HH24:MI:SS'),100,328,'Y','N','D','Y','N','N','Y','6ae05fbb-8bb1-4d4d-9368-720938043602','Y',0,'N','N','N','N','N')
;

-- Jun 13, 2025, 4:28:40 PM IST
ALTER TABLE I_Invoice ADD ISO_Code VARCHAR2(3 CHAR) DEFAULT NULL 
;

-- Jun 13, 2025, 4:28:40 PM IST
UPDATE AD_Field SET SeqNo=133, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL, AD_Chart_ID=NULL,Updated=TO_TIMESTAMP('2025-06-13 16:28:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7234
;

-- Jun 13, 2025, 4:28:40 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208786,'ISO Currency Code','Three letter ISO 4217 Code of the Currency','For details - http://www.unece.org/trade/rec/rec09en.htm',510,217123,'Y',3,135,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-13 16:28:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-13 16:28:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9e343091-8fd0-4ed2-9c38-1a536d51c12f','Y',580,1,2,1,'N','N','N','N')
;

-- Jun 13, 2025, 4:28:40 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, XPosition=4, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL, AD_Chart_ID=NULL,Updated=TO_TIMESTAMP('2025-06-13 16:28:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7223
;

-- Jun 13, 2025, 4:28:40 PM IST
ALTER TABLE I_Payment ADD CONSTRAINT CActivity_IPayment FOREIGN KEY (C_Activity_ID) REFERENCES c_activity(c_activity_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 13, 2025, 4:28:40 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=580, XPosition=1, ColumnSpan=2,Updated=TO_TIMESTAMP('2025-06-13 16:28:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7293
;

-- Jun 13, 2025, 4:28:40 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=590, XPosition=4,Updated=TO_TIMESTAMP('2025-06-13 16:28:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7299
;