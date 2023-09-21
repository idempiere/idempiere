-- IDEMPIERE-5346 SSO Support
SELECT register_migration_script('202307111656_IDEMPIERE-5346.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 11, 2023, 4:56:08 PM IST
UPDATE AD_Table SET TableName='SSO_PrincipalConfig',Updated=TO_TIMESTAMP('2023-07-11 16:56:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200360
;

-- Jul 11, 2023, 4:56:09 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('SSO_PrincipalConfig',1000000,'N','N','Table SSO_PrincipalConfig','Y','Y',0,0,TO_TIMESTAMP('2023-07-11 16:56:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-07-11 16:56:08','YYYY-MM-DD HH24:MI:SS'),100,200458,'Y',1000000,1,200000,'0a3c92f4-feb8-40aa-9c08-2c91a2fc1aad')
;

-- Jul 12, 2023, 10:12:14 AM IST
UPDATE AD_Element SET ColumnName='SSO_PrincipalConfig_ID',Updated=TO_TIMESTAMP('2023-07-12 10:12:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203653
;

-- Jul 12, 2023, 10:12:14 AM IST
UPDATE AD_Column SET ColumnName='SSO_PrincipalConfig_ID', Name='SSO Configuration', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203653
;

-- Jul 12, 2023, 10:12:14 AM IST
UPDATE AD_Process_Para SET ColumnName='SSO_PrincipalConfig_ID', Name='SSO Configuration', Description=NULL, Help=NULL, AD_Element_ID=203653 WHERE UPPER(ColumnName)='SSO_PRINCIPALCONFIG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jul 12, 2023, 10:12:14 AM IST
UPDATE AD_Process_Para SET ColumnName='SSO_PrincipalConfig_ID', Name='SSO Configuration', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203653 AND IsCentrallyMaintained='Y'
;

-- Jul 12, 2023, 10:12:14 AM IST
UPDATE AD_InfoColumn SET ColumnName='SSO_PrincipalConfig_ID', Name='SSO Configuration', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203653 AND IsCentrallyMaintained='Y'
;

-- Jul 12, 2023, 10:12:33 AM IST
UPDATE AD_Element SET ColumnName='SSO_PrincipalConfig_UU',Updated=TO_TIMESTAMP('2023-07-12 10:12:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203654
;

-- Jul 12, 2023, 10:12:33 AM IST
UPDATE AD_Column SET ColumnName='SSO_PrincipalConfig_UU', Name='SSO Configuration UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203654
;

-- Jul 12, 2023, 10:12:33 AM IST
UPDATE AD_Process_Para SET ColumnName='SSO_PrincipalConfig_UU', Name='SSO Configuration UU', Description=NULL, Help=NULL, AD_Element_ID=203654 WHERE UPPER(ColumnName)='SSO_PRINCIPALCONFIG_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jul 12, 2023, 10:12:33 AM IST
UPDATE AD_Process_Para SET ColumnName='SSO_PrincipalConfig_UU', Name='SSO Configuration UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203654 AND IsCentrallyMaintained='Y'
;

-- Jul 12, 2023, 10:12:33 AM IST
UPDATE AD_InfoColumn SET ColumnName='SSO_PrincipalConfig_UU', Name='SSO Configuration UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203654 AND IsCentrallyMaintained='Y'
;

ALTER TABLE SSO_PrincipleConfig RENAME TO SSO_PrincipalConfig;

ALTER TABLE SSO_PrincipalConfig RENAME COLUMN SSO_PrincipleConfig_ID TO SSO_PrincipalConfig_ID;

ALTER TABLE SSO_PrincipalConfig RENAME COLUMN SSO_PrincipleConfig_UU TO SSO_PrincipalConfig_UU;

ALTER TABLE sso_principalconfig RENAME CONSTRAINT sso_principleconfig_key TO sso_principalconfig_key;

ALTER TABLE sso_principalconfig RENAME CONSTRAINT sso_principleconfig_uu_idx TO sso_principalconfig_uu_idx;

-- constraint names have random name in oracle
-- ALTER TABLE sso_principalconfig RENAME CONSTRAINT sso_principleconfig_isactive_check TO sso_principalconfig_isactive_check;
-- ALTER TABLE sso_principalconfig RENAME CONSTRAINT sso_principleconfig_isdefault_check TO sso_principalconfig_isdefault_check;
