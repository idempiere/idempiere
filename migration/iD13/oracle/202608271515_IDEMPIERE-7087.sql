-- 
SELECT register_migration_script('202608271515_IDEMPIERE-7087.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 27, 2026, 3:15:35 PM CEST
UPDATE AD_Field SET Name='Print Button Process', Description='Defines the process to execute (usually a document report) when clicking on the print button on this tab.', Help=NULL, IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2026-08-27 15:15:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;

-- Aug 27, 2026, 3:15:58 PM CEST
UPDATE AD_Field SET Name='Print Button Process', Description='Defines the process to execute (usually a document report) when clicking on the print button on this tab.', Help=NULL, IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2026-08-27 15:15:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205831
;

