SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2668 Exclude Locators for Demand Operations
-- Jun 9, 2015 6:03:39 PM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202886,0,0,'Y',TO_DATE('2015-06-09 18:03:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:03:38','YYYY-MM-DD HH24:MI:SS'),100,'IsAvailableForReplenishment','Available for Replenishment','Available for Replenishment','D','5e2d1eaa-3fde-4240-b83a-035ccab27483')
;

-- Jun 9, 2015 6:03:58 PM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202887,0,0,'Y',TO_DATE('2015-06-09 18:03:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:03:58','YYYY-MM-DD HH24:MI:SS'),100,'IsAvailableForReservation','Available for Reservation','Available for Reservation','D','4ddf3b6f-825d-4c90-9f92-71a3e11f2e2a')
;

-- Jun 9, 2015 6:04:23 PM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202888,0,0,'Y',TO_DATE('2015-06-09 18:04:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:04:23','YYYY-MM-DD HH24:MI:SS'),100,'IsAvailableForShipping','Available for Shipping','Available for Shipping','D','75f9e774-476c-4f32-9c84-54f21f4717bf')
;

-- Jun 9, 2015 6:08:51 PM COT
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200074,'Locator Type',0,0,'Y',TO_DATE('2015-06-09 18:08:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:08:50','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','cf08fb56-c497-48b2-b901-dc331f88a4d4')
;

-- Jun 9, 2015 6:08:59 PM COT
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop) VALUES (200175,'Locator Type',200074,'M_LocatorType',0,'3',0,0,'Y',TO_DATE('2015-06-09 18:08:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:08:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','f2b7e21d-ca0f-4575-a598-5bae28df6b24','N','N')
;

-- Jun 9, 2015 6:08:59 PM COT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('M_LocatorType',1000000,'N','N','Table M_LocatorType','Y','Y',0,0,TO_DATE('2015-06-09 18:08:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:08:59','YYYY-MM-DD HH24:MI:SS'),100,200231,'Y',1000000,1,200000,'401b3cae-5730-4c62-b306-2f18e3d8d142')
;

-- Jun 9, 2015 6:09:13 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212181,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200175,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-06-09 18:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:13','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','f364ce24-be93-4de6-8686-111905fd6980','N','N','N')
;

-- Jun 9, 2015 6:09:13 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212182,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200175,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-06-09 18:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:13','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','ae0f9c76-2825-4cd9-bcd9-24fe6eb43253','N','N','N')
;

-- Jun 9, 2015 6:09:14 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212183,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200175,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-06-09 18:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:13','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','37c6dedf-df2b-4b75-8ecf-a4a6f5c0c376','N','N','N')
;

-- Jun 9, 2015 6:09:14 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212184,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200175,'CreatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','4b1edc4a-f105-4753-8566-4a415ea12c77','N','N','N')
;

-- Jun 9, 2015 6:09:14 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212185,1,'Description','Optional short description of the record','A description is limited to 255 characters.',200175,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','c5c54fc4-f29a-495b-b70b-0319e6e18656','Y','N','N')
;

-- Jun 9, 2015 6:09:14 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212186,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200175,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','7352dea2-66c4-4e2e-98aa-741d102bcb34','Y','N','N')
;

-- Jun 9, 2015 6:09:15 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212187,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200175,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:14','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','1bf86a87-aa8d-4287-bb41-1e82376d8242','N','N','N')
;

-- Jun 9, 2015 6:09:15 PM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202889,0,0,'Y',TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,'M_LocatorType_ID','Locator Type','Locator Type','D','40daae66-c2e4-4700-9ea6-7ba10237fff8')
;

-- Jun 9, 2015 6:09:15 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212188,1,'Locator Type',200175,'M_LocatorType_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,202889,'N','N','D','Y','N','N','Y','f4d83bfd-cc5d-4c03-b479-ad01fa1f7684','N','N','N')
;

-- Jun 9, 2015 6:09:15 PM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202890,0,0,'Y',TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,'M_LocatorType_UU','M_LocatorType_UU','M_LocatorType_UU','D','9b6c9339-fc09-46c5-884f-b048019eeb39')
;

-- Jun 9, 2015 6:09:15 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212189,1.00,'M_LocatorType_UU',200175,'M_LocatorType_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,202890,'Y','N','D','N','N','N','Y','0963606e-219d-49d2-aba1-22605cd5f302','N','N','N')
;

-- Jun 9, 2015 6:09:16 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212190,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200175,'Name',60,'N','N','Y','N','Y',1,'N',10,0,0,'Y',TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','73f48c32-177a-41bf-b049-f347290c5334','Y','N','N')
;

-- Jun 9, 2015 6:09:16 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212191,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200175,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-06-09 18:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:16','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','a35a068c-6556-4b2b-b7e9-93b2c8ab5dbf','N','N','N')
;

-- Jun 9, 2015 6:09:16 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212192,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200175,'UpdatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-06-09 18:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:16','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','6905723a-de6b-40bf-8595-948cfe1c8029','N','N','N')
;

-- Jun 9, 2015 6:09:16 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212193,1,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200175,'Value',40,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-06-09 18:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:09:16','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','Y','N','N','Y','5f703bd8-6824-453f-a419-978a39c47320','Y','N','N')
;

-- Jun 9, 2015 6:10:56 PM COT
UPDATE AD_Column SET Name='Available for Replenishment', Description=NULL, Help=NULL, ColumnName='IsAvailableForReplenishment', DefaultValue='Y', FieldLength=1, AD_Reference_ID=20, AD_Element_ID=202886, IsSelectionColumn='N', FKConstraintType=NULL,Updated=TO_DATE('2015-06-09 18:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212193
;

-- Jun 9, 2015 6:11:18 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212194,1,'Available for Reservation',200175,'IsAvailableForReservation','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-06-09 18:11:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:11:17','YYYY-MM-DD HH24:MI:SS'),100,202887,'Y','N','D','Y','N','N','Y','6de34019-bfeb-4272-974e-52906d4d29eb','Y','N','N')
;

-- Jun 9, 2015 6:12:01 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212195,1,'Available for Shipping',200175,'IsAvailableForShipping','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-06-09 18:12:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:12:01','YYYY-MM-DD HH24:MI:SS'),100,202888,'Y','N','D','Y','N','N','Y','e7fba8f8-f3fb-488f-a6b7-93a89a28e0a3','Y','N','N','N')
;

-- Jun 9, 2015 6:15:44 PM COT
UPDATE AD_Column SET FKConstraintName='ADClient_MLocatorType', FKConstraintType='N',Updated=TO_DATE('2015-06-09 18:15:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212181
;

-- Jun 9, 2015 6:15:44 PM COT
UPDATE AD_Column SET FKConstraintName='ADOrg_MLocatorType', FKConstraintType='N',Updated=TO_DATE('2015-06-09 18:15:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212182
;

-- Jun 9, 2015 6:15:44 PM COT
UPDATE AD_Column SET FKConstraintName='CreatedBy_MLocatorType', FKConstraintType='N',Updated=TO_DATE('2015-06-09 18:15:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212184
;

-- Jun 9, 2015 6:15:44 PM COT
UPDATE AD_Column SET FKConstraintName='UpdatedBy_MLocatorType', FKConstraintType='N',Updated=TO_DATE('2015-06-09 18:15:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212192
;

-- Jun 9, 2015 6:15:44 PM COT
CREATE TABLE M_LocatorType (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255) DEFAULT NULL , Help VARCHAR2(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsAvailableForReplenishment CHAR(1) DEFAULT 'Y' CHECK (IsAvailableForReplenishment IN ('Y','N')) NOT NULL, IsAvailableForReservation CHAR(1) DEFAULT 'Y' CHECK (IsAvailableForReservation IN ('Y','N')) NOT NULL, IsAvailableForShipping CHAR(1) DEFAULT 'Y' CHECK (IsAvailableForShipping IN ('Y','N')) NOT NULL, M_LocatorType_ID NUMBER(10) NOT NULL, M_LocatorType_UU VARCHAR2(36) DEFAULT NULL , Name VARCHAR2(60) NOT NULL, Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT M_LocatorType_Key PRIMARY KEY (M_LocatorType_ID), CONSTRAINT M_LocatorType_UU_idx UNIQUE (M_LocatorType_UU))
;

-- Jun 9, 2015 6:15:44 PM COT
ALTER TABLE M_LocatorType ADD CONSTRAINT ADClient_MLocatorType FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 9, 2015 6:15:44 PM COT
ALTER TABLE M_LocatorType ADD CONSTRAINT ADOrg_MLocatorType FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 9, 2015 6:15:44 PM COT
ALTER TABLE M_LocatorType ADD CONSTRAINT CreatedBy_MLocatorType FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 9, 2015 6:15:44 PM COT
ALTER TABLE M_LocatorType ADD CONSTRAINT UpdatedBy_MLocatorType FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 9, 2015 6:16:17 PM COT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing) VALUES (0,0,201037,'ba61df8c-e022-49fb-8f1a-bc6c6c23f2eb',TO_DATE('2015-06-09 18:16:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','m_locatortype_uu_idx',TO_DATE('2015-06-09 18:16:17','YYYY-MM-DD HH24:MI:SS'),100,200175,'N','Y','N')
;

-- Jun 9, 2015 6:16:17 PM COT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201269,'f1a91678-6ecf-49a3-b5d6-919df929f9c4',TO_DATE('2015-06-09 18:16:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2015-06-09 18:16:17','YYYY-MM-DD HH24:MI:SS'),100,212189,201037,1)
;

-- Jun 9, 2015 6:19:29 PM COT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200190,'Locator Type',200074,10,'Y',200175,0,0,'Y',TO_DATE('2015-06-09 18:19:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','M_LocatorType.Name','N','N',0,'N','D','Y','N','388b0f0c-ece2-4809-96d6-4d486d3e7b5d','B')
;

-- Jun 9, 2015 6:19:38 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203803,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200190,212181,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b4a6281e-d02c-4385-b011-50a80efbe606','N',2)
;

-- Jun 9, 2015 6:19:38 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203804,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200190,212182,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','73843af6-0103-442d-88dc-be6860f7d8f5','Y','Y',10,4,2)
;

-- Jun 9, 2015 6:19:38 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203805,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200190,212190,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d929ad16-8f1a-42ff-a657-83d3f26ebc54','Y',20,5)
;

-- Jun 9, 2015 6:19:38 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203806,'Description','Optional short description of the record','A description is limited to 255 characters.',200190,212185,'Y',255,40,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cc891cd5-29f8-4887-89d6-ea4185a3c6c6','Y',30,5)
;

-- Jun 9, 2015 6:19:39 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (203807,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200190,212186,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','29d71ef0-7af4-40cc-a873-89452a6431e2','Y',40,5,3)
;

-- Jun 9, 2015 6:19:39 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203808,'Locator Type',200190,212188,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c51aade9-02bb-4126-9d35-5cdc82e903cf','N',2)
;

-- Jun 9, 2015 6:19:39 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203809,'M_LocatorType_UU',200190,212189,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','edf9670f-8fb1-45b7-97f8-06dcb0e7d305','N',2)
;

-- Jun 9, 2015 6:19:39 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203810,'Available for Replenishment',200190,212193,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5cf26906-5c25-4fc1-b38a-8369366d8eb6','Y',50,2,2)
;

-- Jun 9, 2015 6:19:39 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203811,'Available for Reservation',200190,212194,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8cc97c74-2853-4c19-8f98-f139981c70e5','Y',60,2,2)
;

-- Jun 9, 2015 6:19:40 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203812,'Available for Shipping',200190,212195,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','58d68f4a-6cf1-42a7-a75e-2378822161dd','Y',70,2,2)
;

-- Jun 9, 2015 6:19:40 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203813,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200190,212187,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:19:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:19:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b9734ff4-cda2-4acc-8d88-1adae757273c','Y',80,2,2)
;

-- Jun 9, 2015 6:20:10 PM COT
UPDATE AD_Field SET SeqNo=60, ColumnSpan=1,Updated=TO_DATE('2015-06-09 18:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203810
;

-- Jun 9, 2015 6:20:10 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=3, ColumnSpan=1,Updated=TO_DATE('2015-06-09 18:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203811
;

-- Jun 9, 2015 6:20:10 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4, ColumnSpan=1,Updated=TO_DATE('2015-06-09 18:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203812
;

-- Jun 9, 2015 6:20:10 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=6, ColumnSpan=1,Updated=TO_DATE('2015-06-09 18:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203813
;

-- Jun 9, 2015 6:20:10 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-06-09 18:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203808
;

-- Jun 9, 2015 6:20:10 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-06-09 18:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203809
;

-- Jun 9, 2015 6:21:29 PM COT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200111,'Locator Type','W',200074,0,0,'Y',TO_DATE('2015-06-09 18:21:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:21:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','a2f0d1bd-3fe0-4f59-af8c-2dafa0247e5a')
;

-- Jun 9, 2015 6:21:29 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200111, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200111)
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200111
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jun 9, 2015 6:21:52 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=268
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=125
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=422
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=107
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=130
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=188
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=227
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=381
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=126
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200111
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=421
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=534
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200044
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=267
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=490
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=132
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=310
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200032
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200033
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200029
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=128
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=585
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=187
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53210
;

-- Jun 9, 2015 6:22:14 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53211
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=268
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200111
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=125
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=422
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=107
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=130
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=188
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=227
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=381
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=126
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=421
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=534
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200044
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=267
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=490
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=132
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=310
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200032
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200033
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200029
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=128
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=585
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=187
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53210
;

-- Jun 9, 2015 6:22:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53211
;

-- Jun 9, 2015 6:27:22 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212196,0,'Locator Type',207,'M_LocatorType_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-06-09 18:27:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:27:21','YYYY-MM-DD HH24:MI:SS'),100,202889,'Y','N','D','N','N','N','Y','78a5bc43-39d9-46d3-b30e-f9ae3bf9f4ec','Y',0,'N','N','N')
;

-- Jun 9, 2015 6:27:27 PM COT
UPDATE AD_Column SET FKConstraintName='MLocatorType_MLocator', FKConstraintType='N',Updated=TO_DATE('2015-06-09 18:27:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212196
;

-- Jun 9, 2015 6:27:27 PM COT
ALTER TABLE M_Locator ADD M_LocatorType_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 9, 2015 6:27:27 PM COT
ALTER TABLE M_Locator ADD CONSTRAINT MLocatorType_MLocator FOREIGN KEY (M_LocatorType_ID) REFERENCES m_locatortype(m_locatortype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 9, 2015 6:28:07 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203814,'Locator Type',178,212196,'Y',22,120,'N','N','N','N',0,0,'Y',TO_DATE('2015-06-09 18:28:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-09 18:28:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6d4732fc-d162-4eea-ad45-6118537250bc','Y',120,2)
;

-- Jun 9, 2015 6:29:03 PM COT
UPDATE AD_Field SET SeqNo=10,Updated=TO_DATE('2015-06-09 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000
;

-- Jun 9, 2015 6:29:03 PM COT
UPDATE AD_Field SET SeqNo=20,Updated=TO_DATE('2015-06-09 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2044
;

-- Jun 9, 2015 6:29:03 PM COT
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2015-06-09 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1003
;

-- Jun 9, 2015 6:29:03 PM COT
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2015-06-09 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2095
;

-- Jun 9, 2015 6:29:03 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1,Updated=TO_DATE('2015-06-09 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203814
;

-- Jun 9, 2015 6:29:03 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=5, ColumnSpan=2,Updated=TO_DATE('2015-06-09 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1001
;

-- Jun 9, 2015 6:29:03 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-06-09 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=999
;

CREATE OR REPLACE FUNCTION BOMQTYONHAND
(
	Product_ID 		IN NUMBER,
	Warehouse_ID		IN NUMBER,
	Locator_ID		IN NUMBER	--	Only used, if warehouse is null
)
RETURN NUMBER
/******************************************************************************
 * ** Compiere Product **             Copyright (c) 1999-2001 Accorto, Inc. USA
 * Open  Source  Software        Provided "AS IS" without warranty or liability
 * When you use any parts (changed or unchanged), add  "Powered by Compiere" to
 * your product name;  See license details http://www.compiere.org/license.html
 ******************************************************************************
 *	Return quantity on hand for BOM
 */
AS
	myWarehouse_ID	NUMBER;
 	Quantity		NUMBER := 99999;	--	unlimited
	IsBOM			CHAR(1);
	IsStocked		CHAR(1);
	ProductType		CHAR(1);
 	ProductQty		NUMBER;
	StdPrecision	NUMBER;
	--	Get BOM Product info
	CURSOR CUR_BOM IS
		SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM, p.IsStocked, p.ProductType
		FROM M_PRODUCT_BOM b, M_PRODUCT p
		WHERE b.M_ProductBOM_ID=p.M_Product_ID
		  AND b.M_Product_ID=Product_ID
		  AND b.M_ProductBOM_ID != Product_ID
		  AND p.IsBOM='Y'
		  AND p.IsVerified='Y'
		  AND b.IsActive='Y';
	--
BEGIN
	--	Check Parameters
	myWarehouse_ID := Warehouse_ID;
	IF (myWarehouse_ID IS NULL) THEN
		IF (Locator_ID IS NULL) THEN
			RETURN 0;
		ELSE
			SELECT 	SUM(M_Warehouse_ID) INTO myWarehouse_ID
			FROM	M_LOCATOR
			WHERE	M_Locator_ID=Locator_ID;
		END IF;
	END IF;
	IF (myWarehouse_ID IS NULL) THEN
		RETURN 0;
	END IF;
--	DBMS_OUTPUT.PUT_LINE('Warehouse=' || myWarehouse_ID);

	--	Check, if product exists and if it is stocked
	BEGIN
		SELECT	IsBOM, ProductType, IsStocked
	 	  INTO	IsBOM, ProductType, IsStocked
		FROM M_PRODUCT
		WHERE M_Product_ID=Product_ID;
		--
	EXCEPTION	--	not found
		WHEN OTHERS THEN
			RETURN 0;
	END;
	--	Unlimited capacity if no item
	IF (IsBOM='N' AND (ProductType<>'I' OR IsStocked='N')) THEN
		RETURN Quantity;
	--	Stocked item
	ELSIF (IsStocked='Y') THEN
		--	Get ProductQty
		SELECT 	NVL(SUM(QtyOnHand), 0)
		  INTO	ProductQty
		FROM 	M_Storageonhand s
		  JOIN M_Locator l ON (s.M_Locator_ID=l.M_Locator_ID)
		WHERE s.M_Product_ID=Product_ID AND l.M_Warehouse_ID=myWarehouse_ID;
		--
	--	DBMS_OUTPUT.PUT_LINE('Qty=' || ProductQty);
		RETURN ProductQty;
	END IF;

	--	Go through BOM
--	DBMS_OUTPUT.PUT_LINE('BOM');
	FOR bom IN CUR_BOM LOOP
		--	Stocked Items "leaf node"
		IF (bom.ProductType = 'I' AND bom.IsStocked = 'Y') THEN
			--	Get ProductQty
			SELECT 	NVL(SUM(QtyOnHand), 0)
			  INTO	ProductQty
			FROM 	M_Storageonhand s
			  JOIN M_Locator l ON (s.M_Locator_ID=l.M_Locator_ID)
			WHERE s.M_Product_ID=bom.M_ProductBOM_ID AND l.M_Warehouse_ID=myWarehouse_ID;
			--	Get Rounding Precision
			SELECT 	NVL(MAX(u.StdPrecision), 0)
			  INTO	StdPrecision
			FROM 	C_UOM u, M_PRODUCT p
			WHERE u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=bom.M_ProductBOM_ID;
			--	How much can we make with this product
			ProductQty := ROUND (ProductQty/bom.BOMQty, StdPrecision);
			--	How much can we make overall
			IF (ProductQty < Quantity) THEN
				Quantity := ProductQty;
			END IF;
		--	Another BOM
		ELSIF (bom.IsBOM = 'Y') THEN
			ProductQty := Bomqtyonhand (bom.M_ProductBOM_ID, myWarehouse_ID, Locator_ID);
			--	How much can we make overall
			IF (ProductQty < Quantity) THEN
				Quantity := ProductQty;
			END IF;
		END IF;
	END LOOP;	--	BOM

	IF (Quantity > 0) THEN
		--	Get Rounding Precision for Product
		SELECT 	NVL(MAX(u.StdPrecision), 0)
		  INTO	StdPrecision
		FROM 	C_UOM u, M_PRODUCT p
		WHERE u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=Product_ID;
		--
		RETURN ROUND (Quantity, StdPrecision);
	END IF;
	RETURN 0;
END Bomqtyonhand;
/

CREATE OR REPLACE FUNCTION BOMQTYONHANDFORRESERVATION
(
	Product_ID 		IN NUMBER,
	Warehouse_ID		IN NUMBER,
	Locator_ID		IN NUMBER	--	Only used, if warehouse is null
)
RETURN NUMBER
/******************************************************************************
 * ** Compiere Product **             Copyright (c) 1999-2001 Accorto, Inc. USA
 * Open  Source  Software        Provided "AS IS" without warranty or liability
 * When you use any parts (changed or unchanged), add  "Powered by Compiere" to
 * your product name;  See license details http://www.compiere.org/license.html
 ******************************************************************************
 *	Return quantity on hand for BOM
 */
AS
	myWarehouse_ID	NUMBER;
 	Quantity		NUMBER := 99999;	--	unlimited
	IsBOM			CHAR(1);
	IsStocked		CHAR(1);
	ProductType		CHAR(1);
 	ProductQty		NUMBER;
	StdPrecision	NUMBER;
	--	Get BOM Product info
	CURSOR CUR_BOM IS
		SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM, p.IsStocked, p.ProductType
		FROM M_PRODUCT_BOM b, M_PRODUCT p
		WHERE b.M_ProductBOM_ID=p.M_Product_ID
		  AND b.M_Product_ID=Product_ID
		  AND b.M_ProductBOM_ID != Product_ID
		  AND p.IsBOM='Y'
		  AND p.IsVerified='Y'
		  AND b.IsActive='Y';
	--
BEGIN
	--	Check Parameters
	myWarehouse_ID := Warehouse_ID;
	IF (myWarehouse_ID IS NULL) THEN
		IF (Locator_ID IS NULL) THEN
			RETURN 0;
		ELSE
			SELECT 	SUM(M_Warehouse_ID) INTO myWarehouse_ID
			FROM	M_LOCATOR
			WHERE	M_Locator_ID=Locator_ID;
		END IF;
	END IF;
	IF (myWarehouse_ID IS NULL) THEN
		RETURN 0;
	END IF;
--	DBMS_OUTPUT.PUT_LINE('Warehouse=' || myWarehouse_ID);

	--	Check, if product exists and if it is stocked
	BEGIN
		SELECT	IsBOM, ProductType, IsStocked
	 	  INTO	IsBOM, ProductType, IsStocked
		FROM M_PRODUCT
		WHERE M_Product_ID=Product_ID;
		--
	EXCEPTION	--	not found
		WHEN OTHERS THEN
			RETURN 0;
	END;
	--	Unlimited capacity if no item
	IF (IsBOM='N' AND (ProductType<>'I' OR IsStocked='N')) THEN
		RETURN Quantity;
	--	Stocked item
	ELSIF (IsStocked='Y') THEN
		--	Get ProductQty
		SELECT 	NVL(SUM(QtyOnHand), 0)
		  INTO	ProductQty
		FROM 	M_Storageonhand s
		  JOIN M_Locator l ON (s.M_Locator_ID=l.M_Locator_ID)
		  LEFT JOIN M_LocatorType lt ON (l.M_LocatorType_ID=lt.M_LocatorType_ID)
		WHERE s.M_Product_ID=Product_ID AND l.M_Warehouse_ID=myWarehouse_ID
		  AND COALESCE(lt.IsAvailableForReservation,'Y')='Y';
		--
	--	DBMS_OUTPUT.PUT_LINE('Qty=' || ProductQty);
		RETURN ProductQty;
	END IF;

	--	Go through BOM
--	DBMS_OUTPUT.PUT_LINE('BOM');
	FOR bom IN CUR_BOM LOOP
		--	Stocked Items "leaf node"
		IF (bom.ProductType = 'I' AND bom.IsStocked = 'Y') THEN
			--	Get ProductQty
			SELECT 	NVL(SUM(QtyOnHand), 0)
			  INTO	ProductQty
			FROM 	M_Storageonhand s
			  JOIN M_Locator l ON (s.M_Locator_ID=l.M_Locator_ID)
			  LEFT JOIN M_LocatorType lt ON (l.M_LocatorType_ID=lt.M_LocatorType_ID)
			WHERE s.M_Product_ID=bom.M_ProductBOM_ID AND l.M_Warehouse_ID=myWarehouse_ID
			  AND COALESCE(lt.IsAvailableForReservation,'Y')='Y';
			--	Get Rounding Precision
			SELECT 	NVL(MAX(u.StdPrecision), 0)
			  INTO	StdPrecision
			FROM 	C_UOM u, M_PRODUCT p
			WHERE u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=bom.M_ProductBOM_ID;
			--	How much can we make with this product
			ProductQty := ROUND (ProductQty/bom.BOMQty, StdPrecision);
			--	How much can we make overall
			IF (ProductQty < Quantity) THEN
				Quantity := ProductQty;
			END IF;
		--	Another BOM
		ELSIF (bom.IsBOM = 'Y') THEN
			ProductQty := BomqtyonhandForReservation (bom.M_ProductBOM_ID, myWarehouse_ID, Locator_ID);
			--	How much can we make overall
			IF (ProductQty < Quantity) THEN
				Quantity := ProductQty;
			END IF;
		END IF;
	END LOOP;	--	BOM

	IF (Quantity > 0) THEN
		--	Get Rounding Precision for Product
		SELECT 	NVL(MAX(u.StdPrecision), 0)
		  INTO	StdPrecision
		FROM 	C_UOM u, M_PRODUCT p
		WHERE u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=Product_ID;
		--
		RETURN ROUND (Quantity, StdPrecision);
	END IF;
	RETURN 0;
END BOMQTYONHANDFORRESERVATION;
/

CREATE OR REPLACE FUNCTION BOMQTYAVAILABLE
(
	Product_ID 		IN NUMBER,
	Warehouse_ID		IN NUMBER,
	Locator_ID		IN NUMBER	--	Only used, if warehouse is null
)
RETURN NUMBER
/******************************************************************************
 * ** Compiere Product **             Copyright (c) 1999-2001 Accorto, Inc. USA
 * Open  Source  Software        Provided "AS IS" without warranty or liability
 * When you use any parts (changed or unchanged), add  "Powered by Compiere" to
 * your product name;  See license details http://www.compiere.org/license.html
 ******************************************************************************
 *	Return quantity available for BOM
 */
AS
BEGIN
	RETURN bomQtyOnHandForReservation(Product_ID, Warehouse_ID, Locator_ID)
		- bomQtyReserved(Product_ID, Warehouse_ID, Locator_ID);
END bomQtyAvailable;
/

--create views
CREATE OR REPLACE VIEW M_PRODUCT_STOCK_V
AS
SELECT 
ms.IsActive, ms.Created, ms.CreatedBy, ms.Updated, ms.UpdatedBy,
mp.VALUE, mp.help,
(CASE WHEN COALESCE(lt.IsAvailableForReservation,'Y')='Y' THEN ms.qtyonhand ELSE 0 END - ms.qtyreserved) AS qtyavailable,
ms.qtyonhand, 
ms.qtyreserved, mp.description, mw.NAME AS warehouse, mw.m_warehouse_id, mw.ad_client_id, 
mw.ad_org_id, mp.documentnote, mp.m_product_id
FROM M_STORAGE ms 
JOIN M_PRODUCT mp ON ms.m_product_id = mp.m_product_id
JOIN M_LOCATOR ml ON ms.m_locator_id = ml.m_locator_id
LEFT JOIN M_LOCATORTYPE lt ON ml.m_locatortype_id = lt.m_locatortype_id
JOIN M_WAREHOUSE mw ON ml.m_warehouse_id = mw.m_warehouse_id 
ORDER BY mw.NAME;

CREATE OR REPLACE VIEW M_PRODUCT_SUBSTITUTERELATED_V AS
SELECT s.ad_client_id, 
		s.ad_org_id, 
		s.isactive, 
		s.created, 
		s.createdby, 
		s.updated, 
		s.updatedby,
		s.m_product_id, 
		s.substitute_id, 
		'S' AS rowtype,
		mp.name, 
		sum(CASE WHEN COALESCE(lt.IsAvailableForReservation,'Y')='Y' THEN ms.qtyonhand ELSE 0 END - ms.qtyreserved) AS qtyavailable, 
		sum(ms.qtyonhand) AS qtyonhand, 
		sum(ms.qtyreserved) AS qtyreserved,
		currencyRound(MAX(mpr.pricestd),mpl.C_Currency_ID,'N') AS pricestd, 
		mpr.m_pricelist_version_id, 
		mw.m_warehouse_id, 
		org.name AS orgname
           FROM m_substitute s
      JOIN m_storage ms ON ms.m_product_id = s.substitute_id
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   LEFT JOIN M_LOCATORTYPE lt ON ml.m_locatortype_id = lt.m_locatortype_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   JOIN m_productprice mpr ON ms.m_product_id = mpr.m_product_id 
   JOIN m_pricelist_version mplv ON mplv.m_pricelist_version_id = mpr.m_pricelist_version_id 
   JOIN m_pricelist mpl ON mplv.m_pricelist_id = mpl.m_pricelist_id 
   JOIN ad_org org ON org.ad_org_id = mw.ad_org_id
   GROUP BY s.ad_client_id, 
   			s.ad_org_id, 
   			s.isactive, 
   			s.created, 
   			s.createdby, 
   			s.updated, 
   			s.updatedby, 
   			s.m_product_id, 
   			s.substitute_id, 
   			mw.m_warehouse_id, 
   			mpr.m_pricelist_version_id, 
   			org.name,  
   			mp.name,
			mpl.C_Currency_ID 
	UNION 
         SELECT r.ad_client_id, 
         	r.ad_org_id, 
         	r.isactive, 
         	r.created, 
         	r.createdby, 
         	r.updated, 
         	r.updatedby,
			r.m_product_id, 
			r.relatedproduct_id AS substitute_id, 
			'R' AS rowtype,  
			mp.name, 
			sum(CASE WHEN COALESCE(lt.IsAvailableForReservation,'Y')='Y' THEN ms.qtyonhand ELSE 0 END - ms.qtyreserved) AS qtyavailable, 
			sum(ms.qtyonhand) AS qtyonhand, 
			sum(ms.qtyreserved) AS qtyreserved, 
			currencyRound(MAX(mpr.pricestd),mpl.C_Currency_ID,'N') AS pricestd, 
			mpr.m_pricelist_version_id, 
			mw.m_warehouse_id, 
			org.name AS orgname
           FROM m_relatedproduct r
      JOIN m_storage ms ON ms.m_product_id = r.relatedproduct_id
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   LEFT JOIN M_LOCATORTYPE lt ON ml.m_locatortype_id = lt.m_locatortype_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   JOIN m_productprice mpr ON ms.m_product_id = mpr.m_product_id 
   JOIN m_pricelist_version mplv ON mplv.m_pricelist_version_id = mpr.m_pricelist_version_id 
   JOIN m_pricelist mpl ON mplv.m_pricelist_id = mpl.m_pricelist_id 
   JOIN ad_org org ON org.ad_org_id = mw.ad_org_id 
   GROUP BY r.ad_client_id, 
   			r.ad_org_id, 
   			r.isactive, 
   			r.created, 
   			r.createdby, 
   			r.updated, 
   			r.updatedby, 
   			r.m_product_id, 
   			r.relatedproduct_id, 
   			mw.m_warehouse_id, 
   			mpr.m_pricelist_version_id, 
   			org.name,  
   			mp.name,
			mpl.C_Currency_ID;

CREATE OR REPLACE VIEW rv_storage
AS
  SELECT s.ad_client_id,
         s.ad_org_id,
         s.m_product_id,
         p.value,
         p.name,
         p.description,
         p.upc,
         p.sku,
         p.c_uom_id,
         p.m_product_category_id,
         p.classification,
         p.weight,
         p.volume,
         p.versionno,
         p.guaranteedays,
         p.guaranteedaysmin,
         s.m_locator_id,
         l.m_warehouse_id,
         l.x,
         l.y,
         l.z,
         s.qtyonhand,
         s.qtyreserved,
         CASE WHEN COALESCE(lt.IsAvailableForReservation,'Y')='Y' THEN s.qtyonhand ELSE 0 END - s.qtyreserved                                    AS qtyavailable,
         s.qtyordered,
         s.datelastinventory,
         s.m_attributesetinstance_id,
         asi.m_attributeset_id,
         asi.serno,
         asi.lot,
         asi.m_lot_id,
         asi.guaranteedate,
         daysbetween(asi.guaranteedate, getdate())                      AS shelflifedays,
         daysbetween(asi.guaranteedate, getdate()) - p.guaranteedaysmin AS goodfordays,
         CASE
           WHEN COALESCE(p.guaranteedays, 0) > 0 THEN round(daysbetween(asi.guaranteedate, getdate()) / p.guaranteedays * 100, 0)
           ELSE NULL
         END                                                            AS shelfliferemainingpct,
         s.isactive                                                     AS m_storage_isactive,
         s.updated                                                      AS m_storage_updated,
         s.updatedby                                                    AS m_storage_updatedby,
         l.ad_org_id                                                    AS m_locator_ad_org_id,
         l.isactive                                                     AS m_locator_isactive,
         l.isdefault,
         l.priorityno,
         l.value                                                        AS m_locator_value,
         p.ad_org_id                                                    AS m_product_ad_org_id,
         p.copyfrom                                                     AS m_product_copyfrom,
         p.created                                                      AS m_product_created,
         p.createdby                                                    AS m_product_createdby,
         p.c_revenuerecognition_id,
         p.c_subscriptiontype_id,
         p.c_taxcategory_id,
         p.descriptionurl,
         p.discontinued                                                 AS m_product_discontinued,
         p.discontinuedat                                               AS m_product_discontinuedat,
         p.documentnote,
         p.group1,
         p.group2,
         p.help,
         p.imageurl,
         p.isactive                                                     AS m_product_isactive,
         p.isbom,
         p.isdropship,
         p.isexcludeautodelivery,
         p.isinvoiceprintdetails,
         p.ispicklistprintdetails,
         p.ispurchased,
         p.isselfservice,
         p.issold,
         p.isstocked,
         p.issummary                                                    AS m_product_issummary,
         p.isverified,
         p.iswebstorefeatured,
         p.lowlevel,
         p.m_attributeset_id                                            AS m_product_m_attributeset_id,
         p.m_attributesetinstance_id                                    AS m_product_m_asi_id,
         p.m_freightcategory_id,
         p.m_locator_id                                                 AS m_product_m_locator_id,
         p.processing                                                   AS m_product_processing,
         p.producttype,
         p.r_mailtext_id,
         p.salesrep_id                                                  AS m_product_salesrep_id,
         p.s_expensetype_id,
         p.shelfdepth,
         p.shelfheight,
         p.shelfwidth,
         p.s_resource_id,
         p.unitsperpack,
         p.unitsperpallet,
         p.updated                                                      AS m_product_updated,
         p.updatedby                                                    AS m_product_updatedby,
         asi.ad_org_id                                                  AS m_asi_ad_org_id,
         asi.created                                                    AS m_asi_created,
         asi.createdby                                                  AS m_asi_createdby,
         asi.description                                                AS m_asi_description,
         asi.isactive                                                   AS m_asi_isactive,
         asi.updated                                                    AS m_asi_updated,
         asi.updatedby                                                  AS m_asi_updatedby
  FROM   m_storage s
         JOIN m_locator l
           ON s.m_locator_id = l.m_locator_id
        LEFT JOIN m_locatortype lt
           ON l.m_locatortype_id = lt.m_locatortype_id 
         JOIN m_product p
           ON s.m_product_id = p.m_product_id
         LEFT JOIN m_attributesetinstance asi
                ON s.m_attributesetinstance_id = asi.m_attributesetinstance_id
;

-- Jun 12, 2015 11:07:40 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Locator not available for shipping',0,0,'Y',TO_DATE('2015-06-12 23:07:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-06-12 23:07:40','YYYY-MM-DD HH24:MI:SS'),100,200353,'LocatorNotAvailableForShipping','D','213a2d7d-449a-48e0-8aa4-596207ee2c73')
;

SELECT register_migration_script('201506091830_IDEMPIERE-2668.sql') FROM dual
;

