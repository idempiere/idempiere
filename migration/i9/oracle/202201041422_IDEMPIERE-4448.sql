SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4448 Autocomplete/Info Window doesn't work correctly with Search fields with Reference
UPDATE AD_Ref_Table SET AD_Display=15601,IsValueDisplayed='N' WHERE AD_Reference_ID=389 /* _EntityTypeNew - AD_EntityType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=204,IsValueDisplayed='N' WHERE AD_Reference_ID=106 /* AD_Language - AD_Language_ID */
;

UPDATE AD_Ref_Table SET AD_Display=204,IsValueDisplayed='N' WHERE AD_Reference_ID=200069 /* AD_Language NOT System/Base - AD_Language_ID */
;

UPDATE AD_Ref_Table SET AD_Display=204,IsValueDisplayed='N' WHERE AD_Reference_ID=327 /* AD_Language System - AD_Language_ID */
;

SELECT register_migration_script('202201041422_IDEMPIERE-4448.sql') FROM dual
;

