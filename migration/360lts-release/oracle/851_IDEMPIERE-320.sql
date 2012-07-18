-- Jul 16, 2012 5:38:59 AM AST
-- IDEMPIERE-320 -   Make Swing CTextArea consistent with ZK
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200012,'D','C','N','Override Text Area behaviour, ENTER to change value, TAB to focus next, Shift-ENTER for new line','b8634904-e4d1-48da-8b86-cc46d12cb52d',TO_DATE('2012-07-16 05:38:58','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-07-16 05:38:58','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'SWING_OVERRIDE_TEXT_AREA_BEHAVIOUR')
;

UPDATE AD_System
  SET LastMigrationScriptApplied='851_IDEMPIERE-320.sql'
WHERE LastMigrationScriptApplied<'851_IDEMPIERE-320.sql'
   OR LastMigrationScriptApplied IS NULL
;
