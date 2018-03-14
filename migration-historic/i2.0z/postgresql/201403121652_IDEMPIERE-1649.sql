-- Mar 12, 2014 4:51:42 PM COT
-- IDEMPIERE-1649 set tab default
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_TIMESTAMP('2014-03-12 16:51:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=166
;

-- Mar 12, 2014 4:52:00 PM COT
INSERT INTO t_alter_column values('ad_tab','IsSingleRow','CHAR(1)',null,'Y')
;

-- Mar 12, 2014 4:52:02 PM COT
UPDATE AD_Tab SET IsSingleRow='Y' WHERE IsSingleRow IS NULL
;

SELECT register_migration_script('201403121652_IDEMPIERE-1649.sql') FROM dual
;

