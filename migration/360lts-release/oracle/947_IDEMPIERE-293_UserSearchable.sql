drop view ad_sessioninfo_v;
CREATE OR REPLACE VIEW ad_sessioninfo_v AS 
 SELECT s.ad_session_id,0 as ad_client_id,0 as ad_org_id, s.isactive, 
		s.created, s.createdby, s.updated, s.updatedby, s.websession, 
		s.remote_addr, s.remote_host, r.name as roleName, s.logindate, s.ad_session_uu, 
		s.servername,  c.name AS ClientName,o.name as orgName,s.ad_session_id as ad_sessioninfo_v_id,
		s.ad_session_uu as ad_sessioninfo_v_uu,u.name as LoginName,u.email as email
   FROM ad_session s
   inner join AD_User u on (s.createdby = u.AD_User_ID)
   left join AD_Role r on (s.ad_role_id=r.ad_role_id)
   inner join AD_Client c on (s.ad_client_id=c.ad_client_id)
   left join AD_Org o on (s.ad_org_id=o.ad_org_id)
  WHERE s.processed = 'N';
  
-- Oct 25, 2012 2:42:24 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (0,'N',200025,0,'N','N',200592,130,'Y',200750,'N','The Created field indicates the date that this record was created.','U','Date this record was created','Created','N','Y','19751202-fa07-45b0-a617-987b1b1504c3',100,0,TO_DATE('2012-10-25 14:42:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-25 14:42:22','YYYY-MM-DD HH24:MI:SS'),'Y','Y',130,1,1,1)
;

-- Oct 25, 2012 2:42:24 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200750 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 25, 2012 2:42:44 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (0,'N',200025,0,'N','N',200594,140,'Y',200751,'N','The Updated field indicates the date that this record was updated.','U','Date this record was updated','Updated','N','Y','823b5840-4f26-4f0a-9afe-c64d4df497c6',100,0,TO_DATE('2012-10-25 14:42:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-25 14:42:44','YYYY-MM-DD HH24:MI:SS'),'Y','Y',140,1,1,1)
;

-- Oct 25, 2012 2:42:45 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200751 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 25, 2012 2:43:33 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2012-10-25 14:43:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200751
;

-- Oct 25, 2012 2:44:22 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200750
;

-- Oct 25, 2012 2:44:22 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200751
;

-- Oct 25, 2012 2:44:22 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200605
;

-- Oct 25, 2012 2:44:22 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200604
;

-- Oct 25, 2012 2:44:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200653
;

-- Oct 25, 2012 2:44:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 25, 2012 2:44:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200750
;

-- Oct 25, 2012 2:44:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 25, 2012 2:44:51 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 25, 2012 2:45:39 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200751
;

-- Oct 25, 2012 2:45:39 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 25, 2012 2:45:39 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 25, 2012 2:49:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200750
;

-- Oct 25, 2012 2:49:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200751
;

-- Oct 25, 2012 2:49:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200613
;

-- Oct 25, 2012 2:49:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200614
;

-- Oct 25, 2012 4:54:00 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Reference_Value_ID=NULL, FieldLength=30, IsSelectionColumn='Y', AD_Reference_ID=10, AD_Element_ID=1903, ColumnName='UserName', Description='Email of the responsible for the System', Help='Email of the responsible person for the system (registered in WebStore)', Name='Registered EMail',Updated=TO_DATE('2012-10-25 16:54:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200705
;

-- Oct 25, 2012 4:54:00 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200705
;

-- Oct 25, 2012 4:54:00 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Registered EMail', Description='Email of the responsible for the System', Help='Email of the responsible person for the system (registered in WebStore)' WHERE AD_Column_ID=200705 AND IsCentrallyMaintained='Y'
;

-- Oct 25, 2012 4:54:33 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200025,200818,'D','N','N','N','N',60,'N',10,'N',881,'7a42ae29-3fdb-4221-9c69-8d3983351e30','N','N','N','EMail','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.','EMail Address',100,TO_DATE('2012-10-25 16:54:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-25 16:54:31','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 25, 2012 4:54:33 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200818 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 25, 2012 4:59:15 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200025,60,'N','N',200818,'Y',200752,'N','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.','D','Electronic Mail Address','EMail Address','N','Y','9938a925-4178-4b3e-b7ca-c0b1e0cf9fdc',100,0,TO_DATE('2012-10-25 16:59:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-25 16:59:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 25, 2012 4:59:15 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200752 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 25, 2012 5:07:14 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('LoginName',200197,'D','User Name','User Name','fe431c69-f258-4f50-b9bc-58160a63b134',0,TO_DATE('2012-10-25 17:07:13','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-25 17:07:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 25, 2012 5:07:14 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200197 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 25, 2012 5:07:40 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element SET Help='Login User Name',Updated=TO_DATE('2012-10-25 17:07:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200197
;

-- Oct 25, 2012 5:07:40 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200197
;

-- Oct 25, 2012 5:07:40 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET ColumnName='LoginName', Name='User Name', Description=NULL, Help='Login User Name' WHERE AD_Element_ID=200197
;

-- Oct 25, 2012 5:07:40 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='LoginName', Name='User Name', Description=NULL, Help='Login User Name', AD_Element_ID=200197 WHERE UPPER(ColumnName)='LOGINNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 25, 2012 5:07:40 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='LoginName', Name='User Name', Description=NULL, Help='Login User Name' WHERE AD_Element_ID=200197 AND IsCentrallyMaintained='Y'
;

-- Oct 25, 2012 5:07:40 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='User Name', Description=NULL, Help='Login User Name' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200197) AND IsCentrallyMaintained='Y'
;

-- Oct 25, 2012 5:07:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Element_ID=200197, ColumnName='LoginName', Description=NULL, Help='Login User Name', Name='User Name',Updated=TO_DATE('2012-10-25 17:07:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200705
;

-- Oct 25, 2012 5:07:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200705
;

-- Oct 25, 2012 5:07:52 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='User Name', Description=NULL, Help='Login User Name' WHERE AD_Column_ID=200705 AND IsCentrallyMaintained='Y'
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200752
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200611
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200607
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200646
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200614
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200613
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200750
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200751
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200604
;

-- Oct 25, 2012 5:20:57 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200605
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200752
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200611
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200646
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200607
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200750
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200751
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200613
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200614
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200605
;

-- Oct 25, 2012 5:21:14 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200604
;

-- Oct 25, 2012 5:24:19 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-10-25 17:24:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200752
;

-- Oct 25, 2012 11:59:27 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('roleName',200198,'D','Login Role','Login Role','af324521-6deb-4459-a2ac-003b3d8f47fd',0,TO_DATE('2012-10-25 23:59:23','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-25 23:59:23','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 25, 2012 11:59:27 PM IST
-- IDEMPIERE-293  List of Active Session
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200198 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 25, 2012 11:59:38 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET IsSelectionColumn='Y', AD_Element_ID=200198, ColumnName='roleName', Description=NULL, Help=NULL, Name='Login Role',Updated=TO_DATE('2012-10-25 23:59:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200599
;

-- Oct 25, 2012 11:59:38 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200599
;

-- Oct 25, 2012 11:59:38 PM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Login Role', Description=NULL, Help=NULL WHERE AD_Column_ID=200599 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:00:03 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET FieldLength=30, AD_Reference_ID=10,Updated=TO_DATE('2012-10-26 00:00:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200599
;

-- Oct 26, 2012 12:00:41 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element SET Help='Role name of user logged in with',Updated=TO_DATE('2012-10-26 00:00:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200198
;

-- Oct 26, 2012 12:00:41 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200198
;

-- Oct 26, 2012 12:00:41 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET ColumnName='roleName', Name='Login Role', Description=NULL, Help='Role name of user logged in with' WHERE AD_Element_ID=200198
;

-- Oct 26, 2012 12:00:41 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='roleName', Name='Login Role', Description=NULL, Help='Role name of user logged in with', AD_Element_ID=200198 WHERE UPPER(ColumnName)='ROLENAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 26, 2012 12:00:41 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='roleName', Name='Login Role', Description=NULL, Help='Role name of user logged in with' WHERE AD_Element_ID=200198 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:00:41 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Login Role', Description=NULL, Help='Role name of user logged in with' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200198) AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:00:48 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET Name='Login Rol',Updated=TO_DATE('2012-10-26 00:00:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200599
;

-- Oct 26, 2012 12:00:48 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200599
;

-- Oct 26, 2012 12:00:48 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Login Rol', Description=NULL, Help='Role name of user logged in with' WHERE AD_Column_ID=200599 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:00:52 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET Name='Login Role',Updated=TO_DATE('2012-10-26 00:00:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200599
;

-- Oct 26, 2012 12:00:52 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200599
;

-- Oct 26, 2012 12:00:52 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Login Role', Description=NULL, Help='Role name of user logged in with' WHERE AD_Column_ID=200599 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:02:54 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element SET ColumnName='clientName', Help='Client in which current session user logged in',Updated=TO_DATE('2012-10-26 00:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200186
;

-- Oct 26, 2012 12:02:54 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200186
;

-- Oct 26, 2012 12:02:54 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET ColumnName='clientName', Name='Loing Client', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Element_ID=200186
;

-- Oct 26, 2012 12:02:54 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='clientName', Name='Loing Client', Description=NULL, Help='Client in which current session user logged in', AD_Element_ID=200186 WHERE UPPER(ColumnName)='CLIENTNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 26, 2012 12:02:54 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='clientName', Name='Loing Client', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Element_ID=200186 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:02:54 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Loing Client', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200186) AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:03:06 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET IsSelectionColumn='Y', ColumnName='clientName',Updated=TO_DATE('2012-10-26 00:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200702
;

-- Oct 26, 2012 12:03:20 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Reference_Value_ID=NULL, FieldLength=30, AD_Reference_ID=10,Updated=TO_DATE('2012-10-26 00:03:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200702
;

-- Oct 26, 2012 12:05:30 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET AD_Reference_Value_ID=NULL, FieldLength=30, IsSelectionColumn='Y', AD_Reference_ID=10, AD_Element_ID=2660, ColumnName='OrgName', Description='Name of the Organization', Help=NULL, Name='Organization Name',Updated=TO_DATE('2012-10-26 00:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200706
;

-- Oct 26, 2012 12:05:30 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200706
;

-- Oct 26, 2012 12:05:30 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Organization Name', Description='Name of the Organization', Help=NULL WHERE AD_Column_ID=200706 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:07:57 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element SET Name='Client Name', PrintName='Client Name',Updated=TO_DATE('2012-10-26 00:07:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200186
;

-- Oct 26, 2012 12:07:57 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200186
;

-- Oct 26, 2012 12:07:57 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET ColumnName='clientName', Name='Client Name', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Element_ID=200186
;

-- Oct 26, 2012 12:07:57 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='clientName', Name='Client Name', Description=NULL, Help='Client in which current session user logged in', AD_Element_ID=200186 WHERE UPPER(ColumnName)='CLIENTNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 26, 2012 12:07:57 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Process_Para SET ColumnName='clientName', Name='Client Name', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Element_ID=200186 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:07:57 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Field SET Name='Client Name', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200186) AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2012 12:07:57 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_PrintFormatItem pi SET PrintName='Client Name', Name='Client Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200186)
;

-- Oct 26, 2012 12:08:27 AM IST
-- IDEMPIERE-293  List of Active Session
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_DATE('2012-10-26 00:08:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200702
;

SELECT register_migration_script('947_IDEMPIERE-293_UserSearchable.sql') FROM dual
;