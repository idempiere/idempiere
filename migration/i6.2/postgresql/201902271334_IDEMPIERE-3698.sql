-- IDEMPIERE-3698 Change datatype R_MailText.MailText to CLOB
-- Feb 27, 2019, 1:33:51 PM CET
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_TIMESTAMP('2019-02-27 13:33:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14615
;

-- Feb 27, 2019, 1:33:53 PM CET
INSERT INTO t_alter_column values('r_mailtext_trl','MailText','TEXT',null,null)
;

SELECT register_migration_script('201902271334_IDEMPIERE-3698.sql') FROM dual
;

