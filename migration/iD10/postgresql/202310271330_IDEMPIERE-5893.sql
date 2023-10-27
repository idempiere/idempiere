-- IDEMPIERE-5893 Completed invoices are being updated in MOrder.afterSave
SELECT register_migration_script('202310271330_IDEMPIERE-5893.sql') FROM dual;

-- Oct 27, 2023, 1:30:33 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200239,0,0,TO_TIMESTAMP('2023-10-27 13:30:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-10-27 13:30:32','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ORDER_COLUMNS_TO_COPY_TO_NOT_COMPLETED_INVOICES','Description,POReference,PaymentRule,C_PaymentTerm_ID,DateAcct','Comma separated list of columns to be copied when changing an order to not completed invoices','D','O','afb62005-a8e6-446a-99d1-d268e59ec255')
;

