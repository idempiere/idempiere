-- IDEMPIERE-6502 Mobile UI enhancements
SELECT register_migration_script('202504192020_IDEMPIERE-6502.sql') FROM dual;

-- Apr 19, 2025, 8:20:37 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200263,0,0,TO_TIMESTAMP('2025-04-19 20:20:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-19 20:20:36','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_MOBILE_AUTO_HIDE_EMPTY_COLUMNS','Y','Mobile setting for AD Window Grid View. Y/N - Auto hide column with empty content','D','C','48242fa8-248e-473b-823d-a6286c44cf2e')
;

-- Apr 19, 2025, 8:21:51 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200264,0,0,TO_TIMESTAMP('2025-04-19 20:21:50','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-19 20:21:50','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_INFO_MOBILE_AUTO_COLLAPSED_PARAMETER_PANEL','Y','Mobile setting for info window. Y/N. When Set to Y,  Info Window will auto collaped parameter panel after query execution return one or more records.','D','C','cf80607f-59e7-4fe6-ba9c-77b119cbc4bc')
;

-- Apr 19, 2025, 8:22:38 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200265,0,0,TO_TIMESTAMP('2025-04-19 20:22:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-19 20:22:37','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_INFO_MOBILE_AUTO_HIDE_EMPTY_COLUMNS','Y','Mobile setting for info window. Y/N - Define if info window will auto hide columns with empty content','D','C','0779818b-7672-498c-adca-888fa1731baf')
;

-- Apr 19, 2025, 8:29:01 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200267,0,0,TO_TIMESTAMP('2025-04-19 20:29:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-19 20:29:00','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_FIELD_LABEL_ABOVE_INPUT','N','Y/N - Define that label of AD window field is positioned above the input field instead of to the left.','D','C','6c4513dc-1ce3-459c-83e1-ef37d5b712b8')
;

-- Apr 19, 2025, 8:32:28 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200269,0,0,TO_TIMESTAMP('2025-04-19 20:32:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-19 20:32:27','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_FIELD_MOBILE_LABEL_ABOVE_INPUT','N','Mobile setting for AD window form view. Y/N - Define that label of AD window field is positioned above the input field instead of to the left.','D','C','2fdfcd6e-6bbd-4c9d-aa6f-fc3fcf232a60')
;

-- Apr 19, 2025, 8:33:57 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200270,0,0,TO_TIMESTAMP('2025-04-19 20:33:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-19 20:33:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_FIELD_MOBILE_SMALL_WIDTH_LABEL_ABOVE_INPUT','Y','Mobile setting for AD window form view (For width < 500px). Y/N - Define that label of AD window field is positioned above the input field instead of to the left.','D','C','b8b48288-1105-4606-8afd-900aca9a729f')
;

