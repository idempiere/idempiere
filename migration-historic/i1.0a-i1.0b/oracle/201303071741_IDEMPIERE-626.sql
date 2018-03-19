-- Mar 7, 2013 5:39:23 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_Column SET DefaultValue='SYSDATE',Updated=TO_DATE('2013-03-07 17:39:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208572
;

-- Mar 7, 2013 5:39:58 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
ALTER TABLE AD_CtxHelpMsg_Trl MODIFY Created DATE DEFAULT SYSDATE
;

-- Mar 7, 2013 5:40:04 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_CtxHelpMsg_Trl SET Created=SYSDATE WHERE Created IS NULL
;

-- Mar 7, 2013 5:45:58 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_Column SET DefaultValue='SYSDATE',Updated=TO_DATE('2013-03-07 17:45:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208578
;

-- Mar 7, 2013 5:46:09 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
ALTER TABLE AD_CtxHelpMsg_Trl MODIFY Updated DATE DEFAULT SYSDATE
;

-- Mar 7, 2013 5:46:09 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_CtxHelpMsg_Trl SET Updated=SYSDATE WHERE Updated IS NULL
;

SELECT register_migration_script('201303071741_IDEMPIERE-626.sql') FROM dual
;

