-- fix wrong entity types
update ad_column set entitytype='D' where ad_column_id in (210647,210648,210649,210849)
;

update ad_field set entitytype='D' where ad_field_id in (202285,202479,202478)
;

update ad_element set entitytype='D' where ad_element_id in (202566,202567,202568)
;

SELECT register_migration_script('201310311828_ReleaseQA_IDEMPIERE-1157.sql') FROM dual
;

