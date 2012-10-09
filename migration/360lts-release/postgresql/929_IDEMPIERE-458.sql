-- IDEMPIERE-458 Invalid indirect foreign keys on GardenWorld
delete from ad_treenode where ad_tree_id=102 and node_id not in (select m_product_id from m_product)
;

delete from ad_treenode where ad_tree_id=103 and node_id not in (select c_bpartner_id from c_bpartner)
;

delete from ad_treenode where ad_tree_id=101 and node_id not in (select c_elementvalue_id from c_elementvalue)
;

SELECT register_migration_script('929_IDEMPIERE-458.sql') FROM dual
;

