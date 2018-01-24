-- IDEMPIERE-3352
update ad_field set entitytype='D' where ad_field_id in (
204438
);

SELECT register_migration_script('201710312201_IDEMPIERE-3352.sql') FROM dual
;

