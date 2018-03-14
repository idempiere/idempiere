-- Aug 12, 2014 3:34:19 PM CEST
-- IDEMPIERE-2134 Issues found on Payment Selection process
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,Description,AD_SysConfig_UU,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType,Created,Updated) VALUES (200058,'O','Y','Define if the payment selection manual process ask the user to invoke generate payments at the end','f7aa5604-3835-40ef-a9fd-4d7b92b323e5',0,100,'Y',100,'PAYMENT_SELECTION_MANUAL_ASK_INVOKE_GENERATE',0,'D',TO_TIMESTAMP('2014-08-12 15:34:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-08-12 15:34:19','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201408121535_IDEMPIERE-2134.sql') FROM dual
;

