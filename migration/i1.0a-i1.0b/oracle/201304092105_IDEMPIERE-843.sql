-- Apr 9, 2013 8:52:09 PM COT
-- IDEMPIERE-843 Negative values are not evaluated in Tab Editor
UPDATE AD_Column SET ValueMin='1',Updated=TO_DATE('2013-04-09 20:52:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200351
;

-- Apr 9, 2013 8:52:37 PM COT
UPDATE AD_Column SET ValueMin='1',Updated=TO_DATE('2013-04-09 20:52:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200352
;

-- Apr 9, 2013 8:53:07 PM COT
UPDATE AD_Column SET ValueMin='1',Updated=TO_DATE('2013-04-09 20:53:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200354
;

SELECT register_migration_script('201304092105_IDEMPIERE-843.sql') FROM dual
;

