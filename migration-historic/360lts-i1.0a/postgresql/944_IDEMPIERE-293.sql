-- IDEMPIERE-293-List of logged users
-- Fix error on script 935_IDEMPIERE-293.sql
UPDATE AD_TreeNodeMM SET Parent_ID=53296, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=228
;

UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53083
;

SELECT register_migration_script('944_IDEMPIERE-293.sql') FROM dual
;

