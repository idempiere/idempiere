-- Aug 22, 2012 5:23:53 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','6',200013,'N','N','N','N','U','L','b86bdb9e-f5b6-4180-93ec-8bdd5b73e467','Y','Y','PA_DashboardPreference','Dashboard Preference',0,'Y',0,TO_TIMESTAMP('2012-08-22 17:23:52','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2012-08-22 17:23:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 22, 2012 5:23:53 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 22, 2012 5:23:54 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',50000,'Y',1000000,1000000,'N','Y',200013,'fcf31a3d-3c64-4a0b-8b0e-2507e44da1e1','Table PA_DashboardPreference','PA_DashboardPreference',1,0,0,TO_TIMESTAMP('2012-08-22 17:23:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-22 17:23:53','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Aug 22, 2012 5:24:08 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200324,'U','Y','N','N','N',10,'N',19,'Y',129,'N',102,'N','Y','70838ff0-ef46-4185-87d5-b9fb148d91ff','N','N','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2012-08-22 17:24:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:07','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:08 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200324 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:08 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200325,'U','Y','N','N','N',10,'N',19,'Y','N',113,'N','Y','9186e599-cd33-45b5-9b59-2e48aeb5dbe6','N','N','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2012-08-22 17:24:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:08','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:09 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200325 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:09 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200326,'U','N','N','N',0,'N',10,'N',19,'N','N',117,'N','Y','c2c4abb3-95b6-4de5-94a1-625f5754b377','N','Y','N','AD_Process_ID','Process or Report','The Process field identifies a unique Process or Report in the system.','Process','Y',100,TO_TIMESTAMP('2012-08-22 17:24:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:09','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:09 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200326 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:10 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200327,'U','N','N','N',0,'N',10,'N',19,'N','N',123,'N','Y','87bf2881-832d-4bde-98a6-2b3ca3bc10e6','N','Y','N','AD_Role_ID','Responsibility Role','0','The Role determines security and access a user who has this Role will have in the System.','Role','Y',100,TO_TIMESTAMP('2012-08-22 17:24:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:09','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:10 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200327 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:11 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200328,'U','N','N','N',0,'N',10,'N',19,'N','N',138,'N','Y','40fd1caf-0831-4740-9955-df6ef22b0259','N','Y','N','AD_User_ID','User within the system - Internal or Business Partner Contact','0','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact','Y',100,TO_TIMESTAMP('2012-08-22 17:24:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:10','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:11 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200328 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:11 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200329,'U','N','N','N','N',22,'N',19,'Y','N',143,'N','Y','b2130167-7717-4e78-b0a9-f4bb18e13de4','N','Y','N','AD_Window_ID','Data entry or display window','The Window field identifies a unique Window in the system.','Window','Y',100,TO_TIMESTAMP('2012-08-22 17:24:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:11','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:11 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200329 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:12 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200330,'U','N','N','N',0,'N',14,'N',11,'N','N',53709,'N','Y','21266064-7289-4578-a943-d036513c89f9','N','Y','N','ColumnNo','Dashboard content column number','1','Dashboard content column number, not used by the swing client at the moment.','Column No','Y',100,TO_TIMESTAMP('2012-08-22 17:24:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:11','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:12 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200330 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:13 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200331,'U','Y','N','N','N',7,'N',16,'Y','N',245,'N','Y','54aa33eb-11c3-4dd0-a49e-68a820b2fa8f','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2012-08-22 17:24:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:12','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:13 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200331 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:14 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200332,'U',110,'Y','N','N','N',10,'N',18,'Y','N',246,'N','Y','08ae2c42-fe47-47b2-a990-aafd60ece4bc','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2012-08-22 17:24:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:13','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:14 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200332 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:14 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200333,'U','N','Y','N','N',255,'Y',10,'Y','N',275,'N','Y','b2af550f-29eb-4a59-b3b5-73a95901072e','N','Y','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_TIMESTAMP('2012-08-22 17:24:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:14','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:14 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200333 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:15 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.000000000000,200013,200334,'U',53316,'N','N','N',0,'N',1,'N',17,'N','N',53895,'N','Y','73f3c7f5-ed37-4f88-afe1-6e2de5a52083','N','Y','N','GoalDisplay','Type of goal display on dashboard','T','Display goal on dashboard as html table or graph.','Goal Display','Y',100,TO_TIMESTAMP('2012-08-22 17:24:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:14','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:15 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200334 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:16 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200335,'U','N','N','N','N','N',36,'Y','N',51005,'N','Y','0a89bacd-d3ba-41ad-8734-5f40eb2f0d70','N','Y','N','HTML','HTML','Y',100,TO_TIMESTAMP('2012-08-22 17:24:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:15','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:16 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200335 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:16 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200336,'U','Y','N','N','N',1,'N',20,'Y','N',348,'N','Y','bd00cfcd-649f-4d7e-9952-464ddd47a214','N','Y','N','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2012-08-22 17:24:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:16','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:16 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200336 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:17 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200337,'U','Y','N','N',0,'N',1,'N',20,'N','N',53336,'N','Y','c1b56cc4-2b4f-440d-90f6-0101e10f95fc','N','Y','N','IsCollapsedByDefault','Flag to set the initial state of collapsible field group.','N','Collapsed By Default','Y',100,TO_TIMESTAMP('2012-08-22 17:24:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:16','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:17 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200337 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:18 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200338,'U','Y','N','N',0,'N',1,'N',20,'N','N',53715,'N','Y','95747f07-876e-4b73-afd8-0f3e89681e47','N','Y','N','IsCollapsible','Flag to indicate the state of the dashboard panel','Y','Flag to indicate the state of the dashboard panel (i.e. collapsible or static)','Collapsible','Y',100,TO_TIMESTAMP('2012-08-22 17:24:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:17','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:18 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200338 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:19 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200339,'U','Y','N','N',0,'N',1,'N',20,'N','N',200075,'N','Y','ce4c22dd-129d-4a4c-b4e3-80ac8f2558f0','N','Y','N','IsEmbedReportContent','Embed report content into dashboard','N','Embed Report Content','Y',100,TO_TIMESTAMP('2012-08-22 17:24:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:18','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:19 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200339 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:19 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200340,'U','Y','N','N',0,'N',1,'N',20,'N','N',200074,'N','Y','ece566cd-05a3-4c78-80cb-b72d37fd97bf','N','Y','N','IsShowInDashboard','Show the dashlet in the dashboard','''Y''','Show in Dashboard','Y',100,TO_TIMESTAMP('2012-08-22 17:24:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:19','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:19 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200340 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:20 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200341,'U','N','N','N','N',22,'N',22,'Y','N',439,'N','Y','b6b75e0a-4a17-4120-81eb-954c040f91b6','N','Y','N','Line','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','Line No','Y',100,TO_TIMESTAMP('2012-08-22 17:24:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:19','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:20 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200341 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:21 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200342,'U','Y','Y','Y',1,'N',120,'Y',10,'Y','N',469,'N','Y','e194e552-2d9e-462d-a764-c4291635f73e','N','Y','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_TIMESTAMP('2012-08-22 17:24:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:21 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200342 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:22 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('PA_DashboardPreference_ID',200097,'U','Dashboard Preference','Dashboard Preference','5e8c3a0b-3d43-416e-9101-c85fb17bf717',0,TO_TIMESTAMP('2012-08-22 17:24:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-22 17:24:21','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 22, 2012 5:24:22 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200097 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 22, 2012 5:24:22 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200343,'U','Y','N','N','N',10,'N',13,'Y','Y',200097,'N','Y','6c0f49bf-fcfe-43ca-b2bf-ea89f23b5d4a','N','N','N','PA_DashboardPreference_ID','Dashboard Preference','N',100,TO_TIMESTAMP('2012-08-22 17:24:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:21','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:22 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200343 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:23 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200013,200344,'U','N','N','N','N',36,'N',10,'N','N',55058,'N','Y','b268bb72-324c-4c88-bb92-c12e519e0299','N','Y','N','PA_DashboardContent_UU','PA_DashboardContent_UU','N',100,TO_TIMESTAMP('2012-08-22 17:24:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:22','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:23 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200344 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:24 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200345,'U','N','N','N','N',22,'N',19,'Y','N',1594,'N','Y','09ecd680-ff20-4e63-aa11-75514bab82c6','N','Y','N','PA_Goal_ID','Performance Goal','The Performance Goal indicates what this users performance will be measured against.','Goal','Y',100,TO_TIMESTAMP('2012-08-22 17:24:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:24 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200345 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:25 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200346,'U','N','N','N',0,'N',2000,'N',10,'N','N',200076,'N','Y','56ba0131-e162-43ab-abb7-dd979d3f7050','N','Y','N','ProcessParameters','Comma separated process parameter list','A list of name value pair process parameter separated by comma','Process Parameters','Y',100,TO_TIMESTAMP('2012-08-22 17:24:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:25 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200346 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:25 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200347,'U','Y','N','N','N',7,'N',16,'Y','N',607,'N','Y','b837c94e-ed52-440e-99b5-5497b8dc97df','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2012-08-22 17:24:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:25 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200347 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200348,'U',110,'Y','N','N','N',10,'N',18,'Y','N',608,'N','Y','91488e3a-d7f2-4d34-bcb2-60ce40dfcc0b','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2012-08-22 17:24:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200348 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:27 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200349,'U','N','N','N',0,'N',255,'N',10,'N','N',53710,'N','Y','53db2cfd-ae14-41c8-8e41-3e76d913a01a','N','Y','N','ZulFilePath','Absolute path to zul file','Absolute path to zul file that is use to generate dashboard content','ZUL File Path','Y',100,TO_TIMESTAMP('2012-08-22 17:24:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:24:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:24:27 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200349 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:24:43 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200326
;

-- Aug 22, 2012 5:24:43 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200326
;

-- Aug 22, 2012 5:24:47 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200329
;

-- Aug 22, 2012 5:24:47 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200329
;

-- Aug 22, 2012 5:24:53 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200333
;

-- Aug 22, 2012 5:24:53 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200333
;

-- Aug 22, 2012 5:24:56 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200334
;

-- Aug 22, 2012 5:24:56 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200334
;

-- Aug 22, 2012 5:24:59 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200335
;

-- Aug 22, 2012 5:24:59 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200335
;

-- Aug 22, 2012 5:25:17 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200338
;

-- Aug 22, 2012 5:25:17 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200338
;

-- Aug 22, 2012 5:25:20 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200339
;

-- Aug 22, 2012 5:25:20 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200339
;

-- Aug 22, 2012 5:25:27 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200342
;

-- Aug 22, 2012 5:25:27 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200342
;

-- Aug 22, 2012 5:25:32 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200344
;

-- Aug 22, 2012 5:25:32 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200344
;

-- Aug 22, 2012 5:25:35 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200345
;

-- Aug 22, 2012 5:25:35 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200345
;

-- Aug 22, 2012 5:25:38 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200346
;

-- Aug 22, 2012 5:25:38 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200346
;

-- Aug 22, 2012 5:25:41 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200349
;

-- Aug 22, 2012 5:25:41 PM SGT
-- Move the Menu to be a Portlet
DELETE FROM AD_Column WHERE AD_Column_ID=200349
;

-- Aug 22, 2012 5:26:08 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200013,200350,'U','Y','N','N',0,'N',10,'N',19,'N','N',51006,'N','Y','79fe7ad2-2a7e-43f2-b656-01bc294a6b89','N','Y','N','PA_DashboardContent_ID','Dashboard Content','Y',100,TO_TIMESTAMP('2012-08-22 17:26:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-22 17:26:07','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 22, 2012 5:26:08 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200350 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 22, 2012 5:26:20 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-08-22 17:26:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200327
;

-- Aug 22, 2012 5:26:23 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-08-22 17:26:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200328
;

-- Aug 22, 2012 5:26:53 PM SGT
-- Move the Menu to be a Portlet
CREATE TABLE PA_DashboardPreference (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Role_ID NUMERIC(10) DEFAULT 0 NOT NULL, AD_User_ID NUMERIC(10) DEFAULT 0 NOT NULL, ColumnNo NUMERIC(10) DEFAULT 1, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL, IsCollapsedByDefault CHAR(1) DEFAULT 'N' CHECK (IsCollapsedByDefault IN ('Y','N')) NOT NULL, IsShowInDashboard CHAR(1) DEFAULT 'Y' CHECK (IsShowInDashboard IN ('Y','N')) NOT NULL, Line NUMERIC DEFAULT NULL , PA_DashboardContent_ID NUMERIC(10) NOT NULL, PA_DashboardPreference_ID NUMERIC(10) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT PA_DashboardPreference_Key PRIMARY KEY (PA_DashboardPreference_ID))
;

-- Aug 22, 2012 5:27:18 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,EntityType,Name,AD_Window_ID,Processing,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('M','Y','N','N','U','Dashboard Preference',200006,'N','b40fb952-f507-43c0-a736-4027a729cf95',TO_TIMESTAMP('2012-08-22 17:27:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-22 17:27:17','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Aug 22, 2012 5:27:18 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200006 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Aug 22, 2012 5:27:49 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsReadOnly,IsInfoTab,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',200006,10,'N','N',200013,'N','N','N','N','Y','N',0,'8913e23b-efab-4d76-8c16-cf020ad5f47b','U','Preference',200011,0,0,TO_TIMESTAMP('2012-08-22 17:27:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-22 17:27:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Aug 22, 2012 5:27:49 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200011 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 22, 2012 5:27:56 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,1,'N','N',200336,'Y',200298,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','U','The record is active in the system','Active','N','Y','60efaf22-47aa-458e-844d-1795f0ae7d51',100,0,TO_TIMESTAMP('2012-08-22 17:27:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:27:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:27:56 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200298 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:27:57 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,10,'N','N',200324,'Y',200299,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','U','Client/Tenant for this installation.','Client','N','Y','4c8e0f92-8621-404c-b74e-a7bbe371dfba',100,0,TO_TIMESTAMP('2012-08-22 17:27:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:27:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:27:57 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200299 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:27:58 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,1,'N','N',200337,'Y',200300,'N','U','Flag to set the initial state of collapsible field group.','Collapsed By Default','N','Y','2de9e3c6-79c7-4535-933a-676e3088b846',100,0,TO_TIMESTAMP('2012-08-22 17:27:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:27:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:27:58 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200300 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:27:58 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,14,'N','N',200330,'Y',200301,'N','Dashboard content column number, not used by the swing client at the moment.','U','Dashboard content column number','Column No','N','Y','6046d04b-ce13-46c5-93d3-ace1ad5cc3b6',100,0,TO_TIMESTAMP('2012-08-22 17:27:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:27:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:27:58 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200301 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:27:59 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,10,'N','N',200350,'Y',200302,'N','U','Dashboard Content','N','Y','54cfd09f-cdeb-4713-b18a-260046407687',100,0,TO_TIMESTAMP('2012-08-22 17:27:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:27:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:27:59 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200302 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:28:00 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200011,10,'N','N',200343,'Y',200303,'N','U','Dashboard Preference','N','N','1261ce0f-507d-4d5f-a2ef-0f19fa852cc5',100,0,TO_TIMESTAMP('2012-08-22 17:27:59','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:27:59','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Aug 22, 2012 5:28:00 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200303 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:28:01 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,22,'N','N',200341,'Y',200304,'N','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','U','Unique line for this document','Line No','N','Y','110508e7-f036-4756-9b1c-f25534679786',100,0,TO_TIMESTAMP('2012-08-22 17:28:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:28:00','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:28:01 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200304 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:28:01 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,10,'N','N',200325,'Y',200305,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','U','Organizational entity within client','Organization','N','Y','81c96d66-b03c-4297-ae6c-013e12115406',100,0,TO_TIMESTAMP('2012-08-22 17:28:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:28:01','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:28:01 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200305 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:28:02 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,10,'N','N',200327,'Y',200306,'N','The Role determines security and access a user who has this Role will have in the System.','U','Responsibility Role','Role','N','Y','9123affc-baac-4b31-b9aa-cf6b2031d042',100,0,TO_TIMESTAMP('2012-08-22 17:28:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:28:01','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:28:02 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200306 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:28:03 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,1,'N','N',200340,'Y',200307,'N','U','Show the dashlet in the dashboard','Show in Dashboard','N','Y','45eb1a7e-6531-4ca6-8c98-fd8de091b9d0',100,0,TO_TIMESTAMP('2012-08-22 17:28:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:28:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:28:03 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200307 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:28:04 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200011,10,'N','N',200328,'Y',200308,'N','The User identifies a unique user in the system. This could be an internal user or a business partner contact','U','User within the system - Internal or Business Partner Contact','User/Contact','N','Y','cfbb0b1a-eaac-4d94-aca0-70c47423973c',100,0,TO_TIMESTAMP('2012-08-22 17:28:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 17:28:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 22, 2012 5:28:04 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200308 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200299
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200305
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200308
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200306
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200302
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200298
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200301
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200304
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200300
;

-- Aug 22, 2012 5:28:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200307
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200299
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200305
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200308
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200306
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200302
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200298
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200301
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200304
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200300
;

-- Aug 22, 2012 5:29:32 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200307
;

-- Aug 22, 2012 5:29:50 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-22 17:29:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200305
;

-- Aug 22, 2012 5:29:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-22 17:29:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200306
;

-- Aug 22, 2012 5:30:15 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-22 17:30:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200304
;

-- Aug 22, 2012 5:30:59 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,"action",AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200006,200010,'N','N','N','D','Y','Dashboard Preference','W','b8b799ed-2f7b-458c-9764-b715dc43dde2','Y',0,100,TO_TIMESTAMP('2012-08-22 17:30:59','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-08-22 17:30:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 22, 2012 5:30:59 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Aug 22, 2012 5:30:59 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200010, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200010)
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Aug 22, 2012 5:31:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Aug 22, 2012 5:31:25 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Window SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:31:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200006
;

-- Aug 22, 2012 5:31:35 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Tab SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:31:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200011
;

-- Aug 22, 2012 5:31:44 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:31:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200299
;

-- Aug 22, 2012 5:31:48 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:31:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200305
;

-- Aug 22, 2012 5:31:52 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:31:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200308
;

-- Aug 22, 2012 5:31:55 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:31:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200306
;

-- Aug 22, 2012 5:31:58 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:31:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200302
;

-- Aug 22, 2012 5:32:02 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200298
;

-- Aug 22, 2012 5:32:05 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200301
;

-- Aug 22, 2012 5:32:09 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200304
;

-- Aug 22, 2012 5:32:12 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200300
;

-- Aug 22, 2012 5:32:15 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200307
;

-- Aug 22, 2012 5:32:35 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Table SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200013
;

-- Aug 22, 2012 5:32:44 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200324
;

-- Aug 22, 2012 5:32:47 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200325
;

-- Aug 22, 2012 5:32:50 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200327
;

-- Aug 22, 2012 5:32:53 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200328
;

-- Aug 22, 2012 5:32:56 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:32:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200330
;

-- Aug 22, 2012 5:33:00 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200331
;

-- Aug 22, 2012 5:33:03 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200332
;

-- Aug 22, 2012 5:33:07 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200336
;

-- Aug 22, 2012 5:33:10 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200337
;

-- Aug 22, 2012 5:33:13 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200340
;

-- Aug 22, 2012 5:33:16 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200341
;

-- Aug 22, 2012 5:33:20 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200350
;

-- Aug 22, 2012 5:33:23 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D', IsUpdateable='N',Updated=TO_TIMESTAMP('2012-08-22 17:33:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200343
;

-- Aug 22, 2012 5:33:26 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200347
;

-- Aug 22, 2012 5:33:30 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-22 17:33:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200348
;

UPDATE AD_System
  SET LastMigrationScriptApplied='888_IDEMPIERE-357_MenuPortlet.sql'
WHERE LastMigrationScriptApplied<'888_IDEMPIERE-357_MenuPortlet.sql'
   OR LastMigrationScriptApplied IS NULL
;