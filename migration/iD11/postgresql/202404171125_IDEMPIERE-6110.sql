-- IDEMPIERE-6110
SELECT register_migration_script('202404171125_IDEMPIERE-6110.sql') FROM dual;

-- Apr 17, 2024, 11:25:53 AM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Products or charges configured as ''Freight Product'' or ''Freight Charge'' cannot be added to this order due to the combination of delivery via rule and freight cost rule',0,0,'Y',TO_TIMESTAMP('2024-04-17 11:25:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-17 11:25:53','YYYY-MM-DD HH24:MI:SS'),100,200897,'FreightOrderLineNotAllowed','D','204c8bb9-d002-4beb-bbc3-1d1a11d7471d')
;

