-- IDEMPIERE-6545 Translation tabs must not allow delete
SELECT register_migration_script('202505151946_IDEMPIERE-6545.sql') FROM dual;

UPDATE AD_Tab
SET IsTranslationTab='Y'
WHERE AD_Tab.AD_Table_ID IN (SELECT AD_Table_ID FROM AD_Table WHERE TableName LIKE '%_Trl')
AND IsTranslationTab='N';

UPDATE AD_Tab
SET IsInsertRecord='N'
WHERE IsTranslationTab='Y' AND IsInsertRecord='Y';

UPDATE AD_Table
SET IsDeleteable='N'
WHERE TableName LIKE '%_Trl'
AND IsDeleteable='Y';

