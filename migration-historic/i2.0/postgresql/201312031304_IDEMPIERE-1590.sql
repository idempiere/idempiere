-- Dec 3, 2013 1:02:10 PM SGT
-- IDEMPIERE-1590 Sales region field is showing summary regions
UPDATE AD_Column SET AD_Reference_Value_ID=144, AD_Reference_ID=18,Updated=TO_TIMESTAMP('2013-12-03 13:02:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2968
;

SELECT register_migration_script('201312031304_IDEMPIERE-1590.sql') FROM dual
;