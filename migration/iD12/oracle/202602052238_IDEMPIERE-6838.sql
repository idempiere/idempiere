-- IDEMPIERE-6838  Allow a BP to pay invoices from a different BP
SELECT register_migration_script('202602052238_IDEMPIERE-6838.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 5, 2026, 10:38:46 PM CET
UPDATE AD_Val_Rule SET Code='C_Invoice.DocStatus IN (''CO'', ''CL'') AND C_Invoice.C_Currency_ID=@C_Currency_ID@ AND C_Invoice.IsSOTrx=''@IsReceipt@'' 
AND (C_Invoice.C_BPartner_ID=@C_BPartner_ID@ OR C_Invoice.C_BPartner_ID IN (SELECT C_BPartner_ID FROM C_BP_Relation br WHERE C_BPartnerRelation_ID=@C_BPartner_ID@ AND IsPayFrom=''Y'' AND IsActive=''Y''))',Updated=TO_TIMESTAMP('2026-02-05 22:38:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=240
;

-- Feb 5, 2026, 10:44:09 PM CET
UPDATE AD_Element SET Name='Pay-From', Description='Business Partner can pay invoices from the related Business Partner', Help='Proxy business partner is allowed to pay and allocate payments from the related Business Partner', PrintName='Pay-From',Updated=TO_TIMESTAMP('2026-02-05 22:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=925
;

-- Feb 5, 2026, 10:44:09 PM CET
UPDATE AD_Column SET ColumnName='IsPayFrom', Name='Pay-From', Description='Business Partner can pay invoices from the related Business Partner', Help='Proxy business partner is allowed to pay and allocate payments from the related Business Partner', Placeholder=NULL WHERE AD_Element_ID=925
;

-- Feb 5, 2026, 10:44:09 PM CET
UPDATE AD_Process_Para SET ColumnName='IsPayFrom', Name='Pay-From', Description='Business Partner can pay invoices from the related Business Partner', Help='Proxy business partner is allowed to pay and allocate payments from the related Business Partner', AD_Element_ID=925 WHERE UPPER(ColumnName)='ISPAYFROM' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 5, 2026, 10:44:09 PM CET
UPDATE AD_Process_Para SET ColumnName='IsPayFrom', Name='Pay-From', Description='Business Partner can pay invoices from the related Business Partner', Help='Proxy business partner is allowed to pay and allocate payments from the related Business Partner', Placeholder=NULL WHERE AD_Element_ID=925 AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2026, 10:44:09 PM CET
UPDATE AD_InfoColumn SET ColumnName='IsPayFrom', Name='Pay-From', Description='Business Partner can pay invoices from the related Business Partner', Help='Proxy business partner is allowed to pay and allocate payments from the related Business Partner', Placeholder=NULL WHERE AD_Element_ID=925 AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2026, 10:44:09 PM CET
UPDATE AD_Field SET Name='Pay-From', Description='Business Partner can pay invoices from the related Business Partner', Help='Proxy business partner is allowed to pay and allocate payments from the related Business Partner', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=925) AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2026, 10:44:09 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Pay-From', Name='Pay-From' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=925)
;

