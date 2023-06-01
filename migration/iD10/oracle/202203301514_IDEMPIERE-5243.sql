-- IDEMPIERE-5243   More columns to increase length
SELECT register_migration_script('202203301514_IDEMPIERE-5243.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 30/03/2022, 3:14:20 p. m. GMT+02:00
UPDATE AD_Column SET AD_Reference_ID=10,FieldLength=4000,Updated=TO_TIMESTAMP('2022-03-30 15:14:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210569
;

-- 30/03/2022, 3:14:30 p. m. GMT+02:00
ALTER TABLE AD_ViewComponent MODIFY FromClause VARCHAR2(4000 CHAR)
;

-- 30/03/2022, 3:17:36 p. m. GMT+02:00
UPDATE AD_Column SET Help='The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses.',Updated=TO_TIMESTAMP('2022-03-30 15:17:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210569
;

-- 30/03/2022, 3:28:27 p. m. GMT+02:00
UPDATE AD_Column SET FieldLength=500, SeqNoSelection=10,Updated=TO_TIMESTAMP('2022-03-30 15:28:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50046
;

-- 30/03/2022, 3:28:38 p. m. GMT+02:00
ALTER TABLE AD_Package_Imp MODIFY Name VARCHAR2(500 CHAR)
;

-- 30/03/2022, 3:37:16 p. m. GMT+02:00
UPDATE AD_Column SET FieldLength=500, SeqNoSelection=10,Updated=TO_TIMESTAMP('2022-03-30 15:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200169
;

-- 30/03/2022, 3:37:24 p. m. GMT+02:00
ALTER TABLE AD_Package_Imp_Proc MODIFY Name VARCHAR2(500 CHAR)
;

