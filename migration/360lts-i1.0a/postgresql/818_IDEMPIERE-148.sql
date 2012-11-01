-- Feb 13, 2012 12:36:56 PM COT
-- IDEMPIERE-148 Allow reversal invoice to use DocNo^ instead of consuming an invoice #
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200009,'D','C','Invoice_ReverseUseNewNumber','Y','Allows you to choose to use a new number for the reversed invoice.',0,0,TO_TIMESTAMP('2012-02-13 12:36:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-13 12:36:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

UPDATE AD_System
  SET LastMigrationScriptApplied='818_IDEMPIERE-148.sql'
WHERE LastMigrationScriptApplied<'818_IDEMPIERE-148.sql'
   OR LastMigrationScriptApplied IS NULL
;
