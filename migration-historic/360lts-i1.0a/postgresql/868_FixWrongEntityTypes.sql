update ad_element set entitytype = 'D' where entitytype='U' and AD_Element_id < 1000000;

update ad_field set entitytype = 'D' where entitytype='U' and AD_Field_id < 1000000;

update AD_Column set entitytype = 'D' where entitytype='U' and AD_Column_id < 1000000;

update AD_Column set entitytype = 'D' where entitytype='A' and AD_Column_id < 1000000;

update AD_Process_Para set entitytype = 'D' where entitytype='U' and AD_Process_Para_ID < 1000000;

update AD_Menu set entitytype = 'D' where entitytype='U' and AD_Menu_ID < 1000000;

update AD_Tab set entitytype = 'D' where entitytype='U' and AD_Tab_ID < 1000000;

UPDATE AD_System
  SET LastMigrationScriptApplied='868_FixWrongEntityTypes.sql'
WHERE LastMigrationScriptApplied<'868_FixWrongEntityTypes.sql'
   OR LastMigrationScriptApplied IS NULL
;
