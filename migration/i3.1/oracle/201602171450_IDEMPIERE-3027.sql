SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3027 'Closed' projects are still selectable in drop downs
-- Feb 4, 2016 2:27:17 PM UTC
UPDATE AD_Val_Rule SET Code='C_Project.Processed=''N'' AND C_Project.IsSummary=''N'' AND (C_Project.C_BPartner_ID IS NULL OR C_Project.C_BPartner_ID=@C_BPartner_ID@ OR C_Project.C_BPartnerSR_ID=@C_BPartner_ID@)',Updated=TO_DATE('2016-02-04 14:27:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=227
;

SELECT register_migration_script('201602171450_IDEMPIERE-3027.sql') FROM dual
;

