-- Aug 25, 2016 8:44:13 PM MYT
-- 1006079 Ease edit of ctx help
UPDATE AD_Process_Para SET DisplayLogic='@AD_UserClient_ID@>0',Updated=TO_TIMESTAMP('2016-08-25 20:44:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200178
;

-- Aug 25, 2016 10:00:40 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_UserClient_ID@>0',Updated=TO_TIMESTAMP('2016-08-25 22:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204263
;

SELECT register_migration_script('201608251800_Ticket_1006079.sql') FROM dual
;

