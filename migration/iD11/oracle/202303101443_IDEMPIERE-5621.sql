-- IDEMPIERE-5621
SELECT register_migration_script('202303101443_IDEMPIERE-5621.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 10, 2023, 2:43:41 PM CET
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Fill mandatory parameters!','Mandatory parameters should be filled in the Process Parameter field of the Dashboard Content.',0,0,'Y',TO_TIMESTAMP('2023-03-10 14:43:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-10 14:43:41','YYYY-MM-DD HH24:MI:SS'),100,200824,'FillMandatoryParametersDashboard','D','e490d702-11b5-40e8-bea9-0221ae6ae3c9')
;

