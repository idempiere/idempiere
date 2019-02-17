SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1615 Multiple key columns lead to data corruption or data loss
-- Feb 14, 2019, 4:51:33 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The table has already a key column, there can be just one key.',0,0,'Y',TO_DATE('2019-02-14 16:51:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-02-14 16:51:32','YYYY-MM-DD HH24:MI:SS'),100,200488,'KeyColumnAlreadyDefined','D','c5011666-1371-4620-a5bc-aa29265f5d90')
;

SELECT register_migration_script('201902141651_IDEMPIERE-1615.sql') FROM dual
;

