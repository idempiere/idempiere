-- IDEMPIERE-2395 - clean orphan ad_note in seed
DELETE FROM ad_note WHERE ad_table_id=53043 AND record_id NOT IN (SELECT PP_MRP_ID FROM PP_MRP);

DELETE FROM ad_attachment WHERE ad_table_id=389 AND record_id NOT IN (SELECT ad_note_id FROM ad_note);

DELETE FROM ad_treenodecmt WHERE node_id>0 AND node_id NOT IN (SELECT cm_template_id FROM cm_template);

SELECT register_migration_script('201903191017_IDEMPIERE-2395.sql') FROM dual
;

