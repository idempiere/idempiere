-- IDEMPIERE-4425 Find Window improvements
SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 17, 2020, 11:20:35 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','=',0,0,'Y',TO_DATE('2020-08-17 23:20:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:20:34','YYYY-MM-DD HH24:MI:SS'),100,200624,'OPERATOR_EQUAL','D','72e41fa5-1116-4cec-8505-5d1c222c902f')
;

-- Aug 17, 2020, 11:20:50 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','!=',0,0,'Y',TO_DATE('2020-08-17 23:20:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:20:50','YYYY-MM-DD HH24:MI:SS'),100,200625,'OPERATOR_NOT_EQUAL','D','9902aa45-226a-425c-a830-df1050712499')
;

-- Aug 17, 2020, 11:21:12 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' ~ ',0,0,'Y',TO_DATE('2020-08-17 23:21:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:21:12','YYYY-MM-DD HH24:MI:SS'),100,200626,'OPERATOR_LIKE','D','4f876b14-394a-48bf-9502-701327be1c7e')
;

-- Aug 17, 2020, 11:21:22 PM CEST
UPDATE AD_Message SET MsgText=' = ',Updated=TO_DATE('2020-08-17 23:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200624
;

-- Aug 17, 2020, 11:21:33 PM CEST
UPDATE AD_Message SET MsgText=' != ',Updated=TO_DATE('2020-08-17 23:21:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200625
;

-- Aug 17, 2020, 11:21:55 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' !~ ',0,0,'Y',TO_DATE('2020-08-17 23:21:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:21:55','YYYY-MM-DD HH24:MI:SS'),100,200627,'OPERATOR_NOT_LIKE','D','a995beb9-80e5-48b4-85e2-0e51fdc17477')
;

-- Aug 17, 2020, 11:22:13 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' > ',0,0,'Y',TO_DATE('2020-08-17 23:22:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:22:13','YYYY-MM-DD HH24:MI:SS'),100,200628,'OPERATOR_GREATER','D','b3403c8f-4ee0-4302-bbeb-ac584862035b')
;

-- Aug 17, 2020, 11:22:29 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' >= ',0,0,'Y',TO_DATE('2020-08-17 23:22:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:22:28','YYYY-MM-DD HH24:MI:SS'),100,200629,'OPERATOR_GREATER_EQUAL','D','494a1506-4473-4ef5-8ea1-34f71a5c0db8')
;

-- Aug 17, 2020, 11:22:39 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' < ',0,0,'Y',TO_DATE('2020-08-17 23:22:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:22:38','YYYY-MM-DD HH24:MI:SS'),100,200630,'OPERATOR_LESS','D','62d7d36c-b8f7-46dd-acaf-ca8c87b3b9f9')
;

-- Aug 17, 2020, 11:22:48 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' <= ',0,0,'Y',TO_DATE('2020-08-17 23:22:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:22:48','YYYY-MM-DD HH24:MI:SS'),100,200631,'OPERATOR_LESS_EQUAL','D','68a2cc4b-7035-4366-834c-f2d7ccc10ff4')
;

-- Aug 17, 2020, 11:23:04 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' >-< ',0,0,'Y',TO_DATE('2020-08-17 23:23:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:23:04','YYYY-MM-DD HH24:MI:SS'),100,200632,'OPERATOR_BETWEEN','D','c8e722cc-42cd-4c69-a746-641f9c073906')
;

-- Aug 17, 2020, 11:23:22 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' NULL ',0,0,'Y',TO_DATE('2020-08-17 23:23:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:23:21','YYYY-MM-DD HH24:MI:SS'),100,200633,'OPERATOR_NOT_NULL','D','b1dff391-5e9a-4f16-928b-9dce138839cc')
;

-- Aug 17, 2020, 11:23:35 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',' NULL ',0,0,'Y',TO_DATE('2020-08-17 23:23:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-08-17 23:23:35','YYYY-MM-DD HH24:MI:SS'),100,200634,'OPERATOR_NULL','D','57a47cb9-c9a0-4b65-b304-f1c8a9e3796d')
;

-- Aug 17, 2020, 11:23:42 PM CEST
UPDATE AD_Message SET MsgText=' !NULL ',Updated=TO_DATE('2020-08-17 23:23:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200633
;

-- Aug 17, 2020, 11:25:50 PM CEST
UPDATE AD_Message SET MsgText='B',Updated=TO_DATE('2020-08-17 23:25:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200632
;

-- Aug 17, 2020, 11:26:06 PM CEST
UPDATE AD_Message SET MsgText=' Between',Updated=TO_DATE('2020-08-17 23:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200632
;

-- Aug 17, 2020, 11:26:22 PM CEST
UPDATE AD_Message SET MsgText=' =',Updated=TO_DATE('2020-08-17 23:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200624
;

-- Aug 17, 2020, 11:26:29 PM CEST
UPDATE AD_Message SET MsgText=' >',Updated=TO_DATE('2020-08-17 23:26:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200628
;

-- Aug 17, 2020, 11:26:32 PM CEST
UPDATE AD_Message SET MsgText=' >=',Updated=TO_DATE('2020-08-17 23:26:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200629
;

-- Aug 17, 2020, 11:26:35 PM CEST
UPDATE AD_Message SET MsgText=' <',Updated=TO_DATE('2020-08-17 23:26:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200630
;

-- Aug 17, 2020, 11:26:38 PM CEST
UPDATE AD_Message SET MsgText=' <=',Updated=TO_DATE('2020-08-17 23:26:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200631
;

-- Aug 17, 2020, 11:26:44 PM CEST
UPDATE AD_Message SET MsgText=' Like',Updated=TO_DATE('2020-08-17 23:26:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200626
;

-- Aug 17, 2020, 11:27:10 PM CEST
UPDATE AD_Message SET MsgText=' Not Equal',Updated=TO_DATE('2020-08-17 23:27:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200625
;

-- Aug 17, 2020, 11:27:41 PM CEST
UPDATE AD_Message SET MsgText=' Not Like',Updated=TO_DATE('2020-08-17 23:27:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200627
;

-- Aug 17, 2020, 11:27:49 PM CEST
UPDATE AD_Message SET MsgText=' Not Null',Updated=TO_DATE('2020-08-17 23:27:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200633
;

-- Aug 17, 2020, 11:27:55 PM CEST
UPDATE AD_Message SET MsgText=' Is Null',Updated=TO_DATE('2020-08-17 23:27:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200634
;

SELECT register_migration_script('202008171626_IDEMPIERE-4425.sql') FROM dual
;

