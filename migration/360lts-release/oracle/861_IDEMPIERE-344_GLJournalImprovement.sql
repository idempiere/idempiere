-- Aug 2, 2012 10:34:37 PM COT
-- IDEMPIERE-344 Improve usability for GL Journal
UPDATE AD_Field SET IsAllowCopy='N',Updated=TO_DATE('2012-08-02 22:34:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200189
;

-- Aug 2, 2012 10:34:56 PM COT
UPDATE AD_Field SET IsAllowCopy='N',Updated=TO_DATE('2012-08-02 22:34:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200205
;

-- Aug 2, 2012 10:35:00 PM COT
UPDATE AD_Field SET IsAllowCopy='N',Updated=TO_DATE('2012-08-02 22:35:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200206
;

-- Aug 2, 2012 10:35:17 PM COT
UPDATE AD_Field SET IsAllowCopy='N',Updated=TO_DATE('2012-08-02 22:35:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200203
;

UPDATE AD_System
  SET LastMigrationScriptApplied='861_IDEMPIERE-344_GLJournalImprovement.sql'
WHERE LastMigrationScriptApplied<'861_IDEMPIERE-344_GLJournalImprovement.sql'
   OR LastMigrationScriptApplied IS NULL
;

