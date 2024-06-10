-- IDEMPIERE-6040 Improvements for CSV import template
SELECT register_migration_script('202405131534_IDEMPIERE-6040.sql') FROM dual;

-- May 13, 2024, 3:34:49 PM CEST
UPDATE AD_Ref_List SET Name='Comma-separated values (CSV)',Updated=TO_TIMESTAMP('2024-05-13 15:34:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200704
;

-- May 13, 2024, 3:35:58 PM CEST
UPDATE AD_Ref_List SET Name='Excel (XLS/XLSX)',Updated=TO_TIMESTAMP('2024-05-13 15:35:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200706
;

-- May 13, 2024, 3:36:02 PM CEST
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_TIMESTAMP('2024-05-13 15:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200705
;

UPDATE AD_ImportTemplate SET ImportTemplateType='XLSX' WHERE ImportTemplateType='XLS'
;

-- May 13, 2024, 3:59:49 PM CEST
UPDATE AD_Field SET SeqNo=120, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-05-13 15:59:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208476
;

