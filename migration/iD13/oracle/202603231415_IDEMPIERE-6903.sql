-- IDEMPIERE-6903: InvoiceCreditMemo process: should not block if previous credit memo is reversed or void
SELECT register_migration_script('202603231415_IDEMPIERE-6903.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

UPDATE C_Invoice i
SET RelatedInvoice_ID = NULL
WHERE EXISTS (
    SELECT 1
    FROM C_DocType dt
    WHERE dt.DocBaseType IN ('ARC', 'APC')
    AND (
        (i.DocStatus = 'VO' AND dt.C_DocType_ID = i.C_DocTypeTarget_ID)
        OR
        (i.DocStatus = 'RE' AND dt.C_DocType_ID = i.C_DocType_ID)
    )
)
;
