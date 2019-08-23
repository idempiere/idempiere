-- IDEMPIERE-4032 Financial Report Translation (lines & column)
-- Aug 22, 2019, 9:40:40 AM BRT
UPDATE AD_Column SET IsTranslated='Y', SeqNoSelection=10,Updated=TO_TIMESTAMP('2019-08-22 09:40:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6043
;

-- Aug 22, 2019, 9:40:49 AM BRT
UPDATE AD_Column SET IsTranslated='Y', SeqNoSelection=20,Updated=TO_TIMESTAMP('2019-08-22 09:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6042
;

-- Aug 22, 2019, 9:43:43 AM BRT
UPDATE AD_Column SET IsTranslated='Y', SeqNoSelection=10,Updated=TO_TIMESTAMP('2019-08-22 09:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6008
;

-- Aug 22, 2019, 9:44:04 AM BRT
UPDATE AD_Column SET IsTranslated='Y', SeqNoSelection=20,Updated=TO_TIMESTAMP('2019-08-22 09:44:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6010
;

-- Aug 22, 2019, 9:44:43 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200259,'Report Column Translation','Column in Report Translation',217,'PA_ReportColumn_Trl',145,'7',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:44:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:44:43','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','Y','L','Y','c2efd726-c0a6-4376-a0f6-3a3fb8ef27a0','N')
;

-- Aug 22, 2019, 9:44:43 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('PA_ReportColumn_Trl',1000000,'N','N','Table PA_ReportColumn_Trl','Y','Y',0,0,TO_TIMESTAMP('2019-08-22 09:44:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:44:43','YYYY-MM-DD HH24:MI:SS'),100,200322,'Y',1000000,1,200000,'82b1108e-9e72-42bb-b2f7-c30cd2502849')
;

-- Aug 22, 2019, 9:45:47 AM BRT
UPDATE AD_Column SET IsTranslated='Y', SeqNoSelection=10,Updated=TO_TIMESTAMP('2019-08-22 09:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6056
;

-- Aug 22, 2019, 9:46:06 AM BRT
UPDATE AD_Column SET IsTranslated='Y', SeqNoSelection=20,Updated=TO_TIMESTAMP('2019-08-22 09:46:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6054
;

-- Aug 22, 2019, 9:46:28 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200260,'Report Line Translation',218,'PA_ReportLine_Trl',135,'3',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:46:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:46:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','Y','L','Y','08b014f2-3f68-4b80-855d-7a1b669339ff','N')
;

-- Aug 22, 2019, 9:46:28 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('PA_ReportLine_Trl',1000000,'N','N','Table PA_ReportLine_Trl','Y','Y',0,0,TO_TIMESTAMP('2019-08-22 09:46:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:46:28','YYYY-MM-DD HH24:MI:SS'),100,200323,'Y',1000000,1,200000,'b0457edd-f4de-44ce-98eb-7c416f34ae0e')
;

-- Aug 22, 2019, 9:46:56 AM BRT
UPDATE AD_Table SET IsDeleteable='Y', IsChangeLog='N',Updated=TO_TIMESTAMP('2019-08-22 09:46:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200259
;

-- Aug 22, 2019, 9:47:00 AM BRT
UPDATE AD_Table SET IsDeleteable='Y',Updated=TO_TIMESTAMP('2019-08-22 09:47:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200260
;

-- Aug 22, 2019, 9:47:12 AM BRT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2019-08-22 09:47:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200259
;

-- Aug 22, 2019, 9:53:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213987,0.0,'Report Line',200260,'PA_ReportLine_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,1614,'N','N','D','N','0b273e07-b059-4c41-8ade-0754f7dbdde7','N','C')
;

-- Aug 22, 2019, 9:53:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213988,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200260,'AD_Language',6,'N','N','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','8f409eea-52da-48c1-be29-08f720eb304f','N','N')
;

-- Aug 22, 2019, 9:53:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213989,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200260,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','edba774d-422e-402b-9491-790819d1e9c0','N','D')
;

-- Aug 22, 2019, 9:53:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213990,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200260,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','603f9c0b-7e1a-438a-8600-3af85f6f9b4d','N','D')
;

-- Aug 22, 2019, 9:53:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213991,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200260,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','ea24b560-de03-4a20-8140-253a31243843','N')
;

-- Aug 22, 2019, 9:53:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213992,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200260,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','126f5b95-898e-455e-a7b9-0ae8e064f437','N')
;

-- Aug 22, 2019, 9:53:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213993,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200260,'CreatedBy',10,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','3444c5ce-4d75-4513-b1a9-8448fa5c1840','N','D')
;

-- Aug 22, 2019, 9:53:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213994,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200260,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:21','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','5fc96081-e0f2-4605-8aa0-ccd1fdd30e03','N')
;

-- Aug 22, 2019, 9:53:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213995,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200260,'UpdatedBy',10,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','c73288c2-d8e6-4141-81a5-89ead1fdeb89','N','D')
;

-- Aug 22, 2019, 9:53:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (213996,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200260,'Name',255,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','e83465a8-312c-466f-9671-cd9a3391cd90',10,'N')
;

-- Aug 22, 2019, 9:53:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213997,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200260,'IsTranslated',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','d7192cff-c075-4e68-ac4e-4cccd64a6db4','N')
;

-- Aug 22, 2019, 9:53:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (213998,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200260,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','c065bbee-0fa6-4245-8898-e83aaa6846e6',20,'N')
;

-- Aug 22, 2019, 9:53:22 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203354,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,'PA_ReportLine_Trl_UU','PA_ReportLine_Trl_UU','PA_ReportLine_Trl_UU','D','7f1013e3-a955-427f-982b-1e1c27f685c1')
;

-- Aug 22, 2019, 9:53:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213999,0.0,'PA_ReportLine_Trl_UU',200260,'PA_ReportLine_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:22','YYYY-MM-DD HH24:MI:SS'),100,203354,'N','N','D','N','c8bd4973-5235-4a20-a30b-680da290abb3','N')
;

-- Aug 22, 2019, 9:53:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214000,0.0,'Report Column','Column in Report',200259,'PA_ReportColumn_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,1601,'N','N','D','N','bca589ea-18d1-46ed-8596-61ba39259532','N')
;

-- Aug 22, 2019, 9:53:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214001,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200259,'AD_Language',6,'N','N','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','d7b2c894-a299-4d0a-acd5-216f12265b4e','N','N')
;

-- Aug 22, 2019, 9:53:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214002,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200259,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','0e8b0dd6-d7fb-4997-8700-9cf8a930a965','N','D')
;

-- Aug 22, 2019, 9:53:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214003,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200259,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','1f80324d-2439-45dd-964a-d4cee2bd867d','N','D')
;

-- Aug 22, 2019, 9:53:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214004,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200259,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:35','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','c4285f6b-ce4f-4939-8809-a13ae64b8ab6','N')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214005,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200259,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','e0d3c7e3-295b-4cfa-a03e-64235456638a','N')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214006,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200259,'CreatedBy',10,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','4fc9bd69-c2b2-4c4d-846e-182d49aa0b84','N','D')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214007,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200259,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','ce13d655-e6d9-40df-b4ea-522c918b51cd','N')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214008,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200259,'UpdatedBy',10,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','64594ab8-8b83-4af4-9e07-6b95fef35b7e','N','D')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214009,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200259,'Name',255,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','89168b94-8625-4ab0-89a4-a8ee00647467',10,'N')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214010,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200259,'IsTranslated',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','b08e7a46-bcbd-4d19-9ea8-3e8c5f400196','N')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214011,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200259,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','658de9c6-7947-471f-9b6f-18727138c5e8',20,'N')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203355,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,'PA_ReportColumn_Trl_UU','PA_ReportColumn_Trl_UU','PA_ReportColumn_Trl_UU','D','fb249b5c-012b-4e9c-b151-f72d1855a713')
;

-- Aug 22, 2019, 9:53:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214012,0.0,'PA_ReportColumn_Trl_UU',200259,'PA_ReportColumn_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:53:36','YYYY-MM-DD HH24:MI:SS'),100,203355,'N','N','D','N','c25437fe-e8c1-4f1f-8db5-861e6fb42241','N')
;

-- Aug 22, 2019, 9:55:13 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200271,'Translation',218,40,'Y',200260,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',2,'N','D','Y','N','3d76586d-4f9c-4b2d-8e39-b0aae583d74c','B')
;

-- Aug 22, 2019, 9:55:33 AM BRT
UPDATE AD_Tab SET IsTranslationTab='Y', IsInsertRecord='N',Updated=TO_TIMESTAMP('2019-08-22 09:55:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200271
;

-- Aug 22, 2019, 9:55:42 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206149,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200271,213989,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e060549e-b1bd-496a-baa9-404a3c6eb5a3','N',2)
;

-- Aug 22, 2019, 9:55:42 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206150,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200271,213990,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1c69247e-47f5-44ae-9b0c-858a5af55272','Y','Y',10,4,2)
;

-- Aug 22, 2019, 9:55:42 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206151,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200271,213996,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','00f6e131-5ac3-4f15-826b-f162f89c3afb','Y',20,5)
;

-- Aug 22, 2019, 9:55:42 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206152,'Description','Optional short description of the record','A description is limited to 255 characters.',200271,213998,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a48e0839-ec03-4be8-a574-0d5158d5dfd2','Y',30,5)
;

-- Aug 22, 2019, 9:55:42 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206153,'Report Line',200271,213987,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','47605942-0627-4716-b9fa-bacb6e274d3e','Y',40,2)
;

-- Aug 22, 2019, 9:55:43 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206154,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200271,213988,'Y',6,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6b0147d8-1b0f-402a-af8a-180d107086d3','Y',50,2)
;

-- Aug 22, 2019, 9:55:43 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206155,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200271,213997,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cad5f757-4a7b-4067-a231-afadda4fe487','Y',60,2,2)
;

-- Aug 22, 2019, 9:55:43 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206156,'PA_ReportLine_Trl_UU',200271,213999,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4274a9f1-53e8-42b6-bdb0-578b07f75eac','N',2)
;

-- Aug 22, 2019, 9:55:43 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206157,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200271,213991,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:55:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:55:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8796e022-05fb-43bb-a1e4-0b3d9f178d3e','Y',70,2,2)
;

-- Aug 22, 2019, 9:56:41 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206153
;

-- Aug 22, 2019, 9:56:41 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206154
;

-- Aug 22, 2019, 9:56:41 AM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206151
;

-- Aug 22, 2019, 9:56:41 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206152
;

-- Aug 22, 2019, 9:56:41 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206157
;

-- Aug 22, 2019, 9:56:41 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206155
;

-- Aug 22, 2019, 9:56:41 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206156
;

-- Aug 22, 2019, 9:57:04 AM BRT
UPDATE AD_Tab SET SeqNo=25,Updated=TO_TIMESTAMP('2019-08-22 09:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200271
;

-- Aug 22, 2019, 9:57:48 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200272,'Translation',217,30,'Y',200259,0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','Y','N','N','N',0,'N','D','N','N','efbf3721-2588-4b98-b836-4f0288a60710','B')
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206158,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200272,214002,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','535cdc66-698a-4f53-8802-cf61cbc17554','N',2)
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206159,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200272,214003,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','63c757ef-9a94-4d32-9d44-824194f174dd','Y','Y',10,4,2)
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206160,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200272,214009,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','34fbd7a5-45f5-42ac-9fc1-507d7ac690d0','Y',20,5)
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206161,'Description','Optional short description of the record','A description is limited to 255 characters.',200272,214011,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d3d1cf08-44cf-4def-9556-4d0c2d130c9c','Y',30,5)
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206162,'Report Column','Column in Report',200272,214000,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9302fa59-8a9f-47e5-a476-ac39a1e3025f','Y',40,2)
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206163,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200272,214001,'Y',6,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','69a25d77-17ea-4d1a-aa0d-d784ff6cef70','Y',50,2)
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206164,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200272,214010,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0c591fb2-be6d-42fe-b6f9-92b81221f52a','Y',60,2,2)
;

-- Aug 22, 2019, 9:57:57 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206165,'PA_ReportColumn_Trl_UU',200272,214012,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1547b346-d5ac-4d13-bbb8-6fd6184d049d','N',2)
;

-- Aug 22, 2019, 9:57:58 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206166,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200272,214004,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-22 09:57:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6da75a84-2b34-4ab8-b729-07d126e6c28f','Y',70,2,2)
;

-- Aug 22, 2019, 9:58:25 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206162
;

-- Aug 22, 2019, 9:58:25 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206163
;

-- Aug 22, 2019, 9:58:25 AM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206160
;

-- Aug 22, 2019, 9:58:26 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206161
;

-- Aug 22, 2019, 9:58:26 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206166
;

-- Aug 22, 2019, 9:58:26 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206164
;

-- Aug 22, 2019, 9:58:26 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-08-22 09:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206165
;

-- Aug 22, 2019, 9:58:34 AM BRT
UPDATE AD_Tab SET TabLevel=2,Updated=TO_TIMESTAMP('2019-08-22 09:58:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200272
;

-- Aug 22, 2019, 10:40:34 AM BRT
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2019-08-22 10:40:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214000
;

-- Aug 22, 2019, 10:40:41 AM BRT
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2019-08-22 10:40:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213987
;

-- 22 de ago de 2019 10:43:46 BRT
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2019-08-22 10:43:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200259
;

-- 22 de ago de 2019 10:48:19 BRT
UPDATE AD_Column SET IsTranslated='N',Updated=TO_TIMESTAMP('2019-08-22 10:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6042
;

-- 22 de ago de 2019 10:48:30 BRT
UPDATE AD_Column SET IsTranslated='N',Updated=TO_TIMESTAMP('2019-08-22 10:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6043
;

-- Drop table

-- DROP TABLE pa_reportcolumn_trl;

--CREATE TABLE pa_reportcolumn_trl (
	--pa_reportcolumn_id numeric(10) NOT NULL,
	--ad_language varchar(6) NOT NULL,
	--ad_client_id numeric(10) NOT NULL,
	--ad_org_id numeric(10) NOT NULL,
	--isactive bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
	--created timestamp NOT NULL DEFAULT now(),
	--createdby numeric(10) NOT NULL,
	--updated timestamp NOT NULL DEFAULT now(),
	--updatedby numeric(10) NOT NULL,
	--"name" varchar(255) NOT NULL,
	--istranslated bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	--description varchar(255) NULL,
	--pa_reportcolumn_trl_uu varchar(36) NULL DEFAULT NULL::character varying,
	--CONSTRAINT pa_reportcolumn_trl_isactive_check CHECK ((isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
	--CONSTRAINT pa_reportcolumn_trl_istranslated_check CHECK ((istranslated = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
	--CONSTRAINT pa_reportcolumn_trl_pkey PRIMARY KEY (pa_reportcolumn_id, ad_language),
	--CONSTRAINT adlanguage_mreportcolumntrl FOREIGN KEY (ad_language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED,
	--CONSTRAINT mreportcolumn_mreportcolumntrl FOREIGN KEY (pa_reportcolumn_id) REFERENCES pa_reportcolumn(pa_reportcolumn_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
--);
--CREATE UNIQUE INDEX pa_reportcolumn_trl_uu_idx ON pa_reportcolumn_trl USING btree (pa_reportcolumn_trl_uu);

-- Permissions

--ALTER TABLE pa_reportcolumn_trl OWNER TO brerp;
--GRANT ALL ON TABLE pa_reportcolumn_trl TO brerp;

-- Drop table

-- DROP TABLE pa_reportline_trl;

--CREATE TABLE pa_reportline_trl (
	--pa_reportline_id numeric(10) NOT NULL,
	--ad_language varchar(6) NOT NULL,
	--ad_client_id numeric(10) NOT NULL,
	--ad_org_id numeric(10) NOT NULL,
	--isactive bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
	--created timestamp NOT NULL DEFAULT now(),
	--createdby numeric(10) NOT NULL,
	--updated timestamp NOT NULL DEFAULT now(),
	--updatedby numeric(10) NOT NULL,
	--"name" varchar(255) NOT NULL,
	--istranslated bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	--description varchar(255) NULL,
	--pa_reportline_trl_uu varchar(36) NULL DEFAULT NULL::character varying,
	--CONSTRAINT pa_reportline_trl_isactive_check CHECK ((isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
	--CONSTRAINT pa_reportline_trl_istranslated_check CHECK ((istranslated = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
	--CONSTRAINT pa_reportline_trl_pkey PRIMARY KEY (pa_reportline_id, ad_language),
	--CONSTRAINT adlanguage_mreportlinetrl FOREIGN KEY (ad_language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED,
	--CONSTRAINT mreportline_mreportlinetrl FOREIGN KEY (pa_reportline_id) REFERENCES pa_reportline(pa_reportline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
--);
--CREATE UNIQUE INDEX pa_reportline_trl_uu_idx ON pa_reportline_trl USING btree (pa_reportline_trl_uu);

-- Permissions

--ALTER TABLE pa_reportline_trl OWNER TO brerp;
--GRANT ALL ON TABLE pa_reportline_trl TO brerp;


-- Aug 23, 2019, 12:05:48 PM CEST
UPDATE AD_Column SET FKConstraintName='ADLanguage_PAReportColumnTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-08-23 12:05:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214001
;

-- Aug 23, 2019, 12:05:49 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='PAReportColumn_PAReportColumnT', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-08-23 12:05:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214000
;

-- Aug 23, 2019, 12:05:49 PM CEST
CREATE TABLE PA_ReportColumn_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(255) NOT NULL, PA_ReportColumn_ID NUMERIC(10) NOT NULL, PA_ReportColumn_Trl_UU VARCHAR(36) DEFAULT NULL , Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT PA_ReportColumn_Trl_UU_idx UNIQUE (PA_ReportColumn_Trl_UU))
;

-- Aug 23, 2019, 12:05:49 PM CEST
ALTER TABLE PA_ReportColumn_Trl ADD CONSTRAINT ADLanguage_PAReportColumnTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 23, 2019, 12:05:49 PM CEST
ALTER TABLE PA_ReportColumn_Trl ADD CONSTRAINT PAReportColumn_PAReportColumnT FOREIGN KEY (PA_ReportColumn_ID) REFERENCES pa_reportcolumn(pa_reportcolumn_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 23, 2019, 12:06:17 PM CEST
UPDATE AD_Column SET FKConstraintName='ADLanguage_PAReportLineTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-08-23 12:06:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213988
;

-- Aug 23, 2019, 12:06:17 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='PAReportLine_PAReportLineTrl', FKConstraintType='C',Updated=TO_TIMESTAMP('2019-08-23 12:06:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213987
;

-- Aug 23, 2019, 12:06:17 PM CEST
CREATE TABLE PA_ReportLine_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(255) NOT NULL, PA_ReportLine_ID NUMERIC(10) NOT NULL, PA_ReportLine_Trl_UU VARCHAR(36) DEFAULT NULL , Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT PA_ReportLine_Trl_UU_idx UNIQUE (PA_ReportLine_Trl_UU))
;

-- Aug 23, 2019, 12:06:17 PM CEST
ALTER TABLE PA_ReportLine_Trl ADD CONSTRAINT ADLanguage_PAReportLineTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 23, 2019, 12:06:18 PM CEST
ALTER TABLE PA_ReportLine_Trl ADD CONSTRAINT PAReportLine_PAReportLineTrl FOREIGN KEY (PA_ReportLine_ID) REFERENCES pa_reportline(pa_reportline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Aug 23, 2019, 12:06:40 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing) VALUES (0,0,201075,'a67484ed-1e7c-4237-8060-258591e25976',TO_TIMESTAMP('2019-08-23 12:06:39','YYYY-MM-DD HH24:MI:SS'),100,'U','Y','pa_reportcolumn_trl_uu_idx',TO_TIMESTAMP('2019-08-23 12:06:39','YYYY-MM-DD HH24:MI:SS'),100,200259,'N','Y','N')
;

-- Aug 23, 2019, 12:06:40 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201390,'4d2d5ca6-a56d-4585-a751-cc59975db329',TO_TIMESTAMP('2019-08-23 12:06:40','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2019-08-23 12:06:40','YYYY-MM-DD HH24:MI:SS'),100,214012,201075,1)
;

-- Aug 23, 2019, 12:07:12 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing) VALUES (0,0,201076,'d0e3c1fd-9d91-4e77-8f64-72fe821a4d5e',TO_TIMESTAMP('2019-08-23 12:07:12','YYYY-MM-DD HH24:MI:SS'),100,'U','Y','pa_reportline_trl_uu_idx',TO_TIMESTAMP('2019-08-23 12:07:12','YYYY-MM-DD HH24:MI:SS'),100,200260,'N','Y','N')
;

-- Aug 23, 2019, 12:07:12 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201391,'88d8157d-d334-40eb-9f1d-cdbc73643795',TO_TIMESTAMP('2019-08-23 12:07:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2019-08-23 12:07:12','YYYY-MM-DD HH24:MI:SS'),100,213999,201076,1)
;

-- Aug 23, 2019, 12:34:56 PM CEST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2019-08-23 12:34:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214001
;

-- Aug 23, 2019, 12:35:26 PM CEST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2019-08-23 12:35:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213988
;

-- Aug 23, 2019, 12:39:59 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201077,'9d0a5e45-631b-48d2-9ca9-96966b928d63',TO_TIMESTAMP('2019-08-23 12:39:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','pa_reportcolumn_trl_pkey',TO_TIMESTAMP('2019-08-23 12:39:58','YYYY-MM-DD HH24:MI:SS'),100,200259,'Y','Y','N','N','Y')
;

-- Aug 23, 2019, 12:40:28 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201392,'3262d884-604c-4e02-8eb9-1bf84b200b26',TO_TIMESTAMP('2019-08-23 12:40:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-08-23 12:40:28','YYYY-MM-DD HH24:MI:SS'),100,214000,201077,10)
;

-- Aug 23, 2019, 12:40:34 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201393,'a42a89c3-ec2b-45cc-a8c8-30ec09c7f9ab',TO_TIMESTAMP('2019-08-23 12:40:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-08-23 12:40:34','YYYY-MM-DD HH24:MI:SS'),100,214001,201077,20)
;

-- Aug 23, 2019, 12:40:39 PM CEST
ALTER TABLE PA_ReportColumn_Trl ADD CONSTRAINT pa_reportcolumn_trl_pkey PRIMARY KEY (PA_ReportColumn_ID,AD_Language)
;

-- Aug 23, 2019, 12:41:05 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201078,'bae1ea1c-285f-40b1-a38c-202f3a6aac8b',TO_TIMESTAMP('2019-08-23 12:41:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','pa_reportline_trl_pkey',TO_TIMESTAMP('2019-08-23 12:41:05','YYYY-MM-DD HH24:MI:SS'),100,200260,'Y','Y','N','N','Y')
;

-- Aug 23, 2019, 12:41:16 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201394,'27b913b5-b8a0-425b-8c9b-64026c26c4f2',TO_TIMESTAMP('2019-08-23 12:41:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-08-23 12:41:15','YYYY-MM-DD HH24:MI:SS'),100,213987,201078,10)
;

-- Aug 23, 2019, 12:41:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201395,'efaad945-58fa-4fd6-af1f-cf4f415da163',TO_TIMESTAMP('2019-08-23 12:41:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-08-23 12:41:21','YYYY-MM-DD HH24:MI:SS'),100,213988,201078,20)
;

-- Aug 23, 2019, 12:41:25 PM CEST
ALTER TABLE PA_ReportLine_Trl ADD CONSTRAINT pa_reportline_trl_pkey PRIMARY KEY (PA_ReportLine_ID,AD_Language)
;

SELECT register_migration_script('201908221115_IDEMPIERE-4032.sql') FROM dual
;
