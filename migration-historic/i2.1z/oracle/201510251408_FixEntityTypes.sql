update ad_field set entitytype='D' where ad_field_id in (
203480,
203482,
203483,
203484,
203486,
203485,
203487,
203488);

update ad_column set entitytype='D' where ad_column_id in (
211812,
211814,
211815,
211816,
211817,
211818);

update ad_indexcolumn set entitytype='D' where ad_indexcolumn_id in (
201254,
201255,
201269);
SELECT register_migration_script('201510251408_FixEntityTypes.sql') FROM dual
;

