SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 3, 2013 11:16:28 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET IsFieldOnly='Y',Updated=TO_DATE('2013-10-03 11:16:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62235
;

-- Oct 3, 2013 11:16:46 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET IsFieldOnly='Y',Updated=TO_DATE('2013-10-03 11:16:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62456
;

-- Oct 3, 2013 11:16:56 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET IsFieldOnly='Y',Updated=TO_DATE('2013-10-03 11:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62855
;

-- Oct 3, 2013 11:17:08 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET IsFieldOnly='Y',Updated=TO_DATE('2013-10-03 11:17:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=63001
;

-- Oct 3, 2013 11:18:57 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET ColumnSpan=3,Updated=TO_DATE('2013-10-03 11:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=63001
;

-- Oct 3, 2013 11:19:11 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET ColumnSpan=3,Updated=TO_DATE('2013-10-03 11:19:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62855
;

-- Oct 3, 2013 11:19:25 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET ColumnSpan=3,Updated=TO_DATE('2013-10-03 11:19:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62456
;

-- Oct 3, 2013 11:19:37 AM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET ColumnSpan=3,Updated=TO_DATE('2013-10-03 11:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62235
;

SELECT register_migration_script('201310030605_IDEMPIERE-1265.sql') FROM dual
;

