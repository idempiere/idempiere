SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
-- Aug 17, 2015 7:18:22 PM COT
UPDATE AD_Process_Para SET IsMandatory='N',Updated=TO_DATE('2015-08-17 19:18:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200069
;

-- IDEMPIERE-2745 2Pack is not creating foreign keys
update ad_column set fkconstrainttype='D' where fkconstrainttype is null and columnname in ('AD_Client_ID','AD_Org_ID','CreatedBy','UpdatedBy') and ad_reference_id in (18,19,30)
;


SELECT register_migration_script('201508171408_IDEMPIERE-2745.sql') FROM dual
;

