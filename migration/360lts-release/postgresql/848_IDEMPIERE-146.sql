-- Jun 30, 2012 9:04:20 AM MYT
-- IDEMPIERE-146 Performance: Report Engine always read all data into memory
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_SysConfig_UU,ConfigurationLevel,Value,Description,EntityType,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,Name) VALUES (200010,'794a49c8-c127-4e9c-bb3f-7be83f42aa48','S','2000','Use swap file when report data exceed the number of rows define here. Enter a value of zero or less if you don''t want to use swap file for all reports regarding the number of rows involved','D',0,TO_TIMESTAMP('2012-06-30 09:04:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-06-30 09:04:18','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y','REPORT_SWAP_MAX_ROWS')
;

-- Jun 30, 2012 9:09:35 AM MYT
-- IDEMPIERE-146 Performance: Report Engine always read all data into memory
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_SysConfig_UU,ConfigurationLevel,Value,Description,EntityType,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,Name) VALUES (200011,'2f885a17-b05f-4744-a617-20e8449c22df','S','100','Max number of pages to keep in memory when rendering a jasper report','D',0,TO_TIMESTAMP('2012-06-30 09:09:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-06-30 09:09:34','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y','JASPER_REPORT_SWAP_MAX_PAGES')
;

UPDATE AD_System
  SET LastMigrationScriptApplied='848_IDEMPIERE-146.sql'
WHERE LastMigrationScriptApplied<'848_IDEMPIERE-146.sql'
   OR LastMigrationScriptApplied IS NULL
;

