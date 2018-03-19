UPDATE AD_Process SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Process_ID<1000000;

UPDATE AD_Process_Para SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Process_Para_ID<1000000;

UPDATE AD_ReportView SET EntityType = 'D' WHERE EntityType = 'U' AND AD_ReportView_ID<1000000;

UPDATE AD_Field SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Field_ID<1000000;

UPDATE AD_Element SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Element_ID<1000000;

UPDATE AD_Val_Rule SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Val_Rule_ID<1000000;

UPDATE AD_Reference SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Reference_ID<1000000;

UPDATE AD_Menu SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Menu_ID<1000000;

UPDATE AD_Ref_List SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Ref_List_ID<1000000;

UPDATE AD_Column SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Column_ID<1000000;

UPDATE AD_Table SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Table_ID<1000000;

UPDATE AD_Message SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Message_ID<1000000;

UPDATE AD_Window SET EntityType = 'D' WHERE EntityType = 'U' AND AD_Window_ID<1000000;

SELECT register_migration_script('955_FixWrongEntityTypes.sql') FROM dual
;

