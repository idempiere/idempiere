-- Mar 11, 2013 5:56:17 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200027,'D','C','U','From where to get the outgoing credentials for email (U : User / C : Client  / S : System)','8a4f70c3-b361-431a-9357-809b9f01abc4',TO_DATE('2013-03-11 17:56:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-11 17:56:16','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'MAIL_SEND_CREDENTIALS')
;

SELECT register_migration_script('201304231000_IDEMPIERE-722.sql') FROM dual
;

