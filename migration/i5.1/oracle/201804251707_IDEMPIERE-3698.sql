SET SQLBLANKLINES ON
SET DEFINE OFF

-- R_MailText.MailText
-- Apr 25, 2018 5:01:41 PM CEST
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_DATE('2018-04-25 17:01:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5414
;

-- Apr 25, 2018 5:01:48 PM CEST
ALTER TABLE R_MailText ADD Tmp_MailText CLOB;
UPDATE R_MailText SET Tmp_MailText = TO_CHAR(MailText);
ALTER TABLE R_MailText DROP COLUMN MailText;
ALTER TABLE R_MailText RENAME COLUMN Tmp_MailText TO MailText;

SELECT register_migration_script('201804251707_IDEMPIERE-3698.sql') FROM dual
;
