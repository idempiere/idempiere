SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 16, 2014 8:32:31 AM COT
-- IDEMPIERE-2055 Changed Constraints for Web Service Security
UPDATE AD_Column SET IsUpdateable='N', IsToolbarButton='N', FKConstraintType='C',Updated=TO_DATE('2014-07-16 08:32:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56769
;

-- Jul 16, 2014 8:32:49 AM COT
ALTER TABLE WS_WebServiceTypeAccess DROP CONSTRAINT wswebservicetype_wswebservicet
;

-- Jul 16, 2014 8:32:50 AM COT
ALTER TABLE WS_WebServiceTypeAccess ADD CONSTRAINT wswebservicetype_wswebservicet FOREIGN KEY (WS_WebServiceType_ID) REFERENCES ws_webservicetype(ws_webservicetype_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201407160833_IDEMPIERE-2055.sql') FROM dual
;

