SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 2, 2013 12:32:01 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing) VALUES ('N','N','N','3',0,200106,'N','N','N','D','L','3638291f-2226-4155-9480-f58150ab311a','Y','Y','PA_DashboardContent_Access','PA_DashboardContent_Access','Y',0,100,TO_DATE('2013-09-02 12:32:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 12:32:00','YYYY-MM-DD HH24:MI:SS'),0,'N')
;

-- Sep 2, 2013 12:32:02 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Sequence_UU,IncrementNo,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200154,'Table PA_DashboardContent_Access','PA_DashboardContent_Access','78497fed-c728-4bb5-a945-01bd9788fbf1',1,0,TO_DATE('2013-09-02 12:32:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 12:32:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Sep 2, 2013 12:32:31 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('PA_DashboardContent_Access_ID',202608,'PA_DashboardContent_Access_ID','PA_DashboardContent_Access_ID','b8fb27fd-6acd-4fc7-80b0-68b52e482f50',TO_DATE('2013-09-02 12:32:30','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-09-02 12:32:30','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Sep 2, 2013 12:32:48 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('PA_DashboardContent_Access_UU',202609,'PA_DashboardContent_Access_UU','PA_DashboardContent_Access_UU','6c03f0c9-427c-4726-8b75-1862091c04f1',TO_DATE('2013-09-02 12:32:47','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-09-02 12:32:47','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Sep 2, 2013 12:33:20 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210851,'Y','N','N',0,'N',22,'N',13,'Y','N','Y','90f59004-ab60-4045-9828-11455d55e247','N','PA_DashboardContent_Access_ID','PA_DashboardContent_Access_ID','N',TO_DATE('2013-09-02 12:33:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 12:33:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',202608,'N')
;

-- Sep 2, 2013 12:34:45 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210852,'N','N','N',0,'N',36,'N',10,'Y','N','Y','c1c8430f-8e1b-4d3d-9a80-4b55b3252a91','N','PA_DashboardContent_Access_UU','PA_DashboardContent_Access_UU','N',TO_DATE('2013-09-02 12:34:45','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 12:34:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',202609,'N')
;

-- Sep 2, 2013 12:35:19 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210853,'N','N','N',0,'N',22,'N',19,129,'N','N','Y','abb15077-e8ef-4fe5-8b22-a84c7799000e','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2013-09-02 12:35:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 12:35:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',102,'N')
;

-- Sep 2, 2013 12:35:46 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210854,'N','N','N',0,'N',22,'N',19,104,'N','N','Y','ae63d06b-6fd5-40f7-b881-886223e4fe9e','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2013-09-02 12:35:45','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 12:35:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',113,'N')
;

-- Sep 2, 2013 12:36:44 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 12:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210853
;

-- Sep 2, 2013 12:36:59 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 12:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210854
;

-- Sep 2, 2013 12:37:14 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET IsUpdateable='N', EntityType='D',Updated=TO_DATE('2013-09-02 12:37:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210851
;

-- Sep 2, 2013 12:37:29 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET IsUpdateable='N', EntityType='D',Updated=TO_DATE('2013-09-02 12:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210852
;

-- Sep 2, 2013 3:14:03 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210855,'N','N','N',0,'N',1,'N',20,'N','N','Y','b16e8503-a1f1-4b92-bfbd-18fae89c7799','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2013-09-02 15:14:02','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:14:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',348,'N')
;

-- Sep 2, 2013 3:15:05 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210856,'N','N','N',0,'N',7,'N',16,'N','N','Y','26299e27-d259-4fbe-8c68-e623b9301d81','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2013-09-02 15:15:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:15:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',245,'N')
;

-- Sep 2, 2013 3:15:27 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210857,110,'N','N','N',0,'N',22,'N',18,'N','N','Y','fc296b0f-0609-438e-a963-3c1b204a9a48','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2013-09-02 15:15:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:15:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',246,'N')
;

-- Sep 2, 2013 3:15:51 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210858,'N','N','N',0,'N',7,'N',16,'N','N','Y','991d8e6b-d793-400b-b378-45c7b36fc45c','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2013-09-02 15:15:51','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:15:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',607,'N')
;

-- Sep 2, 2013 3:16:11 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210859,110,'N','N','N',0,'N',22,'N',18,'N','N','Y','0043c240-3603-482f-9c8b-e24a6421125c','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2013-09-02 15:16:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:16:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',608,'N')
;

-- Sep 2, 2013 3:17:18 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210860,'N','N','N',0,'N',22,'N',19,'N','N','Y','43c5ba06-c8a7-4277-b820-d154dfc0ea6c','N','PA_DashboardContent_ID','Dashboard Content','Y',TO_DATE('2013-09-02 15:17:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:17:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',51006,'N')
;

-- Sep 2, 2013 3:18:11 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210861,110,'N','N','N',0,'N',22,'N',30,'N','N','Y','e892de91-efc5-46a4-a08b-76a4b0fce1b8','N','AD_User_ID','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact','Y',TO_DATE('2013-09-02 15:18:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:18:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',138,'N')
;

-- Sep 2, 2013 3:18:32 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200106,210862,'N','N','N',0,'N',22,'N',19,'N','N','Y','603f16f2-7879-4f25-9454-3bd36de620be','N','AD_Role_ID','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.','Role','Y',TO_DATE('2013-09-02 15:18:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-09-02 15:18:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',123,'N')
;

-- Sep 2, 2013 3:19:26 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:19:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210862
;

-- Sep 2, 2013 3:19:40 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:19:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210861
;

-- Sep 2, 2013 3:19:54 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:19:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210856
;

-- Sep 2, 2013 3:20:08 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210857
;

-- Sep 2, 2013 3:20:22 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210855
;

-- Sep 2, 2013 3:20:44 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:20:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210860
;

-- Sep 2, 2013 3:20:56 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:20:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210858
;

-- Sep 2, 2013 3:21:08 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-09-02 15:21:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210859
;

-- Sep 2, 2013 3:22:31 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET IsKey='N',Updated=TO_DATE('2013-09-02 15:22:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210852
;

-- Sep 2, 2013 3:22:49 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
CREATE TABLE PA_DashboardContent_Access (AD_Client_ID NUMBER(10) DEFAULT NULL , AD_Org_ID NUMBER(10) DEFAULT NULL , AD_Role_ID NUMBER(10) DEFAULT NULL , AD_User_ID NUMBER(10) DEFAULT NULL , Created DATE DEFAULT NULL , CreatedBy NUMBER(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), PA_DashboardContent_Access_ID NUMBER(10) NOT NULL, PA_DashboardContent_Access_UU NVARCHAR2(36) DEFAULT NULL , PA_DashboardContent_ID NUMBER(10) DEFAULT NULL , Updated DATE DEFAULT NULL , UpdatedBy NUMBER(10) DEFAULT NULL , CONSTRAINT PA_DashboardContent_Access_Key PRIMARY KEY (PA_DashboardContent_Access_ID), CONSTRAINT PADashboardContentAcces_UU_idx UNIQUE (PA_DashboardContent_Access_UU))
;

-- Sep 2, 2013 3:22:49 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
ALTER TABLE PA_DashboardContent_Access ADD CONSTRAINT ADClient_PADashboardContentAcc FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id)
;

-- Sep 2, 2013 3:22:49 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
ALTER TABLE PA_DashboardContent_Access ADD CONSTRAINT ADOrg_PADashboardContentAccess FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id)
;

-- Sep 2, 2013 3:22:49 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
ALTER TABLE PA_DashboardContent_Access ADD CONSTRAINT ADRole_PADashboardContentAcces FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id)
;

-- Sep 2, 2013 3:22:50 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
ALTER TABLE PA_DashboardContent_Access ADD CONSTRAINT ADUser_PADashboardContentAcces FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id)
;

-- Sep 2, 2013 3:22:50 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
ALTER TABLE PA_DashboardContent_Access ADD CONSTRAINT CreatedBy_PADashboardContentAc FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id)
;

-- Sep 2, 2013 3:22:50 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
ALTER TABLE PA_DashboardContent_Access ADD CONSTRAINT PADashboardContent_PADashboard FOREIGN KEY (PA_DashboardContent_ID) REFERENCES pa_dashboardcontent(pa_dashboardcontent_id)
;

-- Sep 2, 2013 3:22:50 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
ALTER TABLE PA_DashboardContent_Access ADD CONSTRAINT UpdatedBy_PADashboardContentAc FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id)
;

-- Sep 2, 2013 3:33:05 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','N',50007,30,'N','N',200106,'N','N','N','Y','N',0,'ba945c13-8246-4038-b67d-dc9305016713','D','Dashboard Content Access',200112,0,TO_DATE('2013-09-02 15:33:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Sep 2, 2013 3:33:11 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200112,22,'N','N',210853,10,'Y',202481,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','63ab166f-aaba-4099-9ab4-ed90d34e99c8','Y','N',100,0,TO_DATE('2013-09-02 15:33:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:11','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Sep 2, 2013 3:33:12 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200112,22,'N','N',210854,20,'Y',202482,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','d3240760-8487-4602-9484-bdb6eb613941','Y','N','Y',100,0,TO_DATE('2013-09-02 15:33:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:11','YYYY-MM-DD HH24:MI:SS'),'Y',4,0,2)
;

-- Sep 2, 2013 3:33:12 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200112,22,'N','N',210851,30,'Y',202483,'N','D','PA_DashboardContent_Access_ID','a6466b76-49d6-4c79-895f-120445a6e6d6','N','N',100,0,TO_DATE('2013-09-02 15:33:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:12','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Sep 2, 2013 3:33:13 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200112,36,'N','N',210852,40,'Y',202484,'N','D','PA_DashboardContent_Access_UU','763348a5-60df-4679-b0de-737e8ee9cbf0','N','N',100,0,TO_DATE('2013-09-02 15:33:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:12','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Sep 2, 2013 3:33:13 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200112,22,'N','N',210860,50,'Y',202485,'N','D','Dashboard Content','e37d0b4a-162e-4289-a5c2-ee8d9846e395','Y','N',100,0,TO_DATE('2013-09-02 15:33:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:13','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Sep 2, 2013 3:33:14 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200112,22,'N','N',210861,60,'Y',202486,'N','The User identifies a unique user in the system. This could be an internal user or a business partner contact','D','User within the system - Internal or Business Partner Contact','User/Contact','8afd92c4-4999-4e3f-bf4f-59e50f55eb68','Y','N',100,0,TO_DATE('2013-09-02 15:33:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:13','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Sep 2, 2013 3:33:14 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200112,22,'N','N',210862,70,'Y',202487,'N','The Role determines security and access a user who has this Role will have in the System.','D','Responsibility Role','Role','187ba2fa-56c2-449c-81d5-941145102c9e','Y','N',100,0,TO_DATE('2013-09-02 15:33:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:14','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Sep 2, 2013 3:33:15 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200112,1,'N','N',210855,80,'Y',202488,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','e2859788-82c8-4c92-a4b3-ef0e75663f63','Y','N',100,0,TO_DATE('2013-09-02 15:33:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-09-02 15:33:14','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Sep 2, 2013 3:33:58 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2013-09-02 15:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202485
;

-- Sep 2, 2013 3:33:58 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2013-09-02 15:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202486
;

-- Sep 2, 2013 3:33:58 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2013-09-02 15:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202487
;

-- Sep 2, 2013 3:33:58 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2013-09-02 15:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202488
;

-- Sep 2, 2013 3:33:58 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-09-02 15:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202483
;

-- Sep 2, 2013 3:33:58 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-09-02 15:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202484
;

-- Sep 2, 2013 3:46:01 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Tab SET TabLevel=1,Updated=TO_DATE('2013-09-02 15:46:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200112
;


-- Sep 2, 2013 3:50:02 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET DefaultValue='@#PA_DashboardContent_ID@',Updated=TO_DATE('2013-09-02 15:50:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210860
;

-- Sep 2, 2013 3:51:35 PM COT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Tab SET DisplayLogic='@#AD_Client_ID@ > 0',Updated=TO_DATE('2013-09-02 15:51:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200112
;

-- Sep 12, 2013 5:06:23 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Window SET Name='Dashboard Content',Updated=TO_DATE('2013-09-12 17:06:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=50007
;

-- Sep 12, 2013 5:06:23 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Menu SET Name='Dashboard Content', Description=NULL, IsActive='Y',Updated=TO_DATE('2013-09-12 17:06:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=50010
;

-- Sep 12, 2013 5:06:47 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Tab SET Name='Dashboard Content',Updated=TO_DATE('2013-09-12 17:06:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50010
;

-- Sep 12, 2013 5:11:21 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Tab SET SeqNo=30,Updated=TO_DATE('2013-09-12 17:11:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53372
;

-- Sep 12, 2013 5:11:28 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Tab SET SeqNo=20,Updated=TO_DATE('2013-09-12 17:11:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200112
;

-- Sep 12, 2013 5:13:11 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N', DefaultValue=NULL,Updated=TO_DATE('2013-09-12 17:13:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210860
;

-- Sep 12, 2013 5:14:32 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-09-12 17:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202481
;

-- Sep 12, 2013 5:19:27 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Column SET DefaultValue='-1',Updated=TO_DATE('2013-09-12 17:19:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210861
;

-- Sep 12, 2013 5:20:24 PM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_DATE('2013-09-12 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200112
;

SELECT register_migration_script('201309121040_IDEMPIERE-1064.sql') FROM dual
;
