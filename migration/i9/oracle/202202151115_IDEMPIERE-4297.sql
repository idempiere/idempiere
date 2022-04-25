-- IDEMPIERE-4297 Fix GW accounting issues
SELECT register_migration_script('202202151115_IDEMPIERE-4297.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 15, 2022, 11:15:43 AM AEDT
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200064,11,12,'Y',TO_DATE('2022-02-15 11:15:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-15 11:15:42','YYYY-MM-DD HH24:MI:SS'),100,200000,508,'Store Central-11100-_-_-_-_','Y','Store Central-Checking Account-_-_-_-_','ae4efca6-102d-4583-b782-7c208c109008')
;

-- Feb 15, 2022, 11:17:15 AM AEDT
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200065,11,11,'Y',TO_DATE('2022-02-15 11:17:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-15 11:17:15','YYYY-MM-DD HH24:MI:SS'),100,200000,516,'HQ-11910-_-_-_-_','Y','HQ-Petty Cash In-Transfer-_-_-_-_','dcf8e537-8de5-4bc3-bd6f-55a95fe30225')
;

-- Feb 15, 2022, 11:22:19 AM AEDT
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200066,11,11,'Y',TO_DATE('2022-02-15 11:22:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-15 11:22:19','YYYY-MM-DD HH24:MI:SS'),100,200000,419,'HQ-21101-_-_-_-_','Y','HQ-Tree Farm Payable-_-_-_-_','b8f2ddb6-3151-42f8-a491-f4a830f8fc04')
;

-- Fix missing account combination and doctype in payment allocations
UPDATE C_CashBook_Acct SET CB_CashTransfer_Acct = 200065 WHERE C_CashBook_ID = 101 AND C_AcctSchema_ID = 200000;

UPDATE C_AllocationHdr SET C_DocType_ID = 137 WHERE C_AllocationHdr_ID IN (100,101);

DELETE FROM Fact_Acct WHERE AD_Table_ID = 735 AND Record_ID IN (100,101);

UPDATE C_AllocationHdr SET Posted = 'N' WHERE C_AllocationHdr_ID IN (100,101);

-- Fix A/P Invoices posted to different account in euro schema
UPDATE C_BP_Vendor_Acct SET V_Liability_Acct=200066,Updated=TO_DATE('2022-02-15 11:24:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=114
;

DELETE FROM Fact_Acct WHERE AD_Table_ID = 318 AND Record_ID IN (102, 104, 106);

UPDATE C_Invoice SET Posted = 'N' WHERE C_Invoice_ID IN (102, 104, 106);

-- add intercompany transfer journal to euro schema
INSERT INTO GL_Journal (GL_Journal_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_DocType_ID,DocumentNo,DocStatus,IsPrinted,Posted,Description,PostingType,C_AcctSchema_ID,GL_Category_ID,DateDoc,DateAcct,C_Period_ID,C_Currency_ID,GL_JournalBatch_ID,TotalDr,TotalCr,DocAction,IsApproved,CurrencyRate,ControlAmt,Processed,Processing,C_ConversionType_ID,GL_Journal_UU) VALUES (200000,11,11,'Y',TO_DATE('2022-02-15 11:26:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-15 11:26:47','YYYY-MM-DD HH24:MI:SS'),100,115,'1002','CO','N','N','Intercompany','A',200000,108,TO_DATE('2002-08-10','YYYY-MM-DD'),TO_DATE('2002-08-10','YYYY-MM-DD'),155,102,100,0,0,'CL','Y',1,0,'Y','N',114,'0e80e4c0-9300-43eb-bbad-47f861f75ab1')
;

-- Feb 15, 2022, 11:29:34 AM AEDT
INSERT INTO GL_JournalLine (GL_JournalLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,GL_Journal_ID,Line,C_Currency_ID,AmtSourceDr,AmtSourceCr,AmtAcctDr,AmtAcctCr,IsGenerated,CurrencyRate,DateAcct,C_UOM_ID,Qty,C_ValidCombination_ID,C_ConversionType_ID,Processed,A_CreateAsset,A_Processed,GL_JournalLine_UU,Account_ID) VALUES (200000,11,11,'Y',TO_DATE('2022-02-15 11:29:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-15 11:29:34','YYYY-MM-DD HH24:MI:SS'),100,200000,10,102,85.00,0,85.00,0.0,'N',1.0,TO_DATE('2002-08-10','YYYY-MM-DD'),100,0,200052,114,'Y','N','N','f9ba1ccf-06d0-4264-8964-7b740af54bd8',508)
;

-- Feb 15, 2022, 11:31:13 AM AEDT
INSERT INTO GL_JournalLine (GL_JournalLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,GL_Journal_ID,Line,C_Currency_ID,AmtSourceDr,AmtSourceCr,AmtAcctDr,AmtAcctCr,IsGenerated,CurrencyRate,DateAcct,C_UOM_ID,Qty,C_ValidCombination_ID,C_ConversionType_ID,Processed,A_CreateAsset,A_Processed,GL_JournalLine_UU,Account_ID) VALUES (200001,11,12,'Y',TO_DATE('2022-02-15 11:31:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-02-15 11:31:12','YYYY-MM-DD HH24:MI:SS'),100,200000,20,102,0,85,0.0,85.0,'N',1.0,TO_DATE('2002-08-10','YYYY-MM-DD'),100,0,200064,114,'Y','N','N','b3a71b8d-64f5-4f51-b7f8-a7a946b764fe',508)
;

-- Feb 15, 2022, 11:31:13 AM AEDT
UPDATE GL_Journal j SET (TotalDr, TotalCr) = (SELECT COALESCE(SUM(AmtAcctDr),0), COALESCE(SUM(AmtAcctCr),0) FROM GL_JournalLine jl WHERE jl.IsActive='Y' AND j.GL_Journal_ID=jl.GL_Journal_ID) WHERE GL_Journal_ID=200000
;

-- Feb 15, 2022, 11:26:48 AM AEDT
UPDATE GL_JournalBatch jb SET (TotalDr, TotalCr) = (SELECT COALESCE(SUM(TotalDr),0), COALESCE(SUM(TotalCr),0) FROM GL_Journal j WHERE j.IsActive='Y' AND jb.GL_JournalBatch_ID=j.GL_JournalBatch_ID) WHERE GL_JournalBatch_ID=100
;

-- Fix GL Journal document sequence
UPDATE AD_Sequence SET CurrentNext = CurrentNext+3 WHERE AD_Sequence_ID = 373;

