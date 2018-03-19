update ad_system set name='iDempiere' where name='?'
;

SELECT register_migration_script('201410291142_IDEMPIERE-2260.sql') FROM dual
;

