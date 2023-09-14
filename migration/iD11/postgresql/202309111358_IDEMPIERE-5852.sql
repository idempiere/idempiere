-- IDEMPIERE-3989
SELECT register_migration_script('202309111358_IDEMPIERE-5852.sql') FROM dual;

-- Sep 11, 2023, 1:58:52 PM BRT
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_TIMESTAMP('2023-09-11 13:58:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200985
;

-- Sep 11, 2023, 1:58:58 PM BRT
INSERT INTO t_alter_column values('ad_broadcastmessage','BroadcastMessage','TEXT',null,null)
;

-- Sep 11, 2023, 1:59:52 PM BRT
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2023-09-11 13:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211151
;

-- Sep 11, 2023, 1:59:58 PM BRT
INSERT INTO t_alter_column values('ad_broadcastmessage_trl','BroadcastMessage','TEXT',null,null)
;

-- 14/09/2023, 12:52:20 p. m. GMT+02:00
UPDATE AD_Column SET IsAlwaysUpdateable='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2023-09-14 12:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200979
;

