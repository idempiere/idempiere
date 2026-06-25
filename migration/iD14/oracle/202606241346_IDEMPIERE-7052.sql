-- IDEMPIERE-7052 - Add AD_Org_ID to Index in C_Invoice Table
-- Purpose: Include AD_Org_ID in the C_Invoice_DocumentNo_Target unique index to enforce document number uniqueness at the organization level rather than globally
-- Impact: Allows the same DocumentNo for the same business partner and document type in different organizations while maintaining uniqueness within each organization.
SELECT register_migration_script('202606241346_IDEMPIERE-7052.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 24, 2026, 1:46:18 PM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201831,'019efa86-7c08-73a0-867e-91f7d8c9e476',TO_TIMESTAMP('2026-06-24 13:46:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-24 13:46:17','YYYY-MM-DD HH24:MI:SS'),100,3486,200436,4)
;

-- Jun 24, 2026, 1:47:02 PM BRT
DROP INDEX c_invoice_documentno_target
;

-- Jun 24, 2026, 1:47:02 PM BRT
CREATE UNIQUE INDEX c_invoice_documentno_target ON C_Invoice (C_BPartner_ID,DocumentNo,C_DocTypeTarget_ID,AD_Org_ID)
;

