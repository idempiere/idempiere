-- IDEMPIERE-6203 Back-dating costing
SELECT register_migration_script('202409230952_IDEMPIERE-6203.sql') FROM dual;

-- Sep 23, 2024, 9:52:59 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Insufficient Stock Coverage. A reversal of shipment/project issue is required to replenish stock before reversal.',0,0,'Y',TO_TIMESTAMP('2024-09-23 09:52:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-23 09:52:58','YYYY-MM-DD HH24:MI:SS'),100,200904,'InsufficientStockCoverage','D','2fcd3101-4367-4052-923d-78be965d8910')
;

