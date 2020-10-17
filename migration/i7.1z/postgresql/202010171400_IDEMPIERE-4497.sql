-- Oct 17, 2020, 1:59:24 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200163,0,0,TO_TIMESTAMP('2020-10-17 13:59:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2020-10-17 13:59:23','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_USE_PDF_JS_VIEWER','N','Y - Use pdf.js viewer for pdf, N - use browser default viewer for pdf.','D','S','b5677027-dde6-4a9d-922b-827849ccd9d4')
;

-- Oct 17, 2020, 9:49:20 PM MYT
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_TIMESTAMP('2020-10-17 21:49:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200163
;

SELECT register_migration_script('202010171400_IDEMPIERE-4497.sql') FROM dual
;

