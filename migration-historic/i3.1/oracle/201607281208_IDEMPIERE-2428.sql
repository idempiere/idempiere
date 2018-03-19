SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2428
-- Jul 28, 2016 12:08:00 PM CEST
drop index m_inoutlinema_key;

SELECT register_migration_script('201607281208_IDEMPIERE-2428.sql') FROM dual
;
