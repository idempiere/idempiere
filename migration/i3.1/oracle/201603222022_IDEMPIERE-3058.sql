SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3058 Make 2Pack transaction safe (for postgres)
-- Mar 22, 2016 7:30:44 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200076,0,0,TO_DATE('2016-03-22 19:30:38','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-03-22 19:30:38','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','2PACK_COMMIT_DDL','N','If set to Y 2Pack tries to behave in PostgreSQL same as with Oracle - committing before and after DDL statements','D','S','112f7659-c30f-45df-a505-ba85c4b6f83a')
;

-- Mar 22, 2016 8:30:02 PM CET
UPDATE AD_Column SET AD_Reference_ID=30, FKConstraintType=NULL,Updated=TO_DATE('2016-03-22 20:30:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50025
;

-- Mar 22, 2016 9:59:58 PM CET
UPDATE AD_Column SET FieldLength=2000,Updated=TO_DATE('2016-03-22 21:59:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50073
;

-- Mar 22, 2016 10:00:02 PM CET
ALTER TABLE AD_Package_Imp_Detail MODIFY Name NVARCHAR2(2000) DEFAULT NULL 
;

SELECT register_migration_script('201603222022_IDEMPIERE-3058.sql') FROM dual
;

