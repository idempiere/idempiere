-- IDEMPIERE-5697 Improve Process Log for more advanced logging options for Processes
SELECT register_migration_script('202305020845_IDEMPIERE-5697.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 14, 2023, 3:28:54 PM CET
UPDATE AD_TableIndex SET Name='ad_pinstance_log_uu_idx',Updated=TO_TIMESTAMP('2023-12-14 15:28:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=200138
;

-- Dec 14, 2023, 1:55:11 PM CET
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2023-12-14 13:55:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8779
;

-- Dec 14, 2023, 1:55:41 PM CET
UPDATE AD_TableIndex SET IsKey='N',Updated=TO_TIMESTAMP('2023-12-14 13:55:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=200138
;

-- Dec 14, 2023, 1:55:45 PM CET
ALTER TABLE AD_PInstance_Log DROP CONSTRAINT ad_pinstance_log_uu CASCADE
;

-- Dec 14, 2023, 1:55:49 PM CET
ALTER TABLE AD_PInstance_Log ADD CONSTRAINT ad_pinstance_log_uu_idx UNIQUE (AD_PInstance_Log_UU)
;

-- Dec 14, 2023, 1:56:20 PM CET
ALTER TABLE AD_PInstance_Log MODIFY AD_PInstance_Log_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Dec 14, 2023, 1:56:20 PM CET
-- ALTER TABLE AD_PInstance_Log MODIFY AD_PInstance_Log_UU NULL
-- ;

