-- fill UUIDs
UPDATE ad_treenodemm SET ad_treenodemm_uu='222ca6e9-bb2a-4c2d-872e-2bbd08043288' WHERE ad_tree_id=10 AND node_id=200143;

UPDATE ad_treenodemm SET ad_treenodemm_uu='0e8a37ce-6162-463c-a98c-2c140d92ff27' WHERE ad_tree_id=10 AND node_id=200144;

UPDATE ad_treenodemm SET ad_treenodemm_uu='53a983a3-84a4-4899-ad6a-ee1452b9c610' WHERE ad_tree_id=10 AND node_id=200147;

UPDATE ad_treenodemm SET ad_treenodemm_uu='1b3bc968-83ac-409c-956d-d6d945aa3812' WHERE ad_tree_id=10 AND node_id=200148;

SELECT register_migration_script('201710312216_FillUUIDs.sql') FROM dual
;

