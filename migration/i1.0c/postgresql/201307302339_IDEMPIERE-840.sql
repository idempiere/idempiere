-- Jul 30, 2013 11:33:11 PM SGT
-- IDEMPIERE-840 Improvement to Request model class	
DELETE FROM AD_ModelValidator WHERE AD_ModelValidator_ID=200003
;

SELECT register_migration_script('201307302339_IDEMPIERE-840.sql') FROM dual
;