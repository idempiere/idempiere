-- IDEMPIERE-7160 Report: Add option for export of calculation as Excel formula cell
SELECT register_migration_script('202610131132_IDEMPIERE-7160.sql') FROM dual;

-- Oct 13, 2026, 11:32:18 AM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200335,0,0,TO_TIMESTAMP('2026-10-13 11:32:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-10-13 11:32:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','EXPORT_EXCEL_FUNCTION','N','Determines whether calculations are exported as dynamic Excel formulas or static values. Options: Y (Yes - Excel formulas), N (No - Static values, Default).','D','C','01a13351-743c-745e-821a-7f6957e251b4')
;

