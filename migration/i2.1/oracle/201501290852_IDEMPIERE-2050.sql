SET SQLBLANKLINES ON
SET DEFINE OFF

-- 29/01/2015 08:52:11 AM COT
-- IDEMPIERE-2050 Improvement to Menu Lookup
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200060,0,0,TO_DATE('2015-01-29 08:52:10','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-01-29 08:52:10','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER','3','Max results in document controller search (IDEMPIERE-2050)','D','C','2342e731-5157-42c3-986b-28ed24862694')
;

SELECT register_migration_script('201501290852_IDEMPIERE-2050.sql') FROM dual
;

