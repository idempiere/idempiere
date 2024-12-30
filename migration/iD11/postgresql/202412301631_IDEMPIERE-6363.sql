-- IDEMPIERE-6363
SELECT register_migration_script('202412301631_IDEMPIERE-6363.sql') FROM dual;

-- Dec 30, 2024, 4:34:34 PM BRT
UPDATE AD_Val_Rule SET Code='m_matchinv.processed = ''N''',Updated=TO_TIMESTAMP('2024-12-30 16:34:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52086
;

