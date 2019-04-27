-- CPH::ERP Comments: 
-- 26. apr. 2019 20.56.39 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No query columns found',0,0,'Y',TO_TIMESTAMP('2019-04-26 20:56:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-26 20:56:38','YYYY-MM-DD HH24:MI:SS'),100,200512,'NoQueryColumnsFound','C','6c8ad45a-43a1-4386-96e1-b3958844fd4a')
;

SELECT register_migration_script('201904271403_IDEMPIERE-3957.sql') FROM dual
;

