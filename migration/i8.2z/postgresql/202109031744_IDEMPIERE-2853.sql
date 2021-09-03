-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- 03-Sep-2021, 3:32:31 PM IST
UPDATE AD_ToolBarButton SET DisplayLogic=' @IsActive@=Y & @AD_TabType@!SORT',Updated=TO_TIMESTAMP('2021-09-03 15:32:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200068
;

SELECT register_migration_script('202109031744_IDEMPIERE-2853.sql') FROM dual
;
