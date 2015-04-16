-- IDEMPIERE-2535 Date material policy BUG on receipt
-- Apr 9, 2015 12:04:34 PM COT
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2015-04-09 12:04:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208342
;

SELECT register_migration_script('201504091207_IDEMPIERE-2535.sql') FROM dual
;

