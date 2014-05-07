SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 21, 2014 2:30:56 PM CEST
-- IDEMPIERE-1843
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200271,'8b9721fe-a51a-4d84-8b07-9eff0f3ce158',0,TO_DATE('2014-04-21 14:30:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Tabs','I',TO_DATE('2014-04-21 14:30:55','YYYY-MM-DD HH24:MI:SS'),100,'Tabs')
;

-- Apr 21, 2014 2:31:03 PM CEST
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200272,'b835a2a6-2257-462c-abfb-bfa97e283306',0,TO_DATE('2014-04-21 14:31:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Fields','I',TO_DATE('2014-04-21 14:31:02','YYYY-MM-DD HH24:MI:SS'),100,'Fields')
;


SELECT register_migration_script('201404211431_IDEMPIERE-1843.sql') FROM dual
;