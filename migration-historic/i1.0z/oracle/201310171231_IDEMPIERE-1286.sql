SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 17, 2013 12:21:33 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2013-10-17 12:21:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210762
;

SELECT register_migration_script('201310171231_IDEMPIERE-1286.sql') FROM dual
;