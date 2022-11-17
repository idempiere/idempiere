-- IDEMPIERE-5443
SELECT register_migration_script('202210251555_IDEMPIERE-5443.sql') FROM dual;

-- Oct 25, 2022, 3:55:13 PM CEST
UPDATE AD_Message SET MsgText='Range',Updated=TO_TIMESTAMP('2022-10-25 15:55:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200796
;

-- Oct 25, 2022, 3:55:43 PM CEST
UPDATE AD_Message SET MsgText='Apply', Value='ApplyFilter',Updated=TO_TIMESTAMP('2022-10-25 15:55:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200793
;

-- Oct 25, 2022, 4:15:00 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','End Date must be after Start Date',0,0,'Y',TO_TIMESTAMP('2022-10-25 16:14:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-25 16:14:59','YYYY-MM-DD HH24:MI:SS'),100,200797,'EndDateAfterStartDate','D','9d7aa27f-ec1f-407f-bbf0-6659885c7b80')
;

