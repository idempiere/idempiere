-- IDEMPIERE-6903: InvoiceCreditMemo process: should not block if previous credit memo is reversed or void
SELECT register_migration_script('202603231415_IDEMPIERE-6903.sql') FROM dual;

UPDATE C_Invoice SET RelatedInvoice_ID = NULL WHERE C_DocTypeTarget_ID IN (SELECT C_DocType_ID FROM C_DocType WHERE docbasetype = 'ARC') AND DocStatus IN ('VO', 'RE')
;
