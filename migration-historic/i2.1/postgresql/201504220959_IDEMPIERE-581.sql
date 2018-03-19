delete from ad_preference where ad_user_id is null and (attribute like '%|DetailPane.Height' or attribute like '%|DetailPane.IsOpen')
;

SELECT register_migration_script('201504220959_IDEMPIERE-581.sql') FROM dual
;

