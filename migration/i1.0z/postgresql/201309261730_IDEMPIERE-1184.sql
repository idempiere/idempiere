-- Jul 17, 2013 3:14:50 PM COT
-- IDEMPIERE-1184 Register browser information available on AD_Session
UPDATE AD_Column SET FieldLength=2000,Updated=TO_TIMESTAMP('2013-07-17 15:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54349
;

-- Jul 17, 2013 3:14:55 PM COT
-- IDEMPIERE-1184 Register browser information available on AD_Session
INSERT INTO t_alter_column values('ad_session','Description','VARCHAR(2000)',null,'NULL')
;

SELECT register_migration_script('201309261730_IDEMPIERE-1184.sql') FROM dual
;

