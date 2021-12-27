SET SQLBLANKLINES ON
SET DEFINE OFF
-- IDEMPIERE-4863 Enable save column width in WListBox
-- Jul 3, 2021, 11:06:24 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200279,'Customization of the Wlistbox','AD_Wlistbox_Customization',0,'4',0,0,'Y',TO_DATE('2021-07-03 23:06:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:06:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','ecb85e34-2b9f-4265-9dbd-5c4ae7a83641','N','N','N','N')
;

-- Jul 3, 2021, 11:06:24 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Wlistbox_Customization',1000000,'N','N','Table AD_Wlistbox_Customization','Y','Y',0,0,TO_DATE('2021-07-03 23:06:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:06:24','YYYY-MM-DD HH24:MI:SS'),100,200348,'Y',1000000,1,200000,'f74ad7f0-fac9-4681-8dcd-dd957cec31cb')
;

-- Jul 3, 2021, 11:07:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214533,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200279,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2021-07-03 23:07:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:57','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','c14eacf4-83b4-4687-aaab-37fdba6279e1','N','D')
;

-- Jul 3, 2021, 11:07:58 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214534,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200279,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2021-07-03 23:07:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:57','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','badb2479-a81f-4014-a10f-b886de27440f','N','D')
;

-- Jul 3, 2021, 11:07:58 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203521,0,0,'Y',TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,'AD_Wlistbox_Customization_ID','Customization of the Wlistbox','Customization of the Wlistbox','D','9e48b43a-5fac-4f10-b1f8-18ee6ce341c6')
;

-- Jul 3, 2021, 11:07:58 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214535,0.0,'Customization of the Wlistbox',200279,'AD_Wlistbox_Customization_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,203521,'N','N','D','N','3c21f840-2cc9-4b68-96a3-3d21f0f61961','N')
;

-- Jul 3, 2021, 11:07:59 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203522,0,0,'Y',TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,'WlistboxName','WlistboxName','WlistboxName','D','8cb159d1-d1e6-4b89-97cb-7eb04fa36f0d')
;

-- Jul 3, 2021, 11:07:59 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214536,0.0,'WlistboxName',200279,'WlistboxName',80,'N','N','Y','N','N','N',10,0,0,'Y',TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:58','YYYY-MM-DD HH24:MI:SS'),100,203522,'Y','N','D','N','093a2a9a-f52c-4812-aa2d-65abacc2460b','N')
;

-- Jul 3, 2021, 11:07:59 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214537,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200279,'AD_User_ID',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_DATE('2021-07-03 23:07:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:59','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','N','c807cc23-e699-4e9c-871e-ef75d40a10d0','N')
;

-- Jul 3, 2021, 11:08:00 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214538,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200279,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2021-07-03 23:07:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:07:59','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','4182cb49-9352-44d1-9587-b20d86f07d4c','N')
;

-- Jul 3, 2021, 11:08:00 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214539,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200279,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2021-07-03 23:08:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:08:00','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','9334abbb-1604-4da6-b35a-5c5caf80f156','N','D')
;

-- Jul 3, 2021, 11:08:00 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214540,0.0,'Custom',200279,'Custom',2000,'N','N','Y','N','N','N',10,0,0,'Y',TO_DATE('2021-07-03 23:08:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:08:00','YYYY-MM-DD HH24:MI:SS'),100,200082,'Y','N','D','N','cc4aefa8-582d-49c3-91fa-28669cef8853','N')
;

-- Jul 3, 2021, 11:08:01 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214541,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200279,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2021-07-03 23:08:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:08:00','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','b15ddae4-9c92-4d3c-8eb5-81561fd11b6e','N')
;

-- Jul 3, 2021, 11:08:01 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214542,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200279,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','2269b1a5-728e-4405-b636-7d8cf415d9e4','N')
;

-- Jul 3, 2021, 11:08:01 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214543,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200279,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','a1b4cbbb-41d5-4ebb-a9b9-14008fadc7d9','N','D')
;

-- Jul 3, 2021, 11:08:01 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203523,0,0,'Y',TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,'AD_Wlistbox_Customization_UU','AD_Wlistbox_Customization_UU','AD_Wlistbox_Customization_UU','D','5f67b77c-08f9-4c20-9463-bedde0025842')
;

-- Jul 3, 2021, 11:08:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214544,0.0,'AD_Wlistbox_Customization_UU',200279,'AD_Wlistbox_Customization_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-03 23:08:01','YYYY-MM-DD HH24:MI:SS'),100,203523,'N','N','D','N','71dec96d-d4d6-4e4e-b6c9-3091a6784973','N')
;

-- Table: AD_Wlistbox_Customization
-- Sep 27, 2021, 11:54:39 AM CEST
UPDATE AD_Column SET FKConstraintName='ADUser_ADWlistboxCustomization', FKConstraintType='N',Updated=TO_DATE('2021-09-27 11:54:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214537
;

-- Sep 27, 2021, 11:54:39 AM CEST
CREATE TABLE AD_Wlistbox_Customization (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_User_ID NUMBER(10) NOT NULL, AD_Wlistbox_Customization_ID NUMBER(10) NOT NULL, AD_Wlistbox_Customization_UU VARCHAR2(36 CHAR) DEFAULT NULL , Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Custom VARCHAR2(2000 CHAR) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, WlistboxName VARCHAR2(80 CHAR) NOT NULL, CONSTRAINT AD_Wlistbox_Customization_Key PRIMARY KEY (AD_Wlistbox_Customization_ID), CONSTRAINT AD_Wlistbox_Customizationuuidx UNIQUE (AD_Wlistbox_Customization_UU))
;

-- Sep 27, 2021, 11:54:39 AM CEST
ALTER TABLE AD_Wlistbox_Customization ADD CONSTRAINT ADUser_ADWlistboxCustomization FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 27, 2021, 11:57:43 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201090,'663c5e7b-9a1c-46c5-ab61-5a67c0605d17',TO_DATE('2021-09-27 11:57:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_wlistbox_customization_uu_idx',TO_DATE('2021-09-27 11:57:43','YYYY-MM-DD HH24:MI:SS'),100,200279,'N','Y','N','N','N')
;

-- Sep 27, 2021, 11:57:53 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201430,'7bfe450f-6651-4331-97f2-2c66a8699dd8',TO_DATE('2021-09-27 11:57:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-09-27 11:57:53','YYYY-MM-DD HH24:MI:SS'),100,214544,201090,10)
;

-- Sep 27, 2021, 11:58:00 AM CEST
-- index is created automatically in oracle with the unique constraint
-- CREATE UNIQUE INDEX ad_wlistbox_customization_uu_idx ON AD_Wlistbox_Customization (AD_Wlistbox_Customization_UU)
-- ;

-- Oct 8, 2021, 9:36:28 PM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201095,'358b9fa7-8229-4076-b330-7914e9e46c22',TO_DATE('2021-10-08 21:36:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_wlistbox_custom_name_idx',TO_DATE('2021-10-08 21:36:27','YYYY-MM-DD HH24:MI:SS'),100,200279,'N','Y','N','N','N')
;
 
-- Oct 8, 2021, 9:36:42 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201439,'475230ad-650c-4430-b9d6-29deb6526bb1',TO_DATE('2021-10-08 21:36:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-10-08 21:36:41','YYYY-MM-DD HH24:MI:SS'),100,214533,201095,10)
;
 
-- Oct 8, 2021, 9:36:51 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201440,'0fd0469d-be21-4e00-a7a0-996013871f08',TO_DATE('2021-10-08 21:36:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-10-08 21:36:51','YYYY-MM-DD HH24:MI:SS'),100,214537,201095,20)
;
 
-- Oct 8, 2021, 9:37:11 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201441,'f705108e-a2cd-480e-8a84-8157537af6be',TO_DATE('2021-10-08 21:37:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-10-08 21:37:10','YYYY-MM-DD HH24:MI:SS'),100,214536,201095,30)
;
 
-- Oct 8, 2021, 9:37:22 PM MYT
CREATE UNIQUE INDEX ad_wlistbox_custom_name_idx ON AD_Wlistbox_Customization (AD_Client_ID,AD_User_ID,WlistboxName)
;

SELECT register_migration_script('202110081200_IDEMPIERE-4863.sql') FROM dual;
