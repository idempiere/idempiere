-- Mar 18, 2013 4:12:53 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_ReportView SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:12:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=200004
;

-- Mar 18, 2013 4:12:59 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_Table SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:12:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200073
;

UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:12:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200073
;

-- Mar 18, 2013 4:13:06 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_PrintFormat SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:13:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200008
;

UPDATE AD_PrintFormatItem SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:13:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200008
;

-- Mar 18, 2013 4:13:16 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_Process SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:13:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200038
;

UPDATE AD_Process_Para SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:13:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200038
;

-- Mar 18, 2013 4:13:16 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 16:13:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200046
;

SELECT register_migration_script('201303181615_IDEMPIERE-764.sql') FROM dual
;

