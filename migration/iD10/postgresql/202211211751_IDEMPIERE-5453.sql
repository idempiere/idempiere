-- IDEMPIERE-5453 Payment Selection > Payment Selection Line allows the same invoice to be added several times for payment
SELECT register_migration_script('202211211751_IDEMPIERE-5453.sql') FROM dual;

-- Nov 21, 2022, 5:51:09 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200172,'C_PaySelectionLine Invoice','S','C_Invoice.DocStatus IN (''CO'', ''CL'') AND NOT EXISTS (SELECT * FROM C_PaySelectionLine psl 
INNER JOIN C_PaySelectionCheck psc ON (psl.C_PaySelectionCheck_ID=psc.C_PaySelectionCheck_ID) 
LEFT OUTER JOIN C_Payment pmt ON (pmt.C_Payment_ID=psc.C_Payment_ID) 
WHERE C_Invoice.C_Invoice_ID=psl.C_Invoice_ID AND psl.IsActive=''Y'' 
AND (pmt.DocStatus IS NULL OR pmt.DocStatus NOT IN (''VO'',''RE'')) ) 
AND C_Invoice.C_Invoice_ID NOT IN (SELECT psl.C_Invoice_ID FROM C_PaySelectionLine psl WHERE psl.C_PaySelection_ID=@C_PaySelection_ID@)',0,0,'Y',TO_TIMESTAMP('2022-11-21 17:51:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-21 17:51:07','YYYY-MM-DD HH24:MI:SS'),100,'D','04bd5d22-5d36-4436-b587-3d9ecae182cc')
;

-- Nov 21, 2022, 5:51:24 PM SGT
UPDATE AD_Column SET AD_Val_Rule_ID=200172,Updated=TO_TIMESTAMP('2022-11-21 17:51:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5639
;

