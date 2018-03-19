-- Mar 7, 2013 5:39:23 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_Column SET DefaultValue='SYSDATE',Updated=TO_TIMESTAMP('2013-03-07 17:39:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208572
;

-- Mar 7, 2013 5:39:58 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
INSERT INTO t_alter_column values('ad_ctxhelpmsg_trl','Created','TIMESTAMP',null,'now()')
;

-- Mar 7, 2013 5:40:04 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_CtxHelpMsg_Trl SET Created=now() WHERE Created IS NULL
;

-- Mar 7, 2013 5:45:58 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_Column SET DefaultValue='SYSDATE',Updated=TO_TIMESTAMP('2013-03-07 17:45:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208578
;

-- Mar 7, 2013 5:46:09 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
INSERT INTO t_alter_column values('ad_ctxhelpmsg_trl','Updated','TIMESTAMP',null,'now()')
;

-- Mar 7, 2013 5:46:09 PM COT
-- IDEMPIERE-626 Zk: Ticket #1002211: Context help pane
UPDATE AD_CtxHelpMsg_Trl SET Updated=now() WHERE Updated IS NULL
;

SELECT register_migration_script('201303071741_IDEMPIERE-626.sql') FROM dual
;

