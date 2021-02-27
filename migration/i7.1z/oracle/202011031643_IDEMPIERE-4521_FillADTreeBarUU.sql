UPDATE ad_treenodemm SET ad_treenodemm_uu='e4f03c89-33b9-4f20-a6b4-ffef08a936c9' WHERE ad_tree_id=10 AND node_id=200022
;

UPDATE ad_treenodemm SET ad_treenodemm_uu='67b202f9-51a4-4825-af27-d1bc413d75ed' WHERE ad_tree_id=10 AND node_id=383
;

SELECT register_migration_script('202011031643_IDEMPIERE-4521_FillADTreeBarUU.sql') FROM dual
;

