SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 28, 2014 6:45:00 PM CET
-- IDEMPIERE-2279 C_ContactActivity SalesRep_ID has no AD_Reference_Value_ID
UPDATE AD_Column SET AD_Reference_Value_ID=110,Updated=TO_DATE('2014-10-28 18:45:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=62467
;

SELECT register_migration_script('201410271848_IDEMPIERE-2279.sql') FROM dual
;