-- IDEMPIERE-3101 implement OAuth2 for mail (gmail, outlook and other mail system)
-- Feb 17, 2021, 10:08:15 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200178,'External Authorization',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:14','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','N','D','N','d08e9cc5-6835-4788-960c-a0dbe0d96b9a')
;

-- Feb 17, 2021, 10:08:15 PM CET
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 155,7, 10, 200178)
;

-- Feb 17, 2021, 10:08:15 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200112,'Authorization Provider',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:15','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','4f0f02bf-5529-49e8-b43d-45d1367f5920')
;

-- Feb 17, 2021, 10:08:16 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200269,'Authorization Provider',200112,'AD_AuthorizationProvider',0,'6',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','fc552994-cf9c-49fd-902a-5856ad5f4183','N','N','N','N')
;

-- Feb 17, 2021, 10:08:17 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AuthorizationProvider',1000000,'N','N','Table AD_AuthorizationProvider','Y','Y',0,0,TO_TIMESTAMP('2021-02-17 22:08:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:16','YYYY-MM-DD HH24:MI:SS'),100,200338,'Y',1000000,1,200000,'42a5fd8a-fb5d-4f4c-b877-402ef7a3108d')
;

-- Feb 17, 2021, 10:08:17 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203452,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:17','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationProvider_ID','Authorization Provider','Authorization Provider','D','12041840-15b0-4187-831d-42a7aa644095')
;

-- Feb 17, 2021, 10:08:18 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214348,1,'Authorization Provider',200269,'AD_AuthorizationProvider_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:17','YYYY-MM-DD HH24:MI:SS'),100,203452,'N','N','D','Y','N','N','Y','b75b928d-b34e-47a8-bd52-6f582b973890','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:18 PM CET
CREATE TABLE AD_AuthorizationProvider (AD_AuthorizationProvider_ID NUMERIC(10) NOT NULL, CONSTRAINT AD_AuthorizationProvider_Key PRIMARY KEY (AD_AuthorizationProvider_ID))
;

-- Feb 17, 2021, 10:08:18 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214349,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200269,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:18','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','b2fd5379-53f1-40c7-b5dd-ba3f311ec006','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:18 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN AD_Client_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:19 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214350,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200269,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:18','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','957c495e-98cd-4f13-b0c0-5021d9da2532','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:19 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:19 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214351,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200269,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:19','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','8b51126c-7485-483f-b9ba-c351fdb59be8','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:19 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:08:19 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214352,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200269,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:19','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','6584c6cc-dd95-42eb-a102-b99abfc8295e','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:19 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:20 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214353,1,'Description','Optional short description of the record','A description is limited to 255 characters.',200269,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:19','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','82729790-47f3-49bb-baee-55e2851a93a2','Y',10,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:20 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN Description VARCHAR(255) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:20 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214354,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200269,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:20','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','753818cb-f1ca-4765-a308-5ccb4d299217','Y','N','N','N','N')
;

-- Feb 17, 2021, 10:08:20 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN Help VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:21 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214355,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200269,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:20','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','6c395d0b-1f98-4b83-871f-f220269d4ff6','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:21 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Feb 17, 2021, 10:08:21 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203453,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:21','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationProvider_UU','AD_AuthorizationProvider_UU','AD_AuthorizationProvider_UU','D','85ab42a4-c5bb-48e1-931a-bb2f7e533a22')
;

-- Feb 17, 2021, 10:08:21 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214356,1.00,'AD_AuthorizationProvider_UU',200269,'AD_AuthorizationProvider_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:21','YYYY-MM-DD HH24:MI:SS'),100,203453,'Y','N','D','Y','N','N','Y','61fe1993-f5d6-414f-9480-bd835a8f0825','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:22 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN AD_AuthorizationProvider_UU VARCHAR(36) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:22 PM CET
ALTER TABLE AD_AuthorizationProvider ADD CONSTRAINT AD_AuthorizationProvider_uuidx UNIQUE (AD_AuthorizationProvider_UU)
;

-- Feb 17, 2021, 10:08:22 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214357,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200269,'Name',60,'N','N','Y','N','Y',1,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','0d695a7d-a209-49ba-8267-0df17c0b6d59','Y',20,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:22 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN Name VARCHAR(60) NOT NULL
;

-- Feb 17, 2021, 10:08:22 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214358,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200269,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','155825e4-8c08-4b76-8d3c-821e6af9d4bd','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:22 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:08:23 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214359,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200269,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','c0c23351-cf14-491b-a506-85aa77837296','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:23 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:23 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203454,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:23','YYYY-MM-DD HH24:MI:SS'),100,'AuthorizationEndpoint','Authorization Endpoint','Authorization Endpoint','D','38f87d0c-70f4-4ea8-8695-9607854ba292')
;

-- Feb 17, 2021, 10:08:24 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214360,0,'Authorization Endpoint',200269,'AuthorizationEndpoint',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:23','YYYY-MM-DD HH24:MI:SS'),100,203454,'Y','N','D','Y','N','N','Y','a8ef10eb-c857-4e46-8ec5-da3396f96d18','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:24 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN AuthorizationEndpoint VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:24 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203455,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:24','YYYY-MM-DD HH24:MI:SS'),100,'TokenEndpoint','Token Endpoint','Token Endpoint','D','3130f4a3-0aec-42ab-8751-d075198d07ed')
;

-- Feb 17, 2021, 10:08:24 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214361,0,'Token Endpoint',200269,'TokenEndpoint',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:24','YYYY-MM-DD HH24:MI:SS'),100,203455,'Y','N','D','Y','N','N','Y','51b8ff7d-e1fc-4952-9c01-4abbe890ae09','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:24 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN TokenEndpoint VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:25 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203456,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:24','YYYY-MM-DD HH24:MI:SS'),100,'RevokeEndpoint','Revoke Endpoint','Revoke Endpoint','D','3e1d09e4-b397-4e1e-ab85-5b2b0a9e7216')
;

-- Feb 17, 2021, 10:08:25 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214362,0,'Revoke Endpoint',200269,'RevokeEndpoint',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:25','YYYY-MM-DD HH24:MI:SS'),100,203456,'Y','N','D','Y','N','N','Y','805ef934-ffdf-475e-ad0c-d0b6eaa114b8','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:25 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN RevokeEndpoint VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:26 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203457,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:25','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationType','Authorization Type','Authorization Type','D','ea546222-a3d0-43ad-a681-0ded362d5f25')
;

-- Feb 17, 2021, 10:08:26 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200184,'AD_AuthorizationType','L',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:26','YYYY-MM-DD HH24:MI:SS'),100,'D','N','841014f1-0242-4556-8506-3cd0678846e6')
;

-- Feb 17, 2021, 10:08:26 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200497,'OAuth2',200184,'OAuth2',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:26','YYYY-MM-DD HH24:MI:SS'),100,'D','ee3a6b03-f7fc-4bc1-8022-43ee69d35164')
;

-- Feb 17, 2021, 10:08:27 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200498,'SAML (not implemented yet)',200184,'SAML',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:26','YYYY-MM-DD HH24:MI:SS'),100,'D','33116e52-3591-4455-a4b5-581602cd06cb')
;

-- Feb 17, 2021, 10:08:27 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214363,0,'Authorization Type',200269,'AD_AuthorizationType',10,'N','N','Y','N','N',0,'N',17,200184,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:27','YYYY-MM-DD HH24:MI:SS'),100,203457,'Y','N','D','Y','N','N','Y','644d4efa-e313-4c15-b218-c2b689c13b0a','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:27 PM CET
ALTER TABLE AD_AuthorizationProvider ADD COLUMN AD_AuthorizationType VARCHAR(10) NOT NULL
;

-- Feb 17, 2021, 10:08:28 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201080,'70e62236-442c-4ee9-89a8-a929c08def15',TO_TIMESTAMP('2021-02-17 22:08:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AuthorizationProvider_Unq',TO_TIMESTAMP('2021-02-17 22:08:27','YYYY-MM-DD HH24:MI:SS'),100,200269,'N','Y','N','N','N')
;

-- Feb 17, 2021, 10:08:28 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201397,'586d5a0c-9cd2-4e41-9b7a-081368c3fde9',TO_TIMESTAMP('2021-02-17 22:08:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2021-02-17 22:08:28','YYYY-MM-DD HH24:MI:SS'),100,214349,201080,10)
;

-- Feb 17, 2021, 10:08:29 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201398,'7ec3ba11-51c6-4cba-9324-90c834007904',TO_TIMESTAMP('2021-02-17 22:08:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2021-02-17 22:08:28','YYYY-MM-DD HH24:MI:SS'),100,214357,201080,20)
;

-- Feb 17, 2021, 10:08:29 PM CET
CREATE UNIQUE INDEX AD_AuthorizationProvider_Unq ON AD_AuthorizationProvider (AD_Client_ID,Name)
;

-- Feb 17, 2021, 10:08:29 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200284,'Authorization Provider',200112,10,'Y',200269,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AuthorizationProvider.Name','N',0,'N','D','Y','Y','799b9ac5-e4bb-4cc6-aa8b-e39867f9d939','B','N','Y',0)
;

-- Feb 17, 2021, 10:08:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206548,'Authorization Provider',200284,214348,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fc3e16f3-0f6a-4bf3-881e-0a5518434af5','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206549,'AD_AuthorizationProvider_UU',200284,214356,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a4173af1-167b-43e2-9199-cd80e760b6a0','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206550,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200284,214349,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7f4c1f83-94a2-4001-9c13-277f9c27646a','Y',10,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206551,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200284,214350,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2266d5ce-a683-4449-b6e8-98e180a8c293','Y','N',4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206552,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200284,214357,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','63f07f23-6b2b-4e3e-8041-ef2ac2635a46','Y',20,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206553,'Authorization Type',200284,214363,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f3da9cde-bcd0-4a6f-ac6d-74e6632cedf9','Y',90,4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:32 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206554,'Description','Optional short description of the record','A description is limited to 255 characters.',200284,214353,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3c94836e-d30e-4e06-a274-c47d260a7e20','Y',30,1,5,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:32 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206555,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200284,214354,'Y',2000,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','67167089-6cbf-4e32-86b9-8177ceb05c81','Y',40,1,5,3,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:32 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206556,'Authorization Endpoint',200284,214360,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b7618afd-fe34-44e7-a32b-35c7d8ebbe51','Y',50,1,5,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:33 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206557,'Token Endpoint',200284,214361,'Y',2000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2ac4e4f8-1cd4-483d-af24-e1dc61d2b85f','Y',60,1,5,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:33 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206558,'Revoke Endpoint',200284,214362,'Y',2000,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2eea4d39-7db7-4e86-85a6-e0c16cf3a420','Y',70,1,5,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:33 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206559,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200284,214355,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','087893c1-c62e-40f1-885c-52990a9eda16','Y',80,2,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:34 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200270,'Authorization Scope Provider',200112,'AD_AuthorizationScopeProv',0,'6',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','7293d9bd-0ed2-4b15-8b77-4aca662852d2','N','N','N','N')
;

-- Feb 17, 2021, 10:08:34 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AuthorizationScopeProv',1000000,'N','N','Table AD_AuthorizationScopeProv','Y','Y',0,0,TO_TIMESTAMP('2021-02-17 22:08:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:34','YYYY-MM-DD HH24:MI:SS'),100,200339,'Y',1000000,1,200000,'b6429553-6ffd-438b-a682-3d345141b9a4')
;

-- Feb 17, 2021, 10:08:34 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203458,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:34','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationScopeProv_ID','Authorization Scope Provider','Authorization Scope Provider','D','52015c43-547c-427d-a3b7-83be4d3d0e7c')
;

-- Feb 17, 2021, 10:08:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214364,1,'Authorization Scope Provider',200270,'AD_AuthorizationScopeProv_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:34','YYYY-MM-DD HH24:MI:SS'),100,203458,'N','N','D','Y','N','N','Y','ce4a6d67-e083-4867-8107-2fb17e8fefac','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:35 PM CET
CREATE TABLE AD_AuthorizationScopeProv (AD_AuthorizationScopeProv_ID NUMERIC(10) NOT NULL, CONSTRAINT AD_AuthorizationScopeProv_Key PRIMARY KEY (AD_AuthorizationScopeProv_ID))
;

-- Feb 17, 2021, 10:08:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214365,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200270,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:35','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','d0ad0552-b98c-42b0-b192-0376f18202d4','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:35 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN AD_Client_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214366,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200270,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:35','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','3d283533-dbb7-4a10-aa8f-e4f8439c38e7','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:35 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214367,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200270,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:35','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','1b4f10d8-7a2a-4d8d-ab6c-6a5e532ecaa9','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:36 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:08:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214368,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200270,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:36','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','c324efcb-6a4a-4ff0-b077-f2ff4be44f4d','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:36 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214369,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200270,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:36','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','2e64c613-560d-4a7c-b195-b556b3bebf45','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:36 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Feb 17, 2021, 10:08:37 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203459,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:36','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationScopeProv_UU','AD_AuthorizationScopeProv_UU','AD_AuthorizationScopeProv_UU','D','dcfb0977-5d57-4337-8e08-cbb32b660301')
;

-- Feb 17, 2021, 10:08:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214370,1.00,'AD_AuthorizationScopeProv_UU',200270,'AD_AuthorizationScopeProv_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:37','YYYY-MM-DD HH24:MI:SS'),100,203459,'Y','N','D','Y','N','N','Y','3cface70-28a7-49f4-8fe7-b99eb82f0f9f','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:37 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN AD_AuthorizationScopeProv_UU VARCHAR(36) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:37 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD CONSTRAINT AD_AuthorizationScopeProvuuidx UNIQUE (AD_AuthorizationScopeProv_UU)
;

-- Feb 17, 2021, 10:08:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214371,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200270,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:37','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','839e4c20-f4ee-44b7-9cd3-4feed2366609','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:37 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:08:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214372,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200270,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:37','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','8ba6d57e-cb5b-402a-b50a-6e30df9fb659','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:38 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214373,0,'Authorization Provider',200270,'AD_AuthorizationProvider_ID',22,'N','Y','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:38','YYYY-MM-DD HH24:MI:SS'),100,203452,'N','N','D','Y','N','N','Y','7e788738-37d9-44f2-a2c7-516049f0be88','Y',0,'N','N','ADAuthorizationProvAuthScopePr','N','N')
;

-- Feb 17, 2021, 10:08:38 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN AD_AuthorizationProvider_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:39 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203460,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:38','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationScope','Authorization Scope','Authorization Scope','D','e2000206-b976-4f98-bd71-780e7dc4ab9c')
;

-- Feb 17, 2021, 10:08:39 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200185,'AD_AuthorizationScope','L',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:39','YYYY-MM-DD HH24:MI:SS'),100,'D','N','f91205eb-6b17-4e76-bbdd-0114f7492f44')
;

-- Feb 17, 2021, 10:08:39 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200499,'Calendar',200185,'Calendar',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:39','YYYY-MM-DD HH24:MI:SS'),100,'D','2d70e5ab-b291-44dc-b610-e4de4170e635')
;

-- Feb 17, 2021, 10:08:40 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200500,'EMail',200185,'EMail',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:39','YYYY-MM-DD HH24:MI:SS'),100,'D','d104581f-ad0b-41f2-9922-174d8e27487a')
;

-- Feb 17, 2021, 10:08:40 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200501,'Document',200185,'Document',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:40','YYYY-MM-DD HH24:MI:SS'),100,'D','b2c69b9e-c59d-4bec-8b2d-d871047a0904')
;

-- Feb 17, 2021, 10:08:40 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200502,'Profile',200185,'Profile',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:40','YYYY-MM-DD HH24:MI:SS'),100,'D','2961bff8-d875-4b01-84f2-1f311b41a15f')
;

-- Feb 17, 2021, 10:08:41 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200503,'Storage',200185,'Storage',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:40','YYYY-MM-DD HH24:MI:SS'),100,'D','df766e64-dad7-4970-a026-fa759e4de151')
;

-- Feb 17, 2021, 10:08:41 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214374,0,'Authorization Scope',200270,'AD_AuthorizationScope',10,'N','N','N','N','N',0,'N',17,200185,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:41','YYYY-MM-DD HH24:MI:SS'),100,203460,'Y','N','D','Y','N','N','Y','1ffdf668-2603-40a6-aec5-0d8783eccfbe','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:41 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN AD_AuthorizationScope VARCHAR(10) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:41 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203461,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:41','YYYY-MM-DD HH24:MI:SS'),100,'ScopeURL','Scope URL','Scope URL','D','f53fc784-530a-42da-a01b-593223ac32a5')
;

-- Feb 17, 2021, 10:08:42 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214375,0,'Scope URL',200270,'ScopeURL',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:41','YYYY-MM-DD HH24:MI:SS'),100,203461,'Y','N','D','Y','N','N','Y','5692b202-8995-4877-8d90-b13af89a0c41','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:42 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD COLUMN ScopeURL VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:42 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201081,'46598e5a-1c92-4c04-b163-0d5bca8c060c',TO_TIMESTAMP('2021-02-17 22:08:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AuthorizationScopeProv_Unq',TO_TIMESTAMP('2021-02-17 22:08:42','YYYY-MM-DD HH24:MI:SS'),100,200270,'N','Y','N','N','N')
;

-- Feb 17, 2021, 10:08:42 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201399,'d7733381-aa71-4f34-aef9-f084296f9260',TO_TIMESTAMP('2021-02-17 22:08:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2021-02-17 22:08:42','YYYY-MM-DD HH24:MI:SS'),100,214373,201081,10)
;

-- Feb 17, 2021, 10:08:43 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201400,'30376d07-3570-4811-b72b-25affedad0ca',TO_TIMESTAMP('2021-02-17 22:08:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2021-02-17 22:08:42','YYYY-MM-DD HH24:MI:SS'),100,214374,201081,20)
;

-- Feb 17, 2021, 10:08:43 PM CET
CREATE UNIQUE INDEX AD_AuthorizationScopeProv_Unq ON AD_AuthorizationScopeProv (AD_AuthorizationProvider_ID,AD_AuthorizationScope)
;

-- Feb 17, 2021, 10:08:43 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200285,'Authorization Scope Provider',200112,20,'Y',200270,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:43','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AuthorizationScopeProv.Created DESC','N',1,'N','D','Y','Y','c8a0af28-d20f-425d-a246-39ab83e77b01','B','N','Y',0)
;

-- Feb 17, 2021, 10:08:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206560,'Authorization Scope Provider',200285,214364,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2274598d-1a54-47c9-956f-f9a6d921fb72','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206561,'AD_AuthorizationScopeProv_UU',200285,214370,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5472631b-3d84-442a-b705-8f1b5bf8230d','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206562,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200285,214365,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e5d77c80-7443-492b-83e4-42973667e876','Y',10,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206563,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200285,214366,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','95eb285a-1841-4a11-88de-49caecb58dca','Y','N',4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206564,'Authorization Provider',200285,214373,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','48624b68-5677-4ddb-b49e-6f9c75676035','N',0,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206565,'Authorization Scope',200285,214374,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','230a6692-47f8-4abb-b176-34aa0f13fa1b','Y',20,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206566,'Scope URL',200285,214375,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b960a775-4fc2-449a-9864-fc63c36a9e27','Y',30,1,5,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:46 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206567,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200285,214369,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9b8b08d9-4d52-448b-96ab-ee6aff59d6aa','Y',40,2,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:46 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200113,'Authorization Credential',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:46','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','cfe9eae4-c1f4-40b3-977c-46de7af46fc7')
;

-- Feb 17, 2021, 10:08:46 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200271,'Authorization Credential',200113,'AD_AuthorizationCredential',0,'6',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','5c56edc6-ac54-4d9e-a7f7-dd0a59cb1582','N','N','N','N')
;

-- Feb 17, 2021, 10:08:47 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AuthorizationCredential',1000000,'N','N','Table AD_AuthorizationCredential','Y','Y',0,0,TO_TIMESTAMP('2021-02-17 22:08:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:46','YYYY-MM-DD HH24:MI:SS'),100,200340,'Y',1000000,1,200000,'a7375df1-0853-4c13-83aa-06165a834541')
;

-- Feb 17, 2021, 10:08:47 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203462,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:47','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationCredential_ID','Authorization Credential','Authorization Credential','D','c93879c8-8a5f-49aa-ad38-bb6ba0d388ae')
;

-- Feb 17, 2021, 10:08:47 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214376,1,'Authorization Credential',200271,'AD_AuthorizationCredential_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:47','YYYY-MM-DD HH24:MI:SS'),100,203462,'N','N','D','Y','N','N','Y','2653d1d9-6834-47d3-9404-8fa3904aae5e','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:47 PM CET
CREATE TABLE AD_AuthorizationCredential (AD_AuthorizationCredential_ID NUMERIC(10) NOT NULL, CONSTRAINT AD_AuthorizationCredential_Key PRIMARY KEY (AD_AuthorizationCredential_ID))
;

-- Feb 17, 2021, 10:08:48 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214377,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200271,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:47','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','760b667f-b3ab-4d01-9fea-6b19a421b860','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:48 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AD_Client_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:48 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214378,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200271,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:48','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','81fa31cc-6ec6-4952-b285-4c96599d8788','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:48 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:48 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214379,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200271,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:48','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','783c3973-6e82-40b8-9e80-f710f0e7adec','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:48 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:08:49 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214380,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200271,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:49','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','59438b4a-9863-442a-928b-ba66006697c6','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:49 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:49 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214381,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200271,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:49','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','727cb8bd-a921-4528-b4f2-517095166cf4','Y','N','N','N','N')
;

-- Feb 17, 2021, 10:08:49 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN Help VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:50 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214382,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200271,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:49','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','d0d5d079-ccfd-4679-8e39-a11d0cbd6151','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:50 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Feb 17, 2021, 10:08:50 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203463,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:50','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationCredential_UU','AD_AuthorizationCredential_UU','AD_AuthorizationCredential_UU','D','4ad98046-48ec-4c40-8d6a-de618e50a99b')
;

-- Feb 17, 2021, 10:08:50 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214383,1.00,'AD_AuthorizationCredential_UU',200271,'AD_AuthorizationCredential_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:50','YYYY-MM-DD HH24:MI:SS'),100,203463,'Y','N','D','Y','N','N','Y','8e1432d6-8025-44e3-8e96-e162399971aa','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:50 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AD_AuthorizationCredential_UU VARCHAR(36) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:50 PM CET
ALTER TABLE AD_AuthorizationCredential ADD CONSTRAINT AD_AuthorizationCredentiauuidx UNIQUE (AD_AuthorizationCredential_UU)
;

-- Feb 17, 2021, 10:08:51 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214384,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200271,'Name',60,'N','N','Y','N','Y',1,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:50','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','3d062850-430e-4213-a1b1-2da9de72d7e9','Y',20,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:51 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN Name VARCHAR(60) NOT NULL
;

-- Feb 17, 2021, 10:08:51 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214385,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200271,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:51','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','852cff9b-1ecf-4cc7-bfc7-2484ee6a3adf','N','N','N','N','N')
;

-- Feb 17, 2021, 10:08:51 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:08:51 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214386,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200271,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:51','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','dacec5a8-d05c-4971-a04d-3182bb7c3ccc','N','N','N','D','N')
;

-- Feb 17, 2021, 10:08:51 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:52 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203464,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:51','YYYY-MM-DD HH24:MI:SS'),100,'AuthorizationClientId','Authorization client-id','Authorization client-id','D','331c5216-fbb1-48e7-93d0-a2a1c6476604')
;

-- Feb 17, 2021, 10:08:52 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214387,0,'Authorization client-id',200271,'AuthorizationClientId',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:52','YYYY-MM-DD HH24:MI:SS'),100,203464,'Y','N','D','Y','N','N','Y','02f3d716-5461-4455-b6c5-85a9421862da','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:52 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AuthorizationClientId VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:52 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203465,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:52','YYYY-MM-DD HH24:MI:SS'),100,'AuthorizationClientSecret','Authorization client-secret','Authorization client-secret','D','57617b5b-3a84-4d75-8c42-df1872e832d8')
;

-- Feb 17, 2021, 10:08:53 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214388,0,'Authorization client-secret',200271,'AuthorizationClientSecret',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:52','YYYY-MM-DD HH24:MI:SS'),100,203465,'Y','N','D','Y','N','N','Y','61a760de-e6f5-40ce-9ea5-9690ae5d37c6','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:53 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AuthorizationClientSecret VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:53 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203466,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:53','YYYY-MM-DD HH24:MI:SS'),100,'AuthorizationRedirectURL','Authorization Redirect URL','Authorization Redirect URL','D','6e7ecfcb-a0a6-4be4-ba9a-fcbbe3481186')
;

-- Feb 17, 2021, 10:08:53 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214389,0,'Authorization Redirect URL',200271,'AuthorizationRedirectURL',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:53','YYYY-MM-DD HH24:MI:SS'),100,203466,'Y','N','D','Y','N','N','Y','76cd1018-d40e-41c8-97a9-affa8047c996','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:53 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AuthorizationRedirectURL VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:08:54 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214390,0,'Authorization Provider',200271,'AD_AuthorizationProvider_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:53','YYYY-MM-DD HH24:MI:SS'),100,203452,'Y','N','D','Y','N','N','Y','300c8d97-fdf2-4240-85de-b745350308ad','Y',0,'N','N','ADAuthorizationProvider_ADAuth','N','N')
;

-- Feb 17, 2021, 10:08:54 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AD_AuthorizationProvider_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:08:54 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201082,'96ad829e-c933-4ae8-b224-c9f59f7ee65c',TO_TIMESTAMP('2021-02-17 22:08:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AuthorizationCredential_Unq',TO_TIMESTAMP('2021-02-17 22:08:54','YYYY-MM-DD HH24:MI:SS'),100,200271,'N','Y','N','N','N')
;

-- Feb 17, 2021, 10:08:54 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201401,'0a2e739d-ae2b-4bba-924a-82bc93d2470c',TO_TIMESTAMP('2021-02-17 22:08:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2021-02-17 22:08:54','YYYY-MM-DD HH24:MI:SS'),100,214377,201082,10)
;

-- Feb 17, 2021, 10:08:55 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201402,'6fcd15aa-12df-47e5-9b5a-c4bb41f447b5',TO_TIMESTAMP('2021-02-17 22:08:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2021-02-17 22:08:54','YYYY-MM-DD HH24:MI:SS'),100,214384,201082,20)
;

-- Feb 17, 2021, 10:08:55 PM CET
CREATE UNIQUE INDEX AD_AuthorizationCredential_Unq ON AD_AuthorizationCredential (AD_Client_ID,Name)
;

-- Feb 17, 2021, 10:08:55 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200286,'Authorization Credential',200113,10,'Y',200271,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AuthorizationCredential.Name','N',0,'N','D','Y','Y','4be92250-50da-424d-979c-5acee0854f56','B','N','Y',0)
;

-- Feb 17, 2021, 10:08:55 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206568,'Authorization Credential',200286,214376,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','72b97638-6cc9-4f31-833f-e8799e5547dd','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:56 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206569,'AD_AuthorizationCredential_UU',200286,214383,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','59bd1cef-01f1-4066-ada7-2a98ee86e66c','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:56 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206570,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200286,214377,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','34629e78-546b-4fba-93c3-d24045ca8ef4','Y',10,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:56 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206571,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200286,214378,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','df40dee4-216e-4df2-807a-5b37002984ee','Y','N',4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:57 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206572,'Authorization Provider',200286,214390,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1ac4b31a-6cd5-4aa0-8ba2-0e8370a0a9c8','Y',80,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:57 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206573,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200286,214384,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f6cee96e-bc99-4766-a7e1-a6b4d4ad51ff','Y',20,1,5,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:57 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206574,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200286,214381,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','07390d0b-6f8f-4b2e-81a6-a3aa13dc5943','Y',30,1,5,3,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:58 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,ObscureType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206575,'Authorization client-id',200286,214387,'Y',2000,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','A44','ab4f466e-0fee-48bf-871d-5be9b5068fa6','Y',40,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:58 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,ObscureType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206576,'Authorization client-secret',200286,214388,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','A44','ea045325-bc74-44ab-8cc6-b94e0af287a2','Y',50,4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:58 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206577,'Authorization Redirect URL',200286,214389,'Y',2000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a44d63c0-fa16-4b40-ad84-df39d62f114c','Y',60,1,5,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:59 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206578,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200286,214382,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f5a8d6e4-aca0-4896-bf4d-043de11c7c44','Y',70,2,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:08:59 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200272,'Authorization Account',200113,'AD_AuthorizationAccount',0,'6',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','0f03c44c-3a05-4710-abc5-a01d52399906','N','N','N','N')
;

-- Feb 17, 2021, 10:08:59 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AuthorizationAccount',1000000,'N','N','Table AD_AuthorizationAccount','Y','Y',0,0,TO_TIMESTAMP('2021-02-17 22:08:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:59','YYYY-MM-DD HH24:MI:SS'),100,200341,'Y',1000000,1,200000,'bf4fad0d-f13e-46b7-b438-806c0a0ed451')
;

-- Feb 17, 2021, 10:09:00 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203467,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:08:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:08:59','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationAccount_ID','Authorization Account','Authorization Account','D','8b9dab65-f824-4541-8913-d5627fe3f912')
;

-- Feb 17, 2021, 10:09:00 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214391,1,'Authorization Account',200272,'AD_AuthorizationAccount_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:00','YYYY-MM-DD HH24:MI:SS'),100,203467,'N','N','D','Y','N','N','Y','fa2b29e1-64e4-4341-804b-e57539711474','N','N','N','N','N')
;

-- Feb 17, 2021, 10:09:00 PM CET
CREATE TABLE AD_AuthorizationAccount (AD_AuthorizationAccount_ID NUMERIC(10) NOT NULL, CONSTRAINT AD_AuthorizationAccount_Key PRIMARY KEY (AD_AuthorizationAccount_ID))
;

-- Feb 17, 2021, 10:09:00 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214392,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200272,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:00','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','e67e7b59-4212-4c5a-9022-3dd7458c8d82','N','N','N','D','N')
;

-- Feb 17, 2021, 10:09:00 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AD_Client_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:09:01 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214393,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200272,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:01','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','e9109d90-9645-4127-bbe7-a1cac9996e47','N','N','N','D','N')
;

-- Feb 17, 2021, 10:09:01 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:09:01 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214394,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200272,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:01','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','b8178862-c85d-4ef0-9173-53545c9e26b3','N','N','N','N','N')
;

-- Feb 17, 2021, 10:09:01 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:09:02 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214395,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200272,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:01','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','c3780a4e-24b7-4b42-8bbf-e0d2e2745cb6','N','N','N','D','N')
;

-- Feb 17, 2021, 10:09:02 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:09:02 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214396,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200272,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:02','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','851a4847-a0d6-4f45-9f5b-82ec0756848e','Y','N','N','N','N')
;

-- Feb 17, 2021, 10:09:02 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN Help VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:02 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214397,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200272,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:02','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','37cfdfb9-8011-468b-862e-cf64df6de84b','N','N','N','N','N')
;

-- Feb 17, 2021, 10:09:02 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Feb 17, 2021, 10:09:03 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203468,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:02','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationAccount_UU','AD_AuthorizationAccount_UU','AD_AuthorizationAccount_UU','D','b80b9945-c982-485f-88bc-bd0a70a5b6c5')
;

-- Feb 17, 2021, 10:09:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214398,1.00,'AD_AuthorizationAccount_UU',200272,'AD_AuthorizationAccount_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:03','YYYY-MM-DD HH24:MI:SS'),100,203468,'Y','N','D','Y','N','N','Y','a22ab103-28cf-49e0-a1bc-298ad8f3fd18','N','N','N','N','N')
;

-- Feb 17, 2021, 10:09:03 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AD_AuthorizationAccount_UU VARCHAR(36) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:03 PM CET
ALTER TABLE AD_AuthorizationAccount ADD CONSTRAINT AD_AuthorizationAccount_UU_idx UNIQUE (AD_AuthorizationAccount_UU)
;

-- Feb 17, 2021, 10:09:04 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214399,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200272,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:03','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','42a52024-6ed0-4e75-a25d-2b94221855ef','N','N','N','N','N')
;

-- Feb 17, 2021, 10:09:04 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Feb 17, 2021, 10:09:04 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214400,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200272,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:04','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','a478942e-ab60-47a0-980b-03a22686cc8a','N','N','N','D','N')
;

-- Feb 17, 2021, 10:09:04 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Feb 17, 2021, 10:09:04 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214401,0,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200272,'EMail',200,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:04','YYYY-MM-DD HH24:MI:SS'),100,881,'Y','N','D','Y','N','N','Y','facc12a6-d518-4880-bd89-6a3b5a101e06','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:04 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN EMail VARCHAR(200) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:05 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203469,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:04','YYYY-MM-DD HH24:MI:SS'),100,'AccessToken','Access Token','Access Token','D','7d2ad5fb-276a-4de1-831a-697e55964f5b')
;

-- Feb 17, 2021, 10:09:05 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214402,0,'Access Token',200272,'AccessToken',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:05','YYYY-MM-DD HH24:MI:SS'),100,203469,'Y','N','D','Y','N','N','Y','11133932-9aea-4ed1-bef7-43830f2d45e2','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:05 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AccessToken VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:06 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203470,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:05','YYYY-MM-DD HH24:MI:SS'),100,'RefreshToken','Refresh Token','Refresh Token','D','5469ddd7-b1d3-4e7b-8989-9208de560fd2')
;

-- Feb 17, 2021, 10:09:06 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214403,0,'Refresh Token',200272,'RefreshToken',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:06','YYYY-MM-DD HH24:MI:SS'),100,203470,'Y','N','D','Y','N','N','Y','755d702e-3c1e-4682-8e88-99edf740bc90','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:06 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN RefreshToken VARCHAR(2000) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:06 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203471,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:06','YYYY-MM-DD HH24:MI:SS'),100,'ExpireInSeconds','Expire in Seconds','Expire in Seconds','D','d30f9b5f-e032-4b07-a481-1601439d9f09')
;

-- Feb 17, 2021, 10:09:07 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214404,0,'Expire in Seconds',200272,'ExpireInSeconds',10,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:06','YYYY-MM-DD HH24:MI:SS'),100,203471,'Y','N','D','Y','N','N','Y','57a7f4e0-3abf-4849-a3bc-4f9b1cb4f6b2','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:07 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN ExpireInSeconds NUMERIC DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:07 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214405,0,'Authorization Scope',200272,'AD_AuthorizationScope',10,'N','N','N','N','N',0,'N',17,200185,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:07','YYYY-MM-DD HH24:MI:SS'),100,203460,'Y','N','D','Y','N','N','Y','94712c33-b4d0-47db-8fb0-c6745b1e89df','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:07 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AD_AuthorizationScope VARCHAR(10) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:07 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203472,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:07','YYYY-MM-DD HH24:MI:SS'),100,'AccessTokenTimestamp','Access Token Timestamp','Access Token Timestamp','D','7002d1b3-464f-4093-87f1-1f6acd5bd3db')
;

-- Feb 17, 2021, 10:09:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214406,0,'Access Token Timestamp',200272,'AccessTokenTimestamp',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:07','YYYY-MM-DD HH24:MI:SS'),100,203472,'Y','N','D','Y','N','N','Y','fe8b6ff3-69b5-44ad-a779-ff0ffde619e9','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:08 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AccessTokenTimestamp TIMESTAMP DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:08 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203473,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:08','YYYY-MM-DD HH24:MI:SS'),100,'IsAuthorized','Authorized','Authorized','D','4b9224f8-7886-4a81-b3a6-bbbd00e94eda')
;

-- Feb 17, 2021, 10:09:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214407,0,'Authorized',200272,'IsAuthorized','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:08','YYYY-MM-DD HH24:MI:SS'),100,203473,'Y','N','D','Y','N','N','Y','81371790-4502-4e2c-858e-0a108489b218','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:08 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN IsAuthorized CHAR(1) DEFAULT 'N' CHECK (IsAuthorized IN ('Y','N')) NOT NULL
;

-- Feb 17, 2021, 10:09:09 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214408,0,'Authorization Credential',200272,'AD_AuthorizationCredential_ID',22,'N','Y','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:08','YYYY-MM-DD HH24:MI:SS'),100,203462,'N','N','D','Y','N','N','Y','4128da17-f2fc-4d35-a51d-9f9ebe01b231','Y',0,'N','N','ADAuthorizationCredential_ADAu','N','N')
;

-- Feb 17, 2021, 10:09:09 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AD_AuthorizationCredential_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:09 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203474,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:09','YYYY-MM-DD HH24:MI:SS'),100,'IsAccessRevoked','Access Revoked','Access Revoked','D','a589c100-4e96-4c1a-8fe6-b6b114fd2c52')
;

-- Feb 17, 2021, 10:09:09 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214409,0,'Access Revoked',200272,'IsAccessRevoked','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:09','YYYY-MM-DD HH24:MI:SS'),100,203474,'Y','N','D','Y','N','N','Y','d4315491-f6be-4bc6-b0b9-cacffab7c53b','Y',0,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:09 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN IsAccessRevoked CHAR(1) DEFAULT 'N' CHECK (IsAccessRevoked IN ('Y','N')) NOT NULL
;

-- Feb 17, 2021, 10:09:10 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214410,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200272,'AD_User_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:10','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','Y','N','N','Y','83c39951-093c-46df-952f-3bb310a552c8','Y',0,'N','N','ADUser_ADAuthorizationAccount','N','N')
;

-- Feb 17, 2021, 10:09:10 PM CET
ALTER TABLE AD_AuthorizationAccount ADD COLUMN AD_User_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2021, 10:09:10 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200287,'Authorization Account',200113,20,'Y',200272,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AuthorizationAccount.Created DESC','N',1,'N','D','Y','Y','52886d52-9c96-4aa4-ba57-ddb185e73a7b','B','N','Y',0)
;

-- Feb 17, 2021, 10:09:11 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206579,'Authorization Account',200287,214391,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f9f58dcb-0c1b-417e-8e2a-d97ae5ae1160','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:11 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206580,'AD_AuthorizationAccount_UU',200287,214398,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','af8c5369-96fc-44a9-a87d-28b7cad1922e','N',1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:11 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206581,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200287,214392,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d51d8648-8f98-461c-b956-05c66d5f9b01','N',0,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206582,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200287,214393,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a2ee58d7-1275-44b9-9027-6b362d93de74','Y','N',4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206583,'Authorization Credential',200287,214408,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e5fe92a9-3f3a-4ce7-85ba-c23b0e7d79ca','N',0,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206584,'Authorization Scope',200287,214405,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cdc078c3-f9e0-4376-8d0f-749035fa2a3f','Y',50,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206585,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200287,214401,'Y',200,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d0104dc4-6aea-4208-8232-772ccc7bb3dd','Y',10,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206586,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200287,214410,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b64b7588-4f08-4f0f-9438-83db40688b94','Y',60,4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,ObscureType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206587,'Access Token',200287,214402,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','A44','8611545d-d5d8-4821-96d3-f045de5ec54d','Y',20,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:14 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,ObscureType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206588,'Refresh Token',200287,214403,'Y',2000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','A44','9a4886dd-219e-4dac-a6b3-e6170c4b9482','Y',30,4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:14 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206589,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200287,214396,'Y',2000,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','056dd420-10ff-417f-95c1-89389cb627ad','Y',100,1,5,3,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:14 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206590,'Expire in Seconds',200287,214404,'Y',10,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','508b4488-760e-4404-aea7-636a3094020a','Y',40,1,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:15 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206591,'Access Token Timestamp',200287,214406,'Y',7,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1dcae3db-6d89-4454-9945-baf7ffd87201','Y',70,4,2,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:15 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206592,'Authorized',200287,214407,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','139aefa2-0765-4588-a237-477bda1551e3','Y',80,2,1,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:15 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206593,'Access Revoked',200287,214409,'Y',1,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4a82f6b7-6d68-46dd-9bcc-7e05a247ee7f','Y',90,3,1,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:16 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206594,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200287,214397,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fec92423-3e9d-4c77-bdf7-992c710fa0bc','Y',110,6,1,1,'N','N','N','N')
;

-- Feb 17, 2021, 10:09:16 PM CET
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200016,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:16','YYYY-MM-DD HH24:MI:SS'),100,'Add Authorization Mail Account','org.adempiere.webui.apps.form.AddAuthorizationForm','7','D','N','0f52aecd-dc50-4ca6-b4db-4287d1c8c9e5')
;

-- Feb 17, 2021, 10:09:17 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200179,'Authorization Provider','W',200112,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','2f018e36-c19b-4572-91f2-0441e33c00d8')
;

-- Feb 17, 2021, 10:09:17 PM CET
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200178,1, 10, 200179)
;

-- Feb 17, 2021, 10:09:17 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200180,'Authorization Credential','W',200113,0,0,'Y',TO_TIMESTAMP('2021-02-17 22:09:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-17 22:09:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','a7f142fe-2236-4ce9-a819-4e0971681474')
;

-- Feb 17, 2021, 10:09:17 PM CET
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200178,2, 10, 200180)
;

-- Feb 17, 2021, 10:09:17 PM CET
ALTER TABLE AD_AuthorizationScopeProv ADD CONSTRAINT ADAuthorizationProvAuthScopePr FOREIGN KEY (AD_AuthorizationProvider_ID) REFERENCES ad_authorizationprovider(ad_authorizationprovider_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2021, 10:09:18 PM CET
ALTER TABLE AD_AuthorizationCredential ADD CONSTRAINT ADAuthorizationProvider_ADAuth FOREIGN KEY (AD_AuthorizationProvider_ID) REFERENCES ad_authorizationprovider(ad_authorizationprovider_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2021, 10:09:18 PM CET
ALTER TABLE AD_AuthorizationAccount ADD CONSTRAINT ADAuthorizationCredential_ADAu FOREIGN KEY (AD_AuthorizationCredential_ID) REFERENCES ad_authorizationcredential(ad_authorizationcredential_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2021, 10:09:18 PM CET
ALTER TABLE AD_AuthorizationAccount ADD CONSTRAINT ADUser_ADAuthorizationAccount FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2021, 10:09:36 PM CET
INSERT INTO AD_AuthorizationProvider (AD_AuthorizationProvider_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,AD_AuthorizationProvider_UU,Name,Updated,UpdatedBy,AuthorizationEndpoint,TokenEndpoint,RevokeEndpoint,AD_AuthorizationType) VALUES (200000,0,0,TO_TIMESTAMP('2021-02-17 22:09:36','YYYY-MM-DD HH24:MI:SS'),100,'Y','87680f3c-673f-4444-8f9c-da6cdcd553ae','Google',TO_TIMESTAMP('2021-02-17 22:09:36','YYYY-MM-DD HH24:MI:SS'),100,'https://accounts.google.com/o/oauth2/auth','https://accounts.google.com/o/oauth2/token','https://accounts.google.com/o/oauth2/revoke','OAuth2')
;

-- Feb 17, 2021, 10:09:37 PM CET
INSERT INTO AD_AuthorizationScopeProv (AD_AuthorizationScopeProv_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,AD_AuthorizationScopeProv_UU,Updated,UpdatedBy,AD_AuthorizationProvider_ID,AD_AuthorizationScope,ScopeURL) VALUES (200000,0,0,TO_TIMESTAMP('2021-02-17 22:09:36','YYYY-MM-DD HH24:MI:SS'),100,'Y','1ccabfa1-2687-4ea5-bf19-b88a9868fab7',TO_TIMESTAMP('2021-02-17 22:09:36','YYYY-MM-DD HH24:MI:SS'),100,200000,'Document','https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/spreadsheets profile email')
;

-- Feb 17, 2021, 10:09:37 PM CET
INSERT INTO AD_AuthorizationScopeProv (AD_AuthorizationScopeProv_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,AD_AuthorizationScopeProv_UU,Updated,UpdatedBy,AD_AuthorizationProvider_ID,AD_AuthorizationScope,ScopeURL) VALUES (200001,0,0,TO_TIMESTAMP('2021-02-17 22:09:37','YYYY-MM-DD HH24:MI:SS'),100,'Y','6ad22e9b-d78f-4964-8021-25870606d8c1',TO_TIMESTAMP('2021-02-17 22:09:37','YYYY-MM-DD HH24:MI:SS'),100,200000,'EMail','https://mail.google.com/ email')
;

-- Feb 24, 2021, 7:23:08 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203476,0,0,'Y',TO_TIMESTAMP('2021-02-24 19:22:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 19:22:52','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationScopeList','Scope List',NULL,NULL,'Scope List','D','47d45601-9646-48ff-8493-6f9eb11e1b8a')
;

-- Feb 24, 2021, 7:23:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214414,0,'Scope List',200271,'AD_AuthorizationScopeList',2000,'N','N','N','N','N',0,'N',200161,200185,0,0,'Y',TO_TIMESTAMP('2021-02-24 19:23:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 19:23:35','YYYY-MM-DD HH24:MI:SS'),100,203476,'Y','N','D','N','N','N','Y','9c442e52-168b-4d66-a9b4-725e9fcf2494','Y',0,'N','N','N')
;

-- Feb 24, 2021, 7:23:40 PM CET
ALTER TABLE AD_AuthorizationCredential ADD COLUMN AD_AuthorizationScopeList VARCHAR(2000) DEFAULT NULL 
;

-- Feb 24, 2021, 7:23:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206599,'Scope List',200286,214414,'Y',2000,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-24 19:23:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 19:23:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c769cadd-4c53-4934-a7d0-277f42691551','Y',90,5)
;

-- Feb 24, 2021, 7:24:39 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-24 19:24:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206599
;

-- Feb 24, 2021, 7:24:39 PM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-24 19:24:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206573
;

-- Feb 24, 2021, 7:24:39 PM CET
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-24 19:24:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206574
;

-- Feb 24, 2021, 7:24:39 PM CET
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-24 19:24:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206575
;

-- Feb 24, 2021, 7:24:39 PM CET
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-24 19:24:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206576
;

-- Feb 24, 2021, 7:24:39 PM CET
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-24 19:24:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206577
;

-- Feb 24, 2021, 7:24:39 PM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-24 19:24:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206578
;

-- Feb 24, 2021, 7:34:46 PM CET
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200144,'AD_AuthorizationScope From Provider','S','AD_Ref_List.Value IN (SELECT asp.AD_AuthorizationScope FROM AD_AuthorizationScopeProv asp
JOIN AD_AuthorizationProvider ap ON (asp.AD_AuthorizationProvider_ID=ap.AD_AuthorizationProvider_ID AND ap.IsActive=''Y'')
WHERE asp.AD_AuthorizationProvider_ID=@AD_AuthorizationProvider_ID@ AND asp.IsActive=''Y'')',0,0,'Y',TO_TIMESTAMP('2021-02-24 19:34:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 19:34:46','YYYY-MM-DD HH24:MI:SS'),100,'D','8f855e4c-4308-4a85-b1f7-29101201a632')
;

-- Feb 24, 2021, 7:37:22 PM CET
UPDATE AD_Column SET AD_Val_Rule_ID=200144,Updated=TO_TIMESTAMP('2021-02-24 19:37:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214414
;

-- Feb 24, 2021, 9:08:17 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-24 21:08:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214414
;

-- Feb 24, 2021, 9:08:19 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AD_AuthorizationScopeList','VARCHAR(2000)',null,null)
;

-- Feb 24, 2021, 9:08:19 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AD_AuthorizationScopeList',null,'NOT NULL',null)
;

-- Feb 24, 2021, 9:10:42 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Grant access to this application from your account',0,0,'Y',TO_TIMESTAMP('2021-02-24 21:10:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 21:10:42','YYYY-MM-DD HH24:MI:SS'),100,200660,'Authorization_Grant_Access','D','d6f7d416-3344-413e-9c01-f32bf077f114')
;

-- Feb 24, 2021, 9:12:20 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Authorization request failed or it was aborted by user',0,0,'Y',TO_TIMESTAMP('2021-02-24 21:12:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 21:12:19','YYYY-MM-DD HH24:MI:SS'),100,200661,'Authorization_Fail','D','24bfe89b-d5e1-454e-9037-7262fdfb48d8')
;

-- Feb 24, 2021, 9:14:08 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Application now has access to your account {0}',0,0,'Y',TO_TIMESTAMP('2021-02-24 21:14:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 21:14:08','YYYY-MM-DD HH24:MI:SS'),100,200662,'Authorization_Access_OK','D','45d40448-a30a-4139-bcda-12aebbce70a7')
;

-- Feb 24, 2021, 9:14:59 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Access to your account {0} have been previously granted to this application',0,0,'Y',TO_TIMESTAMP('2021-02-24 21:14:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-24 21:14:59','YYYY-MM-DD HH24:MI:SS'),100,200663,'Authorization_Access_Previous','D','007f49dc-603f-4fa5-a91f-21203e675465')
;

-- Feb 26, 2021, 9:42:27 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2021-02-26 21:42:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214402
;

-- Feb 26, 2021, 9:42:29 PM CET
INSERT INTO t_alter_column values('ad_authorizationaccount','AccessToken','VARCHAR(4000)',null,'NULL')
;

-- Feb 26, 2021, 9:42:38 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2021-02-26 21:42:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214403
;

-- Feb 26, 2021, 9:42:39 PM CET
INSERT INTO t_alter_column values('ad_authorizationaccount','RefreshToken','VARCHAR(4000)',null,'NULL')
;

-- Feb 26, 2021, 9:43:14 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-26 21:43:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214360
;

-- Feb 26, 2021, 9:43:15 PM CET
INSERT INTO t_alter_column values('ad_authorizationprovider','AuthorizationEndpoint','VARCHAR(2000)',null,null)
;

-- Feb 26, 2021, 9:43:15 PM CET
INSERT INTO t_alter_column values('ad_authorizationprovider','AuthorizationEndpoint',null,'NOT NULL',null)
;

-- Feb 26, 2021, 9:43:23 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-26 21:43:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214361
;

-- Feb 26, 2021, 9:43:24 PM CET
INSERT INTO t_alter_column values('ad_authorizationprovider','TokenEndpoint','VARCHAR(2000)',null,null)
;

-- Feb 26, 2021, 9:43:24 PM CET
INSERT INTO t_alter_column values('ad_authorizationprovider','TokenEndpoint',null,'NOT NULL',null)
;

-- Feb 26, 2021, 9:43:47 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-26 21:43:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214375
;

-- Feb 26, 2021, 9:43:49 PM CET
INSERT INTO t_alter_column values('ad_authorizationscopeprov','ScopeURL','VARCHAR(2000)',null,null)
;

-- Feb 26, 2021, 9:43:49 PM CET
INSERT INTO t_alter_column values('ad_authorizationscopeprov','ScopeURL',null,'NOT NULL',null)
;

-- Feb 26, 2021, 9:44:00 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-26 21:44:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214374
;

-- Feb 26, 2021, 9:44:01 PM CET
INSERT INTO t_alter_column values('ad_authorizationscopeprov','AD_AuthorizationScope','VARCHAR(10)',null,null)
;

-- Feb 26, 2021, 9:44:01 PM CET
INSERT INTO t_alter_column values('ad_authorizationscopeprov','AD_AuthorizationScope',null,'NOT NULL',null)
;

-- Feb 26, 2021, 9:44:22 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-26 21:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214387
;

-- Feb 26, 2021, 9:44:24 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AuthorizationClientId','VARCHAR(2000)',null,null)
;

-- Feb 26, 2021, 9:44:24 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AuthorizationClientId',null,'NOT NULL',null)
;

-- Feb 26, 2021, 9:44:28 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-26 21:44:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214388
;

-- Feb 26, 2021, 9:44:30 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AuthorizationClientSecret','VARCHAR(2000)',null,null)
;

-- Feb 26, 2021, 9:44:30 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AuthorizationClientSecret',null,'NOT NULL',null)
;

-- Feb 26, 2021, 9:44:38 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2021-02-26 21:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214389
;

-- Feb 26, 2021, 9:44:39 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AuthorizationRedirectURL','VARCHAR(2000)',null,null)
;

-- Feb 26, 2021, 9:44:39 PM CET
INSERT INTO t_alter_column values('ad_authorizationcredential','AuthorizationRedirectURL',null,'NOT NULL',null)
;

-- Feb 26, 2021, 9:45:03 PM CET
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2021-02-26 21:45:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214387
;

-- Feb 26, 2021, 9:45:11 PM CET
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2021-02-26 21:45:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214388
;

-- Feb 26, 2021, 9:45:29 PM CET
UPDATE AD_Field SET IsEncrypted='Y', ObscureType=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-26 21:45:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206576
;

-- Feb 26, 2021, 9:46:06 PM CET
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2021-02-26 21:46:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214402
;

-- Feb 26, 2021, 9:46:15 PM CET
UPDATE AD_Field SET IsEncrypted='Y', ObscureType=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-26 21:46:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206587
;

-- Feb 26, 2021, 9:46:27 PM CET
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2021-02-26 21:46:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214403
;

-- Feb 26, 2021, 9:46:38 PM CET
UPDATE AD_Field SET IsEncrypted='Y', ObscureType=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-26 21:46:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206588
;

-- Feb 26, 2021, 10:40:43 PM CET
INSERT INTO AD_AuthorizationProvider (AD_AuthorizationProvider_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,AD_AuthorizationProvider_UU,Name,Updated,UpdatedBy,AuthorizationEndpoint,TokenEndpoint,AD_AuthorizationType) VALUES (200001,0,0,TO_TIMESTAMP('2021-02-26 22:40:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','7d5d231e-121a-4ef5-912f-fefb7960fb5b','Microsoft',TO_TIMESTAMP('2021-02-26 22:40:42','YYYY-MM-DD HH24:MI:SS'),100,'https://login.microsoftonline.com/common/oauth2/v2.0/authorize','https://login.microsoftonline.com/common/oauth2/v2.0/token','OAuth2')
;

-- Feb 26, 2021, 10:40:56 PM CET
INSERT INTO AD_AuthorizationScopeProv (AD_AuthorizationScopeProv_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,AD_AuthorizationScopeProv_UU,Updated,UpdatedBy,AD_AuthorizationProvider_ID,AD_AuthorizationScope,ScopeURL) VALUES (200002,0,0,TO_TIMESTAMP('2021-02-26 22:40:56','YYYY-MM-DD HH24:MI:SS'),100,'Y','34a26d19-85f3-44af-9df6-57883161b076',TO_TIMESTAMP('2021-02-26 22:40:56','YYYY-MM-DD HH24:MI:SS'),100,200001,'EMail','https://outlook.office.com/mail.read https://outlook.office.com/mail.send https://outlook.office.com/SMTP.Send https://outlook.office.com/IMAP.AccessAsUser.All email openid offline_access')
;

-- Mar 2, 2021, 8:44:54 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200128,0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:53','YYYY-MM-DD HH24:MI:SS'),100,'Add Authorization Mail Account','N','AddAuthorizationProcess','N','org.compiere.process.AddAuthorizationProcess','7','D',7,7,'N','Y','N','c6ba87ce-aa65-4895-b156-5385dfcc6164','P')
;

-- Mar 2, 2021, 8:44:54 PM CET
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200145,'AD_AuthorizationScope Configured','S','AD_Ref_List.Value IN (
SELECT DISTINCT asp.AD_AuthorizationScope
FROM AD_AuthorizationScopeProv asp
WHERE asp.IsActive=''Y''
  AND (''0''=''@+SCOPE:0@'' OR asp.AD_AuthorizationScope=''@+SCOPE:0@'')
  AND asp.AD_Client_ID IN (0,@#AD_Client_ID@)
  AND EXISTS (SELECT 1
    FROM AD_AuthorizationCredential ac
    JOIN AD_AuthorizationProvider ap ON (ac.AD_AuthorizationProvider_ID=ap.AD_AuthorizationProvider_ID
      AND ap.IsActive=''Y''
      AND ap.AD_Client_ID IN (0,@#AD_Client_ID@))
    WHERE ac.AD_AuthorizationProvider_ID=asp.AD_AuthorizationProvider_ID 
      AND ac.IsActive=''Y''
      AND ac.AD_AuthorizationScopeList LIKE ''%''||asp.AD_AuthorizationScope||''%''
      AND ac.AD_Client_ID IN (0,@#AD_Client_ID@))
)',0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:54','YYYY-MM-DD HH24:MI:SS'),100,'D','3972733f-ee00-4e30-9aab-5d09b0d849d3')
;

-- Mar 2, 2021, 8:44:55 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,ReadOnlyLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200335,0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:54','YYYY-MM-DD HH24:MI:SS'),100,'Authorization Scope',200128,10,17,200185,'N',200145,10,'Y','@+SCOPE@','AD_AuthorizationScope','Y','D',203460,'@+SCOPE@!''''','f2c44e06-a98b-476c-b6aa-5035e19f6cdb','N','N')
;

-- Mar 2, 2021, 8:44:55 PM CET
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200146,'AD_AuthorizationCredential of Scope','S','AD_AuthorizationCredential.AD_Client_ID IN (0,@#AD_Client_ID@) AND 
AD_AuthorizationCredential.IsActive=''Y'' AND 
AD_AuthorizationCredential.AD_AuthorizationScopeList LIKE ''%''||''@AD_AuthorizationScope@''||''%'' AND 
EXISTS ( 
  SELECT 1 
  FROM AD_AuthorizationScopeProv asp 
    JOIN AD_AuthorizationProvider ap ON (asp.AD_AuthorizationProvider_ID=ap.AD_AuthorizationProvider_ID  
      AND ap.IsActive=''Y''  
      AND ap.AD_Client_ID IN (0,@#AD_Client_ID@)) 
  WHERE asp.AD_AuthorizationProvider_ID=AD_AuthorizationCredential.AD_AuthorizationProvider_ID 
    AND asp.AD_AuthorizationScope=''@AD_AuthorizationScope@'' 
    AND asp.IsActive=''Y'' 
    AND asp.AD_Client_ID IN (0,@#AD_Client_ID@))',0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,'D','2be5a622-adb4-485d-a06a-168e3627135a')
;

-- Mar 2, 2021, 8:44:55 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200336,0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,'Authorization Credential',200128,20,19,'N',200146,22,'Y','AD_AuthorizationCredential_ID','Y','D',203462,'0f2496c7-10d4-4f0c-aae1-6e25bc2b4ff7','N','N')
;

-- Mar 2, 2021, 8:44:56 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203477,0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:55','YYYY-MM-DD HH24:MI:SS'),100,'Auth_OpenPopup','Open Authorization in Popup Window','Open Authorization in Popup Window','D','03b05026-1620-4429-a28a-49a06fa8612a')
;

-- Mar 2, 2021, 8:44:56 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200337,0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:56','YYYY-MM-DD HH24:MI:SS'),100,'Open Authorization in Popup Window',200128,30,20,'N',1,'Y','@+OPEN_POPUP:Y@','Auth_OpenPopup','Y','D',203477,'@+OPEN_POPUP@=''''','6f136023-be77-4762-aed3-0107c473379e','N','N')
;

-- Mar 2, 2021, 8:44:57 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU,PredefinedContextVariables) VALUES (200182,'Add Authorization Mail Account','P',0,0,'Y',TO_TIMESTAMP('2021-03-02 20:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-02 20:44:56','YYYY-MM-DD HH24:MI:SS'),100,'N',200128,'Y','N','D','Y','53d88c72-2e33-41b2-94b2-03f16bf07982','SCOPE=EMail
OPEN_POPUP=Y')
;

-- Mar 2, 2021, 8:44:57 PM CET
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200178,3, 10, 200182)
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200178
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 2, 2021, 8:47:20 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=24, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200177
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200178
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 2, 2021, 8:47:29 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=24, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200177
;

-- Mar 4, 2021, 10:35:05 AM CET
UPDATE AD_Process_Para SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2021-03-04 10:35:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200337
;

-- IDEMPIERE-3101 implement OAuth2 for mail (gmail, outlook and other mail system)
-- Mar 4, 2021, 10:37:16 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Please copy this URL and open it into your browser to authorize your account',0,0,'Y',TO_TIMESTAMP('2021-03-04 10:37:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 10:37:16','YYYY-MM-DD HH24:MI:SS'),100,200664,'Add_Auth_Copy_Link','D','15c81291-1926-4d7f-a69f-15ec9e94e057')
;

-- Mar 4, 2021, 10:37:47 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Please proceed to authorize your account in the popup window.',0,0,'Y',TO_TIMESTAMP('2021-03-04 10:37:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 10:37:46','YYYY-MM-DD HH24:MI:SS'),100,200665,'Add_Auth_In_Popup','D','1fc69689-5c66-4ea2-ac09-3a3f064bad16')
;

-- Mar 4, 2021, 10:47:28 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The "{0}" URL parameter is missing',0,0,'Y',TO_TIMESTAMP('2021-03-04 10:47:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 10:47:28','YYYY-MM-DD HH24:MI:SS'),100,200666,'OAuthCallback_MissingParameter','D','4741bb6c-eb25-4504-89c9-a3b8e74b875c')
;

-- Mar 4, 2021, 10:50:29 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The "state" URL parameter is not valid',0,0,'Y',TO_TIMESTAMP('2021-03-04 10:50:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 10:50:29','YYYY-MM-DD HH24:MI:SS'),100,200667,'OAuthCallback_InvalidState','D','39cc3d01-fe8d-437e-a90c-68383dd9296e')
;

-- Mar 4, 2021, 10:51:46 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The "state" URL parameter is not valid, parameter not found',0,0,'Y',TO_TIMESTAMP('2021-03-04 10:51:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 10:51:46','YYYY-MM-DD HH24:MI:SS'),100,200668,'OAuthCallback_NotFoundState','D','b8dbabc5-2942-4207-808b-5195e1fc91d6')
;

-- Mar 4, 2021, 10:55:51 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Could not get the email from the response',0,0,'Y',TO_TIMESTAMP('2021-03-04 10:55:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 10:55:51','YYYY-MM-DD HH24:MI:SS'),100,200669,'OAuthProcessToken_CouldNotGetEMail','D','494ad2ec-b18f-4479-9ce0-fd62227853ea')
;

-- Mar 4, 2021, 10:56:06 AM CET
UPDATE AD_Message SET MsgType='E',Updated=TO_TIMESTAMP('2021-03-04 10:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200667
;

-- Mar 4, 2021, 10:56:09 AM CET
UPDATE AD_Message SET MsgType='E',Updated=TO_TIMESTAMP('2021-03-04 10:56:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200666
;

-- Mar 4, 2021, 10:56:11 AM CET
UPDATE AD_Message SET MsgType='E',Updated=TO_TIMESTAMP('2021-03-04 10:56:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200668
;

-- Mar 4, 2021, 10:56:40 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No refresh token.  Request Failed. Please try again',0,0,'Y',TO_TIMESTAMP('2021-03-04 10:56:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 10:56:40','YYYY-MM-DD HH24:MI:SS'),100,200670,'OAuthProcessToken_NoRefreshToken','D','f4ed653b-6021-4ab3-a0bd-db3971f872f6')
;

-- Mar 4, 2021, 11:17:35 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Request failed or it was aborted by user.',0,0,'Y',TO_TIMESTAMP('2021-03-04 11:17:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 11:17:35','YYYY-MM-DD HH24:MI:SS'),100,200671,'OAuthPopup_Failure','D','0b34a772-fa43-4a84-a7bc-34bb5f3b78f1')
;

-- Mar 4, 2021, 11:40:09 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','This window can be closed now.',0,0,'Y',TO_TIMESTAMP('2021-03-04 11:40:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 11:40:08','YYYY-MM-DD HH24:MI:SS'),100,200672,'OAuthPopup_Close','D','22b37095-6afc-458a-b2b5-86eb808fef87')
;

-- Mar 4, 2021, 1:10:14 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Click the OK button to open the authorization popup window.',0,0,'Y',TO_TIMESTAMP('2021-03-04 13:10:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 13:10:14','YYYY-MM-DD HH24:MI:SS'),100,200673,'Authorization_Message','D','a0ace366-678c-47d9-b048-737af5511fd9')
;

-- Mar 4, 2021, 4:01:13 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200338,0,0,'Y',TO_TIMESTAMP('2021-03-04 16:01:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-04 16:01:12','YYYY-MM-DD HH24:MI:SS'),100,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200128,40,18,327,'N',6,'N','@#AD_Language@','AD_Language','Y','D',109,'1=2','9042a009-41dd-466c-9ed7-9a352d3eb362','N','N')
;

-- Mar 4, 2021, 4:26:51 PM CET
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_TIMESTAMP('2021-03-04 16:26:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214402
;

-- Mar 4, 2021, 4:27:04 PM CET
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-03-04 16:27:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214403
;

-- Mar 4, 2021, 4:27:08 PM CET
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-03-04 16:27:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214402
;

-- Mar 4, 2021, 4:27:35 PM CET
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-03-04 16:27:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214388
;

-- Mar 4, 2021, 4:27:40 PM CET
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-03-04 16:27:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214387
;

-- Mar 5, 2021, 3:56:33 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203478,0,0,'Y',TO_TIMESTAMP('2021-03-05 15:56:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-05 15:56:03','YYYY-MM-DD HH24:MI:SS'),100,'Auth_CallbackAnswer','Callback Answer',NULL,NULL,'Callback Answer','D','60b94b5d-a902-4e98-93ef-360a93fd6cbe')
;

-- Mar 5, 2021, 3:57:46 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200339,0,0,'Y',TO_TIMESTAMP('2021-03-05 15:57:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-05 15:57:45','YYYY-MM-DD HH24:MI:SS'),100,'Callback Answer',200128,50,10,'N',4000,'N','Auth_CallbackAnswer','Y','D',203478,'1=2','c36bcfc9-d123-4f57-bae3-4ad93c8f338e','N','N')
;

-- Mar 5, 2021, 4:07:22 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The authorization link was already used',0,0,'Y',TO_TIMESTAMP('2021-03-05 16:07:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-05 16:07:21','YYYY-MM-DD HH24:MI:SS'),100,200674,'OAuthCallback_AlreadyUsedLink','D','3ebd92aa-4a4d-4a2c-a6d3-df874083f040')
;

SELECT register_migration_script('202102241858_IDEMPIERE-3101.sql') FROM dual
;

