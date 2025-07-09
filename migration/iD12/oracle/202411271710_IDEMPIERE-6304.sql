SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-6304   Multiple SSO provider support
-- Nov 27, 2024, 5:10:57 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203964,0,0,'Y',TO_DATE('2024-11-27 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-11-27 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,'SSO_LoginButtonImage_ID','Login Button Image','Identifier for the image used as the icon for the Single Sign-On (SSO) login button. References the AD_Image table.','Login Button Image','D','8630c585-0b23-49e6-a83b-3bad6766ed9e')
;

-- Nov 27, 2024, 5:14:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216922,0,'Login Button Image','Identifier for the image used as the icon for the Single Sign-On (SSO) login button. References the AD_Image table.',200360,'SSO_LoginButtonImage_ID',22,'N','N','N','N','N',0,'N',18,200182,0,0,'Y',TO_DATE('2024-11-27 17:14:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-11-27 17:14:09','YYYY-MM-DD HH24:MI:SS'),100,203964,'Y','N','D','N','N','N','Y','db5d3fd1-3476-4136-ae84-45a2b18fa56f','Y',0,'N','N','N','N')
;

-- Nov 27, 2024, 5:14:11 PM IST
UPDATE AD_Column SET FKConstraintName='SSOLoginButtonImage_SSOPrincip', FKConstraintType='N',Updated=TO_DATE('2024-11-27 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216922
;

-- Nov 27, 2024, 5:14:11 PM IST
ALTER TABLE SSO_PrincipalConfig ADD SSO_LoginButtonImage_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2024, 5:14:11 PM IST
ALTER TABLE SSO_PrincipalConfig ADD CONSTRAINT SSOLoginButtonImage_SSOPrincip FOREIGN KEY (SSO_LoginButtonImage_ID) REFERENCES ad_image(ad_image_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2024, 5:14:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208545,'Login Button Image','Identifier for the image used as the icon for the Single Sign-On (SSO) login button. References the AD_Image table.',200328,216922,'Y',22,150,'N','N','N','N',0,0,'Y',TO_DATE('2024-11-27 17:14:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-11-27 17:14:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3c359757-a49c-4c65-9bbb-5c50cc2dc09b','Y',150,2)
;

-- Nov 27, 2024, 5:19:51 PM IST
UPDATE AD_Column SET Description='Indicates whether this SSO configuration is set as the default for logging in to the iDempiere Monitor and Felix Web Console.', Help='When IsDefault is set to Y, this SSO configuration will be used for logging in to the iDempiere Monitor and Felix Web Console.',Updated=TO_DATE('2024-11-27 17:19:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215303
;

-- 09-Apr-2025, 3:26:56 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200262,0,0,TO_DATE('2025-04-09 15:26:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2025-04-09 15:26:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','SSO_SHOW_LOGINPAGE','N','Allows users to access the standard login page alongside SSO, enabling manual login even when SSO is configured.','D','S','be343ea6-d422-4603-8b61-04bf18236797')
;

-- Jun 16, 2025, 5:47:35 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','SSO Principal Service could not be retrieved for the specified provider. Please verify the SSO provider configuration.',0,0,'Y',TO_TIMESTAMP('2025-06-16 17:47:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-16 17:47:34','YYYY-MM-DD HH24:MI:SS'),100,200945,'SSOServiceNotFound','D','bd5f5401-a53d-40da-b785-5160d352dab1')
;

SELECT register_migration_script('202411271710_IDEMPIERE-6304.sql') FROM dual
;