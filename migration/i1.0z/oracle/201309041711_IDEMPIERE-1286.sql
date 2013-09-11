SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 4, 2013 5:07:27 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_SysConfig SET Value=' ', Description='Enable address validation by country codes  - separated by semicolons',Updated=TO_DATE('2013-09-04 17:07:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200033
;

-- Sep 4, 2013 5:09:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Address validation call is not enabled for this country',200226,'D','8ca0038d-ded5-4862-b517-afff6671dfd2','AddressValidationNotEnabledForCountry','Y',TO_DATE('2013-09-04 17:09:22','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-09-04 17:09:22','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201309041711_IDEMPIERE-1286.sql') FROM dual
;