-- IDEMPIERE-6732
SELECT register_migration_script('202511191144_IDEMPIERE-6732.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF


-- Nov 19, 2025, 11:57:53 AM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Quantity received exceeds balance to receive, Line {0} Product {1} Quantity Balance {2}',0,0,'Y',TO_TIMESTAMP('2025-11-19 11:57:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-19 11:57:48','YYYY-MM-DD HH24:MI:SS'),100,200985,'ReceiptQtyExceedsBalance','D','019a9c9f-4114-7dff-89f6-9a63fff6e7ff')
;

