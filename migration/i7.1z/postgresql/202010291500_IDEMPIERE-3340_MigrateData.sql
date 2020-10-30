
-- Postgresql Data Migration from AD_TreeBar to AD_Tree_Favorite and AD_Tree_Favorite_Node table
-- Insert TreeBar data to Tree Favorite
INSERT INTO AD_Tree_Favorite
		(AD_Tree_Favorite_ID, 
		AD_Client_ID, AD_Org_ID, AD_User_ID, 
		AD_Role_ID,
		Created, CreatedBy, Updated, UpdatedBy, AD_Tree_Favorite_UU)

SELECT 	(row_number() OVER (ORDER BY AD_Client_ID, AD_User_ID))	+ (SELECT CASE WHEN COALESCE(MAX(AD_Tree_Favorite_ID),0)> 0 THEN COALESCE(MAX(AD_Tree_Favorite_ID),0) ELSE 1000000 END   FROM AD_Tree_Favorite), 
		AD_Client_ID, 0, AD_User_ID,
		(SELECT AD_Role_ID FROM AD_User_Roles WHERE AD_Client_ID = tb.AD_Client_ID AND AD_User_ID = tb.AD_User_ID ORDER BY Created FETCH FIRST 1 ROW ONLY),
		NOW(), 100, NOW(), 100, Generate_UUID()
FROM AD_TreeBar tb
GROUP BY AD_Client_ID, AD_User_ID;


-- Insert TreeBar data to Tree Favorite Node
INSERT INTO AD_Tree_Favorite_Node
		(AD_Client_ID, AD_Menu_ID, AD_Org_ID, 
	 	AD_Tree_Favorite_ID, 
	 	AD_Tree_Favorite_Node_ID, 
	 	AD_Tree_Favorite_Node_UU, Created, CreatedBy, IsSummary, SeqNo, Updated, UpdatedBy, IsFavourite, LoginOpenSeqNo)

SELECT 	AD_Client_ID, Node_ID, AD_Org_ID, 
		(SELECT MAX(AD_Tree_Favorite_ID) FROM AD_Tree_Favorite WHERE AD_Client_ID = tb.AD_Client_ID AND AD_User_ID=tb.AD_User_ID),
		(row_number() OVER (ORDER BY AD_Client_ID, AD_User_ID))	+ (SELECT CASE WHEN COALESCE(MAX(AD_Tree_Favorite_Node_ID),0)> 0 THEN COALESCE(MAX(AD_Tree_Favorite_Node_ID),0) ELSE 1000000 END   FROM AD_Tree_Favorite_Node),
		Generate_UUID(), NOW(), 100, 'N', 0, NOW(), 100, 'Y',LoginOpenSeqNo
FROM AD_TreeBar tb;

SELECT register_migration_script('202010291500_IDEMPIERE-3340_MigrateData.sql') FROM dual
;
