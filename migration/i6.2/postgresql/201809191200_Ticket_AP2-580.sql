-- Sep 19, 2018 3:29:19 PM MYT
-- AP2-580 remove mandatory location on BP quick entry on OFX Transaction
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Updated,Description,AD_SysConfig_UU,IsActive,Name,Created,CreatedBy,UpdatedBy,AD_Client_ID,Value,AD_Org_ID) VALUES (200145,'D','S',TO_TIMESTAMP('2018-09-19 15:29:13','YYYY-MM-DD HH24:MI:SS'),'Comma separated list of tables where business partner location is optional for quick entry of business partner record','17facb7e-bab8-4c92-a6c6-e7db0ae427a1','Y','BPARTNER_QUICK_ENTRY_OPTIONAL_LOCATION_TABLES',TO_TIMESTAMP('2018-09-19 15:29:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,'C_Payment',0)
;

SELECT register_migration_script('201809191200_Ticket_AP2-580.sql') FROM dual
;

