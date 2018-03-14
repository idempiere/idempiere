CREATE OR REPLACE VIEW ad_sessioninfo_v AS 
 SELECT s.ad_session_id, 0::numeric(10,0) AS ad_client_id, 0::numeric(10,0) AS  ad_org_id, s.isactive, 
		s.created, s.createdby, s.updated, s.updatedby, s.websession, 
		s.remote_addr, s.remote_host, s.ad_role_id, s.logindate, s.ad_session_uu, 
		s.servername, s.ad_client_id AS login_client_id,createdby as ad_user_id,s.ad_org_id as login_org_id,s.ad_session_id as ad_sessioninfo_v_id,
		s.ad_session_uu as ad_sessioninfo_v_uu
   FROM ad_session s
  WHERE s.processed = 'N'::bpchar;

Update AD_Session set processed='Y';
  
-- Oct 11, 2012 6:09:22 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','4',0,200025,'N','N','N','N','D','N','L','fd0427f8-ec15-4bd2-b4b1-d9ee2fb3890f','Y','Y','AD_SessionInfo_v','List of current logged in user','AD_SessionInfo_v',0,'Y',0,TO_TIMESTAMP('2012-10-11 18:09:20','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2012-10-11 18:09:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 11, 2012 6:09:22 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Oct 11, 2012 6:09:24 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',50000,'Y',1000000,1000000,'N','Y',200025,'8d765793-7e49-47fe-809f-e82c93b8a5f2','Table AD_SessionInfo_v','AD_SessionInfo_v',1,0,0,TO_TIMESTAMP('2012-10-11 18:09:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-10-11 18:09:22','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Oct 11, 2012 6:12:56 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200588,'D','N','N','N','N',10,'N',19,'N',2029,'ce1e4f62-f570-4d3f-b57f-29cbfc70ad8a','N','Y','N','AD_Session_ID','User Session Online or Web','Online or Web Session Information','Session',100,TO_TIMESTAMP('2012-10-11 18:12:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:12:55','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:12:56 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200588 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:12:58 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200589,'D','N','N','N','N',10,'N',19,'N',102,'4fb5a4e2-626f-44e3-ab61-9225cee5b188','N','N','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',100,TO_TIMESTAMP('2012-10-11 18:12:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:12:56','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:12:58 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200589 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:12:59 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200590,'D','N','N','N','N',10,'N',19,'N',113,'52199616-5a16-4bf4-ba03-496a75b33138','N','N','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',100,TO_TIMESTAMP('2012-10-11 18:12:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:12:58','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:12:59 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200590 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:00 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200591,'D','N','N','N','N',1,'N',20,'N',348,'b011d222-0512-474d-967a-39501f9f4aad','N','Y','N','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active',100,TO_TIMESTAMP('2012-10-11 18:12:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:12:59','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:00 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200591 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:01 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200592,'D','N','N','N','N',29,'N',16,'N',245,'6a2a8dff-02b4-4a9d-8218-4c1ac75967c7','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created',100,TO_TIMESTAMP('2012-10-11 18:13:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:00','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:01 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200592 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:02 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200593,'D',110,'N','N','N','N',10,'N',18,'N',246,'f712b956-5f63-4051-99b0-36c0f96ad562','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By',100,TO_TIMESTAMP('2012-10-11 18:13:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:01','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:03 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200593 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:04 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200594,'D','N','N','N','N',29,'N',16,'N',607,'62fb0d4a-a813-4c3f-b61b-b50d769e7221','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated',100,TO_TIMESTAMP('2012-10-11 18:13:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:05 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200594 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:07 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200595,'D',110,'N','N','N','N',10,'N',18,'N',608,'dfbd1427-339e-4bff-83a6-99ab8ae71b0b','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By',100,TO_TIMESTAMP('2012-10-11 18:13:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:08 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200595 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:13 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200596,'D','N','N','N','N',40,'N',10,'N',2059,'c105dadf-309d-4a1d-b0bd-a5a2aac25667','N','Y','N','WebSession','Web Session ID','Web Session',100,TO_TIMESTAMP('2012-10-11 18:13:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:08','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:13 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200596 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:16 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200597,'D','N','N','N','N',60,'N',10,'N',1430,'7cd7f374-5ab8-4f64-ab70-03191fe92705','N','Y','N','Remote_Addr','Remote Address','The Remote Address indicates an alternative or external address.','Remote Addr',100,TO_TIMESTAMP('2012-10-11 18:13:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:13','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:16 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200597 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:18 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200598,'D','N','N','N','N',120,'N',10,'N',1431,'2505c72d-c722-4548-8339-de2a4c38b94f','N','Y','N','Remote_Host','Remote host Info','Remote Host',100,TO_TIMESTAMP('2012-10-11 18:13:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:16','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:18 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200598 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:24 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200599,'D','N','N','N','N',10,'N',19,'N',123,'a979c0b4-d349-40b7-9dc9-6aa9dbb41913','N','Y','N','AD_Role_ID','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.','Role',100,TO_TIMESTAMP('2012-10-11 18:13:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:19','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:24 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200599 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:27 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200600,'D','N','N','N','N',29,'N',16,'N',53344,'b286aafe-777b-46ff-ab4a-bcd304962e38','N','Y','N','LoginDate','Login date',100,TO_TIMESTAMP('2012-10-11 18:13:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:27 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200600 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:29 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200601,'D','N','N','N','N',36,'N',10,'N',54595,'58879fef-b363-465a-a56e-25f15bdf296e','N','Y','N','AD_Session_UU','AD_Session_UU',100,TO_TIMESTAMP('2012-10-11 18:13:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:29 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200601 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:13:32 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200602,'D','N','N','N','N',40,'Y',10,'N',200182,'992d57b8-76ef-45a8-8dd7-0226cb17b3e4','N','Y','N','ServerName','Server name',100,TO_TIMESTAMP('2012-10-11 18:13:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 18:13:29','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 11, 2012 6:13:32 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200602 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 6:17:07 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,Description,AD_Window_ID,Processing,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('Q','Y','N','N',0,0,'D','Current Logins','List of Current Logged in user',200016,'N','9ca5088a-12f9-4f68-9ad2-8d6bc667c718',TO_TIMESTAMP('2012-10-11 18:17:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-11 18:17:05','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Oct 11, 2012 6:17:08 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200016 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Oct 11, 2012 6:24:07 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('Y',200016,10,'N','N',200025,'N','N','N','N','Y','N',0,'6fb7071b-f94c-49fe-86db-a4a5560f119f','D','Sessions','Current Sessions',200025,0,0,TO_TIMESTAMP('2012-10-11 18:24:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-10-11 18:24:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Oct 11, 2012 6:24:08 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Oct 11, 2012 6:24:17 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,1,'N','N',200591,'Y',200604,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','Y','N','4a4ea069-d90b-4f94-bd8c-54bc9e9e410d',100,0,TO_TIMESTAMP('2012-10-11 18:24:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:17 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200604 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:20 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,36,'N','N',200601,'Y',200605,'N','D','AD_Session_UU','Y','N','13fd257c-f4b4-4847-b550-a5b5121c4dd3',100,0,TO_TIMESTAMP('2012-10-11 18:24:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:20 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200605 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:26 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,10,'N','N',200589,'Y',200606,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','Y','N','0a1cb71d-afb0-4b44-8500-b98bcb0d6f5a',100,0,TO_TIMESTAMP('2012-10-11 18:24:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:26 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200606 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:28 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,29,'N','N',200600,'Y',200607,'N','D','Login date','Y','N','75afce1d-6a45-4f3c-991b-a99755414c06',100,0,TO_TIMESTAMP('2012-10-11 18:24:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:28 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200607 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:32 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,10,'N','N',200590,'Y',200608,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','Y','N','b2f7e6d5-192f-4602-967f-0bad43829dd2',100,0,TO_TIMESTAMP('2012-10-11 18:24:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:32 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200608 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:32 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,60,'N','N',200597,'Y',200609,'N','The Remote Address indicates an alternative or external address.','D','Remote Address','Remote Addr','Y','N','246620b1-bdfd-44f6-9e04-86a1b2acebb9',100,0,TO_TIMESTAMP('2012-10-11 18:24:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:33 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200609 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:34 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,120,'N','N',200598,'Y',200610,'N','D','Remote host Info','Remote Host','Y','N','721af3e7-10ec-4e6f-b9b7-cefb1f11579d',100,0,TO_TIMESTAMP('2012-10-11 18:24:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:34 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200610 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:35 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,10,'N','N',200599,'Y',200611,'N','The Role determines security and access a user who has this Role will have in the System.','D','Responsibility Role','Role','Y','N','3e693000-4510-4d7b-a1cf-7cc2d33a877a',100,0,TO_TIMESTAMP('2012-10-11 18:24:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:35 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200611 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:36 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,40,'N','N',200602,'Y',200612,'N','D','Server name','Y','N','b15ce97a-2550-4c7d-9cfa-2ae4e66e5783',100,0,TO_TIMESTAMP('2012-10-11 18:24:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:36 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200612 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:37 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,10,'N','N',200588,'Y',200613,'N','Online or Web Session Information','D','User Session Online or Web','Session','Y','N','8dd5343c-ebd6-4824-8a37-f2129750a5c1',100,0,TO_TIMESTAMP('2012-10-11 18:24:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:37 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200613 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:24:39 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,40,'N','N',200596,'Y',200614,'N','D','Web Session ID','Web Session','Y','N','55af8bd7-d361-4f1c-8b8f-3546b66f4d05',100,0,TO_TIMESTAMP('2012-10-11 18:24:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-11 18:24:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 11, 2012 6:24:39 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200614 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 11, 2012 6:28:47 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,"action",AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200016,200022,'N','N','N','U','Y','Login Session','Current logged in session','W','cef6bf48-0c65-4739-97f5-2d0b0cb062d4','Y',0,100,TO_TIMESTAMP('2012-10-11 18:28:44','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-10-11 18:28:44','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 11, 2012 6:28:47 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Oct 11, 2012 6:28:47 PM PDT
-- IDEMPIERE-293-List of logged users
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200022, 0, 999 FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200022)
;

-- Oct 18, 2012 1:30:02 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Window SET Name='Active Session',Updated=TO_TIMESTAMP('2012-10-18 13:30:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200016
;

-- Oct 18, 2012 1:30:02 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=200016
;

-- Oct 18, 2012 1:30:02 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Menu SET Name='Active Session', Description='List of Current Logged in user', IsActive='Y',Updated=TO_TIMESTAMP('2012-10-18 13:30:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200022
;

-- Oct 18, 2012 1:30:02 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=200022
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200606
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200608
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200609
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200610
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200611
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200607
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200614
;

-- Oct 18, 2012 1:31:38 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200609
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200610
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200611
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200607
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200614
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 18, 2012 1:32:31 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 18, 2012 1:33:15 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:33:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200606
;

-- Oct 18, 2012 1:33:39 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:33:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200608
;

-- Oct 18, 2012 1:34:00 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:34:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200609
;

-- Oct 18, 2012 1:34:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET IsSameLine='Y', XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:34:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200610
;

-- Oct 18, 2012 1:34:28 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200611
;

-- Oct 18, 2012 1:34:43 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-18 13:34:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200607
;

-- Oct 18, 2012 1:35:43 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200614
;

-- Oct 18, 2012 1:35:43 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 18, 2012 1:35:43 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 18, 2012 1:41:56 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200646
;

-- Oct 18, 2012 1:41:56 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200614
;

-- Oct 18, 2012 1:41:56 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 18, 2012 1:41:56 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 18, 2012 1:41:56 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 18, 2012 1:42:24 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:42:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200646
;

-- Oct 18, 2012 1:42:36 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:42:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200614
;

-- Oct 18, 2012 1:42:53 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-18 13:42:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200604
;

-- Oct 18, 2012 1:43:19 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-18 13:43:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200605
;

-- Oct 18, 2012 1:46:50 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=519
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=518
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=228
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=114
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=108
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=115
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53225
;

-- Oct 18, 2012 1:46:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53226
;

-- Oct 18, 2012 2:28:42 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('login_client_id',200186,'D','login_client_id','login_client_id','4fc6243a-2368-4251-9229-5dd20de17693',0,TO_TIMESTAMP('2012-10-18 14:28:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-18 14:28:41','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 18, 2012 2:28:42 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200186 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 18, 2012 2:28:43 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200702,'D','N','N','N','N',10,'N',19,'N',200186,'1b4a16bb-fe54-4afb-a1b1-2320a09ab856','N','N','N','login_client_id','login_client_id',100,TO_TIMESTAMP('2012-10-18 14:28:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-18 14:28:41','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 18, 2012 2:28:43 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200702 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 18, 2012 2:31:50 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element SET Name='Client', PrintName='Client',Updated=TO_TIMESTAMP('2012-10-18 14:31:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200186
;

-- Oct 18, 2012 2:31:50 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200186
;

-- Oct 18, 2012 2:31:50 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET ColumnName='login_client_id', Name='Client', Description=NULL, Help=NULL WHERE AD_Element_ID=200186
;

-- Oct 18, 2012 2:31:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='login_client_id', Name='Client', Description=NULL, Help=NULL, AD_Element_ID=200186 WHERE UPPER(ColumnName)='LOGIN_CLIENT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 18, 2012 2:31:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='login_client_id', Name='Client', Description=NULL, Help=NULL WHERE AD_Element_ID=200186 AND IsCentrallyMaintained='Y'
;

-- Oct 18, 2012 2:31:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Client', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200186) AND IsCentrallyMaintained='Y'
;

-- Oct 18, 2012 2:31:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_PrintFormatItem SET PrintName='Client', Name='Client' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200186)
;

-- Oct 18, 2012 2:32:49 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Table SET AccessLevel='4', IsView='N',Updated=TO_TIMESTAMP('2012-10-18 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200025
;

-- Oct 18, 2012 2:32:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Table SET IsView='Y',Updated=TO_TIMESTAMP('2012-10-18 14:32:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200025
;

-- Oct 18, 2012 2:33:22 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,10,'N','N',200702,'Y',200647,'N','D','Client','N','Y','5fb154ca-0759-4700-9beb-071c871a7b7b',100,0,TO_TIMESTAMP('2012-10-18 14:33:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-18 14:33:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 18, 2012 2:33:22 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200647 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 18, 2012 2:33:59 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200606
;

-- Oct 18, 2012 2:33:59 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200647
;

-- Oct 18, 2012 2:37:13 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200013,'AD_Session','D','3d5add60-2d2d-4570-b1d1-0e188b731374','N','AD Session','T',0,0,100,TO_TIMESTAMP('2012-10-18 14:37:12','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2012-10-18 14:37:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 18, 2012 2:37:13 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Oct 18, 2012 2:38:49 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Reference_Value_ID=129, AD_Reference_ID=18,Updated=TO_TIMESTAMP('2012-10-18 14:38:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200702
;

-- Oct 18, 2012 2:39:09 PM IST
-- IDEMPIERE-293  List of Active Session
DELETE FROM AD_Reference_Trl WHERE AD_Reference_ID=200013
;

-- Oct 18, 2012 2:39:09 PM IST
-- IDEMPIERE-293  List of Active Session
DELETE FROM AD_Reference WHERE AD_Reference_ID=200013
;

-- Oct 19, 2012 1:35:06 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200705,'D','N','N','N','N',10,'N',19,'N',138,'f1336921-57f1-4fe8-8c12-543d2b4a49bf','N','N','N','AD_User_ID','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact',100,TO_TIMESTAMP('2012-10-19 13:35:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-19 13:35:00','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 19, 2012 1:35:07 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200705 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 19, 2012 1:40:53 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('login_org_id',200189,'D','login_org_id','login_org_id','a5353900-dd61-4d08-8a16-ff00125c61cd',0,TO_TIMESTAMP('2012-10-19 13:40:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-19 13:40:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 19, 2012 1:40:53 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200189 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 19, 2012 1:40:59 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200706,'D','N','N','N','N',10,'N',19,'N',200189,'f6a3b130-de25-4cbd-802f-560435d2cbab','N','N','N','login_org_id','login_org_id',100,TO_TIMESTAMP('2012-10-19 13:40:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-19 13:40:45','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 19, 2012 1:40:59 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200706 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 19, 2012 1:44:02 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element SET Name='Login Org', PrintName='Login Org',Updated=TO_TIMESTAMP('2012-10-19 13:44:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200189
;

-- Oct 19, 2012 1:44:02 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200189
;

-- Oct 19, 2012 1:44:02 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET ColumnName='login_org_id', Name='Login Org', Description=NULL, Help=NULL WHERE AD_Element_ID=200189
;

-- Oct 19, 2012 1:44:02 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='login_org_id', Name='Login Org', Description=NULL, Help=NULL, AD_Element_ID=200189 WHERE UPPER(ColumnName)='LOGIN_ORG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 19, 2012 1:44:02 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='login_org_id', Name='Login Org', Description=NULL, Help=NULL WHERE AD_Element_ID=200189 AND IsCentrallyMaintained='Y'
;

-- Oct 19, 2012 1:44:02 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Login Org', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200189) AND IsCentrallyMaintained='Y'
;

-- Oct 19, 2012 1:44:03 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_PrintFormatItem SET PrintName='Login Org', Name='Login Org' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200189)
;

-- Oct 19, 2012 1:44:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element SET Name='Loing Client', PrintName='Loing Client',Updated=TO_TIMESTAMP('2012-10-19 13:44:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200186
;

-- Oct 19, 2012 1:44:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200186
;

-- Oct 19, 2012 1:44:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET ColumnName='login_client_id', Name='Loing Client', Description=NULL, Help=NULL WHERE AD_Element_ID=200186
;

-- Oct 19, 2012 1:44:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='login_client_id', Name='Loing Client', Description=NULL, Help=NULL, AD_Element_ID=200186 WHERE UPPER(ColumnName)='LOGIN_CLIENT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 19, 2012 1:44:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='login_client_id', Name='Loing Client', Description=NULL, Help=NULL WHERE AD_Element_ID=200186 AND IsCentrallyMaintained='Y'
;

-- Oct 19, 2012 1:44:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Loing Client', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200186) AND IsCentrallyMaintained='Y'
;

-- Oct 19, 2012 1:44:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_PrintFormatItem SET PrintName='Loing Client', Name='Loing Client' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200186)
;

-- Oct 19, 2012 1:46:13 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET IsKey='Y', IsUpdateable='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2012-10-19 13:46:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200588
;

-- Oct 19, 2012 1:46:39 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,10,'N','N',200706,'Y',200650,'N','D','Login Org','N','Y','b40af732-2db2-4cac-aa21-1149a50b106b',100,0,TO_TIMESTAMP('2012-10-19 13:46:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-19 13:46:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 19, 2012 1:46:39 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200650 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 19, 2012 1:46:40 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,10,'N','N',200705,'Y',200651,'N','The User identifies a unique user in the system. This could be an internal user or a business partner contact','D','User within the system - Internal or Business Partner Contact','User/Contact','N','Y','4dc92524-ada7-4797-9501-54e662606e48',100,0,TO_TIMESTAMP('2012-10-19 13:46:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-19 13:46:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 19, 2012 1:46:40 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200651 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200606
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200608
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200647
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200650
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200609
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200610
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200651
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200611
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200646
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200607
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200613
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200614
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200604
;

-- Oct 19, 2012 1:50:04 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200605
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200608
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200609
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200610
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200611
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200607
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200646
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200614
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200650
;

-- Oct 19, 2012 1:51:55 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200651
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200650
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200609
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200610
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200651
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200611
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200607
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200646
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200614
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 19, 2012 2:01:01 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 19, 2012 2:02:21 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-19 14:02:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200650
;

-- Oct 19, 2012 2:04:08 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Reference_Value_ID=276, AD_Reference_ID=18,Updated=TO_TIMESTAMP('2012-10-19 14:04:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200706
;

-- Oct 19, 2012 2:04:49 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Reference_Value_ID=130,Updated=TO_TIMESTAMP('2012-10-19 14:04:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200706
;

-- Oct 19, 2012 2:05:16 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Reference_Value_ID=276,Updated=TO_TIMESTAMP('2012-10-19 14:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200706
;

-- Oct 19, 2012 2:10:54 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_SessionInfo_v_ID',200190,'D','AD_SessionInfo_v','AD_SessionInfo_v','388c863c-f3a7-4645-8591-6e1604e725e8',0,TO_TIMESTAMP('2012-10-19 14:10:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-19 14:10:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 19, 2012 2:10:54 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200190 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 19, 2012 2:10:55 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200707,'D','N','N','N','N',10,'N',13,'Y',200190,'49302e65-9959-4cd4-8604-bc83ca508df0','N','N','N','AD_SessionInfo_v_ID','AD_SessionInfo_v',100,TO_TIMESTAMP('2012-10-19 14:10:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-19 14:10:47','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 19, 2012 2:10:55 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200707 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 19, 2012 2:12:49 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200025,10,'N','N',200707,'Y',200652,'N','D','AD_SessionInfo_v','N','N','d5552148-760e-4df8-a701-1c768670718f',100,0,TO_TIMESTAMP('2012-10-19 14:12:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-19 14:12:45','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Oct 19, 2012 2:12:49 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200652 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 19, 2012 2:32:50 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ad_sessioninfo_v_uu',200191,'D','ad_sessioninfo_v_uu','ad_sessioninfo_v_uu','c84d427a-3b7b-479a-82e2-7dd40d061ff6',0,TO_TIMESTAMP('2012-10-19 14:32:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-19 14:32:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 19, 2012 2:32:50 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200191 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 19, 2012 2:32:50 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200708,'D','N','N','N','N',36,'N',10,'N',200191,'2aeb7648-a543-4a73-af45-87b3b6096a1a','N','N','N','ad_sessioninfo_v_uu','ad_sessioninfo_v_uu',100,TO_TIMESTAMP('2012-10-19 14:32:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-19 14:32:49','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 19, 2012 2:32:50 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200708 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 19, 2012 2:33:58 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,36,'N','N',200708,'Y',200653,'N','D','ad_sessioninfo_v_uu','N','Y','008aae2b-0106-44a8-a6a1-bbec08dba31a',100,0,TO_TIMESTAMP('2012-10-19 14:33:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-19 14:33:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 19, 2012 2:33:58 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200653 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 19, 2012 2:34:16 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200653
;

SELECT register_migration_script('935_IDEMPIERE-293.sql') FROM dual
;
