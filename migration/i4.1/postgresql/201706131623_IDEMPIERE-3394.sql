-- IDEMPIERE-3394 Allow defining web service type in System and extend in Tenant
-- Jun 13, 2017 4:19:26 PM CEST
UPDATE AD_Column SET DefaultValue='@#AD_Client_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 16:19:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56766
;

-- Jun 13, 2017 4:19:38 PM CEST
UPDATE AD_Column SET DefaultValue='@#AD_Org_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 16:19:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56767
;

-- Jun 13, 2017 5:54:59 PM CEST
UPDATE AD_Column SET DefaultValue='@AD_Client_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 17:54:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56734
;

-- Jun 13, 2017 5:55:04 PM CEST
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 17:55:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56735
;

-- Jun 13, 2017 5:55:21 PM CEST
UPDATE AD_Column SET DefaultValue='@AD_Client_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 17:55:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56746
;

-- Jun 13, 2017 5:55:28 PM CEST
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 17:55:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56747
;

-- Jun 13, 2017 5:55:44 PM CEST
UPDATE AD_Column SET DefaultValue='@AD_Client_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 17:55:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56756
;

-- Jun 13, 2017 5:55:51 PM CEST
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsToolbarButton='N',Updated=TO_TIMESTAMP('2017-06-13 17:55:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56758
;

SELECT register_migration_script('201706131623_IDEMPIERE-3394.sql') FROM dual
;

