-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202210051347_IDEMPIERE-5396.sql') FROM dual;

-- Oct 5, 2022, 1:47:28 PM MYT
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_TIMESTAMP('2022-10-05 13:47:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215126
;

UPDATE AD_Column SET AD_InfoWindow_ID=NULL WHERE AD_InfoWindow_ID IS NOT NULL AND AD_Reference_ID != 28
;

