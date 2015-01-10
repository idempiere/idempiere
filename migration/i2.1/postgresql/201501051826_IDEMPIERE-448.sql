-- Jan 5, 2015 6:14:51 PM COT
-- IDEMPIERE-448 Add CopyFrom on Bank Statement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2015-01-05 18:14:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4939
;

-- Jan 5, 2015 6:14:59 PM COT
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_TIMESTAMP('2015-01-05 18:14:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4009
;

SELECT register_migration_script('201501051826_IDEMPIERE-448.sql') FROM dual
;

