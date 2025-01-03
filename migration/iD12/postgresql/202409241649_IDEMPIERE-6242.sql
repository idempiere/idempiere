-- IDEMPIERE-6242 Info window, image fieldtype doesn't work
SELECT register_migration_script('202409241649_IDEMPIERE-6242.sql') FROM dual;

-- Sep 24, 2024, 4:49:49 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200251,0,0,TO_TIMESTAMP('2024-09-24 16:49:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-09-24 16:49:48','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_THUMBNAIL_IMAGE_HEIGHT','100','Height of thumbnail image for info window and grid view','D','C','9ecbe9aa-25e0-4933-ba33-50da6f66875a')
;

-- Sep 24, 2024, 4:50:12 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200252,0,0,TO_TIMESTAMP('2024-09-24 16:50:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-09-24 16:50:11','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_THUMBNAIL_IMAGE_WIDTH','100','Width of thumbnail image for info window and grid view','D','C','27ad8a0d-7ffa-4058-9cae-187ffdfc6dfa')
;

-- Sep 24, 2024, 4:52:35 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200271,'Image URL','Web URL of an image','D',0,0,'Y',TO_TIMESTAMP('2024-09-24 16:52:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 16:52:35','YYYY-MM-DD HH24:MI:SS'),100,'D','N','27a6d876-b451-4fdb-ae4b-584ef6022838','N')
;

