-- Feb 26, 2014 2:58:39 PM CET
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Reference SET IsOrderByValue='Y',Updated=TO_TIMESTAMP('2014-02-26 14:58:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=279
;

SELECT register_migration_script('201402260912_IDEMPIERE-1613.sql') FROM dual
;

