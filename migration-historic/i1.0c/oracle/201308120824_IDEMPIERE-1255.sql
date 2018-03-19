-- Aug 12, 2013 4:21:30 PM MYT
-- IDEMPIERE-1207 Fixed inconsistent error message for well known database exception
UPDATE AD_Column SET DefaultValue='@#AD_Client_ID@',Updated=TO_DATE('2013-08-12 16:21:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5163
;

-- Aug 12, 2013 4:21:53 PM MYT
-- IDEMPIERE-1207 Fixed inconsistent error message for well known database exception
UPDATE AD_Column SET DefaultValue='@#AD_Org_ID@',Updated=TO_DATE('2013-08-12 16:21:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5164
;

SELECT register_migration_script('201308120824_IDEMPIERE-1255.sql') FROM dual
;

