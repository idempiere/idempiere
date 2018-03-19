-- Feb 10, 2014 1:01:33 AM ICT
-- IDEMPIERE-1712:Field "Event Change Log" of "Change Audit" window is not read only.
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-02-10 01:01:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54397
;

SELECT register_migration_script('201402101604-IDEMPIERE-1712.sql') FROM dual
;
