-- IDEMPIERE-3770: Translation : export only centralized data
-- Aug 2, 2018 3:36:33 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Only centralized data',0,0,'Y',TO_TIMESTAMP('2018-08-02 15:36:32','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2018-08-02 15:36:32','YYYY-MM-DD HH24:MI:SS'),0,200481,'OnlyCentralizedData','D','f43c0cce-0462-4247-baf6-e7da842152ab')
;

SELECT register_migration_script('201808021530_IDEMPIERE-3770.sql') FROM dual
;