-- IDEMPIERE-5213 Flat view improvement for menu tree
SELECT register_migration_script('202203022014_IDEMPIERE-5213.sql') FROM dual;

-- Mar 2, 2022, 8:14:17 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200195,0,0,TO_TIMESTAMP('2022-03-02 20:14:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-03-02 20:14:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_FLAT_VIEW_MENU_TREE','50000','D','S','359e0313-663a-4b3a-9a80-d20eea8c3b54')
;

-- Mar 2, 2022, 8:15:58 PM MYT
UPDATE AD_SysConfig SET Description='Y/N - Define if the application menu tree default to a single level only, flat structure',Updated=TO_TIMESTAMP('2022-03-02 20:15:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200195
;

-- Mar 2, 2022, 8:16:04 PM MYT
UPDATE AD_SysConfig SET Value='N',Updated=TO_TIMESTAMP('2022-03-02 20:16:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200195
;

-- Mar 2, 2022, 8:16:08 PM MYT
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_TIMESTAMP('2022-03-02 20:16:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200195
;

