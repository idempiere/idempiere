-- IDEMPIERE-1052 Improve Performance using Search instead of Table/Table Direct
-- Oct 31, 2017 5:15:03 PM CET
UPDATE AD_Column SET AD_Reference_ID=30, IsUpdateable='N', FKConstraintType=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:15:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8814
;

SELECT register_migration_script('201710311719_IDEMPIERE-1052.sql') FROM dual
;

