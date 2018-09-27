SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2652 default value of ad_ctxhelpmsg_trl.create and ad_ctxhelpmsg_trl.update should now()
-- Sep 8, 2018 4:14:56 PM CEST
ALTER TABLE AD_CtxHelpMsg_Trl MODIFY Created DATE DEFAULT SYSDATE
;

-- Sep 8, 2018 4:15:28 PM CEST
ALTER TABLE AD_CtxHelpMsg_Trl MODIFY Updated DATE DEFAULT SYSDATE
;

SELECT register_migration_script('201809081618_IDEMPIERE-2652.sql') FROM dual
;

