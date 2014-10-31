SET SQLBLANKLINES ON
SET DEFINE OFF

ALTER TABLE AD_PrintFormat_Trl DROP CONSTRAINT AD_PrintFormat_Trl_Key
;

ALTER TABLE AD_PrintFormat_Trl ADD CONSTRAINT AD_PrintFormat_Trl_Key PRIMARY KEY (AD_PrintFormat_ID, AD_Language)
;

SELECT register_migration_script('201407021604_IDEMPIERE-1878-wrong-key.sql') FROM dual
;
