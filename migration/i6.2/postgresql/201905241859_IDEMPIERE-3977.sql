-- IDEMPIERE-3977 Allow context variables on subject and message when processing alerts (FHCA-967)
-- May 24, 2019, 6:58:25 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2019-05-24 18:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9077
;

-- May 24, 2019, 6:58:27 PM CEST
INSERT INTO t_alter_column values('ad_alert','AlertSubject','VARCHAR(255)',null,null)
;

SELECT register_migration_script('201905241859_IDEMPIERE-3977.sql') FROM dual
;

