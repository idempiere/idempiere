-- IDEMPIERE-4297 Improve test data - not advanced role
-- May 19, 2020, 11:25:16 AM CEST
INSERT INTO AD_Role (AD_Role_ID,Name,Description,UserLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Currency_ID,AmtApproval,IsManual,IsPersonalAccess,IsShowAcct,IsPersonalLock,IsCanReport,IsCanExport,IsCanApproveOwnDoc,IsAccessAllOrgs,IsChangeLog,PreferenceType,OverwritePriceLimit,IsUseUserOrgAccess,ConfirmQueryRecords,MaxQueryRecords,Allow_Info_Account,Allow_Info_Asset,Allow_Info_BPartner,Allow_Info_InOut,Allow_Info_Invoice,Allow_Info_Order,Allow_Info_Payment,Allow_Info_Product,Allow_Info_Resource,Allow_Info_Schedule,AD_Role_UU,IsMenuAutoExpand,IsMasterRole,IsAccessAdvanced) VALUES (200001,'GardenWorld Admin Not Advanced','GardenWorld Admin Not Advanced',' CO',11,0,'Y',TO_TIMESTAMP('2020-05-19 11:25:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-05-19 11:25:15','YYYY-MM-DD HH24:MI:SS'),100,100,500,'N','N','Y','N','Y','Y','Y','Y','N','C','N','N',0,0,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','59cf270b-d74a-4cea-a8f7-ff2fd838a8f9','N','N','Y')
;

-- May 19, 2020, 11:25:16 AM CEST
INSERT INTO AD_User_Roles (AD_Role_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_User_ID,AD_Client_ID,AD_Org_ID,AD_User_Roles_UU) VALUES (200001,'Y',TO_TIMESTAMP('2020-05-19 11:25:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-05-19 11:25:16','YYYY-MM-DD HH24:MI:SS'),100,100,11,0,'f0638aee-6960-4d5e-ae10-947fb24ca5a3')
;

-- May 19, 2020, 11:25:29 AM CEST
INSERT INTO AD_User_Roles (AD_Role_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_User_ID,AD_Client_ID,AD_Org_ID,AD_User_Roles_UU) VALUES (200001,'Y',TO_TIMESTAMP('2020-05-19 11:25:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-05-19 11:25:29','YYYY-MM-DD HH24:MI:SS'),100,101,11,0,'3708c068-968b-44dc-9398-d2a2ce659c2f')
;

-- May 19, 2020, 11:26:32 AM CEST
UPDATE AD_Role SET IsPersonalLock='Y', OverwritePriceLimit='Y',Updated=TO_TIMESTAMP('2020-05-19 11:26:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Role_ID=102
;

SELECT register_migration_script('202005191128_IDEMPIERE-4297_NotAdvancedRole.sql') FROM dual
;

