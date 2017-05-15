-- IDEMPIERE-3358 Dictionary fixes - ASP Indexes
DROP INDEX asp_clientlevel_unq
;

CREATE UNIQUE INDEX asp_clientlevel_unq ON ASP_ClientLevel (AD_Client_ID,ASP_Level_ID)
;

SELECT register_migration_script('201705121535_IDEMPIERE-3358_ASP_indexes.sql') FROM dual
;

