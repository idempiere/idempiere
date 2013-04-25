-- Feb 14, 2013 12:24:47 PM MYT
-- IDEMPIERE-613 Column Encryption Enhancement
UPDATE AD_Process_Para SET DisplayLogic='@IsEncrypted@=Y',Updated=TO_DATE('2013-02-14 12:24:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=647
;

-- Feb 14, 2013 12:25:07 PM MYT
-- IDEMPIERE-613 Column Encryption Enhancement
UPDATE AD_Process_Para SET DisplayLogic='@IsEncrypted@=Y',Updated=TO_DATE('2013-02-14 12:25:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=648
;

-- Feb 14, 2013 12:46:09 PM MYT
-- IDEMPIERE-613 Column Encryption Enhancement
UPDATE AD_Column SET ReadOnlyLogic='@IsKey@=Y | @IsParent@=Y | @IsIdentifier@=Y | @IsTranslated@=Y | @ColumnName@=AD_Client_ID | @ColumnName@=AD_Client_ID | @ColumnName@=AD_Org_ID | @ColumnName@=IsActive | @ColumnName@=Created | @ColumnName@=Updated | @ColumnName@=DocumentNo | @ColumnName@=Value | @ColumnName@=Name | @AD_Reference_ID@=23 | @AD_Reference_ID@=36 | @ColumnSQL@!''''',Updated=TO_DATE('2013-02-14 12:46:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=128
;

SELECT register_migration_script('201302190222_IDEMPIERE-613.sql') FROM dual
;

