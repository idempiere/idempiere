SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5188
-- Feb 24, 2022, 1:54:35 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Select a color',0,0,'Y',TO_DATE('2022-02-24 13:54:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-24 13:54:34','YYYY-MM-DD HH24:MI:SS'),100,200726,'ColorFieldPlaceholder','D','7d428fc1-2826-4e2e-8626-1347ddcd9423')
;

-- Feb 24, 2022, 1:55:09 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Erase',0,0,'Y',TO_DATE('2022-02-24 13:55:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-24 13:55:09','YYYY-MM-DD HH24:MI:SS'),100,200727,'Erase','D','cb0bcecb-2e6a-44d5-97cd-1fbc37ee1a80')
;

-- IDEMPIERE-5188
-- Feb 24, 2022, 1:58:06 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Color Picker',0,0,'Y',TO_DATE('2022-02-24 13:58:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-24 13:58:05','YYYY-MM-DD HH24:MI:SS'),100,200728,'ColorPicker','D','ecdf19df-e3e7-42d1-905e-5496b273fefb')
;

SELECT register_migration_script('202202241400_IDEMPIERE-5188.sql') FROM dual
;
