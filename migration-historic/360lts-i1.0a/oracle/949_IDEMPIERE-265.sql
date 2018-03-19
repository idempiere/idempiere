-- Oct 27, 2012 3:42:39 PM IST
-- Allow records to be deleted
UPDATE AD_Table SET IsDeleteable='Y',Updated=TO_DATE('2012-10-27 15:42:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=814
;

SELECT register_migration_script('949_IDEMPIERE-265.sql') FROM dual
;