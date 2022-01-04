SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5139 BOM validation for Deactivation of Product
-- Jan 4, 2022, 3:43:47 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','This product is being used as a component in an active BOM. Please remove from BOM or inactivate BOM before marking this product as inactive.',0,0,'Y',TO_DATE('2022-01-04 15:43:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-01-04 15:43:42','YYYY-MM-DD HH24:MI:SS'),100,200724,'DeActivateProductInActiveBOM','D','748a4e5b-95ec-4106-a949-ab700376a4a1')
;

SELECT register_migration_script('202201040800_IDEMPIERE-5139.sql') FROM dual
;

