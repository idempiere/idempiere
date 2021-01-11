SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3358
-- Jun 3, 2020, 1:25:13 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2020-06-03 13:25:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=58113
;

-- Jun 3, 2020, 1:25:46 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2020-06-03 13:25:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59097
;

-- Jun 3, 2020, 1:31:15 PM CEST
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,Referenced_Table_ID,SeqNo,WhereClause,FromClause) VALUES (0,0,200005,'b5c50a8a-715c-438f-9890-f63faad7b928',TO_DATE('2020-06-03 13:31:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_session',TO_DATE('2020-06-03 13:31:14','YYYY-MM-DD HH24:MI:SS'),100,200025,566,10,'WHERE s.processed = ''N''','FROM ad_session s
JOIN ad_user u ON s.createdby = u.ad_user_id
LEFT JOIN ad_role r ON s.ad_role_id = r.ad_role_id
JOIN ad_client c ON s.ad_client_id = c.ad_client_id
LEFT JOIN ad_org o ON s.ad_org_id = o.ad_org_id')
;

-- Jun 3, 2020, 1:32:37 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200103,'2f5d5913-fd07-4e79-a015-d15f0597ce97',TO_DATE('2020-06-03 13:32:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:32:36','YYYY-MM-DD HH24:MI:SS'),100,200005,'AD_Client_ID','0',10)
;

-- Jun 3, 2020, 1:32:47 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200104,'84e0b4e8-9490-4ed2-a554-cf9c7df000e6',TO_DATE('2020-06-03 13:32:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:32:47','YYYY-MM-DD HH24:MI:SS'),100,200005,'AD_Org_ID','0',20)
;

-- Jun 3, 2020, 1:33:00 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200105,'c5ad2696-cf53-4808-a342-d2258ca4061c',TO_DATE('2020-06-03 13:32:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:32:59','YYYY-MM-DD HH24:MI:SS'),100,200005,'IsActive','s.IsActive',30)
;

-- Jun 3, 2020, 1:33:17 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200106,'be376a95-7a45-482b-9b82-091946b0261f',TO_DATE('2020-06-03 13:33:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:33:17','YYYY-MM-DD HH24:MI:SS'),100,200005,'Created','s.Created',40)
;

-- Jun 3, 2020, 1:33:28 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200107,'385abf8d-14cf-4246-80c6-768ffb9b5850',TO_DATE('2020-06-03 13:33:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:33:27','YYYY-MM-DD HH24:MI:SS'),100,200005,'CreatedBy','s.CreatedBy',50)
;

-- Jun 3, 2020, 1:33:36 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200108,'a4cc4134-3ec4-4e58-9161-496794269457',TO_DATE('2020-06-03 13:33:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:33:36','YYYY-MM-DD HH24:MI:SS'),100,200005,'Updated','s.Updated',60)
;

-- Jun 3, 2020, 1:33:48 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200109,'c6a8b53f-0f29-4582-bb29-e036ffd4612e',TO_DATE('2020-06-03 13:33:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:33:47','YYYY-MM-DD HH24:MI:SS'),100,200005,'UpdatedBy','s.UpdatedBy',70)
;

-- Jun 3, 2020, 1:34:23 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200110,'575f010b-acda-40a1-bfe4-f64303775b8d',TO_DATE('2020-06-03 13:34:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:34:22','YYYY-MM-DD HH24:MI:SS'),100,200005,'WebSession','SUBSTR(s.WebSession, 1, 40)',80)
;

-- Jun 3, 2020, 1:34:47 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200111,'d2e41ae8-30d5-4f89-82d0-e523d00f2076',TO_DATE('2020-06-03 13:34:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:34:46','YYYY-MM-DD HH24:MI:SS'),100,200005,'Remote_Addr','SUBSTR(s.Remote_Addr, 1, 60)',90)
;

-- Jun 3, 2020, 1:35:07 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200112,'02a78e9f-d586-4220-ac98-cc8c12e16a0e',TO_DATE('2020-06-03 13:35:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:35:07','YYYY-MM-DD HH24:MI:SS'),100,200005,'Remote_Host','SUBSTR(s.Remote_Host, 1, 120)',100)
;

-- Jun 3, 2020, 1:35:29 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200113,'bf72ceed-9c9a-4d7e-87f3-05b310c43de8',TO_DATE('2020-06-03 13:35:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:35:29','YYYY-MM-DD HH24:MI:SS'),100,200005,'RoleName','SUBSTR(s.RoleName, 1, 60)',110)
;

-- Jun 3, 2020, 1:35:39 PM CEST
UPDATE AD_ViewColumn SET ColumnSQL='SUBSTR(r.RoleName, 1, 60)',Updated=TO_DATE('2020-06-03 13:35:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=200113
;

-- Jun 3, 2020, 1:35:56 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200114,'270f399b-0c76-4701-92e7-a73ce61fab93',TO_DATE('2020-06-03 13:35:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:35:56','YYYY-MM-DD HH24:MI:SS'),100,200005,'LoginDate','s.LoginDate',120)
;

-- Jun 3, 2020, 1:36:16 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200115,'fde92964-b296-4d62-8d26-2527bcb73d60',TO_DATE('2020-06-03 13:36:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:36:15','YYYY-MM-DD HH24:MI:SS'),100,200005,'AD_Session_UU','s.AD_Session_UU',130)
;

-- Jun 3, 2020, 1:36:43 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200116,'ae02d4d5-f2f7-4f22-92df-cb2977b87b24',TO_DATE('2020-06-03 13:36:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:36:42','YYYY-MM-DD HH24:MI:SS'),100,200005,'ServerName','SUBSTR(s.ServerName, 1, 80)',140)
;

-- Jun 3, 2020, 1:37:10 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200117,'fa1d528c-b950-420c-96fe-15125ae310e9',TO_DATE('2020-06-03 13:37:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:37:09','YYYY-MM-DD HH24:MI:SS'),100,200005,'ClientName','SUBSTR(c.Name, 1, 60)',150)
;

-- Jun 3, 2020, 1:37:20 PM CEST
UPDATE AD_ViewColumn SET ColumnSQL='SUBSTR(r.Name, 1, 60)',Updated=TO_DATE('2020-06-03 13:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=200113
;

-- Jun 3, 2020, 1:37:45 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200118,'a680d112-46a9-4b86-965a-5cf4535282cd',TO_DATE('2020-06-03 13:37:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:37:45','YYYY-MM-DD HH24:MI:SS'),100,200005,'OrgName','SUBSTR(o.Name, 1, 60)',160)
;

-- Jun 3, 2020, 1:38:08 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200119,'ccea99a1-f2c4-4e2b-817b-cffbaf12215b',TO_DATE('2020-06-03 13:38:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:38:08','YYYY-MM-DD HH24:MI:SS'),100,200005,'AD_SessionInfo_V_ID','s.AD_Session_ID',170)
;

-- Jun 3, 2020, 1:38:18 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200120,'350b8681-709b-430f-b118-e6507d2e5c56',TO_DATE('2020-06-03 13:38:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:38:17','YYYY-MM-DD HH24:MI:SS'),100,200005,'AD_SessionInfo_V_UU','s.AD_Session_UU',180)
;

-- Jun 3, 2020, 1:38:46 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200121,'155982c6-03f3-4fb5-99a8-34b9e57eefc5',TO_DATE('2020-06-03 13:38:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:38:46','YYYY-MM-DD HH24:MI:SS'),100,200005,'LoginName','SUBSTR(u.Name, 1, 60)',190)
;

-- Jun 3, 2020, 1:39:03 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200122,'fcb879f5-8f1b-46b9-89c1-31ee1f7e3e67',TO_DATE('2020-06-03 13:39:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:39:03','YYYY-MM-DD HH24:MI:SS'),100,200005,'EMail','SUBSTR(u.EMail, 1, 60)',200)
;

-- Jun 3, 2020, 1:40:33 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200123,'eb380739-23b6-447b-a153-e200e463776c',TO_DATE('2020-06-03 13:40:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:40:32','YYYY-MM-DD HH24:MI:SS'),100,200005,'LDAPUser','SUBSTR(u.LDAPUser, 1, 60)',210)
;

-- Jun 3, 2020, 1:40:54 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200124,'40f18e60-a591-4bb2-aa1a-1f2e34a5b660',TO_DATE('2020-06-03 13:40:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:40:53','YYYY-MM-DD HH24:MI:SS'),100,200005,'Description','SUBSTR(s.Description, 1, 2000)',220)
;

-- Jun 3, 2020, 1:41:23 PM CEST
DROP VIEW AD_SessionInfo_v
;

-- Jun 3, 2020, 1:42:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214204,0.0,'LDAP User Name','User Name used for authorization via LDAP (directory) services','Optional LDAP system user name for the user. If not defined, the normal Name of the user is used. This allows to use the internal (LDAP) user id (e.g. jjanke) and the normal display name (e.g. Jorg Janke).  The LDAP User Name can also be used without LDAP enables (see system window).  This would allow to sign in as jjanke and use the display name of Jorg Janke.',200025,'LDAPUser',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-06-03 13:42:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-03 13:42:09','YYYY-MM-DD HH24:MI:SS'),100,2546,'N','N','D','N','b0a54d7e-1189-4e3d-ad00-dd3b866db1ed','N','N')
;

-- Jun 3, 2020, 1:42:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214205,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200025,'Description',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-06-03 13:42:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-03 13:42:09','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','N','2cc9ec28-cd6a-4e85-9829-031dbde8f259',10,'N')
;

-- Jun 3, 2020, 1:42:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206411,'Description','Optional short description of the record','A description is limited to 255 characters.',200025,214205,'Y',2147483647,150,'N','N','N','N',0,0,'Y',TO_DATE('2020-06-03 13:42:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-03 13:42:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8673b14a-17bb-48bd-9287-a230e3140ab6','Y',160,5)
;

-- Jun 3, 2020, 1:42:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206412,'LDAP User Name','User Name used for authorization via LDAP (directory) services','Optional LDAP system user name for the user. If not defined, the normal Name of the user is used. This allows to use the internal (LDAP) user id (e.g. jjanke) and the normal display name (e.g. Jorg Janke).  The LDAP User Name can also be used without LDAP enables (see system window).  This would allow to sign in as jjanke and use the display name of Jorg Janke.',200025,214204,'Y',2147483647,160,'N','N','N','N',0,0,'Y',TO_DATE('2020-06-03 13:42:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-03 13:42:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5b3213ea-0081-46c6-858d-861d30829706','Y',170,5)
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206412
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200611
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200607
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200613
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200614
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200750
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200751
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200612
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200604
;

-- Jun 3, 2020, 1:43:43 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=8, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206411
;

-- Jun 3, 2020, 1:44:05 PM CEST
UPDATE AD_Field SET DisplayLogic='@LDAPUser@!''''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-03 13:44:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206412
;

-- Jun 3, 2020, 1:45:24 PM CEST
UPDATE AD_Tab SET OrderByClause='AD_SessionInfo_V.Created DESC',Updated=TO_DATE('2020-06-03 13:45:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200025
;

-- Jun 3, 2020, 1:48:34 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200125,'28bdb979-8f62-478b-a58a-de47ee8a8a43',TO_DATE('2020-06-03 13:48:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2020-06-03 13:48:33','YYYY-MM-DD HH24:MI:SS'),100,200005,'AD_Session_ID','s.AD_Session_ID',230)
;

-- Jun 3, 2020, 1:48:43 PM CEST
CREATE OR REPLACE VIEW AD_SessionInfo_v(AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, WebSession, Remote_Addr, Remote_Host, RoleName, LoginDate, AD_Session_UU, ServerName, ClientName, OrgName, AD_SessionInfo_V_ID, AD_SessionInfo_V_UU, LoginName, EMail, LDAPUser, Description, AD_Session_ID) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, s.IsActive AS IsActive, s.Created AS Created, s.CreatedBy AS CreatedBy, s.Updated AS Updated, s.UpdatedBy AS UpdatedBy, SUBSTR(s.WebSession, 1, 40) AS WebSession, SUBSTR(s.Remote_Addr, 1, 60) AS Remote_Addr, SUBSTR(s.Remote_Host, 1, 120) AS Remote_Host, SUBSTR(r.Name, 1, 60) AS RoleName, s.LoginDate AS LoginDate, s.AD_Session_UU AS AD_Session_UU, SUBSTR(s.ServerName, 1, 80) AS ServerName, SUBSTR(c.Name, 1, 60) AS ClientName, SUBSTR(o.Name, 1, 60) AS OrgName, s.AD_Session_ID AS AD_SessionInfo_V_ID, s.AD_Session_UU AS AD_SessionInfo_V_UU, SUBSTR(u.Name, 1, 60) AS LoginName, SUBSTR(u.EMail, 1, 60) AS EMail, SUBSTR(u.LDAPUser, 1, 60) AS LDAPUser, SUBSTR(s.Description, 1, 2000) AS Description, s.AD_Session_ID AS AD_Session_ID
FROM ad_session s
JOIN ad_user u ON s.createdby = u.ad_user_id
LEFT JOIN ad_role r ON s.ad_role_id = r.ad_role_id
JOIN ad_client c ON s.ad_client_id = c.ad_client_id
LEFT JOIN ad_org o ON s.ad_org_id = o.ad_org_id
WHERE s.processed = 'N'
;

-- Jun 3, 2020, 3:10:28 PM CEST
INSERT INTO AD_TreeBar (AD_Tree_ID,AD_User_ID,Node_ID, AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy)VALUES (10,100,200022,0,0,'Y',getDate(),100,getDate(),100)
;

-- Jun 3, 2020, 3:10:40 PM CEST
INSERT INTO AD_TreeBar (AD_Tree_ID,AD_User_ID,Node_ID, AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy)VALUES (10,100,383,0,0,'Y',getDate(),100,getDate(),100)
;

SELECT register_migration_script('202006031349_IDEMPIERE-3358.sql') FROM dual
;

