-- IDEMPIERE-3280 Callout invalid in the Asset balance form
-- Jan 17, 2017 5:32:17 PM CET
UPDATE AD_Column SET Callout='org.idempiere.fa.model.CalloutA_Depreciation_Workfile.A_Valoare_Cofinantare',Updated=TO_TIMESTAMP('2017-01-17 17:32:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55399
;

-- Jan 17, 2017 5:32:39 PM CET
UPDATE AD_Column SET Callout='org.idempiere.fa.model.CalloutA_Depreciation_Workfile.A_Valoare_Cofinantare', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-01-17 17:32:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59292
;

SELECT register_migration_script('201701171735_IDEMPIERE-3280.sql') FROM dual
;

