-- Nov 17, 2014 6:27:47 PM IST
-- IDEMPIERE-2318: Handling NPE for Attribute not set on product and Batch level costing used
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created,Updated) VALUES ('E','No attribute set configured on product ',200328,'D','b8793354-b3b6-4106-8d8a-32d511d5b5d9','NoAttributeSet','Y',100,100,0,0,TO_TIMESTAMP('2014-11-17 18:27:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-11-17 18:27:46','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201411170824_IDEMPIERE-2318.sql') FROM dual
;