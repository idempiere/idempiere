-- IDEMPIERE-3052 Advanced Search on doctype on invoices or orders shows all the doctypes

update ad_column set AD_Val_Rule_ID=124 where AD_Column_ID=3493 and AD_Val_Rule_ID IS NULL
;

update ad_column set AD_Val_Rule_ID=133 where AD_Column_ID=2172 and AD_Val_Rule_ID IS NULL
;

SELECT register_migration_script('201603110209_IDEMPIERE-3052.sql') FROM dual
;

