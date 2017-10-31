-- IDEMPIERE-3438
update ad_field set isdisplayedgrid='N' where ad_field_id in (
204231,
204253
);

SELECT register_migration_script('201710312152_IDEMPIERE-3438.sql') FROM dual
;

