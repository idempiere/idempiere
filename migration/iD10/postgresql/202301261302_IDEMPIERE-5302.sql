-- IDEMPIERE-5302 Drill Assistant Feature
SELECT register_migration_script('202301261302_IDEMPIERE-5302.sql') FROM dual;

-- Jan 26, 2023, 1:03:41 PM CET
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2023-01-26 13:03:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214733
;

-- Jan 26, 2023, 1:03:57 PM CET
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2023-01-26 13:03:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206939
;

-- Jan 26, 2023, 1:04:00 PM CET
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2023-01-26 13:04:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206941
;

-- Jan 26, 2023, 1:04:34 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206937
;

-- Jan 26, 2023, 1:04:34 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206944
;

-- Jan 26, 2023, 1:04:34 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206939
;

-- Jan 26, 2023, 1:04:34 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206941
;

-- Jan 26, 2023, 1:04:34 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206936
;

