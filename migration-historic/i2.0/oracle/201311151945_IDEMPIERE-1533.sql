SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 15, 2013 7:35:45 PM CET
-- IDEMPIERE-1533 Constraint Name shouldn't be copied
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2013-11-15 19:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210871
;

SELECT register_migration_script('201311151945_IDEMPIERE-1533.sql') FROM dual
;
