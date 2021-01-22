UPDATE ad_treebar SET ad_treebar_uu='37767381-de38-4723-8fd0-ef8fae5b7019' WHERE ad_tree_id=10 AND node_id=200022 AND ad_user_id=100;

UPDATE ad_treebar SET ad_treebar_uu='27c2dccf-fc7a-4a06-ba22-dbabda09c72c' WHERE ad_tree_id=10 AND node_id=383 AND ad_user_id=100;

SELECT register_migration_script('202012200821_FillADTreeBarUU.sql') FROM dual
;

