SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 5, 2021, 7:38:10 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200176,0,0,TO_DATE('2021-07-05 19:38:10','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-07-05 19:38:10','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_ADVANCE_FIND_FILTER_COLUMN_LIST','N','Y/N - Define if the advance find column list is filter by user input','D','C','cc532902-6f11-40e5-962a-e8af896544e0')
;

SELECT Register_Migration_Script ('202107051142_IDEMPIERE-4865.sql') FROM DUAL
;

