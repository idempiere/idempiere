-- Aug 14, 2012 3:36:39 PM COT
-- IDEMPIERE-364 Improve Grid Layout
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200273
;

-- Aug 14, 2012 3:36:39 PM COT
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=200275
;

-- Aug 14, 2012 3:36:45 PM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200273
;

-- Aug 14, 2012 3:36:45 PM COT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=200275
;

UPDATE AD_System
  SET LastMigrationScriptApplied='876_IDEMPIERE-364_FixWrongField.sql'
WHERE LastMigrationScriptApplied<'876_IDEMPIERE-364_FixWrongField.sql'
   OR LastMigrationScriptApplied IS NULL
;
