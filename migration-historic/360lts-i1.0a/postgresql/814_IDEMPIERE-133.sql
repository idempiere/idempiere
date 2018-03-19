-- Feb 5, 2012 12:56:29 PM COT
-- IDEMPIERE-133 Make Zk report type configurable per client and org
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200002,'D','O','ZK_REPORT_FORM_OUTPUT_TYPE','PDF','Type of output in zkwebui for reports of type form, possible values are PDF, HTML, XLS',0,0,TO_TIMESTAMP('2012-02-05 12:56:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-05 12:56:28','YYYY-MM-DD HH24:MI:SS'),0,0,'Y')
;

-- Feb 5, 2012 12:56:54 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200003,'D','O','ZK_REPORT_TABLE_OUTPUT_TYPE','PDF','Type of output in zkwebui for reports of type table, possible values are PDF, HTML, XLS',0,0,TO_TIMESTAMP('2012-02-05 12:56:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-05 12:56:54','YYYY-MM-DD HH24:MI:SS'),0,0,'Y')
;

