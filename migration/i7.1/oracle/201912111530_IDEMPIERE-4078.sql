SET SQLBLANKLINES ON
SET DEFINE OFF

-- CPH::ERP Comments: 
-- 26. okt. 2019 14.51.26 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Period Open',0,0,'Y',TO_DATE('2019-10-26 14:51:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-26 14:51:25','YYYY-MM-DD HH24:MI:SS'),100,200580,'PeriodOpen','D','cb274239-00ed-4a7f-b508-4a00436e6d70')
;

SELECT register_migration_script('201912111530_IDEMPIERE-4078.sql') FROM dual
;

