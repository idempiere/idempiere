-- Jul 26, 2016 4:43:35 PM MYT
-- 1006181 Speed-up windows - Field to show read-only grid
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID.AD_Reference_ID@=200127|@AD_Column_ID.AD_Reference_ID@=200128|@AD_Reference_ID@=200127|@AD_Reference_ID@=200128',Updated=TO_TIMESTAMP('2016-07-26 16:43:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6432
;

-- Jul 26, 2016 4:45:34 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,MsgTip,AD_Message_UU,Updated,Value,IsActive,CreatedBy,AD_Org_ID,AD_Client_ID,Created,UpdatedBy,EntityType) VALUES ('I','Clear Selection',200404,'Clear current selections','af2f6c7a-7f24-46e2-8ae7-0b67ca44890f',TO_TIMESTAMP('2016-07-26 16:45:27','YYYY-MM-DD HH24:MI:SS'),'ClearSelection','Y',100,0,0,TO_TIMESTAMP('2016-07-26 16:45:27','YYYY-MM-DD HH24:MI:SS'),100,'D')
;

SELECT register_migration_script('201607261600_Ticket_1006181.sql') FROM dual
;

