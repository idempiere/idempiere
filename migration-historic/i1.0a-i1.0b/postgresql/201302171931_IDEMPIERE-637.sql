-- 17.02.2013 19:27:25 MEZ
-- IDEMPIERE-637 GL Journal: Accounting Dimension "User Element 1&2" not posted to Accounting Facts
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-17 19:27:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200178
;

-- 17.02.2013 19:27:34 MEZ
-- IDEMPIERE-637 GL Journal: Accounting Dimension "User Element 1&2" not posted to Accounting Facts
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-17 19:27:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200179
;

-- 17.02.2013 19:28:19 MEZ
-- IDEMPIERE-637 GL Journal: Accounting Dimension "User Element 1&2" not posted to Accounting Facts
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-17 19:28:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200234
;

-- 17.02.2013 19:28:27 MEZ
-- IDEMPIERE-637 GL Journal: Accounting Dimension "User Element 1&2" not posted to Accounting Facts
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-17 19:28:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200235
;

-- 17.02.2013 19:28:51 MEZ
-- IDEMPIERE-637 GL Journal: Accounting Dimension "User Element 1&2" not posted to Accounting Facts
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-17 19:28:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200229
;

-- 17.02.2013 19:28:55 MEZ
-- IDEMPIERE-637 GL Journal: Accounting Dimension "User Element 1&2" not posted to Accounting Facts
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-17 19:28:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200230
;

ALTER TABLE gl_journalline DROP COLUMN userelement1_id
;

ALTER TABLE gl_journalline DROP COLUMN userelement2_id
;

SELECT register_migration_script('201302171931_IDEMPIERE-637.sql') FROM dual
;
