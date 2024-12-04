-- IDEMPIERE-6326 Rename "Automatic Commit" user preference to "Save on Navigate"
SELECT register_migration_script('202412032123_IDEMPIERE-6326.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 3, 2024, 9:23:08 PM MYT
UPDATE AD_Message SET MsgText='Save on Navigate', MsgTip='Automatically save changes to the current record when the user navigates to another record, switches to a detail tab, or performs an action (e.g., running a process) that requires saving the current changes.',Updated=TO_TIMESTAMP('2024-12-03 21:23:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=155
;

