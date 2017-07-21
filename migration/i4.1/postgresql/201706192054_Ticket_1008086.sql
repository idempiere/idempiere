-- Jun 19, 2017 8:54:41 PM CEST
-- 2Pack Semaphore
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Updated,Value,AD_SysConfig_UU,IsActive,Name,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID) VALUES (200098,'D','S',TO_TIMESTAMP('2017-06-19 20:54:40','YYYY-MM-DD HH24:MI:SS'),'AUTOMATIC_PACKIN_PROCESSING','cba425fc-4e0e-4a45-bc14-281a98a52c81','Y','AUTOMATIC_PACKIN_PROCESSING',TO_TIMESTAMP('2017-06-19 20:54:40','YYYY-MM-DD HH24:MI:SS'),0,100,100,0)
;

-- Jun 19, 2017 8:55:06 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Updated,Value,AD_SysConfig_UU,IsActive,Name,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID) VALUES (200099,'D','S',TO_TIMESTAMP('2017-06-19 20:55:05','YYYY-MM-DD HH24:MI:SS'),'120','2dd1b89a-936e-47aa-b7e6-3b66649ed224','Y','AUTOMATIC_PACKIN_TIMEOUT',TO_TIMESTAMP('2017-06-19 20:55:05','YYYY-MM-DD HH24:MI:SS'),0,100,100,0)
;

INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Updated,Value,AD_SysConfig_UU,IsActive,Name,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID) VALUES (200100,'D','S',TO_TIMESTAMP('2017-06-20 12:12:07','YYYY-MM-DD HH24:MI:SS'),'5','49244d58-3306-4a38-9458-7fa8616214c2','Y','AUTOMATIC_PACKIN_RETRIES',TO_TIMESTAMP('2017-06-20 12:12:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,0)
;

SELECT register_migration_script('201706192054_Ticket_1008086.sql') FROM dual
;
