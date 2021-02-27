-- Postgresql Data Migration from AD_TreeBar to AD_Tree_Favorite and AD_Tree_Favorite_Node table
-- Insert TreeBar data to Tree Favorite
INSERT INTO AD_Tree_Favorite (AD_Tree_Favorite_ID, AD_Client_ID, AD_Org_ID, AD_User_ID, Created, CreatedBy, Updated, UpdatedBy, AD_Tree_Favorite_UU)
SELECT 	(row_number() OVER (ORDER BY AD_Client_ID, AD_User_ID))	+ 999999 AS AD_Tree_Favorite_ID, AD_Client_ID, 0, AD_User_ID, SYSDATE, 100, SYSDATE, 100, Generate_UUID()
FROM AD_TreeBar
WHERE AD_User_ID NOT IN (SELECT DISTINCT AD_User_ID FROM AD_Tree_Favorite)
GROUP BY AD_Client_ID, AD_User_ID
;

-- Insert TreeBar data to Tree Favorite Node
INSERT INTO AD_Tree_Favorite_Node (AD_Client_ID, AD_Menu_ID, AD_Org_ID, AD_Tree_Favorite_ID, AD_Tree_Favorite_Node_ID, 
	 	AD_Tree_Favorite_Node_UU, Created, CreatedBy, IsSummary, SeqNo, Updated, UpdatedBy, IsFavourite, LoginOpenSeqNo)
SELECT 	AD_Client_ID, Node_ID, AD_Org_ID, (SELECT AD_Tree_Favorite_ID FROM AD_Tree_Favorite WHERE AD_Client_ID = tb.AD_Client_ID AND AD_User_ID=tb.AD_User_ID) AS AD_Tree_Favorite_ID,
		(row_number() OVER (ORDER BY AD_Client_ID, AD_User_ID))	+ 999999 AD_Tree_Favorite_Node_ID,
		Generate_UUID(), SYSDATE, 100, 'N', 0, SYSDATE, 100, 'Y', LoginOpenSeqNo
FROM AD_TreeBar tb
WHERE (AD_Client_ID, AD_User_ID, Node_ID) NOT IN (SELECT DISTINCT tf.AD_Client_ID, tf.AD_User_ID, tfn.AD_Menu_ID FROM  AD_Tree_Favorite tf INNER JOIN AD_Tree_Favorite_Node tfn ON (tfn.AD_Tree_Favorite_ID = tf.AD_Tree_Favorite_ID) AND tfn.AD_Menu_ID>0)
ORDER BY AD_Client_ID, AD_User_ID
;

SELECT register_migration_script('202011101100_IDEMPIERE-3340_MigrateData.sql') FROM dual
;
