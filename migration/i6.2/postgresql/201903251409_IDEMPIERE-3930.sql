-- IDEMPIERE-3930 Allow permission control for idempiereMonitor and OSGI console
-- Mar 25, 2019, 12:20:18 PM BRT
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200011,0,0,'Y',TO_TIMESTAMP('2019-03-25 12:20:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-25 12:20:17','YYYY-MM-DD HH24:MI:SS'),100,'idempiereMonitor','Form to configure access to /idempiereMonitor - do not add to menu','/idempiereMonitor','4','D','N','3406efc3-aa1d-4212-bb5d-6d64ee39cc61')
;

-- Mar 25, 2019, 12:21:15 PM BRT
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200012,0,0,'Y',TO_TIMESTAMP('2019-03-25 12:21:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-25 12:21:15','YYYY-MM-DD HH24:MI:SS'),100,'Apache Felix Web Console','Form to configure access to /osgi/system/console - do not add to menu','/osgi/system/console','4','D','N','bb212a96-e71d-4deb-98eb-799c74247c96')
;

SELECT register_migration_script('201903251409_IDEMPIERE-3930.sql') FROM dual
;

