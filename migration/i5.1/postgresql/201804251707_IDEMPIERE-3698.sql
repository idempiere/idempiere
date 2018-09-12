-- R_MailText.MailText
-- Apr 25, 2018 5:01:41 PM CEST
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_TIMESTAMP('2018-04-25 17:01:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5414
;

-- Apr 25, 2018 5:01:48 PM CEST
INSERT INTO t_alter_column values('r_mailtext','MailText','TEXT',null,null)
;

SELECT register_migration_script('201804251707_IDEMPIERE-3698.sql') FROM dual
;
