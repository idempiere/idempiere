-- Jun 18, 2013 12:06:03 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2013-06-18 12:06:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201805
;

-- Jun 18, 2013 12:06:03 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2013-06-18 12:06:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10957
;

SELECT register_migration_script('201306181225_IDEMPIERE-362.sql') FROM dual
;

