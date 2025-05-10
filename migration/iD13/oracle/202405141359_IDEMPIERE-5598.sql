-- IDEMPIERE-5598: Add new Accounting Dimensions
SELECT register_migration_script('202405141359_IDEMPIERE-5598.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF
-- Jan 22, 2024, 1:59:10 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200692,'Charge','Additional document charges',181,'CH',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,'D','ff70fb90-e8eb-4db1-9239-63d31cad4a74')
;

-- Jan 22, 2024, 1:59:10 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200693,'Asset','Asset used internally or by customers',181,'AS',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,'D','79e02baa-3ecd-4c41-81d3-7b97b5ea8cc1')
;

-- Jan 22, 2024, 1:59:10 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200694,'Warehouse','Storage Warehouse and Service Point',181,'WH',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,'D','50ae79bd-6fa9-42b0-bafd-fd980cf9a905')
;

-- Jan 22, 2024, 1:59:10 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200695,'Employee',' Business Partner is an employee',181,'EP',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,'D','6d4e0423-45c4-4396-90a3-f7b158c60377')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200696,'Department','Department',181,'DP',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'D','a9912365-fa71-4cff-ab8d-3c4236797b8f')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200697,'Cost Center','Cost Center',181,'CC',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'D','dfc1bcd1-1d43-44b4-9aa4-d0b6089f6b01')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200698,'Custom Field 1','Custom Field 1',181,'F1',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'D','8105488b-8d42-4532-97f9-beaf17bdc7a4')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200699,'Custom Field 2','Custom Field 2',181,'F2',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'D','2c84ba63-d47b-4be2-80f6-7968de8f043d')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200700,'Custom Field 3','Custom Field 3',181,'F3',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'D','c2b68210-20d9-4452-b296-4586596f1959')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200701,'Custom Field 4','Custom Field 4',181,'F4',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'D','e43566fb-3d23-410c-bd57-cd19efd76390')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216316,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',279,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','Y','N','N','Y','b6803253-c659-4cb1-ac15-19e3182b814e','Y',0,'N','N','CCharge_CAcctSchemaElement','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216317,0,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',279,'A_Asset_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,1884,'Y','N','D','Y','N','N','Y','dc8e7b19-e130-4a73-ada1-1ee8f0c212bf','Y',0,'N','N','AAsset_CAcctSchemaElement','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD A_Asset_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216318,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',279,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','Y','N','N','Y','c57c1321-e7f0-43d8-905d-c51e748a2aaa','Y',0,'N','N','MWarehouse_CAcctSchemaElement','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD M_Warehouse_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203892,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'AD_Column2_ID','Column 2','Column in the table','Link to the database column of the table','Column 2','D','12a729fa-1f2f-4f3f-b2d1-4be21738e859')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200184,'AD_Column with datatype string','Only columns with text datatypes','S','AD_Column.AD_Reference_ID IN (10,14,36)',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'D','ed94bbb4-fc4c-491f-b82c-f21f748d6a60')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216319,0,'Column 2','Column in the table','Link to the database column of the table',279,200184,'AD_Column2_ID',10,'N','N','N','N','N',0,'N',18,3,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203892,'Y','N','D','Y','N','N','Y','552eb09a-1ce5-4002-8aba-a9c1168cdc7d','Y',0,'N','N','ADColumn2_CAcctSchemaElement','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD AD_Column2_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203893,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'C_Employee_ID','Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Employee','D','4d9f38d2-bcd9-4b27-90c6-6977d55ecab1')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216320,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',279,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','Y','N','N','Y','812c0b8d-9ec9-4bec-bd58-f1afbb4fd9d4','Y',0,'N','N','CEmployee_CAcctSchemaE','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD C_Employee_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208103,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',217,216316,'Y','@ElementType@=''CH''',10,210,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dfb6c507-92ad-48d8-9f58-55b82d81f78d','Y',210,1,2,1,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208104,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',217,216317,'Y','@ElementType@=''AS''',22,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6496b288-65b4-447d-8b91-41879af379b2','Y',220,1,2,1,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208105,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',217,216318,'Y','@ElementType@=''WH''',22,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','088cc13b-7d19-4095-8832-d09c8e482f86','Y',230,1,2,1,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208106,'Column 2','Column in the table','Link to the database column of the table',217,216319,'Y','@ElementType@=''F1'' | @ElementType@=''F2'' | @ElementType@=''F3'' | @ElementType@=''F4''',10,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ea490bc8-361b-4c3a-8ac3-1c72502a7576','Y',240,1,2,1,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208107,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',217,216320,'Y','@ElementType@=''EP''',10,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','31bf76f0-653b-4b26-b610-37b0d2208df6','Y',250,1,2,1,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216337,0,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',53203,'A_Asset_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,1884,'Y','N','D','Y','N','N','N','303d1d3b-b890-4055-a037-a4b707167466','Y',0,'N','N','AAsset_FactAcctSummary','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD A_Asset_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216338,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',53203,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','Y','N','N','N','2b9f4ea7-8be0-4fe0-8628-8372fb3eccf6','Y',0,'N','N','CEmployee_FactAcctSumm','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD C_Employee_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216339,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',53203,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','Y','N','N','N','1a0ce46d-8e8f-469e-9546-3a03fc860c6b','Y',0,'N','N','CCharge_FactAcctSummary','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216340,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',53203,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','Y','N','N','N','2945d901-c32f-4159-8d22-e80ea1027634','Y',0,'N','N','MWarehouse_FactAcctSummary','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD M_Warehouse_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203894,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'CustomFieldText1','Custom FieldText 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Custom FieldText 1','D','2fa1a0bf-63a4-4f75-896f-320e61a83adb')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216341,0,'Custom FieldText 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',53203,'CustomFieldText1',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203894,'Y','N','D','Y','N','N','N','2785d480-1d5b-49fe-9ed5-3094b185c2dd','Y',0,'N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CustomFieldText1 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203895,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'CustomFieldText2','Custom FieldText 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Custom FieldText 2','D','6f12ae1c-b116-4897-a584-a1bda40eb823')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216342,0,'Custom FieldText 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',53203,'CustomFieldText2',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203895,'Y','N','D','Y','N','N','N','e22a921a-309f-421b-95f4-4c09f1b7e90d','Y',0,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CustomFieldText2 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203896,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'CustomFieldText3','Custom FieldText 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Custom FieldText 3','D','693ec085-48b2-41e9-9760-06e2292b4494')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216343,0,'Custom FieldText 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',53203,'CustomFieldText3',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203896,'Y','N','D','Y','N','N','N','bdc826b0-95da-4126-80d9-41798aa5a33f','Y',0,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CustomFieldText3 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203897,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,'CustomFieldText4','Custom FieldText 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Custom FieldText 4','D','c9fcfe1f-5e82-482d-974b-a513d974385b')
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216344,0,'Custom FieldText 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',53203,'CustomFieldText4',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203897,'Y','N','D','Y','N','N','N','5cf725b1-bc21-4142-ae5a-709694e2eb35','Y',0,'N','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CustomFieldText4 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml) VALUES (216321,0,'Custom FieldText 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',270,'CustomFieldText1',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203894,'Y','N','D','Y','N','N','N','ec38b5a0-1278-4485-8d6f-236cd0a16870','Y','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD CustomFieldText1 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml) VALUES (216322,0,'Custom FieldText 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',270,'CustomFieldText2',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203895,'Y','N','D','Y','N','N','N','20ba7c7a-b4c4-4aa1-b1e0-2a82efacc3f2','Y','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD CustomFieldText2 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml) VALUES (216323,0,'Custom FieldText 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',270,'CustomFieldText3',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203896,'Y','N','D','Y','N','N','N','9868105f-02f3-46b2-bcfa-19b347598ffe','Y','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD CustomFieldText3 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml) VALUES (216324,0,'Custom FieldText 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',270,'CustomFieldText4',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203897,'Y','N','D','Y','N','N','N','5a61b7ef-ee41-41d2-8e93-1ae72b85aec5','Y','N','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD CustomFieldText4 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216334,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',270,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','Y','N','N','N','9acf1787-825e-4caa-9fc9-eafb6870271f','Y',0,'N','N','CCharge_FactAcct','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216335,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',270,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','Y','N','N','N','87cb6019-1a71-4ba0-a17b-74054bd39955','Y',0,'N','N','MWarehouse_FactAcct','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD M_Warehouse_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216336,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',270,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 13:59:11','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','Y','N','N','N','ab447b6e-24e2-49f2-b77b-ee0b460bf5eb','Y',0,'N','N','CEmployee_FactAcct','N','N')
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD C_Employee_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT CCharge_CAcctSchemaElement FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT AAsset_CAcctSchemaElement FOREIGN KEY (A_Asset_ID) REFERENCES a_asset(a_asset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT MWarehouse_CAcctSchemaElement FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT ADColumn2_CAcctSchemaElement FOREIGN KEY (AD_Column2_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT CEmployee_CAcctSchemaE FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT AAsset_FactAcctSummary FOREIGN KEY (A_Asset_ID) REFERENCES a_asset(a_asset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT CEmployee_FactAcctSumm FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT CCharge_FactAcctSummary FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT MWarehouse_FactAcctSummary FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD CONSTRAINT CCharge_FactAcct FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD CONSTRAINT MWarehouse_FactAcct FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 22, 2024, 1:59:11 PM IST
ALTER TABLE Fact_Acct ADD CONSTRAINT CEmployee_FactAcct FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 23, 2024, 3:04:00 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200413,'Department','C_Department',0,'3',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:03:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:03:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','da1215f1-4837-4e17-9af5-97f3ed712de7','N','N','N','N','N')
;

-- Jan 23, 2024, 3:04:00 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_Department',1000000,'N','N','Table C_Department','Y','Y',0,0,TO_TIMESTAMP('2024-01-23 15:04:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:04:00','YYYY-MM-DD HH24:MI:SS'),100,200484,'Y',1000000,1,200000,'c2e852f6-44d3-418f-9537-ad37a232bc31')
;

-- Jan 23, 2024, 3:07:08 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203901,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:07:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:07:07','YYYY-MM-DD HH24:MI:SS'),100,'C_Department_ID','Department','Department','D','12c99bc7-9fe6-4772-91ff-3359b4a1877e')
;

-- Jan 23, 2024, 3:11:00 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203902,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:11:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:11:00','YYYY-MM-DD HH24:MI:SS'),100,'C_Department_UU','Department UU','Department UU','D','39eb11ac-bb9f-48a3-8f2f-7788de501f32')
;

-- Jan 23, 2024, 3:16:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216352,0,'Department',200413,'C_Department_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:16:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:16:25','YYYY-MM-DD HH24:MI:SS'),100,203901,'N','N','D','N','N','N','Y','aad93483-354c-4b81-90f5-5fed4116e11b','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:16:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216353,0,'Department UU',200413,'C_Department_UU',36,'N','N','N','N','N',0,'N',200231,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),100,203902,'N','N','D','N','N','N','Y','f19113cf-52b1-4d85-99bf-f1d2ebbb8394','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:16:54 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216354,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200413,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:16:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:16:54','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','ec12541b-8f58-4cba-9645-a7b2edc26af8','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:17:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216355,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200413,'UpdatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','e61e3f2e-9e71-47e2-9b5b-82c4d5a91642','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 3:17:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216356,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200413,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','64e939c3-5ab9-463b-82e5-f862f3bbb58f','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:17:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216357,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200413,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:17:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:17:48','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','e4709468-be78-4415-bad7-8d3a3f1a1446','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:17:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216358,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200413,'CreatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:17:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:17:49','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','16eaa7af-2f02-4723-8ea3-41515d969dc3','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 3:29:00 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216359,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200413,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:28:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:28:59','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','9f575c08-e8ec-447f-8878-1686a4e905ec','Y',10,'N','N','N')
;

-- Jan 23, 2024, 3:29:07 PM IST
CREATE TABLE C_Department (C_Department_ID NUMBER(10) NOT NULL, C_Department_UU VARCHAR2(36 CHAR) DEFAULT NULL , Created DATE DEFAULT SYSDATE, CreatedBy NUMBER(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) DEFAULT NULL , Updated DATE DEFAULT SYSDATE, UpdatedBy NUMBER(10) DEFAULT NULL , CONSTRAINT C_Department_Key PRIMARY KEY (C_Department_ID), CONSTRAINT C_Department_UU_idx UNIQUE (C_Department_UU))
;

-- Jan 23, 2024, 3:29:43 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200414,'Cost Center','C_CostCenter',0,'3',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:29:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:29:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','39759e32-d515-4802-a911-4c02f808d2ad','N','N','N','N','N')
;

-- Jan 23, 2024, 3:29:43 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_CostCenter',1000000,'N','N','Table C_CostCenter','Y','Y',0,0,TO_TIMESTAMP('2024-01-23 15:29:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:29:43','YYYY-MM-DD HH24:MI:SS'),100,200485,'Y',1000000,1,200000,'1aa6a45a-fbab-490c-bde9-c33dbafbbf70')
;

-- Jan 23, 2024, 3:30:06 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203903,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:30:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:30:06','YYYY-MM-DD HH24:MI:SS'),100,'C_CostCenter_ID','Cost Center','Cost Center','D','a8e41310-f790-47f4-bf11-9b0c4d50e54d')
;

-- Jan 23, 2024, 3:30:16 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203904,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:30:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:30:15','YYYY-MM-DD HH24:MI:SS'),100,'C_CostCenter_UU','Cost Center UU','Cost Center UU','D','54c266d9-d671-497c-83c7-a9e5c3a8a0c6')
;

-- Jan 23, 2024, 3:30:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216360,0,'Cost Center',200414,'C_CostCenter_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:30:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:30:50','YYYY-MM-DD HH24:MI:SS'),100,203903,'N','N','D','N','N','N','Y','520df3c0-daaf-4d64-b2a3-d7217b498382','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:30:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216361,0,'Cost Center UU',200414,'C_CostCenter_UU',36,'N','N','N','N','N',0,'N',200231,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:30:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:30:55','YYYY-MM-DD HH24:MI:SS'),100,203904,'N','N','D','N','N','N','Y','edd7911a-4448-47a0-a49b-01231ca250d7','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:31:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216362,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200414,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:31:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:31:15','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','8d95d49e-3151-4743-af7b-57129146a642','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:31:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216363,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200414,'CreatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:31:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:31:16','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','ab458c12-da75-474c-be9c-afacee6e6fd0','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 3:31:30 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216364,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200414,'UpdatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:31:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:31:30','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','0f01fd4e-ffc0-4eb4-bb67-94f981633f65','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 3:31:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216365,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200414,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:31:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:31:30','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','10ce7f4a-81d7-4b1a-aa7c-e67927f28a0a','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:33:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216366,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200414,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:33:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:33:10','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','2603155a-9f7c-4a17-b9ca-8ead4f856f52','N',0,'N','N','N')
;

-- Jan 23, 2024, 3:35:40 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216367,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200414,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:35:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:35:40','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','dea00aad-0733-43fb-ba77-292885f0fa7b','Y',10,'N','N','N')
;

-- Jan 23, 2024, 3:35:44 PM IST
CREATE TABLE C_CostCenter (C_CostCenter_ID NUMBER(10) DEFAULT NULL , C_CostCenter_UU VARCHAR2(36 CHAR) DEFAULT NULL , Created DATE DEFAULT SYSDATE, CreatedBy NUMBER(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) DEFAULT NULL , Updated DATE DEFAULT SYSDATE, UpdatedBy NUMBER(10) DEFAULT NULL , CONSTRAINT C_CostCenter_Key PRIMARY KEY (C_CostCenter_ID), CONSTRAINT C_CostCenter_UU_idx UNIQUE (C_CostCenter_UU))
;

-- Jan 23, 2024, 3:41:07 PM IST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200148,'Department',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:41:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:41:07','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','d030f55a-ff99-4222-8d54-8b0f66c8f33c')
;

-- Jan 23, 2024, 3:41:24 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200383,'Department',200148,10,'Y',200413,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:41:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:41:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','e227676a-7592-4d16-bc31-09345b967c8b','B','N','Y',0)
;

-- Jan 23, 2024, 3:41:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208205,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200383,216359,'Y',60,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:41:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:41:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5bb63dd6-6fe0-4a92-a953-ff53a7cda6f9','Y',10,5)
;

-- Jan 23, 2024, 3:41:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208206,'Department',200383,216352,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:41:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:41:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b1b36f22-0f9d-4e5b-8c1f-472ac3ad4a67','N',2)
;

-- Jan 23, 2024, 3:41:32 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208207,'Department UU',200383,216353,'Y',36,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:41:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:41:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','229fcea2-3ccc-423a-89fe-5ffa23eef52c','Y',20,2)
;

-- Jan 23, 2024, 3:41:32 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208208,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200383,216354,'Y',1,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:41:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:41:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','abf73b86-c5e8-4cf0-a5db-e73ad9e0327a','Y',30,2,2)
;

-- Jan 23, 2024, 3:41:49 PM IST
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2024-01-23 15:41:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208208
;

-- Jan 23, 2024, 3:41:50 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-01-23 15:41:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208206
;

-- Jan 23, 2024, 3:41:50 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2024-01-23 15:41:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208207
;

-- Jan 23, 2024, 3:42:24 PM IST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200149,'Cost Center',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:42:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:42:24','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','b3bc53ff-e6b7-4570-9e31-0d81a8b172e2')
;

-- Jan 23, 2024, 3:42:39 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200384,'Cost Center',200149,10,'Y',200414,0,0,'Y',TO_TIMESTAMP('2024-01-23 15:42:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:42:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','10daf6a8-7f4d-44fd-ba8b-ab0561bf82c0','B','N','Y',0)
;

-- Jan 23, 2024, 3:42:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208209,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200384,216367,'Y',60,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:42:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:42:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9d50ff00-18a9-40b9-9178-eef9faa0017c','Y',10,5)
;

-- Jan 23, 2024, 3:42:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208210,'Cost Center',200384,216360,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:42:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:42:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9fde413d-f55b-47fc-9612-ae8295c9203a','N',2)
;

-- Jan 23, 2024, 3:42:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208211,'Cost Center UU',200384,216361,'Y',36,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:42:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:42:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2182a85e-d7ce-4ad2-8dc8-818f2bf5525c','Y',20,2)
;

-- Jan 23, 2024, 3:42:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208212,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200384,216366,'Y',1,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 15:42:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 15:42:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1503095a-c913-4420-b92a-715cb4901d99','Y',30,2,2)
;

-- Jan 23, 2024, 3:43:10 PM IST
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2024-01-23 15:43:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208212
;

-- Jan 23, 2024, 3:43:10 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-01-23 15:43:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208210
;

-- Jan 23, 2024, 3:43:10 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2024-01-23 15:43:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208211
;

-- Jan 23, 2024, 3:43:38 PM IST
UPDATE AD_Field SET IsDisplayedGrid='N',Updated=TO_TIMESTAMP('2024-01-23 15:43:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208211
;

-- Jan 23, 2024, 3:44:14 PM IST
UPDATE AD_Field SET IsDisplayedGrid='N',Updated=TO_TIMESTAMP('2024-01-23 15:44:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208207
;

-- Jan 23, 2024, 4:08:18 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216368,0,'Cost Center',279,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:08:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:08:17','YYYY-MM-DD HH24:MI:SS'),100,203903,'N','N','D','N','N','N','Y','f89a7be6-fa6a-4185-a1a6-d11942183e15','Y',0,'N','N','N','N')
;

-- Jan 23, 2024, 4:08:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216369,0,'Department',279,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:08:31','YYYY-MM-DD HH24:MI:SS'),100,203901,'N','N','D','N','N','N','Y','b12afc2b-f42c-46d2-9537-51ea6ee71e23','Y',0,'N','N','N','N')
;

-- Jan 23, 2024, 4:08:37 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CAcctSchemaElement', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 16:08:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216368
;

-- Jan 23, 2024, 4:08:37 PM IST
ALTER TABLE C_AcctSchema_Element ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 4:08:37 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT CCostCenter_CAcctSchemaElement FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 23, 2024, 4:08:43 PM IST
UPDATE AD_Column SET IsUpdateable='Y', IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2024-01-23 16:08:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216368
;

-- Jan 23, 2024, 4:08:48 PM IST
UPDATE AD_Column SET IsUpdateable='Y', IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2024-01-23 16:08:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216369
;

-- Jan 23, 2024, 4:08:49 PM IST
ALTER TABLE C_AcctSchema_Element MODIFY C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 4:08:49 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_CAcctSchemaElement', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 16:08:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216369
;

-- Jan 23, 2024, 4:08:49 PM IST
ALTER TABLE C_AcctSchema_Element ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 4:08:49 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT CDepartment_CAcctSchemaElement FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 23, 2024, 4:13:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208213,'Department',217,216369,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 16:13:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:13:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','92f11c65-4457-406f-98d6-b73b4b585157','Y',260,1,1,1,'N','N','N','N')
;

-- Jan 23, 2024, 4:13:55 PM IST
UPDATE AD_Field SET DisplayLogic='@ElementType@=''DP''',Updated=TO_TIMESTAMP('2024-01-23 16:13:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208213
;

-- Jan 23, 2024, 4:14:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208214,'Cost Center',217,216368,'Y','@ElementType@=''CC''',0,270,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 16:14:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:14:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','90d9e8e9-99fd-47ba-a00b-c062c31b2768','Y',270,1,1,1,'N','N','N','N')
;

-- Jan 23, 2024, 4:47:18 PM IST
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 16:47:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208213
;

-- Jan 23, 2024, 4:47:21 PM IST
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 16:47:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208214
;

-- Jan 23, 2024, 4:53:40 PM IST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200232,'Cost Center','W',200149,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:53:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:53:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','e5b191e7-7711-48b2-9666-3ab33c931e16')
;

-- Jan 23, 2024, 4:53:40 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200232, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200232)
;

-- Jan 23, 2024, 4:53:54 PM IST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200233,'Department','W',200148,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:53:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:53:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','58bb4436-a6cb-43e6-94eb-3bd1946457b8')
;

-- Jan 23, 2024, 4:53:54 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200233, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200233)
;

-- Jan 23, 2024, 4:55:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216370,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200413,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:55:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:55:37','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','d2361c66-2efe-429d-b434-4fb27b7dc445','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 4:55:43 PM IST
ALTER TABLE C_Department ADD AD_Client_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 4:56:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216371,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200413,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:56:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:56:03','YYYY-MM-DD HH24:MI:SS'),100,113,'Y','N','D','N','N','N','Y','645a2f82-d6f0-4fb9-a43b-133c406ec2bb','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 4:56:07 PM IST
ALTER TABLE C_Department ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 4:57:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208215,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200383,216370,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 16:57:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:57:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8a42fbe6-0069-4b9b-9c8d-5ee6be9abdf7','N',2)
;

-- Jan 23, 2024, 4:57:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208216,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200383,216371,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 16:57:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:57:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e8bc1f43-91e8-49fa-9453-84702b2df539','Y','Y',40,4,2)
;

-- Jan 23, 2024, 4:57:26 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=10, XPosition=1,Updated=TO_TIMESTAMP('2024-01-23 16:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208215
;

-- Jan 23, 2024, 4:57:26 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, XPosition=4,Updated=TO_TIMESTAMP('2024-01-23 16:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208216
;

-- Jan 23, 2024, 4:57:26 PM IST
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2024-01-23 16:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208205
;

-- Jan 23, 2024, 4:57:26 PM IST
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2024-01-23 16:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208208
;

-- Jan 23, 2024, 4:57:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216372,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200414,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:57:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:57:42','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','803d1cf1-a22d-4230-a18d-98f4a65a7739','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 4:57:45 PM IST
ALTER TABLE C_CostCenter ADD AD_Client_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 4:57:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216373,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200414,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 16:57:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:57:56','YYYY-MM-DD HH24:MI:SS'),100,113,'Y','N','D','N','N','N','Y','3665f850-a904-4044-91ae-81f8296a4af8','N',0,'N','N','D','N')
;

-- Jan 23, 2024, 4:57:58 PM IST
ALTER TABLE C_CostCenter ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 4:58:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208217,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200384,216372,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 16:58:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:58:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','760923a2-8374-4d18-a54c-42b3f60e1148','N',2)
;

-- Jan 23, 2024, 4:58:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208218,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200384,216373,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 16:58:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 16:58:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','98e23132-95e4-4b51-a567-09886460b043','Y','Y',40,4,2)
;

-- Jan 23, 2024, 4:58:27 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=10, XPosition=1,Updated=TO_TIMESTAMP('2024-01-23 16:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208217
;

-- Jan 23, 2024, 4:58:27 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, XPosition=4,Updated=TO_TIMESTAMP('2024-01-23 16:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208218
;

-- Jan 23, 2024, 4:58:27 PM IST
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2024-01-23 16:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208209
;

-- Jan 23, 2024, 4:58:27 PM IST
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2024-01-23 16:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208212
;

-- Jan 23, 2024, 5:32:04 PM IST
INSERT INTO AD_PrintFormat (Updated,CreatedBy,IsTableBased,IsActive,IsStandardHeaderFooter,AD_PrintFont_ID,AD_Table_ID,IsForm,HeaderMargin,UpdatedBy,AD_PrintColor_ID,Created,Name,FooterMargin,AD_Client_ID,AD_PrintPaper_ID,AD_Org_ID,AD_PrintFormat_ID,IsDefault,AD_PrintFormat_UU) VALUES (TO_TIMESTAMP('2024-01-23 17:32:03','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','Y',130,106,'N',0,100,100,TO_TIMESTAMP('2024-01-23 17:32:03','YYYY-MM-DD HH24:MI:SS'),'Tab',0,0,100,0,200018,'N','56ac2fcc-5bf5-4f52-86af-eb7c998a5f97')
;

-- Jan 23, 2024, 5:32:04 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (1,'Parent Column',TO_TIMESTAMP('2024-01-23 17:32:04','YYYY-MM-DD HH24:MI:SS'),'N',0,'Parent Column',0,0,57842,'N','Y',100,0,200414,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:04','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','f25bb181-384b-4752-9975-c91411e8f5e5')
;

-- Jan 23, 2024, 5:32:05 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (2,'Delete Confirmation Logic',TO_TIMESTAMP('2024-01-23 17:32:04','YYYY-MM-DD HH24:MI:SS'),'N',0,'Delete Confirmation Logic',0,0,214937,'N','Y',100,0,200415,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:04','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','ea90cb03-330b-4041-b023-f0a08f896f62')
;

-- Jan 23, 2024, 5:32:05 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (3,'Sequence',TO_TIMESTAMP('2024-01-23 17:32:05','YYYY-MM-DD HH24:MI:SS'),'N',0,'Sequence',0,0,165,'N','Y',100,0,200416,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:05','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','97817746-7040-45ae-b306-e5c178a386d7')
;

-- Jan 23, 2024, 5:32:06 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Tenant',TO_TIMESTAMP('2024-01-23 17:32:05','YYYY-MM-DD HH24:MI:SS'),'N',0,'Tenant',0,0,379,'N','Y',100,0,200417,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:05','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','054eeafd-f6d5-4566-b04c-35fc7ed82c8c')
;

-- Jan 23, 2024, 5:32:06 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Organization',TO_TIMESTAMP('2024-01-23 17:32:06','YYYY-MM-DD HH24:MI:SS'),'N',0,'Organization',0,0,380,'N','Y',100,0,200418,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:06','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','1019d992-f490-4b76-b406-04891c8fe265')
;

-- Jan 23, 2024, 5:32:07 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (6,'Window',TO_TIMESTAMP('2024-01-23 17:32:07','YYYY-MM-DD HH24:MI:SS'),'N',0,'Window',0,2,164,'N','Y',100,0,200419,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:07','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','Y','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','ab13b439-f1ca-44d7-958c-694095828c6d')
;

-- Jan 23, 2024, 5:32:08 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (7,'Name',TO_TIMESTAMP('2024-01-23 17:32:07','YYYY-MM-DD HH24:MI:SS'),'N',0,'Name',0,1,161,'N','Y',100,0,200420,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:07','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','Y','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','7f7c51ca-a229-4b30-82c2-aa65e6281264')
;

-- Jan 23, 2024, 5:32:08 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (8,'Description',TO_TIMESTAMP('2024-01-23 17:32:08','YYYY-MM-DD HH24:MI:SS'),'N',0,'Description',0,0,162,'N','Y',100,0,200421,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:08','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','51730f6c-c9e9-40e8-a9f5-4888aec8e23f')
;

-- Jan 23, 2024, 5:32:09 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (9,'Comment/Help',TO_TIMESTAMP('2024-01-23 17:32:08','YYYY-MM-DD HH24:MI:SS'),'N',0,'Comment',0,0,163,'N','Y',100,0,200422,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:08','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'B','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','210798e4-5fa4-4042-b6c2-c1d2de53a003')
;

-- Jan 23, 2024, 5:32:09 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (10,'Table',TO_TIMESTAMP('2024-01-23 17:32:09','YYYY-MM-DD HH24:MI:SS'),'N',0,'Table',0,0,251,'N','Y',100,0,200423,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:09','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','9afced39-5995-4a6a-a576-bcaaa13e2a9b')
;

-- Jan 23, 2024, 5:32:10 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (11,'Entity Type',TO_TIMESTAMP('2024-01-23 17:32:09','YYYY-MM-DD HH24:MI:SS'),'N',0,'Entity Type',0,0,7713,'N','Y',100,0,200424,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:09','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','fdbac781-33f5-4609-991c-45f51b102c0a')
;

-- Jan 23, 2024, 5:32:10 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (12,'Tab Level',TO_TIMESTAMP('2024-01-23 17:32:10','YYYY-MM-DD HH24:MI:SS'),'N',0,'Tab Level',0,0,6654,'N','Y',100,0,200425,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:10','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','94d93f24-f459-41de-bc0c-a914ea992b25')
;

-- Jan 23, 2024, 5:32:11 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (13,'Tab Type',TO_TIMESTAMP('2024-01-23 17:32:10','YYYY-MM-DD HH24:MI:SS'),'N',0,'Tab Type',0,0,212616,'N','Y',100,0,200426,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:10','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','37e8cd05-86ca-4a55-9a3f-28a96426b6bf')
;

-- Jan 23, 2024, 5:32:12 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (14,'Single Row Layout',TO_TIMESTAMP('2024-01-23 17:32:11','YYYY-MM-DD HH24:MI:SS'),'N',0,'Single Row Layout',0,0,166,'N','Y',100,0,200427,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:11','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','3a021642-4e25-47e5-a6b9-4226478f28ad')
;

-- Jan 23, 2024, 5:32:12 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (15,'Has Tree',TO_TIMESTAMP('2024-01-23 17:32:12','YYYY-MM-DD HH24:MI:SS'),'N',0,'Has Tree',0,0,1183,'N','Y',100,0,200428,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:12','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','2d7001f2-59f0-4197-9acd-131c6ef262a6')
;

-- Jan 23, 2024, 5:32:13 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (16,'Tree displayed',TO_TIMESTAMP('2024-01-23 17:32:12','YYYY-MM-DD HH24:MI:SS'),'N',0,'Tree displayed',0,0,210869,'N','Y',100,0,200429,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:12','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','ecac13ec-e80c-487b-9ea0-456f4c51121b')
;

-- Jan 23, 2024, 5:32:13 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (17,'Advanced Tab',TO_TIMESTAMP('2024-01-23 17:32:13','YYYY-MM-DD HH24:MI:SS'),'N',0,'Advanced Tab',0,0,13995,'N','Y',100,0,200430,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:13','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','06f98081-b2c0-4e53-b21f-5fa084e55ebc')
;

-- Jan 23, 2024, 5:32:14 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (18,'Accounting Tab',TO_TIMESTAMP('2024-01-23 17:32:13','YYYY-MM-DD HH24:MI:SS'),'N',0,'Accounting Tab',0,0,2042,'N','Y',100,0,200431,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:13','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','f49982c0-230c-4586-9781-fe7e92feab31')
;

-- Jan 23, 2024, 5:32:14 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (19,'Translation Tab',TO_TIMESTAMP('2024-01-23 17:32:14','YYYY-MM-DD HH24:MI:SS'),'N',0,'Translation Tab',0,0,2043,'N','Y',100,0,200432,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:14','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','8040250f-54b3-45ac-ab7a-02d5af1216a5')
;

-- Jan 23, 2024, 5:32:15 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (20,'Lookup Only Selection Columns',TO_TIMESTAMP('2024-01-23 17:32:14','YYYY-MM-DD HH24:MI:SS'),'N',0,'Lookup Only Selection Columns',0,0,213944,'N','Y',100,0,200433,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:14','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','86a5c02d-e1d6-460a-ab68-bff51c2c21b6')
;

-- Jan 23, 2024, 5:32:16 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (21,'Allow Advanced Lookup',TO_TIMESTAMP('2024-01-23 17:32:15','YYYY-MM-DD HH24:MI:SS'),'N',0,'Allow Advanced Lookup',0,0,213945,'N','Y',100,0,200434,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:15','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','740fe683-eb75-47b7-8e20-394c85aa27a7')
;

-- Jan 23, 2024, 5:32:16 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (22,'Order Column',TO_TIMESTAMP('2024-01-23 17:32:16','YYYY-MM-DD HH24:MI:SS'),'N',0,'Order Column',0,0,7029,'N','Y',100,0,200435,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:16','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','563628b9-183b-4d70-8a0b-754f271c0603')
;

-- Jan 23, 2024, 5:32:17 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (23,'Included Column',TO_TIMESTAMP('2024-01-23 17:32:16','YYYY-MM-DD HH24:MI:SS'),'N',0,'Included Column',0,0,7028,'N','Y',100,0,200436,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:16','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','7e438b16-2d6e-4f36-ab61-bbffad0b685f')
;

-- Jan 23, 2024, 5:32:17 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (24,'Column',TO_TIMESTAMP('2024-01-23 17:32:17','YYYY-MM-DD HH24:MI:SS'),'N',0,'Column',0,0,2740,'N','Y',100,0,200437,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:17','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','0c71b0c9-554c-4bbc-90c7-66b4d8370894')
;

-- Jan 23, 2024, 5:32:18 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (25,'Max Query Records',TO_TIMESTAMP('2024-01-23 17:32:17','YYYY-MM-DD HH24:MI:SS'),'N',0,'Max Query Records',0,0,214163,'N','Y',100,0,200438,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:17','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','942b79f7-f02f-4a86-84e7-97d31b47894c')
;

-- Jan 23, 2024, 5:32:18 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (26,'Process',TO_TIMESTAMP('2024-01-23 17:32:18','YYYY-MM-DD HH24:MI:SS'),'N',0,'Process',0,0,3374,'N','Y',100,0,200439,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:18','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','e767730e-064d-4652-9f2c-dc193a917c2b')
;

-- Jan 23, 2024, 5:32:19 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (27,'High Volume',TO_TIMESTAMP('2024-01-23 17:32:18','YYYY-MM-DD HH24:MI:SS'),'N',0,'High Volume',0,0,214663,'N','Y',100,0,200440,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:18','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','51337c23-8622-4d9a-a4f3-d18c6a2972a1')
;

-- Jan 23, 2024, 5:32:20 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (28,'Display Logic',TO_TIMESTAMP('2024-01-23 17:32:19','YYYY-MM-DD HH24:MI:SS'),'N',0,'Display Logic',0,0,13450,'N','Y',100,0,200441,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:19','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','72eff65c-2b9a-4911-8f98-0ccb1ac2ff1a')
;

-- Jan 23, 2024, 5:32:20 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (29,'Read Only',TO_TIMESTAMP('2024-01-23 17:32:20','YYYY-MM-DD HH24:MI:SS'),'N',0,'Read Only',0,0,2044,'N','Y',100,0,200442,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:20','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','22d09524-9207-457b-9847-3d4334d1192f')
;

-- Jan 23, 2024, 5:32:21 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (30,'Insert Record',TO_TIMESTAMP('2024-01-23 17:32:20','YYYY-MM-DD HH24:MI:SS'),'N',0,'Insert Record',0,0,13994,'N','Y',100,0,200443,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:20','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','4a091020-8c9c-40c6-b8ae-1e23bcce1ac4')
;

-- Jan 23, 2024, 5:32:21 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Active',TO_TIMESTAMP('2024-01-23 17:32:21','YYYY-MM-DD HH24:MI:SS'),'N',0,'Active',0,0,573,'N','Y',100,0,200444,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:21','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','d7e92f68-f7d8-4d58-8c3a-a153e10cd452')
;

-- Jan 23, 2024, 5:32:22 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (32,'Read Only Logic',TO_TIMESTAMP('2024-01-23 17:32:21','YYYY-MM-DD HH24:MI:SS'),'N',0,'Read Only Logic',0,0,13449,'N','Y',100,0,200445,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:21','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','62c02b24-a9fc-4f49-9eec-1fcdd19a8a2a')
;

-- Jan 23, 2024, 5:32:23 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (33,'Commit Warning',TO_TIMESTAMP('2024-01-23 17:32:22','YYYY-MM-DD HH24:MI:SS'),'N',0,'Commit Warning',0,0,2744,'N','Y',100,0,200446,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:22','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'B','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c5726b27-cee9-475a-b9f7-b0c4be924daf')
;

-- Jan 23, 2024, 5:32:23 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (34,'Sql WHERE',TO_TIMESTAMP('2024-01-23 17:32:23','YYYY-MM-DD HH24:MI:SS'),'N',0,'Where clause',0,0,2741,'N','Y',100,0,200447,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:23','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','4e23631f-4822-4678-a065-8c40ac44d9e2')
;

-- Jan 23, 2024, 5:32:24 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (35,'Sql ORDER BY',TO_TIMESTAMP('2024-01-23 17:32:23','YYYY-MM-DD HH24:MI:SS'),'N',0,'Order by clause',0,0,2742,'N','Y',100,0,200448,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:23','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','340373ed-fb42-4b5b-a702-3dc71d48ab73')
;

-- Jan 23, 2024, 5:32:24 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (36,'Image',TO_TIMESTAMP('2024-01-23 17:32:24','YYYY-MM-DD HH24:MI:SS'),'N',0,'Image',0,0,6313,'N','Y',100,0,200449,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:24','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','6368655c-000e-4c0f-8c04-7d2ab7c1f647')
;

-- Jan 23, 2024, 5:32:25 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (37,'Context Help',TO_TIMESTAMP('2024-01-23 17:32:24','YYYY-MM-DD HH24:MI:SS'),'N',0,'Context Help',0,0,208589,'N','Y',100,0,200450,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:24','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','b8791b2c-3918-44c0-b052-4cf903b3c8f7')
;

-- Jan 23, 2024, 5:32:25 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Import Fields',TO_TIMESTAMP('2024-01-23 17:32:25','YYYY-MM-DD HH24:MI:SS'),'N',0,'Import Fields',0,0,6487,'N','Y',100,0,200451,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:25','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','4dfa8bb0-3017-4bf9-a826-1ec8561d1712')
;

-- Jan 23, 2024, 5:32:26 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Process Now',TO_TIMESTAMP('2024-01-23 17:32:25','YYYY-MM-DD HH24:MI:SS'),'N',0,'Process Now',0,0,4207,'N','Y',100,0,200452,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:25','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','2f3afae0-a29b-4f15-a300-046527dcf532')
;

-- Jan 23, 2024, 5:32:26 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (40,'AD_Tab_UU',TO_TIMESTAMP('2024-01-23 17:32:26','YYYY-MM-DD HH24:MI:SS'),'N',0,'AD_Tab_UU',0,0,60504,'N','Y',100,0,200453,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:26','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c1d1ede4-52d8-4a40-8ffd-c508175eb9b0')
;

-- Jan 23, 2024, 5:32:27 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (41,'Included Tab',TO_TIMESTAMP('2024-01-23 17:32:26','YYYY-MM-DD HH24:MI:SS'),'N',0,'Included Tab',0,0,8547,'N','Y',100,0,200454,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:26','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','cf1ab51d-4ef9-4882-91be-813be9089147')
;

-- Jan 23, 2024, 5:32:28 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (42,'Order Tab',TO_TIMESTAMP('2024-01-23 17:32:27','YYYY-MM-DD HH24:MI:SS'),'N',0,'Order Tab',0,0,7027,'N','Y',100,0,200455,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:27','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','63296d3b-f33e-46ac-9291-74207e87e2ba')
;

-- Jan 23, 2024, 5:32:28 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Tab',TO_TIMESTAMP('2024-01-23 17:32:28','YYYY-MM-DD HH24:MI:SS'),'N',0,'Tab',0,0,160,'N','Y',100,0,200456,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:28','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','9a5691cb-cbd4-4de7-a48d-a2bc06bb8e29')
;

-- Jan 23, 2024, 5:35:59 PM IST
UPDATE AD_Field SET SeqNo=240, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 17:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208190
;

-- Jan 23, 2024, 5:35:59 PM IST
UPDATE AD_Field SET SeqNo=250, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 17:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208191
;

-- Jan 23, 2024, 5:35:59 PM IST
UPDATE AD_Field SET SeqNo=260, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 17:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208192
;

-- Jan 23, 2024, 5:35:59 PM IST
UPDATE AD_Field SET SeqNo=270, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 17:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208193
;

-- Jan 23, 2024, 5:35:59 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-01-23 17:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204827
;

-- Jan 23, 2024, 5:40:45 PM IST
UPDATE AD_Element SET Name='Text Column 1', PrintName='Text Column 1',Updated=TO_TIMESTAMP('2024-01-23 17:40:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203894
;

-- Jan 23, 2024, 5:40:45 PM IST
UPDATE AD_Column SET ColumnName='CustomFieldText1', Name='Text Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203894
;

-- Jan 23, 2024, 5:40:45 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText1', Name='Text Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', AD_Element_ID=203894 WHERE UPPER(ColumnName)='CustomFieldText1' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 23, 2024, 5:40:45 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText1', Name='Text Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203894 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:45 PM IST
UPDATE AD_InfoColumn SET ColumnName='CustomFieldText1', Name='Text Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203894 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:45 PM IST
UPDATE AD_Field SET Name='Text Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203894) AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:45 PM IST
UPDATE AD_PrintFormatItem SET PrintName='Text Column 1', Name='Text Column 1' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203894)
;

-- Jan 23, 2024, 5:40:54 PM IST
UPDATE AD_Element SET Name='Text Column 2', PrintName='Text Column 2',Updated=TO_TIMESTAMP('2024-01-23 17:40:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203895
;

-- Jan 23, 2024, 5:40:54 PM IST
UPDATE AD_Column SET ColumnName='CustomFieldText2', Name='Text Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203895
;

-- Jan 23, 2024, 5:40:54 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText2', Name='Text Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', AD_Element_ID=203895 WHERE UPPER(ColumnName)='CustomFieldText2' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 23, 2024, 5:40:54 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText2', Name='Text Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203895 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:54 PM IST
UPDATE AD_InfoColumn SET ColumnName='CustomFieldText2', Name='Text Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203895 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:54 PM IST
UPDATE AD_Field SET Name='Text Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203895) AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:54 PM IST
UPDATE AD_PrintFormatItem SET PrintName='Text Column 2', Name='Text Column 2' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203895)
;

-- Jan 23, 2024, 5:40:59 PM IST
UPDATE AD_Element SET Name='Text Column 3', PrintName='Text Column 3',Updated=TO_TIMESTAMP('2024-01-23 17:40:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203896
;

-- Jan 23, 2024, 5:40:59 PM IST
UPDATE AD_Column SET ColumnName='CustomFieldText3', Name='Text Column 3', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203896
;

-- Jan 23, 2024, 5:40:59 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText3', Name='Text Column 3', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', AD_Element_ID=203896 WHERE UPPER(ColumnName)='CustomFieldText3' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 23, 2024, 5:40:59 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText3', Name='Text Column 3', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203896 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:59 PM IST
UPDATE AD_InfoColumn SET ColumnName='CustomFieldText3', Name='Text Column 3', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203896 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:59 PM IST
UPDATE AD_Field SET Name='Text Column 3', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203896) AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:40:59 PM IST
UPDATE AD_PrintFormatItem SET PrintName='Text Column 3', Name='Text Column 3' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203896)
;

-- Jan 23, 2024, 5:41:05 PM IST
UPDATE AD_Element SET Name='Text Column 4', PrintName='Text Column 4',Updated=TO_TIMESTAMP('2024-01-23 17:41:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203897
;

-- Jan 23, 2024, 5:41:05 PM IST
UPDATE AD_Column SET ColumnName='CustomFieldText4', Name='Text Column 4', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203897
;

-- Jan 23, 2024, 5:41:05 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText4', Name='Text Column 4', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', AD_Element_ID=203897 WHERE UPPER(ColumnName)='CustomFieldText4' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 23, 2024, 5:41:05 PM IST
UPDATE AD_Process_Para SET ColumnName='CustomFieldText4', Name='Text Column 4', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203897 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:41:05 PM IST
UPDATE AD_InfoColumn SET ColumnName='CustomFieldText4', Name='Text Column 4', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Element_ID=203897 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:41:05 PM IST
UPDATE AD_Field SET Name='Text Column 4', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203897) AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2024, 5:41:05 PM IST
UPDATE AD_PrintFormatItem SET PrintName='Text Column 4', Name='Text Column 4' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203897)
;

-- Jan 23, 2024, 5:49:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216382,0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200413,'Value',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-01-23 17:49:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 17:49:25','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','N','N','N','Y','ee5042ee-808c-4f80-86df-82942a445839','Y',20,'N','N','N')
;

-- Jan 23, 2024, 5:49:26 PM IST
ALTER TABLE C_Department ADD Value VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Jan 23, 2024, 5:49:44 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208228,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200383,216382,'Y',40,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 17:49:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 17:49:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f5edf06-0cd3-4451-b7e2-2d1bcc17c508','Y',50,2)
;

-- Jan 23, 2024, 5:50:01 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2024-01-23 17:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208228
;

-- Jan 23, 2024, 5:50:01 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 17:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208205
;

-- Jan 23, 2024, 5:50:01 PM IST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2024-01-23 17:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208208
;

-- Jan 23, 2024, 5:50:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216383,0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200414,'Value',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-01-23 17:50:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 17:50:32','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','N','N','N','Y','0572dd88-8c54-42be-8342-a417f64f5459','Y',20,'N','N','N')
;

-- Jan 23, 2024, 5:50:34 PM IST
ALTER TABLE C_CostCenter ADD Value VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Jan 23, 2024, 5:50:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208229,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200384,216383,'Y',40,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-23 17:50:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 17:50:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5228c9e8-0184-43b7-8d67-2533f45d117f','Y',50,2)
;

-- Jan 23, 2024, 5:51:02 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2024-01-23 17:51:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208229
;

-- Jan 23, 2024, 5:51:02 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-01-23 17:51:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208209
;

-- Jan 23, 2024, 5:51:02 PM IST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2024-01-23 17:51:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208212
;

-- Jan 23, 2024, 6:37:22 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216384,0,'Department',270,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 18:37:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 18:37:21','YYYY-MM-DD HH24:MI:SS'),100,203901,'N','N','D','N','N','N','Y','8e9fa5dd-db3d-4c34-971a-82852826da73','Y',0,'N','N','N','N')
;

-- Jan 23, 2024, 6:37:24 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_FactAcct', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 18:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216384
;

-- Jan 23, 2024, 6:37:24 PM IST
ALTER TABLE Fact_Acct ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 6:37:24 PM IST
ALTER TABLE Fact_Acct ADD CONSTRAINT CDepartment_FactAcct FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 23, 2024, 6:37:35 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216385,0,'Cost Center',270,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 18:37:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 18:37:35','YYYY-MM-DD HH24:MI:SS'),100,203903,'N','N','D','N','N','N','Y','7588d802-0a68-4e7b-a6f3-06cddbb792d0','Y',0,'N','N','N','N')
;

-- Jan 23, 2024, 6:37:36 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_FactAcct', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 18:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216385
;

-- Jan 23, 2024, 6:37:36 PM IST
ALTER TABLE Fact_Acct ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 6:37:36 PM IST
ALTER TABLE Fact_Acct ADD CONSTRAINT CCostCenter_FactAcct FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 23, 2024, 6:53:54 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216386,0,'Department',53203,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 18:53:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 18:53:54','YYYY-MM-DD HH24:MI:SS'),100,203901,'N','N','D','N','N','N','Y','51d5276d-bdd9-4494-a4fa-345e095105db','Y',0,'N','N','N','N')
;

-- Jan 23, 2024, 6:53:59 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_FactAcctSummary', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 18:53:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216386
;

-- Jan 23, 2024, 6:53:59 PM IST
ALTER TABLE Fact_Acct_Summary ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 6:53:59 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT CDepartment_FactAcctSummary FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 23, 2024, 6:54:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216387,0,'Cost Center',53203,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-23 18:54:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-23 18:54:09','YYYY-MM-DD HH24:MI:SS'),100,203903,'N','N','D','N','N','N','Y','5bd631b9-9641-4ec2-bfc9-455f9672e139','Y',0,'N','N','N','N')
;

-- Jan 23, 2024, 6:54:10 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_FactAcctSummary', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 18:54:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216387
;

-- Jan 23, 2024, 6:54:10 PM IST
ALTER TABLE Fact_Acct_Summary ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2024, 6:54:10 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT CCostCenter_FactAcctSummary FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 24, 2024, 11:22:38 AM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2024-01-24 11:22:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216383
;

-- Jan 24, 2024, 11:22:40 AM IST
ALTER TABLE C_CostCenter MODIFY Value VARCHAR2(40 CHAR)
;

-- Jan 24, 2024, 11:22:40 AM IST
ALTER TABLE C_CostCenter MODIFY Value NOT NULL
;

-- Jan 24, 2024, 11:22:54 AM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2024-01-24 11:22:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216382
;

-- Jan 24, 2024, 11:22:55 AM IST
ALTER TABLE C_Department MODIFY Value VARCHAR2(40 CHAR)
;

-- Jan 24, 2024, 11:22:55 AM IST
ALTER TABLE C_Department MODIFY Value NOT NULL
;

-- Jan 24, 2024, 1:37:57 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200455,0,0,'Y',TO_TIMESTAMP('2024-01-24 13:37:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-24 13:37:57','YYYY-MM-DD HH24:MI:SS'),100,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',202,150,18,252,'N',10,'N','C_Employee_ID','Y','D',203893,'2ed56048-2f8a-4167-8291-cbe7d1e869b8','N','N','D','N')
;

-- Jan 24, 2024, 1:38:10 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200456,0,0,'Y',TO_TIMESTAMP('2024-01-24 13:38:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-24 13:38:09','YYYY-MM-DD HH24:MI:SS'),100,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',202,160,19,'N',0,'N','C_Charge_ID','Y','D',968,'14c362c8-560f-4550-9b39-98dce70033c2','N','N','D','N')
;

-- Jan 24, 2024, 1:38:26 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200457,0,0,'Y',TO_TIMESTAMP('2024-01-24 13:38:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-24 13:38:26','YYYY-MM-DD HH24:MI:SS'),100,'Cost Center',202,170,19,'N',22,'N','C_CostCenter_ID','Y','D',203903,'3bcc7a36-d607-4fd8-bff0-ba8871ae22af','N','N','D','N')
;

-- Jan 24, 2024, 1:38:33 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200458,0,0,'Y',TO_TIMESTAMP('2024-01-24 13:38:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-24 13:38:33','YYYY-MM-DD HH24:MI:SS'),100,'Department',202,180,19,'N',22,'N','C_Department_ID','Y','D',203901,'481cfdb0-d348-45da-aee2-70ab82f945ad','N','N','D','N')
;

-- Jan 24, 2024, 1:38:49 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200459,0,0,'Y',TO_TIMESTAMP('2024-01-24 13:38:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-24 13:38:48','YYYY-MM-DD HH24:MI:SS'),100,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',202,190,19,'N',0,'N','M_Warehouse_ID','Y','D',459,'fec3bdcc-f76c-419c-bf89-4227debd3421','N','N','D','N')
;

-- Feb 21, 2024, 2:12:45 PM IST
UPDATE AD_Process_Para SET DisplayLogic='@$Element_EP@=''Y''',Updated=TO_TIMESTAMP('2024-02-21 14:12:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200455
;

-- Feb 21, 2024, 2:13:01 PM IST
UPDATE AD_Process_Para SET DisplayLogic='@$Element_CH@=''Y''',Updated=TO_TIMESTAMP('2024-02-21 14:13:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200456
;

-- Feb 21, 2024, 2:13:10 PM IST
UPDATE AD_Process_Para SET DisplayLogic='@$Element_CC@=''Y''',Updated=TO_TIMESTAMP('2024-02-21 14:13:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200457
;

-- Feb 21, 2024, 2:13:23 PM IST
UPDATE AD_Process_Para SET DisplayLogic='@$Element_DP@=''Y''',Updated=TO_TIMESTAMP('2024-02-21 14:13:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200458
;

-- Feb 21, 2024, 2:13:33 PM IST
UPDATE AD_Process_Para SET DisplayLogic='@$Element_WH@=''Y''',Updated=TO_TIMESTAMP('2024-02-21 14:13:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200459
;

-- Feb 21, 2024, 2:14:52 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200461,0,0,'Y',TO_TIMESTAMP('2024-02-21 14:14:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-21 14:14:51','YYYY-MM-DD HH24:MI:SS'),100,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',202,210,30,'N',0,'N','A_Asset_ID','Y','D',1884,'@$Element_AS@=''Y''','8032b8ed-b51c-48f8-bbf5-34da5fcf3ebb','N','N','D','N')
;

-- Feb 21, 2024, 2:55:04 PM IST
UPDATE AD_Process_Para SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2024-02-21 14:55:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200460
;

-- May 10, 2024, 3:08:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200709,'Attribute Set Instance',181,'AI',0,0,'Y',TO_TIMESTAMP('2024-05-10 15:08:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-10 15:08:11','YYYY-MM-DD HH24:MI:SS'),100,'D','bd323bc4-d094-4dcb-b65c-dcb03fd04954')
;

-- May 10, 2024, 3:09:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216596,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',279,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',35,0,0,'Y',TO_TIMESTAMP('2024-05-10 15:09:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-10 15:09:22','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','886e0131-539b-4d10-bb0d-645c738f52e2','Y',0,'N','N','N','N','N')
;

-- May 10, 2024, 3:09:27 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_CAcctSchemaElement', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-05-10 15:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216596
;

-- May 10, 2024, 3:09:27 PM IST
ALTER TABLE C_AcctSchema_Element ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- May 10, 2024, 3:09:27 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT MAttributeSetInstance_CAcctSchemaElement FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 10, 2024, 3:10:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208482,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',217,216596,'Y','@ElementType@=''AI''',22,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-10 15:10:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-10 15:10:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb30259e-c7f2-4abc-a9fd-f5b5bb7e9f10','Y',280,1,2,1,'N','N','N','N')
;

-- May 10, 2024, 3:13:57 PM IST
UPDATE AD_Field SET Description='Attribute Set Instance', Help='The values of the actual Attribute Instances.', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2024-05-10 15:13:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208482
;

-- May 10, 2024, 3:14:28 PM IST
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2024-05-10 15:14:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216596
;

-- May 10, 2024, 3:15:19 PM IST
UPDATE AD_Column SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2024-05-10 15:15:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216596
;

-- May 10, 2024, 3:15:20 PM IST
ALTER TABLE C_AcctSchema_Element MODIFY M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- May 10, 2024, 3:16:21 PM IST
UPDATE AD_Column SET Description='Attribute Set Instance', Help='The values of the actual Attribute Instances. ',Updated=TO_TIMESTAMP('2024-05-10 15:16:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216596
;

-- May 10, 2024, 5:19:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216598,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',270,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-05-10 17:19:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-10 17:19:24','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','c2f4ba53-c210-4946-9a7b-7e9846a5e4a0','Y',0,'N','N','N','N','N')
;

-- May 10, 2024, 5:19:28 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_FactAcct', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-05-10 17:19:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216598
;

-- May 10, 2024, 5:19:28 PM IST
ALTER TABLE Fact_Acct ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- May 10, 2024, 5:19:28 PM IST
ALTER TABLE Fact_Acct ADD CONSTRAINT MAttributeSetInstance_FactAcct FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 10, 2024, 5:19:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208484,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',242,216598,'Y',22,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-10 17:19:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-10 17:19:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','95976a86-1388-42e5-9569-724e58afe5b5','Y',430,2)
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=330, XPosition=4,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208484
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3891
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5141
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208201
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208202
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208203
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208204
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2352
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2350
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2349
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2348
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2347
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2358
;

-- May 10, 2024, 5:20:10 PM IST
UPDATE AD_Field SET SeqNo=460,Updated=TO_TIMESTAMP('2024-05-10 17:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2365
;


-- Dec 6, 2024, 1:18:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216925,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',53203,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',35,0,0,'Y',TO_TIMESTAMP('2024-12-06 13:18:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-06 13:18:47','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','984d65d3-1bca-48d2-bf8e-03051022a37d','Y',0,'N','N','N','N','N')
;

-- Dec 6, 2024, 1:18:53 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_FactAcctSummary', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-06 13:18:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216925
;

-- Dec 6, 2024, 1:18:53 PM IST
ALTER TABLE Fact_Acct_Summary ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 6, 2024, 1:18:53 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT MAttributeSetInstance_FactAcctSummary FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 16, 2024, 5:03:42 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200485,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:03:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:03:38','YYYY-MM-DD HH24:MI:SS'),100,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',202,220,18,'N',22,'N','M_AttributeSetInstance_ID','Y','D',2019,'@$Element_AI@=Y','4b1419b8-7756-4673-a6f0-01466bab08ff','N','N','D','N')
;

-- Dec 16, 2024, 5:23:38 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200486,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:23:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:23:34','YYYY-MM-DD HH24:MI:SS'),100,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',204,150,18,252,'N',10,'N','C_Employee_ID','Y','D',203893,'@$Element_EP@=''Y''','a30aded2-cbaa-4c62-9ccf-ede94aebd99f','N','N','D','N')
;

-- Dec 16, 2024, 5:24:16 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200487,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:24:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:24:12','YYYY-MM-DD HH24:MI:SS'),100,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',204,160,19,'N',0,'N','C_Charge_ID','Y','D',968,'@$Element_CH@=''Y''','b00364e9-c0fe-4b78-97ed-85480b9f9bd1','N','N','D','N')
;

-- Dec 16, 2024, 5:28:13 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200488,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:28:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:28:09','YYYY-MM-DD HH24:MI:SS'),100,'Cost Center',204,170,19,'N',22,'N','C_CostCenter_ID','Y','D',203903,'@$Element_CC@=''Y''','12165c21-e62a-47d2-b02c-c39668723c94','N','N','D','N')
;

-- Dec 16, 2024, 5:28:34 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200489,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:28:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:28:34','YYYY-MM-DD HH24:MI:SS'),100,'Department',204,180,19,'N',22,'N','C_Department_ID','Y','D',203901,'@$Element_DP@=''Y''','13a7a878-f7c9-4a64-a656-be879db14650','N','N','D','N')
;

-- Dec 16, 2024, 5:30:00 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200490,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:29:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:29:57','YYYY-MM-DD HH24:MI:SS'),100,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',204,190,19,'N',0,'N','M_Warehouse_ID','Y','D',459,'@$Element_WH@=''Y''','98db2e07-5df7-4fdf-aa57-ffbfac651cca','N','N','D','N')
;

-- Dec 16, 2024, 5:31:53 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200492,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:31:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:31:52','YYYY-MM-DD HH24:MI:SS'),100,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',204,210,30,'N',0,'N','A_Asset_ID','Y','D',1884,'@$Element_AS@=''Y''','3796315c-af33-4a34-a042-66b3337dc92d','N','N','D','N')
;

-- Dec 16, 2024, 5:32:15 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200493,0,0,'Y',TO_TIMESTAMP('2024-12-16 17:32:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 17:32:11','YYYY-MM-DD HH24:MI:SS'),100,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',204,220,18,'N',22,'N','M_AttributeSetInstance_ID','Y','D',2019,'@$Element_AI@=Y','281d41a4-fbf5-4bbf-a93d-75843d7b5c81','N','N','D','N')
;


-- Dec 17, 2024, 12:20:49 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F1@=Y',Updated=TO_TIMESTAMP('2024-12-17 12:20:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208201
;

-- Dec 17, 2024, 12:20:56 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F2@=Y',Updated=TO_TIMESTAMP('2024-12-17 12:20:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208202
;

-- Dec 17, 2024, 12:21:03 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F3@=Y',Updated=TO_TIMESTAMP('2024-12-17 12:21:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208203
;

-- Dec 17, 2024, 12:21:12 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F4@=Y',Updated=TO_TIMESTAMP('2024-12-17 12:21:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208204
;

-- Dec 18, 2024, 4:37:01 PM IST
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=20,Updated=TO_TIMESTAMP('2024-12-18 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8479
;

-- Add C_Department_ID & C_CostCenter_ID


-- Dec 19, 2024, 4:33:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216927,0,'Department',318,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:33:42','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','0d525e96-abc5-4702-bd5f-8b52d21b53d9','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:33:46 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_CInvoice', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:33:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216927
;

-- Dec 19, 2024, 4:33:46 PM IST
ALTER TABLE C_Invoice ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:33:46 PM IST
ALTER TABLE C_Invoice ADD CONSTRAINT CDepartment_CInvoice FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 4:34:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216928,0,'Cost Center',318,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:34:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:34:03','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','933b94f7-eec3-4f66-8faf-5d7846bb79bc','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:34:06 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CInvoice', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:34:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216928
;

-- Dec 19, 2024, 4:34:06 PM IST
ALTER TABLE C_Invoice ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:34:06 PM IST
ALTER TABLE C_Invoice ADD CONSTRAINT CCostCenter_CInvoice FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 4:34:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216929,0,'Department',333,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:34:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:34:55','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','f04293c5-0d3d-4878-be9a-7199844cd3af','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:34:57 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_CInvoiceLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:34:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216929
;

-- Dec 19, 2024, 4:34:57 PM IST
ALTER TABLE C_InvoiceLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:34:57 PM IST
ALTER TABLE C_InvoiceLine ADD CONSTRAINT CDepartment_CInvoiceLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 4:35:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216930,0,'Cost Center',333,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:35:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:35:08','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','7a3af70b-8720-4ba6-b60e-2d8aa6e43dfd','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:35:10 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CInvoiceLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:35:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216930
;

-- Dec 19, 2024, 4:35:10 PM IST
ALTER TABLE C_InvoiceLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:35:10 PM IST
ALTER TABLE C_InvoiceLine ADD CONSTRAINT CCostCenter_CInvoiceLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 4:38:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216931,0,'Department',768,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:38:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:38:46','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','80b1bfb9-60d9-47e9-8a65-c98561a46af7','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:38:49 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_CInvoiceBatchLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:38:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216931
;

-- Dec 19, 2024, 4:38:49 PM IST
ALTER TABLE C_InvoiceBatchLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:38:49 PM IST
ALTER TABLE C_InvoiceBatchLine ADD CONSTRAINT CDepartment_CInvoiceBatchLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 4:39:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216932,0,'Cost Center',768,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:39:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:39:11','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','15821239-26d9-459c-a36b-d2f9df579f1a','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:39:13 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CInvoiceBatchLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:39:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216932
;

-- Dec 19, 2024, 4:39:13 PM IST
ALTER TABLE C_InvoiceBatchLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:39:13 PM IST
ALTER TABLE C_InvoiceBatchLine ADD CONSTRAINT CCostCenter_CInvoiceBatchLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 4:43:33 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208549,'Department',263,216927,'Y','@$Element_DP@=Y',22,480,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:43:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:43:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b46aac57-ee39-4d8f-b455-ffe25dc678bf','Y',470,2)
;

-- Dec 19, 2024, 4:43:34 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208550,'Cost Center',263,216928,'Y','@$Element_CC@=Y',22,490,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:43:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:43:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7ee62fed-04eb-4c23-9fd4-6d06ce6dbc29','Y',480,2)
;

-- Dec 19, 2024, 4:46:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208551,'Department',290,216927,'Y','@$Element_DP@=Y',22,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:46:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','43cce73d-c7df-4824-be5a-4409701d4bff','Y',450,2)
;

-- Dec 19, 2024, 4:46:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208552,'Cost Center',290,216928,'Y','@$Element_CC@=Y',22,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:46:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:46:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8d7d4823-f3d1-4e47-9b62-c2c07dfe22b3','Y',460,2)
;

-- Dec 19, 2024, 4:47:20 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208553,'Department',270,216929,'Y','@$Element_DP@=Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:47:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:47:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','955ab7dc-a60e-4bc8-a3c7-713aa7b299df','Y',270,2)
;

-- Dec 19, 2024, 4:47:21 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208554,'Cost Center',270,216930,'Y','@$Element_CC@=Y',22,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:47:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:47:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9b8fb85b-e1ee-4b83-8241-43be1435dd31','Y',280,2)
;

-- Dec 19, 2024, 4:47:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208555,'Department',291,216929,'Y','@$Element_DP@=Y',22,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:47:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:47:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','22c6523d-83d6-4589-9670-98366d81d1de','Y',320,2)
;

-- Dec 19, 2024, 4:47:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208556,'Cost Center',291,216930,'Y','@$Element_CC@=Y',22,340,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:47:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:47:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dfe2f3de-746a-44ef-b8df-45876c9f4a3b','Y',330,2)
;

-- Dec 19, 2024, 4:52:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208557,'Department',695,216931,'Y','@$Element_DP@=Y',22,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dcec35a3-cd22-461b-a499-1350d8279a23','Y',290,2)
;

-- Dec 19, 2024, 4:52:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208558,'Cost Center',695,216932,'Y','@$Element_CC@=Y',22,300,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 16:52:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:52:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec935dee-4c2b-4876-85fd-62cca00d5cc4','Y',300,2)
;

-- Dec 19, 2024, 4:55:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216933,0,'Department',259,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:55:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:55:50','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','d13f95b3-d55d-477e-b997-796015367d29','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:55:52 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_COrder', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216933
;

-- Dec 19, 2024, 4:55:52 PM IST
ALTER TABLE C_Order ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:55:52 PM IST
ALTER TABLE C_Order ADD CONSTRAINT CDepartment_COrder FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 4:56:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216934,0,'Cost Center',259,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 16:56:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 16:56:03','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','af7053d4-09f2-4e90-b29a-7e319bbdf3fd','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 4:56:05 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_COrder', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 16:56:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216934
;

-- Dec 19, 2024, 4:56:05 PM IST
ALTER TABLE C_Order ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 4:56:05 PM IST
ALTER TABLE C_Order ADD CONSTRAINT CCostCenter_COrder FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 5:12:43 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208559,'Department',186,216933,'Y','@$Element_DP@=Y',22,590,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:12:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:12:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a4223b03-1543-4d60-a380-6e8817dc7595','Y',580,2)
;

-- Dec 19, 2024, 5:12:44 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208560,'Cost Center',186,216934,'Y','@$Element_CC@=Y',22,600,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:12:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:12:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a5959680-65ae-40f5-b23a-511cee946778','Y',590,2)
;

-- Dec 19, 2024, 5:13:01 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208561,'Department',294,216933,'Y','@$Element_DP@=Y',22,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:13:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:13:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','624b65d7-861b-48d3-b7f8-7952066f2b05','Y',500,2)
;

-- Dec 19, 2024, 5:13:01 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208562,'Cost Center',294,216934,'Y','@$Element_CC@=Y',22,510,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:13:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:13:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','70f189d9-52aa-4415-943b-0fc20bf1003e','Y',510,2)
;

-- Dec 19, 2024, 5:22:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216935,0,'Department',260,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 17:22:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:22:28','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','4a4b4343-3e16-44d2-b658-a0d3ef73e3bb','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 5:22:32 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_COrderLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 17:22:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216935
;

-- Dec 19, 2024, 5:22:32 PM IST
ALTER TABLE C_OrderLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 5:22:32 PM IST
ALTER TABLE C_OrderLine ADD CONSTRAINT CDepartment_COrderLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 5:22:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216936,0,'Cost Center',260,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 17:22:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:22:42','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','51996f71-f666-4377-b631-93358b81dd5a','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 5:22:44 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_COrderLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 17:22:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216936
;

-- Dec 19, 2024, 5:22:44 PM IST
ALTER TABLE C_OrderLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 5:22:44 PM IST
ALTER TABLE C_OrderLine ADD CONSTRAINT CCostCenter_COrderLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 5:23:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208563,'Department',187,216935,'Y','@$Element_DP@=Y',22,390,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:23:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:23:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5245e606-d8a5-4280-8cde-71360c6b3e0e','Y',390,2)
;

-- Dec 19, 2024, 5:23:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208564,'Cost Center',187,216936,'Y','@$Element_CC@=Y',22,400,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:23:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:23:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','657e863e-f37b-4f81-af3d-99a5cfff112a','Y',400,2)
;

-- Dec 19, 2024, 5:24:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208565,'Department',293,216935,'Y','@$Element_DP@=Y',22,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:24:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:24:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0bf5312f-f189-4d80-b626-ae6394f137bc','Y',350,2)
;

-- Dec 19, 2024, 5:24:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208566,'Cost Center',293,216936,'Y','@$Element_CC@=Y',22,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:24:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:24:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ab32e891-934c-4d7e-b7d8-3b2ee65cfb46','Y',360,2)
;

-- Dec 19, 2024, 5:25:13 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216937,0,'Department',335,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 17:25:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:25:12','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','d409c20f-fd1f-4a58-93cf-9581ffcb66e0','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 5:25:14 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_CPayment', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 17:25:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216937
;

-- Dec 19, 2024, 5:25:14 PM IST
ALTER TABLE C_Payment ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 5:25:14 PM IST
ALTER TABLE C_Payment ADD CONSTRAINT CDepartment_CPayment FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 5:25:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216938,0,'Cost Center',335,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 17:25:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:25:25','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','6f052ca7-cac3-4ada-8deb-b56870e23036','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 5:25:28 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CPayment', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 17:25:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216938
;

-- Dec 19, 2024, 5:25:28 PM IST
ALTER TABLE C_Payment ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 5:25:28 PM IST
ALTER TABLE C_Payment ADD CONSTRAINT CCostCenter_CPayment FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 5:25:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208567,'Department',330,216937,'Y','@$Element_DP@=Y',22,760,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:25:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:25:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','652838c0-65b8-45ca-916a-6b07d1db8ccc','Y',760,2)
;

-- Dec 19, 2024, 5:25:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208568,'Cost Center',330,216938,'Y','@$Element_CC@=Y',22,770,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 17:25:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 17:25:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','704751fe-8532-484d-a294-9deb697da109','Y',770,2)
;

-- Dec 19, 2024, 6:57:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216939,0,'Department',200031,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 18:57:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 18:57:46','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','f658efe2-dfa3-4fe8-bef1-a402bea2a0ca','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 6:57:51 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_CPaymentTransaction', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 18:57:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216939
;

-- Dec 19, 2024, 6:57:51 PM IST
ALTER TABLE C_PaymentTransaction ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 6:57:52 PM IST
ALTER TABLE C_PaymentTransaction ADD CONSTRAINT CDepartment_CPaymentTransaction FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 6:58:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216940,0,'Cost Center',200031,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 18:58:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 18:58:23','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','6cce7c28-da2c-4a84-836b-fa9bf057d34d','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 6:58:27 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CPaymentTransaction', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 18:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216940
;

-- Dec 19, 2024, 6:58:27 PM IST
ALTER TABLE C_PaymentTransaction ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 6:58:27 PM IST
ALTER TABLE C_PaymentTransaction ADD CONSTRAINT CCostCenter_CPaymentTransaction FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 6:58:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208569,'Department',200027,216939,'Y','@$Element_DP@=Y',22,730,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 18:58:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 18:58:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7972a24b-4c3e-469e-b9de-86775f11a82e','Y',730,2)
;

-- Dec 19, 2024, 6:58:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208570,'Cost Center',200027,216940,'Y','@$Element_CC@=Y',22,740,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 18:58:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 18:58:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f7d782b-57b9-4799-a8c4-26d77838f7cf','Y',740,2)
;

-- Dec 19, 2024, 7:15:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216941,0,'Cost Center',319,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:15:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:15:41','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','0fb4ec62-adb1-4ea6-8ec8-b93472db674f','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:15:48 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MInOut', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:15:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216941
;

-- Dec 19, 2024, 7:15:48 PM IST
ALTER TABLE M_InOut ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:15:49 PM IST
ALTER TABLE M_InOut ADD CONSTRAINT CCostCenter_MInOut FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:16:22 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216942,0,'Department',319,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:16:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:16:22','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','bc17893c-d73b-4a9f-b177-c884f52534bd','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:16:24 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MInOut', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:16:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216942
;

-- Dec 19, 2024, 7:16:24 PM IST
ALTER TABLE M_InOut ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:16:24 PM IST
ALTER TABLE M_InOut ADD CONSTRAINT CDepartment_MInOut FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:16:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208571,'Cost Center',257,216941,'Y','@$Element_CC@=Y',22,580,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:16:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1a6dcf1a-10a6-47c3-84e6-c5b9965f4972','Y',570,2)
;

-- Dec 19, 2024, 7:16:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208572,'Department',257,216942,'Y','@$Element_DP@=Y',22,590,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:16:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:16:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1ff7b460-7301-46b4-a14d-23d8a55ffcc3','Y',580,2)
;

-- Dec 19, 2024, 7:17:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208573,'Cost Center',296,216941,'Y','@$Element_CC@=Y',22,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:17:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:17:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6234e81e-313e-43e1-8509-162e541ce698','Y',410,2)
;

-- Dec 19, 2024, 7:17:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208574,'Department',296,216942,'Y','@$Element_DP@=Y',22,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:17:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:17:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d4f18f57-c838-4fcc-8776-6186380a8705','Y',420,2)
;

-- Dec 19, 2024, 7:18:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216943,0,'Cost Center',320,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:18:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:18:10','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','dc4eca6c-f03c-4967-b0ef-9d55e1001525','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:18:12 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MInOutLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:18:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216943
;

-- Dec 19, 2024, 7:18:12 PM IST
ALTER TABLE M_InOutLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:18:12 PM IST
ALTER TABLE M_InOutLine ADD CONSTRAINT CCostCenter_MInOutLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:18:27 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216944,0,'Department',320,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:18:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:18:26','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','39c4f016-3936-4643-9114-acb04dfa6737','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:18:28 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MInOutLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:18:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216944
;

-- Dec 19, 2024, 7:18:28 PM IST
ALTER TABLE M_InOutLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:18:28 PM IST
ALTER TABLE M_InOutLine ADD CONSTRAINT CDepartment_MInOutLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:18:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208575,'Cost Center',258,216943,'Y','@$Element_CC@=Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:18:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:18:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2e21042f-a42a-424e-aac9-03cbbbf7c10b','Y',270,2)
;

-- Dec 19, 2024, 7:18:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208576,'Department',258,216944,'Y','@$Element_DP@=Y',22,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:18:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:18:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a4c71d14-47d9-4881-b87c-c059642de9cb','Y',280,2)
;

-- Dec 19, 2024, 7:19:19 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208577,'Cost Center',297,216943,'Y','@$Element_CC@=Y',22,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:19:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:19:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a54c8b11-df19-4130-8424-0dcadaa17d74','Y',260,2)
;

-- Dec 19, 2024, 7:19:20 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208578,'Department',297,216944,'Y','@$Element_DP@=Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:19:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:19:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a1690e73-6e98-494c-beed-3f98326b7bf4','Y',270,2)
;

-- Dec 19, 2024, 7:20:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208579,'Cost Center',53271,216941,'Y','@$Element_CC@=Y',22,410,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:20:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:20:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ce433614-b820-4992-b58a-570ff188b19f','Y',410,2)
;

-- Dec 19, 2024, 7:20:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208580,'Department',53271,216942,'Y','@$Element_DP@=Y',22,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:20:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:20:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','04998129-2489-4e61-9233-bc9b0d411f7a','Y',420,2)
;

-- Dec 19, 2024, 7:20:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208581,'Cost Center',53272,216943,'Y','@$Element_CC@=Y',22,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:20:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:20:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3896b0a2-96c9-467b-988c-a22a5dad18cb','Y',260,2)
;

-- Dec 19, 2024, 7:20:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208582,'Department',53272,216944,'Y','@$Element_DP@=Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:20:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:20:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6d822328-be80-4933-9747-bee153ac09ee','Y',270,2)
;

-- Dec 19, 2024, 7:20:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208583,'Cost Center',53276,216941,'Y','@$Element_CC@=Y',22,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:20:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:20:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f80d2755-c282-49d4-8be5-7151106e29a2','Y',460,2)
;

-- Dec 19, 2024, 7:20:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208584,'Department',53276,216942,'Y','@$Element_DP@=Y',22,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:20:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:20:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cc121e2c-80cc-4ad0-a488-6992b26c1057','Y',470,2)
;

-- Dec 19, 2024, 7:21:03 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208585,'Cost Center',53277,216943,'Y','@$Element_CC@=Y',22,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:21:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:21:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','af077c02-5c56-4252-bca3-f986a8493960','Y',260,2)
;

-- Dec 19, 2024, 7:21:04 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208586,'Department',53277,216944,'Y','@$Element_DP@=Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:21:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:21:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5c909be1-ee63-4cbe-87a1-5cf82914274e','Y',270,2)
;

-- Dec 19, 2024, 7:22:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216945,0,'Cost Center',323,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:22:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:22:11','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','0e552df9-f027-4a53-86fe-b53686076486','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:22:13 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MMovement', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:22:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216945
;

-- Dec 19, 2024, 7:22:13 PM IST
ALTER TABLE M_Movement ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:22:13 PM IST
ALTER TABLE M_Movement ADD CONSTRAINT CCostCenter_MMovement FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:22:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216946,0,'Department',323,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:22:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:22:25','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','51490ac5-4646-4233-bb64-69b3886753be','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:22:27 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MMovement', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:22:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216946
;

-- Dec 19, 2024, 7:22:27 PM IST
ALTER TABLE M_Movement ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:22:27 PM IST
ALTER TABLE M_Movement ADD CONSTRAINT CDepartment_MMovement FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:23:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216947,0,'Cost Center',324,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:23:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:23:15','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','0bbb6599-ee04-4105-a519-c5da29681e55','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:23:18 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MMovementLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:23:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216947
;

-- Dec 19, 2024, 7:23:18 PM IST
ALTER TABLE M_MovementLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:23:18 PM IST
ALTER TABLE M_MovementLine ADD CONSTRAINT CCostCenter_MMovementLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:23:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216948,0,'Department',324,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:23:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:23:31','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','f47b6893-e172-4498-8d43-f3a809e8b78b','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:23:33 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MMovementLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:23:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216948
;

-- Dec 19, 2024, 7:23:33 PM IST
ALTER TABLE M_MovementLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:23:33 PM IST
ALTER TABLE M_MovementLine ADD CONSTRAINT CDepartment_MMovementLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:24:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208587,'Cost Center',259,216945,'Y','@$Element_CC@=Y',22,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:24:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:24:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6bf99dca-6491-4cac-9187-04c2e642ff62','Y',330,2)
;

-- Dec 19, 2024, 7:24:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208588,'Department',259,216946,'Y','@$Element_DP@=Y',22,340,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:24:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:24:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b5f3e7cc-df16-47e4-b67c-7ad43f09339b','Y',340,2)
;

-- Dec 19, 2024, 7:24:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208589,'Cost Center',260,216947,'Y','@$Element_CC@=Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:24:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:24:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9ea40348-a427-44c9-b89a-044f80bdc306','Y',170,2)
;

-- Dec 19, 2024, 7:24:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208590,'Department',260,216948,'Y','@$Element_DP@=Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:24:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:24:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b950925e-51e4-4844-b025-9ac191bd6b11','Y',180,2)
;

-- Dec 19, 2024, 7:26:14 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216949,0,'Cost Center',321,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:26:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:26:13','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','05dfe243-ffe2-490f-bb04-39ffc2f80a5f','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:26:15 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MInventory', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:26:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216949
;

-- Dec 19, 2024, 7:26:15 PM IST
ALTER TABLE M_Inventory ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:26:15 PM IST
ALTER TABLE M_Inventory ADD CONSTRAINT CCostCenter_MInventory FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:26:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216950,0,'Department',321,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:26:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:26:32','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','b2a614be-9b60-4573-8251-4fa42f5564bf','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:26:34 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MInventory', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:26:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216950
;

-- Dec 19, 2024, 7:26:34 PM IST
ALTER TABLE M_Inventory ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:26:34 PM IST
ALTER TABLE M_Inventory ADD CONSTRAINT CDepartment_MInventory FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:27:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216951,0,'Cost Center',322,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:27:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:27:25','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','8418319e-b146-495b-8b89-7502f1dcad56','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:27:28 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MInventoryLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:27:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216951
;

-- Dec 19, 2024, 7:27:28 PM IST
ALTER TABLE M_InventoryLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:27:28 PM IST
ALTER TABLE M_InventoryLine ADD CONSTRAINT CCostCenter_MInventoryLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:27:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216952,0,'Department',322,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:27:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:27:45','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','d33c19f9-689c-477e-bad5-e212898eca15','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:27:49 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MInventoryLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:27:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216952
;

-- Dec 19, 2024, 7:27:49 PM IST
ALTER TABLE M_InventoryLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:27:49 PM IST
ALTER TABLE M_InventoryLine ADD CONSTRAINT CDepartment_MInventoryLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:28:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208591,'Cost Center',200102,216949,'Y','@$Element_CC@=Y',22,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:28:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:28:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8c031dd-e08d-48dc-9abf-38fc697f4b46','Y',220,2)
;

-- Dec 19, 2024, 7:28:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208592,'Department',200102,216950,'Y','@$Element_DP@=Y',22,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:28:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:28:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da2b4488-15ac-46f4-93c3-1601923e1573','Y',230,2)
;

-- Dec 19, 2024, 7:28:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208593,'Cost Center',200103,216951,'Y','@$Element_CC@=Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:28:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:28:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2312f3f5-a881-4691-a2b9-f027aa3560f1','Y',130,2)
;

-- Dec 19, 2024, 7:28:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208594,'Department',200103,216952,'Y','@$Element_DP@=Y',22,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:28:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:28:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7bc0cf7f-1f9e-44a9-942b-64bbc7c19139','Y',140,2)
;

-- Dec 19, 2024, 7:44:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216953,0,'Cost Center',325,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:44:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:44:32','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','19aaeb90-e628-423f-a1f3-5a214efcdfec','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:44:35 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MProduction', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216953
;

-- Dec 19, 2024, 7:44:35 PM IST
ALTER TABLE M_Production ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:44:35 PM IST
ALTER TABLE M_Production ADD CONSTRAINT CCostCenter_MProduction FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:44:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216954,0,'Department',325,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:44:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:44:48','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','d8bb76e1-aed1-4159-8b32-a6507ce992a1','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:44:53 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MProduction', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:44:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216954
;

-- Dec 19, 2024, 7:44:53 PM IST
ALTER TABLE M_Production ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:44:53 PM IST
ALTER TABLE M_Production ADD CONSTRAINT CDepartment_MProduction FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:45:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216955,0,'Cost Center',326,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:45:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:45:22','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','fd922a62-a159-4a4b-a518-2961c4360854','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:45:25 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MProductionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:45:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216955
;

-- Dec 19, 2024, 7:45:25 PM IST
ALTER TABLE M_ProductionLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:45:25 PM IST
ALTER TABLE M_ProductionLine ADD CONSTRAINT CCostCenter_MProductionLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:45:35 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216956,0,'Department',326,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 19:45:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:45:34','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','726cbdfa-101a-41ea-a267-a67d2b9840e3','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 7:45:37 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MProductionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 19:45:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216956
;

-- Dec 19, 2024, 7:45:37 PM IST
ALTER TABLE M_ProductionLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 7:45:37 PM IST
ALTER TABLE M_ProductionLine ADD CONSTRAINT CDepartment_MProductionLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 7:46:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208595,'Cost Center',53344,216953,'Y','@$Element_CC@=Y',22,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:46:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:46:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb9c07f2-1adb-4535-89fd-2926ee24c249','Y',310,2)
;

-- Dec 19, 2024, 7:46:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208596,'Department',53344,216954,'Y','@$Element_DP@=Y',22,300,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:46:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:46:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9a057f2a-15f4-41c3-9d42-31024d99ba52','Y',320,2)
;

-- Dec 19, 2024, 7:46:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208597,'Cost Center',53345,216955,'Y','@$Element_CC@=Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:46:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:46:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a26d0ff0-7cc1-4f15-9b9a-26373ff5cb25','Y',150,2)
;

-- Dec 19, 2024, 7:46:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208598,'Department',53345,216956,'Y','@$Element_DP@=Y',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 19:46:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 19:46:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','76c4c91a-e84d-430f-ab7f-6c8914f2935a','Y',160,2)
;

-- Dec 19, 2024, 8:43:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216957,0,'Cost Center',417,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 20:43:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:43:17','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','e5ac74ef-bb54-44bc-a7e8-e92c957fa433','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 8:43:20 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_RRequest', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 20:43:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216957
;

-- Dec 19, 2024, 8:43:20 PM IST
ALTER TABLE R_Request ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 8:43:20 PM IST
ALTER TABLE R_Request ADD CONSTRAINT CCostCenter_RRequest FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 8:43:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216958,0,'Department',417,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-19 20:43:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:43:32','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','d9cfa64d-94cb-4517-b0f0-ff225a75b23f','Y',0,'N','N','N','N','N')
;

-- Dec 19, 2024, 8:43:34 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_RRequest', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 20:43:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216958
;

-- Dec 19, 2024, 8:43:34 PM IST
ALTER TABLE R_Request ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 19, 2024, 8:43:34 PM IST
ALTER TABLE R_Request ADD CONSTRAINT CDepartment_RRequest FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 8:44:01 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208599,'Cost Center',344,216957,'Y','@$Element_CC@=Y',22,610,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b2ccfa94-0fd4-4cac-9781-e7a5aef0cefc','Y',600,2)
;

-- Dec 19, 2024, 8:44:02 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208600,'Department',344,216958,'Y','@$Element_DP@=Y',22,620,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b254f37a-82cd-4c85-b790-6385899b82d5','Y',610,2)
;

-- Dec 19, 2024, 8:44:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208601,'Cost Center',402,216957,'Y','@$Element_CC@=Y',22,580,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9503095c-3603-40b2-917d-793b9f7712c7','Y',610,2)
;

-- Dec 19, 2024, 8:44:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208602,'Department',402,216958,'Y','@$Element_DP@=Y',22,590,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2bd16af1-9929-42e2-ac7a-eb9e35e68048','Y',620,2)
;

-- Dec 19, 2024, 8:44:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208603,'Cost Center',556,216957,'Y','@$Element_CC@=Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4dcd005e-2e3f-4af1-a050-55f682cb31a4','Y',170,2)
;

-- Dec 19, 2024, 8:44:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208604,'Department',556,216958,'Y','@$Element_DP@=Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b01b5b8f-2f4b-4cac-8cd4-d4d660ed4d69','Y',180,2)
;

-- Dec 19, 2024, 8:44:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208605,'Cost Center',737,216957,'Y','@$Element_CC@=Y',22,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a0746aa5-b73c-48a3-b34c-2c65d5d24968','Y',230,2)
;

-- Dec 19, 2024, 8:44:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208606,'Department',737,216958,'Y','@$Element_DP@=Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:44:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f1f2f777-e8c7-43f5-8082-7a52ca204c1f','Y',240,2)
;

-- Dec 19, 2024, 8:45:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208607,'Cost Center',743,216957,'Y','@$Element_CC@=Y',22,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:45:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:45:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','39e3b62e-d5ee-4d4e-b06f-c7d6d861e147','Y',230,2)
;

-- Dec 19, 2024, 8:45:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208608,'Department',743,216958,'Y','@$Element_DP@=Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:45:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:45:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0a5a2ae5-5418-4cec-8c01-04426cdd3c7e','Y',240,2)
;

-- Dec 19, 2024, 8:45:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208609,'Cost Center',53461,216957,'Y','@$Element_CC@=Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:45:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e1e5b4ba-9d0a-40e0-aa0e-6c46340f3be5','Y',170,2)
;

-- Dec 19, 2024, 8:45:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208610,'Department',53461,216958,'Y','@$Element_DP@=Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-19 20:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-19 20:45:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0b609bda-3b87-46cd-9783-a270524868b1','Y',180,2)
;

-- Dec 20, 2024, 12:33:59 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216959,0,'Cost Center',53137,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 12:33:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:33:58','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','54288cdf-9094-4e59-913e-90b3131ad19a','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 12:34:01 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_AAssetAddition', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 12:34:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216959
;

-- Dec 20, 2024, 12:34:01 PM IST
ALTER TABLE A_Asset_Addition ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 12:34:01 PM IST
ALTER TABLE A_Asset_Addition ADD CONSTRAINT CCostCenter_AAssetAddition FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 12:34:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216960,0,'Department',53137,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 12:34:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:34:09','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','8bae4f4a-cfcd-47a3-b62a-482d0fdacc2f','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 12:34:11 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_AAssetAddition', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 12:34:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216960
;

-- Dec 20, 2024, 12:34:11 PM IST
ALTER TABLE A_Asset_Addition ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 12:34:11 PM IST
ALTER TABLE A_Asset_Addition ADD CONSTRAINT CDepartment_AAssetAddition FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 12:34:41 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208611,'Cost Center',53323,216959,'Y','@$Element_CC@=Y',22,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:34:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3fbc125f-f4d0-498a-a952-73cf81db5d45','Y',360,2)
;

-- Dec 20, 2024, 12:34:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208612,'Department',53323,216960,'Y','@$Element_DP@=Y',22,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:34:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d7444d34-cc55-4c08-967a-33bcebda0323','Y',370,2)
;

-- Dec 20, 2024, 12:35:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208613,'Cost Center',53324,216959,'Y','@$Element_CC@=Y',22,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:34:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:34:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8767a5c5-3178-47cd-8e75-484d5b31ca97','Y',410,2)
;

-- Dec 20, 2024, 12:35:01 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208614,'Department',53324,216960,'Y','@$Element_DP@=Y',22,430,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:35:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:35:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4398d047-c2a2-4e1f-b0f2-c42df3e1ec00','Y',420,2)
;

-- Dec 20, 2024, 12:41:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216961,0,'Cost Center',53127,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 12:41:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:41:34','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','b9173831-e9dd-4ea8-9459-2be736bf4f7f','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 12:41:36 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_AAssetDisposed', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 12:41:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216961
;

-- Dec 20, 2024, 12:41:36 PM IST
ALTER TABLE A_Asset_Disposed ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 12:41:36 PM IST
ALTER TABLE A_Asset_Disposed ADD CONSTRAINT CCostCenter_AAssetDisposed FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 12:41:46 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216962,0,'Department',53127,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 12:41:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:41:45','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','4999c5f5-05ad-4067-b4a8-87406443961c','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 12:41:48 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_AAssetDisposed', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 12:41:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216962
;

-- Dec 20, 2024, 12:41:48 PM IST
ALTER TABLE A_Asset_Disposed ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 12:41:48 PM IST
ALTER TABLE A_Asset_Disposed ADD CONSTRAINT CDepartment_AAssetDisposed FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 12:42:16 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208615,'Cost Center',53325,216961,'Y','@$Element_CC@=Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:42:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:42:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8a8655db-9cab-40e3-aaad-c5290e7bb1df','Y',220,2)
;

-- Dec 20, 2024, 12:42:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208616,'Department',53325,216962,'Y','@$Element_DP@=Y',22,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:42:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:42:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4cde39ae-6eca-4506-bde5-1b4c98e0c0cd','Y',230,2)
;

-- Dec 20, 2024, 12:46:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216963,0,'Cost Center',53275,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 12:46:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:46:26','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','43049adf-778a-41d7-aa4e-04fa304b68fd','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 12:46:28 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_AAssetReval', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 12:46:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216963
;

-- Dec 20, 2024, 12:46:28 PM IST
ALTER TABLE A_Asset_Reval ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 12:46:28 PM IST
ALTER TABLE A_Asset_Reval ADD CONSTRAINT CCostCenter_AAssetReval FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 12:46:59 PM IST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-12-20 12:46:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216963
;

-- Dec 20, 2024, 12:47:22 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216964,0,'Department',53275,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 12:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:47:22','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','17aabadd-345f-4b77-b840-1df208d5fa35','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 12:47:23 PM IST
ALTER TABLE A_Asset_Reval MODIFY C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 12:47:24 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_AAssetReval', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 12:47:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216964
;

-- Dec 20, 2024, 12:47:24 PM IST
ALTER TABLE A_Asset_Reval ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 12:47:24 PM IST
ALTER TABLE A_Asset_Reval ADD CONSTRAINT CDepartment_AAssetReval FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 12:50:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208617,'Cost Center',53331,216963,'Y','@$Element_CC@=Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:50:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:50:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5cfa5b17-607c-4931-8756-e5fbc554a84e','Y',180,2)
;

-- Dec 20, 2024, 12:50:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208618,'Department',53331,216964,'Y','@$Element_DP@=Y',22,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 12:50:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 12:50:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a9fd8548-d522-48fc-a772-abfb93c79699','Y',190,2)
;

-- Dec 20, 2024, 1:37:46 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216965,0,'Cost Center',53128,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 13:37:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:37:45','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','250a8ffc-c2d0-4fd4-84ea-b83e27b32062','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 1:37:48 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_AAssetTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 13:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216965
;

-- Dec 20, 2024, 1:37:48 PM IST
ALTER TABLE A_Asset_Transfer ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 1:37:48 PM IST
ALTER TABLE A_Asset_Transfer ADD CONSTRAINT CCostCenter_AAssetTransfer FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 1:38:03 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216966,0,'Department',53128,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 13:38:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:38:02','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','10a633d3-370d-4c98-b455-ddff04a0cb3b','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 1:38:04 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_AAssetTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 13:38:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216966
;

-- Dec 20, 2024, 1:38:04 PM IST
ALTER TABLE A_Asset_Transfer ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 1:38:04 PM IST
ALTER TABLE A_Asset_Transfer ADD CONSTRAINT CDepartment_AAssetTransfer FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 1:38:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208619,'Cost Center',53149,216965,'Y','@$Element_CC@=Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:38:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:38:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','530d81be-1d59-4f2e-b2f9-c26f62cd942a','Y',240,2)
;

-- Dec 20, 2024, 1:38:19 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208620,'Department',53149,216966,'Y','@$Element_DP@=Y',22,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:38:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:38:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1949fd2d-a6f2-4e8e-bb4c-4037c342295d','Y',250,2)
;

-- Dec 20, 2024, 1:38:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208621,'Cost Center',53327,216965,'Y','@$Element_CC@=Y',22,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:38:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:38:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f6726d82-2ecf-4a2d-9c75-8b74c911e386','Y',230,2)
;

-- Dec 20, 2024, 1:38:32 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208622,'Department',53327,216966,'Y','@$Element_DP@=Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:38:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:38:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3fd45f80-ca34-4535-81ab-87c635d14d83','Y',240,2)
;

-- Dec 20, 2024, 1:45:21 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216967,0,'Cost Center',53121,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 13:45:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:45:20','YYYY-MM-DD HH24:MI:SS'),100,203903,'N','N','D','N','N','N','Y','99e2b60f-c169-4aa2-8a83-a5bd7a14cc3f','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 1:45:23 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_ADepreciationEntry', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 13:45:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216967
;

-- Dec 20, 2024, 1:45:23 PM IST
ALTER TABLE A_Depreciation_Entry ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 1:45:23 PM IST
ALTER TABLE A_Depreciation_Entry ADD CONSTRAINT CCostCenter_ADepreciationEntry FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 1:45:31 PM IST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-12-20 13:45:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216967
;

-- Dec 20, 2024, 1:45:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216968,0,'Department',53121,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 13:45:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:45:44','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','feb45ec9-4d1c-40e5-9216-3aa317a01ff1','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 1:45:47 PM IST
ALTER TABLE A_Depreciation_Entry MODIFY C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 1:45:47 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_ADepreciationEntry', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 13:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216968
;

-- Dec 20, 2024, 1:45:47 PM IST
ALTER TABLE A_Depreciation_Entry ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 1:45:47 PM IST
ALTER TABLE A_Depreciation_Entry ADD CONSTRAINT CDepartment_ADepreciationEntry FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 1:46:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208623,'Cost Center',53140,216967,'Y','@$Element_CC@=Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:46:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:46:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','789091c5-dc50-42d6-bbdd-862efc960c07','Y',140,2)
;

-- Dec 20, 2024, 1:46:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208624,'Department',53140,216968,'Y','@$Element_DP@=Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:46:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:46:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e5c1bb77-d170-4019-be06-36161cfae9f9','Y',150,2)
;

-- Dec 20, 2024, 1:46:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208625,'Cost Center',53141,216967,'Y','@$Element_CC@=Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:46:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:46:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2a867bcd-c9e0-4392-b638-6acfe49d59c4','Y',140,2)
;

-- Dec 20, 2024, 1:46:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208626,'Department',53141,216968,'Y','@$Element_DP@=Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:46:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:46:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ee31d057-d749-41f2-8a02-d00ab1068827','Y',150,2)
;

-- Dec 20, 2024, 1:47:23 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208627,'Cost Center',53151,216967,'Y','@$Element_CC@=Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:47:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','18efd72e-695c-4a49-859e-f12580e3b747','Y',140,2)
;

-- Dec 20, 2024, 1:47:23 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208628,'Department',53151,216968,'Y','@$Element_DP@=Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:47:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:47:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0cef64b0-ff3b-48cd-b86b-b9ca72eec89c','Y',150,2)
;

-- Dec 20, 2024, 1:47:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208629,'Cost Center',53153,216967,'Y','@$Element_CC@=Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:47:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f990237-931e-4e11-a743-125a7b853377','Y',170,2)
;

-- Dec 20, 2024, 1:47:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208630,'Department',53153,216968,'Y','@$Element_DP@=Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 13:47:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 13:47:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0840dbb3-7881-490e-9f0e-9d1766949ffe','Y',180,2)
;

-- Dec 20, 2024, 2:53:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216971,0,'Cost Center',53027,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 14:53:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 14:53:42','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','1dc5130f-6fab-42e2-857c-49c57cac2175','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 2:53:45 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_PPOrder', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 14:53:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216971
;

-- Dec 20, 2024, 2:53:45 PM IST
ALTER TABLE PP_Order ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 2:53:45 PM IST
ALTER TABLE PP_Order ADD CONSTRAINT CCostCenter_PPOrder FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 2:54:01 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216972,0,'Department',53027,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 14:54:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 14:54:00','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','614c5fa1-4e80-4b34-863e-e63123449588','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 2:54:02 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_PPOrder', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 14:54:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216972
;

-- Dec 20, 2024, 2:54:02 PM IST
ALTER TABLE PP_Order ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 2:54:02 PM IST
ALTER TABLE PP_Order ADD CONSTRAINT CDepartment_PPOrder FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 2:54:28 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208631,'Cost Center',53054,216971,'Y','@$Element_CC@=Y',22,490,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 14:54:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 14:54:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','5804b2fa-4c84-4da3-9c32-7c3501c351ef','Y',490,2)
;

-- Dec 20, 2024, 2:54:29 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208632,'Department',53054,216972,'Y','@$Element_DP@=Y',22,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 14:54:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 14:54:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','eda34816-f0e0-49bc-a300-29c89bf7a921','Y',500,2)
;

-- Dec 20, 2024, 3:54:55 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216973,0,'Cost Center',708,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 15:54:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 15:54:54','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','d8ff3699-1ca2-4ed1-95ac-7306b28dc2f8','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 3:54:57 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 15:54:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216973
;

-- Dec 20, 2024, 3:54:57 PM IST
ALTER TABLE GL_Distribution ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 3:54:58 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT CCostCenter_GLDistribution FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 3:55:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216974,0,'Department',708,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 15:55:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 15:55:08','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','0e24fa3c-95a2-459f-b206-43b4a23b182a','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 3:55:10 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 15:55:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216974
;

-- Dec 20, 2024, 3:55:10 PM IST
ALTER TABLE GL_Distribution ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 3:55:10 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT CDepartment_GLDistribution FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 3:55:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208633,'Cost Center',646,216973,'Y','@$Element_CC@=Y',22,430,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 15:55:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 15:55:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a1454186-3e09-4e61-a582-1697ffcaa9a5','Y',420,2)
;

-- Dec 20, 2024, 3:55:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208634,'Department',646,216974,'Y','@$Element_DP@=Y',22,440,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 15:55:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 15:55:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dbe0f61a-1238-4719-9cb7-e121818f9c2e','Y',430,2)
;

-- Dec 20, 2024, 3:58:18 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216975,0,'Cost Center',707,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 15:58:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 15:58:17','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','4c800271-d226-42d6-bfb0-fe7389a3c789','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 3:58:19 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 15:58:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216975
;

-- Dec 20, 2024, 3:58:19 PM IST
ALTER TABLE GL_DistributionLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 3:58:19 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT CCostCenter_GLDistributionLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 3:58:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216976,0,'Department',707,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 15:58:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 15:58:31','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','ab9e5842-5976-49c4-ad63-7166974a9718','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 3:58:34 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 15:58:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216976
;

-- Dec 20, 2024, 3:58:34 PM IST
ALTER TABLE GL_DistributionLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 3:58:34 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT CDepartment_GLDistributionLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 4:01:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208635,'Cost Center',647,216975,'Y','@$Element_CC@=Y',22,340,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 16:01:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:01:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','48727e4b-54cc-4efe-9cfc-57725b3bdd52','Y',340,2)
;

-- Dec 20, 2024, 4:01:51 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208636,'Department',647,216976,'Y','@$Element_DP@=Y',22,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 16:01:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:01:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ba0f390d-a434-4c5a-816a-64b8c3d730ba','Y',350,2)
;

-- Dec 20, 2024, 4:03:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216977,0,'Cost Center',226,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 16:03:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:03:34','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','34140141-29c6-4856-ad6a-e6efbb8ea685','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 4:03:36 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 16:03:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216977
;

-- Dec 20, 2024, 4:03:36 PM IST
ALTER TABLE GL_JournalLine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 4:03:36 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT CCostCenter_GLJournalLine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 4:03:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216978,0,'Department',226,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-20 16:03:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:03:46','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','af1ed6d8-05c6-40ce-822c-16bc0ca98afd','Y',0,'N','N','N','N','N')
;

-- Dec 20, 2024, 4:03:49 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-20 16:03:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216978
;

-- Dec 20, 2024, 4:03:49 PM IST
ALTER TABLE GL_JournalLine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 20, 2024, 4:03:49 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT CDepartment_GLJournalLine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2024, 4:04:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208637,'Cost Center',161,216977,'Y','@$Element_CC@=Y',22,380,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 16:04:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:04:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6629b7f5-1b5a-42d0-bdaf-c5b7080d363d','Y',380,2)
;

-- Dec 20, 2024, 4:04:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208638,'Department',161,216978,'Y','@$Element_DP@=Y',22,390,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 16:04:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:04:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','624d5edd-1517-4570-97fc-dd5614bd982f','Y',390,2)
;

-- Dec 20, 2024, 4:04:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208639,'Cost Center',200008,216977,'Y','@$Element_CC@=Y',22,380,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 16:04:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:04:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f0fdfdb7-0dad-4a02-bc4b-489a38b0e386','Y',380,2)
;

-- Dec 20, 2024, 4:04:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208640,'Department',200008,216978,'Y','@$Element_DP@=Y',22,390,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-20 16:04:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-20 16:04:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5fd4766d-e9a5-4444-b3d6-7cb26d32910a','Y',390,2)
;


-- Dec 23, 2024, 12:18:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216979,0,'Cost Center',660,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-23 12:18:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-23 12:18:55','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','8410aa6f-4836-431c-a43c-dffaff3dd1dc','Y',0,'N','N','N','N','N')
;

-- Dec 23, 2024, 12:18:59 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_MRMALine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-23 12:18:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216979
;

-- Dec 23, 2024, 12:18:59 PM IST
ALTER TABLE M_RMALine ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 23, 2024, 12:18:59 PM IST
ALTER TABLE M_RMALine ADD CONSTRAINT CCostCenter_MRMALine FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 23, 2024, 12:19:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216980,0,'Department',660,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-23 12:19:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-23 12:19:11','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','b431ec2d-3276-4fd7-b920-01879cf089ea','Y',0,'N','N','N','N','N')
;

-- Dec 23, 2024, 12:19:13 PM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_MRMALine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-23 12:19:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216980
;

-- Dec 23, 2024, 12:19:13 PM IST
ALTER TABLE M_RMALine ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 23, 2024, 12:19:13 PM IST
ALTER TABLE M_RMALine ADD CONSTRAINT CDepartment_MRMALine FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 23, 2024, 12:19:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208641,'Cost Center',629,216979,'Y','@$Element_CC@=Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-23 12:19:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-23 12:19:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa03734b-552c-4c48-970d-5018ea99b3b8','Y',130,2)
;

-- Dec 23, 2024, 12:19:39 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208642,'Department',629,216980,'Y','@$Element_DP@=Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-23 12:19:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-23 12:19:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','826ea980-5080-4fd2-87a2-6c2be22e2b99','Y',140,2)
;

-- Dec 23, 2024, 12:19:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208643,'Cost Center',53281,216979,'Y','@$Element_CC@=Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-23 12:19:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-23 12:19:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7821c51b-fcd2-44b1-98f0-4fd91fe76742','Y',130,2)
;

-- Dec 23, 2024, 12:19:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208644,'Department',53281,216980,'Y','@$Element_DP@=Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-23 12:19:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-23 12:19:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dfd600a6-fa3c-474e-ac16-de6cb879836e','Y',140,2)
;

-- Dec 24, 2024, 3:32:16 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203965,0,0,'Y',TO_TIMESTAMP('2024-12-24 15:32:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 15:32:15','YYYY-MM-DD HH24:MI:SS'),100,'AnyCostCenter','Any Cost Center','Match any value of the Cost Center segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).','Any Cost Center','D','5703ed52-0001-48f7-8b87-b146ebf0ed76')
;

-- Dec 24, 2024, 3:32:47 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203966,0,0,'Y',TO_TIMESTAMP('2024-12-24 15:32:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 15:32:47','YYYY-MM-DD HH24:MI:SS'),100,'AnyDepartment','Any Department','Match any value of the Department segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).','Any Department','D','5250a71b-ad51-408e-b8ec-abeb59ac757b')
;

-- Dec 24, 2024, 3:33:22 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216981,0,'Any Department','Match any value of the Department segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',708,'AnyDepartment','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-24 15:33:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 15:33:22','YYYY-MM-DD HH24:MI:SS'),100,203966,'Y','N','D','N','N','N','Y','de0fd84e-c9b4-4041-bcf9-00827becba09','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 3:33:24 PM IST
ALTER TABLE GL_Distribution ADD AnyDepartment CHAR(1) DEFAULT 'Y' CHECK (AnyDepartment IN ('Y','N')) NOT NULL
;

-- Dec 24, 2024, 3:33:44 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216982,0,'Any Cost Center','Match any value of the Cost Center segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',708,'AnyCostCenter','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-24 15:33:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 15:33:44','YYYY-MM-DD HH24:MI:SS'),100,203965,'Y','N','D','N','Y','N','Y','70f340ee-e779-4c08-bd49-57c386b22879','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 3:33:47 PM IST
UPDATE AD_Column SET IsMandatory='Y', IsAlwaysUpdateable='N',Updated=TO_TIMESTAMP('2024-12-24 15:33:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216982
;

-- Dec 24, 2024, 3:33:48 PM IST
ALTER TABLE GL_Distribution ADD AnyCostCenter CHAR(1) DEFAULT 'Y' CHECK (AnyCostCenter IN ('Y','N')) NOT NULL
;

-- Dec 24, 2024, 3:39:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208645,'Any Department','Match any value of the Department segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',646,216981,'Y',1,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 15:39:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 15:39:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4c0c5415-587c-4687-8b0d-92cb73ec13b7','Y',440,2,2)
;

-- Dec 24, 2024, 3:39:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208646,'Any Cost Center','Match any value of the Cost Center segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',646,216982,'Y',1,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 15:39:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 15:39:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f214251b-81dd-4fc3-8030-e1b598bc81b9','Y',450,2,2)
;

-- Dec 24, 2024, 3:44:20 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=410, XPosition=4,Updated=TO_TIMESTAMP('2024-12-24 15:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208634
;

-- Dec 24, 2024, 3:44:20 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CC@=Y', SeqNo=420, XPosition=2,Updated=TO_TIMESTAMP('2024-12-24 15:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208646
;

-- Dec 24, 2024, 3:44:20 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CC@=Y & @AnyCostCenter@=N
', SeqNo=430, XPosition=4,Updated=TO_TIMESTAMP('2024-12-24 15:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208633
;

-- Dec 24, 2024, 3:44:20 PM IST
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2024-12-24 15:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10870
;

-- Dec 24, 2024, 3:44:20 PM IST
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2024-12-24 15:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10134
;

-- Dec 24, 2024, 3:44:20 PM IST
UPDATE AD_Field SET SeqNo=460,Updated=TO_TIMESTAMP('2024-12-24 15:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10140
;

-- Dec 24, 2024, 3:53:16 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_DP@=Y
', SeqNo=400,Updated=TO_TIMESTAMP('2024-12-24 15:53:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208645
;

-- Dec 24, 2024, 3:53:17 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_DP@=Y & @AnyDepartment@=N', SeqNo=410,Updated=TO_TIMESTAMP('2024-12-24 15:53:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208634
;
-- Dec 24, 2024, 5:02:01 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203967,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:02:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:02:00','YYYY-MM-DD HH24:MI:SS'),100,'AnyWarehouse','Any Warehouse','Match any value of the Warehouse segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).','Any Warehouse','D','f8fa66a2-db81-4bcb-a96c-3f95b7cc0440')
;

-- Dec 24, 2024, 5:02:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216984,0,'Any Warehouse','Match any value of the Warehouse segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',708,'AnyWarehouse','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:02:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:02:52','YYYY-MM-DD HH24:MI:SS'),100,203967,'Y','N','D','N','N','N','Y','8b89ca9b-7df6-492a-9932-2b8175446af5','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 5:02:57 PM IST
ALTER TABLE GL_Distribution ADD AnyWarehouse CHAR(1) DEFAULT 'Y' CHECK (AnyWarehouse IN ('Y','N')) NOT NULL
;

-- Dec 24, 2024, 5:03:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216985,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',708,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:03:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:03:43','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','N','N','N','Y','69b8c146-4391-4836-b404-f9141c970520','Y',0,'N','N','N','N','N')
;

-- Dec 24, 2024, 5:03:48 PM IST
UPDATE AD_Column SET FKConstraintName='MWarehouse_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-24 17:03:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216985
;

-- Dec 24, 2024, 5:03:48 PM IST
ALTER TABLE GL_Distribution ADD M_Warehouse_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 24, 2024, 5:03:48 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT MWarehouse_GLDistribution FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 24, 2024, 5:04:52 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203968,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:04:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:04:50','YYYY-MM-DD HH24:MI:SS'),100,'AnyAsset','Any Asset','Match any value of the Asset segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).','Any Asset','D','448d8a29-3bdb-455c-98a8-a17cd4cacd98')
;

-- Dec 24, 2024, 5:05:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216986,0,'Any Asset','Match any value of the Asset segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',708,'AnyAsset','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:05:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:05:06','YYYY-MM-DD HH24:MI:SS'),100,203968,'Y','N','D','N','N','N','Y','ae38fcc6-f8b8-403a-bb5a-9573795f3ddc','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 5:05:07 PM IST
ALTER TABLE GL_Distribution ADD AnyAsset CHAR(1) DEFAULT 'Y' CHECK (AnyAsset IN ('Y','N')) NOT NULL
;

-- Dec 24, 2024, 5:05:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216987,0,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',708,'A_Asset_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:05:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:05:25','YYYY-MM-DD HH24:MI:SS'),100,1884,'Y','N','D','N','N','N','Y','7fb9b7a5-beb8-46b5-aa17-507a24ecd442','Y',0,'N','N','N','N','N')
;

-- Dec 24, 2024, 5:05:41 PM IST
UPDATE AD_Column SET FKConstraintName='AAsset_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-24 17:05:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216987
;

-- Dec 24, 2024, 5:05:41 PM IST
ALTER TABLE GL_Distribution ADD A_Asset_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 24, 2024, 5:05:41 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT AAsset_GLDistribution FOREIGN KEY (A_Asset_ID) REFERENCES a_asset(a_asset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 24, 2024, 5:41:22 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203969,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:41:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:41:18','YYYY-MM-DD HH24:MI:SS'),100,'AnyCharge','Any Charge','Match any value of the Charge segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).','Any Charge','D','b89b5fa6-572d-46b3-a8a6-81c5f53f2859')
;

-- Dec 24, 2024, 5:41:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216988,0,'Any Charge','Match any value of the Charge segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',708,'AnyCharge','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:41:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:41:37','YYYY-MM-DD HH24:MI:SS'),100,203969,'Y','N','D','N','N','N','Y','2122acd3-654c-4a11-8ef2-0016de648f17','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 5:41:39 PM IST
ALTER TABLE GL_Distribution ADD AnyCharge CHAR(1) DEFAULT 'Y' CHECK (AnyCharge IN ('Y','N')) NOT NULL
;

-- Dec 24, 2024, 5:46:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216989,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',708,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-24 17:46:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 17:46:40','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','N','N','N','Y','60f5422b-a900-4af4-b12a-8e972b408787','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 5:46:45 PM IST
UPDATE AD_Column SET FKConstraintName='CCharge_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-24 17:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216989
;

-- Dec 24, 2024, 5:46:45 PM IST
ALTER TABLE GL_Distribution ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 24, 2024, 5:46:45 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT CCharge_GLDistribution FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 24, 2024, 6:05:07 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203970,0,0,'Y',TO_TIMESTAMP('2024-12-24 18:05:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:05:06','YYYY-MM-DD HH24:MI:SS'),100,'AnyEmployee','Any Employee','Match any value of the Employee segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).','Any Employee','D','e5c12c58-d55c-4f64-9f32-e3252c0fe853')
;

-- Dec 24, 2024, 6:05:21 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216990,0,'Any Employee','Match any value of the Employee segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',708,'AnyEmployee','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-24 18:05:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:05:21','YYYY-MM-DD HH24:MI:SS'),100,203970,'Y','N','D','N','N','N','Y','ae3d3f78-70d2-4ef5-b5de-be5ca57c234f','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 6:05:26 PM IST
ALTER TABLE GL_Distribution ADD AnyEmployee CHAR(1) DEFAULT 'Y' CHECK (AnyEmployee IN ('Y','N')) NOT NULL
;

-- Dec 24, 2024, 6:05:54 PM IST
ALTER TABLE GL_Distribution MODIFY AnyEmployee CHAR(1) DEFAULT 'Y'
;

-- Dec 24, 2024, 6:05:54 PM IST
UPDATE GL_Distribution SET AnyEmployee='Y' WHERE AnyEmployee IS NULL
;

-- Dec 24, 2024, 6:06:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216991,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',708,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2024-12-24 18:06:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:06:25','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','N','N','N','Y','145f9608-4172-429c-846e-ce49f7b4ad06','Y',0,'N','N','N','N','N')
;

-- Dec 24, 2024, 6:06:30 PM IST
UPDATE AD_Column SET FKConstraintName='CEmployee_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-24 18:06:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216991
;

-- Dec 24, 2024, 6:06:30 PM IST
ALTER TABLE GL_Distribution ADD C_Employee_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 24, 2024, 6:06:30 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT CEmployee_GLDistribution FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 24, 2024, 6:08:32 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203971,0,0,'Y',TO_TIMESTAMP('2024-12-24 18:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:08:31','YYYY-MM-DD HH24:MI:SS'),100,'AnyAttributeSetInstance','Any Attribute Set Instance','Match any value of the Employee segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).','Any Attribute Set Instance','D','3c5ca20e-0365-456e-a808-820a64bbf323')
;

-- Dec 24, 2024, 6:08:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216992,0,'Any Attribute Set Instance','Match any value of the Employee segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',708,'AnyAttributeSetInstance','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-24 18:08:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:08:50','YYYY-MM-DD HH24:MI:SS'),100,203971,'Y','N','D','N','N','N','Y','8fd621c7-827b-438f-8473-3845cfc00349','Y',0,'N','N','N','N')
;

-- Dec 24, 2024, 6:08:53 PM IST
ALTER TABLE GL_Distribution ADD AnyAttributeSetInstance CHAR(1) DEFAULT 'Y' CHECK (AnyAttributeSetInstance IN ('Y','N')) NOT NULL
;

-- Dec 24, 2024, 6:09:47 PM IST
ALTER TABLE GL_Distribution MODIFY AnyAttributeSetInstance CHAR(1) DEFAULT 'Y'
;

-- Dec 24, 2024, 6:09:47 PM IST
UPDATE GL_Distribution SET AnyAttributeSetInstance='Y' WHERE AnyAttributeSetInstance IS NULL
;

-- Dec 24, 2024, 6:11:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216993,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',708,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-24 18:11:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:11:11','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','6028e0c4-4bab-4c8b-9aae-9d1005af0c04','Y',0,'N','N','N','N','N')
;

-- Dec 24, 2024, 6:11:17 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-24 18:11:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216993
;

-- Dec 24, 2024, 6:11:17 PM IST
ALTER TABLE GL_Distribution ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 24, 2024, 6:11:17 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT MAttributeSetInstance_GLDistribution FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 24, 2024, 6:12:05 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208647,'Any Warehouse','Match any value of the Warehouse segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',646,216984,'Y',1,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','11d873ee-88a4-4c28-a6d6-11bde92c4f85','Y',460,2,2)
;

-- Dec 24, 2024, 6:12:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208648,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',646,216985,'Y','@$Element_WH@=Y',22,480,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b98620ce-ad11-4c65-bf88-b79e2dcad319','Y',470,2)
;

-- Dec 24, 2024, 6:12:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208649,'Any Asset','Match any value of the Asset segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',646,216986,'Y',1,490,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2d20a0c1-cf2e-4a8b-8072-526818e7e7f3','Y',480,2,2)
;

-- Dec 24, 2024, 6:12:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208650,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',646,216987,'Y','@$Element_AS@=Y',22,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','950a0a3f-f8d7-4ec7-be91-17019b33f5af','Y',490,2)
;

-- Dec 24, 2024, 6:12:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208651,'Any Charge','Match any value of the Charge segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',646,216988,'Y',1,510,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','751b1c87-2f57-478e-8a8a-85b876bf9d50','Y',500,2,2)
;

-- Dec 24, 2024, 6:12:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208652,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',646,216989,'Y',10,520,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f0dec1a6-b185-4087-b90f-0c9f093dfdf9','Y',510,2)
;

-- Dec 24, 2024, 6:12:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208653,'Any Employee','Match any value of the Employee segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',646,216990,'Y',1,530,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e429c5c4-d919-4046-b6e7-73662945e684','Y',520,2,2)
;

-- Dec 24, 2024, 6:12:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208654,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',646,216991,'Y','@$Element_EP@=Y',10,540,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a0caf0d8-8c10-4214-8d21-0aa1526f7148','Y',530,2)
;

-- Dec 24, 2024, 6:12:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208655,'Any Attribute Set Instance','Match any value of the Employee segment','If selected, any value of the account segment will match. If not selected, but no value of the accounting segment is selected, the matched value must be null (i.e. not defined).',646,216992,'Y',1,550,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','db222c73-1333-46f3-85ae-0eb673534966','Y',540,2,2)
;

-- Dec 24, 2024, 6:12:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208656,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',646,216993,'Y','@$Element_AI@=Y',22,560,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-24 18:12:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-24 18:12:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','91c8f826-8d17-4502-b669-5b67dda2d100','Y',550,2)
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_WH@=Y ', SeqNo=420, XPosition=2,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208647
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_WH@=Y & @AnyWarehouse@=N', SeqNo=430, XPosition=4,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208648
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_AS@=Y', SeqNo=440, XPosition=2,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208649
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_AS@=Y & @AnyAsset@=N', SeqNo=450, XPosition=4,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208650
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CH@=Y', SeqNo=460, XPosition=2,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208651
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CH@=Y & @AnyCharge@=N', SeqNo=470, XPosition=4,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208652
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_EP@=Y', SeqNo=480, XPosition=2,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208653
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_EP@=Y & @AnyEmployee@=N', SeqNo=490, XPosition=4,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208654
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_AI@=Y', SeqNo=500, XPosition=2,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208655
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_AI@=Y & @AnyAttributeSetInstance@=N', SeqNo=510, XPosition=4,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208656
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208646
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET SeqNo=530,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208633
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET SeqNo=540,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10870
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET SeqNo=550,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10134
;

-- Dec 24, 2024, 6:23:00 PM IST
UPDATE AD_Field SET SeqNo=560,Updated=TO_TIMESTAMP('2024-12-24 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10140
;


-- Dec 24, 2024, 6:54:19 PM IST
ALTER TABLE GL_Distribution MODIFY AnyAttributeSetInstance CHAR(1) DEFAULT 'Y'
;

-- Dec 24, 2024, 6:54:19 PM IST
UPDATE GL_Distribution SET AnyAttributeSetInstance='Y' WHERE AnyAttributeSetInstance IS NULL
;

-- Dec 26, 2024, 12:10:39 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203972,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:10:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:10:34','YYYY-MM-DD HH24:MI:SS'),100,'OverwriteAsset','Overwrite Asset','Overwrite the account segment Asset with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.','Overwrite Asset','D','336fdf3a-5da4-4ac9-9fcb-c0e2ff8183b4')
;

-- Dec 26, 2024, 12:11:39 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203973,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:11:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:11:36','YYYY-MM-DD HH24:MI:SS'),100,'OverwriteAttributeSetInstance','Overwrite Attribute Set Instance','Overwrite the account segment Attribute Set Instance with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.','Overwrite Attribute Set Instance','D','e9bbc924-6d5f-46e3-a6c3-84c68c7b297e')
;

-- Dec 26, 2024, 12:12:45 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203974,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:12:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:12:43','YYYY-MM-DD HH24:MI:SS'),100,'OverwriteCharge','Overwrite Charge','Overwrite the account segment Charge with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.','Overwrite Charge','D','e84b9a32-f242-4f91-8201-736acdee878f')
;

-- Dec 26, 2024, 12:13:01 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203975,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:13:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:13:01','YYYY-MM-DD HH24:MI:SS'),100,'OverwriteCostCenter','Overwrite Cost Center','Overwrite the account segment Cost Center with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.','Overwrite Cost Center','D','01595739-83ad-4542-83b7-e665ee87fa10')
;

-- Dec 26, 2024, 12:13:25 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203976,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:13:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:13:22','YYYY-MM-DD HH24:MI:SS'),100,'OverwriteDepartment','Overwrite Department','Overwrite the account segment Department with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.','Overwrite Department','D','6ca202db-876d-4848-81a8-08ccc7e63217')
;

-- Dec 26, 2024, 12:14:02 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203977,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:13:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:13:58','YYYY-MM-DD HH24:MI:SS'),100,'OverwriteEmployee','Overwrite Employee','Overwrite the account segment Employee with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.','Overwrite Employee','D','edc85363-0f1f-4d46-a592-fc29e12afa3e')
;

-- Dec 26, 2024, 12:14:26 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203978,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:14:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:14:25','YYYY-MM-DD HH24:MI:SS'),100,'OverwriteWarehouse','Overwrite Warehouse','Overwrite the account segment Warehouse with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.','Overwrite Warehouse','D','cd82578c-48cd-45c8-b100-ffe3a18118ec')
;

-- Dec 26, 2024, 12:18:28 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216994,0,'Overwrite Asset','Overwrite the account segment Asset with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',707,'OverwriteAsset','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:18:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:18:24','YYYY-MM-DD HH24:MI:SS'),100,203972,'Y','N','D','N','N','N','Y','5aab5bf8-1e2c-4679-8022-5bb57ceab52d','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:18:31 PM IST
ALTER TABLE GL_DistributionLine ADD OverwriteAsset CHAR(1) DEFAULT 'N' CHECK (OverwriteAsset IN ('Y','N')) NOT NULL
;

-- Dec 26, 2024, 12:18:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216995,0,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',707,'A_Asset_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:18:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:18:49','YYYY-MM-DD HH24:MI:SS'),100,1884,'Y','N','D','N','N','N','Y','3c731af6-29b8-447e-8c55-977d1a1a02fd','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 12:18:50 PM IST
UPDATE AD_Column SET FKConstraintName='AAsset_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 12:18:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216995
;

-- Dec 26, 2024, 12:18:50 PM IST
ALTER TABLE GL_DistributionLine ADD A_Asset_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 12:18:50 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT AAsset_GLDistributionLine FOREIGN KEY (A_Asset_ID) REFERENCES a_asset(a_asset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 12:19:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216996,0,'Overwrite Attribute Set Instance','Overwrite the account segment Attribute Set Instance with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',707,'OverwriteAttributeSetInstance','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:19:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:19:41','YYYY-MM-DD HH24:MI:SS'),100,203973,'Y','N','D','N','N','N','Y','65b00e8a-a772-466e-a98b-0aef2c74401f','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:19:46 PM IST
ALTER TABLE GL_DistributionLine ADD OverwriteAttributeSetInstance CHAR(1) DEFAULT 'N' CHECK (OverwriteAttributeSetInstance IN ('Y','N')) NOT NULL
;

-- Dec 26, 2024, 12:20:07 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216997,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',707,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:20:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:20:06','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','df6bd3a3-0f4c-45be-90ed-11e362bd9ca6','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 12:20:08 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 12:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216997
;

-- Dec 26, 2024, 12:20:08 PM IST
ALTER TABLE GL_DistributionLine ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 12:20:08 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT MAttributeSetInstance_GLDistributionLine FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 12:25:00 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216998,0,'Overwrite Charge','Overwrite the account segment Charge with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',707,'OverwriteCharge','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:24:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:24:56','YYYY-MM-DD HH24:MI:SS'),100,203974,'Y','N','D','N','N','N','Y','33831124-2890-49b7-9971-09872a6d0405','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:25:02 PM IST
ALTER TABLE GL_DistributionLine ADD OverwriteCharge CHAR(1) DEFAULT 'N' CHECK (OverwriteCharge IN ('Y','N')) NOT NULL
;

-- Dec 26, 2024, 12:28:03 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216999,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',707,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','N','N','Y','55373177-d80e-4e40-838c-fa783ca37ddc','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:28:09 PM IST
UPDATE AD_Column SET FKConstraintName='CCharge_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 12:28:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216999
;

-- Dec 26, 2024, 12:28:09 PM IST
ALTER TABLE GL_DistributionLine ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 12:28:09 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT CCharge_GLDistributionLine FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 12:28:27 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217000,0,'Overwrite Cost Center','Overwrite the account segment Cost Center with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',707,'OverwriteCostCenter','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,203975,'Y','N','D','N','N','N','Y','ed8ab96b-a7c3-43bd-8c06-d235801af7ec','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:28:28 PM IST
ALTER TABLE GL_DistributionLine ADD OverwriteCostCenter CHAR(1) DEFAULT 'N' CHECK (OverwriteCostCenter IN ('Y','N')) NOT NULL
;

-- Dec 26, 2024, 12:29:19 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217001,0,'Overwrite Department','Overwrite the account segment Department with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',707,'OverwriteDepartment','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:29:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:29:16','YYYY-MM-DD HH24:MI:SS'),100,203976,'Y','N','D','N','N','N','Y','35945156-f9e7-4d9e-9013-fc80c4893e14','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:29:21 PM IST
ALTER TABLE GL_DistributionLine ADD OverwriteDepartment CHAR(1) DEFAULT 'N' CHECK (OverwriteDepartment IN ('Y','N')) NOT NULL
;

-- Dec 26, 2024, 12:39:14 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217002,0,'Overwrite Employee','Overwrite the account segment Employee with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',707,'OverwriteEmployee','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:39:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:39:10','YYYY-MM-DD HH24:MI:SS'),100,203977,'Y','N','D','N','N','N','Y','a96de8d5-bc71-45ed-9978-eb856965a0e8','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:39:16 PM IST
ALTER TABLE GL_DistributionLine ADD OverwriteEmployee CHAR(1) DEFAULT 'N' CHECK (OverwriteEmployee IN ('Y','N')) NOT NULL
;

-- Dec 26, 2024, 12:39:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217003,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',707,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:39:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:39:37','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','N','N','N','Y','1f005e7f-6072-45db-a3bb-e6258f352db5','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 12:39:38 PM IST
UPDATE AD_Column SET FKConstraintName='CEmployee_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 12:39:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217003
;

-- Dec 26, 2024, 12:39:38 PM IST
ALTER TABLE GL_DistributionLine ADD C_Employee_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 12:39:38 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT CEmployee_GLDistributionLine FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 12:40:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217004,0,'Overwrite Warehouse','Overwrite the account segment Warehouse with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',707,'OverwriteWarehouse','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:40:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:40:00','YYYY-MM-DD HH24:MI:SS'),100,203978,'Y','N','D','N','N','N','Y','badfcec9-5888-4461-a6ee-4cad0b568d1d','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 12:40:07 PM IST
ALTER TABLE GL_DistributionLine ADD OverwriteWarehouse CHAR(1) DEFAULT 'N' CHECK (OverwriteWarehouse IN ('Y','N')) NOT NULL
;

-- Dec 26, 2024, 12:40:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217005,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',707,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-26 12:40:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 12:40:19','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','N','N','N','Y','88b5e7aa-d88a-4f3c-a85b-b693fa5646bc','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 12:40:21 PM IST
UPDATE AD_Column SET FKConstraintName='MWarehouse_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 12:40:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217005
;

-- Dec 26, 2024, 12:40:21 PM IST
ALTER TABLE GL_DistributionLine ADD M_Warehouse_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 12:40:21 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT MWarehouse_GLDistributionLine FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 1:53:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208657,'Overwrite Asset','Overwrite the account segment Asset with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',647,216994,'Y',1,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cf39467c-1eba-4bf9-9525-dd87dad350a2','Y',360,2,2)
;

-- Dec 26, 2024, 1:53:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208658,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',647,216995,'Y','@$Element_AS@=Y',22,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a6362029-b085-4b21-b454-6eb1a79d1434','Y',370,2)
;

-- Dec 26, 2024, 1:53:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208659,'Overwrite Attribute Set Instance','Overwrite the account segment Attribute Set Instance with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',647,216996,'Y',1,380,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e7b4d86d-a0ce-48a7-b1dd-0e94f540aeb2','Y',380,2,2)
;

-- Dec 26, 2024, 1:53:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208660,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',647,216997,'Y','@$Element_AI@=Y',22,390,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','185bf0f6-24f2-4103-83c0-457d47a4d265','Y',390,2)
;

-- Dec 26, 2024, 1:53:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208661,'Overwrite Charge','Overwrite the account segment Charge with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',647,216998,'Y',1,400,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','983a2e8e-4846-4c2b-a5eb-ab05f0e4bbf1','Y',400,2,2)
;

-- Dec 26, 2024, 1:53:39 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208662,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',647,216999,'Y',10,410,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','28d71cd4-2820-40f9-b05e-2891787ef029','Y',410,2)
;

-- Dec 26, 2024, 1:53:39 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208663,'Overwrite Cost Center','Overwrite the account segment Cost Center with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',647,217000,'Y',1,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b77af5b2-b2ef-4add-88e4-93e6a04eb50d','Y',420,2,2)
;

-- Dec 26, 2024, 1:53:40 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208664,'Overwrite Department','Overwrite the account segment Department with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',647,217001,'Y',1,430,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9d384308-e424-45b4-8d77-01f932941a26','Y',430,2,2)
;

-- Dec 26, 2024, 1:53:41 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208665,'Overwrite Employee','Overwrite the account segment Employee with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',647,217002,'Y',1,440,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1247d742-25ee-4af4-bd6b-9f3e638cc033','Y',440,2,2)
;

-- Dec 26, 2024, 1:53:41 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208666,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',647,217003,'Y','@$Element_EP@=Y',10,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1f61a6d1-c614-46fa-be60-0889362d09b8','Y',450,2)
;

-- Dec 26, 2024, 1:53:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208667,'Overwrite Warehouse','Overwrite the account segment Warehouse with the value specified','If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.',647,217004,'Y',1,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','721b648a-84b8-44d6-b0bc-a20a89d67cb2','Y',460,2,2)
;

-- Dec 26, 2024, 1:53:43 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208668,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',647,217005,'Y','@$Element_WH@=Y',22,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 13:53:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:53:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d943f90c-447b-4e50-8c1b-c692b8acc7eb','Y',470,2)
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CC@=Y', SeqNo=340, XPosition=2,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208663
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CC@=Y & @OverwriteCostCenter@=Y', SeqNo=350, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208635
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_DP@=Y', SeqNo=360, XPosition=2,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208664
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_DP@=Y & @OverwriteDepartment@=Y', SeqNo=370, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208636
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_AS@=Y', SeqNo=380,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208657
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_AS@=Y & @OverwriteAsset@=Y', SeqNo=390, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208658
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_AI@=Y', SeqNo=400,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208659
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_AI@=Y & @OverwriteAttributeSetInstance@=Y', SeqNo=410, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208660
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_CH@=Y', SeqNo=420,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208661
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CH@=Y & @OverwriteCharge@=Y', SeqNo=430, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208662
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_EP@=Y', SeqNo=440,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208665
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_EP@=Y & @OverwriteEmployee@=Y', SeqNo=450, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208666
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_WH@=Y', SeqNo=460,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208667
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_WH@=Y & @OverwriteWarehouse@=Y', SeqNo=470, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208668
;

-- Dec 26, 2024, 2:01:43 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-12-26 14:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204841
;

-- Dec 26, 2024, 3:24:21 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217006,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',226,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-26 15:24:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:24:19','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','N','N','N','Y','bcf440e2-c1bb-4b06-b7ee-9b46a8a72ebb','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 3:24:23 PM IST
UPDATE AD_Column SET FKConstraintName='CCharge_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 15:24:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217006
;

-- Dec 26, 2024, 3:24:23 PM IST
ALTER TABLE GL_JournalLine ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 3:24:23 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT CCharge_GLJournalLine FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 3:24:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217008,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',226,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-26 15:24:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:24:55','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','N','N','N','Y','b1759ab2-368f-4164-82f7-3cb8dfb7d363','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 3:24:59 PM IST
UPDATE AD_Column SET FKConstraintName='MWarehouse_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 15:24:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217008
;

-- Dec 26, 2024, 3:24:59 PM IST
ALTER TABLE GL_JournalLine ADD M_Warehouse_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 3:24:59 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT MWarehouse_GLJournalLine FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 3:25:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217009,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',226,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2024-12-26 15:25:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:25:11','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','N','N','N','Y','d36dac8e-2e25-4d1f-b3af-d25955b6687a','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 3:25:12 PM IST
UPDATE AD_Column SET FKConstraintName='CEmployee_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 15:25:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217009
;

-- Dec 26, 2024, 3:25:12 PM IST
ALTER TABLE GL_JournalLine ADD C_Employee_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 3:25:12 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT CEmployee_GLJournalLine FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 3:25:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217010,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',226,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-26 15:25:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:25:32','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','88e4acdf-3ac1-4339-9a30-07027f02faba','Y',0,'N','N','N','N','N')
;

-- Dec 26, 2024, 3:25:37 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 15:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217010
;

-- Dec 26, 2024, 3:25:37 PM IST
ALTER TABLE GL_JournalLine ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 3:25:37 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT MAttributeSetInstance_GLJournalLine FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 3:25:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208669,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200008,217006,'Y',10,400,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:25:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:25:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bb4b0e63-f24d-4e95-bd35-77fdb57141ba','Y',400,2)
;

-- Dec 26, 2024, 3:25:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208670,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200008,217008,'Y','@$Element_WH@=Y',22,410,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:25:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:25:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','57c8739b-269c-446a-bc03-8673c6fb741d','Y',410,2)
;

-- Dec 26, 2024, 3:26:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208671,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200008,217009,'Y','@$Element_EP@=Y',10,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:25:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:25:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d573c852-1906-42fd-9fd8-a242640ad02a','Y',420,2)
;

-- Dec 26, 2024, 3:26:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208672,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200008,217010,'Y','@$Element_AI@=Y',22,430,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:26:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:26:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a2760ed-87e4-4a82-9985-62e6875f0083','Y',430,2)
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200236
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200237
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208639
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208640
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CH@=Y', SeqNo=260, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208669
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208670
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208671
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=290, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208672
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200238
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200239
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200240
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200241
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200242
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200243
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200244
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200245
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200246
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200247
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200248
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200249
;

-- Dec 26, 2024, 3:30:22 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-12-26 15:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204848
;

-- Dec 26, 2024, 3:30:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217011,0,'Tax','Tax identifier','The Tax indicates the type of tax used in document line.',226,'C_Tax_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-26 15:30:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:30:33','YYYY-MM-DD HH24:MI:SS'),100,213,'Y','N','D','N','N','N','Y','d8043f0d-fce6-4a5d-acf8-2687a43087e4','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 3:30:38 PM IST
UPDATE AD_Column SET FKConstraintName='CTax_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 15:30:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217011
;

-- Dec 26, 2024, 3:30:38 PM IST
ALTER TABLE GL_JournalLine ADD C_Tax_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 26, 2024, 3:30:38 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT CTax_GLJournalLine FOREIGN KEY (C_Tax_ID) REFERENCES c_tax(c_tax_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 3:30:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208673,'Tax','Tax identifier','The Tax indicates the type of tax used in document line.',200008,217011,'Y',22,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:30:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:30:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c08b3b42-318e-4ea2-9b4b-593937839b53','Y',440,2)
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208673
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200238
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200239
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200240
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200241
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200242
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200243
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200244
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200245
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200246
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200247
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200248
;

-- Dec 26, 2024, 3:31:08 PM IST
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2024-12-26 15:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200249
;

-- Dec 26, 2024, 3:31:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208674,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',161,217006,'Y',10,400,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:31:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:31:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','23f8eda9-d5cf-4b32-bf4b-5032c16faae2','Y',400,2)
;

-- Dec 26, 2024, 3:31:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208675,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',161,217008,'Y','@$Element_WH@=Y',22,410,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:31:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:31:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b19b58a8-3d1f-4c9e-a1e3-1c2cebfaabe8','Y',410,2)
;

-- Dec 26, 2024, 3:31:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208676,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',161,217009,'Y','@$Element_EP@=Y',10,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:31:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:31:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15cd4564-8348-40ec-b8a6-21622a182c77','Y',420,2)
;

-- Dec 26, 2024, 3:31:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208677,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',161,217010,'Y','@$Element_AI@=Y',22,430,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:31:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:31:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','140f9122-6527-4d03-8a41-d3da49ebabac','Y',430,2)
;

-- Dec 26, 2024, 3:31:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208678,'Tax','Tax identifier','The Tax indicates the type of tax used in document line.',161,217011,'Y',22,440,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 15:31:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 15:31:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2ede098a-77e5-4ffe-acf6-f1fa10a2c4bf','Y',440,2)
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200180
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200181
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208637
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208638
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_CH@=Y', SeqNo=260, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208674
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208677
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208676
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=290, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208675
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208678
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200168
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=895
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4724
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56249
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56250
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56251
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=728
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=729
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=730
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=731
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1294
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1295
;

-- Dec 26, 2024, 3:33:04 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-12-26 15:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204849
;


-- Dec 26, 2024, 4:38:48 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200494,0,0,'Y',TO_TIMESTAMP('2024-12-26 16:38:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 16:38:44','YYYY-MM-DD HH24:MI:SS'),100,'Tax','Tax identifier','The Tax indicates the type of tax used in document line.',204,230,200162,158,'N',0,'N','-1','C_Tax_ID','Y','D',213,'800e7214-566c-4e24-91bf-52e39d2e0964','N','N','D','N')
;

-- Dec 26, 2024, 4:48:29 PM IST
UPDATE AD_Process_Para SET DefaultValue=NULL,Updated=TO_TIMESTAMP('2024-12-26 16:48:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200494
;

-- Jan 22, 2025, 2:29:04 PM IST
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,FieldGroupType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200032,0,0,'Y',TO_TIMESTAMP('2025-01-22 14:29:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-22 14:29:00','YYYY-MM-DD HH24:MI:SS'),100,'Additional Dimensions','D','C','N','c5e2ebb1-5a09-419c-820b-66f473a37ed8')
;

-- Jan 22, 2025, 2:29:59 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:29:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208669
;

-- Jan 22, 2025, 2:30:01 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:30:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208670
;

-- Jan 22, 2025, 2:30:04 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:30:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208671
;

-- Jan 22, 2025, 2:30:06 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:30:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208672
;

-- Jan 22, 2025, 2:30:08 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:30:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208673
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200238
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=4,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200239
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET SeqNo=260, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208639
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET SeqNo=270, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208640
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208669
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208670
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208671
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208672
;

-- Jan 22, 2025, 2:31:49 PM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2025-01-22 14:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208673
;

-- Jan 22, 2025, 2:32:20 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208674
;

-- Jan 22, 2025, 2:32:23 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:32:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208677
;

-- Jan 22, 2025, 2:32:25 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:32:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208676
;

-- Jan 22, 2025, 2:32:27 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:32:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208675
;

-- Jan 22, 2025, 2:32:30 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:32:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208678
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200168
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=4,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=895
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET SeqNo=260, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208637
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET SeqNo=270, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208638
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208674
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208677
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208676
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208675
;

-- Jan 22, 2025, 2:33:06 PM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2025-01-22 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208678
;

-- Feb 17, 2025, 11:46:08 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217041,0,'Custom FieldText 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText1',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:46:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:46:07','YYYY-MM-DD HH24:MI:SS'),100,203894,'Y','N','D','N','N','N','Y','21808c30-4093-420a-a6ad-4fa98046444f','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:46:10 AM IST
ALTER TABLE T_Fact_Acct_History ADD CustomFieldText1 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Feb 17, 2025, 11:46:18 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217042,0,'Text Column 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText2',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:46:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:46:18','YYYY-MM-DD HH24:MI:SS'),100,203895,'Y','N','D','N','N','N','Y','6d88b10c-6a3f-4b83-a7f4-0842c19daa9b','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:46:20 AM IST
ALTER TABLE T_Fact_Acct_History ADD CustomFieldText2 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:34 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217034,0,'Text Column 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText3',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:44:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:44:33','YYYY-MM-DD HH24:MI:SS'),100,203896,'Y','N','D','N','N','N','Y','bd6cb537-fdec-44e8-b2a2-83c386198a8c','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:44:36 AM IST
ALTER TABLE T_Fact_Acct_History ADD CustomFieldText3 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:57 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217040,0,'Text Column 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText4',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:56','YYYY-MM-DD HH24:MI:SS'),100,203897,'Y','N','D','N','N','N','Y','c95447de-8006-44c3-a270-98689358403e','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:59 AM IST
ALTER TABLE T_Fact_Acct_History ADD CustomFieldText4 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:46 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217035,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200420,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:44:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:44:46','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','N','N','N','Y','f7cf511f-4b14-408f-b9ac-eb2d909ef94b','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:44:50 AM IST
UPDATE AD_Column SET FKConstraintName='CCharge_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217035
;

-- Feb 17, 2025, 11:44:50 AM IST
ALTER TABLE T_Fact_Acct_History ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:50 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CCharge_TFactAcctHistory FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:15 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217037,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200420,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:15','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','N','N','N','Y','5871e09b-0dd7-4bd1-ab29-5bcd48100177','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:18 AM IST
UPDATE AD_Column SET FKConstraintName='MWarehouse_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217037
;

-- Feb 17, 2025, 11:45:18 AM IST
ALTER TABLE T_Fact_Acct_History ADD M_Warehouse_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:18 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT MWarehouse_TFactAcctHistory FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:41 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217039,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200420,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:40','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','N','N','N','Y','386cacb5-ec16-4f81-ac00-20a893e95f26','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:43 AM IST
UPDATE AD_Column SET FKConstraintName='CEmployee_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217039
;

-- Feb 17, 2025, 11:45:43 AM IST
ALTER TABLE T_Fact_Acct_History ADD C_Employee_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:43 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CEmployee_TFactAcctHistory FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:28 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217038,0,'Department',200420,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:27','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','443830dc-dab8-4fd6-aa3e-6d69c8a5d12c','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:30 AM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217038
;

-- Feb 17, 2025, 11:45:30 AM IST
ALTER TABLE T_Fact_Acct_History ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:30 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CDepartment_TFactAcctHistory FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:44:05 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217033,0,'Cost Center',200420,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:44:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:44:04','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','15e2f7e3-74ed-49c1-85ea-6eb8203678f4','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:44:08 AM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:44:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217033
;

-- Feb 17, 2025, 11:44:08 AM IST
ALTER TABLE T_Fact_Acct_History ADD C_CostCenter_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:08 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CCostCenter_TFactAcctHistory FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:01 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217036,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200420,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',35,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:01','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','dd26f228-fd33-40a8-951f-eed7b78b5839','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:03 AM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217036
;

-- Feb 17, 2025, 11:45:03 AM IST
ALTER TABLE T_Fact_Acct_History ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:03 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT MAttributeSetInstance_TFactAcctHistory FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 2:45:06 PM IST
UPDATE AD_Process_Para SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2025-02-17 14:45:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200494
;


-- Feb 17, 2025, 3:04:02 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208694,'Project Phase','Phase of a Project',242,15465,'Y',10,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4d71ce65-2703-4cb7-a792-c4758a624407','Y',440,2)
;

-- Feb 17, 2025, 3:04:02 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208695,'Project Task','Actual Project Task in a Phase','A Project Task in a Project Phase represents the actual work.',242,15466,'Y',10,480,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e88487ce-9443-4cc7-acf4-b0f6860b4e59','Y',450,2)
;

-- Feb 17, 2025, 3:04:03 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208696,'Text Column 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',242,216321,'Y',255,490,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6349443d-2852-4a89-ba5d-a1e7993c3123','Y',460,5,3)
;

-- Feb 17, 2025, 3:04:04 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208697,'Text Column 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',242,216322,'Y',255,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bbc99865-dd7e-4867-8c69-c134b0c00878','Y',470,5,3)
;

-- Feb 17, 2025, 3:04:05 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208698,'Text Column 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',242,216323,'Y',255,510,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f26040db-ff1d-4349-b57f-b72b7c00de5d','Y',480,5,3)
;

-- Feb 17, 2025, 3:04:05 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208699,'Text Column 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',242,216324,'Y',255,520,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c00b2a84-8d54-41df-8e5a-ab0233141bcd','Y',490,5,3)
;

-- Feb 17, 2025, 3:04:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208700,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',242,216334,'Y',10,530,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d477c8c7-7866-4684-bf4d-7c30e206e5ab','Y',500,2)
;

-- Feb 17, 2025, 3:04:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208701,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',242,216335,'Y',22,540,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','86a996a5-2ca4-40fb-b8ef-e21dfe6a360f','Y',510,2)
;

-- Feb 17, 2025, 3:04:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208702,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',242,216336,'Y',10,550,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d9f52feb-1576-4970-bcbb-646257321cbb','Y',520,2)
;

-- Feb 17, 2025, 3:04:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208703,'Department',242,216384,'Y','@$Element_DP@=Y',22,560,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f8832ee9-36eb-4345-a5c3-bc1a0dc4fe30','Y',530,2)
;

-- Feb 17, 2025, 3:04:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208704,'Cost Center',242,216385,'Y','@$Element_CC@=Y',22,570,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-17 15:04:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 15:04:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','53ebb204-1dca-4288-a8b2-461f72ab06e9','Y',540,2)
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208484
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3891
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5141
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2352
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2350
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2349
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2348
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2347
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2358
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2365
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208694
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208695
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F1@=Y', SeqNo=400, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208696
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F2@=Y', SeqNo=410, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208697
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F3@=Y', SeqNo=420, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208698
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_F4@=Y', SeqNo=430, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208699
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_CH@=Y', SeqNo=440, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208700
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@$Element_EP@=Y', SeqNo=450, AD_FieldGroup_ID=200032, XPosition=4,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208702
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_WH@=Y', SeqNo=460,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208701
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=470, AD_FieldGroup_ID=200032, XPosition=4,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208703
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=480, AD_FieldGroup_ID=200032,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208704
;

-- Feb 17, 2025, 3:10:48 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-02-17 15:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204836
;

