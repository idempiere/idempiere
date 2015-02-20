-- Feb 3, 2015 1:45:55 PM ICT
-- IDEMPIERE-2440 lengh of org name in session active is wrong
UPDATE AD_Column SET FieldLength=60,Updated=TO_TIMESTAMP('2015-02-03 13:45:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200706
;

-- Feb 3, 2015 2:02:04 PM ICT
UPDATE AD_Column SET FieldLength=60,Updated=TO_TIMESTAMP('2015-02-03 14:02:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200599
;

-- Feb 3, 2015 2:02:04 PM ICT
UPDATE AD_Column SET FieldLength=60,Updated=TO_TIMESTAMP('2015-02-03 14:02:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200705
;

SELECT register_migration_script('201502031604_IDEMPIERE-2440.sql') FROM dual
;

