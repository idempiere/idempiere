SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 12, 2020, 11:36:58 AM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200159,0,0,TO_DATE('2020-10-12 11:36:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2020-10-12 11:36:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_MOBILE_EDITABLE','N','Mobile setting for AD Window Grid View. Y - Grid is editable. N - Grid is read only, must use form view to make changes.','D','S','f70a852c-84df-4de3-82c0-bdc7efda12ef')
;

-- Oct 12, 2020, 1:22:51 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200160,0,0,TO_DATE('2020-10-12 13:22:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2020-10-12 13:22:50','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_MOBILE_LINE_BREAK_AS_IDENTIFIER_SEPARATOR','Y','Mobile setting for AD Window Grid View. Y - Replace identifier separator with line break. N - Use the configured identifier separator','D','S','31b780c9-4789-4feb-9f1a-35a87be34c73')
;

-- Oct 12, 2020, 2:41:17 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200161,0,0,TO_DATE('2020-10-12 14:41:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2020-10-12 14:41:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_MOBILE_SHOW_CURRENT_ROW_INDICATOR','N','Mobile setting for AD Window Grid View. Y - add a column to display the current row indicator. N - no column created for current row indicator','D','S','aacc9992-7296-4d0d-b74b-c38f8e0f5a4d')
;

SELECT register_migration_script('202010121700_IDEMPIERE-4482.sql') FROM dual
;

