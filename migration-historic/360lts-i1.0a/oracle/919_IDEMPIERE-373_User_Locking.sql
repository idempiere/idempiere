-- Sep 27, 2012 12:32:31 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message SET MsgText='Reached the maximum number of login attempts, user account ({0}) is locked',Updated=TO_DATE('2012-09-27 12:32:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200033
;

-- Sep 27, 2012 12:32:31 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200033
;

-- Sep 27, 2012 12:32:59 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message SET MsgText='User account ({0}) is locked, please contact the system administrator',Updated=TO_DATE('2012-09-27 12:32:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200032
;

-- Sep 27, 2012 12:32:59 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200032
;

SELECT register_migration_script('919_IDEMPIERE-373_User_Locking.sql') FROM dual
;
