SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3977 Allow context variables on subject and message when processing alerts (FHCA-967)
-- May 24, 2019, 6:58:25 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_DATE('2019-05-24 18:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9077
;

-- May 24, 2019, 6:58:27 PM CEST
-- ALTER TABLE AD_Alert MODIFY AlertSubject NVARCHAR2(255);
ALTER TABLE AD_Alert ADD Tmp_AlertSubject NVARCHAR2(255);
UPDATE AD_Alert SET Tmp_AlertSubject = AlertSubject;
ALTER TABLE AD_Alert MODIFY Tmp_AlertSubject NVARCHAR2(255) NOT NULL;
ALTER TABLE AD_Alert DROP COLUMN AlertSubject;
ALTER TABLE AD_Alert RENAME COLUMN Tmp_AlertSubject TO AlertSubject;

SELECT register_migration_script('201905241859_IDEMPIERE-3977.sql') FROM dual
;

