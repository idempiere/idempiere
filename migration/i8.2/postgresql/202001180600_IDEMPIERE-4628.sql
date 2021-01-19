-- Jan 18, 2021, 1:40:41 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200169,0,0,TO_TIMESTAMP('2021-01-18 13:40:40','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-01-18 13:40:40','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_INFO_QUERY_TIME_OUT','120','Query timeout in seconds for info window. 0 means no timeout.','D','C','f5953385-1c8a-4df2-92dd-ad46aaeefb8e')
;

-- Jan 18, 2021, 1:47:51 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The search took too long to return results. Please refine your search criteria.',0,0,'Y',TO_TIMESTAMP('2021-01-18 13:47:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-18 13:47:50','YYYY-MM-DD HH24:MI:SS'),100,200655,'INFO_QUERY_TIME_OUT_ERROR','D','ea2c33af-7c98-4208-8ed0-ea59b7f0ec58')
;

-- Jan 18, 2021, 2:20:33 PM MYT
UPDATE AD_Message SET Value='InfoQueryTimeOutError',Updated=TO_TIMESTAMP('2021-01-18 14:20:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200655
;

SELECT register_migration_script('202001180600_IDEMPIERE-4628.sql') FROM dual
;
