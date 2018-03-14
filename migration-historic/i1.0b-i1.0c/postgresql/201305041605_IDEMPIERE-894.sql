-- May 4, 2013 4:02:25 PM COT
-- IDEMPIERE-894 Not Possible to Link Business Partner to an Organization
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2013-05-04 16:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10927
;

-- May 4, 2013 4:03:03 PM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2013-05-04 16:03:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8757
;

SELECT register_migration_script('201305041605_IDEMPIERE-894.sql') FROM dual
;

