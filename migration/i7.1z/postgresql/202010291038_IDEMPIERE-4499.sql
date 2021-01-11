-- IDEMPIERE-4499 zk9.5 - Popup menu disappear quickly for buttons on the More area
-- Oct 29, 2020, 10:37:46 AM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200164,0,0,TO_TIMESTAMP('2020-10-29 10:37:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2020-10-29 10:37:46','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_TOOLBAR_SHOW_MORE_VERTICAL','Y','The extended toolbar for the "Show More" buttons is shown vertical (Y) - or as horizontal extension (N)','D','C','24aeedc0-24c7-4794-9062-0d0d1631d025')
;

SELECT register_migration_script('202010291038_IDEMPIERE-4499.sql') FROM dual
;

