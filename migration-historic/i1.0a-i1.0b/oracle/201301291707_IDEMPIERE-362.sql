-- Jan 29, 2013 5:06:41 PM PST
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2013-01-29 17:06:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3945
;

-- Jan 29, 2013 5:06:41 PM PST
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2013-01-29 17:06:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58784
;

SELECT register_migration_script('201301291707_IDEMPIERE-362.sql') FROM dual
;

