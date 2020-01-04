-- IDEMPIERE-2924  Export to XLS limited to 65536
-- Jan 4, 2020, 3:56:13 PM CET
UPDATE AD_SysConfig SET Description='Type of output in zkwebui for reports of type form, possible values are PDF, HTML, XLS, CSV, XLSX',Updated=TO_TIMESTAMP('2020-01-04 15:56:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200002
;

-- Jan 4, 2020, 3:56:18 PM CET
UPDATE AD_SysConfig SET Description='Type of output in zkwebui for jasper reports, possible values are PDF, HTML, XLS, CSV, SSV, XLSX',Updated=TO_TIMESTAMP('2020-01-04 15:56:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200030
;

-- Jan 4, 2020, 3:56:21 PM CET
UPDATE AD_SysConfig SET Description='Type of output in zkwebui for reports of type table, possible values are PDF, HTML, XLS, CSV, XLSX',Updated=TO_TIMESTAMP('2020-01-04 15:56:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200003
;

-- Jan 4, 2020, 4:09:08 PM CET
UPDATE AD_Ref_List SET Name='XLS',Updated=TO_TIMESTAMP('2020-01-04 16:09:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200472
;

-- Jan 4, 2020, 4:09:17 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200491,'XLSX',200169,'XLSX',0,0,'Y',TO_TIMESTAMP('2020-01-04 16:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-01-04 16:09:16','YYYY-MM-DD HH24:MI:SS'),100,'D','2ebce9b0-ffa1-429d-aa8e-42be54bc161b')
;

SELECT register_migration_script('202001041556_IDEMPIERE-2924.sql') FROM dual
;

