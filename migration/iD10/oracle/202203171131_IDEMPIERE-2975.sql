SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2975 Password Validator translations (Passay lib)
-- Dec 14, 2015 11:06:02 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password matches one of %1$s previous passwords.',0,0,'Y',TO_DATE('2022-03-17 11:06:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:06:01','YYYY-MM-DD HH24:MI:SS'),100,200371,'PASSAY_HISTORY_VIOLATION','D','36eed7ea-7b5c-48af-83f2-6875cfc7e0bd')
;

-- Dec 14, 2015 11:06:38 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the dictionary word ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:06:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:06:37','YYYY-MM-DD HH24:MI:SS'),100,200372,'PASSAY_ILLEGAL_WORD','D','ed284044-a4f3-43c8-8335-67788ebd41d6')
;

-- Dec 14, 2015 11:07:18 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the reversed dictionary word ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:07:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:07:17','YYYY-MM-DD HH24:MI:SS'),100,200373,'PASSAY_ILLEGAL_WORD_REVERSED','D','976233af-655a-4053-bd09-827d57dbc25a')
;

-- Dec 14, 2015 11:07:50 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password matches the illegal pattern ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:07:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:07:49','YYYY-MM-DD HH24:MI:SS'),100,200374,'PASSAY_ILLEGAL_MATCH','D','b2d5c206-f0fa-4cec-a88b-e41d2274dc91')
;

-- Dec 14, 2015 11:08:24 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must match pattern ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:08:24','YYYY-MM-DD HH24:MI:SS'),100,200375,'PASSAY_ALLOWED_MATCH','D','1ac8c4ec-a2cb-4a38-a8b1-8578c3e401ee')
;

-- Dec 14, 2015 11:08:56 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the illegal character ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:08:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:08:55','YYYY-MM-DD HH24:MI:SS'),100,200376,'PASSAY_ILLEGAL_CHAR','D','433b5354-edbd-4932-94f2-cbf19ba5d90b')
;

-- Dec 14, 2015 11:09:50 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the illegal character ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:09:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:09:49','YYYY-MM-DD HH24:MI:SS'),100,200377,'PASSAY_ALLOWED_CHAR','D','39cbed11-50fa-44e8-b01e-b413c76e4142')
;

-- Dec 14, 2015 11:10:23 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the illegal QWERTY sequence ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:10:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:10:23','YYYY-MM-DD HH24:MI:SS'),100,200378,'PASSAY_ILLEGAL_QWERTY_SEQUENCE','D','ffc2a8d0-3845-4786-b67b-426db7c18236')
;

-- Dec 14, 2015 11:10:50 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the illegal alphabetical sequence ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:10:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:10:50','YYYY-MM-DD HH24:MI:SS'),100,200379,'PASSAY_ILLEGAL_ALPHABETICAL_SEQUENCE','D','41318bbd-63be-4f3f-bb12-ab7d7747ee2a')
;

-- Dec 14, 2015 11:11:25 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the illegal numerical sequence ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:11:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:11:24','YYYY-MM-DD HH24:MI:SS'),100,200380,'PASSAY_ILLEGAL_NUMERICAL_SEQUENCE','D','1b80c69c-21eb-4de2-8f60-140962223b70')
;

-- Dec 14, 2015 11:11:56 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the user id ''%1$s''.',0,0,'Y',TO_DATE('2022-03-17 11:11:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:11:55','YYYY-MM-DD HH24:MI:SS'),100,200381,'PASSAY_ILLEGAL_USERNAME','D','0133970b-0e92-4c4c-bf5c-4e14d8ff376a')
;

-- Dec 14, 2015 11:12:29 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password contains the user id ''%1$s'' in reverse.',0,0,'Y',TO_DATE('2022-03-17 11:12:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:12:28','YYYY-MM-DD HH24:MI:SS'),100,200382,'PASSAY_ILLEGAL_USERNAME_REVERSED','D','3b557fee-e24a-41a1-ae56-3038fae42ca3')
;

-- Dec 14, 2015 11:12:58 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password cannot contain whitespace characters.',0,0,'Y',TO_DATE('2022-03-17 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,200383,'PASSAY_ILLEGAL_WHITESPACE','D','3632af0d-8879-429a-bca5-2548a3ef4915')
;

-- Dec 14, 2015 11:13:33 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must contain at least %1$s uppercase characters.',0,0,'Y',TO_DATE('2022-03-17 11:13:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:13:32','YYYY-MM-DD HH24:MI:SS'),100,200384,'PASSAY_INSUFFICIENT_UPPERCASE','D','16196802-52c0-439a-9de2-cd29016b031e')
;

-- Dec 14, 2015 11:14:04 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must contain at least %1$s lowercase characters.',0,0,'Y',TO_DATE('2022-03-17 11:14:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:14:03','YYYY-MM-DD HH24:MI:SS'),100,200385,'PASSAY_INSUFFICIENT_LOWERCASE','D','3bcfef71-06bc-48c8-b2cb-80b7454fb028')
;

-- Dec 14, 2015 11:14:35 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must contain at least %1$s alphabetical characters.',0,0,'Y',TO_DATE('2022-03-17 11:14:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:14:35','YYYY-MM-DD HH24:MI:SS'),100,200386,'PASSAY_INSUFFICIENT_ALPHABETICAL','D','4c7cc4b3-0032-4397-be38-4110a9e339e9')
;

-- Dec 14, 2015 11:15:04 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must contain at least %1$s digit characters.',0,0,'Y',TO_DATE('2022-03-17 11:15:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:15:04','YYYY-MM-DD HH24:MI:SS'),100,200387,'PASSAY_INSUFFICIENT_DIGIT','D','cbaecaf8-952a-412c-8a5d-fcf91968fbe6')
;

-- Dec 14, 2015 11:15:36 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must contain at least %1$s special characters.',0,0,'Y',TO_DATE('2022-03-17 11:15:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:15:35','YYYY-MM-DD HH24:MI:SS'),100,200388,'PASSAY_INSUFFICIENT_SPECIAL','D','d4b976e2-4be9-4b4c-8cbf-90fb3195037d')
;

-- Dec 14, 2015 11:16:04 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password matches %1$s of %3$s character rules, but %2$s are required.',0,0,'Y',TO_DATE('2022-03-17 11:16:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:16:04','YYYY-MM-DD HH24:MI:SS'),100,200389,'PASSAY_INSUFFICIENT_CHARACTERISTICS','D','8ce1d322-9e55-40b3-a4c2-5d45f2587a53')
;

-- Dec 14, 2015 11:16:35 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password cannot be the same as your %1$s password.',0,0,'Y',TO_DATE('2022-03-17 11:16:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:16:34','YYYY-MM-DD HH24:MI:SS'),100,200390,'PASSAY_SOURCE_VIOLATION','D','8cb09106-ee50-4e89-8e8b-498d2280119a')
;

-- Dec 14, 2015 11:17:05 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must be no more than %2$s characters in length.',0,0,'Y',TO_DATE('2022-03-17 11:17:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:17:04','YYYY-MM-DD HH24:MI:SS'),100,200391,'PASSAY_TOO_LONG','D','97114763-4f44-417c-8dae-d207cd0c6f12')
;

-- Dec 14, 2015 11:17:35 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Password must be at least %1$s characters in length.',0,0,'Y',TO_DATE('2022-03-17 11:17:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-03-17 11:17:34','YYYY-MM-DD HH24:MI:SS'),100,200392,'PASSAY_TOO_SHORT','D','3a0aaca0-8727-46df-b196-ddb34e5a7acb')
;

SELECT register_migration_script('202203171131_IDEMPIERE-2975.sql') FROM dual
;
