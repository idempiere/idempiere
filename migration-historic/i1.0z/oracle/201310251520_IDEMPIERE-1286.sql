SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 25, 2013 3:18:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Created,Updated,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200038,'S','N','070c9a65-7c15-4ed5-9239-d47902a78ca4',TO_DATE('2013-10-25 15:18:26','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-10-25 15:18:26','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'ADDRESS_SAVE_REQUEST_RESPONSE_LOG',0,'D')
;

SELECT register_migration_script('201310251520_IDEMPIERE-1286.sql') FROM dual
;