-- Aug 7, 2012 5:22:34 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Flat View',1000000,'U','1d68fb0b-318d-463e-aa36-442ec9bc2d90','FlatView','Y',TO_DATE('2012-08-07 17:22:34','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-08-07 17:22:34','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2012 5:22:34 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=1000000 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Aug 7, 2012 5:22:50 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Message SET MsgType='M',Updated=TO_DATE('2012-08-07 17:22:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=1000000
;

-- Aug 7, 2012 5:28:39 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,50010,1000007,'U','N','N','N',0,'N',10,'N',19,'N','N',138,'N','Y','7a1348ca-67c6-43a4-8edb-b4993fe73f37','N','Y','N','AD_User_ID','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact','Y',100,TO_DATE('2012-08-07 17:28:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-07 17:28:39','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 7, 2012 5:28:39 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000007 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 7, 2012 5:28:45 PM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent ADD AD_User_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 7, 2012 5:29:23 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,50010,1000008,'U','N','N','N',0,'N',10,'N',19,'N','N',123,'N','Y','0ef8fece-cda5-4349-a7ca-a84cfc808b2c','N','Y','N','AD_Role_ID','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.','Role','Y',100,TO_DATE('2012-08-07 17:29:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-07 17:29:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 7, 2012 5:29:23 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000008 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 7, 2012 5:29:26 PM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent ADD AD_Role_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 7, 2012 5:29:50 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,10,'N','N',1000008,'Y',1000010,'N','The Role determines security and access a user who has this Role will have in the System.','U','Responsibility Role','Role','Y','N','7c90c0dc-696b-450b-a00c-54027171422b',100,0,TO_DATE('2012-08-07 17:29:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-07 17:29:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 7, 2012 5:29:51 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000010 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 7, 2012 5:29:51 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,10,'N','N',1000007,'Y',1000011,'N','The User identifies a unique user in the system. This could be an internal user or a business partner contact','U','User within the system - Internal or Business Partner Contact','User/Contact','Y','N','8766c305-21db-43d0-8739-055b1e82d90d',100,0,TO_DATE('2012-08-07 17:29:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-07 17:29:51','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 7, 2012 5:29:51 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000011 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=1000011
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=1000010
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=51007
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=51008
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=56485
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=51009
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=51010
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=51011
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=56486
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=51012
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=51013
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=57344
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=56504
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=1000009
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=1000001
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=1000003
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=1000002
;

-- Aug 7, 2012 5:30:14 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=1000004
;

-- Aug 7, 2012 5:30:22 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-07 17:30:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000010
;

-- Aug 7, 2012 6:41:20 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET DefaultValue='0',Updated=TO_DATE('2012-08-07 18:41:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1000008
;

-- Aug 7, 2012 6:41:23 PM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent MODIFY AD_Role_ID NUMBER(10) DEFAULT 0
;

-- Aug 7, 2012 6:41:23 PM SGT
-- Move the Menu to be a Portlet
UPDATE PA_DashboardContent SET AD_Role_ID=0 WHERE AD_Role_ID IS NULL
;

-- Aug 7, 2012 6:41:48 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Column SET DefaultValue='0',Updated=TO_DATE('2012-08-07 18:41:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1000007
;

-- Aug 7, 2012 6:41:53 PM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent MODIFY AD_User_ID NUMBER(10) DEFAULT 0
;

-- Aug 7, 2012 6:41:53 PM SGT
-- Move the Menu to be a Portlet
UPDATE PA_DashboardContent SET AD_User_ID=0 WHERE AD_User_ID IS NULL
;

UPDATE AD_System
  SET LastMigrationScriptApplied='867_IDEMPIERE-357_MenuPortlet.sql'
WHERE LastMigrationScriptApplied<'867_IDEMPIERE-357_MenuPortlet.sql'
   OR LastMigrationScriptApplied IS NULL
;
