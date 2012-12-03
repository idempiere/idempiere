CREATE TABLE ad_broadcastmessage
(
  ad_client_id NUMBER(10,0) NOT NULL,
  ad_org_id NUMBER(10,0) NOT NULL,
  isactive CHAR(1 BYTE) DEFAULT 'Y' NOT NULL,
  created DATE DEFAULT SYSDATE NOT NULL ,
  createdby NUMBER(10,0) NOT NULL,
  updated DATE DEFAULT SYSDATE NOT NULL,
  updatedby NUMBER(10,0) NOT NULL,
  broadcastfrequency NVARCHAR2(60) NOT NULL,
  broadcastmessage  NVARCHAR2(2000) NOT NULL,
  broadcasttype NVARCHAR2(32) NOT NULL,
  expiration Date,
  logacknowledge CHAR(1 BYTE) DEFAULT 'N' NOT NULL,
  target NVARCHAR2(60) NOT NULL,
  ad_role_id NUMBER(10,0) DEFAULT NULL,
  ad_user_id NUMBER(10,0) DEFAULT NULL,
  testmessage character(1) DEFAULT NULL,
  publish character(1) DEFAULT NULL,
  expirenow character(1) DEFAULT NULL,
  ad_broadcastmessage_id NUMBER(10,0) NOT NULL,
  notification_client_id character varying(10),
  ispublished CHAR(1 BYTE) DEFAULT 'N' ,
  processed CHAR(1 BYTE) DEFAULT 'N',
  expired CHAR(1 BYTE) DEFAULT 'N',
  CHECK (IsActive  IN ('Y','N')) ENABLE,
  CHECK (expired  IN ('Y','N')) ENABLE,
  CHECK (ispublished  IN ('Y','N')) ENABLE,
  CHECK (logacknowledge  IN ('Y','N')) ENABLE,
  CHECK (processed  IN ('Y','N')) ENABLE,
  CONSTRAINT ad_broadcastmessage_key PRIMARY KEY (ad_broadcastmessage_id ))
;

-- Nov 24, 2012 12:56:04 PM PST
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','6',0,200038,'N','N','N','N','D','N','L','720b62dc-94f3-4246-b5aa-ee6f69b4230c','Y','Y','AD_BroadcastMessage','Broadcast Messages for system users','Broadcast Message',0,'Y',0,TO_DATE('2012-11-24 12:56:02','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2012-11-24 12:56:02','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 24, 2012 12:56:05 PM PST
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200038 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Nov 24, 2012 12:56:06 PM PST
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',200000,'Y',1000000,1000000,'N','Y',200034,'52f6c481-bd54-427d-8eff-0893a967256b','Table AD_BroadcastMessage','AD_BroadcastMessage',1,0,0,TO_DATE('2012-11-24 12:56:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-24 12:56:05','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Nov 24, 2012 12:57:21 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200977,'D','Y','N','N','N',10,'N',19,'N',102,'97226127-ebaa-4d09-8074-014cd14f738e','N','N','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',100,TO_DATE('2012-11-24 12:57:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:21 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200977 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:23 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200978,'D','Y','N','N','N',10,'N',19,'N',113,'ebbfe7a3-72b7-4ee9-9885-46d90ccc0b77','N','N','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',100,TO_DATE('2012-11-24 12:57:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:22','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:23 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200978 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:24 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200979,'D','Y','N','N','N',1,'N',20,'N',348,'3298c736-c408-4ba1-938f-16c0ffc4df78','N','Y','N','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active',100,TO_DATE('2012-11-24 12:57:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:24 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200979 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:25 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200980,'D','Y','N','N','N',29,'N',16,'N',245,'39ff0db1-1b66-4188-8756-0f51786f51a5','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created',100,TO_DATE('2012-11-24 12:57:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:25 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200980 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:26 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200981,'D',110,'Y','N','N','N',10,'N',18,'N',246,'d79e9cff-7232-4da0-bcef-419a8779d5bd','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By',100,TO_DATE('2012-11-24 12:57:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:26 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200981 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:27 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200982,'D','Y','N','N','N',13,'N',16,'N',607,'4346520f-4c54-4e39-ae77-2b72f0c6bb87','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated',100,TO_DATE('2012-11-24 12:57:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:27 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200982 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:28 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200983,'D',110,'Y','N','N','N',10,'N',18,'N',608,'918d82a3-adb8-4600-b1e8-ab93075109a7','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By',100,TO_DATE('2012-11-24 12:57:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:28 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200983 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:29 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('broadcastfrequency',200242,'D','broadcastfrequency','broadcastfrequency','c0fd20d8-ed19-4aee-88df-92b5fa836290',0,TO_DATE('2012-11-24 12:57:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:28','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:29 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200242 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:30 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200984,'D','Y','N','N','N',60,'N',10,'N',200242,'8a5f4b34-5686-4479-a612-2cfd6730105d','N','Y','N','broadcastfrequency','broadcastfrequency',100,TO_DATE('2012-11-24 12:57:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:28','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:30 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200984 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:31 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('broadcastmessage',200243,'D','broadcastmessage','broadcastmessage','8c17030c-7ae1-4aba-9ba2-6e3c98598bde',0,TO_DATE('2012-11-24 12:57:30','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:30','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:31 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200243 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:32 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200985,'D','Y','N','N','N',1024,'N',14,'N',200243,'de7a6a01-7d94-41b0-a4d8-2d36b5febe0f','N','Y','N','broadcastmessage','broadcastmessage',100,TO_DATE('2012-11-24 12:57:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:32 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200985 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:33 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('broadcasttype',200244,'D','broadcasttype','broadcasttype','fe9618b9-f5b1-443b-a237-5603424be727',0,TO_DATE('2012-11-24 12:57:32','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:32','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:33 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200244 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:35 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200986,'D','Y','N','N','N',32,'N',10,'N',200244,'ee2b0a4c-bcab-4388-92d5-86c7b950df61','N','Y','N','broadcasttype','broadcasttype',100,TO_DATE('2012-11-24 12:57:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:32','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:35 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200986 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:39 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('expiration',200245,'D','expiration','expiration','d9feb630-b638-416a-a32e-69e0947c0344',0,TO_DATE('2012-11-24 12:57:35','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:35','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:39 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200245 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:40 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200987,'D','N','N','N','N',29,'N',16,'N',200245,'00e3d997-d2f4-4691-84f2-273e6a945732','N','Y','N','expiration','expiration',100,TO_DATE('2012-11-24 12:57:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:35','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:40 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200987 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:45 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('logacknowledge',200246,'D','logacknowledge','logacknowledge','f0a20adc-47ed-4c3b-9f95-6cf06d983818',0,TO_DATE('2012-11-24 12:57:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:40','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:45 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200246 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:46 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200988,'D','N','N','N','N',1,'N',20,'N',200246,'5b1a8a44-3d84-4211-95b0-6ded91259569','N','Y','N','logacknowledge','logacknowledge',100,TO_DATE('2012-11-24 12:57:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:40','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:46 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200988 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:48 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('target',200247,'D','target','target','f35da3e9-5d4f-4c52-8129-ff7389c161aa',0,TO_DATE('2012-11-24 12:57:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:46','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:49 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200247 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:49 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200989,'D','Y','N','N','N',60,'N',10,'N',200247,'8766b4d1-c186-4f59-b79f-0b739c213b56','N','Y','N','target','target',100,TO_DATE('2012-11-24 12:57:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:46','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:49 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200989 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:50 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200990,'D','N','N','N','N',10,'N',19,'N',123,'d81ee55a-f71e-4f2e-850f-b9382dc3c309','N','Y','N','AD_Role_ID','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.','Role',100,TO_DATE('2012-11-24 12:57:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:49','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:50 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200990 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:51 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200991,'D','N','N','N','N',10,'N',19,'N',138,'5a7b6022-4cba-4ab5-8b45-6590a50ef29b','N','Y','N','AD_User_ID','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact',100,TO_DATE('2012-11-24 12:57:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:50','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:51 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200991 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:52 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('testmessage',200248,'D','testmessage','testmessage','024db2d6-4fbf-475f-a920-cb849538eb08',0,TO_DATE('2012-11-24 12:57:51','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:51','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:52 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200248 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:53 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200992,'D','N','N','N','N',1,'N',20,'N',200248,'36f6ffa0-af70-49b7-adf4-1f107d460082','N','Y','N','testmessage','testmessage',100,TO_DATE('2012-11-24 12:57:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:51','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:53 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200992 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:54 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('publish',200249,'D','publish','publish','686bc1d8-d573-44e4-85c6-912952a17a2c',0,TO_DATE('2012-11-24 12:57:53','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:53','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:54 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200249 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:56 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200993,'D','N','N','N','N',1,'N',20,'N',200249,'85ca0089-1a27-43fb-b105-e752f2d20bbc','N','Y','N','publish','publish',100,TO_DATE('2012-11-24 12:57:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:53','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:56 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200993 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:57 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('expirenow',200250,'D','expirenow','expirenow','6527163e-7775-4f43-80d2-8b610b56b2df',0,TO_DATE('2012-11-24 12:57:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:56','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:57 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200250 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:57:58 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200994,'D','N','N','N','N',1,'N',20,'N',200250,'97d17fb3-1afd-42bb-ba1c-31da1a9c5b7e','N','Y','N','expirenow','expirenow',100,TO_DATE('2012-11-24 12:57:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:56','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:57:58 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200994 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:57:59 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_BroadcastMessage_ID',200251,'D','Broadcast Message','Broadcast Message','27ffca30-a31e-40c9-915b-2f101e4d4e3e',0,TO_DATE('2012-11-24 12:57:58','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:57:58','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:57:59 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200251 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:58:02 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200995,'D','Y','N','N','N',10,'N',13,'Y',200251,'f9ea1472-7d98-439b-a5dd-e517347f37f4','N','N','N','AD_BroadcastMessage_ID','Broadcast Message',100,TO_DATE('2012-11-24 12:57:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:57:58','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:58:02 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200995 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:58:03 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Notification_Client_ID',200252,'D','Notification Client','Notification Client','9eea3b13-6ce5-4237-972a-67bab028928d',0,TO_DATE('2012-11-24 12:58:02','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:58:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:58:03 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200252 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:58:04 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200996,'D','N','N','N','N',10,'N',10,'N',200252,'3a92dc2a-9eac-4af0-ab77-e11ab9cc1905','N','Y','N','Notification_Client_ID','Notification_Client_ID',100,TO_DATE('2012-11-24 12:58:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:58:02','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:58:04 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200996 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:58:05 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200997,'D','N','N','N','N',1,'N',20,'N',2400,'153a43dd-6725-4b7d-8709-eb9d0ffc5c07','N','Y','N','IsPublished','The Topic is published and can be viewed','If not selected, the Topic is not visible to the general public.','Published',100,TO_DATE('2012-11-24 12:58:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:58:04','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:58:05 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200997 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:58:06 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200998,'D','N','N','N','N',1,'N',20,'N',1047,'872b2050-9f7a-4a16-8b09-d5ff131be0fd','N','Y','N','Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.','Processed',100,TO_DATE('2012-11-24 12:58:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:58:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:58:06 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200998 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:58:07 PM PST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('expired',200253,'D','expired','expired','aa817c1d-fd43-447d-ac07-a8ee8c48084a',0,TO_DATE('2012-11-24 12:58:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 12:58:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 24, 2012 12:58:07 PM PST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200253 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 24, 2012 12:58:08 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200038,200999,'D','N','N','N','N',1,'N',20,'N',200253,'179ba45e-1729-46d8-8e42-2ca1454f4036','N','Y','N','expired','expired',100,TO_DATE('2012-11-24 12:58:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 12:58:06','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 24, 2012 12:58:08 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200999 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 12:59:15 PM PST
UPDATE AD_Element SET Description='Broadcast Message',Updated=TO_DATE('2012-11-24 12:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200251
;

-- Nov 24, 2012 12:59:15 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200251
;

-- Nov 24, 2012 12:59:15 PM PST
UPDATE AD_Column SET ColumnName='AD_BroadcastMessage_ID', Name='Broadcast Message', Description='Broadcast Message', Help=NULL WHERE AD_Element_ID=200251
;

-- Nov 24, 2012 12:59:15 PM PST
UPDATE AD_Process_Para SET ColumnName='AD_BroadcastMessage_ID', Name='Broadcast Message', Description='Broadcast Message', Help=NULL, AD_Element_ID=200251 WHERE UPPER(ColumnName)='AD_BROADCASTMESSAGE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 12:59:15 PM PST
UPDATE AD_Process_Para SET ColumnName='AD_BroadcastMessage_ID', Name='Broadcast Message', Description='Broadcast Message', Help=NULL WHERE AD_Element_ID=200251 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 12:59:15 PM PST
UPDATE AD_Field SET Name='Broadcast Message', Description='Broadcast Message', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200251) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 12:59:27 PM PST
UPDATE AD_Column SET IsUpdateable='N', Name='Broadcast Messag', IsAllowCopy='N',Updated=TO_DATE('2012-11-24 12:59:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200995
;

-- Nov 24, 2012 12:59:27 PM PST
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200995
;

-- Nov 24, 2012 12:59:27 PM PST
UPDATE AD_Field SET Name='Broadcast Messag', Description='Broadcast Message', Help=NULL WHERE AD_Column_ID=200995 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:00:40 PM PST
UPDATE AD_Element SET ColumnName='BroadcastFrequency', Description='How Many Times Message Should be Broadcasted', Name='Broadcast Frequency', PrintName='Broadcast Frequency',Updated=TO_DATE('2012-11-24 13:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200242
;

-- Nov 24, 2012 1:00:40 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200242
;

-- Nov 24, 2012 1:00:40 PM PST
UPDATE AD_Column SET ColumnName='BroadcastFrequency', Name='Broadcast Frequency', Description='How Many Times Message Should be Broadcasted', Help=NULL WHERE AD_Element_ID=200242
;

-- Nov 24, 2012 1:00:40 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastFrequency', Name='Broadcast Frequency', Description='How Many Times Message Should be Broadcasted', Help=NULL, AD_Element_ID=200242 WHERE UPPER(ColumnName)='BROADCASTFREQUENCY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:00:40 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastFrequency', Name='Broadcast Frequency', Description='How Many Times Message Should be Broadcasted', Help=NULL WHERE AD_Element_ID=200242 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:00:40 PM PST
UPDATE AD_Field SET Name='Broadcast Frequency', Description='How Many Times Message Should be Broadcasted', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200242) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:00:40 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Broadcast Frequency', Name='Broadcast Frequency' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200242)
;

-- Nov 24, 2012 1:01:38 PM PST
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,VFormat,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200020,'AD_BroadcastMessage_Frequency','D','d36f1fde-2e1f-43c9-b0cb-cd0f949831e3','N','Frequency of Broadcast','L','L',0,0,100,TO_DATE('2012-11-24 13:01:37','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-11-24 13:01:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 24, 2012 1:01:38 PM PST
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Nov 24, 2012 1:02:17 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200045,200020,'D','Message will be broadcasted one time','Just Once','eb20103b-6c47-449d-b7f5-2e28c797beaf','J',100,TO_DATE('2012-11-24 13:02:13','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:02:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:02:17 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200045 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:02:48 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200046,200020,'D','Repeat it until message expiration value','Until Expiration','e60b5002-3fa4-49bf-aca3-d8146471a538','U',100,TO_DATE('2012-11-24 13:02:44','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:02:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:02:48 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200046 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:03:24 PM PST
UPDATE AD_Column SET AD_Reference_Value_ID=200020, AD_Reference_ID=17,Updated=TO_DATE('2012-11-24 13:03:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200984
;

-- Nov 24, 2012 1:04:15 PM PST
UPDATE AD_Element SET ColumnName='BroadcastMessage', Description='Broadcast Message', Name='Broadcast Message', PrintName='Broadcast Message',Updated=TO_DATE('2012-11-24 13:04:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200243
;

-- Nov 24, 2012 1:04:15 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200243
;

-- Nov 24, 2012 1:04:15 PM PST
UPDATE AD_Column SET ColumnName='BroadcastMessage', Name='Broadcast Message', Description='Broadcast Message', Help=NULL WHERE AD_Element_ID=200243
;

-- Nov 24, 2012 1:04:15 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastMessage', Name='Broadcast Message', Description='Broadcast Message', Help=NULL, AD_Element_ID=200243 WHERE UPPER(ColumnName)='BROADCASTMESSAGE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:04:15 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastMessage', Name='Broadcast Message', Description='Broadcast Message', Help=NULL WHERE AD_Element_ID=200243 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:04:15 PM PST
UPDATE AD_Field SET Name='Broadcast Message', Description='Broadcast Message', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200243) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:04:15 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Broadcast Message', Name='Broadcast Message' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200243)
;

-- Nov 24, 2012 1:04:29 PM PST
UPDATE AD_Column SET AD_Reference_ID=34,Updated=TO_DATE('2012-11-24 13:04:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200985
;

-- Nov 24, 2012 1:05:36 PM PST
UPDATE AD_Element SET ColumnName='BroadcastType', Description='Broadcast Type', Name='Broadcast Type', PrintName='Broadcast Type',Updated=TO_DATE('2012-11-24 13:05:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200244
;

-- Nov 24, 2012 1:05:36 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200244
;

-- Nov 24, 2012 1:05:36 PM PST
UPDATE AD_Column SET ColumnName='BroadcastType', Name='Broadcast Type', Description='Broadcast Type', Help=NULL WHERE AD_Element_ID=200244
;

-- Nov 24, 2012 1:05:36 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastType', Name='Broadcast Type', Description='Broadcast Type', Help=NULL, AD_Element_ID=200244 WHERE UPPER(ColumnName)='BROADCASTTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:05:36 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastType', Name='Broadcast Type', Description='Broadcast Type', Help=NULL WHERE AD_Element_ID=200244 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:05:36 PM PST
UPDATE AD_Field SET Name='Broadcast Type', Description='Broadcast Type', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200244) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:05:37 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Broadcast Type', Name='Broadcast Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200244)
;

-- Nov 24, 2012 1:06:13 PM PST
UPDATE AD_Element SET Description='Type of Broadcast',Updated=TO_DATE('2012-11-24 13:06:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200244
;

-- Nov 24, 2012 1:06:13 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200244
;

-- Nov 24, 2012 1:06:13 PM PST
UPDATE AD_Column SET ColumnName='BroadcastType', Name='Broadcast Type', Description='Type of Broadcast', Help=NULL WHERE AD_Element_ID=200244
;

-- Nov 24, 2012 1:06:13 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastType', Name='Broadcast Type', Description='Type of Broadcast', Help=NULL, AD_Element_ID=200244 WHERE UPPER(ColumnName)='BROADCASTTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:06:13 PM PST
UPDATE AD_Process_Para SET ColumnName='BroadcastType', Name='Broadcast Type', Description='Type of Broadcast', Help=NULL WHERE AD_Element_ID=200244 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:06:13 PM PST
UPDATE AD_Field SET Name='Broadcast Type', Description='Type of Broadcast', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200244) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:07:01 PM PST
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,VFormat,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200021,'AD_BroadcastMessage_Type','D','63a15ff5-2048-4fa3-a8ec-93e4d55d9078','N','Type of broadcast messages','L','L',0,0,100,TO_DATE('2012-11-24 13:06:57','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-11-24 13:06:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 24, 2012 1:07:02 PM PST
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Nov 24, 2012 1:07:56 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200047,200021,'D','show a modal popup dialog to all users connected','Immediate','616b30c8-b810-4eb8-97c7-69ac8c5d042f','I',100,TO_DATE('2012-11-24 13:07:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:07:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:07:56 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200047 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:08:19 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200048,200021,'D','Immediate + Login','Immediate + Login','6237108e-64f8-4873-9d9b-4523d5b86f77','IL',100,TO_DATE('2012-11-24 13:08:19','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:08:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:08:19 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200048 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:08:42 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200049,200021,'D','Shows a modal popup dialog at login time','Login','6cd78804-e0f9-4f33-bd0d-b7fdde926648','L',100,TO_DATE('2012-11-24 13:08:41','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:08:41','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:08:42 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200049 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:08:47 PM PST
UPDATE AD_Ref_List SET EntityType='D',Updated=TO_DATE('2012-11-24 13:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200049
;

-- Nov 24, 2012 1:09:53 PM PST
UPDATE AD_Column SET AD_Reference_Value_ID=200021, AD_Reference_ID=17,Updated=TO_DATE('2012-11-24 13:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200986
;

-- Nov 24, 2012 1:11:35 PM PST
UPDATE AD_Element SET ColumnName='Expiration', Description='Expire On', Name='Expire On', PrintName='Expire On',Updated=TO_DATE('2012-11-24 13:11:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200245
;

-- Nov 24, 2012 1:11:35 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200245
;

-- Nov 24, 2012 1:11:36 PM PST
UPDATE AD_Column SET ColumnName='Expiration', Name='Expire On', Description='Expire On', Help=NULL WHERE AD_Element_ID=200245
;

-- Nov 24, 2012 1:11:36 PM PST
UPDATE AD_Process_Para SET ColumnName='Expiration', Name='Expire On', Description='Expire On', Help=NULL, AD_Element_ID=200245 WHERE UPPER(ColumnName)='EXPIRATION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:11:37 PM PST
UPDATE AD_Process_Para SET ColumnName='Expiration', Name='Expire On', Description='Expire On', Help=NULL WHERE AD_Element_ID=200245 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:11:37 PM PST
UPDATE AD_Field SET Name='Expire On', Description='Expire On', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200245) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:11:38 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Expire On', Name='Expire On' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200245)
;

-- Nov 24, 2012 1:13:24 PM PST
UPDATE AD_Element SET ColumnName='Expired', Name='Expired', PrintName='Expired',Updated=TO_DATE('2012-11-24 13:13:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200253
;

-- Nov 24, 2012 1:13:24 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200253
;

-- Nov 24, 2012 1:13:24 PM PST
UPDATE AD_Column SET ColumnName='Expired', Name='Expired', Description=NULL, Help=NULL WHERE AD_Element_ID=200253
;

-- Nov 24, 2012 1:13:24 PM PST
UPDATE AD_Process_Para SET ColumnName='Expired', Name='Expired', Description=NULL, Help=NULL, AD_Element_ID=200253 WHERE UPPER(ColumnName)='EXPIRED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:13:24 PM PST
UPDATE AD_Process_Para SET ColumnName='Expired', Name='Expired', Description=NULL, Help=NULL WHERE AD_Element_ID=200253 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:13:24 PM PST
UPDATE AD_Field SET Name='Expired', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200253) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:13:24 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Expired', Name='Expired' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200253)
;

-- Nov 24, 2012 1:13:31 PM PST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2012-11-24 13:13:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200999
;

-- Nov 24, 2012 1:13:53 PM PST
ALTER TABLE AD_BroadcastMessage MODIFY Expired CHAR(1) DEFAULT 'N'
;

-- Nov 24, 2012 1:14:36 PM PST
UPDATE AD_Element SET ColumnName='ExpireNow', Description='Expire the broadcast message', Name='Expire Now', PrintName='Expire Now',Updated=TO_DATE('2012-11-24 13:14:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200250
;

-- Nov 24, 2012 1:14:36 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200250
;

-- Nov 24, 2012 1:14:36 PM PST
UPDATE AD_Column SET ColumnName='ExpireNow', Name='Expire Now', Description='Expire the broadcast message', Help=NULL WHERE AD_Element_ID=200250
;

-- Nov 24, 2012 1:14:36 PM PST
UPDATE AD_Process_Para SET ColumnName='ExpireNow', Name='Expire Now', Description='Expire the broadcast message', Help=NULL, AD_Element_ID=200250 WHERE UPPER(ColumnName)='EXPIRENOW' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:14:36 PM PST
UPDATE AD_Process_Para SET ColumnName='ExpireNow', Name='Expire Now', Description='Expire the broadcast message', Help=NULL WHERE AD_Element_ID=200250 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:14:36 PM PST
UPDATE AD_Field SET Name='Expire Now', Description='Expire the broadcast message', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200250) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:14:36 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Expire Now', Name='Expire Now' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200250)
;

-- Nov 24, 2012 1:16:26 PM PST
INSERT INTO AD_Process (Help,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,CopyFromProcess,Classname,Description,Name,Value,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy) VALUES ('Expire BroadcastMeassage',200018,'N','N','9db3c2f0-3c8b-4b32-9101-2be9ba888888','4','N','N',0,0,'Y','D','N','org.adempiere.webui.process.ExpireBrodcastMessage','Expire BroadcastMeassage','Expire BroadcastMeassage','AD_ExpireBroadcastMeassage',0,0,TO_DATE('2012-11-24 13:16:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-24 13:16:22','YYYY-MM-DD HH24:MI:SS'),'Y',100)
;

-- Nov 24, 2012 1:16:26 PM PST
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200018 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 24, 2012 1:17:21 PM PST
UPDATE AD_Column SET AD_Reference_ID=28, AD_Process_ID=200018, ReadOnlyLogic='@IsPublished@=N | @Expired@=Y | @BroadcastFrequency@!U', IsAlwaysUpdateable='Y',Updated=TO_DATE('2012-11-24 13:17:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200994
;

-- Nov 24, 2012 1:17:24 PM PST
ALTER TABLE AD_BroadcastMessage MODIFY ExpireNow CHAR(1) DEFAULT NULL 
;

-- Nov 24, 2012 1:18:01 PM PST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2012-11-24 13:18:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200997
;

-- Nov 24, 2012 1:18:04 PM PST
ALTER TABLE AD_BroadcastMessage MODIFY IsPublished CHAR(1) DEFAULT 'N'
;

-- Nov 24, 2012 1:19:01 PM PST
UPDATE AD_Element SET ColumnName='LogAcknowledge', Description='Want to Log the Acknowledgement of Message?', Name='Log Acknowledge', PrintName='Log Acknowledge',Updated=TO_DATE('2012-11-24 13:19:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200246
;

-- Nov 24, 2012 1:19:01 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200246
;

-- Nov 24, 2012 1:19:01 PM PST
UPDATE AD_Column SET ColumnName='LogAcknowledge', Name='Log Acknowledge', Description='Want to Log the Acknowledgement of Message?', Help=NULL WHERE AD_Element_ID=200246
;

-- Nov 24, 2012 1:19:01 PM PST
UPDATE AD_Process_Para SET ColumnName='LogAcknowledge', Name='Log Acknowledge', Description='Want to Log the Acknowledgement of Message?', Help=NULL, AD_Element_ID=200246 WHERE UPPER(ColumnName)='LOGACKNOWLEDGE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:19:01 PM PST
UPDATE AD_Process_Para SET ColumnName='LogAcknowledge', Name='Log Acknowledge', Description='Want to Log the Acknowledgement of Message?', Help=NULL WHERE AD_Element_ID=200246 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:19:01 PM PST
UPDATE AD_Field SET Name='Log Acknowledge', Description='Want to Log the Acknowledgement of Message?', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200246) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:19:01 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Log Acknowledge', Name='Log Acknowledge' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200246)
;

-- Nov 24, 2012 1:20:42 PM PST
UPDATE AD_Element SET ColumnName='Notification_Client_ID', Description='Notification Client', Name='Notification Client', PrintName='Notification Client',Updated=TO_DATE('2012-11-24 13:20:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200252
;

-- Nov 24, 2012 1:20:42 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200252
;

-- Nov 24, 2012 1:20:42 PM PST
UPDATE AD_Column SET ColumnName='Notification_Client_ID', Name='Notification Client', Description='Notification Client', Help=NULL WHERE AD_Element_ID=200252
;

-- Nov 24, 2012 1:20:42 PM PST
UPDATE AD_Process_Para SET ColumnName='Notification_Client_ID', Name='Notification Client', Description='Notification Client', Help=NULL, AD_Element_ID=200252 WHERE UPPER(ColumnName)='NOTIFICATION_CLIENT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:20:42 PM PST
UPDATE AD_Process_Para SET ColumnName='Notification_Client_ID', Name='Notification Client', Description='Notification Client', Help=NULL WHERE AD_Element_ID=200252 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:20:42 PM PST
UPDATE AD_Field SET Name='Notification Client', Description='Notification Client', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200252) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:20:42 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Notification Client', Name='Notification Client' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200252)
;

-- Nov 24, 2012 1:21:49 PM PST
UPDATE AD_Column SET AD_Reference_Value_ID=129, AD_Reference_ID=18, MandatoryLogic='@Target@=''C''',Updated=TO_DATE('2012-11-24 13:21:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200996
;

-- Nov 24, 2012 1:22:22 PM PST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2012-11-24 13:22:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200998
;

-- Nov 24, 2012 1:22:56 PM PST
UPDATE AD_Element SET ColumnName='Publish', Description='Publish Broadcast Message', Name='Publish', PrintName='Publish',Updated=TO_DATE('2012-11-24 13:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200249
;

-- Nov 24, 2012 1:22:57 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200249
;

-- Nov 24, 2012 1:22:57 PM PST
UPDATE AD_Column SET ColumnName='Publish', Name='Publish', Description='Publish Broadcast Message', Help=NULL WHERE AD_Element_ID=200249
;

-- Nov 24, 2012 1:22:57 PM PST
UPDATE AD_Process_Para SET ColumnName='Publish', Name='Publish', Description='Publish Broadcast Message', Help=NULL, AD_Element_ID=200249 WHERE UPPER(ColumnName)='PUBLISH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:22:57 PM PST
UPDATE AD_Process_Para SET ColumnName='Publish', Name='Publish', Description='Publish Broadcast Message', Help=NULL WHERE AD_Element_ID=200249 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:22:57 PM PST
UPDATE AD_Field SET Name='Publish', Description='Publish Broadcast Message', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200249) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:22:57 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Publish', Name='Publish' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200249)
;

-- Nov 24, 2012 1:24:23 PM PST
INSERT INTO AD_Process (Help,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,CopyFromProcess,Classname,Description,Name,Value,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy) VALUES ('Publish Broadcast message',200019,'N','N','666bef59-d884-4f68-967d-3edd2d3f0418','6','N','N',0,0,'Y','D','N','org.adempiere.webui.process.PublishBrodcastMessage','Publish Broadcast message','Publish Broadcast message','AD_PublishBrodcastMessage',0,0,TO_DATE('2012-11-24 13:24:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-24 13:24:22','YYYY-MM-DD HH24:MI:SS'),'Y',100)
;

-- Nov 24, 2012 1:24:23 PM PST
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200019 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 24, 2012 1:24:59 PM PST
UPDATE AD_Column SET AD_Reference_ID=28, AD_Process_ID=200019, ReadOnlyLogic='@IsPublished@=Y',Updated=TO_DATE('2012-11-24 13:24:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200993
;

-- Nov 24, 2012 1:25:37 PM PST
UPDATE AD_Element SET ColumnName='Target', Description='Target client', Name='Target', PrintName='Target',Updated=TO_DATE('2012-11-24 13:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200247
;

-- Nov 24, 2012 1:25:37 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200247
;

-- Nov 24, 2012 1:25:37 PM PST
UPDATE AD_Column SET ColumnName='Target', Name='Target', Description='Target client', Help=NULL WHERE AD_Element_ID=200247
;

-- Nov 24, 2012 1:25:37 PM PST
UPDATE AD_Process_Para SET ColumnName='Target', Name='Target', Description='Target client', Help=NULL, AD_Element_ID=200247 WHERE UPPER(ColumnName)='TARGET' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:25:37 PM PST
UPDATE AD_Process_Para SET ColumnName='Target', Name='Target', Description='Target client', Help=NULL WHERE AD_Element_ID=200247 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:25:37 PM PST
UPDATE AD_Field SET Name='Target', Description='Target client', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200247) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:25:37 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Target', Name='Target' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200247)
;

-- Nov 24, 2012 1:26:41 PM PST
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,VFormat,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200022,'AD_BroadcastMessag_Target','D','301456b6-04c6-410d-acd1-e03203e25339','N','Target Client','L','L',0,0,100,TO_DATE('2012-11-24 13:26:40','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-11-24 13:26:40','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 24, 2012 1:26:41 PM PST
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Nov 24, 2012 1:27:32 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200050,200022,'D','Client','Client','1371569d-a605-41c8-86b6-f175ef4eb390','C',100,TO_DATE('2012-11-24 13:27:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:27:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:27:32 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200050 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:27:56 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200051,200022,'D','Everybody will receive message','Everybody','294904a2-0672-46f4-91ba-cbe14be17fe0','E',100,TO_DATE('2012-11-24 13:27:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:27:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:27:56 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200051 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:28:15 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200052,200022,'D','Message will reach out to all users with this role','Role','ea261c96-1b82-43ce-8f6a-e1e170f2851c','R',100,TO_DATE('2012-11-24 13:28:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:28:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:28:15 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200052 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:28:34 PM PST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200053,200022,'D','User will receive message','User','3ff1c5d6-9c71-49e7-b3ea-73ee6d025b28','U',100,TO_DATE('2012-11-24 13:28:33','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:28:33','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 24, 2012 1:28:34 PM PST
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200053 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 24, 2012 1:29:13 PM PST
UPDATE AD_Reference SET Name='AD_BroadcastMessage_Target',Updated=TO_DATE('2012-11-24 13:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200022
;

-- Nov 24, 2012 1:29:13 PM PST
UPDATE AD_Reference_Trl SET IsTranslated='N' WHERE AD_Reference_ID=200022
;

-- Nov 24, 2012 1:29:58 PM PST
UPDATE AD_Column SET AD_Reference_Value_ID=200022, AD_Reference_ID=17,Updated=TO_DATE('2012-11-24 13:29:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200989
;

-- Nov 24, 2012 1:30:43 PM PST
UPDATE AD_Element SET ColumnName='TestMessage', Description='Test broadcast message', Name='Test Message', PrintName='Test Message',Updated=TO_DATE('2012-11-24 13:30:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200248
;

-- Nov 24, 2012 1:30:43 PM PST
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200248
;

-- Nov 24, 2012 1:30:43 PM PST
UPDATE AD_Column SET ColumnName='TestMessage', Name='Test Message', Description='Test broadcast message', Help=NULL WHERE AD_Element_ID=200248
;

-- Nov 24, 2012 1:30:44 PM PST
UPDATE AD_Process_Para SET ColumnName='TestMessage', Name='Test Message', Description='Test broadcast message', Help=NULL, AD_Element_ID=200248 WHERE UPPER(ColumnName)='TESTMESSAGE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 24, 2012 1:30:44 PM PST
UPDATE AD_Process_Para SET ColumnName='TestMessage', Name='Test Message', Description='Test broadcast message', Help=NULL WHERE AD_Element_ID=200248 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:30:44 PM PST
UPDATE AD_Field SET Name='Test Message', Description='Test broadcast message', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200248) AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:30:44 PM PST
UPDATE AD_PrintFormatItem pi SET PrintName='Test Message', Name='Test Message' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200248)
;

-- Nov 24, 2012 1:32:13 PM PST
INSERT INTO AD_Process (AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,CopyFromProcess,Classname,Description,Name,Value,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy) VALUES (200020,'N','N','43c7fcd3-d271-45c2-a348-55caef5f8f06','6','N','N',0,0,'Y','D','N','org.adempiere.webui.process.TestBrodcastMessage','Test and verify message before broadcasting','Test Brodcast Message','AD_TestBrodcastMessage',0,0,TO_DATE('2012-11-24 13:32:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-24 13:32:11','YYYY-MM-DD HH24:MI:SS'),'Y',100)
;

-- Nov 24, 2012 1:32:13 PM PST
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 24, 2012 1:32:37 PM PST
UPDATE AD_Column SET AD_Reference_ID=28, AD_Process_ID=200020,Updated=TO_DATE('2012-11-24 13:32:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200992
;

-- Nov 24, 2012 1:33:14 PM PST
UPDATE AD_Column SET IsUpdateable='N', Name='Broadcast Message',Updated=TO_DATE('2012-11-24 13:33:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200995
;

-- Nov 24, 2012 1:33:14 PM PST
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200995
;

-- Nov 24, 2012 1:33:14 PM PST
UPDATE AD_Field SET Name='Broadcast Message', Description='Broadcast Message', Help=NULL WHERE AD_Column_ID=200995 AND IsCentrallyMaintained='Y'
;

-- Nov 24, 2012 1:34:49 PM PST
UPDATE AD_Column SET MandatoryLogic='@Target@=''R''',Updated=TO_DATE('2012-11-24 13:34:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200990
;

-- Nov 24, 2012 1:35:13 PM PST
UPDATE AD_Column SET MandatoryLogic='@Target@=''U''',Updated=TO_DATE('2012-11-24 13:35:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200991
;

-- Nov 24, 2012 1:38:44 PM PST
ALTER TABLE AD_BroadcastMessage MODIFY Processed CHAR(1) DEFAULT 'N'
;

-- Nov 24, 2012 1:41:39 PM PST
INSERT INTO AD_Window (WindowType,Help,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,Description,AD_Window_ID,Processing,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('M','Window allows to enter broadcast messages','Y','N','N',0,0,'A','Broadcast Message','Broadcast Message',200023,'N','3921057a-c9dc-478b-9606-b4d615d943e5',TO_DATE('2012-11-24 13:41:36','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-24 13:41:36','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Nov 24, 2012 1:41:39 PM PST
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Nov 24, 2012 1:42:47 PM PST
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsReadOnly,IsInfoTab,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',200023,10,'N','N',200038,'N','N','N','N','Y','N',0,'5127b90a-d7a3-45aa-8000-bf81cc0dc49a','A','Broadcast Message','Broadcast Message',200033,0,0,TO_DATE('2012-11-24 13:42:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-24 13:42:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Nov 24, 2012 1:42:47 PM PST
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200033 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Nov 24, 2012 1:42:59 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200979,'Y',200872,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','A','The record is active in the system','Active','N','Y','ff9206cf-aea4-4ccb-9598-a21826f854d9',100,0,TO_DATE('2012-11-24 13:42:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:42:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:42:59 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200872 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:00 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,60,'N','N',200984,'Y',200873,'N','A','How Many Times Message Should be Broadcasted','Broadcast Frequency','N','Y','4f45134f-80df-4dea-bc01-eedce2512c3e',100,0,TO_DATE('2012-11-24 13:42:59','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:42:59','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:00 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200873 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:01 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200033,10,'N','N',200995,'Y',200874,'N','A','Broadcast Message','Broadcast Message','N','N','acdb5d09-5e6a-47a8-925c-856e62e66a1c',100,0,TO_DATE('2012-11-24 13:43:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:00','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Nov 24, 2012 1:43:01 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200874 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:02 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1024,'N','N',200985,'Y',200875,'N','A','Broadcast Message','Broadcast Message','N','Y','646e39b8-9438-4859-9bee-ade63c85a107',100,0,TO_DATE('2012-11-24 13:43:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:01','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:02 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200875 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:03 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,32,'N','N',200986,'Y',200876,'N','A','Type of Broadcast','Broadcast Type','N','Y','4429b766-6dcf-4f3c-9ea0-bb45b3056ee2',100,0,TO_DATE('2012-11-24 13:43:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:03 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200876 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:04 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,10,'N','N',200977,'Y',200877,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','A','Client/Tenant for this installation.','Client','N','Y','c3ea9198-f208-4a0c-9fd2-4f5c17cb0f0c',100,0,TO_DATE('2012-11-24 13:43:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:04 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200877 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:05 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200994,'Y',200878,'N','A','Expire the broadcast message','Expire Now','N','Y','160c097e-2de3-45d1-8dd3-fccddba9279a',100,0,TO_DATE('2012-11-24 13:43:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:05 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200878 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:06 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,29,'N','N',200987,'Y',200879,'N','A','Expire On','Expire On','N','Y','7700a7ca-014b-4229-a3a7-49d48929824f',100,0,TO_DATE('2012-11-24 13:43:05','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:05','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:06 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200879 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:06 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200999,'Y',200880,'N','A','Expired','N','Y','91a41749-215e-4183-91fe-f7f3de49d93d',100,0,TO_DATE('2012-11-24 13:43:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:07 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200880 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:07 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200988,'Y',200881,'N','A','Want to Log the Acknowledgement of Message?','Log Acknowledge','N','Y','1b667ff2-5905-4b86-92a2-23742182d654',100,0,TO_DATE('2012-11-24 13:43:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:07 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200881 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:08 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,10,'N','N',200996,'Y',200882,'N','A','Notification Client','Notification Client','N','Y','ebcd0bdf-30c5-4f9f-9ff4-5be872cfda92',100,0,TO_DATE('2012-11-24 13:43:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:08 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200882 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:09 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,10,'N','N',200978,'Y',200883,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','A','Organizational entity within client','Organization','N','Y','ed4a7276-ca65-41a3-af3f-466938683821',100,0,TO_DATE('2012-11-24 13:43:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:09 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200883 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:10 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200998,'Y',200884,'N','The Processed checkbox indicates that a document has been processed.','A','The document has been processed','Processed','N','Y','69a5eb2f-d1f2-4662-ae12-1da3328892c4',100,0,TO_DATE('2012-11-24 13:43:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:10 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200884 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:11 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200993,'Y',200885,'N','A','Publish Broadcast Message','Publish','N','Y','2522aeea-2dd0-490f-801b-18c9ffc1291f',100,0,TO_DATE('2012-11-24 13:43:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:11 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200885 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:13 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200997,'Y',200886,'N','If not selected, the Topic is not visible to the general public.','A','The Topic is published and can be viewed','Published','N','Y','26bfd1f4-cee9-471e-bc91-d5e15b06ec03',100,0,TO_DATE('2012-11-24 13:43:11','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:11','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:13 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200886 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:14 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,10,'N','N',200990,'Y',200887,'N','The Role determines security and access a user who has this Role will have in the System.','A','Responsibility Role','Role','N','Y','ee945909-185a-4fba-b24f-9e6d9132b86a',100,0,TO_DATE('2012-11-24 13:43:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:14 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200887 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:16 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,60,'N','N',200989,'Y',200888,'N','A','Target client','Target','N','Y','6c4ddf06-ca1c-4a17-bdb1-d55eb3eeb6bc',100,0,TO_DATE('2012-11-24 13:43:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:16 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200888 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:18 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,1,'N','N',200992,'Y',200889,'N','A','Test broadcast message','Test Message','N','Y','b4355a44-9bf0-4e08-aa36-b510191cd185',100,0,TO_DATE('2012-11-24 13:43:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:18 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200889 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:43:19 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200033,10,'N','N',200991,'Y',200890,'N','The User identifies a unique user in the system. This could be an internal user or a business partner contact','A','User within the system - Internal or Business Partner Contact','User/Contact','N','Y','1aff8aec-0672-40ba-9c76-5732a715ae4f',100,0,TO_DATE('2012-11-24 13:43:18','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 13:43:18','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 1:43:19 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200890 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200884
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200877
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200883
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200875
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200876
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200888
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200882
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200887
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200890
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200873
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200879
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200881
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200889
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200872
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200878
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200880
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200885
;

-- Nov 24, 2012 1:47:17 PM PST
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200886
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200877
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200883
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200884
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200876
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200888
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200873
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200875
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200879
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200881
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200882
;

-- Nov 24, 2012 1:48:58 PM PST
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200887
;

-- Nov 24, 2012 1:48:59 PM PST
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200890
;

-- Nov 24, 2012 1:48:59 PM PST
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200886
;

-- Nov 24, 2012 1:48:59 PM PST
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200880
;

-- Nov 24, 2012 1:48:59 PM PST
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200889
;

-- Nov 24, 2012 1:48:59 PM PST
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200885
;

-- Nov 24, 2012 1:48:59 PM PST
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200878
;

-- Nov 24, 2012 1:48:59 PM PST
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200872
;

-- Nov 24, 2012 1:49:36 PM PST
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:49:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200877
;

-- Nov 24, 2012 1:49:57 PM PST
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2012-11-24 13:49:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200883
;

-- Nov 24, 2012 1:50:23 PM PST
UPDATE AD_Field SET ColumnSpan=5, NumLines=8,Updated=TO_DATE('2012-11-24 13:50:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200875
;

-- Nov 24, 2012 1:50:49 PM PST
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-11-24 13:50:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200876
;

-- Nov 24, 2012 1:51:21 PM PST
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-11-24 13:51:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200888
;

-- Nov 24, 2012 1:52:28 PM PST
UPDATE AD_Field SET DisplayLogic='@Target@=''C''', ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:52:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200882
;

-- Nov 24, 2012 1:52:59 PM PST
UPDATE AD_Field SET DisplayLogic='@Target@=''R''', ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:52:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200887
;

-- Nov 24, 2012 1:53:22 PM PST
UPDATE AD_Field SET DisplayLogic='@Target@=''U''', ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:53:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200890
;

-- Nov 24, 2012 1:53:42 PM PST
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-11-24 13:53:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200873
;

-- Nov 24, 2012 1:54:18 PM PST
UPDATE AD_Field SET DisplayLogic='@BroadcastFrequency@=''U''', ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:54:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200879
;

-- Nov 24, 2012 1:55:04 PM PST
UPDATE AD_Field SET DisplayLogic='@BroadcastFrequency@=''U''', XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:55:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200881
;

-- Nov 24, 2012 1:55:59 PM PST
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:55:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200889
;

-- Nov 24, 2012 1:56:21 PM PST
UPDATE AD_Field SET XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:56:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200872
;

-- Nov 24, 2012 1:56:37 PM PST
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:56:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200878
;

-- Nov 24, 2012 1:57:03 PM PST
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200880
;

-- Nov 24, 2012 1:57:22 PM PST
UPDATE AD_Field SET XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:57:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200885
;

-- Nov 24, 2012 1:57:44 PM PST
UPDATE AD_Field SET XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-11-24 13:57:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200886
;

-- Nov 24, 2012 1:59:29 PM PST
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200023,200028,'N','N','N','D','Y','Broadcast Message','Broadcast Message','W','059e2b46-f8dc-4416-aa9a-5b51c7a7130f','Y',0,100,TO_DATE('2012-11-24 13:59:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-11-24 13:59:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 24, 2012 1:59:29 PM PST
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Nov 24, 2012 1:59:30 PM PST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200028, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200028)
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=228
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=155
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=156
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=175
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=157
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53251
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=552
;

-- Nov 24, 2012 1:59:37 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200028
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=155
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=156
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=175
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=157
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53251
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=552
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200028
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Nov 24, 2012 1:59:47 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200028
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=583
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=578
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=570
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=579
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=576
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=587
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=588
;

-- Nov 24, 2012 1:59:55 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=584
;

-- Nov 24, 2012 1:59:56 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=574
;

-- Nov 24, 2012 1:59:56 PM PST
UPDATE AD_TreeNodeMM SET Parent_ID=566, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=573
;





-- Nov 24, 2012 3:16:52 PM PST
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,389,201000,'D','N','N','N',0,'N',10,'N',19,'N','N',200251,'N','Y','7af23ae2-777d-497a-a9a4-9aa32322df76','N','Y','N','AD_BroadcastMessage_ID','Broadcast Message','Broadcast Message','Y',100,TO_DATE('2012-11-24 15:16:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-24 15:16:50','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Nov 24, 2012 3:16:52 PM PST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=201000 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 24, 2012 3:18:05 PM PST
ALTER TABLE AD_Note ADD AD_BroadcastMessage_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 24, 2012 3:25:27 PM PST
UPDATE AD_Tab SET WhereClause='((AD_Note.AD_User_ID IN (0,@#AD_User_ID@) OR AD_Note.AD_User_ID IS NULL) AND AD_Note.AD_BroadcastMessage_ID IS NULL)',Updated=TO_DATE('2012-11-24 15:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=325
;

-- Nov 24, 2012 3:25:38 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',325,36,'N','N',60439,'Y',200891,'N','D','AD_Note_UU','N','Y','ca5dac32-b197-4dbe-b4f9-1b9ec3cf2818',100,0,TO_DATE('2012-11-24 15:25:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 15:25:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 3:25:38 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200891 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 3:25:39 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',325,10,'N','N',201000,'Y',200892,'N','D','Broadcast Message','Broadcast Message','N','Y','87d4cf8c-ff2c-49cd-8a9a-d70830a0bf54',100,0,TO_DATE('2012-11-24 15:25:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 15:25:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 3:25:40 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200892 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200891
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=3951
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200892
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=3947
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=3946
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=3948
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=5378
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=10199
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=4632
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=9244
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=4728
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=4729
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=4726
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9243
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=8894
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=4725
;

-- Nov 24, 2012 3:34:02 PM PST
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=8288
;





-- Nov 24, 2012 6:06:23 PM PST
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsReadOnly,IsInfoTab,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',200023,20,'N','N',389,'N','N','N','N','Y','N',0,'de8b3fac-7476-43df-964e-4ea4ad3f2947','D','Message Log',200035,0,0,TO_DATE('2012-11-24 18:06:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-24 18:06:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Nov 24, 2012 6:06:23 PM PST
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200035 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Nov 24, 2012 6:07:47 PM PST
UPDATE AD_Tab SET IsReadOnly='Y', AD_Column_ID=201000, IsInsertRecord='N',Updated=TO_DATE('2012-11-24 18:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200035
;

-- Nov 24, 2012 6:08:03 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,1,'N','N',4828,'Y',200909,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','d9962f06-b2cd-496a-be9a-6709e5a582ff',100,0,TO_DATE('2012-11-24 18:08:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:01','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:03 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200909 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:04 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,36,'N','N',60439,'Y',200910,'N','D','AD_Note_UU','N','Y','78722e6a-eed1-49f1-9ae0-faf48eebe07c',100,0,TO_DATE('2012-11-24 18:08:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:04 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200910 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:06 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,10,'N','N',201000,'Y',200911,'N','D','Broadcast Message','Broadcast Message','N','Y','4a77c91f-da49-4a1d-9e07-7e1e5af9a003',100,0,TO_DATE('2012-11-24 18:08:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:06 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200911 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:07 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,22,'N','N',4826,'Y',200912,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','214cf3b1-52bb-44f3-b371-62bc314933cc',100,0,TO_DATE('2012-11-24 18:08:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:07 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200912 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:08 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,255,'N','N',10581,'Y',200913,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','N','Y','15953a20-bd5a-4895-a7ed-05f38d910a72',100,0,TO_DATE('2012-11-24 18:08:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:08 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200913 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:10 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,22,'N','N',6768,'Y',200914,'N','Information and Error messages','D','System Message','Message','N','Y','66078878-ab90-4f36-82cc-fbbb088f38a5',100,0,TO_DATE('2012-11-24 18:08:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:10 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200914 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:14 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200035,22,'N','N',4825,'Y',200915,'N','D','System Notice','Notice','N','N','610386a3-0125-4f8a-b1ba-947964af974f',100,0,TO_DATE('2012-11-24 18:08:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:10','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Nov 24, 2012 6:08:14 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200915 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:15 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,22,'N','N',4827,'Y',200916,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','c5b02d3e-6463-4195-95f2-73b1fce238fb',100,0,TO_DATE('2012-11-24 18:08:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:15 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200916 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:16 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,1,'N','N',9954,'Y',200917,'N','D','Process Now','N','Y','2e9b42a5-6240-4ab9-a27c-97d2775b0a48',100,0,TO_DATE('2012-11-24 18:08:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:16 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200917 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:17 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,1,'N','N',5949,'Y',200918,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','N','Y','fe91998f-2e61-4119-8907-000accc810a1',100,0,TO_DATE('2012-11-24 18:08:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:17 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200918 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:18 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,22,'N','N',5958,'Y',200919,'N','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','D','Direct internal record ID','Record ID','N','Y','8c87eefa-9f3d-4389-a443-1ea9f103f8cc',100,0,TO_DATE('2012-11-24 18:08:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:18 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200919 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:19 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,60,'N','N',5950,'Y',200920,'N','The Reference displays the source document number.','D','Reference for this record','Reference','N','Y','eb60afa4-52cb-498f-b964-f30eddccdb0a',100,0,TO_DATE('2012-11-24 18:08:18','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:18','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:19 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200920 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:20 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,22,'N','N',5957,'Y',200921,'N','The Database Table provides the information of the table definition','D','Database Table information','Table','N','Y','febe69e2-4814-42dc-9199-43bda7a523af',100,0,TO_DATE('2012-11-24 18:08:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:19','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:20 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200921 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:21 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,2000,'N','N',10806,'Y',200922,'N','D','Text Message','Text Message','N','Y','ad08bb01-9d16-4b0e-8dd5-c1b90ebe4c8e',100,0,TO_DATE('2012-11-24 18:08:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:21 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200922 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:22 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,22,'N','N',5946,'Y',200923,'N','The User identifies a unique user in the system. This could be an internal user or a business partner contact','D','User within the system - Internal or Business Partner Contact','User/Contact','N','Y','7344d2ae-a9c5-458c-b872-47aa2f1b20be',100,0,TO_DATE('2012-11-24 18:08:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:22 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200923 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:08:23 PM PST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200035,22,'N','N',10807,'Y',200924,'N','The Workflow Activity is the actual Workflow Node in a Workflow Process instance','D','Workflow Activity','Workflow Activity','N','Y','f04dbd2e-d4ea-46a7-8298-bc9dc7a1d188',100,0,TO_DATE('2012-11-24 18:08:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-24 18:08:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 24, 2012 6:08:23 PM PST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200924 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200910
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200909
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200911
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200912
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200913
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200914
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200916
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200917
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200918
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200919
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200920
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200921
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200922
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200923
;

-- Nov 24, 2012 6:09:35 PM PST
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200924
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200912
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200916
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200914
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200923
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200924
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200921
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200919
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200920
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200922
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200913
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200911
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200917
;

-- Nov 24, 2012 6:12:48 PM PST
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200918
;

-- Nov 24, 2012 6:13:12 PM PST
UPDATE AD_Field SET DisplayLength=14,Updated=TO_DATE('2012-11-24 18:13:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200912
;

-- Nov 24, 2012 6:13:41 PM PST
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2012-11-24 18:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200916
;

-- Nov 24, 2012 6:14:06 PM PST
UPDATE AD_Field SET DisplayLength=14, ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:14:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200914
;

-- Nov 24, 2012 6:14:29 PM PST
UPDATE AD_Field SET DisplayLength=14, ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:14:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200916
;

-- Nov 24, 2012 6:14:45 PM PST
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200912
;

-- Nov 24, 2012 6:15:16 PM PST
UPDATE AD_Field SET DisplayLength=20, XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200923
;

-- Nov 24, 2012 6:15:37 PM PST
UPDATE AD_Field SET DisplayLength=14, ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200924
;

-- Nov 24, 2012 6:16:03 PM PST
UPDATE AD_Field SET DisplayLength=14, ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:16:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200921
;

-- Nov 24, 2012 6:16:58 PM PST
UPDATE AD_Field SET DisplayLength=23, XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:16:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200919
;

-- Nov 24, 2012 6:17:21 PM PST
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-11-24 18:17:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200920
;

-- Nov 24, 2012 6:17:54 PM PST
UPDATE AD_Field SET ColumnSpan=5, NumLines=3,Updated=TO_DATE('2012-11-24 18:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200922
;

-- Nov 24, 2012 6:18:17 PM PST
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-11-24 18:18:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200913
;

-- Nov 24, 2012 6:18:35 PM PST
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-11-24 18:18:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200911
;

-- Nov 24, 2012 6:18:54 PM PST
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-11-24 18:18:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200917
;

-- Nov 24, 2012 6:19:16 PM PST
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-11-24 18:19:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200918
;



-- Nov 25, 2012 11:17:32 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Tab SET TabLevel=1,Updated=TO_DATE('2012-11-25 11:17:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200035
;

-- Nov 25, 2012 11:17:53 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Tab SET AD_Column_ID=201000,Updated=TO_DATE('2012-11-25 11:17:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200035
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200887
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200890
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200873
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200879
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200881
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200889
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200880
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200886
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200872
;

-- Nov 25, 2012 11:21:29 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200878
;

-- Nov 25, 2012 11:26:42 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET FieldLength=2000, IsToolbarButton='N',Updated=TO_DATE('2012-11-25 11:26:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200985
;

-- Nov 25, 2012 11:26:52 AM IST
-- IDEMPIERE-293  List of Active Session
ALTER TABLE AD_BroadcastMessage MODIFY BroadcastMessage NVARCHAR2(2000)
;





-- Nov 25, 2012 2:25:04 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_BroadcastMessage_UU',200254,'D','AD_BroadcastMessage_UU','AD_BroadcastMessage_UU','046f64f9-0438-41fe-8f63-e20e1d850290',0,TO_DATE('2012-11-25 14:25:02','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-25 14:25:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 25, 2012 2:25:04 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200254 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 25, 2012 2:25:38 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
INSERT INTO AD_Column (Version,AD_Column_ID,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,SeqNoSelection) VALUES (0,201001,200038,'U','N','N','N',0,'N',36,'N',10,'N','N',200254,'N','Y','2de2bb87-31ba-499d-9ca3-bfbf2cac3b71','N','Y','N','AD_BroadcastMessage_UU','AD_BroadcastMessage_UU','N',100,TO_DATE('2012-11-25 14:25:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-11-25 14:25:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0)
;

-- Nov 25, 2012 2:25:38 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=201001 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 25, 2012 2:25:48 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
ALTER TABLE AD_BroadcastMessage ADD AD_BroadcastMessage_UU NVARCHAR2(36) DEFAULT NULL 
;





-- Nov 25, 2012 2:35:44 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process SET ShowHelp='N',Updated=TO_DATE('2012-11-25 14:35:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200020
;

-- Nov 25, 2012 2:38:32 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process SET Help='Selecting ok will publish message.',Updated=TO_DATE('2012-11-25 14:38:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200019
;

-- Nov 25, 2012 2:38:32 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=200019
;

-- Nov 25, 2012 2:39:32 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process SET Help='Selecting OK will expire current message. Do you want to expire message?',Updated=TO_DATE('2012-11-25 14:39:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200018
;

-- Nov 25, 2012 2:39:32 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=200018
;

-- Nov 25, 2012 2:39:54 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process SET Help='Selecting ok will publish message.  Do you want to publish message?',Updated=TO_DATE('2012-11-25 14:39:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200019
;

-- Nov 25, 2012 2:39:54 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=200019
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200910
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200909
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200912
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200914
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200916
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200917
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200919
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200920
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200921
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200922
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200924
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200923
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200913
;

-- Nov 25, 2012 2:43:43 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200918
;

-- Nov 25, 2012 2:44:55 PM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Tab SET IsReadOnly='Y', IsInsertRecord='N',Updated=TO_DATE('2012-11-25 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200035
;

-- Nov 26, 2012 10:09:13 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-11-26 10:09:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200880
;

-- Nov 26, 2012 10:09:23 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-11-26 10:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200886
;

-- Nov 26, 2012 10:10:43 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-11-26 10:10:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200876
;

-- Nov 26, 2012 10:10:50 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-11-26 10:10:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200888
;

-- Nov 26, 2012 10:10:59 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-11-26 10:10:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200873
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200882
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200873
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200879
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200881
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200889
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200880
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200886
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200872
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200878
;

-- Nov 26, 2012 10:29:49 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200885
;

-- Nov 30, 2012 11:57:51 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process SET Classname='org.idempiere.broadcast.process.PublishBrodcastMessage',Updated=TO_DATE('2012-11-30 11:57:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200019
;

-- Nov 30, 2012 11:58:23 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process SET Classname='org.idempiere.broadcast.process.TestBrodcastMessage',Updated=TO_DATE('2012-11-30 11:58:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200020
;

-- Nov 30, 2012 11:58:42 AM IST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients 
UPDATE AD_Process SET Classname='org.idempiere.broadcast.process.ExpireBrodcastMessage',Updated=TO_DATE('2012-11-30 11:58:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200018
;


-- Dec 2, 2012 11:31:15 PM COT
-- IDEMPIERE-294 Maintenance
UPDATE AD_Tab SET EntityType='D',Updated=TO_DATE('2012-12-02 23:31:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200033
;

-- Dec 2, 2012 11:31:34 PM COT
-- IDEMPIERE-294 Maintenance
UPDATE AD_Window SET EntityType='D',Updated=TO_DATE('2012-12-02 23:31:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200023
;

-- Dec 2, 2012 11:32:40 PM COT
-- IDEMPIERE-294 Maintenance
UPDATE AD_Field SET ColumnSpan=2, SeqNo=20,Updated=TO_DATE('2012-12-02 23:32:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200883
;

-- Dec 2, 2012 11:32:40 PM COT
-- IDEMPIERE-294 Maintenance
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2012-12-02 23:32:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200874
;

-- Dec 2, 2012 11:34:42 PM COT
-- IDEMPIERE-294 Maintenance
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N',Updated=TO_DATE('2012-12-02 23:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200999
;

-- Dec 2, 2012 11:35:03 PM COT
-- IDEMPIERE-294 Maintenance
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N',Updated=TO_DATE('2012-12-02 23:35:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200997
;

-- Dec 2, 2012 11:35:33 PM COT
-- IDEMPIERE-294 Maintenance
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N',Updated=TO_DATE('2012-12-02 23:35:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200998
;

SELECT register_migration_script('201211250933_IDEMPIERE-294.sql') FROM dual
;

