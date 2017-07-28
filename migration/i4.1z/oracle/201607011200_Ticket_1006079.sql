SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 29, 2016 12:01:50 PM MYT
-- 1006079 Ease edit of OnLine Context Help
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,AD_Table_UU,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Org_ID,Updated,IsCentrallyMaintained,IsDeleteable,Description,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,Created,LoadSeq) VALUES ('N','N','N','4','b770748e-0795-4ef6-a243-bd30f01c8b17',200209,'N','N','N','L',0,TO_DATE('2016-06-29 12:01:43','YYYY-MM-DD HH24:MI:SS'),'Y','Y','Suggestions for field label, description and help','AD_FieldSuggestion','Field Suggestions','Y',100,100,0,'N','N','D',TO_DATE('2016-06-29 12:01:43','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jun 29, 2016 12:01:51 PM MYT
INSERT INTO AD_Sequence (StartNewYear,AD_Sequence_ID,IsTableID,IsAudited,IsAutoSequence,AD_Org_ID,Description,Name,IncrementNo,AD_Sequence_UU,CreatedBy,Updated,IsActive,StartNo,AD_Client_ID,Created,UpdatedBy,CurrentNextSys,CurrentNext) VALUES ('N',200273,'Y','N','Y',0,'Table AD_FieldSuggestion','AD_FieldSuggestion',1,'87e56a1b-5bd9-45a5-ab87-4f4981cc0f52',100,TO_DATE('2016-06-29 12:01:50','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,0,TO_DATE('2016-06-29 12:01:50','YYYY-MM-DD HH24:MI:SS'),100,200000,1000000)
;

-- Jun 29, 2016 12:02:59 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212770,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','Y','0ee6ac41-f84b-4ce6-a457-c32ead68edd1',TO_DATE('2016-06-29 12:02:58','YYYY-MM-DD HH24:MI:SS'),'N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:02:58','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',102,19,129,200209)
;

-- Jun 29, 2016 12:04:00 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212771,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','Y','ee56416a-e622-4888-8bbb-dbec5df8a53f',TO_DATE('2016-06-29 12:03:54','YYYY-MM-DD HH24:MI:SS'),'N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:03:54','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',113,19,104,200209)
;

-- Jun 29, 2016 12:05:40 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212772,0,'N',0,'Y','N','N',0,'N',7,'N','N','N','Y','bee79b12-e934-4c23-89d1-0e476dbe5cb1',TO_DATE('2016-06-29 12:05:34','YYYY-MM-DD HH24:MI:SS'),'N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:05:34','YYYY-MM-DD HH24:MI:SS'),'D','N','N',245,16,200209)
;

-- Jun 29, 2016 12:07:04 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212773,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','549a7c69-d68b-4ed4-a5e9-cea3709ed6fe',TO_DATE('2016-06-29 12:07:03','YYYY-MM-DD HH24:MI:SS'),'N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:07:03','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',246,18,110,200209)
;

-- Jun 29, 2016 12:07:50 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212774,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','387bec39-d868-4aad-9e15-c06299dd0f7b',TO_DATE('2016-06-29 12:07:44','YYYY-MM-DD HH24:MI:SS'),'Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:07:44','YYYY-MM-DD HH24:MI:SS'),'D','N','N',348,20,200209)
;

-- Jun 29, 2016 12:08:36 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212775,0,'N',0,'Y','N','N',0,'N',7,'N','N','N','Y','1cc6d9da-431b-43c5-b6bb-425ac003397d',TO_DATE('2016-06-29 12:08:30','YYYY-MM-DD HH24:MI:SS'),'N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:08:30','YYYY-MM-DD HH24:MI:SS'),'D','N','N',607,16,200209)
;

-- Jun 29, 2016 12:09:16 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212776,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','Y','78a6febb-7556-48c8-8da0-1b51be73d220',TO_DATE('2016-06-29 12:09:15','YYYY-MM-DD HH24:MI:SS'),'N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:09:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',608,18,110,200209)
;

-- Jun 29, 2016 12:10:00 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203017,'AD_FieldSuggestion_ID',TO_DATE('2016-06-29 12:09:54','YYYY-MM-DD HH24:MI:SS'),'Field Suggestions','Field Suggestions','96760464-e5c2-466b-b58e-c4b04c334040','Y',TO_DATE('2016-06-29 12:09:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 12:11:12 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203018,'AD_FieldSuggestion_UU',TO_DATE('2016-06-29 12:11:11','YYYY-MM-DD HH24:MI:SS'),'Field Suggestions UUID','Field Suggestions UUID','0bb2db56-8a92-45e4-a5de-c39d0fdf9051','Y',TO_DATE('2016-06-29 12:11:11','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 12:11:49 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212777,0,'N',0,'Y','N','N',0,'N',22,'N','Y','N','N','b9aa3b01-0c0b-42b6-8dcb-143a9c097b06',TO_DATE('2016-06-29 12:11:48','YYYY-MM-DD HH24:MI:SS'),'N','AD_FieldSuggestion_ID','Field Suggestions','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:11:48','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203017,13,200209)
;

-- Jun 29, 2016 12:12:34 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212778,0,'N',0,'Y','N','N',0,'N',36,'N','N','N','N','9fc9f656-b8e6-42f5-8d95-ccdf4f7d7630',TO_DATE('2016-06-29 12:12:28','YYYY-MM-DD HH24:MI:SS'),'N','AD_FieldSuggestion_UU','Field Suggestions UUID','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 12:12:28','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203018,10,200209)
;

-- Jun 29, 2016 3:13:55 PM MYT
-- 1006079 Ease edit of OnLine Context Help
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203019,'AD_UserClient_ID',TO_DATE('2016-06-29 15:13:54','YYYY-MM-DD HH24:MI:SS'),'Tenant of User','Tenant of User','fddba35b-0026-4aaf-8550-386fca53dc3d','Y',TO_DATE('2016-06-29 15:13:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 3:15:00 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212779,0,'N',0,'Y','N','N',0,'N',10,'N','N','N','N','da07b007-5788-44bb-a8c5-229427f68764',TO_DATE('2016-06-29 15:14:59','YYYY-MM-DD HH24:MI:SS'),'N','AD_UserClient_ID','Tenant of User','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:14:59','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203019,18,129,200209)
;

-- Jun 29, 2016 3:15:27 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212780,0,'N',0,'Y','N','N',0,'N',10,'N','N','N','N','dee70884-bdba-49cd-ad9a-b251742816a7',TO_DATE('2016-06-29 15:15:26','YYYY-MM-DD HH24:MI:SS'),'N','AD_User_ID','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:15:26','YYYY-MM-DD HH24:MI:SS'),'D','N','N',138,19,200209)
;

-- Jun 29, 2016 3:15:49 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212781,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','5fa8d3c6-917e-4d09-8933-599f920edc18',TO_DATE('2016-06-29 15:15:48','YYYY-MM-DD HH24:MI:SS'),'N','AD_Field_ID','Field on a database table','The Field identifies a field on a database table.','Field','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:15:48','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',107,19,52005,200209)
;

-- Jun 29, 2016 3:18:45 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212782,0,'N',0,'Y','N','N',0,'N',6,'N','N','N','Y','287ff24c-2ec4-4b4a-9f48-4ab09b727d23',TO_DATE('2016-06-29 15:18:44','YYYY-MM-DD HH24:MI:SS'),'N','AD_Language','Language for this entity','The Language identifies the language to use for display and formatting','Language','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:18:44','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',109,18,106,200209)
;

-- Jun 29, 2016 3:24:11 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212783,0,'N',0,'N','N','N',0,'N',60,'N','N','N','Y','b9821e07-5539-4b7d-b2f9-307759cce0f3',TO_DATE('2016-06-29 15:24:10','YYYY-MM-DD HH24:MI:SS'),'Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:24:10','YYYY-MM-DD HH24:MI:SS'),'D','N','N',469,10,200209)
;

-- Jun 29, 2016 3:24:47 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212784,0,'N',0,'N','N','N',0,'N',255,'Y','N','N','Y','e9aaf854-de07-4074-8a0f-b0921587424a',TO_DATE('2016-06-29 15:24:46','YYYY-MM-DD HH24:MI:SS'),'Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:24:46','YYYY-MM-DD HH24:MI:SS'),'D','N','N',275,10,200209)
;

-- Jun 29, 2016 3:25:28 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212785,0,'N',0,'N','N','N',0,'N',2000,'N','N','N','Y','1c3128d6-bb10-471c-9c79-f6ff157597bf',TO_DATE('2016-06-29 15:25:27','YYYY-MM-DD HH24:MI:SS'),'Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:25:27','YYYY-MM-DD HH24:MI:SS'),'D','N','N',326,14,200209)
;

-- Jun 29, 2016 3:53:42 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212786,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','5f927162-6976-4923-b0a2-25f3f2a03dd0',TO_DATE('2016-06-29 15:53:41','YYYY-MM-DD HH24:MI:SS'),'Y','IsApproved','Indicates if this document requires approval','N','The Approved checkbox indicates if this document requires approval before it can be processed.','Approved','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:53:41','YYYY-MM-DD HH24:MI:SS'),'D','N','N',351,20,200209)
;

-- Jun 29, 2016 3:54:12 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212787,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','c5e20d62-5d9e-4479-ab4e-335a15694838',TO_DATE('2016-06-29 15:54:12','YYYY-MM-DD HH24:MI:SS'),'Y','Processed','The document has been processed','N','The Processed checkbox indicates that a document has been processed.','Processed','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:54:12','YYYY-MM-DD HH24:MI:SS'),'D','N','N',1047,20,200209)
;

-- Jun 29, 2016 3:58:48 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203020,'IsUpdateBaseLanguage',TO_DATE('2016-06-29 15:58:47','YYYY-MM-DD HH24:MI:SS'),'Update Base Language','Update Base Language','bdc95da7-9fbc-4a0f-9016-f35fbf4c4684','Y',TO_DATE('2016-06-29 15:58:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 3:59:30 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212788,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','83649f9b-70ae-4e32-870d-5761e1b237c6',TO_DATE('2016-06-29 15:59:29','YYYY-MM-DD HH24:MI:SS'),'Y','IsUpdateBaseLanguage','Y','Update Base Language','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 15:59:29','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203020,20,200209)
;

-- Jun 29, 2016 4:02:15 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,AD_Org_ID,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType) VALUES (200123,'FieldSuggestionTargetList','5038c525-51b5-465e-8464-839bf9ef50fe','Y',0,'L',TO_DATE('2016-06-29 16:02:14','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_DATE('2016-06-29 16:02:14','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- Jun 29, 2016 4:02:37 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Ref_List_UU,Name,Value,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created,Updated,EntityType,AD_Reference_ID) VALUES (200361,'83c118b7-0a50-47b8-b4e4-0e0e80eb06a6','Element','E','Y',100,100,0,0,TO_DATE('2016-06-29 16:02:36','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-06-29 16:02:36','YYYY-MM-DD HH24:MI:SS'),'D',200123)
;

-- Jun 29, 2016 4:02:51 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Ref_List_UU,Name,Value,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created,Updated,EntityType,AD_Reference_ID) VALUES (200362,'74ebcb91-f3ad-4931-9049-259c936186ca','Field','F','Y',100,100,0,0,TO_DATE('2016-06-29 16:02:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-06-29 16:02:50','YYYY-MM-DD HH24:MI:SS'),'D',200123)
;

-- Jun 29, 2016 4:04:56 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203021,'FieldSuggestionTarget',TO_DATE('2016-06-29 16:04:55','YYYY-MM-DD HH24:MI:SS'),'Apply Suggestion To','Apply Suggestion To','670226ac-8491-4645-be55-83480783be85','Y',TO_DATE('2016-06-29 16:04:55','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 4:05:59 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212789,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','5ba3f8c4-df46-4889-9f61-f9cf3fbfdebd',TO_DATE('2016-06-29 16:05:58','YYYY-MM-DD HH24:MI:SS'),'Y','FieldSuggestionTarget','E','Apply Suggestion To','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 16:05:58','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203021,17,200123,200209)
;

-- Jun 29, 2016 4:15:00 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203022,'RejectSuggestion',TO_DATE('2016-06-29 16:14:59','YYYY-MM-DD HH24:MI:SS'),'Reject','Reject suggested changes','Reject','8b1c3a36-511a-4506-9d3b-cd8932034fab','Y',TO_DATE('2016-06-29 16:14:59','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 4:15:43 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203023,'AcceptSuggestion',TO_DATE('2016-06-29 16:15:42','YYYY-MM-DD HH24:MI:SS'),'Accept','Accept suggested changes','Accept','1105db44-6e5d-4ca3-b999-b6862b636e38','Y',TO_DATE('2016-06-29 16:15:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 4:17:03 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203024,'CompareSuggestion',TO_DATE('2016-06-29 16:17:02','YYYY-MM-DD HH24:MI:SS'),'Compare','Compare suggested text with original text','Compare','aea1e79d-ca75-48ef-b806-a6290a1de6fe','Y',TO_DATE('2016-06-29 16:17:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 29, 2016 4:20:34 PM MYT
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Updated,Description,IsActive,AD_Org_ID,UpdatedBy,Name,Value,Created,CreatedBy,Classname,AD_Client_ID,EntityType) VALUES ('N',200093,'N','N','a539ee7a-4729-4f44-be34-0a5dc25d374d','4','N','N',0,0,'Y',TO_DATE('2016-06-29 16:20:33','YYYY-MM-DD HH24:MI:SS'),'Reject suggested name, description and help changes','Y',0,100,'Reject Field Suggestion','RejectFieldSuggestion',TO_DATE('2016-06-29 16:20:33','YYYY-MM-DD HH24:MI:SS'),100,'org.adempiere.base.process.RejectFieldSuggestion',0,'D')
;

-- Jun 29, 2016 4:21:28 PM MYT
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Updated,Description,IsActive,AD_Org_ID,UpdatedBy,Name,Value,Created,CreatedBy,AD_Client_ID,EntityType) VALUES ('N',200094,'N','N','1227719d-e257-4780-b5dd-56eade790ac3','4','N','N',0,0,'Y',TO_DATE('2016-06-29 16:21:27','YYYY-MM-DD HH24:MI:SS'),'Accept suggested changes for field','Y',0,100,'Accept Field Suggestion','AcceptFieldSuggestion',TO_DATE('2016-06-29 16:21:27','YYYY-MM-DD HH24:MI:SS'),100,0,'D')
;

-- Jun 29, 2016 4:22:37 PM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,IsRange,AD_Process_Para_UU,AD_Reference_ID,IsMandatory,EntityType,CreatedBy,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,Updated,UpdatedBy,AD_Org_ID,IsEncrypted,Created,AD_Client_ID,AD_Element_ID,AD_Reference_Value_ID,AD_Process_ID) VALUES (200176,'N','0a31a61c-de7e-4136-a2c9-a707818e08c5',17,'Y','D',100,'Apply Suggestion To','FieldSuggestionTarget',1,'Y',10,'E','Y',TO_DATE('2016-06-29 16:22:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N',TO_DATE('2016-06-29 16:22:37','YYYY-MM-DD HH24:MI:SS'),0,203021,200123,200094)
;

-- Jun 29, 2016 4:24:08 PM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,IsRange,AD_Process_Para_UU,AD_Reference_ID,IsMandatory,EntityType,CreatedBy,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,Updated,UpdatedBy,AD_Org_ID,IsEncrypted,Created,AD_Client_ID,AD_Element_ID,AD_Process_ID) VALUES (200177,'N','65e140ce-18e3-456b-a644-e55efb394ab0',20,'Y','D',100,'Update Base Language','IsUpdateBaseLanguage',1,'Y',20,'Y','Y',TO_DATE('2016-06-29 16:24:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N',TO_DATE('2016-06-29 16:24:07','YYYY-MM-DD HH24:MI:SS'),0,203020,200094)
;

-- Jun 29, 2016 4:25:49 PM MYT
UPDATE AD_Process SET Classname='org.adempiere.base.process.AcceptFieldSuggestion',Updated=TO_DATE('2016-06-29 16:25:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200094
;

-- Jun 29, 2016 4:31:06 PM MYT
INSERT INTO AD_Form (AccessLevel,AD_Form_ID,Classname,IsBetaFunctionality,AD_Form_UU,Description,Name,CreatedBy,AD_Org_ID,IsActive,UpdatedBy,Created,Updated,AD_Client_ID,EntityType) VALUES ('4',200009,'org.adempiere.webui.apps.form.CompareFieldSuggestion','N','8cabf09d-02c0-463f-b110-45dc831654ca','Review field changes for label, descriptipn','Compare Field Suggestion',100,0,'Y',100,TO_DATE('2016-06-29 16:31:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-06-29 16:31:05','YYYY-MM-DD HH24:MI:SS'),0,'D')
;

-- Jun 29, 2016 4:31:15 PM MYT
UPDATE AD_Form SET Description='Review field changes for label, descriptipn and help',Updated=TO_DATE('2016-06-29 16:31:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=200009
;

-- Jun 29, 2016 4:32:02 PM MYT
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Updated,IsActive,AD_Org_ID,UpdatedBy,Name,Value,Created,CreatedBy,Classname,AD_Client_ID,EntityType,AD_Form_ID) VALUES ('N',200095,'N','N','3862a0d5-263d-479b-8c5e-f0db5c26cd6a','4','N','N',0,0,'N',TO_DATE('2016-06-29 16:32:01','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,'Compare Field Suggestion','CompareFieldSuggestion',TO_DATE('2016-06-29 16:32:01','YYYY-MM-DD HH24:MI:SS'),100,NULL,0,'D',200009)
;

-- Jun 29, 2016 4:34:19 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212790,0,'N',0,'N','N','N',0,'N',1,'N','N',200095,'N','N','e2bb3c6f-447e-4c49-8fb3-92dd99ed9bb6',TO_DATE('2016-06-29 16:34:18','YYYY-MM-DD HH24:MI:SS'),'Y','CompareSuggestion','Compare suggested text with original text','Compare','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 16:34:18','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203024,28,200209)
;

-- Jun 29, 2016 4:34:51 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212791,0,'N',0,'N','N','N',0,'N',1,'N','N',200093,'N','N','5ba982f4-aef9-4db7-849c-e4f4aa414ab6',TO_DATE('2016-06-29 16:34:50','YYYY-MM-DD HH24:MI:SS'),'Y','RejectSuggestion','Reject suggested changes','Reject','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 16:34:50','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203022,28,200209)
;

-- Jun 29, 2016 4:37:05 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212792,0,'N',0,'N','N','N',0,'N',1,'N','N',200094,'N','N','2cce39f4-5bf6-4384-ba6b-1d484b2a30c8',TO_DATE('2016-06-29 16:37:04','YYYY-MM-DD HH24:MI:SS'),'Y','AcceptSuggestion','Accept suggested changes','Accept','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-06-29 16:37:04','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203023,28,200209)
;

-- Jun 29, 2016 4:40:00 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADField_ADFieldSuggestion',Updated=TO_DATE('2016-06-29 16:40:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212781
;

-- Jun 29, 2016 4:40:01 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADLanguage_ADFieldSuggestion',Updated=TO_DATE('2016-06-29 16:40:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212782
;

-- Jun 29, 2016 4:40:01 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADUserClient_ADFieldSuggestion',Updated=TO_DATE('2016-06-29 16:40:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212779
;

-- Jun 29, 2016 4:40:01 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADUser_ADFieldSuggestion',Updated=TO_DATE('2016-06-29 16:40:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212780
;

-- Jun 29, 2016 4:40:01 PM MYT
CREATE TABLE AD_FieldSuggestion (AcceptSuggestion CHAR(1) DEFAULT NULL , AD_Client_ID NUMBER(10) NOT NULL, AD_Field_ID NUMBER(10) NOT NULL, AD_FieldSuggestion_ID NUMBER(10) NOT NULL, AD_FieldSuggestion_UU VARCHAR2(36) NOT NULL, AD_Language VARCHAR2(6) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_UserClient_ID NUMBER(10) NOT NULL, AD_User_ID NUMBER(10) NOT NULL, CompareSuggestion CHAR(1) DEFAULT NULL , Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255) DEFAULT NULL , FieldSuggestionTarget CHAR(1) DEFAULT 'E' NOT NULL, Help VARCHAR2(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsApproved CHAR(1) DEFAULT 'N' CHECK (IsApproved IN ('Y','N')) NOT NULL, IsUpdateBaseLanguage CHAR(1) DEFAULT 'Y' CHECK (IsUpdateBaseLanguage IN ('Y','N')) NOT NULL, Name VARCHAR2(60) DEFAULT NULL , Processed CHAR(1) DEFAULT 'N' CHECK (Processed IN ('Y','N')) NOT NULL, RejectSuggestion CHAR(1) DEFAULT NULL , Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_FieldSuggestion_Key PRIMARY KEY (AD_FieldSuggestion_ID), CONSTRAINT AD_FieldSuggestion_UU_idx UNIQUE (AD_FieldSuggestion_UU))
;

-- Jun 29, 2016 4:40:02 PM MYT
ALTER TABLE AD_FieldSuggestion ADD CONSTRAINT ADField_ADFieldSuggestion FOREIGN KEY (AD_Field_ID) REFERENCES ad_field(ad_field_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 29, 2016 4:40:02 PM MYT
ALTER TABLE AD_FieldSuggestion ADD CONSTRAINT ADLanguage_ADFieldSuggestion FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 29, 2016 4:40:02 PM MYT
ALTER TABLE AD_FieldSuggestion ADD CONSTRAINT ADUserClient_ADFieldSuggestion FOREIGN KEY (AD_UserClient_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 29, 2016 4:40:02 PM MYT
ALTER TABLE AD_FieldSuggestion ADD CONSTRAINT ADUser_ADFieldSuggestion FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 29, 2016 8:42:45 PM MYT
-- 1006079 Ease edit of OnLine Context Help
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,Processing,AD_Org_ID,Name,Description,AD_Window_ID,AD_Window_UU,IsActive,AD_Client_ID,Updated,CreatedBy,UpdatedBy,EntityType,Created) VALUES ('M','N','N','N',0,0,'N',0,'Field Suggestions','Suggestions for field name, description and help.',200087,'57f99d5c-a9fd-4b00-9cff-0b6a5fba60e3','Y',0,TO_DATE('2016-06-29 20:42:38','YYYY-MM-DD HH24:MI:SS'),100,100,'D',TO_DATE('2016-06-29 20:42:38','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 29, 2016 8:44:54 PM MYT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,WhereClause,IsReadOnly,AD_Tab_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,AD_Org_ID,Updated,Name,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,EntityType,AD_Table_ID,TreeDisplayedOn,AD_Window_ID) VALUES ('N','N','Y',10,'N','N','N','N','AD_FieldSuggestion.Processed=''N''','N',200215,'N','N',0,'d5a42b15-e903-48cd-b3b5-09a2b4126134',0,TO_DATE('2016-06-29 20:44:47','YYYY-MM-DD HH24:MI:SS'),'Suggestions',100,100,'Y',0,TO_DATE('2016-06-29 20:44:47','YYYY-MM-DD HH24:MI:SS'),'D',200209,'M',200087)
;

-- Jun 29, 2016 8:45:07 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204225,'N',22,'N','N',10,'Y','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_DATE('2016-06-29 20:45:06','YYYY-MM-DD HH24:MI:SS'),'Client/Tenant for this installation.','Client','eae331fa-a0df-4096-9edb-9a0cd530cae5','Y','N',100,100,'Y','N',0,TO_DATE('2016-06-29 20:45:06','YYYY-MM-DD HH24:MI:SS'),2,212770,'D',200215)
;

-- Jun 29, 2016 8:45:08 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204226,'N',22,'N','N',20,'Y','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_DATE('2016-06-29 20:45:07','YYYY-MM-DD HH24:MI:SS'),'Organizational entity within client','Organization','519a6921-5841-4892-932b-f559fccea789','Y','N','Y',100,100,'Y','N',4,0,TO_DATE('2016-06-29 20:45:07','YYYY-MM-DD HH24:MI:SS'),2,212771,'D',200215)
;

-- Jun 29, 2016 8:45:09 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204227,'N',60,'N','N',30,'Y','N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',0,TO_DATE('2016-06-29 20:45:08','YYYY-MM-DD HH24:MI:SS'),'Alphanumeric identifier of the entity','Name','f41d402d-8e68-4d14-9c70-91b75ed4672f','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:08','YYYY-MM-DD HH24:MI:SS'),5,212783,'D',200215)
;

-- Jun 29, 2016 8:45:10 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204228,'N',255,'N','N',40,'Y','N','A description is limited to 255 characters.',0,TO_DATE('2016-06-29 20:45:09','YYYY-MM-DD HH24:MI:SS'),'Optional short description of the record','Description','6cfe07e8-09ac-4060-bea8-e25985e4f633','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:09','YYYY-MM-DD HH24:MI:SS'),5,212784,'D',200215)
;

-- Jun 29, 2016 8:45:11 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,NumLines,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204229,'N',2000,'N','N',50,'Y','N','The Help field contains a hint, comment or help about the use of this item.',0,TO_DATE('2016-06-29 20:45:10','YYYY-MM-DD HH24:MI:SS'),'Comment or Hint','Comment/Help','d27272d3-9be6-444c-b1af-bf548d3be837','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:10','YYYY-MM-DD HH24:MI:SS'),5,3,212785,'D',200215)
;

-- Jun 29, 2016 8:45:12 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204230,'N',22,'N','N',60,'Y','N',0,TO_DATE('2016-06-29 20:45:11','YYYY-MM-DD HH24:MI:SS'),'Field Suggestions','7f75e0dd-b1c8-48db-b21a-2e2f87825c33','N','N',100,100,'Y','N',0,TO_DATE('2016-06-29 20:45:11','YYYY-MM-DD HH24:MI:SS'),2,212777,'D',200215)
;

-- Jun 29, 2016 8:45:13 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204231,'N',36,'N','N',70,'Y','N',0,TO_DATE('2016-06-29 20:45:12','YYYY-MM-DD HH24:MI:SS'),'Field Suggestions UUID','b2c443ad-bfc8-4012-9ef1-f47aadefaf52','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:12','YYYY-MM-DD HH24:MI:SS'),2,212778,'D',200215)
;

-- Jun 29, 2016 8:45:14 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204232,'N',10,'N','N',80,'Y','N',0,TO_DATE('2016-06-29 20:45:13','YYYY-MM-DD HH24:MI:SS'),'Tenant of User','18758bf0-dde5-49dc-9bbf-546a627250ee','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:13','YYYY-MM-DD HH24:MI:SS'),2,212779,'D',200215)
;

-- Jun 29, 2016 8:45:15 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204233,'N',10,'N','N',90,'Y','N','The User identifies a unique user in the system. This could be an internal user or a business partner contact',0,TO_DATE('2016-06-29 20:45:14','YYYY-MM-DD HH24:MI:SS'),'User within the system - Internal or Business Partner Contact','User/Contact','be538f56-55ff-4d71-9bc6-6124f728cf0a','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:14','YYYY-MM-DD HH24:MI:SS'),2,212780,'D',200215)
;

-- Jun 29, 2016 8:45:16 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204234,'N',22,'N','N',100,'Y','N','The Field identifies a field on a database table.',0,TO_DATE('2016-06-29 20:45:15','YYYY-MM-DD HH24:MI:SS'),'Field on a database table','Field','38344d71-1592-4041-81b4-c8dd0257e4c5','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:15','YYYY-MM-DD HH24:MI:SS'),2,212781,'D',200215)
;

-- Jun 29, 2016 8:45:16 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204235,'N',6,'N','N',110,'Y','N','The Language identifies the language to use for display and formatting',0,TO_DATE('2016-06-29 20:45:16','YYYY-MM-DD HH24:MI:SS'),'Language for this entity','Language','f17a292b-9746-47de-a12a-6c9c1e6bcd0e','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:16','YYYY-MM-DD HH24:MI:SS'),2,212782,'D',200215)
;

-- Jun 29, 2016 8:45:17 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204236,'N',1,'N','N',120,'Y','N','The Approved checkbox indicates if this document requires approval before it can be processed.',0,TO_DATE('2016-06-29 20:45:17','YYYY-MM-DD HH24:MI:SS'),'Indicates if this document requires approval','Approved','4de1928e-2404-413c-a1ad-02f0e229af1f','Y','N',100,100,'Y',2,0,TO_DATE('2016-06-29 20:45:17','YYYY-MM-DD HH24:MI:SS'),2,212786,'D',200215)
;

-- Jun 29, 2016 8:45:18 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204237,'N',1,'N','N',130,'Y','N','The Processed checkbox indicates that a document has been processed.',0,TO_DATE('2016-06-29 20:45:17','YYYY-MM-DD HH24:MI:SS'),'The document has been processed','Processed','ac8b0e15-f5c8-42d7-956b-fa135d167432','Y','N',100,100,'Y',2,0,TO_DATE('2016-06-29 20:45:17','YYYY-MM-DD HH24:MI:SS'),2,212787,'D',200215)
;

-- Jun 29, 2016 8:45:19 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204238,'N',1,'N','N',140,'Y','N',0,TO_DATE('2016-06-29 20:45:18','YYYY-MM-DD HH24:MI:SS'),'Update Base Language','53d28f48-55d5-4cba-9b30-f4ea061f0307','Y','N',100,100,'Y',2,0,TO_DATE('2016-06-29 20:45:18','YYYY-MM-DD HH24:MI:SS'),2,212788,'D',200215)
;

-- Jun 29, 2016 8:45:20 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204239,'N',1,'N','N',150,'Y','N',0,TO_DATE('2016-06-29 20:45:19','YYYY-MM-DD HH24:MI:SS'),'Apply Suggestion To','184444c4-773b-4532-85a1-b63f05710df8','Y','N',100,100,'Y',0,TO_DATE('2016-06-29 20:45:19','YYYY-MM-DD HH24:MI:SS'),2,212789,'D',200215)
;

-- Jun 29, 2016 8:45:21 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204240,'N',1,'N','N',160,'Y','N',0,TO_DATE('2016-06-29 20:45:20','YYYY-MM-DD HH24:MI:SS'),'Compare suggested text with original text','Compare','6ea9e8d8-1acc-4199-82d6-ed5f8317761f','Y','N',100,100,'Y',2,0,TO_DATE('2016-06-29 20:45:20','YYYY-MM-DD HH24:MI:SS'),2,212790,'D',200215)
;

-- Jun 29, 2016 8:45:22 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204241,'N',1,'N','N',170,'Y','N',0,TO_DATE('2016-06-29 20:45:21','YYYY-MM-DD HH24:MI:SS'),'Reject suggested changes','Reject','9a299064-f556-41f6-85f7-f5e329f291c9','Y','N',100,100,'Y',2,0,TO_DATE('2016-06-29 20:45:21','YYYY-MM-DD HH24:MI:SS'),2,212791,'D',200215)
;

-- Jun 29, 2016 8:45:23 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204242,'N',1,'N','N',180,'Y','N',0,TO_DATE('2016-06-29 20:45:22','YYYY-MM-DD HH24:MI:SS'),'Accept suggested changes','Accept','60ce6b8d-5aff-4875-b6fd-761d36142a1d','Y','N',100,100,'Y',2,0,TO_DATE('2016-06-29 20:45:22','YYYY-MM-DD HH24:MI:SS'),2,212792,'D',200215)
;

-- Jun 29, 2016 8:45:24 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204243,'N',1,'N','N',190,'Y','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_DATE('2016-06-29 20:45:23','YYYY-MM-DD HH24:MI:SS'),'The record is active in the system','Active','9018b685-3ed9-415a-a825-d520850f00df','Y','N',100,100,'Y',2,0,TO_DATE('2016-06-29 20:45:23','YYYY-MM-DD HH24:MI:SS'),2,212774,'D',200215)
;

-- Jun 29, 2016 8:50:03 PM MYT
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2016-06-29 20:50:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204232
;

-- Jun 29, 2016 8:50:03 PM MYT
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2016-06-29 20:50:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204233
;

-- Jun 29, 2016 8:50:03 PM MYT
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2016-06-29 20:50:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204234
;

-- Jun 29, 2016 8:50:03 PM MYT
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2016-06-29 20:50:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204235
;

-- Jun 29, 2016 8:50:04 PM MYT
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2016-06-29 20:50:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204243
;

-- Jun 29, 2016 8:50:04 PM MYT
UPDATE AD_Field SET SeqNo=80, ColumnSpan=2,Updated=TO_DATE('2016-06-29 20:50:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204227
;

-- Jun 29, 2016 8:50:04 PM MYT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2016-06-29 20:50:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204228
;

-- Jun 29, 2016 8:50:05 PM MYT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2016-06-29 20:50:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204229
;

-- Jun 29, 2016 8:50:05 PM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2016-06-29 20:50:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204240
;

-- Jun 29, 2016 8:50:05 PM MYT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2016-06-29 20:50:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204241
;

-- Jun 29, 2016 8:50:05 PM MYT
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2016-06-29 20:50:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204242
;

-- Jun 29, 2016 8:50:06 PM MYT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2016-06-29 20:50:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204239
;

-- Jun 29, 2016 8:50:06 PM MYT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2016-06-29 20:50:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204236
;

-- Jun 29, 2016 8:50:06 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2016-06-29 20:50:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204230
;

-- Jun 29, 2016 8:50:07 PM MYT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2016-06-29 20:50:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204231
;

-- Jun 29, 2016 8:50:07 PM MYT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2016-06-29 20:50:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204237
;

-- Jun 29, 2016 8:50:07 PM MYT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2016-06-29 20:50:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204238
;

-- Jun 29, 2016 8:50:38 PM MYT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2016-06-29 20:50:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204232
;

-- Jun 29, 2016 8:50:46 PM MYT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2016-06-29 20:50:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204233
;

-- Jun 29, 2016 8:50:54 PM MYT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2016-06-29 20:50:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204234
;

-- Jun 29, 2016 8:51:01 PM MYT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2016-06-29 20:51:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204235
;

-- Jun 29, 2016 8:53:05 PM MYT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,AD_Menu_UU,IsSOTrx,IsReadOnly,IsCentrallyMaintained,Name,Action,IsActive,CreatedBy,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,EntityType,AD_Window_ID) VALUES (200142,'N','cb37707c-7ed0-449e-b623-84ad84b9d569','N','N','Y','Field Suggestions','W','Y',100,0,0,TO_DATE('2016-06-29 20:52:59','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-06-29 20:52:59','YYYY-MM-DD HH24:MI:SS'),100,'D',200087)
;

-- Jun 29, 2016 8:53:05 PM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200142, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200142)
;

-- Jun 29, 2016 8:53:06 PM MYT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200142, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200142)
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200142
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Jun 29, 2016 8:54:25 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Jun 29, 2016 8:54:26 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Jun 30, 2016 5:00:07 PM MYT
-- 1006079 Ease edit of OnLine Context Help
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,ColumnSQL,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212793,0,'N',0,'N','N','N',0,'N',22,'Y','N','N','N','1d13c592-3dcc-4f16-811d-91d1e8d8a9ea',TO_DATE('2016-06-30 17:00:01','YYYY-MM-DD HH24:MI:SS'),'N','AD_Window_ID','Data entry or display window','(select a.ad_window_id from ad_tab a, ad_field b where a.ad_tab_id=b.ad_tab_id and b.ad_field_id=ad_fieldsuggestion.ad_field_id)','The Window field identifies a unique Window in the system.','Window','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-30 17:00:01','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',143,19,200209)
;

-- Jun 30, 2016 5:01:45 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,ColumnSQL,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212794,0,'N',0,'N','N','N',0,'N',10,'Y','N','N','N','cf31e2a8-014e-49e3-95fa-fa6008c16fc0',TO_DATE('2016-06-30 17:01:39','YYYY-MM-DD HH24:MI:SS'),'N','AD_Tab_ID','Tab within a Window','(select a.ad_tab_id from ad_tab a, ad_field b where a.ad_tab_id=b.ad_tab_id and b.ad_field_id=ad_fieldsuggestion.ad_field_id)','The Tab indicates a tab that displays within a window.','Tab','N','Y',100,100,'N','N',0,0,TO_DATE('2016-06-30 17:01:39','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',125,19,163,200209)
;

-- Jun 30, 2016 5:02:25 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204244,'N',0,'N','N',140,'Y','N','The Window field identifies a unique Window in the system.',0,TO_DATE('2016-06-30 17:02:22','YYYY-MM-DD HH24:MI:SS'),'Data entry or display window','Window','92c338a2-6907-4cf1-8719-2269979a3954','Y','N',100,100,'Y','Y',10,1,'N',0,TO_DATE('2016-06-30 17:02:22','YYYY-MM-DD HH24:MI:SS'),1,1,'N','N',212793,'D',200215)
;

-- Jun 30, 2016 5:02:48 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204245,'N',0,'N','N',150,'Y','N','The Tab indicates a tab that displays within a window.',0,TO_DATE('2016-06-30 17:02:47','YYYY-MM-DD HH24:MI:SS'),'Tab within a Window','Tab','60b6c2c7-040b-470a-8604-39bc4dfc1bc5','Y','N',100,100,'Y','Y',20,1,'N',0,TO_DATE('2016-06-30 17:02:47','YYYY-MM-DD HH24:MI:SS'),1,1,'N','N',212794,'D',200215)
;

-- Jun 30, 2016 5:03:34 PM MYT
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_DATE('2016-06-30 17:03:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204244
;

-- Jun 30, 2016 5:03:35 PM MYT
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2016-06-30 17:03:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204245
;

-- Jun 30, 2016 5:03:35 PM MYT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2016-06-30 17:03:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204234
;

-- Jun 30, 2016 5:03:35 PM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2016-06-30 17:03:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204235
;

-- Jun 30, 2016 5:03:35 PM MYT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2016-06-30 17:03:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204243
;

-- Jun 30, 2016 5:03:36 PM MYT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2016-06-30 17:03:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204227
;

-- Jun 30, 2016 5:03:36 PM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2016-06-30 17:03:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204228
;

-- Jun 30, 2016 5:03:36 PM MYT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2016-06-30 17:03:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204229
;

-- Jun 30, 2016 5:03:36 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2016-06-30 17:03:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204240
;

-- Jun 30, 2016 5:03:36 PM MYT
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2016-06-30 17:03:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204241
;

-- Jun 30, 2016 5:03:37 PM MYT
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2016-06-30 17:03:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204242
;

-- Jun 30, 2016 7:15:24 PM MYT
-- 1006079 Ease edit of OnLine Context Help
UPDATE AD_Table SET IsDeleteable='N',Updated=TO_DATE('2016-06-30 19:15:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200209
;

-- Jun 30, 2016 10:13:22 PM MYT
-- 1006079 Ease edit of OnLine Context Help
UPDATE AD_Column SET IsSelectionColumn='N',Updated=TO_DATE('2016-06-30 22:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212784
;

-- Jun 30, 2016 10:13:53 PM MYT
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_DATE('2016-06-30 22:13:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212781
;

SELECT register_migration_script('201607011200_Ticket_1006079.sql') FROM dual
;

