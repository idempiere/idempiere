-- Test
SELECT register_migration_script('202404151549_IDEMPIERE-6110.sql') FROM dual;

-- Apr 15, 2024, 3:49:29 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Impossible to complete document using only the Tenant''s Shipping Product or Charge.',0,0,'Y',TO_TIMESTAMP('2024-04-15 15:49:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-15 15:49:29','YYYY-MM-DD HH24:MI:SS'),100,nextidfunc(9,'N'),'ShippingProductOnly','D','e9a6ba68-0128-4e91-8f49-fed099c902f9')
;



