-- IDEMPIERE-5083 add FREIGHTCOSTRULE_CustomerAccount
SELECT register_migration_script('202203211620_IDEMPIERE-5083.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 21, 2022, 4:20:33 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200528,'Customer Account','Charge to receiver/customer shipper account',153,'U',0,0,'Y',TO_TIMESTAMP('2022-03-21 16:20:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-21 16:20:32','YYYY-MM-DD HH24:MI:SS'),100,'D','7ed34a5f-ffe5-499e-afd0-f074cca9d1f6')
;

