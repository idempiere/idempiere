-- Mar 16, 2014 1:24:36 PM ICT
-- IDEMPIERE-1619 Link on third tab pointing to field on first tab instead of second
UPDATE AD_Column SET IsUpdateable='N', DefaultValue='@1|AD_WF_Node_ID@',Updated=TO_TIMESTAMP('2014-03-16 13:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10426
;

-- Mar 16, 2014 1:25:39 PM ICT
UPDATE AD_Column SET IsUpdateable='N', DefaultValue='@1|AD_WF_Node_ID@',Updated=TO_TIMESTAMP('2014-03-16 13:25:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=304
;

UPDATE AD_Column SET IsUpdateable='N', DefaultValue='@4|AD_WF_NodeNext_ID@',Updated=TO_TIMESTAMP('2014-03-20 02:22:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11571
;

SELECT register_migration_script('201403161604_IDEMPIERE-1619.sql') FROM dual
;
