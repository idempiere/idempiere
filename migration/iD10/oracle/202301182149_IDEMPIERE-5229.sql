-- IDEMPIERE-5229 After migrate helper (FHCA-4070)
SELECT register_migration_script('202301182149_IDEMPIERE-5229.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 18, 2023, 9:49:34 PM CET
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_TIMESTAMP('2023-01-18 21:49:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11427
;

-- Jan 18, 2023, 9:49:39 PM CET
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_TIMESTAMP('2023-01-18 21:49:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11432
;

-- Jan 18, 2023, 10:23:34 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','A customized record does not exist in the database.
The column {0} was customized on {1,date,long} by {2} in record {3} that no longer exists',0,0,'Y',TO_TIMESTAMP('2023-01-18 22:23:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-18 22:23:34','YYYY-MM-DD HH24:MI:SS'),100,200819,'VM_CustomizedRecordDoesNotExist','D','bbe7b719-ba3e-42b3-8baf-7f7f1133697a')
;

