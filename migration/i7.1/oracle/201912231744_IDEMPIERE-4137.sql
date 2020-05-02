SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4137 : Allocation report should display C_AllocationHdr.DocumentNo instead of C_AllocationHdr.C_AllocationHdr_ID
-- 2019-12-23 05:43:34
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_DATE('2019-12-23 17:43:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=12378
;

SELECT register_migration_script('201912231744_IDEMPIERE-4137.sql') FROM dual
;
