-- May 3, 2013 2:40:20 PM COT
-- IDEMPIERE-909 Enable back After Order delivered invoice rule
UPDATE AD_Ref_List SET IsActive='Y',Updated=TO_DATE('2013-05-03 14:40:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=214
;

SELECT register_migration_script('201305031441_IDEMPIERE-909.sql') FROM dual
;

