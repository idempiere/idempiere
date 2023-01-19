-- IDEMPIERE-5534 Make configurable the maximum records in lists
SELECT register_migration_script('202301062010_IDEMPIERE-5534.sql') FROM dual;

-- Jan 6, 2023, 8:10:55 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200215,0,0,TO_TIMESTAMP('2023-01-06 20:10:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-01-06 20:10:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAX_ROWS_IN_TABLE_COMBOLIST','10000','Maximum number of records in lists (records in Table/TableDirect). WARNING: increasing this value affects heavily performance and memory, use it wisely. Max possible value is 50,000','D','C','051dafef-b66e-40ec-8a88-215aeb6c0355')
;

