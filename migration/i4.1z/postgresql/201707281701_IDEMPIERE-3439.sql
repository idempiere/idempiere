-- IDEMPIERE-3439
-- Jul 28, 2017 6:16:51 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200092,'All Clients',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:50','YYYY-MM-DD HH24:MI:SS'),100,'Q','N','D','Y','N',0,0,'N','f9cf0170-7311-4a69-b2e8-af765ff9ac19')
;

-- Jul 28, 2017 6:16:51 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200223,'All Clients',200092,'AD_AllClients_V',0,'4',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','Y','L','N','Y','1ff55d50-0470-4742-9525-cae631e90a17','N','N','N')
;

-- Jul 28, 2017 6:16:52 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AllClients_V',1000000,'N','N','Table AD_AllClients_V','Y','Y',0,0,TO_TIMESTAMP('2017-07-28 18:16:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:51','YYYY-MM-DD HH24:MI:SS'),100,200287,'Y',1000000,1,200000,'3eaf54a9-64bc-4edd-942d-172a46eba7d3')
;

-- Jul 28, 2017 6:16:52 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203119,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:52','YYYY-MM-DD HH24:MI:SS'),100,'AD_AllClients_V_ID','All Clients','All Clients','D','5bf190ec-645e-40d8-b1f7-8d16ba2e2c47')
;

-- Jul 28, 2017 6:16:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213145,0.0,'All Clients',200223,'AD_AllClients_V_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:52','YYYY-MM-DD HH24:MI:SS'),100,203119,'N','N','D','Y','N','N','Y','6a9dbcf3-93c4-4b1d-97fa-71fca21902f8','N','N','N','N')
;

-- Jul 28, 2017 6:16:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213146,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200223,'AD_Client_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:53','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','629153c6-e0da-4f0a-b389-096dda522c46','N','N','N','D')
;

-- Jul 28, 2017 6:16:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213147,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200223,'AD_Org_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:53','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','a02c9f12-60f7-4f44-bacc-889a8182a4ed','N','N','N','D')
;

-- Jul 28, 2017 6:16:54 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213148,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200223,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:53','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','Y','N','N','Y','681917d3-1909-4de8-907d-c3ac9002a9e8','N','N','N','N')
;

-- Jul 28, 2017 6:16:54 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213149,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200223,'Created','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:54','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','40cf1006-c551-4792-b02f-a11e02321aa9','N','N','N','N')
;

-- Jul 28, 2017 6:16:54 PM CEST
UPDATE AD_Ref_Table SET AD_Key=212, AD_Display=213, WhereClause=NULL, AD_Window_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2017-07-28 18:16:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=110
;

-- Jul 28, 2017 6:16:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213150,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200223,'CreatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:54','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','7ade9f6d-4c45-4721-9303-400bbdf596a0','N','N','N','D')
;

-- Jul 28, 2017 6:16:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213151,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200223,'Updated','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:55','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','b8a0758a-7ea4-4db3-82a5-6c5c8f5b43e5','N','N','N','N')
;

-- Jul 28, 2017 6:16:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213152,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200223,'UpdatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:55','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','0f0a5544-d737-4c5b-872a-ff0197eb2330','N','N','N','D')
;

-- Jul 28, 2017 6:16:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213153,0.0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200223,'Value',40,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:55','YYYY-MM-DD HH24:MI:SS'),100,620,'N','Y','D','Y','N','N','Y','bafba960-faaf-474f-9a42-8d4babc13121','Y','N','N','N')
;

-- Jul 28, 2017 6:16:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213154,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200223,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:56','YYYY-MM-DD HH24:MI:SS'),100,469,'N','Y','D','Y','N','N','Y','77c0f8ed-209c-4976-a2d9-278b212c4f80','Y','N','N','N')
;

-- Jul 28, 2017 6:16:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213155,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200223,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:56','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','Y','N','N','Y','dde267ab-ff81-4808-84b7-444144c8373f','Y','N','N','N')
;

-- Jul 28, 2017 6:16:57 PM CEST
UPDATE AD_Ref_Table SET AD_Key=203, AD_Display=204, WhereClause=NULL, OrderByClause=NULL, AD_Window_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2017-07-28 18:16:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=106
;

-- Jul 28, 2017 6:16:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213156,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200223,'AD_Language',6,'N','N','N','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:57','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','Y','N','N','Y','01df2034-6570-4568-909e-64e9b28e9467','Y','N','N','N')
;

-- Jul 28, 2017 6:16:57 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203120,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_AllClients_V_UU','AD_AllClients_V_UU','AD_AllClients_V_UU','D','c7f878f0-0ac5-473e-a90f-9147bbbc4b82')
;

-- Jul 28, 2017 6:16:58 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213157,0.0,'AD_AllClients_V_UU',200223,'AD_AllClients_V_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:16:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:16:58','YYYY-MM-DD HH24:MI:SS'),100,203120,'N','N','D','Y','N','N','Y','ba6da1ce-eb52-4ad2-aad2-82a503c397d0','N','N','N','N')
;

-- Jul 28, 2017 6:16:58 PM CEST
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,Referenced_Table_ID,SeqNo,FromClause) VALUES (0,0,200001,'4885202b-e82d-4753-a503-afdd57b43483',TO_TIMESTAMP('2017-07-28 18:16:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AllClients',TO_TIMESTAMP('2017-07-28 18:16:58','YYYY-MM-DD HH24:MI:SS'),100,200223,112,10,'FROM AD_Client')
;

-- Jul 28, 2017 6:16:59 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200010,'02046b36-7d82-4b83-9659-2c1f2ee9f113',TO_TIMESTAMP('2017-07-28 18:16:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:16:58','YYYY-MM-DD HH24:MI:SS'),100,200001,'AD_Client_ID','0',10)
;

-- Jul 28, 2017 6:16:59 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200011,'ed689b5d-ca07-4dd2-b824-3ef10e102eb7',TO_TIMESTAMP('2017-07-28 18:16:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:16:59','YYYY-MM-DD HH24:MI:SS'),100,200001,'AD_Org_ID','0',20)
;

-- Jul 28, 2017 6:16:59 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200012,'d6cd4249-d44d-457b-ab6a-e20f5ef0aad4',TO_TIMESTAMP('2017-07-28 18:16:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:16:59','YYYY-MM-DD HH24:MI:SS'),100,200001,'AD_AllClients_V_ID','AD_Client_ID',30)
;

-- Jul 28, 2017 6:17:00 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200013,'53173868-74ec-41fa-aa12-2c63623d4aef',TO_TIMESTAMP('2017-07-28 18:16:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:16:59','YYYY-MM-DD HH24:MI:SS'),100,200001,'IsActive','IsActive',40)
;

-- Jul 28, 2017 6:17:00 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200014,'1768981f-aac5-4769-849f-2c20a9d31146',TO_TIMESTAMP('2017-07-28 18:17:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:00','YYYY-MM-DD HH24:MI:SS'),100,200001,'Created','Created',50)
;

-- Jul 28, 2017 6:17:01 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200015,'a3652078-6d90-41f1-92d7-2bfdde55f871',TO_TIMESTAMP('2017-07-28 18:17:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:00','YYYY-MM-DD HH24:MI:SS'),100,200001,'CreatedBy','CreatedBy',60)
;

-- Jul 28, 2017 6:17:01 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200016,'229c14dc-ca2c-4439-9758-9557584f4339',TO_TIMESTAMP('2017-07-28 18:17:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:01','YYYY-MM-DD HH24:MI:SS'),100,200001,'Updated','Updated',70)
;

-- Jul 28, 2017 6:17:01 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200017,'1aa0d5bf-bf6c-49db-bbbc-07c92832516f',TO_TIMESTAMP('2017-07-28 18:17:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:01','YYYY-MM-DD HH24:MI:SS'),100,200001,'UpdatedBy','UpdatedBy',80)
;

-- Jul 28, 2017 6:17:02 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200018,'9a8104a7-63f6-4a71-8ebd-8cedf0e1f4b8',TO_TIMESTAMP('2017-07-28 18:17:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:01','YYYY-MM-DD HH24:MI:SS'),100,200001,'Value','Value',90)
;

-- Jul 28, 2017 6:17:02 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200019,'b69eb578-531e-4367-8189-06dda565981c',TO_TIMESTAMP('2017-07-28 18:17:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:02','YYYY-MM-DD HH24:MI:SS'),100,200001,'Name','Name',100)
;

-- Jul 28, 2017 6:17:02 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200020,'1b336e3b-72b0-45e6-84dc-89cc02d2d7d8',TO_TIMESTAMP('2017-07-28 18:17:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:02','YYYY-MM-DD HH24:MI:SS'),100,200001,'Description','Description',110)
;

-- Jul 28, 2017 6:17:03 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200021,'063ee0e9-ac8e-4496-a7ff-703368cc0b1b',TO_TIMESTAMP('2017-07-28 18:17:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:02','YYYY-MM-DD HH24:MI:SS'),100,200001,'AD_Language','AD_Language',120)
;

-- Jul 28, 2017 6:17:03 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200022,'061ef031-0375-4d94-bcaa-c9ef10a8bd7d',TO_TIMESTAMP('2017-07-28 18:17:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:03','YYYY-MM-DD HH24:MI:SS'),100,200001,'AD_AllClients_V_UU','AD_Client_UU',130)
;

-- Jul 28, 2017 6:17:03 PM CEST
CREATE OR REPLACE VIEW AD_AllClients_V(AD_Client_ID, AD_Org_ID, AD_AllClients_V_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, Value, Name, Description, AD_Language, AD_AllClients_V_UU) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_Client_ID AS AD_AllClients_V_ID, IsActive AS IsActive, Created AS Created, CreatedBy AS CreatedBy, Updated AS Updated, UpdatedBy AS UpdatedBy, Value AS Value, Name AS Name, Description AS Description, AD_Language AS AD_Language, AD_Client_UU AS AD_AllClients_V_UU FROM AD_Client
;

-- Jul 28, 2017 6:17:04 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200226,'Client',200092,10,'Y',200223,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AllClients_V.Name','N','N',0,'N','D','Y','N','4c54be9c-5edf-4df9-a759-1c60cd850987','B')
;

-- Jul 28, 2017 6:17:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205141,'AD_AllClients_V_UU',200226,213157,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','075f9e3c-9501-4ef9-93d0-02963a040686','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205142,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200226,213147,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb14215f-2b0a-44c1-8d37-7495817ab157','Y','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205143,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200226,213146,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','041e3854-783c-4fae-aa54-5a1a388eb1d6','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205144,'All Clients',200226,213145,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e853c0c4-142e-4269-940e-d437b1243681','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205145,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200226,213153,'Y',40,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4f36d8c1-324c-4683-95f6-3a4b3170158b','Y',10,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205146,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200226,213154,'Y',60,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','de01a8ed-dfaa-4d40-a1e3-82b8ce2ab30a','Y',20,1,5,1,'N','N','N')
;

-- Jul 28, 2017 6:17:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205147,'Description','Optional short description of the record','A description is limited to 255 characters.',200226,213155,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','36cef6a8-a387-4243-9f76-b6eadb81956a','Y',30,1,5,1,'N','N','N')
;

-- Jul 28, 2017 6:17:07 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205148,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200226,213156,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6a3e22c0-42a3-42da-9b78-61661dca2d41','Y',40,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:08 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205149,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200226,213148,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d77415c2-caaa-4dce-ac46-04cd19a86a79','Y',50,5,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:08 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203121,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:08','YYYY-MM-DD HH24:MI:SS'),100,'AD_AllUsers_V_ID','All Users','All Users','D','1e269dc8-49ea-44bb-bd08-61574d45de21')
;

-- Jul 28, 2017 6:17:09 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203122,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:08','YYYY-MM-DD HH24:MI:SS'),100,'AD_AllUsers_V_UU','AD_AllUsers_V_UU','AD_AllUsers_V_UU','D','fdd4c326-a398-496b-942e-b69a5c42c120')
;

-- Jul 28, 2017 6:17:09 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200093,'All Users','Users from All Clients',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:09','YYYY-MM-DD HH24:MI:SS'),100,'Q','N','D','Y','N',0,0,'N','87b570b2-4e30-47af-a35c-3828a284b675')
;

-- Jul 28, 2017 6:17:09 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200147,'All Clients','W',200092,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','a3c143c0-ca37-46de-8d0d-b60d3b510fa6')
;

-- Jul 28, 2017 6:17:09 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 367,19, 10, 200147)
;

-- Jul 28, 2017 6:17:10 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200148,'All Users','Users from all Clients','W',200093,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','bc5805b5-9c7a-4fc1-bc2e-f6b25fb1c7bb')
;

-- Jul 28, 2017 6:17:10 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 367,20, 10, 200148)
;

-- Jul 28, 2017 6:17:10 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200224,'All Users','Users from All Tenants',200093,'AD_AllUsers_V',0,'4',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','Y','L','N','Y','41316841-fe21-4e6d-afda-85e06503d899','N','N','N')
;

-- Jul 28, 2017 6:17:11 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AllUsers_V',1000000,'N','N','Table AD_AllUsers_V','Y','Y',0,0,TO_TIMESTAMP('2017-07-28 18:17:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:10','YYYY-MM-DD HH24:MI:SS'),100,200288,'Y',1000000,1,200000,'b30c5508-e1b0-4878-96d5-de3c9511508a')
;

-- Jul 28, 2017 6:17:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213158,0.0,'All Users',200224,'AD_AllUsers_V_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:11','YYYY-MM-DD HH24:MI:SS'),100,203121,'N','N','D','Y','N','N','Y','42ab2ef2-05ee-40c6-8b46-d1ccc4df645c','N','N','N','N')
;

-- Jul 28, 2017 6:17:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213159,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200224,'AD_Client_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:11','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','087d4e5b-46d9-4242-8e34-613043b13b32','N','N','N','D')
;

-- Jul 28, 2017 6:17:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213160,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200224,'AD_Org_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:11','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','ab993c6b-d49c-4949-ac0e-4e18af6f55d6','N','N','N','D')
;

-- Jul 28, 2017 6:17:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213161,0.0,'All Clients',200224,'AD_AllClients_V_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:12','YYYY-MM-DD HH24:MI:SS'),100,203119,'N','N','D','Y','N','N','Y','9f215ff3-ae07-4d27-a4b3-5c528a71ab03','Y','N','N','N')
;

-- Jul 28, 2017 6:17:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213162,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200224,'IsActive',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:12','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','Y','N','N','Y','8b04e4f1-b271-4d2f-bcae-8ecd8d502da8','N','N','N','N')
;

-- Jul 28, 2017 6:17:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213163,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200224,'Created','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:13','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','da33bec8-ff86-4f22-8e3b-e5d3392e5327','N','N','N','N')
;

-- Jul 28, 2017 6:17:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213164,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200224,'CreatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:13','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','dc7c520b-674b-480d-ad22-bfac9ca05670','N','N','N','D')
;

-- Jul 28, 2017 6:17:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213165,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200224,'Updated','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:13','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','8286d483-bf29-4650-98f3-e62d5e11964e','N','N','N','N')
;

-- Jul 28, 2017 6:17:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213166,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200224,'UpdatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:14','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','838233cf-d00c-40d4-8c21-f56afa6ec190','N','N','N','D')
;

-- Jul 28, 2017 6:17:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213167,0.0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200224,'Value',40,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:14','YYYY-MM-DD HH24:MI:SS'),100,620,'N','Y','D','Y','N','N','Y','963e551d-d90a-4a12-b314-c163e3a537c3','Y','N','N','N')
;

-- Jul 28, 2017 6:17:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213168,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200224,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:15','YYYY-MM-DD HH24:MI:SS'),100,469,'N','Y','D','Y','N','N','Y','d5c9ca24-403b-4f08-9954-5819e66b7a8e','Y','N','N','N')
;

-- Jul 28, 2017 6:17:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213169,0.0,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200224,'EMail',60,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:15','YYYY-MM-DD HH24:MI:SS'),100,881,'N','N','D','Y','N','N','Y','f219b55a-13b9-43ea-84c1-2c0857113c75','Y','N','N','N')
;

-- Jul 28, 2017 6:17:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213170,0.0,'LDAP User Name','User Name used for authorization via LDAP (directory) services','Optional LDAP system user name for the user. If not defined, the normal Name of the user is used. This allows to use the internal (LDAP) user id (e.g. jjanke) and the normal display name (e.g. Jorg Janke).  The LDAP User Name can also be used without LDAP enables (see system window).  This would allow to sign in as jjanke and use the display name of Jorg Janke.',200224,'LDAPUser',60,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:15','YYYY-MM-DD HH24:MI:SS'),100,2546,'N','N','D','Y','N','N','Y','b0dee033-658e-46d4-8e25-61758367c759','Y','N','N','N')
;

-- Jul 28, 2017 6:17:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213171,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200224,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:16','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','Y','N','N','Y','88bd1325-f30d-462a-a9d4-ddb37495f6cd','Y','N','N','N')
;

-- Jul 28, 2017 6:17:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213172,0.0,'Date Last Login',200224,'DateLastLogin',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:16','YYYY-MM-DD HH24:MI:SS'),100,200115,'N','N','D','Y','N','N','Y','2bd1e024-8397-438f-a62b-fdd10f2ef9be','Y','N','N','N')
;

-- Jul 28, 2017 6:17:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213173,0.0,'User PIN',200224,'UserPIN',20,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:17','YYYY-MM-DD HH24:MI:SS'),100,52023,'N','N','D','Y','N','N','Y','ad8217ce-796f-438d-95ec-ce906ecb9484','Y','N','N','N')
;

-- Jul 28, 2017 6:17:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213174,0.0,'Password','Password of any length (case sensitive)','The Password for this User.  Passwords are required to identify authorized users.  For iDempiere Users, you can change the password via the Process "Reset Password".',200224,'Password',2064,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:17','YYYY-MM-DD HH24:MI:SS'),100,498,'N','N','D','Y','N','N','Y','76fcbafd-4972-4d73-9178-ba3365367562','Y','N','Y','N')
;

-- Jul 28, 2017 6:17:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213175,0.0,'Salt','Random data added to improve password hash effectiveness',200224,'Salt',16,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:17','YYYY-MM-DD HH24:MI:SS'),100,55218,'N','N','D','Y','N','N','Y','1cfa5e01-ed5a-4b2b-a9e5-4f4acf8d0b76','Y','N','Y','N')
;

-- Jul 28, 2017 6:17:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213176,0.0,'Locked',200224,'IsLocked',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:18','YYYY-MM-DD HH24:MI:SS'),100,200111,'N','N','D','Y','N','N','Y','20c17072-d8a5-4219-8671-56a00411c6e2','Y','N','N','N')
;

-- Jul 28, 2017 6:17:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213177,0.0,'Failed Login Count',200224,'FailedLoginCount',10,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:18','YYYY-MM-DD HH24:MI:SS'),100,200113,'N','N','D','Y','N','N','Y','61388bc3-fd45-4939-bffa-a509acd0df8c','Y','N','N','N')
;

-- Jul 28, 2017 6:17:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213178,0.0,'Date Password Changed',200224,'DatePasswordChanged',29,'N','N','N','N','N','N',15,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:19','YYYY-MM-DD HH24:MI:SS'),100,200114,'N','N','D','Y','N','N','Y','3ea804ee-b4b3-4fd0-bd91-62e6bdebeeb5','Y','N','N','N')
;

-- Jul 28, 2017 6:17:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213179,0.0,'No Password Reset',200224,'IsNoPasswordReset',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:19','YYYY-MM-DD HH24:MI:SS'),100,200116,'N','N','D','Y','N','N','Y','cc77140e-d22c-4442-b1fb-98ad92de6b26','Y','N','N','N')
;

-- Jul 28, 2017 6:17:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213180,0.0,'Expired',200224,'IsExpired',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:19','YYYY-MM-DD HH24:MI:SS'),100,200126,'N','N','D','Y','N','N','Y','05cd2a68-6ba0-472c-874e-0632899bb570','Y','N','N','N')
;

-- Jul 28, 2017 6:17:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213181,0.0,'AD_AllUsers_V_UU',200224,'AD_AllUsers_V_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:20','YYYY-MM-DD HH24:MI:SS'),100,203122,'N','N','D','Y','N','N','Y','d2c7c4fc-0f65-4af8-a1e0-7b798ff7d259','N','N','N','N')
;

-- Jul 28, 2017 6:17:21 PM CEST
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,Referenced_Table_ID,SeqNo,WhereClause,FromClause) VALUES (0,0,200002,'e053326f-868a-4d66-9d4a-21246bf42317',TO_TIMESTAMP('2017-07-28 18:17:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AllUsers',TO_TIMESTAMP('2017-07-28 18:17:20','YYYY-MM-DD HH24:MI:SS'),100,200224,114,10,'WHERE Password IS NOT NULL','FROM AD_User')
;

-- Jul 28, 2017 6:17:21 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200023,'02e4f3e9-41cd-43f8-9d10-3c78e8e8a13b',TO_TIMESTAMP('2017-07-28 18:17:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:21','YYYY-MM-DD HH24:MI:SS'),100,200002,'AD_Client_ID','0',10)
;

-- Jul 28, 2017 6:17:22 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200024,'8a0434d5-73fe-4945-b89e-1b37e63e09c9',TO_TIMESTAMP('2017-07-28 18:17:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:21','YYYY-MM-DD HH24:MI:SS'),100,200002,'AD_Org_ID','0',20)
;

-- Jul 28, 2017 6:17:22 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200025,'4cf24f79-e738-4240-8c93-13c4157808f6',TO_TIMESTAMP('2017-07-28 18:17:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:22','YYYY-MM-DD HH24:MI:SS'),100,200002,'AD_AllUsers_V_ID','AD_User_ID',30)
;

-- Jul 28, 2017 6:17:22 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200026,'360b2ca5-3e09-4b40-992a-be43cf0564a7',TO_TIMESTAMP('2017-07-28 18:17:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:22','YYYY-MM-DD HH24:MI:SS'),100,200002,'AD_AllClients_V_ID','AD_Client_ID',40)
;

-- Jul 28, 2017 6:17:23 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200027,'1ba5e690-2ab5-4b4c-a26c-d8c569d10971',TO_TIMESTAMP('2017-07-28 18:17:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:22','YYYY-MM-DD HH24:MI:SS'),100,200002,'IsActive','IsActive',50)
;

-- Jul 28, 2017 6:17:23 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200028,'9bfd6d50-add5-405d-89d0-b140e2c57417',TO_TIMESTAMP('2017-07-28 18:17:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:23','YYYY-MM-DD HH24:MI:SS'),100,200002,'Created','Created',60)
;

-- Jul 28, 2017 6:17:23 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200029,'e49773c4-2453-431b-98b0-01295a3e412a',TO_TIMESTAMP('2017-07-28 18:17:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:23','YYYY-MM-DD HH24:MI:SS'),100,200002,'CreatedBy','CreatedBy',70)
;

-- Jul 28, 2017 6:17:24 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200030,'35b4e861-0dae-465e-bb85-f2906a6d29ea',TO_TIMESTAMP('2017-07-28 18:17:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:23','YYYY-MM-DD HH24:MI:SS'),100,200002,'Updated','Updated',80)
;

-- Jul 28, 2017 6:17:24 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200031,'b3d37652-16e6-4f42-96b7-e7fb0d5abbd1',TO_TIMESTAMP('2017-07-28 18:17:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:24','YYYY-MM-DD HH24:MI:SS'),100,200002,'UpdatedBy','UpdatedBy',90)
;

-- Jul 28, 2017 6:17:25 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200032,'d141c3c8-de14-4c9b-a326-595ae100a943',TO_TIMESTAMP('2017-07-28 18:17:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:24','YYYY-MM-DD HH24:MI:SS'),100,200002,'Value','Value',100)
;

-- Jul 28, 2017 6:17:25 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200033,'46948ee5-89b1-47c5-a674-87f96724b9a3',TO_TIMESTAMP('2017-07-28 18:17:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:25','YYYY-MM-DD HH24:MI:SS'),100,200002,'Name','Name',110)
;

-- Jul 28, 2017 6:17:25 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200034,'d453b97d-edfa-4f13-b49a-a18ebadc39fe',TO_TIMESTAMP('2017-07-28 18:17:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:25','YYYY-MM-DD HH24:MI:SS'),100,200002,'EMail','EMail',120)
;

-- Jul 28, 2017 6:17:26 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200035,'67055351-c76b-4e8c-978b-7b647fff96b4',TO_TIMESTAMP('2017-07-28 18:17:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:25','YYYY-MM-DD HH24:MI:SS'),100,200002,'LDAPUser','LDAPUser',130)
;

-- Jul 28, 2017 6:17:26 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200036,'b8398fc4-16c2-47c1-876c-48aaea18959a',TO_TIMESTAMP('2017-07-28 18:17:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:26','YYYY-MM-DD HH24:MI:SS'),100,200002,'Description','Description',140)
;

-- Jul 28, 2017 6:17:27 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200037,'276357ee-825b-44a9-8174-b0e17b3aed71',TO_TIMESTAMP('2017-07-28 18:17:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:26','YYYY-MM-DD HH24:MI:SS'),100,200002,'DateLastLogin','DateLastLogin',150)
;

-- Jul 28, 2017 6:17:27 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200038,'c47f80d3-7b17-4252-9ad7-5ef2915d0e32',TO_TIMESTAMP('2017-07-28 18:17:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:27','YYYY-MM-DD HH24:MI:SS'),100,200002,'UserPIN','UserPIN',160)
;

-- Jul 28, 2017 6:17:27 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200039,'97d9dc23-c19d-417b-b39a-8c84efb3c4e5',TO_TIMESTAMP('2017-07-28 18:17:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:27','YYYY-MM-DD HH24:MI:SS'),100,200002,'Password','Password',170)
;

-- Jul 28, 2017 6:17:28 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200040,'44570939-f2c1-4495-8a99-5205cb3a30dc',TO_TIMESTAMP('2017-07-28 18:17:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:27','YYYY-MM-DD HH24:MI:SS'),100,200002,'Salt','Salt',180)
;

-- Jul 28, 2017 6:17:28 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200041,'a382377b-819a-4a41-aaf8-900b697046b0',TO_TIMESTAMP('2017-07-28 18:17:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:28','YYYY-MM-DD HH24:MI:SS'),100,200002,'IsLocked','IsLocked',190)
;

-- Jul 28, 2017 6:17:28 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200042,'75716821-ebde-4c6a-b42e-3c7beec76541',TO_TIMESTAMP('2017-07-28 18:17:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:28','YYYY-MM-DD HH24:MI:SS'),100,200002,'FailedLoginCount','FailedLoginCount',200)
;

-- Jul 28, 2017 6:17:29 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200043,'eecc7632-95f9-4649-bb5f-b56af10ed80c',TO_TIMESTAMP('2017-07-28 18:17:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:28','YYYY-MM-DD HH24:MI:SS'),100,200002,'DatePasswordChanged','DatePasswordChanged',210)
;

-- Jul 28, 2017 6:17:29 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200044,'172a450e-bbcc-45bc-aec2-258b46e7da92',TO_TIMESTAMP('2017-07-28 18:17:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:29','YYYY-MM-DD HH24:MI:SS'),100,200002,'IsNoPasswordReset','IsNoPasswordReset',220)
;

-- Jul 28, 2017 6:17:30 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200045,'471419f3-13f9-4312-bd55-c8c0536aa293',TO_TIMESTAMP('2017-07-28 18:17:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:29','YYYY-MM-DD HH24:MI:SS'),100,200002,'IsExpired','IsExpired',230)
;

-- Jul 28, 2017 6:17:30 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200046,'f86bec60-0334-4a37-a3f4-f34b46bc2e12',TO_TIMESTAMP('2017-07-28 18:17:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-07-28 18:17:30','YYYY-MM-DD HH24:MI:SS'),100,200002,'AD_AllUsers_V_UU','AD_User_UU',240)
;

-- Jul 28, 2017 6:17:30 PM CEST
CREATE OR REPLACE VIEW AD_AllUsers_V(AD_Client_ID, AD_Org_ID, AD_AllUsers_V_ID, AD_AllClients_V_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, Value, Name, EMail, LDAPUser, Description, DateLastLogin, UserPIN, Password, Salt, IsLocked, FailedLoginCount, DatePasswordChanged, IsNoPasswordReset, IsExpired, AD_AllUsers_V_UU) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_User_ID AS AD_AllUsers_V_ID, AD_Client_ID AS AD_AllClients_V_ID, IsActive AS IsActive, Created AS Created, CreatedBy AS CreatedBy, Updated AS Updated, UpdatedBy AS UpdatedBy, Value AS Value, Name AS Name, EMail AS EMail, LDAPUser AS LDAPUser, Description AS Description, DateLastLogin AS DateLastLogin, UserPIN AS UserPIN, Password AS Password, Salt AS Salt, IsLocked AS IsLocked, FailedLoginCount AS FailedLoginCount, DatePasswordChanged AS DatePasswordChanged, IsNoPasswordReset AS IsNoPasswordReset, IsExpired AS IsExpired, AD_User_UU AS AD_AllUsers_V_UU FROM AD_User WHERE Password IS NOT NULL
;

-- Jul 28, 2017 6:17:30 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200227,'User',200092,20,'Y',200224,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:30','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',213161,'N','N',1,'N','D','Y','N','6ad09983-2dd4-4c30-8314-c6a83c5bbaed','B')
;

-- Jul 28, 2017 6:17:31 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205150,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200227,213160,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0b27f408-c77a-4d64-be16-1d17c9f5a763','Y','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:31 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205151,'All Users',200227,213158,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e7de6197-b5f5-417b-bd6f-e43fc5cd22c2','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:31 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205152,'AD_AllUsers_V_UU',200227,213181,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15c8f92a-6e82-4523-ad0f-6e72d032361a','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:32 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205153,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200227,213159,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e5af618c-0efe-4636-82bf-fd8f4dbf63c4','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:32 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205154,'Client',200227,213161,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N','D','0761c295-11d5-4331-a5b3-a1990cd6bb4b','N',0,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205155,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200227,213169,'Y',60,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','52f32d5f-d2bf-4299-a061-935b835d4494','Y',10,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205156,'LDAP User Name','User Name used for authorization via LDAP (directory) services','Optional LDAP system user name for the user. If not defined, the normal Name of the user is used. This allows to use the internal (LDAP) user id (e.g. jjanke) and the normal display name (e.g. Jorg Janke).  The LDAP User Name can also be used without LDAP enables (see system window).  This would allow to sign in as jjanke and use the display name of Jorg Janke.',200227,213170,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b0dc4d7b-4bde-41a2-b6ad-cf175ccb8034','Y',140,4,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205157,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200227,213168,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b3b2cea4-e4e8-472e-a142-b1f6cf61b862','Y',20,1,5,1,'N','N','N')
;

-- Jul 28, 2017 6:17:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205158,'Description','Optional short description of the record','A description is limited to 255 characters.',200227,213171,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7dcb864a-8e74-49b7-b114-56ea74a6937a','Y',30,1,5,1,'N','N','N')
;

-- Jul 28, 2017 6:17:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205159,'Date Last Login',200227,213172,'Y',29,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','076499be-f33d-4e9e-b672-bff944ed9286','Y',40,1,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205160,'Failed Login Count',200227,213177,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','46438263-26a6-40f4-a607-e514e7753a5b','Y',50,4,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205161,'Date Password Changed',200227,213178,'Y',29,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0d346432-ef48-4ac8-a3f3-56056c2fc0f5','Y',60,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205162,'Expired',200227,213180,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a06f47fc-6c17-4437-99b2-ec7b0bc555f9','Y',70,4,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205163,'Locked',200227,213176,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4a7f9b59-e6ab-4778-a6cd-35b4e357c567','Y',80,5,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205164,'No Password Reset',200227,213179,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','abab6178-e3b5-4b3d-bbe5-dbe1ef410846','Y',90,6,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205165,'Password','Password of any length (case sensitive)','The Password for this User.  Passwords are required to identify authorized users.  For iDempiere Users, you can change the password via the Process "Reset Password".',200227,213174,'Y',1024,120,'N','N','N','Y',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0fc0030d-edd0-4372-9b7e-51fb1d533b65','Y',100,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205166,'Salt','Random data added to improve password hash effectiveness',200227,213175,'Y',16,130,'N','N','N','Y',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b924ffbc-65f2-47d8-a47f-f667f236c63f','Y',110,4,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205167,'User PIN',200227,213173,'Y',20,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cd17cf35-f3d6-42b2-81a3-d0e41a772ec3','Y',120,1,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:38 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205168,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200227,213167,'Y',40,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d76ad1b2-fe37-484e-a513-046f6b13e2d6','Y',130,3,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:38 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205169,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200227,213162,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6bedb878-8420-431d-be85-3b1064654e11','Y',150,5,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:38 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200228,'User',200093,10,'Y',200224,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AllUsers_V.Name','N','N',0,'N','D','Y','N','27ce3e6e-7387-44db-89fc-605b989847ac','B')
;

-- Jul 28, 2017 6:17:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205170,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200228,213159,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5c1ad640-9029-4c6f-a20d-2f7a60c15d32','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205171,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200228,213160,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','811d74e6-d16b-42f0-8cf5-b5b203f34d30','Y','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205172,'All Users',200228,213158,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cb6786f8-e791-4cf1-96a1-8bcd40fd53de','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:40 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205173,'AD_AllUsers_V_UU',200228,213181,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6d124a9d-b6f5-4cb7-b103-5b17817f154f','N',1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:40 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205174,'Client',200228,213161,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N','D','47c2dd3b-82c5-47ea-a78c-8940e1af3216','Y',10,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:41 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205175,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200228,213169,'Y',60,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7b8d585c-af5a-42c1-9825-20196f5dc091','Y',20,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:41 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205176,'LDAP User Name','User Name used for authorization via LDAP (directory) services','Optional LDAP system user name for the user. If not defined, the normal Name of the user is used. This allows to use the internal (LDAP) user id (e.g. jjanke) and the normal display name (e.g. Jorg Janke).  The LDAP User Name can also be used without LDAP enables (see system window).  This would allow to sign in as jjanke and use the display name of Jorg Janke.',200228,213170,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e67dfb6e-203c-4bda-b752-b24251dce24f','Y',150,4,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:41 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205177,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200228,213168,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','615f22ab-652d-4fd5-9361-b8479adc73a1','Y',30,1,5,1,'N','N','N')
;

-- Jul 28, 2017 6:17:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205178,'Description','Optional short description of the record','A description is limited to 255 characters.',200228,213171,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9369b26f-8a52-449c-8f38-6d25e43f7d36','Y',40,1,5,1,'N','N','N')
;

-- Jul 28, 2017 6:17:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205179,'Date Last Login',200228,213172,'Y',29,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a5dc821e-c7e3-4368-ba58-73ab9452ef14','Y',50,1,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205180,'Failed Login Count',200228,213177,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','51b01e38-738b-4df1-b8c8-9a34b815db53','Y',60,4,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205181,'Date Password Changed',200228,213178,'Y',29,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aa41dc7f-0ce6-4256-8094-5c0b9a7ba89f','Y',70,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205182,'Expired',200228,213180,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0935e198-a18a-4d29-9fc0-588612a4d623','Y',80,4,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205183,'Locked',200228,213176,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0a01e09d-e5c1-45b2-8ff7-5bffa6daaade','Y',90,5,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205184,'No Password Reset',200228,213179,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fca1b989-f082-4009-ae7e-bb55f714474c','Y',100,6,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205185,'Password','Password of any length (case sensitive)','The Password for this User.  Passwords are required to identify authorized users.  For iDempiere Users, you can change the password via the Process "Reset Password".',200228,213174,'Y',1024,120,'N','N','N','Y',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','83bc7bb4-84a4-41a6-ae03-0f47152b3af5','Y',110,1,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205186,'Salt','Random data added to improve password hash effectiveness',200228,213175,'Y',16,130,'N','N','N','Y',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','88b7591c-46ea-4ccf-8eab-f0d26d0a7951','Y',120,4,2,1,'N','N','N')
;

-- Jul 28, 2017 6:17:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205187,'User PIN',200228,213173,'Y',20,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da3b6402-af94-4bda-b4fe-c9ee0d544d47','Y',130,1,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:46 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205188,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200228,213167,'Y',40,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e2a86812-3214-4d77-827c-0ce895804ff5','Y',140,3,1,1,'N','N','N')
;

-- Jul 28, 2017 6:17:46 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205189,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200228,213162,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:17:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:17:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','31dff6e6-f7a6-4e6a-bb23-54a7e7d3941d','Y',160,5,1,1,'N','N','N')
;

-- Jul 28, 2017 4:40:49 PM CEST
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_TIMESTAMP('2017-07-28 16:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200098
;

-- Jul 28, 2017 4:45:09 PM CEST
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_TIMESTAMP('2017-07-28 16:45:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200099
;

-- Jul 28, 2017 4:48:24 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2017-07-28 16:48:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212635
;

-- Jul 28, 2017 4:54:33 PM CEST
UPDATE AD_Field SET Help='The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses. It must include the FROM itself.', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-28 16:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202235
;

-- Jul 28, 2017 4:56:46 PM CEST
UPDATE AD_Field SET Help='The Where Clause indicates the SQL WHERE clause to use for record selection. It must include the WHERE itself. Fully qualified means "tablename.columnname".', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-28 16:56:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202234
;

-- Jul 28, 2017 5:16:57 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=30, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-28 17:16:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202246
;

-- Jul 28, 2017 5:17:01 PM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=20, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-28 17:17:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202247
;

-- Jul 28, 2017 5:18:18 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-28 17:18:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202247
;

-- Jul 28, 2017 5:18:22 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-28 17:18:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202246
;

SELECT register_migration_script('201707281701_IDEMPIERE-3439.sql') FROM dual
;

