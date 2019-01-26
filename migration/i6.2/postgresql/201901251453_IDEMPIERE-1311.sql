-- IDEMPIERE-1311 Ability to hide fields on Connection panel
-- Jan 25, 2019, 2:53:25 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Defaults',0,0,'Y',TO_TIMESTAMP('2019-01-25 14:53:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-25 14:53:25','YYYY-MM-DD HH24:MI:SS'),100,200486,'Defaults','D','4b2b5e32-b978-47d9-a843-7e6c9eb647f2')
;

SELECT register_migration_script('201901251453_IDEMPIERE-1311.sql') FROM dual
;

