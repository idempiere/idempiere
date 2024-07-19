-- IDEMPIERE-5467
SELECT register_migration_script('202211100946_IDEMPIERE-5467.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 26, 2022, 2:58:22 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','{0} {1,choice,1#|1<{1}} {1,choice,1#Years|-1#Year|1<Years}',0,0,'Y',TO_TIMESTAMP('2022-10-26 14:58:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 14:58:22','YYYY-MM-DD HH24:MI:SS'),100,200798,'DatePickerYear','D','6351efc6-d019-4b00-947d-b8d3d1912ae5')
;

-- Oct 26, 2022, 2:59:19 PM CEST
UPDATE AD_Message SET MsgText='{0} {1,choice,1#|1<{1}}{1,choice,1#Year|1< Years}',Updated=TO_TIMESTAMP('2022-10-26 14:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200798
;

-- Oct 26, 2022, 2:59:42 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','{0} {1,choice,1#|1<{1}}{1,choice,1#Quarter|1< Quarters}',0,0,'Y',TO_TIMESTAMP('2022-10-26 14:59:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 14:59:41','YYYY-MM-DD HH24:MI:SS'),100,200799,'DatePickerQuarter','D','0d9c59b1-920e-4f8b-b91e-2a384f533436')
;

-- Oct 26, 2022, 3:00:01 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','{0} {1,choice,1#|1<{1}}{1,choice,1#Month|1< Months}',0,0,'Y',TO_TIMESTAMP('2022-10-26 15:00:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 15:00:01','YYYY-MM-DD HH24:MI:SS'),100,200800,'DatePickerMonth','D','6e6f414d-b61f-4a36-9809-ecfae6dd62f3')
;

-- Oct 26, 2022, 3:00:23 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','{0} {1,choice,1#|1<{1}}{1,choice,1#Week|1< Weeks}}',0,0,'Y',TO_TIMESTAMP('2022-10-26 15:00:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 15:00:23','YYYY-MM-DD HH24:MI:SS'),100,200801,'DatePickerWeek','D','55769080-f6d8-4f3d-ad85-0ddb6427c6f3')
;

-- Oct 26, 2022, 3:01:13 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','{0} {1,choice,1#|1<{1}}{1,choice,1#Day|1< Days}',0,0,'Y',TO_TIMESTAMP('2022-10-26 15:01:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 15:01:12','YYYY-MM-DD HH24:MI:SS'),100,200802,'DatePickerDay','D','b907b729-11e1-47d2-a2e1-5c60dfcbb264')
;

