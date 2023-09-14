-- IDEMPIERE-3989
SELECT register_migration_script('202309111358_IDEMPIERE-5852.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 11, 2023, 1:58:52 PM BRT
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_TIMESTAMP('2023-09-11 13:58:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200985
;

-- Sep 11, 2023, 1:58:58 PM BRT
ALTER TABLE AD_BroadcastMessage ADD (Tmp_BroadcastMessage_ToRename CLOB);
UPDATE AD_BroadcastMessage SET Tmp_BroadcastMessage_ToRename = BroadcastMessage;
ALTER TABLE AD_BroadcastMessage DROP COLUMN BroadcastMessage;
ALTER TABLE AD_BroadcastMessage RENAME COLUMN Tmp_BroadcastMessage_ToRename TO BroadcastMessage;

-- Sep 11, 2023, 1:59:52 PM BRT
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2023-09-11 13:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211151
;

-- Sep 11, 2023, 1:59:58 PM BRT
ALTER TABLE AD_BroadcastMessage_Trl ADD (Tmp_BroadcastMessage_ToRename CLOB);
UPDATE AD_BroadcastMessage_Trl SET Tmp_BroadcastMessage_ToRename = BroadcastMessage;
ALTER TABLE AD_BroadcastMessage_Trl DROP COLUMN BroadcastMessage;
ALTER TABLE AD_BroadcastMessage_Trl RENAME COLUMN Tmp_BroadcastMessage_ToRename TO BroadcastMessage;

-- 14/09/2023, 12:52:19 p. m. GMT+02:00
UPDATE AD_Column SET IsAlwaysUpdateable='Y', IsToolbarButton='N',Updated=TO_DATE('2023-09-14 12:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200979
;

