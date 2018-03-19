-- Aug 28, 2013 5:35:23 PM COT
-- IDEMPIERE-1304 Document allow to select price list without version
UPDATE AD_Val_Rule SET Code='M_PriceList.IsSOPriceList = ''@IsSOTrx@''  AND (SELECT COUNT(*) FROM M_PriceList_Version WHERE M_PriceList.M_PriceList_ID=M_PriceList_Version.M_PriceList_ID AND M_PriceList_Version.IsActive=''Y'')>0',Updated=TO_DATE('2013-08-28 17:35:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=271
;

-- Aug 29, 2013 9:45:47 AM COT
-- IDEMPIERE-1304 Document allow to select price list without version
UPDATE AD_Column SET AD_Val_Rule_ID=271,Updated=TO_DATE('2013-08-29 09:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3789
;

SELECT register_migration_script('201309100739_IDEMPIERE-1304.sql') FROM dual
;

