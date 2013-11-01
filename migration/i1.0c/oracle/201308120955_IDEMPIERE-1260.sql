-- Aug 12, 2013 5:52:23 PM MYT
-- IDEMPIERE-1207 Fixed inconsistent error message for well known database exception
UPDATE AD_Column SET IsUpdateable='N', DefaultValue=NULL,Updated=TO_DATE('2013-08-12 17:52:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2705
;

SELECT register_migration_script('201308120955_IDEMPIERE-1260.sql') FROM dual
;

