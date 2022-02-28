-- IDEMPIERE-2567 RfQResponseRank's message is hard coding,cannot translate
SELECT register_migration_script('202202271650_IDEMPIERE-2567.sql') FROM dual;

-- Feb 27, 2022, 4:50:46 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Only one completed RfQ Response found',0,0,'Y',TO_TIMESTAMP('2022-02-27 16:50:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-02-27 16:50:46','YYYY-MM-DD HH24:MI:SS'),100,200731,'OnlyOneRfQResponse','D','4d2dea2d-b2e9-443f-9aef-27a5d8fafa18')
;


