-- IDEMPIERE-6810 Make Global Document Search Extensible
SELECT register_migration_script('202601081411_IDEMPIERE-6810.sql') FROM dual;

-- Jan 8, 2026, 2:11:21 PM MYT
UPDATE AD_Field SET AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL,Updated=TO_TIMESTAMP('2026-01-08 14:11:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56711
;

-- Jan 8, 2026, 2:12:07 PM MYT
UPDATE AD_Column SET FieldLength=255, AD_Reference_ID=17, AD_Reference_Value_ID=53291,Updated=TO_TIMESTAMP('2026-01-08 14:12:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56812
;

-- Jan 8, 2026, 2:12:11 PM MYT
INSERT INTO t_alter_column values('ad_searchdefinition','SearchType','VARCHAR(255)',null,null)
;

