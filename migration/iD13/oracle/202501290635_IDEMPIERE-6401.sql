-- IDEMPIERE-6401
SELECT register_migration_script('202501290635_IDEMPIERE-6401.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 29, 2025, 6:35:53 AM WIB
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200258,0,0,TO_TIMESTAMP('2025-01-29 06:35:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-01-29 06:35:52','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','DEMO_URL_PREFIX','test','url prefix to identify for demo purpose. ex. test.idempiere.org','D','S','0aa3b0e1-daca-4455-a9cd-89e9c7eae067')
;

