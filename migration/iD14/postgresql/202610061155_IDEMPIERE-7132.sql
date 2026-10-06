-- IDEMPIERE-7132
SELECT register_migration_script('202610061155_IDEMPIERE-7132.sql') FROM dual;

-- Oct 6, 2026, 11:55:26 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200330,0,0,TO_TIMESTAMP('2026-10-06 11:55:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-10-06 11:55:25','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','INVOICE_ISPAID_REQUIRES_ALLOCATION','N','If Y, an invoice is only marked as Paid when it has at least one allocation line and its open balance is 0. If N (default), an invoice is Paid whenever its open balance is 0, even with no allocation line (for example a zero total invoice).','D','C','01a110a3-b39f-7883-9d7e-5bbeb194c414')
;

