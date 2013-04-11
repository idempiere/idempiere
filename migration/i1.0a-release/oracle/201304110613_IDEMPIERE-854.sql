-- Apr 11, 2013 2:08:24 PM MYT
-- IDEMPIERE-854 Wrong length for AD_SessionInfo_v.ServerName
UPDATE AD_Column SET FieldLength=80,Updated=TO_DATE('2013-04-11 14:08:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200602
;

-- Apr 11, 2013 2:10:13 PM MYT
-- IDEMPIERE-854 Wrong length for AD_SessionInfo_v.ServerName
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-04-11 14:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200612
;

SELECT register_migration_script('201304110613_IDEMPIERE-854.sql') FROM dual
;

