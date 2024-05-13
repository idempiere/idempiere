-- IDEMPIERE-5622 - Language in Window and Info Window customization should be filtered by log in languages
SELECT register_migration_script('202303101208_IDEMPIERE-5622.sql') FROM dual;

-- Mar 10, 2023, 12:08:54 PM CET
UPDATE AD_Column SET AD_Reference_Value_ID=327,Updated=TO_TIMESTAMP('2023-03-10 12:08:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6399
;

-- Mar 10, 2023, 12:09:05 PM CET
UPDATE AD_Column SET AD_Reference_Value_ID=327,Updated=TO_TIMESTAMP('2023-03-10 12:09:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214241
;

