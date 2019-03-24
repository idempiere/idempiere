UPDATE ad_treebar SET ad_client_id=(SELECT ad_client_id FROM ad_user WHERE ad_user.ad_user_id=ad_treebar.ad_user_id)
WHERE ad_client_id!=(SELECT ad_client_id FROM ad_user WHERE ad_user.ad_user_id=ad_treebar.ad_user_id);

UPDATE ad_treebar SET ad_org_id=0 WHERE ad_org_id!=0;

SELECT register_migration_script('201903181955_IDEMPIERE-3528.sql') FROM dual
;

