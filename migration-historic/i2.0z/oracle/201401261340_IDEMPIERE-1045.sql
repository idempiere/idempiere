SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 6, 2013 9:37:51 AM GMT
-- http://jira.idempiere.com/browse/IDEMPIERE-1045
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,EntityType) VALUES ('N','N','N','4',0,200089,'N','N','N','L','7b655e17-ab9d-4aa5-ad0b-ccf466542bbd','Y','Y','AD_InfoRelated','InfoRelated','Y',0,0,TO_DATE('2013-07-06 09:37:53','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:37:53','YYYY-MM-DD HH24:MI:SS'),0,'D')
;

-- Jul 6, 2013 9:37:59 AM GMT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,Created,CreatedBy,UpdatedBy,Updated,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200087,'cf86882c-aa4f-4866-99f2-06fb2cf588fe','Table AD_InfoRelated','AD_InfoRelated',1,0,TO_DATE('2013-07-06 09:37:58','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2013-07-06 09:37:58','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,0)
;

-- Jul 6, 2013 9:38:00 AM GMT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_InfoRelated_ID',202556,'InfoRelated','InfoRelated','690dfc35-2577-44d3-8a92-74ed78756846',TO_DATE('2013-07-06 09:37:59','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-06 09:37:59','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:01 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210597,'Y','N','N','N',10,'N',13,'Y',202556,'N','Y','8937e3af-8c97-4b1c-9292-ebd9ac89cc53','N','AD_InfoRelated_ID','InfoRelated','N',TO_DATE('2013-07-06 09:38:00','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:00','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:01 AM GMT
CREATE TABLE AD_InfoRelated (AD_InfoRelated_ID NUMBER(10) NOT NULL, CONSTRAINT AD_InfoRelated_Key PRIMARY KEY (AD_InfoRelated_ID))
;

-- Jul 6, 2013 9:38:01 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210598,'Y','N','N','N',10,'N',19,129,'N',102,'N','Y','60f193f8-6553-4b5b-bd81-76e3f31b2ef6','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2013-07-06 09:38:01','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:01','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:01 AM GMT
ALTER TABLE AD_InfoRelated ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Jul 6, 2013 9:38:02 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210599,'Y','N','N','N',10,'N',19,'N',113,'N','Y','afeec9a6-1eb1-4790-802d-864ea00dc862','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2013-07-06 09:38:01','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:01','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:02 AM GMT
ALTER TABLE AD_InfoRelated ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jul 6, 2013 9:38:03 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210600,'Y','N','N','N',1,'N',20,'N',348,'N','Y','5acbe692-1a57-49c8-9885-e6cb7e6166ee','Y','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2013-07-06 09:38:02','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:02','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:03 AM GMT
ALTER TABLE AD_InfoRelated ADD IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jul 6, 2013 9:38:03 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210601,'Y','N','N','N',29,'N',16,'N',245,'N','Y','a4213f78-0c68-4765-a984-ba67359bbcc9','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2013-07-06 09:38:03','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:03','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:03 AM GMT
ALTER TABLE AD_InfoRelated ADD Created DATE NOT NULL
;

-- Jul 6, 2013 9:38:04 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210602,110,'Y','N','N','N',10,'N',18,'N',246,'N','Y','c0244ff1-7b07-4ef6-bd60-41802df6833f','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2013-07-06 09:38:04','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:04','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:04 AM GMT
ALTER TABLE AD_InfoRelated ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jul 6, 2013 9:38:05 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210603,'Y','N','N','N',29,'N',16,'N',607,'N','Y','5f2d2eeb-6b00-47f0-9a27-90e48d2c9f05','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2013-07-06 09:38:04','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:04','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:05 AM GMT
ALTER TABLE AD_InfoRelated ADD Updated DATE NOT NULL
;

-- Jul 6, 2013 9:38:06 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210604,110,'Y','N','N','N',10,'N',18,'N',608,'N','Y','983cde5c-62b3-4ea0-af96-28714415b967','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2013-07-06 09:38:05','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:05','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:06 AM GMT
ALTER TABLE AD_InfoRelated ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jul 6, 2013 9:38:06 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210605,'Y','N','Y',1,'N',60,'Y',10,'N',469,'N','Y','130edb93-0a58-4895-aba9-50c64dabaeaa','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2013-07-06 09:38:06','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:06','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:06 AM GMT
ALTER TABLE AD_InfoRelated ADD Name NVARCHAR2(60) NOT NULL
;

-- Jul 6, 2013 9:38:10 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210606,'N','N','N','N',255,'Y',10,'N',275,'N','Y','aaca8f95-6d0c-4d6c-b2fa-d9cfd321a1af','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_DATE('2013-07-06 09:38:07','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:07','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:10 AM GMT
ALTER TABLE AD_InfoRelated ADD Description NVARCHAR2(255) DEFAULT NULL 
;

-- Jul 6, 2013 9:38:11 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210607,'N','N','N','N',2000,'N',14,'N',326,'N','Y','f13e2849-6371-42ff-8dad-12fb532c58f4','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',TO_DATE('2013-07-06 09:38:10','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:10','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:11 AM GMT
ALTER TABLE AD_InfoRelated ADD Help NVARCHAR2(2000) DEFAULT NULL 
;

-- Jul 6, 2013 9:38:12 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210608,'Y','N','N','N',10,'N',19,'N',3068,'N','Y','3c3b6796-836b-4f27-a432-524bd8d636d9','Y','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y',TO_DATE('2013-07-06 09:38:11','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:11','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:12 AM GMT
ALTER TABLE AD_InfoRelated ADD AD_InfoWindow_ID NUMBER(10) NOT NULL
;

-- Jul 6, 2013 9:38:12 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210609,'Y','N','N','N',10,'N',11,'N',566,'N','Y','68b51a70-ac68-4f53-8a98-171e0e4e7509','Y','SeqNo','Method of ordering records; lowest number comes first','The Sequence indicates the order of records','Sequence','Y',TO_DATE('2013-07-06 09:38:12','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:12','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:12 AM GMT
ALTER TABLE AD_InfoRelated ADD SeqNo NUMBER(10) NOT NULL
;

-- Jul 6, 2013 9:38:13 AM GMT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('RelatedInfo_ID',202557,'RelatedInfo_ID','RelatedInfo_ID','417c2969-095a-4137-b250-ad3b7dc34d55',TO_DATE('2013-07-06 09:38:12','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-06 09:38:12','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:14 AM GMT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy,AD_Client_ID,EntityType) VALUES (200071,'AD_RelatedInfoWindow','84852b3d-373d-4d0c-9147-7be7923e93e4','N','T',0,0,TO_DATE('2013-07-06 09:38:13','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2013-07-06 09:38:13','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 6, 2013 9:38:14 AM GMT
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Reference_ID,AD_Key,AD_Display,AD_Window_ID,AD_Table_ID,AD_Ref_Table_UU,CreatedBy,Updated,Created,UpdatedBy,AD_Org_ID,IsActive,AD_Client_ID,EntityType) VALUES ('N',200071,15744,15752,385,895,'3a863968-8b44-4b47-b0f1-50cca1b65ae0',0,TO_DATE('2013-07-06 09:38:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-06 09:38:14','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:15 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210610,200071,'Y','N','N','N',10,'N',18,'N',202557,'N','Y','97a4dff9-3272-42c9-9bf2-cf0d14abc16c','Y','RelatedInfo_ID','0','RelatedInfo_ID','Y',TO_DATE('2013-07-06 09:38:14','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:14','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:15 AM GMT
ALTER TABLE AD_InfoRelated ADD RelatedInfo_ID NUMBER(10) DEFAULT 0 NOT NULL
;

-- Jul 6, 2013 9:38:25 AM GMT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('RelatedColumn_ID',202558,'RelatedColumn_ID','RelatedColumn_ID','fc1be9d0-d099-422a-9192-bd0412b566f6',TO_DATE('2013-07-06 09:38:15','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-06 09:38:15','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:25 AM GMT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy,AD_Client_ID,EntityType) VALUES (200072,'AD_LinkInfowindow','584ab9bd-2a90-4d98-bc6b-fdff8c346a3e','N','T',0,0,TO_DATE('2013-07-06 09:38:25','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2013-07-06 09:38:25','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 6, 2013 9:38:25 AM GMT
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Reference_ID,AD_Key,AD_Display,AD_Window_ID,AD_Table_ID,AD_Ref_Table_UU,CreatedBy,Updated,Created,UpdatedBy,AD_Org_ID,IsActive,AD_Client_ID,EntityType) VALUES ('N',200072,15773,15781,385,897,'73c98762-5d7a-46c6-918f-4166d50e606a',0,TO_DATE('2013-07-06 09:38:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-06 09:38:25','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:26 AM GMT
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Org_ID,IsActive,AD_Client_ID,EntityType) VALUES ('AD_InfoColumn.AD_InfoWindow_ID=@RelatedInfo_ID@',200046,'AD_InfoColumn(related window columns)','S','5372d944-b877-4b0c-9c02-0a25c8cce42f',0,0,TO_DATE('2013-07-06 09:38:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-06 09:38:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:27 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210611,200072,'Y','N','N','N',10,'N',18,200046,'N',202558,'N','Y','7318afe5-0812-46ec-a6d3-c0c2ac9f997b','Y','RelatedColumn_ID','0','RelatedColumn_ID','Y',TO_DATE('2013-07-06 09:38:26','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:26','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:27 AM GMT
ALTER TABLE AD_InfoRelated ADD RelatedColumn_ID NUMBER(10) DEFAULT 0 NOT NULL
;

-- Jul 6, 2013 9:38:28 AM GMT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_InfoRelated_UU',202559,'InfoRelated','InfoRelated','a5b2eba1-cde4-4e88-bb39-ee4087a75833',TO_DATE('2013-07-06 09:38:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-06 09:38:27','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:28 AM GMT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType) VALUES ('Y',0,200089,210612,'N','N','N',0,'N',36,'N',10,'N',202559,'N','Y','59776e05-c2ee-4ad7-98cb-7816f6b93465','N','AD_InfoRelated_UU','InfoRelated','N',TO_DATE('2013-07-06 09:38:28','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2013-07-06 09:38:28','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N',0,'D')
;

-- Jul 6, 2013 9:38:28 AM GMT
ALTER TABLE AD_InfoRelated ADD AD_InfoRelated_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Jul 6, 2013 9:38:28 AM GMT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT AD_InfoRelated_UU_idx UNIQUE (AD_InfoRelated_UU)
;

-- Jul 6, 2013 9:38:29 AM GMT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,AD_Column_ID,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('N','N','N',385,50,'N','N',200089,'N',15744,'N','N','Y','N',1,'773e0bd5-8a1a-4697-9a6a-edb8c380d24d','Related Info Window',200100,0,TO_DATE('2013-07-06 09:38:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',0,'D')
;

-- Jul 6, 2013 9:38:30 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,36,'N','N',210612,0,'Y',202258,'N','InfoRelated','041af0da-c6fa-4002-9856-7bb72efc2310','N','N',0,0,TO_DATE('2013-07-06 09:38:29','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:29','YYYY-MM-DD HH24:MI:SS'),'Y','Y',1,'N',0,1,'D')
;

-- Jul 6, 2013 9:38:31 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,10,'N','N',210598,10,'Y',202259,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','2e94611f-d943-493d-816e-e69a7ecb2a64','Y','N',0,0,TO_DATE('2013-07-06 09:38:30','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:30','YYYY-MM-DD HH24:MI:SS'),'Y',10,'Y',1,'N',0,2,'D')
;

-- Jul 6, 2013 9:38:31 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,10,'Y','N',210599,20,'Y',202260,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','31c6d0ac-21a2-4d6e-bca5-e88f577d4581','Y','N',0,0,TO_DATE('2013-07-06 09:38:31','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:31','YYYY-MM-DD HH24:MI:SS'),'Y',20,'Y',4,'N',0,2,'D')
;

-- Jul 6, 2013 9:38:32 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,1,'N','N',210600,30,'Y',202261,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','ca430fd2-c224-40b6-81d8-48b8260913cb','Y','N',0,0,TO_DATE('2013-07-06 09:38:31','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:31','YYYY-MM-DD HH24:MI:SS'),'Y',30,'Y',2,'N',0,2,'D')
;

-- Jul 6, 2013 9:38:36 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,10,'N','N',210608,40,'Y',202262,'N','The Info window is used to search and select records as well as display information relevant to the selection.','Info and search/select Window','Info Window','773101d1-adc8-4a50-a46e-c0256a61d0e6','Y','N',0,0,TO_DATE('2013-07-06 09:38:32','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:32','YYYY-MM-DD HH24:MI:SS'),'Y',40,'Y',1,'N',0,2,'D')
;

-- Jul 6, 2013 9:38:36 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,60,'N','N',210605,50,'Y',202263,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','06b5cc6d-bb15-4d10-bb86-e3fc38797f7b','Y','N',0,0,TO_DATE('2013-07-06 09:38:36','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:36','YYYY-MM-DD HH24:MI:SS'),'Y',50,'Y',1,'N',0,5,'D')
;

-- Jul 6, 2013 9:38:37 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,255,'N','N',210606,60,'Y',202264,'N','A description is limited to 255 characters.','Optional short description of the record','Description','9e56c072-3e01-4f88-91ba-03cf0b163fae','Y','N',0,0,TO_DATE('2013-07-06 09:38:36','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:36','YYYY-MM-DD HH24:MI:SS'),'Y',60,'Y',1,'N',0,5,'D')
;

-- Jul 6, 2013 9:38:38 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (3,'N',200100,2000,'N','N',210607,70,'Y',202265,'N','The Help field contains a hint, comment or help about the use of this item.','Comment or Hint','Comment/Help','581926dc-f5e1-46e9-8665-3f789295a63d','Y','N',0,0,TO_DATE('2013-07-06 09:38:37','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:37','YYYY-MM-DD HH24:MI:SS'),'Y',70,'Y',1,'N',0,5,'D')
;

-- Jul 6, 2013 9:38:42 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,10,'N','N',210610,80,'Y',202266,'N','RelatedInfo_ID','62744643-45df-4d01-bd95-5214c5f11c1f','Y','N',0,0,TO_DATE('2013-07-06 09:38:38','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:38','YYYY-MM-DD HH24:MI:SS'),'Y',80,'Y',1,'N',0,2,'D')
;

-- Jul 6, 2013 9:38:42 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,10,'Y','N',210611,90,'Y',202267,'N','RelatedColumn_ID','40fc94fc-bd49-4bca-b9c1-c28e15b399fa','Y','N',0,0,TO_DATE('2013-07-06 09:38:42','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:42','YYYY-MM-DD HH24:MI:SS'),'Y',90,'Y',4,'N',0,2,'D')
;

-- Jul 6, 2013 9:38:43 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,SeqNoGrid,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,10,'N','N',210609,100,'Y',202268,'N','The Sequence indicates the order of records','Method of ordering records; lowest number comes first','Sequence','170ca2d8-b832-4a60-ba2c-e580f2940fd3','Y','N','N',0,0,TO_DATE('2013-07-06 09:38:42','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:42','YYYY-MM-DD HH24:MI:SS'),'Y',100,'Y',1,'N',0,2,'D')
;

-- Jul 6, 2013 9:38:44 AM GMT
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,EntityType) VALUES (1,'N',200100,10,'N','N',210597,'Y',202269,'N','InfoRelated','0f22c3e7-2e28-4e9c-a923-57a0678a5d42','N','N',0,0,TO_DATE('2013-07-06 09:38:43','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-07-06 09:38:43','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,'D')
;

-- Jan 26, 2014 2:51:07 PM COT
-- IDEMPIERE-1045 Improve info Window implementation to enable the definition of related info which will be rendered as tabs at the bottom of the content Pane
UPDATE AD_Column SET FKConstraintName='ADClient_ADInfoRelated', FKConstraintType='N',Updated=TO_DATE('2014-01-26 14:51:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210598
;

-- Jan 26, 2014 2:51:07 PM COT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT ADClient_ADInfoRelated FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 26, 2014 2:51:08 PM COT
UPDATE AD_Column SET FKConstraintName='ADOrg_ADInfoRelated', FKConstraintType='N',Updated=TO_DATE('2014-01-26 14:51:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210599
;

-- Jan 26, 2014 2:51:08 PM COT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT ADOrg_ADInfoRelated FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 26, 2014 2:51:08 PM COT
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADInfoRelated', FKConstraintType='N',Updated=TO_DATE('2014-01-26 14:51:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210602
;

-- Jan 26, 2014 2:51:08 PM COT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT CreatedBy_ADInfoRelated FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 26, 2014 2:51:08 PM COT
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADInfoRelated', FKConstraintType='N',Updated=TO_DATE('2014-01-26 14:51:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210604
;

-- Jan 26, 2014 2:51:08 PM COT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT UpdatedBy_ADInfoRelated FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 26, 2014 2:51:08 PM COT
UPDATE AD_Column SET FKConstraintName='ADInfoWindow_ADInfoRelated', FKConstraintType='N',Updated=TO_DATE('2014-01-26 14:51:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210608
;

-- Jan 26, 2014 2:51:08 PM COT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT ADInfoWindow_ADInfoRelated FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 26, 2014 2:51:08 PM COT
UPDATE AD_Column SET FKConstraintName='RelatedInfo_ADInfoRelated', FKConstraintType='N',Updated=TO_DATE('2014-01-26 14:51:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210610
;

-- Jan 26, 2014 2:51:08 PM COT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT RelatedInfo_ADInfoRelated FOREIGN KEY (RelatedInfo_ID) REFERENCES ad_infowindow(ad_infowindow_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 26, 2014 2:51:08 PM COT
UPDATE AD_Column SET FKConstraintName='RelatedColumn_ADInfoRelated', FKConstraintType='N',Updated=TO_DATE('2014-01-26 14:51:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210611
;

-- Jan 26, 2014 2:51:08 PM COT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT RelatedColumn_ADInfoRelated FOREIGN KEY (RelatedColumn_ID) REFERENCES ad_infocolumn(ad_infocolumn_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 26, 2014 2:51:44 PM COT
UPDATE AD_Column SET FKConstraintName='adprocess_adinfowindow',Updated=TO_DATE('2014-01-26 14:51:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210944
;

-- Jan 26, 2014 3:06:03 PM COT
-- IDEMPIERE-1045 Improve info Window implementation to enable the definition of related info which will be rendered as tabs at the bottom of the content Pane
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202259
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202260
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202262
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202258
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202263
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202268
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202266
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202267
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202264
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202265
;

-- Jan 26, 2014 3:06:03 PM COT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202261
;

-- Jan 26, 2014 3:07:10 PM COT
UPDATE AD_Column SET Name='AD_InfoRelated_UU',Updated=TO_DATE('2014-01-26 15:07:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210612
;

-- Jan 26, 2014 3:07:27 PM COT
UPDATE AD_Element SET Name='AD_InfoRelated_UU', PrintName='AD_InfoRelated_UU',Updated=TO_DATE('2014-01-26 15:07:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202559
;

-- Jan 26, 2014 3:07:27 PM COT
UPDATE AD_Column SET ColumnName='AD_InfoRelated_UU', Name='AD_InfoRelated_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202559
;

-- Jan 26, 2014 3:07:27 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_InfoRelated_UU', Name='AD_InfoRelated_UU', Description=NULL, Help=NULL, AD_Element_ID=202559 WHERE UPPER(ColumnName)='AD_INFORELATED_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 26, 2014 3:07:27 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_InfoRelated_UU', Name='AD_InfoRelated_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202559 AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:27 PM COT
UPDATE AD_InfoColumn SET ColumnName='AD_InfoRelated_UU', Name='AD_InfoRelated_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202559 AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:27 PM COT
UPDATE AD_Field SET Name='AD_InfoRelated_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202559) AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:27 PM COT
UPDATE AD_PrintFormatItem SET PrintName='AD_InfoRelated_UU', Name='AD_InfoRelated_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202559)
;

-- Jan 26, 2014 3:07:42 PM COT
UPDATE AD_Element SET Name='Related Info Column', PrintName='Related Info Column',Updated=TO_DATE('2014-01-26 15:07:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202558
;

-- Jan 26, 2014 3:07:42 PM COT
UPDATE AD_Column SET ColumnName='RelatedColumn_ID', Name='Related Info Column', Description=NULL, Help=NULL WHERE AD_Element_ID=202558
;

-- Jan 26, 2014 3:07:42 PM COT
UPDATE AD_Process_Para SET ColumnName='RelatedColumn_ID', Name='Related Info Column', Description=NULL, Help=NULL, AD_Element_ID=202558 WHERE UPPER(ColumnName)='RELATEDCOLUMN_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 26, 2014 3:07:42 PM COT
UPDATE AD_Process_Para SET ColumnName='RelatedColumn_ID', Name='Related Info Column', Description=NULL, Help=NULL WHERE AD_Element_ID=202558 AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:42 PM COT
UPDATE AD_InfoColumn SET ColumnName='RelatedColumn_ID', Name='Related Info Column', Description=NULL, Help=NULL WHERE AD_Element_ID=202558 AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:42 PM COT
UPDATE AD_Field SET Name='Related Info Column', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202558) AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:42 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Related Info Column', Name='Related Info Column' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202558)
;

-- Jan 26, 2014 3:07:57 PM COT
UPDATE AD_Element SET Name='Related Info Window', PrintName='Related Info Window',Updated=TO_DATE('2014-01-26 15:07:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202557
;

-- Jan 26, 2014 3:07:57 PM COT
UPDATE AD_Column SET ColumnName='RelatedInfo_ID', Name='Related Info Window', Description=NULL, Help=NULL WHERE AD_Element_ID=202557
;

-- Jan 26, 2014 3:07:57 PM COT
UPDATE AD_Process_Para SET ColumnName='RelatedInfo_ID', Name='Related Info Window', Description=NULL, Help=NULL, AD_Element_ID=202557 WHERE UPPER(ColumnName)='RELATEDINFO_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 26, 2014 3:07:57 PM COT
UPDATE AD_Process_Para SET ColumnName='RelatedInfo_ID', Name='Related Info Window', Description=NULL, Help=NULL WHERE AD_Element_ID=202557 AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:57 PM COT
UPDATE AD_InfoColumn SET ColumnName='RelatedInfo_ID', Name='Related Info Window', Description=NULL, Help=NULL WHERE AD_Element_ID=202557 AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:57 PM COT
UPDATE AD_Field SET Name='Related Info Window', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202557) AND IsCentrallyMaintained='Y'
;

-- Jan 26, 2014 3:07:57 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Related Info Window', Name='Related Info Window' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202557)
;

-- Jan 26, 2014 3:08:42 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','Related Information',200253,'D','ffd7193a-7404-450c-82f4-dad988da87b1','Related Information','Y',TO_DATE('2014-01-26 15:08:41','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-01-26 15:08:41','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jan 26, 2014 4:57:10 PM COT
-- IDEMPIERE-1045 Improve info Window implementation to enable the definition of related info which will be rendered as tabs at the bottom of the content Pane
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_DATE('2014-01-26 16:57:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200100
;

-- Jan 26, 2014 4:57:46 PM COT
UPDATE AD_Table SET AD_Window_ID=385, IsChangeLog='Y',Updated=TO_DATE('2014-01-26 16:57:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200089
;

SELECT register_migration_script('201401261340_IDEMPIERE-1045.sql') FROM dual
;

