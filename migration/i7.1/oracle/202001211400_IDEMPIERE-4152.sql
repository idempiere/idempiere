SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4152 - Payment Allocation : notify user when date changes
-- 2020-01-21 02:03:32
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Allocation date updated',0,0,'Y',TO_DATE('2020-01-21 14:03:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-01-21 14:03:32','YYYY-MM-DD HH24:MI:SS'),100,200592,'AllocationDateUpdated','D','c5cb7231-9ccc-4219-aaab-46ac3de8a372')
;

SELECT register_migration_script('202001211400_IDEMPIERE-4152.sql') FROM dual
;
