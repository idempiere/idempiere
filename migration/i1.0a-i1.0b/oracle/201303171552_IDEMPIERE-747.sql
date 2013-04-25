-- Mar 17, 2013 3:51:32 PM COT
UPDATE AD_Message SET MsgText='Confirm New EMail User Password', Value='New EMail PW Confirm',Updated=TO_DATE('2013-03-17 15:51:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200070
;

-- Mar 17, 2013 3:51:33 PM COT
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200070
;

SELECT register_migration_script('201303171552_IDEMPIERE-747.sql') FROM dual
;

