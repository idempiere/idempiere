-- Mar 16, 2014 1:47:55 PM ICT
-- IDEMPIERE-1820 node parameter tab (in workfow window) should hidden when not need
UPDATE AD_Tab SET DisplayLogic='@Action@=P|@Action@=R',Updated=TO_TIMESTAMP('2015-09-28 09:48:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=577
;
SELECT register_migration_script('201509280947_IDEMPIERE-1820.sql') FROM dual
;
