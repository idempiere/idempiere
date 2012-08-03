UPDATE GL_JournalLine SET Account_ID = (SELECT Account_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
;

UPDATE AD_System
  SET LastMigrationScriptApplied='858_IDEMPIERE-344_GLJournalImprovement.sql'
WHERE LastMigrationScriptApplied<'858_IDEMPIERE-344_GLJournalImprovement.sql'
   OR LastMigrationScriptApplied IS NULL
;
