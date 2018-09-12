-- IDEMPIERE-3757
-- Jul 24, 2018 9:30:27 AM CEST
UPDATE AD_Table SET AccessLevel='4',Updated=TO_TIMESTAMP('2018-07-24 09:30:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=116
;

DELETE FROM ad_window_access WHERE ad_window_id=105
AND ad_role_id IN (SELECT ad_role_id FROM ad_role WHERE ismanual='N' AND userlevel NOT LIKE 'S%')
;

SELECT register_migration_script('201807240936_IDEMPIERE-3757.sql') FROM dual
;

