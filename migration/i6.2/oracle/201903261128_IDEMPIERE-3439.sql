SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3439 Create System windows to analyze all clients and users
-- Mar 26, 2019, 10:23:23 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200072,'d4e460b5-e405-40b1-83e3-c3e86b4ebece',TO_DATE('2019-03-26 10:23:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:23:22','YYYY-MM-DD HH24:MI:SS'),100,200002,'IsSupportUser','IsSupportUser',250)
;

-- Mar 26, 2019, 10:26:46 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200073,'be429289-ebed-4807-9d85-047f1a24d1bf',TO_DATE('2019-03-26 10:26:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:26:45','YYYY-MM-DD HH24:MI:SS'),100,200002,'IsNoExpire','IsNoExpire',260)
;

-- Mar 26, 2019, 10:27:52 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200074,'3593fe88-cf23-411e-8c2b-df2461665274',TO_DATE('2019-03-26 10:27:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:27:51','YYYY-MM-DD HH24:MI:SS'),100,200002,'DateAccountLocked','DateAccountLocked',270)
;

-- Mar 26, 2019, 10:29:02 AM BRT
CREATE OR REPLACE VIEW AD_AllUsers_V(AD_Client_ID, AD_Org_ID, AD_AllUsers_V_ID, AD_AllClients_V_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, Value, Name, EMail, LDAPUser, Description, DateLastLogin, UserPIN, Password, Salt, IsLocked, FailedLoginCount, DatePasswordChanged, IsNoPasswordReset, IsExpired, AD_AllUsers_V_UU, IsSupportUser, IsNoExpire, DateAccountLocked) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_User_ID AS AD_AllUsers_V_ID, AD_Client_ID AS AD_AllClients_V_ID, IsActive AS IsActive, Created AS Created, CreatedBy AS CreatedBy, Updated AS Updated, UpdatedBy AS UpdatedBy, Value AS Value, Name AS Name, EMail AS EMail, LDAPUser AS LDAPUser, Description AS Description, DateLastLogin AS DateLastLogin, UserPIN AS UserPIN, Password AS Password, Salt AS Salt, IsLocked AS IsLocked, FailedLoginCount AS FailedLoginCount, DatePasswordChanged AS DatePasswordChanged, IsNoPasswordReset AS IsNoPasswordReset, IsExpired AS IsExpired, AD_User_UU AS AD_AllUsers_V_UU, IsSupportUser AS IsSupportUser, IsNoExpire AS IsNoExpire, DateAccountLocked AS DateAccountLocked FROM AD_User WHERE Password IS NOT NULL
;

-- Mar 26, 2019, 10:30:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213867,0,'Support User',200224,'IsSupportUser','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-03-26 10:30:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:30:34','YYYY-MM-DD HH24:MI:SS'),100,203304,'Y','N','D','N','N','N','Y','bd6dcaf2-9712-496c-9fd7-a10ece594c49','Y',0,'N','N','N')
;

-- Mar 26, 2019, 10:30:45 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213868,0,'No Expire',200224,'IsNoExpire','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-03-26 10:30:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:30:45','YYYY-MM-DD HH24:MI:SS'),100,203266,'Y','N','D','N','N','N','Y','2cf50ee3-0b08-4eeb-973b-497047da1912','Y',0,'N','N','N')
;

-- Mar 26, 2019, 10:30:59 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213869,0,'Date Account Locked',200224,'DateAccountLocked',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2019-03-26 10:30:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:30:59','YYYY-MM-DD HH24:MI:SS'),100,200112,'Y','N','D','N','N','N','Y','79ac9f7b-fec5-495e-810f-8ba050826e73','Y',0,'N','N')
;

-- Mar 26, 2019, 10:31:50 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205958,'Support User',200227,213867,'Y',1,170,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:31:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:31:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d3fa87a1-9199-46c9-a3dd-1245625555ff','Y',160,2,2)
;

-- Mar 26, 2019, 10:31:50 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205959,'No Expire',200227,213868,'Y',1,180,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:31:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:31:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19e6a8aa-c4b3-418b-ab2e-47b0882652b5','Y',170,2,2)
;

-- Mar 26, 2019, 10:31:51 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205960,'Date Account Locked',200227,213869,'Y',7,190,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:31:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:31:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d70fa814-4e3f-4ab8-9b78-6649ee6cd854','Y',180,2)
;

-- Mar 26, 2019, 10:32:07 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205961,'Support User',200228,213867,'Y',1,170,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:32:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:32:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a7396bfa-a0ee-47e9-b760-62e5d90663e6','Y',170,2,2)
;

-- Mar 26, 2019, 10:32:07 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205962,'No Expire',200228,213868,'Y',1,180,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:32:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:32:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3214002f-73d8-4514-9cb3-f509ee021535','Y',180,2,2)
;

-- Mar 26, 2019, 10:32:08 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205963,'Date Account Locked',200228,213869,'Y',7,190,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:32:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:32:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b9ea300c-965b-4b47-b7d3-ace91db73211','Y',190,2)
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205161
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205164
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205162
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205959
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205958
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205169
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205163
;

-- Mar 26, 2019, 10:34:42 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205960
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205181
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205184
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205182
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205962
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205961
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205189
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205183
;

-- Mar 26, 2019, 10:36:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 10:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205963
;

-- Mar 26, 2019, 10:39:46 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200075,'26afbdc1-a8b0-42bb-82d4-11a284f6dccf',TO_DATE('2019-03-26 10:39:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:39:46','YYYY-MM-DD HH24:MI:SS'),100,200003,'RoleType','AD_Role.RoleType',260)
;

-- Mar 26, 2019, 10:40:00 AM BRT
CREATE OR REPLACE VIEW AD_AllUserRoles_V(AD_Client_ID, AD_Org_ID, AD_AllUsers_V_ID, AD_AllClients_V_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, AD_AllUserRoles_V_UU, Name, Description, UserLevel, IsManual, IsShowAcct, IsPersonalLock, IsPersonalAccess, IsCanExport, IsCanReport, IsAccessAllOrgs, IsChangeLog, PreferenceType, IsUseUserOrgAccess, IsMasterRole, IsAccessAdvanced, RoleType) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_User_Roles.AD_User_ID AS AD_AllUsers_V_ID, AD_Role.AD_Client_ID AS AD_AllClients_V_ID, CASE WHEN AD_User_Roles.IsActive = 'N' THEN AD_User_Roles.IsActive ELSE AD_Role.IsActive END AS IsActive, AD_User_Roles.Created AS Created, AD_User_Roles.CreatedBy AS CreatedBy, AD_User_Roles.Updated AS Updated, AD_User_Roles.UpdatedBy AS UpdatedBy, AD_User_Roles.AD_User_Roles_UU AS AD_AllUserRoles_V_UU, AD_Role.Name AS Name, AD_Role.Description AS Description, AD_Role.UserLevel AS UserLevel, AD_Role.IsManual AS IsManual, AD_Role.IsShowAcct AS IsShowAcct, AD_Role.IsPersonalLock AS IsPersonalLock, AD_Role.IsPersonalAccess AS IsPersonalAccess, AD_Role.IsCanExport AS IsCanExport, AD_Role.IsCanReport AS IsCanReport, AD_Role.IsAccessAllOrgs AS IsAccessAllOrgs, AD_Role.IsChangeLog AS IsChangeLog, AD_Role.PreferenceType AS PreferenceType, AD_Role.IsUseUserOrgAccess AS IsUseUserOrgAccess, AD_Role.IsMasterRole AS IsMasterRole, AD_Role.IsAccessAdvanced AS IsAccessAdvanced, AD_Role.RoleType AS RoleType FROM AD_User_Roles JOIN AD_Role ON (AD_Role.AD_Role_ID=AD_User_Roles.AD_Role_ID)
;

-- Mar 26, 2019, 10:40:16 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213870,0,'Role Type',200254,'RoleType',2,'N','N','N','N','N',0,'N',17,200166,0,0,'Y',TO_DATE('2019-03-26 10:40:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:40:16','YYYY-MM-DD HH24:MI:SS'),100,203303,'Y','N','D','N','N','N','Y','bea9e097-714f-4ac7-8029-4682e88cebac','Y',0,'N','N','N')
;

-- Mar 26, 2019, 10:40:56 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205964,'Role Type',200262,213870,'Y',2,190,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:40:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:40:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','056ce3f6-e96a-485b-8d59-06e149454e00','Y',180,2)
;

-- Mar 26, 2019, 10:41:05 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205965,'Role Type',200263,213870,'Y',2,190,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 10:41:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:41:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','befb9e4e-0821-4476-977b-ee06e21f44e2','Y',190,2)
;

-- Mar 26, 2019, 10:43:51 AM BRT
INSERT INTO AD_Window (AD_Window_ID,Name,Description,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200108,'All Roles','Roles from All Clients',0,0,'Y',TO_DATE('2019-03-26 10:43:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:43:51','YYYY-MM-DD HH24:MI:SS'),100,'Q','N','D','Y','N',0,0,'N','7e2e7287-97f5-44cb-9c53-5c99afe77e0a')
;

-- Mar 26, 2019, 10:44:00 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200255,'All Roles','Roles from All Tenants',200108,'AD_AllRoles_V',0,'4',0,0,'Y',TO_DATE('2019-03-26 10:43:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:43:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','Y','L','N','Y','4cd182b9-1184-4e35-a16d-f34a313c1795','N','N','N')
;

-- Mar 26, 2019, 10:44:00 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AllRoles_V',1000000,'N','N','Table AD_AllRoles_V','Y','Y',0,0,TO_DATE('2019-03-26 10:44:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:44:00','YYYY-MM-DD HH24:MI:SS'),100,200318,'Y',1000000,1,200000,'3730a243-1a5e-46af-82f2-faa66b6a3afb')
;

-- Mar 26, 2019, 10:45:26 AM BRT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200170,'All Roles','W',200108,0,0,'Y',TO_DATE('2019-03-26 10:45:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:45:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','62109682-7275-4f75-9ced-49222885753c')
;

-- Mar 26, 2019, 10:45:26 AM BRT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200170, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200170)
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200002
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=147
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=150
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53246
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=495
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200017
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50007
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200012
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=362
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200001
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53201
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53348
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200147
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200148
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200170
;

-- Mar 26, 2019, 10:46:24 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200165
;

-- Mar 26, 2019, 10:47:58 AM BRT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,Referenced_Table_ID,SeqNo,FromClause) VALUES (0,0,200004,'ea4f19e7-e13a-4297-aaaa-79ab2d71f2a8',TO_DATE('2019-03-26 10:47:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AllRoles',TO_DATE('2019-03-26 10:47:58','YYYY-MM-DD HH24:MI:SS'),100,200255,156,10,'FROM AD_Role')
;

-- Mar 26, 2019, 10:48:25 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200076,'f5796a76-2773-4d5a-86fd-30bb2864cf9d',TO_DATE('2019-03-26 10:48:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:48:25','YYYY-MM-DD HH24:MI:SS'),100,200004,'AD_Client_ID','0',10)
;

-- Mar 26, 2019, 10:48:31 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200077,'08e2e66c-ad9d-40d8-8d7d-719ab5bd88dd',TO_DATE('2019-03-26 10:48:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:48:31','YYYY-MM-DD HH24:MI:SS'),100,200004,'AD_Org_ID','0',20)
;

-- Mar 26, 2019, 10:48:52 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200078,'46491cb3-c5f3-484a-8146-586fd13e7c61',TO_DATE('2019-03-26 10:48:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:48:52','YYYY-MM-DD HH24:MI:SS'),100,200004,'AD_AllRoles_V_ID','AD_Role_ID',30)
;

-- Mar 26, 2019, 10:49:08 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200079,'21d83914-16ee-440a-8219-c77154e82b82',TO_DATE('2019-03-26 10:49:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:49:08','YYYY-MM-DD HH24:MI:SS'),100,200004,'AD_AllRoles_V_UU','AD_Role_UU',40)
;

-- Mar 26, 2019, 10:49:35 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200080,'716417ca-9f58-4866-abef-2a744a7717ab',TO_DATE('2019-03-26 10:49:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:49:34','YYYY-MM-DD HH24:MI:SS'),100,200004,'Created','Created',50)
;

-- Mar 26, 2019, 10:49:43 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200081,'171604eb-5404-404b-87c3-1b470803b253',TO_DATE('2019-03-26 10:49:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:49:43','YYYY-MM-DD HH24:MI:SS'),100,200004,'CreatedBy','CreatedBy',60)
;

-- Mar 26, 2019, 10:49:52 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200082,'bb517466-6c51-4d18-a7d3-849d304528d7',TO_DATE('2019-03-26 10:49:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:49:51','YYYY-MM-DD HH24:MI:SS'),100,200004,'Updated','Updated',70)
;

-- Mar 26, 2019, 10:49:58 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200083,'7f76a5c2-f264-40f4-9076-f94cd386023f',TO_DATE('2019-03-26 10:49:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:49:58','YYYY-MM-DD HH24:MI:SS'),100,200004,'UpdatedBy','UpdatedBy',80)
;

-- Mar 26, 2019, 10:50:05 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200084,'fb445895-1beb-472d-afaf-b9965a1c8252',TO_DATE('2019-03-26 10:50:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:50:05','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsActive','IsActive',90)
;

-- Mar 26, 2019, 10:51:29 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200085,'40d17e98-252c-4a11-a621-dba4c1c20631',TO_DATE('2019-03-26 10:51:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:51:28','YYYY-MM-DD HH24:MI:SS'),100,200004,'Name','Name',100)
;

-- Mar 26, 2019, 10:51:36 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200086,'991d078b-e76d-4e27-9f3a-5a3feada1a7b',TO_DATE('2019-03-26 10:51:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:51:35','YYYY-MM-DD HH24:MI:SS'),100,200004,'Description','Description',110)
;

-- Mar 26, 2019, 10:51:48 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200087,'0c9527e3-ef75-485a-9fd2-ecfdfee74816',TO_DATE('2019-03-26 10:51:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:51:47','YYYY-MM-DD HH24:MI:SS'),100,200004,'UserLevel','UserLevel',120)
;

-- Mar 26, 2019, 10:51:58 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200088,'377a8dcf-5fac-4187-9292-4fb5821257a6',TO_DATE('2019-03-26 10:51:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:51:58','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsManual','IsManual',130)
;

-- Mar 26, 2019, 10:52:08 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200089,'0f75e77a-1fbd-4bf5-b16e-637a34ca62aa',TO_DATE('2019-03-26 10:52:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:52:08','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsShowAcct','IsShowAcct',140)
;

-- Mar 26, 2019, 10:52:18 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200090,'f680d135-09da-4dd1-bf76-94dd49a0d3b7',TO_DATE('2019-03-26 10:52:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:52:17','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsPersonalLock','IsPersonalLock',150)
;

-- Mar 26, 2019, 10:52:26 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200091,'2c9844b6-11ab-4836-968e-ab8e75455e67',TO_DATE('2019-03-26 10:52:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:52:25','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsPersonalAccess','IsPersonalAccess',160)
;

-- Mar 26, 2019, 10:52:34 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200092,'04697353-52af-4e67-ac7a-ea1f4eec51df',TO_DATE('2019-03-26 10:52:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:52:33','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsCanExport','IsCanExport',170)
;

-- Mar 26, 2019, 10:52:43 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200093,'7041b846-455d-49fb-99bf-d11befb3c2cd',TO_DATE('2019-03-26 10:52:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:52:43','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsCanReport','IsCanReport',180)
;

-- Mar 26, 2019, 10:52:56 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200094,'fb7e8c14-5370-4d96-8723-0b4d3b145ba0',TO_DATE('2019-03-26 10:52:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:52:55','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsAccessAllOrgs','IsAccessAllOrgs',190)
;

-- Mar 26, 2019, 10:53:04 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200095,'4c57276f-efff-4997-bcfa-6608f291ea4d',TO_DATE('2019-03-26 10:53:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:53:04','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsChangeLog','IsChangeLog',200)
;

-- Mar 26, 2019, 10:53:18 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200096,'f5924257-8804-4cb9-9d25-05d0532bc78f',TO_DATE('2019-03-26 10:53:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:53:18','YYYY-MM-DD HH24:MI:SS'),100,200004,'PreferenceType','PreferenceType',210)
;

-- Mar 26, 2019, 10:53:37 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200097,'5bddac4e-0f3e-421f-8814-6b5c7250cd76',TO_DATE('2019-03-26 10:53:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:53:36','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsUseUserOrgAccess','IsUseUserOrgAccess',220)
;

-- Mar 26, 2019, 10:53:45 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200098,'570b40af-ed04-4d8b-8fc2-209e3c7e8291',TO_DATE('2019-03-26 10:53:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:53:45','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsMasterRole','IsMasterRole',230)
;

-- Mar 26, 2019, 10:53:56 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200099,'dbeaccae-e947-421a-8d92-e5458e279719',TO_DATE('2019-03-26 10:53:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:53:55','YYYY-MM-DD HH24:MI:SS'),100,200004,'IsAccessAdvanced','IsAccessAdvanced',240)
;

-- Mar 26, 2019, 10:54:03 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200100,'76483416-76fc-4551-8026-1a935fded2d0',TO_DATE('2019-03-26 10:54:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 10:54:03','YYYY-MM-DD HH24:MI:SS'),100,200004,'RoleType','RoleType',250)
;

-- Mar 26, 2019, 10:54:17 AM BRT
CREATE OR REPLACE VIEW AD_AllRoles_V(AD_Client_ID, AD_Org_ID, AD_AllRoles_V_ID, AD_AllRoles_V_UU, Created, CreatedBy, Updated, UpdatedBy, IsActive, Name, Description, UserLevel, IsManual, IsShowAcct, IsPersonalLock, IsPersonalAccess, IsCanExport, IsCanReport, IsAccessAllOrgs, IsChangeLog, PreferenceType, IsUseUserOrgAccess, IsMasterRole, IsAccessAdvanced, RoleType) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_Role_ID AS AD_AllRoles_V_ID, AD_Role_UU AS AD_AllRoles_V_UU, Created AS Created, CreatedBy AS CreatedBy, Updated AS Updated, UpdatedBy AS UpdatedBy, IsActive AS IsActive, Name AS Name, Description AS Description, UserLevel AS UserLevel, IsManual AS IsManual, IsShowAcct AS IsShowAcct, IsPersonalLock AS IsPersonalLock, IsPersonalAccess AS IsPersonalAccess, IsCanExport AS IsCanExport, IsCanReport AS IsCanReport, IsAccessAllOrgs AS IsAccessAllOrgs, IsChangeLog AS IsChangeLog, PreferenceType AS PreferenceType, IsUseUserOrgAccess AS IsUseUserOrgAccess, IsMasterRole AS IsMasterRole, IsAccessAdvanced AS IsAccessAdvanced, RoleType AS RoleType FROM AD_Role
;

-- Mar 26, 2019, 10:55:25 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213871,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200255,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_DATE('2019-03-26 10:55:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:25','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','3732a820-0b33-424b-aebe-613a9789d690','N','D')
;

-- Mar 26, 2019, 10:55:26 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213872,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200255,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_DATE('2019-03-26 10:55:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:25','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','649ad125-eda7-465f-845b-cae9a9da12c1','N','D')
;

-- Mar 26, 2019, 10:55:26 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203312,0,0,'Y',TO_DATE('2019-03-26 10:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:26','YYYY-MM-DD HH24:MI:SS'),100,'AD_AllRoles_V_ID','All Roles','All Roles','D','938ee3eb-f97f-45d5-b12b-e5faa4630748')
;

-- Mar 26, 2019, 10:55:27 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213873,0.0,'All Roles',200255,'AD_AllRoles_V_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_DATE('2019-03-26 10:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:26','YYYY-MM-DD HH24:MI:SS'),100,203312,'N','N','D','N','a9972758-d770-4267-9eb0-61bdaab78e0f','N')
;

-- Mar 26, 2019, 10:55:27 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203313,0,0,'Y',TO_DATE('2019-03-26 10:55:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:27','YYYY-MM-DD HH24:MI:SS'),100,'AD_AllRoles_V_UU','AD_AllRoles_V_UU','AD_AllRoles_V_UU','D','f57a6bfc-42a4-489b-aa06-a44e8845af64')
;

-- Mar 26, 2019, 10:55:28 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213874,0.0,'AD_AllRoles_V_UU',200255,'AD_AllRoles_V_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2019-03-26 10:55:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:27','YYYY-MM-DD HH24:MI:SS'),100,203313,'N','N','D','N','bae936bf-45b8-432a-854e-8edd1b05ef07','N')
;

-- Mar 26, 2019, 10:55:28 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213875,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200255,'Created','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_DATE('2019-03-26 10:55:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:28','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','73ea95ef-511c-43cf-8807-6a6830356a26','N')
;

-- Mar 26, 2019, 10:55:28 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213876,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200255,'CreatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_DATE('2019-03-26 10:55:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:28','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','30f01b15-5301-4e8d-ba19-7dbda318dbf7','N','D')
;

-- Mar 26, 2019, 10:55:29 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213877,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200255,'Updated','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_DATE('2019-03-26 10:55:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:28','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','56469f2a-a68d-4ec8-b017-d0e267f7d947','N')
;

-- Mar 26, 2019, 10:55:29 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213878,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200255,'UpdatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_DATE('2019-03-26 10:55:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:29','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','5df1d6fa-c8d8-42fa-ab8b-5c76114dee2e','N','D')
;

-- Mar 26, 2019, 10:55:30 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213879,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200255,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:29','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','N','dc2c16e8-8c27-4adf-93ec-e925d99dc709','N')
;

-- Mar 26, 2019, 10:55:30 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (213880,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200255,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_DATE('2019-03-26 10:55:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:30','YYYY-MM-DD HH24:MI:SS'),100,469,'N','Y','D','N','b4949552-9d04-45b3-8efb-b6a04b558ac6',10,'N')
;

-- Mar 26, 2019, 10:55:31 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (213881,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200255,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2019-03-26 10:55:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:30','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','N','a1ab939c-5621-47ca-b5b0-adb1074d82d4',20,'N')
;

-- Mar 26, 2019, 10:55:31 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213882,0.0,'User Level','System Client Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Client level data or Client and Organization level data.',200255,'UserLevel',3,'N','N','N','N','N','N',17,226,0,0,'Y',TO_DATE('2019-03-26 10:55:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:31','YYYY-MM-DD HH24:MI:SS'),100,615,'N','N','D','N','3a4d5815-9a1f-40f3-93e3-c4fd24014f26','N','N')
;

-- Mar 26, 2019, 10:55:31 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213883,0.0,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200255,'IsManual','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:31','YYYY-MM-DD HH24:MI:SS'),100,1474,'N','N','D','N','9b59dcf3-79c3-4e2c-9a1f-a8c17ba54ff0','N')
;

-- Mar 26, 2019, 10:55:32 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213884,0.0,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200255,'IsShowAcct','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:31','YYYY-MM-DD HH24:MI:SS'),100,2213,'N','N','D','N','f6834f4a-ecad-4556-840c-04acb29c979e','N','N')
;

-- Mar 26, 2019, 10:55:32 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213885,0.0,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200255,'IsPersonalLock','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:32','YYYY-MM-DD HH24:MI:SS'),100,2210,'N','N','D','N','c9c865c1-9b5f-4312-8eb2-00ee69b8fe9c','N','N')
;

-- Mar 26, 2019, 10:55:33 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213886,0.0,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200255,'IsPersonalAccess','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:32','YYYY-MM-DD HH24:MI:SS'),100,2209,'N','N','D','N','0b3b3d78-c500-4bb0-8e42-2cccd74f00ff','N','N')
;

-- Mar 26, 2019, 10:55:33 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213887,0.0,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200255,'IsCanExport','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:33','YYYY-MM-DD HH24:MI:SS'),100,2204,'N','N','D','N','c4b0e01a-d012-41bf-99db-ae1af393ff7f','N','N')
;

-- Mar 26, 2019, 10:55:34 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213888,0.0,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200255,'IsCanReport','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:33','YYYY-MM-DD HH24:MI:SS'),100,2205,'N','N','D','N','0ba07fbc-7b07-41ad-97c1-e27d7cf2654a','N','N')
;

-- Mar 26, 2019, 10:55:34 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213889,0.0,'Access all Orgs','Access all Organizations (no org access control) of the client','When selected, the role has access to all organizations of the client automatically. This also increases performance where you have many organizations.',200255,'IsAccessAllOrgs','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:34','YYYY-MM-DD HH24:MI:SS'),100,2587,'N','N','D','N','6591947d-8a0b-4ca5-a564-fff1f00a1867','N','N')
;

-- Mar 26, 2019, 10:55:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213890,0.0,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200255,'IsChangeLog','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:34','YYYY-MM-DD HH24:MI:SS'),100,2046,'N','N','D','N','4cd10f82-a619-4aba-8960-c557dcc494c6','N','N')
;

-- Mar 26, 2019, 10:55:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213891,0.0,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Client, you can see the Record Info Change Log.',200255,'PreferenceType','O',1,'N','N','N','N','N','N',17,330,0,0,'Y',TO_DATE('2019-03-26 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,2656,'N','N','D','N','e0673398-055a-44e2-9f78-c9fe79a2b636','N','N')
;

-- Mar 26, 2019, 10:55:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213892,0.0,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200255,'IsUseUserOrgAccess','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,2696,'N','N','D','N','cd30f3f1-2e93-46ad-9c20-b86e915d0a3c','N','N')
;

-- Mar 26, 2019, 10:55:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213893,0.0,'Master Role','A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200255,'IsMasterRole','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,200117,'N','N','D','N','0cccd0d1-5bce-4555-a373-8928eb182199','N','N')
;

-- Mar 26, 2019, 10:55:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213894,0.0,'Access Advanced ',200255,'IsAccessAdvanced','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_DATE('2019-03-26 10:55:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:36','YYYY-MM-DD HH24:MI:SS'),100,202575,'N','N','D','N','68bbd269-9765-4bea-84c5-5dbb28de8ba2','N','N')
;

-- Mar 26, 2019, 10:55:37 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213895,0.0,'Role Type',200255,'RoleType',2,'N','N','N','N','N','N',17,200166,0,0,'Y',TO_DATE('2019-03-26 10:55:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 10:55:36','YYYY-MM-DD HH24:MI:SS'),100,203303,'N','N','D','N','2bef7804-288c-40ae-9b38-3a4b3dd0cfea','N','N')
;

-- Mar 26, 2019, 11:00:13 AM BRT
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, DefaultValue=NULL, IsAllowCopy='N',Updated=TO_DATE('2019-03-26 11:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213871
;

-- Mar 26, 2019, 11:00:26 AM BRT
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, DefaultValue=NULL, IsAllowCopy='N',Updated=TO_DATE('2019-03-26 11:00:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213872
;

-- Mar 26, 2019, 11:05:18 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200264,'Role',200108,10,'Y',200255,0,0,'Y',TO_DATE('2019-03-26 11:05:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:05:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_AllRoles_V.Name','N','N',0,'N','D','Y','N','2db530bc-a013-4a84-b7b4-0ee2c9636720','B')
;

-- Mar 26, 2019, 11:06:21 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200101,'6ad34b29-c526-4215-9094-7f19d24e0162',TO_DATE('2019-03-26 11:06:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 11:06:21','YYYY-MM-DD HH24:MI:SS'),100,200004,'AD_AllClients_V_ID','AD_Client_ID',260)
;

-- Mar 26, 2019, 11:06:41 AM BRT
CREATE OR REPLACE VIEW AD_AllRoles_V(AD_Client_ID, AD_Org_ID, AD_AllRoles_V_ID, AD_AllRoles_V_UU, Created, CreatedBy, Updated, UpdatedBy, IsActive, Name, Description, UserLevel, IsManual, IsShowAcct, IsPersonalLock, IsPersonalAccess, IsCanExport, IsCanReport, IsAccessAllOrgs, IsChangeLog, PreferenceType, IsUseUserOrgAccess, IsMasterRole, IsAccessAdvanced, RoleType, AD_AllClients_V_ID) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_Role_ID AS AD_AllRoles_V_ID, AD_Role_UU AS AD_AllRoles_V_UU, Created AS Created, CreatedBy AS CreatedBy, Updated AS Updated, UpdatedBy AS UpdatedBy, IsActive AS IsActive, Name AS Name, Description AS Description, UserLevel AS UserLevel, IsManual AS IsManual, IsShowAcct AS IsShowAcct, IsPersonalLock AS IsPersonalLock, IsPersonalAccess AS IsPersonalAccess, IsCanExport AS IsCanExport, IsCanReport AS IsCanReport, IsAccessAllOrgs AS IsAccessAllOrgs, IsChangeLog AS IsChangeLog, PreferenceType AS PreferenceType, IsUseUserOrgAccess AS IsUseUserOrgAccess, IsMasterRole AS IsMasterRole, IsAccessAdvanced AS IsAccessAdvanced, RoleType AS RoleType, AD_Client_ID AS AD_AllClients_V_ID FROM AD_Role
;

-- Mar 26, 2019, 11:07:50 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213896,0,'All Clients',200255,'AD_AllClients_V_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2019-03-26 11:07:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:07:49','YYYY-MM-DD HH24:MI:SS'),100,203119,'N','N','D','N','N','N','Y','63e0e42c-8f6b-4ada-b852-a3b32dea43ae','Y',0,'N','N','N')
;

-- Mar 26, 2019, 11:08:29 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205966,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200264,213871,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c3e9608a-0497-471f-97f4-f1fb06dade74','N',2)
;

-- Mar 26, 2019, 11:08:31 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (205967,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200264,213872,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6f532cbf-43c9-4902-9cf1-bdbd929fa8a7','Y','N',4,2)
;

-- Mar 26, 2019, 11:08:31 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205968,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200264,213880,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','374e0e0b-6f24-43ef-9225-ea462ccca909','Y',10,5)
;

-- Mar 26, 2019, 11:08:31 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205969,'Description','Optional short description of the record','A description is limited to 255 characters.',200264,213881,'Y',255,40,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0847d504-7120-488b-a64a-d7f4e6b77d47','Y',20,5)
;

-- Mar 26, 2019, 11:08:32 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205970,'All Roles',200264,213873,'N',10,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bc7a41e5-4139-47af-b727-b8cc037c99e6','N',2)
;

-- Mar 26, 2019, 11:08:32 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205971,'AD_AllRoles_V_UU',200264,213874,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a584123-e427-4bb3-b682-ed5a2cac1adc','N',2)
;

-- Mar 26, 2019, 11:08:33 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205972,'User Level','System Client Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Client level data or Client and Organization level data.',200264,213882,'Y',3,50,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d7087782-51f0-4481-bfaa-a7673caa522f','Y',30,2)
;

-- Mar 26, 2019, 11:08:34 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205973,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200264,213883,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e786acc9-241c-414f-a9b8-d3641a393bae','Y',40,2,2)
;

-- Mar 26, 2019, 11:08:35 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205974,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200264,213884,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b5f829b7-91e2-4daa-8adc-dfda47f969b5','Y',50,2,2)
;

-- Mar 26, 2019, 11:08:35 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205975,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200264,213885,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','834970f6-5f01-4c63-97c6-44693b3a143f','Y',60,2,2)
;

-- Mar 26, 2019, 11:08:36 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205976,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200264,213886,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2e63215f-2014-4da7-8830-a0bdb64b3bde','Y',70,2,2)
;

-- Mar 26, 2019, 11:08:36 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205977,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200264,213887,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','38c1c758-f974-4f6d-821b-7e237136029e','Y',80,2,2)
;

-- Mar 26, 2019, 11:08:36 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205978,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200264,213888,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ca379790-816b-4df5-9105-b680304951b6','Y',90,2,2)
;

-- Mar 26, 2019, 11:08:37 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205979,'Access all Orgs','Access all Organizations (no org access control) of the client','When selected, the role has access to all organizations of the client automatically. This also increases performance where you have many organizations.',200264,213889,'Y',1,120,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c8a404bb-75ae-496a-8dc1-3eee00613503','Y',100,2,2)
;

-- Mar 26, 2019, 11:08:37 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205980,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200264,213890,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e81fe34e-e467-4f10-93a2-d368869c619e','Y',110,2,2)
;

-- Mar 26, 2019, 11:08:38 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205981,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Client, you can see the Record Info Change Log.',200264,213891,'Y',1,140,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d569c1ab-b9f7-4f6e-86ba-ed68e616bdf1','Y',120,2)
;

-- Mar 26, 2019, 11:08:38 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205982,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200264,213892,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','78c9f09a-4c1c-48aa-8252-e3339664caa2','Y',130,2,2)
;

-- Mar 26, 2019, 11:08:39 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205983,'Master Role','A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200264,213893,'Y',1,160,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa142c8e-f553-42b8-8809-2c86f928a131','Y',140,2,2)
;

-- Mar 26, 2019, 11:08:39 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205984,'Access Advanced ',200264,213894,'Y',1,170,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','156b34db-cf59-49d2-b5e3-d165da6707e7','Y',150,2,2)
;

-- Mar 26, 2019, 11:08:39 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205985,'Role Type',200264,213895,'Y',2,180,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e11c36db-4b73-4209-939c-6c45acc1add2','Y',160,2)
;

-- Mar 26, 2019, 11:08:40 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205986,'All Clients',200264,213896,'Y',10,190,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fe800366-eed6-42f7-93fc-ceaf4e36942b','Y',170,2)
;

-- Mar 26, 2019, 11:08:41 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205987,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200264,213879,'Y',1,200,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:08:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:08:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6a667047-fda8-4c67-a59c-0538115034d7','Y',180,2,2)
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205986
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205968
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205969
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205972
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205981
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205973
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205983
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205979
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205982
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205977
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205978
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205974
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205975
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205976
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205984
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205980
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205987
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205971
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205970
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205966
;

-- Mar 26, 2019, 11:11:11 AM BRT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205967
;

-- Mar 26, 2019, 11:13:31 AM BRT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200102,'78359706-2020-4901-b408-07b7cc6b74e9',TO_DATE('2019-03-26 11:13:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2019-03-26 11:13:30','YYYY-MM-DD HH24:MI:SS'),100,200003,'AD_AllRoles_V_ID','AD_Role.AD_Role_ID',270)
;

-- Mar 26, 2019, 11:13:39 AM BRT
CREATE OR REPLACE VIEW AD_AllUserRoles_V(AD_Client_ID, AD_Org_ID, AD_AllUsers_V_ID, AD_AllClients_V_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, AD_AllUserRoles_V_UU, Name, Description, UserLevel, IsManual, IsShowAcct, IsPersonalLock, IsPersonalAccess, IsCanExport, IsCanReport, IsAccessAllOrgs, IsChangeLog, PreferenceType, IsUseUserOrgAccess, IsMasterRole, IsAccessAdvanced, RoleType, AD_AllRoles_V_ID) AS SELECT 0 AS AD_Client_ID, 0 AS AD_Org_ID, AD_User_Roles.AD_User_ID AS AD_AllUsers_V_ID, AD_Role.AD_Client_ID AS AD_AllClients_V_ID, CASE WHEN AD_User_Roles.IsActive = 'N' THEN AD_User_Roles.IsActive ELSE AD_Role.IsActive END AS IsActive, AD_User_Roles.Created AS Created, AD_User_Roles.CreatedBy AS CreatedBy, AD_User_Roles.Updated AS Updated, AD_User_Roles.UpdatedBy AS UpdatedBy, AD_User_Roles.AD_User_Roles_UU AS AD_AllUserRoles_V_UU, AD_Role.Name AS Name, AD_Role.Description AS Description, AD_Role.UserLevel AS UserLevel, AD_Role.IsManual AS IsManual, AD_Role.IsShowAcct AS IsShowAcct, AD_Role.IsPersonalLock AS IsPersonalLock, AD_Role.IsPersonalAccess AS IsPersonalAccess, AD_Role.IsCanExport AS IsCanExport, AD_Role.IsCanReport AS IsCanReport, AD_Role.IsAccessAllOrgs AS IsAccessAllOrgs, AD_Role.IsChangeLog AS IsChangeLog, AD_Role.PreferenceType AS PreferenceType, AD_Role.IsUseUserOrgAccess AS IsUseUserOrgAccess, AD_Role.IsMasterRole AS IsMasterRole, AD_Role.IsAccessAdvanced AS IsAccessAdvanced, AD_Role.RoleType AS RoleType, AD_Role.AD_Role_ID AS AD_AllRoles_V_ID FROM AD_User_Roles JOIN AD_Role ON (AD_Role.AD_Role_ID=AD_User_Roles.AD_Role_ID)
;

-- Mar 26, 2019, 11:13:49 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213897,0.0,'All Roles',200254,'AD_AllRoles_V_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_DATE('2019-03-26 11:13:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:13:48','YYYY-MM-DD HH24:MI:SS'),100,203312,'N','N','D','N','26a8bed1-abdb-4ee0-8d57-355557736ce3','N','N')
;

-- Mar 26, 2019, 11:14:43 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205988,'All Roles',200263,213897,'Y',10,200,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:14:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:14:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7bd5377a-2946-4568-ba8a-527c0ee65ac4','Y',200,2)
;

-- Mar 26, 2019, 11:14:58 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205989,'All Roles',200262,213897,'Y',10,200,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:14:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:14:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7fc37f16-973b-4c14-a6da-95e8e9e32d9d','Y',190,2)
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205988
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205928
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205929
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205930
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205931
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205932
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205933
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205934
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205935
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205936
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205937
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205938
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205939
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205940
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205941
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205942
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205943
;

-- Mar 26, 2019, 11:15:14 AM BRT
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205965
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205989
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205907
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205908
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205909
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205910
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205911
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205912
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205913
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205914
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205915
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205916
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205917
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205918
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205919
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205920
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205921
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205922
;

-- Mar 26, 2019, 11:15:22 AM BRT
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-26 11:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205964
;

-- Mar 26, 2019, 11:18:59 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200265,'Role',200092,30,'Y',200255,0,0,'Y',TO_DATE('2019-03-26 11:18:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:18:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','32d8aefe-8404-49dc-b22a-e403b7a5d2e3','B')
;

-- Mar 26, 2019, 11:19:10 AM BRT
UPDATE AD_Tab SET AD_Column_ID=213896,Updated=TO_DATE('2019-03-26 11:19:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200265
;

-- Mar 26, 2019, 11:19:43 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205990,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200265,213871,'N',10,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','312b500c-19b1-47ef-958f-ec720d37b4da','N',1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:43 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205991,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200265,213872,'N',10,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','102ced0f-3eb5-410d-b9dd-71c6907a7fed','Y','N',1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:44 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205992,'All Roles',200265,213873,'N',10,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','23489c6c-5400-4d8e-8aa9-bcf78530ca96','N',1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:44 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205993,'AD_AllRoles_V_UU',200265,213874,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fdb08ba6-9d1e-40ca-a6d5-ce5db7499c3c','N',1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:45 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205994,'All Clients',200265,213896,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d4677f91-9f71-4835-bccd-8f457bc2bb5c','Y',170,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:45 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205995,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200265,213880,'Y',60,20,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','925fdbcd-44a7-4d46-a41e-db0e3cb597f2','Y',10,1,5,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:45 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205996,'Description','Optional short description of the record','A description is limited to 255 characters.',200265,213881,'Y',255,30,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2a04a2de-042e-4585-813e-4aabc50129c8','Y',20,1,5,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:46 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205997,'User Level','System Client Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Client level data or Client and Organization level data.',200265,213882,'Y',3,40,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','714c217b-bd88-4c12-a9ec-00c894461ed8','Y',30,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:46 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205998,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Client, you can see the Record Info Change Log.',200265,213891,'Y',1,50,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cdefee35-3cea-469e-9594-0685cf75b81a','Y',120,4,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:47 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205999,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200265,213883,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','675e0f21-0809-43ca-8344-5a44945b357d','Y',40,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:47 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206000,'Master Role','A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200265,213893,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','98acaf86-5a57-463b-aab2-f056e9ad2422','Y',140,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:48 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206001,'Access all Orgs','Access all Organizations (no org access control) of the client','When selected, the role has access to all organizations of the client automatically. This also increases performance where you have many organizations.',200265,213889,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','27ff9105-9a83-44eb-a26f-285549d8e5a2','Y',100,4,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:48 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206002,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200265,213892,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1ebde255-4e9b-4d46-954a-6b96a4079dba','Y',130,5,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:48 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206003,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200265,213887,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0eab9076-773a-4f9a-bace-f10bb33fa0a4','Y',80,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:49 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206004,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200265,213888,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cfc2c735-a31a-4612-a612-a32d34779b95','Y',90,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:49 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206005,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200265,213884,'Y',1,120,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e561c26-0fe7-4fa8-bc1e-fea9eeb79fda','Y',50,4,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:50 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206006,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200265,213885,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6439ac5b-c014-4efc-8d16-7b11856c2858','Y',60,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:50 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206007,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200265,213886,'Y',1,140,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ee4189e8-6865-4836-8bcd-9b70c8e99fff','Y',70,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:51 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206008,'Access Advanced ',200265,213894,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','12a7cc3a-fd58-4184-b231-fe389d5171d6','Y',150,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:51 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206009,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200265,213890,'Y',1,160,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e4711226-ba9b-4007-9253-74a7da03d1a2','Y',110,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:51 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206010,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200265,213879,'Y',1,170,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','20dcf546-e39e-4039-9cfd-73fec1edd006','Y',180,4,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:19:52 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206011,'Role Type',200265,213895,'Y',2,180,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8d598163-aca4-4fea-8411-3eccc95900f0','Y',160,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:03 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200266,'User Roles',200108,20,'Y',200254,0,0,'Y',TO_DATE('2019-03-26 11:23:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',213897,'AD_AllRoles_V_ID, AD_AllClients_V_ID, Name','N','N',1,'N','D','Y','N','13043fff-ebde-4ebd-bbb6-bc2af55528f2','B')
;

-- Mar 26, 2019, 11:23:23 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206012,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200266,213826,'N',10,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c3c7b750-5392-41f7-bd2f-f91790e5e415','N',0,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:23 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206013,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200266,213827,'N',10,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4bf8bab9-4fcc-4110-8236-e8e04c650447','Y','N',1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:23 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206014,'AD_AllUserRoles_V_UU',200266,213835,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa1f020f-f423-4b41-a1a9-f4b77e66c49a','N',1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:24 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206015,'All Clients',200266,213829,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3800b50e-3696-484e-9480-0ae7a489fb17','Y',10,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:24 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206016,'All Users',200266,213828,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e503364d-b185-42a1-8369-e240e96f4328','N',0,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:25 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206017,'All Roles',200266,213897,'Y',10,30,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d7eab04a-efe1-401a-b07b-b87bf60f8c07','Y',190,4,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:25 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206018,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200266,213836,'Y',60,40,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','92c2e6b7-125a-4dd4-9e72-2a27def15d90','Y',20,1,5,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:26 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206019,'Description','Optional short description of the record','A description is limited to 255 characters.',200266,213837,'Y',255,50,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3e973146-49c8-43d3-bac2-87b48d9c9ca9','Y',30,1,5,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:26 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206020,'User Level','System Client Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Client level data or Client and Organization level data.',200266,213838,'Y',3,60,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','66cd0e58-4bc6-469e-b442-5af20df5ce21','Y',40,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:26 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206021,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Client, you can see the Record Info Change Log.',200266,213847,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','93add968-823f-49a3-8a4a-9b6b0bcd7a0e','Y',130,4,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:27 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206022,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200266,213839,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ff720243-3043-4513-adf0-b5d016ca573a','Y',50,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:27 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206023,'Master Role','A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200266,213849,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7cc77301-a9ff-44c5-bcf0-72ff65699915','Y',150,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:28 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206024,'Access all Orgs','Access all Organizations (no org access control) of the client','When selected, the role has access to all organizations of the client automatically. This also increases performance where you have many organizations.',200266,213845,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5e7a9f7b-2ca5-4a65-9448-bbfef92ba98a','Y',110,4,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:28 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206025,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200266,213848,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e3387a17-bca4-410b-8288-fd53d358dcf2','Y',140,5,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:29 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206026,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200266,213843,'Y',1,120,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ea024c6d-5607-4138-9f3f-7f0d486a9c67','Y',90,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:29 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206027,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200266,213844,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','22f1bb16-97e2-4a64-9988-793ede1178de','Y',100,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:29 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206028,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200266,213840,'Y',1,140,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ef69c7be-d816-4b38-8485-5d5823dbf970','Y',60,4,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:30 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206029,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200266,213841,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9421b926-7f64-4c12-b63e-e6c07531de8b','Y',70,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:31 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206030,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200266,213842,'Y',1,160,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','46b417e7-dec3-4ede-8903-de9d15afb694','Y',80,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:32 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206031,'Access Advanced ',200266,213850,'Y',1,170,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e8edb561-f556-4835-b5ff-585046c18abb','Y',160,2,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:32 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206032,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200266,213846,'Y',1,180,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fac89ba9-03c7-41a9-9096-988ccbde7abf','Y',120,3,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:33 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206033,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200266,213830,'Y',1,190,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','350cc865-9596-4d76-b81d-ced5a2531dcf','Y',170,4,1,1,'N','N','N')
;

-- Mar 26, 2019, 11:23:33 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206034,'Role Type',200266,213870,'Y',2,200,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-26 11:23:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 11:23:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e28f2dda-c903-4d08-b01f-48d7deddc269','Y',180,1,2,1,'N','N','N')
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206034
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206018
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206019
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206020
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206021
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206022
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206023
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206024
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206025
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206026
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206027
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206028
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206029
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206030
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206031
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206032
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206017
;

-- Mar 26, 2019, 11:26:59 AM BRT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206033
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206017
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206034
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206019
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206020
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206022
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206028
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206029
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206030
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206026
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206027
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206024
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206032
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206021
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206025
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206023
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206031
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206018
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206016
;

-- Mar 26, 2019, 11:27:31 AM BRT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206033
;

UPDATE ad_treenodemm SET ad_treenodemm_uu='42d88110-95ff-42fc-96eb-55b4bcd9a7ba' WHERE node_id=200165 AND ad_tree_id=10 AND ad_treenodemm_uu IS NULL;

SELECT register_migration_script('201903261128_IDEMPIERE-3439.sql') FROM dual
;

