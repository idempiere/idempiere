SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3488 Improvement to Error Message for Negative Inventory Disallow exception
-- Sep 14, 2017 6:28:55 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The {0} warehouse does not allow negative inventory for Product = {1}, ASI = {2}, Locator = {3} (Shortage of {4})',0,0,'Y',TO_DATE('2017-09-14 18:28:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-09-14 18:28:54','YYYY-MM-DD HH24:MI:SS'),100,200431,'NegativeInventoryDisallowedInfo','D','1a686715-09f5-4437-9885-882719423bd1')
;

SELECT register_migration_script('201709151000_IDEMPIERE-3488.sql') FROM dual
;

