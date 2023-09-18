-- Sep 17, 2023, 12:25:48 PM WIB
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200234,0,0,TO_TIMESTAMP('2023-09-17 12:25:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-09-17 12:25:47','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','UPLOAD_TEMP_FILENAME_PREFIX','idempiere_','Prefix temporary filename for uploaded media','D','C','ecc709a7-8c32-4637-861f-9606a9de9751')
;

-- IDEMPIERE-4697
SELECT register_migration_script('202309171225_IDEMPIERE-4697.sql') FROM dual;
