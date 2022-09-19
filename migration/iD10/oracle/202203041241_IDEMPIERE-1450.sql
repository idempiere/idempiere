-- IDEMPIERE-1450  Translation missing for Matching Purchase Order
SELECT register_migration_script('202203041241_IDEMPIERE-1450.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 4, 2022, 12:41:42 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No posting if not matched to Shipment',0,0,'Y',TO_TIMESTAMP('2022-03-04 12:41:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-04 12:41:41','YYYY-MM-DD HH24:MI:SS'),100,200735,'NoPostingIfNotMatchedToShipment','D','ec8dce54-1223-4afe-a713-2f0521fbaa7d')
;

-- Mar 4, 2022, 12:52:28 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Purchase Order not convertible - {0}',0,0,'Y',TO_TIMESTAMP('2022-03-04 12:52:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-04 12:52:28','YYYY-MM-DD HH24:MI:SS'),100,200736,'PurchaseOrderNotConvertible','D','41e7cf54-92cd-40fc-a83b-a9d7ccd61c8e')
;

-- Mar 4, 2022, 12:58:26 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Failed to create reversal entry for ACCTTYPE_PPVOffset',0,0,'Y',TO_TIMESTAMP('2022-03-04 12:58:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-04 12:58:25','YYYY-MM-DD HH24:MI:SS'),100,200737,'FailedToCreateReversalEntryForACCTTYPE_PPVOffset','D','d21f4540-1966-44df-a1a6-56330dbf53b4')
;

