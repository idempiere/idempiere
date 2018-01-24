-- IDEMPIERE-3535 Implement font icon theme
-- Nov 2, 2017 3:27:27 PM GMT+08:00
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200111,0,0,TO_TIMESTAMP('2017-11-02 15:27:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-11-02 15:27:26','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_THEME_USE_FONT_ICON_FOR_IMAGE','N','Y - Use css font icon instead of image for button, toolbar button and menu, N - Use image','D','S','29a0d95d-af05-477a-a047-241c350dc8e3')
;

SELECT register_migration_script('201711030900_IDEMPIERE-3535.sql') FROM dual
;

