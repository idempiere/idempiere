-- Jan 26, 2021, 3:58:13 PM MYT
UPDATE AD_Ref_List SET Name='After Payment', Description='After full payment has been received for the order',Updated=TO_TIMESTAMP('2021-01-26 15:58:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=217
;

SELECT register_migration_script('202101260800_IDEMPIERE-4654.sql') FROM dual
;

