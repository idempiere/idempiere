-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603261741_IDEMPIERE-6908.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 26, 2026, 5:41:27 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Disable',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:41:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:41:26','YYYY-MM-DD HH24:MI:SS'),100,200997,'Disable','D','019d2985-2df4-73bd-bedb-cdb90af6f157')
;

-- Mar 26, 2026, 5:41:39 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Enable',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:41:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:41:38','YYYY-MM-DD HH24:MI:SS'),100,200998,'Enable','D','019d2985-5df3-7188-997c-c70d0fd3dc36')
;

-- Mar 26, 2026, 5:41:56 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Download (.idext)',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:41:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:41:55','YYYY-MM-DD HH24:MI:SS'),100,200999,'ExtensionDownloadArchive','D','019d2985-9fe6-740b-9e14-a748ec2e5bbb')
;

-- Mar 26, 2026, 5:42:11 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Registry',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:42:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:42:10','YYYY-MM-DD HH24:MI:SS'),100,201000,'ExtensionRegistryButton','D','019d2985-db83-7d29-9dda-bff6d3872980')
;

-- Mar 26, 2026, 5:42:35 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Extension Repository',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:42:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:42:35','YYYY-MM-DD HH24:MI:SS'),100,201001,'ExtensionRepository','D','019d2986-3ab5-7952-a95f-5942456a6cf3')
;

-- Mar 26, 2026, 5:43:24 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Installed Extensions',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:43:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:43:24','YYYY-MM-DD HH24:MI:SS'),100,201002,'InstalledExtensions','D','019d2986-f9e7-7e48-9e40-036a231df49a')
;

-- Mar 26, 2026, 5:43:41 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Error loading extensions: {0}',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:43:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:43:40','YYYY-MM-DD HH24:MI:SS'),100,201003,'ErrorLoadingExtensions','D','019d2987-3a6d-7968-9ffa-6702d14b6c58')
;

-- Mar 26, 2026, 5:46:05 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No extensions installed',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:46:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:46:04','YYYY-MM-DD HH24:MI:SS'),100,201004,'NoExtensionsInstalled','D','019d2989-6c64-74a4-878a-a8bf1e965f0e')
;

-- Mar 26, 2026, 5:46:19 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Changelog',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:46:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:46:19','YYYY-MM-DD HH24:MI:SS'),100,201005,'ExtensionChangeLog','D','019d2989-a528-79f5-9c9e-a73f22a545d3')
;

-- Mar 26, 2026, 5:46:44 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Details',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:46:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:46:44','YYYY-MM-DD HH24:MI:SS'),100,201006,'ExtensionDetails','D','019d298a-0783-72df-bfa9-c693f9bd8c65')
;

-- Mar 26, 2026, 5:46:56 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Categories',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:46:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:46:56','YYYY-MM-DD HH24:MI:SS'),100,201007,'ExtensionCategories','D','019d298a-3654-73ba-abb8-ed02fcbf5e1d')
;

-- Mar 26, 2026, 5:47:08 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Tags',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:47:07','YYYY-MM-DD HH24:MI:SS'),100,201008,'ExtensionTags','D','019d298a-6254-7566-bb80-4f4d899b384b')
;

-- Mar 26, 2026, 5:47:23 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Bundled extensions cannot be uninstalled',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:47:22','YYYY-MM-DD HH24:MI:SS'),100,201009,'CannotUninstallBundledExtension','D','019d298a-9cbc-7bf9-8feb-af7eeae68d55')
;

-- Mar 26, 2026, 5:47:57 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','iDempiere extension repository URL is not set',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,201010,'ExtensionRepositoryNotSet','D','019d298b-2121-72ee-b66c-4dd06de3519a')
;

-- Mar 26, 2026, 5:48:09 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Http error ({0}) fetching {1}',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:48:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:48:09','YYYY-MM-DD HH24:MI:SS'),100,201011,'HttpFetchFailed','D','019d298b-528c-7854-834a-9af1faa32fb8')
;

-- Mar 26, 2026, 5:48:23 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Extension is already being installed',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:48:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:48:22','YYYY-MM-DD HH24:MI:SS'),100,201012,'ExtensionAlreadyInstalling','D','019d298b-878d-7181-b5c2-1cd69fb384b3')
;

-- Mar 26, 2026, 5:48:36 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','A newer version of bundle {0} ({1}) is already installed',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:48:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:48:36','YYYY-MM-DD HH24:MI:SS'),100,201013,'ExtensionBundleNewerVersionInstalled','D','019d298b-bcc5-7558-95c7-d2ac5a388ad7')
;

-- Mar 26, 2026, 5:48:49 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Database {0} not supported',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,201014,'DatabaseTypeNotSupported','D','019d298b-eec5-7c7a-a7f4-819164e1f1a5')
;

-- Mar 26, 2026, 5:49:03 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','{0} version {1} is too old, {2} and above is required',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:49:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:49:02','YYYY-MM-DD HH24:MI:SS'),100,201015,'DatabaseVersionTooOld','D','019d298c-24ce-7143-8608-6f7fc5197b08')
;

-- Mar 26, 2026, 5:49:16 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The required extension {0} is not found on this {1} server',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:49:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:49:15','YYYY-MM-DD HH24:MI:SS'),100,201016,'DatabaseExtensionNotFound','D','019d298c-5728-7139-bc66-e35a8c5259da')
;

-- Mar 26, 2026, 5:49:28 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No bundles found in metadata.json',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:49:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:49:27','YYYY-MM-DD HH24:MI:SS'),100,201017,'NoBundlesInExtensionMetadata','D','019d298c-8724-74e4-bba7-12dbeafcee8f')
;

-- Mar 26, 2026, 5:49:43 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Incompatible iDempiere version. Extension requires {0} and above but current version is {1}',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:49:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:49:42','YYYY-MM-DD HH24:MI:SS'),100,201018,'IncompatibleIDempiereVersion','D','019d298c-bf89-7d1d-9851-6a5f1f33ff5d')
;

-- Mar 26, 2026, 5:49:54 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Missing dependency: {0}. Please install it first',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:49:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:49:54','YYYY-MM-DD HH24:MI:SS'),100,201019,'MissingDependency','D','019d298c-ecc9-7fd6-a8c5-22c3a9b05627')
;

-- Mar 26, 2026, 5:50:06 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Incompatible dependency version: {0}. Required {1} and above but installed {2}',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:50:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:50:06','YYYY-MM-DD HH24:MI:SS'),100,201020,'IncompatibleDependencyVersion','D','019d298d-1b98-7748-8058-e822ff8be68e')
;

-- Mar 26, 2026, 5:50:20 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Bundle {0} is missing downloadUrl',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:50:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:50:20','YYYY-MM-DD HH24:MI:SS'),100,201021,'BundleNoDownloadURL','D','019d298d-524c-755c-afb1-dd0fb6b4e0f2')
;

-- Mar 26, 2026, 5:50:32 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Downloading bundle {0} from {1}',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:50:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:50:31','YYYY-MM-DD HH24:MI:SS'),100,201022,'DownloadingBundleFrom','D','019d298d-7ff0-74d9-b1ec-5f5d73427f4b')
;

-- Mar 26, 2026, 5:50:48 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','SHA256 hash mismatch for bundle {0}. Expected {1} but got {2}',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:50:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:50:47','YYYY-MM-DD HH24:MI:SS'),100,201023,'BundleSHA256HashNotMatch','D','019d298d-bebc-70e9-af7c-e50aac23c64c')
;

-- Mar 26, 2026, 5:51:01 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Extension install successfully',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:51:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:51:00','YYYY-MM-DD HH24:MI:SS'),100,201024,'ExtensionInstallSuccessfully','D','019d298d-f058-7610-8afc-e947e1407dec')
;

-- Mar 26, 2026, 5:51:12 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','OSGi BundleContext is not available',0,0,'Y',TO_TIMESTAMP('2026-03-26 17:51:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-26 17:51:12','YYYY-MM-DD HH24:MI:SS'),100,201025,'BundleContextNotFound','D','019d298e-1e64-71b6-bb6f-7c9f2898537e')
;

