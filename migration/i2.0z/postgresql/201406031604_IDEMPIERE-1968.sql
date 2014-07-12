-- Jun 3, 2014 4:22:36 PM ICT
-- IDEMPIERE-1968 valid check box in info window can manual editable
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-06-03 16:22:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201639
;

SELECT register_migration_script('201406031604_IDEMPIERE-1968.sql') FROM dual
;
