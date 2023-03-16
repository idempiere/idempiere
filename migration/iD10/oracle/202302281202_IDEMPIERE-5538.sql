-- IDEMPIERE-5538
SELECT register_migration_script('202302281202_IDEMPIERE-5538.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 28, 2023, 12:02:28 PM CET
UPDATE AD_Message SET MsgText='Cannot find any valid Drill Rules for the selected Column.', MsgTip='You can define new definitions in Drill Rule window, then run the ''Validate'' process.',Updated=TO_TIMESTAMP('2023-02-28 12:02:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200762
;

-- Feb 28, 2023, 12:04:40 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','All Drill Rules in System which have at least one Drill Rule Parameter with a mandatory Process Parameter must have the Show Help field set to value ''Show Help''',0,0,'Y',TO_TIMESTAMP('2023-02-28 12:04:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-28 12:04:39','YYYY-MM-DD HH24:MI:SS'),100,200823,'DrillParameterTenantCheck','D','c93f3c2c-4d1f-4a13-a41d-05b31402453d')
;

