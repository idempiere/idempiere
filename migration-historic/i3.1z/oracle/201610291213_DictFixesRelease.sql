update ad_column set entitytype='D' where ad_column_id=211840;

update ad_field set entitytype='D' where ad_field_id=203499;

update ad_val_rule set entitytype='D' where ad_val_rule_id=200082;

SELECT register_migration_script('201610291213_DictFixesRelease.sql') FROM dual
;

