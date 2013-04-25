-- IDEMPIERE-457 - hide tab editor for inactive tabs
UPDATE AD_ToolBarButton SET DisplayLogic='@IsSortTab@=N & @IsActive@=Y ',Updated=TO_DATE('2012-11-07 14:29:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200068

;

SELECT register_migration_script('201211141558_IDEMPIERE-457.sql') FROM dual
;

