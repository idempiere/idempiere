-- Mar 21, 2013 4:18:58 PM MYT
-- IDEMPIERE-763 Maximum size for File Upload
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200028,'D','S','5120','It specifies the maximum allowed size, in kilobytes, to upload a file from the client. A zero or negative value indicates that there is no limit.','6f5a2d67-123a-411e-a218-1c328e963cc4',TO_DATE('2013-03-21 16:18:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-21 16:18:55','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'ZK_MAX_UPLOAD_SIZE')
;

SELECT register_migration_script('201303210824_IDEMPIERE-763.sql') FROM dual
;

