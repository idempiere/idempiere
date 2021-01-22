SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4510 Search in the toolbar improvement to work out of the box
-- Oct 27, 2020, 2:30:55 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Select Query',0,0,'Y',TO_DATE('2020-10-27 18:53:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 18:53:07','YYYY-MM-DD HH24:MI:SS'),100,200643,'SelectQuery','D','265f31ef-a92f-4898-bc38-5cbcd5d8523c')
;


SELECT register_migration_script('202010271430_IDEMPIERE-4510.sql') FROM dual
;
