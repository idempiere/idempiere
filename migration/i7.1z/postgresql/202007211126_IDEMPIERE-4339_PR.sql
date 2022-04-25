-- Jul 21, 2020, 11:03:05 AM CEST
UPDATE AD_Process SET Name='Create Default Parameters',Updated=TO_TIMESTAMP('2020-07-21 11:03:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200119
;

-- Jul 21, 2020, 11:03:20 AM CEST
UPDATE AD_Element SET Name='Create Default Parameters', PrintName='Create Default Parameters',Updated=TO_TIMESTAMP('2020-07-21 11:03:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203423
;

-- Jul 21, 2020, 11:03:20 AM CEST
UPDATE AD_Column SET ColumnName='InsertParameters', Name='Create Default Parameters', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203423
;

-- Jul 21, 2020, 11:03:20 AM CEST
UPDATE AD_Field SET Name='Create Default Parameters', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203423) AND IsCentrallyMaintained='Y'
;

-- Jul 21, 2020, 11:22:14 AM CEST
UPDATE AD_Field SET DisplayLogic='@WS_WebService_ID.Value@=''ModelADService''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-07-21 11:22:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206417
;

SELECT register_migration_script('202007211126_IDEMPIERE-4339_PR.sql') FROM dual
;

