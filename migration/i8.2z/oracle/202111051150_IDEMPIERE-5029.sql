SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5029 User can make Shipment/Receipt Line Product different from Order Line Product
-- Nov 5, 2021, 7:31:15 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Shipment/Receipt Line Product is different from Order Line Product',0,0,'Y',TO_DATE('2021-11-05 19:31:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-05 19:31:14','YYYY-MM-DD HH24:MI:SS'),100,200720,'MInOutLineAndOrderLineProductDifferent','D','2e24aa42-6a8e-4ff1-b236-43d16e543389')
;

SELECT register_migration_script('202111051150_IDEMPIERE-5029.sql') FROM dual
;

