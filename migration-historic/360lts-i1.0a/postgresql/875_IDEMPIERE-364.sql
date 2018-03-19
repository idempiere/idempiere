-- Aug 10, 2012 3:55:26 PM COT
-- IDEMPIERE-364 Improve Grid Layout
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,IsActive,AD_ToolBarButton_UU) VALUES ('zk Window - Customize','Customize','org.adempiere.webui.component.CWindowToolbar','N',0,0,0,0,TO_TIMESTAMP('2012-08-10 15:55:25','YYYY-MM-DD HH24:MI:SS'),100,200058,TO_TIMESTAMP('2012-08-10 15:55:25','YYYY-MM-DD HH24:MI:SS'),100,'Y','73e850aa-66dc-4fd8-a7e0-72623ed457f1')
;

UPDATE AD_System
  SET LastMigrationScriptApplied='875_IDEMPIERE-364.sql'
WHERE LastMigrationScriptApplied<'875_IDEMPIERE-364.sql'
   OR LastMigrationScriptApplied IS NULL
;
