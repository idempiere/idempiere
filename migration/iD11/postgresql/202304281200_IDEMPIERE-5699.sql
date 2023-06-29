-- IDEMPIERE-5699 - Deactivate Product Info toolbar button
SELECT register_migration_script('202304281200_IDEMPIERE-5699.sql') FROM dual;

-- Apr 28, 2023, 12:00:37 PM CEST
UPDATE AD_ToolBarButton SET IsActive='N',Updated=TO_TIMESTAMP('2023-04-28 12:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200056
;

