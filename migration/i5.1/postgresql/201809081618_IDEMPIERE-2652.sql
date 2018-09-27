-- IDEMPIERE-2652 default value of ad_ctxhelpmsg_trl.create and ad_ctxhelpmsg_trl.update should now()
-- Sep 8, 2018 4:14:56 PM CEST
INSERT INTO t_alter_column values('ad_ctxhelpmsg_trl','Created','TIMESTAMP',null,'statement_timestamp()')
;

-- Sep 8, 2018 4:15:28 PM CEST
INSERT INTO t_alter_column values('ad_ctxhelpmsg_trl','Updated','TIMESTAMP',null,'statement_timestamp()')
;

SELECT register_migration_script('201809081618_IDEMPIERE-2652.sql') FROM dual
;

