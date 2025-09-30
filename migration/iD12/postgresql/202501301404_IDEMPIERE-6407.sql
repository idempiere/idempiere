-- IDEMPIERE-6407 Payment Selection (Manual) - NPE when there is no conversion rate
SELECT register_migration_script('202501301404_IDEMPIERE-6407.sql') FROM dual;

-- Jan 30, 2025, 2:04:40 PM CET
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','There are payments with no value for Amount Due or Payment Amount, this is usually caused by missing currency exchange rates.','Please deselect the payments without amounts or configure the currency rate correctly.',0,0,'Y',TO_TIMESTAMP('2025-01-30 14:04:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-30 14:04:36','YYYY-MM-DD HH24:MI:SS'),100,200934,'PaymentSelectAmtNull','D','0f9a7146-fb1d-4779-a91c-8382f6177a8c')
;

