-- IDEMPIERE-5706 Improvements to Tab Editor in Window Customization
SELECT register_migration_script('202305011505_IDEMPIERE-5706.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 1, 2023, 3:05:28 PM CEST
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200031,0,0,'Y',TO_TIMESTAMP('2023-05-01 15:05:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-01 15:05:27','YYYY-MM-DD HH24:MI:SS'),100,'( None )','D','N','b447882e-593a-4e5e-9491-a499e2edf11b')
;

-- May 1, 2023, 3:12:43 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200636,'Do Nothing',53000,'D',0,0,'Y',TO_TIMESTAMP('2023-05-01 15:12:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-01 15:12:43','YYYY-MM-DD HH24:MI:SS'),100,'D','5621157f-37ae-4134-95b2-65a957b258a7')
;

-- May 1, 2023, 3:26:21 PM CEST
UPDATE AD_FieldGroup SET FieldGroupType='D',Updated=TO_TIMESTAMP('2023-05-01 15:26:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_FieldGroup_ID=200031
;

