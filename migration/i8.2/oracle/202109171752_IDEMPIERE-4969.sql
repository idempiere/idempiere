SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4969 Clean non-working 2Pack Code for File and CodeSnippet
-- Sep 17, 2021, 5:51:16 PM CEST
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_DATE('2021-09-17 17:51:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=50021
;

-- Sep 17, 2021, 5:51:35 PM CEST
UPDATE AD_Ref_List SET Name='Code Snippet', Description='Replace a code snippet with in a file', IsActive='N',Updated=TO_DATE('2021-09-17 17:51:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=50029
;

SELECT register_migration_script('202109171752_IDEMPIERE-4969.sql') FROM dual
;

