-- IDEMPIERE-6843 Security Dashboard
SELECT register_migration_script('202602092343_IDEMPIERE-6843.sql') FROM dual;

-- Feb 9, 2026, 11:43:15 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200296,0,0,TO_TIMESTAMP('2026-02-09 23:43:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-02-09 23:43:15','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','SECURITY_DASHBOARD_LEGACY_KEY_WARNING','Y','Show warning in security dashboard when legacy key detected.  (D) -> Disable, (Y) -> detected legacy key, (N) not detected','D','S','019c4492-c534-7b35-8752-7b6f8539e842')
;

-- Feb 10, 2026, 12:27:11 AM CET
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,FieldGroupType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200033,0,0,'Y',TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,'Security Checklist','D','C','N','019c3887-b33a-73b3-a1fa-22bdd5821890')
;

-- Feb 10, 2026, 12:27:11 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,Name_PrintColorZero_ID,AD_FieldGroup_ID,AD_Process_ID) VALUES (200006,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,'Hashed Passwords','Hashed passwords are not configured','Y',20,102,102,50009,'AD_Client_ID=0 AND Name=''USER_PASSWORD_HASH'' AND Value!=''Y''','019c3887-eeb3-75b3-920f-e2f7c248c693','D','Y','Plain (or even encrypted) passwords are insecure.  Run the process "Convert passwords to hashes" for a safer approach.',103,200033,53259)
;

-- Feb 10, 2026, 12:27:11 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200000,0,0,TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,'019c3888-081e-799f-895c-4dae0105893c',0,200006)
;

-- Feb 10, 2026, 12:27:12 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,Name_PrintColorZero_ID,AD_FieldGroup_ID) VALUES (200007,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:11','YYYY-MM-DD HH24:MI:SS'),100,'Default Passwords','Users with default passwords','Y',10,102,102,200224,'(Password=''System'' OR Password=Name OR (Password IS NOT NULL AND DatePasswordChanged IS NULL))',200093,'019c388a-4044-75c0-be66-4a95f295efd5','D','Y','There are users with default passwords, navigate to the corresponding user in the tenant and assign a safest password.',103,200033)
;

-- Feb 10, 2026, 12:27:12 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200001,0,0,TO_TIMESTAMP('2026-02-10 00:27:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:12','YYYY-MM-DD HH24:MI:SS'),100,'019c388a-56aa-7f9d-bfa4-6a3190d20400',0,200007)
;

-- Feb 10, 2026, 12:27:12 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,Name_PrintColorZero_ID,AD_FieldGroup_ID) VALUES (200008,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:12','YYYY-MM-DD HH24:MI:SS'),100,'System Status','System Status Evaluation','Y',60,102,102,531,'SystemStatus=''E''',246,'019c3f03-e252-7d92-a72c-3d46721b24e9','D','Y','When System Status remains in Evaluation some critical information can be disclosed in the login page.
Consider changing the System Status to Implementation or Production and also setting the SysConfig values for:
APPLICATION_MAIN_VERSION_SHOWN
APPLICATION_DATABASE_VERSION_SHOWN
APPLICATION_IMPLEMENTATION_VENDOR_SHOWN
APPLICATION_JVM_VERSION_SHOWN
APPLICATION_OS_INFO_SHOWN
APPLICATION_HOST_SHOWN',103,200033)
;

-- Feb 10, 2026, 12:27:13 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200002,0,0,TO_TIMESTAMP('2026-02-10 00:27:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:12','YYYY-MM-DD HH24:MI:SS'),100,'019c44b7-f71f-770d-b98c-308a082fa67d',0,200008)
;

-- Feb 10, 2026, 12:27:13 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,Name_PrintColorZero_ID,AD_FieldGroup_ID) VALUES (200009,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:13','YYYY-MM-DD HH24:MI:SS'),100,'Password Rules','Password rules are not configured','Y',30,102,102,112,'AD_Client_ID=0 AND AD_PasswordRule_ID IS NULL',109,'019c3ee7-bce4-752a-bedb-1a4ea2e9b933','D','Y','Password rules are recommended to enforce users to choose a good password, consider configuring a password rule and assigning it to Tenant',103,200033)
;

-- Feb 10, 2026, 12:27:13 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200003,0,0,TO_TIMESTAMP('2026-02-10 00:27:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:13','YYYY-MM-DD HH24:MI:SS'),100,'019c3ee8-a60e-72f3-9f5c-d1601cd1bda6',0,200009)
;

-- Feb 10, 2026, 12:27:14 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,Name_PrintColorZero_ID,AD_FieldGroup_ID) VALUES (200010,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:13','YYYY-MM-DD HH24:MI:SS'),100,'Users without MFA','Users with Multifactor Authentication','Y',40,102,102,200224,'IsActive=''Y'' AND Password IS NOT NULL AND NOT EXISTS (SELECT 1 FROM MFA_Registration r WHERE r.IsActive=''Y'' AND r.AD_User_ID=AD_AllUsers_V.AD_AllUsers_V_ID AND r.IsValid=''Y'')',200093,'019c3ef1-8853-742f-8abd-74dcd5d17fdb','D','Y','There are users without multi-factor authentication configured.  Consider advising these users to enable and configure MFA.',103,200033)
;

-- Feb 10, 2026, 12:27:14 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200004,0,0,TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,'019c44b7-d504-712f-8824-1758f36ac508',0,200010)
;

-- Feb 10, 2026, 12:27:14 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,AD_FieldGroup_ID) VALUES (200011,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,'Root Folder Browser','ZK_ROOT_FOLDER_BROWSER not configured','Y',70,102,102,531,'NOT EXISTS (SELECT 1 FROM AD_SysConfig WHERE AD_Client_ID=0 AND Name=''ZK_ROOT_FOLDER_BROWSER'' AND IsActive=''Y'')','019c3f13-fa8f-77bf-a573-29649d30b9a9','D','Y','The System Configurator ZK_ROOT_FOLDER_BROWSER is used to define which folder is navigated when using a Folder field/parameter type.  By default it navigates to IDEMPIERE_HOME, for security reasons you could consider configuring a different folder, for example to avoid reading the log files or plugins.  See https://wiki.idempiere.org/en/Securing_iDempiere#ZK_ROOT_FOLDER_BROWSER',200033)
;

-- Feb 10, 2026, 12:27:14 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200005,0,0,TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,'019c44b8-0904-7064-a5d4-28d068279af5',0,200011)
;

-- Feb 10, 2026, 12:27:15 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,AD_FieldGroup_ID) VALUES (200012,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:14','YYYY-MM-DD HH24:MI:SS'),100,'Advanced Roles','Advanced Roles assigned to Users','Y',80,102,102,200255,'IsAccessAdvanced=''Y''
AND AD_AllClients_V_ID>0
AND (SELECT COUNT(*) FROM AD_User_Roles ur JOIN AD_User u ON (u.AD_User_ID=ur.AD_User_ID AND u.IsActive=''Y'' AND u.AD_User_ID!=100) WHERE ur.AD_Role_ID=AD_AllRoles_V.AD_AllRoles_V_ID AND ur.IsActive=''Y'')>1
',200108,'019c3f4f-e130-76ea-958a-3cbe24d745e4','D','Y','Be careful about which advanced roles are assigned to which users.  You must consider advanced roles as SuperUser , they have access to all security holes.  Also you must consider SuperUser as if it has access to the operating system user used to install iDempiere on the server.  In other words, the advanced roles have access to iDempiere features that can be easily exploited to gain access to SuperUser in the application, to the database as a DBA, and to the operating system as the user that run iDempiere server. ',200033)
;

-- Feb 10, 2026, 12:27:15 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200006,0,0,TO_TIMESTAMP('2026-02-10 00:27:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:15','YYYY-MM-DD HH24:MI:SS'),100,'019c44b8-1f53-7adf-93d8-f3d701ef3086',0,200012)
;

-- Feb 10, 2026, 12:27:15 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,Name_PrintColorZero_ID,AD_FieldGroup_ID) VALUES (200013,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:15','YYYY-MM-DD HH24:MI:SS'),100,'User Locking','User locking not configured','Y',50,102,102,50009,'AD_Client_ID=0 AND Name IN (
''USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES'',
''USER_LOCKING_MAX_INACTIVE_PERIOD_DAY'',
''USER_LOCKING_MAX_LOGIN_ATTEMPT'',
''USER_LOCKING_MAX_PASSWORD_AGE_DAY''
)
AND Value=''0''',50006,'019c3ef6-35f9-72bd-8739-271f7fefd641','D','Y','Consider configuring user locking mechanisms.',103,200033)
;

-- Feb 10, 2026, 12:27:16 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200007,0,0,TO_TIMESTAMP('2026-02-10 00:27:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:15','YYYY-MM-DD HH24:MI:SS'),100,'019c44b7-e746-7f3d-b473-9bec79ef8bf5',0,200013)
;

-- Feb 10, 2026, 12:27:16 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,AD_FieldGroup_ID) VALUES (200014,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:16','YYYY-MM-DD HH24:MI:SS'),100,'Unencrypted Sensitive','Sensitive columns not encrypted','Y',100,102,102,101,'ColumnName LIKE ''%Password'' AND AD_Reference_ID=10 AND IsActive=''Y'' AND AD_Column_ID!=417
','019c3f57-67a3-7e6b-8a62-86adfab6ecc3','D','Y','There can be sensitive columns not encrypted.  Consider encrypting all columns containing passwords, credit cards and any sensitive information.',200033)
;

-- Feb 10, 2026, 12:27:16 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200008,0,0,TO_TIMESTAMP('2026-02-10 00:27:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:16','YYYY-MM-DD HH24:MI:SS'),100,'019c44b8-3393-7e76-a9f2-79904cf998f3',0,200014)
;

-- Feb 10, 2026, 12:27:17 AM CET
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsActive,SeqNo,Name_PrintColor_ID,Number_PrintColor_ID,AD_Table_ID,WhereClause,PA_DocumentStatus_UU,EntityType,IsHideWhenZero,Help,AD_FieldGroup_ID) VALUES (200015,0,0,0,100,TO_TIMESTAMP('2026-02-10 00:27:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 00:27:16','YYYY-MM-DD HH24:MI:SS'),100,'Legacy Encryption key','Legacy Encryption key detected','Y',90,102,102,50009,'AD_Client_ID=0 AND Name=''SECURITY_DASHBOARD_LEGACY_KEY_WARNING'' AND Value=''Y''','019c4498-8516-7e0e-b699-0a53507a294c','D','Y','Encryption with legacy key algorithm DES detected - it is recommended to migrate to a stronger algorithm.

<br><br>
<b>WARNING!</b> Before changing the algorithm, note that if you already have encrypted data in your database, changing the key will render all the encrypted information unreadable. First, decrypt all encrypted columns, then apply the new encryption key and re-encrypt the columns.

<br>
This can be done simply by adding the file idempiere-ks.properties in your IDEMPIERE_HOME folder with the following content:
<pre>
algorithm=AES
password=mySecurePassword
</pre>

You can use AES or another supported algorithm and change mySecurePassword for a password of your choice.  Please save this password carefully; if you lose it, you will also lose access to all your encrypted data.',200033)
;

-- Feb 10, 2026, 12:27:17 AM CET
INSERT INTO PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatusAccess_UU,AD_Role_ID,PA_DocumentStatus_ID) VALUES (200009,0,0,TO_TIMESTAMP('2026-02-10 00:27:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2026-02-10 00:27:17','YYYY-MM-DD HH24:MI:SS'),100,'019c44b7-745c-7646-9b0e-fcd52d7c8d47',0,200015)
;

-- Feb 10, 2026, 11:58:34 AM CET
UPDATE PA_DocumentStatus SET Description='Users with default passwords have been found', AD_Form_ID=NULL, Help='To prevent unauthorized access, locate the affected users within the tenant and assign them strong, unique passwords.', AD_Process_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 11:58:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200007
;

-- Feb 10, 2026, 12:02:22 PM CET
UPDATE PA_DocumentStatus SET Name='Passwords are not hashed', Description='Password hashing is not enabled', AD_Window_ID=NULL, AD_Form_ID=NULL, Help='Storing passwords in plain text or using reversible encryption is insecure. We recommend running the ''Convert password to hashes'' process to implement a one-way hashing algorithm instead.', AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 12:02:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200006
;

-- Feb 10, 2026, 12:03:58 PM CET
UPDATE PA_DocumentStatus SET Name='No password policy', Description='No password policy is configured', AD_Form_ID=NULL, Help='We recommend setting up password rules to ensure that users create strong and secure passwords. Once configured, make sure that the policy is assigned to the relevant tenant.', AD_Process_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 12:03:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200009
;

-- Feb 10, 2026, 12:05:04 PM CET
UPDATE PA_DocumentStatus SET Description='Users without Multifactor Authentication', AD_Form_ID=NULL, AD_Process_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 12:05:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200010
;

-- Feb 10, 2026, 12:05:47 PM CET
UPDATE PA_DocumentStatus SET Name='No User Locking', Description='User locking is not configured', AD_Form_ID=NULL, Help='Consider configuring a user locking mechanism.', AD_Process_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 12:05:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200013
;

-- Feb 10, 2026, 12:07:31 PM CET
UPDATE PA_DocumentStatus SET AD_Form_ID=NULL, Help='When System Status remains in Evaluation some critical information may be disclosed on the login page.
Consider changing the System Status to ''Implementation'' or ''Production'' and also setting the SysConfig values for:
APPLICATION_MAIN_VERSION_SHOWN
APPLICATION_DATABASE_VERSION_SHOWN
APPLICATION_IMPLEMENTATION_VENDOR_SHOWN
APPLICATION_JVM_VERSION_SHOWN
APPLICATION_OS_INFO_SHOWN
APPLICATION_HOST_SHOWN', AD_Process_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 12:07:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200008
;

-- Feb 10, 2026, 12:09:45 PM CET
UPDATE PA_DocumentStatus SET Name='Default Root Folder Browser', Description='The SysConfig ZK_ROOT_FOLDER_BROWSER has not been configured', Help='The System Configurator specifies the base directory for ''Folder'' fields and parameters. It currently defaults to IDEMPIERE_HOME. For enhanced security and to prevent unauthorized access to sensitive system files, such as logs or plugin binaries, we recommend setting a more restricted directory.',Updated=TO_TIMESTAMP('2026-02-10 12:09:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200011
;

-- Feb 10, 2026, 12:11:27 PM CET
UPDATE PA_DocumentStatus SET AD_Form_ID=NULL, Help='Be careful about which advanced roles you assign to which users.  Consider advanced roles as SuperUser; they have access to all security vulnerabilities.  You must also consider the SuperUser role as having access to the operating system user that was used to install iDempiere on the server.  In other words, advanced roles provide access to iDempiere features that can easily be exploited to gain access to SuperUser in the application, the database as a DBA and the operating system as the user running the iDempiere server.', AD_Process_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 12:11:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200012
;

-- Feb 10, 2026, 12:13:43 PM CET
UPDATE PA_DocumentStatus SET Help='Legacy key algorithm DES encryption detected – migration to a stronger algorithm is recommended.

<br><br>
<b>WARNING!</b> Before changing the algorithm, please note that if you already have encrypted data in your database, changing the key will render all the encrypted information unreadable. First, decrypt all encrypted columns, then apply the new encryption key and re-encrypt the columns.

<br>
This can be done simply by adding the file ''idempiere-ks.properties'' to your ''IDEMPIERE_HOME'' folder with the following content:
<pre>
algorithm=AES
password=mySecurePassword
</pre>

You can use AES or another supported algorithm and replace ''mySecurePassword'' with a password of your choice.  Please save this password carefully, as if you lose it, you will also lose access to all your encrypted data.',Updated=TO_TIMESTAMP('2026-02-10 12:13:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200015
;

-- Feb 10, 2026, 12:14:38 PM CET
UPDATE PA_DocumentStatus SET Name='Unencrypted sensitive data', Help='We have detected columns containing sensitive data that lack encryption. Make sure that all fields storing passwords, credit card numbers or other sensitive business data are properly encrypted.',Updated=TO_TIMESTAMP('2026-02-10 12:14:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200014
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_FieldGroup_ID=NULL, XPosition=1,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200096
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3813
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5887
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200594
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200595
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5161
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5162
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5163
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5164
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12098
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11024
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54238
;

-- Feb 10, 2026, 12:20:12 PM CET
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-02-10 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54680
;

-- Feb 10, 2026, 12:20:46 PM CET
UPDATE PA_DocumentStatus SET AD_Form_ID=NULL, Help='We recommend setting up password rules to ensure that users create strong and secure passwords. Once configured, make sure that the policy is assigned to the System tenant.', AD_Process_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2026-02-10 12:20:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200009
;

