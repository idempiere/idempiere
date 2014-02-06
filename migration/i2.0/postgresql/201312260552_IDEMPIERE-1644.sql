-- Dec 26, 2013 12:22:23 PM MYT
-- IDEMPIERE-1644 Length 22 for AD_PrintFormatItem.FormatPattern is too short
UPDATE AD_Column SET FieldLength=60,Updated=TO_TIMESTAMP('2013-12-26 12:22:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56351
;

-- Dec 26, 2013 12:22:34 PM MYT
-- IDEMPIERE-1644 Length 22 for AD_PrintFormatItem.FormatPattern is too short
INSERT INTO t_alter_column values('ad_printformatitem','FormatPattern','VARCHAR(60)',null,'NULL')
;

SELECT register_migration_script('201312260552_IDEMPIERE-1644.sql') FROM dual
;

