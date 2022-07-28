SELECT register_migration_script('202203090311_IDEMPIERE-5094.sql') FROM dual
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5094 Implement validation for costing level change ( Accounting Schema and Product Category Accounting )
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200478,'dc008155-cfe9-4394-9280-4817f3bb4f21',0,TO_DATE('2022-03-08 15:22:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Costing level can''t be changed if there are product cost details created with current costing level','E',TO_DATE('2022-03-08 15:22:40','YYYY-MM-DD HH24:MI:SS'),100,'ChangeCostingLevelError')
;

