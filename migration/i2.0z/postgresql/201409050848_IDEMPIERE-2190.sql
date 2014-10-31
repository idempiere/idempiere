-- Sep 5, 2014 8:46:44 AM COT
-- IDEMPIERE-2190 Virtual Column M_Product.CostStandard too heavy
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2014-09-05 08:46:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=61998
;

-- Sep 5, 2014 8:47:19 AM COT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', IsActive='N', IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2014-09-05 08:47:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62009
;

UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', IsActive='N', IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2014-09-05 08:47:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201344
;

SELECT register_migration_script('201409050848_IDEMPIERE-2190.sql') FROM dual
;

