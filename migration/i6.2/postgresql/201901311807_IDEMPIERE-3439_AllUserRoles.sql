-- IDEMPIERE-3439 Create System windows to analyze all clients and users
-- Jan 31, 2019, 6:04:56 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200254,'All User Roles','User Roles from All Tenants',200093,'AD_AllUserRoles_V',0,'4',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','Y','L','N','Y','e1b6bcc6-db32-4a8c-b5b7-7adcba498526','N','N','N')
;

-- Jan 31, 2019, 6:04:56 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AllUserRoles_V',1000000,'N','N','Table AD_AllUserRoles_V','Y','Y',0,0,TO_TIMESTAMP('2019-01-31 18:04:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:56','YYYY-MM-DD HH24:MI:SS'),100,200317,'Y',1000000,1,200000,'aa1e721c-e49d-4fb0-8f70-0877631cccc2')
;

-- Jan 31, 2019, 6:04:57 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213826,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200254,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:56','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','121a3d4d-3413-4632-bfe0-bcf6e505b805','N','N','N','D')
;

-- Jan 31, 2019, 6:04:57 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213827,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200254,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:57','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','0ce3f65b-059f-4c48-88a5-fe45fad21803','N','N','N','D')
;

-- Jan 31, 2019, 6:04:57 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213828,0.0,'All Users',200254,'AD_AllUsers_V_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:57','YYYY-MM-DD HH24:MI:SS'),100,203121,'N','N','D','Y','N','N','Y','062337e1-ecf1-4626-bfe9-163466bfc785','Y','N','N','N')
;

-- Jan 31, 2019, 6:04:58 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213829,0.0,'All Clients',200254,'AD_AllClients_V_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:57','YYYY-MM-DD HH24:MI:SS'),100,203119,'N','N','D','Y','N','N','Y','2ef20d9b-1982-4cda-b94b-1a2fe40d9e9b','Y','N','N','N')
;

-- Jan 31, 2019, 6:04:58 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213830,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200254,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:58','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','Y','N','N','Y','3c7951fa-1fac-47ad-a3ea-0b4b0c2ff065','N','N','N','N')
;

-- Jan 31, 2019, 6:04:58 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213831,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200254,'Created','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:58','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','26f0a125-027a-4e44-a0dc-e023085f10c0','N','N','N','N')
;

-- Jan 31, 2019, 6:04:59 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213832,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200254,'CreatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:58','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','fff516cb-e528-44d0-a23f-c4a089cd57be','N','N','N','D')
;

-- Jan 31, 2019, 6:04:59 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213833,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200254,'Updated','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:59','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','770cc8ae-93c9-4936-a419-b70b05d1ac84','N','N','N','N')
;

-- Jan 31, 2019, 6:04:59 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213834,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200254,'UpdatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:59','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','f3fc2d21-c617-45da-a608-2201c970f97a','N','N','N','D')
;

-- Jan 31, 2019, 6:05:01 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203290,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:04:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:04:59','YYYY-MM-DD HH24:MI:SS'),100,'AD_AllUserRoles_V_UU','AD_AllUserRoles_V_UU','AD_AllUserRoles_V_UU','D','0ef99186-6b1d-465c-b78e-d8671838526a')
;

-- Jan 31, 2019, 6:05:02 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213835,0.0,'AD_AllUserRoles_V_UU',200254,'AD_AllUserRoles_V_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:01','YYYY-MM-DD HH24:MI:SS'),100,203290,'N','N','D','Y','N','N','Y','9c08d894-6d0e-4a7a-8f37-5913a826819c','N','N','N','N')
;

-- Jan 31, 2019, 6:05:02 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213836,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200254,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:02','YYYY-MM-DD HH24:MI:SS'),100,469,'N','Y','D','Y','N','N','Y','04ca9435-cafc-4598-b5df-09625e5a94fe','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213837,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200254,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:02','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','Y','N','N','Y','cd163f10-1f72-47c3-a24a-c19de30dc55c','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213838,0.0,'User Level','System Client Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Client level data or Client and Organization level data.',200254,'UserLevel',3,'N','N','N','N','N','N',17,226,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:03','YYYY-MM-DD HH24:MI:SS'),100,615,'N','N','D','Y','N','N','Y','2375e17e-9820-415a-ab91-2113f851055a','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213839,0.0,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200254,'IsManual','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:03','YYYY-MM-DD HH24:MI:SS'),100,1474,'N','N','D','Y','N','N','Y','c745ee64-34cd-4974-aa08-2837c85994b6','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:04 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213840,0.0,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200254,'IsShowAcct','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:03','YYYY-MM-DD HH24:MI:SS'),100,2213,'N','N','D','Y','N','N','Y','4becb513-fa92-40cb-8653-27085a7b7965','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:04 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213841,0.0,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200254,'IsPersonalLock','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:04','YYYY-MM-DD HH24:MI:SS'),100,2210,'N','N','D','Y','N','N','Y','75cde11f-14df-489f-815c-187875263383','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213842,0.0,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200254,'IsPersonalAccess','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:04','YYYY-MM-DD HH24:MI:SS'),100,2209,'N','N','D','Y','N','N','Y','bc77776c-8923-4f99-842c-62e6ae813885','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213843,0.0,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200254,'IsCanExport','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:08','YYYY-MM-DD HH24:MI:SS'),100,2204,'N','N','D','Y','N','N','Y','b7570d1b-0cdf-42ff-9df1-73aa8f4f057d','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:09 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213844,0.0,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200254,'IsCanReport','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:08','YYYY-MM-DD HH24:MI:SS'),100,2205,'N','N','D','Y','N','N','Y','4d32a6b8-f20f-4269-9978-af96b13d14ab','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:09 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213845,0.0,'Access all Orgs','Access all Organizations (no org access control) of the client','When selected, the role has access to all organizations of the client automatically. This also increases performance where you have many organizations.',200254,'IsAccessAllOrgs','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:09','YYYY-MM-DD HH24:MI:SS'),100,2587,'N','N','D','Y','N','N','Y','25581d23-1955-404a-ba31-2e95156b9e5f','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:09 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213846,0.0,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200254,'IsChangeLog','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:09','YYYY-MM-DD HH24:MI:SS'),100,2046,'N','N','D','Y','N','N','Y','89fff10a-409d-43bc-8162-81a2ad1a4c1e','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:10 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213847,0.0,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Client, you can see the Record Info Change Log.',200254,'PreferenceType','O',1,'N','N','N','N','N','N',17,330,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:09','YYYY-MM-DD HH24:MI:SS'),100,2656,'N','N','D','Y','N','N','Y','bb794878-c747-47e3-843a-122d0fe2d7fc','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:11 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213848,0.0,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200254,'IsUseUserOrgAccess','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:10','YYYY-MM-DD HH24:MI:SS'),100,2696,'N','N','D','Y','N','N','Y','1b1f1ec4-eeb6-4ff6-8e50-0f9ae2c11adf','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:11 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213849,0.0,'Master Role','A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200254,'IsMasterRole','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:11','YYYY-MM-DD HH24:MI:SS'),100,200117,'N','N','D','Y','N','N','Y','beeb9f5c-f196-4a9a-be5c-51495fc16441','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:14 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213850,0.0,'Access Advanced ',200254,'IsAccessAdvanced','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:11','YYYY-MM-DD HH24:MI:SS'),100,202575,'N','N','D','Y','N','N','Y','aca477b1-1e02-4406-b6e4-02943a9a51cd','Y','N','N','N')
;

-- Jan 31, 2019, 6:05:15 PM CET
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,Referenced_Table_ID,SeqNo,FromClause) VALUES (0,0,200003,'5b6e77f2-ad69-438e-a696-3c969911477c',TO_TIMESTAMP('2019-01-31 18:05:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AllUserRoles',TO_TIMESTAMP('2019-01-31 18:05:14','YYYY-MM-DD HH24:MI:SS'),100,200254,157,10,'FROM AD_User_Roles JOIN AD_Role ON (AD_Role.AD_Role_ID=AD_User_Roles.AD_Role_ID)')
;

-- Jan 31, 2019, 6:05:15 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200047,'87f6b170-6230-4a2c-9ae7-242eb223d8b1',TO_TIMESTAMP('2019-01-31 18:05:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:15','YYYY-MM-DD HH24:MI:SS'),100,200003,'AD_Client_ID','0',10)
;

-- Jan 31, 2019, 6:05:15 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200048,'c8a18b3f-1576-49eb-b94e-5af8b0c9c4f0',TO_TIMESTAMP('2019-01-31 18:05:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:15','YYYY-MM-DD HH24:MI:SS'),100,200003,'AD_Org_ID','0',20)
;

-- Jan 31, 2019, 6:05:16 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200049,'22693d0d-2ac0-4c17-b241-1bae122b5c74',TO_TIMESTAMP('2019-01-31 18:05:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:15','YYYY-MM-DD HH24:MI:SS'),100,200003,'AD_AllUsers_V_ID','AD_User_Roles.AD_User_ID',30)
;

-- Jan 31, 2019, 6:05:16 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200050,'5c51049a-204c-47fe-ba57-9a15c7e81325',TO_TIMESTAMP('2019-01-31 18:05:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:16','YYYY-MM-DD HH24:MI:SS'),100,200003,'AD_AllClients_V_ID','AD_Role.AD_Client_ID',40)
;

-- Jan 31, 2019, 6:05:18 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200051,'e196a3ad-4a23-48a7-a4fb-3b27e630031d',TO_TIMESTAMP('2019-01-31 18:05:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:16','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsActive','CASE WHEN AD_User_Roles.IsActive = ''N'' THEN AD_User_Roles.IsActive ELSE AD_Role.IsActive END',50)
;

-- Jan 31, 2019, 6:05:18 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200052,'f88479d7-5fc0-491c-9bb2-ad66494f78b7',TO_TIMESTAMP('2019-01-31 18:05:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:18','YYYY-MM-DD HH24:MI:SS'),100,200003,'Created','AD_User_Roles.Created',60)
;

-- Jan 31, 2019, 6:05:19 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200053,'3a2cc8c0-274a-4b93-9fcb-fe9ebef55fa7',TO_TIMESTAMP('2019-01-31 18:05:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:18','YYYY-MM-DD HH24:MI:SS'),100,200003,'CreatedBy','AD_User_Roles.CreatedBy',70)
;

-- Jan 31, 2019, 6:05:19 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200054,'82663bb6-ed79-4436-a702-635b0c24f250',TO_TIMESTAMP('2019-01-31 18:05:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:19','YYYY-MM-DD HH24:MI:SS'),100,200003,'Updated','AD_User_Roles.Updated',80)
;

-- Jan 31, 2019, 6:05:19 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200055,'5afff2c9-aaa8-450f-a3c8-587c7b3281d7',TO_TIMESTAMP('2019-01-31 18:05:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:19','YYYY-MM-DD HH24:MI:SS'),100,200003,'UpdatedBy','AD_User_Roles.UpdatedBy',90)
;

-- Jan 31, 2019, 6:05:20 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200056,'a453c72a-34a9-4ae1-ae0e-db40b7ed9b8a',TO_TIMESTAMP('2019-01-31 18:05:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:19','YYYY-MM-DD HH24:MI:SS'),100,200003,'AD_AllUserRoles_V_UU','AD_User_Roles.AD_User_Roles_UU',100)
;

-- Jan 31, 2019, 6:05:20 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200057,'0063c952-d4a4-49c9-b1f8-3cf11973b8f0',TO_TIMESTAMP('2019-01-31 18:05:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:20','YYYY-MM-DD HH24:MI:SS'),100,200003,'Name','AD_Role.Name',110)
;

-- Jan 31, 2019, 6:05:20 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200058,'c0c022e3-8892-4ca4-8e33-95102b46abd5',TO_TIMESTAMP('2019-01-31 18:05:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:20','YYYY-MM-DD HH24:MI:SS'),100,200003,'Description','AD_Role.Description',120)
;

-- Jan 31, 2019, 6:05:22 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200059,'0f64333c-e49b-41a6-b573-2cd2ccb30644',TO_TIMESTAMP('2019-01-31 18:05:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:20','YYYY-MM-DD HH24:MI:SS'),100,200003,'UserLevel','AD_Role.UserLevel',130)
;

-- Jan 31, 2019, 6:05:25 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200060,'7da4b7b7-2c9d-44cf-ac30-1aa52c69a50b',TO_TIMESTAMP('2019-01-31 18:05:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:22','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsManual','AD_Role.IsManual',140)
;

-- Jan 31, 2019, 6:05:26 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200061,'d0804306-78b7-4eba-b33c-b23ccac102ce',TO_TIMESTAMP('2019-01-31 18:05:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:25','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsShowAcct','AD_Role.IsShowAcct',150)
;

-- Jan 31, 2019, 6:05:26 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200062,'ded4c2e7-44a9-4f53-9f40-7ce04d7266a1',TO_TIMESTAMP('2019-01-31 18:05:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:26','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsPersonalLock','AD_Role.IsPersonalLock',160)
;

-- Jan 31, 2019, 6:05:26 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200063,'c76fc8f2-af48-42e3-9c54-631c7660c649',TO_TIMESTAMP('2019-01-31 18:05:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:26','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsPersonalAccess','AD_Role.IsPersonalAccess',170)
;

-- Jan 31, 2019, 6:05:30 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200064,'4b81690f-40fa-41d9-9635-dce2bb28ce5c',TO_TIMESTAMP('2019-01-31 18:05:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:26','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsCanExport','AD_Role.IsCanExport',180)
;

-- Jan 31, 2019, 6:05:30 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200065,'d671fba0-8b20-4a03-a291-da93d9962bcf',TO_TIMESTAMP('2019-01-31 18:05:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:30','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsCanReport','AD_Role.IsCanReport',190)
;

-- Jan 31, 2019, 6:05:30 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200066,'1884c63d-f1df-448e-9ffd-283b35830a9c',TO_TIMESTAMP('2019-01-31 18:05:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:30','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsAccessAllOrgs','AD_Role.IsAccessAllOrgs',200)
;

-- Jan 31, 2019, 6:05:31 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200067,'3bd34c32-d069-47dc-8ee4-06416635c7b6',TO_TIMESTAMP('2019-01-31 18:05:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:30','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsChangeLog','AD_Role.IsChangeLog',210)
;

-- Jan 31, 2019, 6:05:31 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200068,'5e0519c8-0a04-4710-8ff6-2c6cb3c492cc',TO_TIMESTAMP('2019-01-31 18:05:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:31','YYYY-MM-DD HH24:MI:SS'),100,200003,'PreferenceType','AD_Role.PreferenceType',220)
;

-- Jan 31, 2019, 6:05:31 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200069,'764f7153-4114-4ae2-a49c-07fe0ce73d66',TO_TIMESTAMP('2019-01-31 18:05:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:31','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsUseUserOrgAccess','AD_Role.IsUseUserOrgAccess',230)
;

-- Jan 31, 2019, 6:05:33 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200070,'a47373f8-d804-4e25-809f-02f2022bf038',TO_TIMESTAMP('2019-01-31 18:05:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:31','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsMasterRole','AD_Role.IsMasterRole',240)
;

-- Jan 31, 2019, 6:05:36 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200071,'d3249d91-a004-45b3-9b2a-fbf5c47465df',TO_TIMESTAMP('2019-01-31 18:05:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-01-31 18:05:33','YYYY-MM-DD HH24:MI:SS'),100,200003,'IsAccessAdvanced','AD_Role.IsAccessAdvanced',250)
;

-- Jan 31, 2019, 6:05:36 PM CET
CREATE OR REPLACE VIEW AD_AllUserRoles_V(AD_Client_ID, AD_Org_ID, AD_AllUsers_V_ID, AD_AllClients_V_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, AD_AllUserRoles_V_UU, Name, Description, UserLevel, IsManual, IsShowAcct, IsPersonalLock, IsPersonalAccess, IsCanExport, IsCanReport, IsAccessAllOrgs, IsChangeLog, PreferenceType, IsUseUserOrgAccess, IsMasterRole, IsAccessAdvanced) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_User_Roles.AD_User_ID AS AD_AllUsers_V_ID, AD_Role.AD_Client_ID AS AD_AllClients_V_ID, CASE WHEN AD_User_Roles.IsActive = 'N' THEN AD_User_Roles.IsActive ELSE AD_Role.IsActive END AS IsActive, AD_User_Roles.Created AS Created, AD_User_Roles.CreatedBy AS CreatedBy, AD_User_Roles.Updated AS Updated, AD_User_Roles.UpdatedBy AS UpdatedBy, AD_User_Roles.AD_User_Roles_UU AS AD_AllUserRoles_V_UU, AD_Role.Name AS Name, AD_Role.Description AS Description, AD_Role.UserLevel AS UserLevel, AD_Role.IsManual AS IsManual, AD_Role.IsShowAcct AS IsShowAcct, AD_Role.IsPersonalLock AS IsPersonalLock, AD_Role.IsPersonalAccess AS IsPersonalAccess, AD_Role.IsCanExport AS IsCanExport, AD_Role.IsCanReport AS IsCanReport, AD_Role.IsAccessAllOrgs AS IsAccessAllOrgs, AD_Role.IsChangeLog AS IsChangeLog, AD_Role.PreferenceType AS PreferenceType, AD_Role.IsUseUserOrgAccess AS IsUseUserOrgAccess, AD_Role.IsMasterRole AS IsMasterRole, AD_Role.IsAccessAdvanced AS IsAccessAdvanced FROM AD_User_Roles JOIN AD_Role ON (AD_Role.AD_Role_ID=AD_User_Roles.AD_Role_ID)
;

-- Jan 31, 2019, 6:05:36 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200262,'User Roles',200093,20,'Y',200254,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:36','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',213828,'AD_AllUsers_V_ID, AD_AllClients_V_ID, Name','N','N',1,'N','D','Y','N','64c6056d-6c46-46e1-8bfc-d217bd64da19','B')
;

-- Jan 31, 2019, 6:05:37 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205902,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200262,213826,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da23fe7e-a8c3-442e-a1a9-3d4df63f99ac','N',0,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:37 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205903,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200262,213827,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8621acd7-9e0f-448d-b350-f126fdf83889','Y','N',1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205904,'AD_AllUserRoles_V_UU',200262,213835,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cc1591f9-71fb-43e9-b137-204c79a99d9b','N',1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205905,'All Clients',200262,213829,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','13e74da8-98ad-4c74-81e9-960e37c0fdde','Y',10,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205906,'All Users',200262,213828,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ad9382cb-23b1-442a-815b-0574106fad56','N',0,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:42 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205907,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200262,213836,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dba05735-981b-460c-8b34-9f82494ecba6','Y',20,1,5,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:42 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205908,'Description','Optional short description of the record','A description is limited to 255 characters.',200262,213837,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','601205e1-8c9e-4db3-b6a6-014b85a5b106','Y',30,1,5,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205909,'User Level','System Client Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Client level data or Client and Organization level data.',200262,213838,'Y',3,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fdd3b142-6054-4ed3-9bd0-d9da790715ce','Y',40,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205910,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Client, you can see the Record Info Change Log.',200262,213847,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','544cb6e3-3ed4-491e-a6dc-e49c1549cfe7','Y',130,4,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205911,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200262,213839,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cc7cb50d-6c8b-483f-9734-ad09ae9d755c','Y',50,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205912,'Master Role','A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200262,213849,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','66d89042-5856-4203-9cc2-ee63753a5b93','Y',150,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205913,'Access all Orgs','Access all Organizations (no org access control) of the client','When selected, the role has access to all organizations of the client automatically. This also increases performance where you have many organizations.',200262,213845,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','043c23d0-edde-48cf-9759-bc165412bd6d','Y',110,4,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205914,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200262,213848,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6cbd8fb1-cb96-48b2-9b34-043a4d31ccac','Y',140,5,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205915,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200262,213843,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a2a5219-9d1a-4eff-afb7-06f680cf4ea6','Y',90,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205916,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200262,213844,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1da83633-1949-48b4-80db-f86c459ad1e2','Y',100,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205917,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200262,213840,'Y',1,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d30b0eb1-ba00-4ba9-ab76-5c2f6ad34694','Y',60,4,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205918,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200262,213841,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5a8c5597-a753-43e3-a846-1b01254ef251','Y',70,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205919,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200262,213842,'Y',1,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','160b8951-6f36-408e-86f9-d12b4560e0cb','Y',80,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205920,'Access Advanced ',200262,213850,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','672fd5cc-c2f7-4e3a-9879-2228bc5c23bc','Y',160,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:55 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205921,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200262,213846,'Y',1,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d6feca90-6f34-4e12-a26e-c51c2851ec32','Y',120,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:55 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205922,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200262,213830,'Y',1,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d2dbeca1-517e-4db1-913a-224e8aeab6e1','Y',170,4,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:55 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200107,'All User Roles',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:55','YYYY-MM-DD HH24:MI:SS'),100,'Q','N','D','Y','N',0,0,'N','f908ce27-ed44-405d-9032-d09c2b00f644')
;

-- Jan 31, 2019, 6:05:56 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200263,'User Roles',200107,10,'Y',200254,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AllUsers_V_ID, AD_AllClients_V_ID, Name','N','N',0,'N','D','Y','N','42b86626-4d51-4b18-989c-d15a8c92bf0a','B')
;

-- Jan 31, 2019, 6:05:56 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205923,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200263,213826,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6c40865c-9fb2-4968-abff-aefe61eeff7b','N',0,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:57 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205924,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200263,213827,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','86f4af37-76a1-4cb5-b3d6-4f4341a0a92a','Y','N',1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:57 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205925,'AD_AllUserRoles_V_UU',200263,213835,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a6ea7c7-9d91-43b0-bd36-c0e298cf72e1','N',1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:57 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205926,'All Clients',200263,213829,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','510f2770-3110-4b9c-a15e-ea5cb53b8b71','Y',10,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:05:58 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205927,'All Users',200263,213828,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','937bb76c-2b9a-4d8b-875c-69cd4e47d3e7','Y',20,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:01 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205928,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200263,213836,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:05:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:05:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2365edad-93d2-49fc-a116-cf25f6994178','Y',30,1,5,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:02 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205929,'Description','Optional short description of the record','A description is limited to 255 characters.',200263,213837,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','44bea325-d4f4-4c7c-863e-54777bb70928','Y',40,1,5,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:02 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205930,'User Level','System Client Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Client level data or Client and Organization level data.',200263,213838,'Y',3,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4bbe25c5-2eb8-4378-9ae2-958e6094e0f5','Y',50,1,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:02 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205931,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Client, you can see the Record Info Change Log.',200263,213847,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8c7316b7-5dda-4e95-bc9f-bba4cb2c30a5','Y',140,4,2,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:06 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205932,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200263,213839,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','515c199e-16fa-4729-b56a-daa15f085f5d','Y',60,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:06 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205933,'Master Role','A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200263,213849,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c65d3e1f-1a23-4ef7-b791-5ff7af384d51','Y',160,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:07 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205934,'Access all Orgs','Access all Organizations (no org access control) of the client','When selected, the role has access to all organizations of the client automatically. This also increases performance where you have many organizations.',200263,213845,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c24298af-9809-45d8-801a-4354b890ad62','Y',120,4,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:07 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205935,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200263,213848,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','16e761f8-7453-4073-a7d9-b731f0b64cd5','Y',150,5,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:07 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205936,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200263,213843,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','920ea612-e4b7-43bc-bace-a1467b477d1a','Y',100,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205937,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200263,213844,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5f3ac43d-f2c7-4c05-a464-ff59d5b6cfa7','Y',110,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205938,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200263,213840,'Y',1,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','30390dfc-a6c9-4ef4-a482-b16a05ac3afd','Y',70,4,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205939,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200263,213841,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','febb7017-b10c-4955-a96c-72002fc96bf0','Y',80,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:09 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205940,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200263,213842,'Y',1,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e3a72e67-492c-4a62-8dc7-d95cd63af24d','Y',90,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205941,'Access Advanced ',200263,213850,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9c2d8c30-7adc-4865-821a-fe8f725636fb','Y',170,2,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205942,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200263,213846,'Y',1,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','29911166-9035-4e7c-bf7d-d484328c5c0d','Y',130,3,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205943,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200263,213830,'Y',1,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bf379903-6573-4461-bf66-14ba2ee099c9','Y',180,4,1,1,'N','N','N')
;

-- Jan 31, 2019, 6:06:14 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200165,'All User Roles','W',200107,0,0,'Y',TO_TIMESTAMP('2019-01-31 18:06:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-31 18:06:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','57604b1d-d066-46b5-aad7-c2bf6b50a909')
;

-- Jan 31, 2019, 6:06:14 PM CET
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 367,21, 10, 200165)
;

SELECT register_migration_script('201901311807_IDEMPIERE-3439_AllUserRoles.sql') FROM dual
;

