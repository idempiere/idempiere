SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3022 Copy Columns from table error message
-- Feb 1, 2016 5:11:42 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Target table must not have columns',0,0,'Y',TO_DATE('2016-02-01 17:11:42','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2016-02-01 17:11:42','YYYY-MM-DD HH24:MI:SS'),0,200398,'ErrorCopyColumns','D','e74d8970-44f1-4cd0-9b5e-ee21af6c286e')
;

SELECT register_migration_script('201602011711_IDEMPIERE-3022.sql') FROM dual
;

