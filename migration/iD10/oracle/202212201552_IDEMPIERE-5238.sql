-- IDEMPIERE-5238
SELECT register_migration_script('202212201552_IDEMPIERE-5238.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 20, 2022, 3:52:24 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Table',0,0,'Y',TO_TIMESTAMP('2022-12-20 15:52:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-20 15:52:24','YYYY-MM-DD HH24:MI:SS'),100,200809,'Table','D','a7c566e9-b176-4d25-9556-137255e45509')
;

-- Dec 20, 2022, 3:53:10 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Choose Related Record',0,0,'Y',TO_TIMESTAMP('2022-12-20 15:53:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-20 15:53:09','YYYY-MM-DD HH24:MI:SS'),100,200810,'ChooseRelatedRecord','D','7fb8fd7c-ced8-44a1-950f-26242a5e0371')
;

