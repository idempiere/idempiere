SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3698 Change datatype R_MailText.MailText to CLOB
-- Feb 27, 2019, 1:33:51 PM CET
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_DATE('2019-02-27 13:33:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14615
;

-- Feb 27, 2019, 1:33:53 PM CET
--ALTER TABLE R_MailText_Trl MODIFY MailText CLOB;
ALTER TABLE R_MailText_Trl ADD Tmp_MailText CLOB;
UPDATE R_MailText_Trl SET Tmp_MailText = TO_CHAR(MailText);
ALTER TABLE R_MailText_Trl DROP COLUMN MailText;
ALTER TABLE R_MailText_Trl RENAME COLUMN Tmp_MailText TO MailText;

SELECT register_migration_script('201902271334_IDEMPIERE-3698.sql') FROM dual
;

