-- Apr 18, 2014 12:41:00 PM SGT
-- IDEMPIERE-1904 Incorrect document status when void a document with completed document status

UPDATE C_AllocationHdr SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE C_Invoice SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE C_Payment SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE GL_Journal SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE GL_JournalBatch SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE HR_Process SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE M_InOut SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE M_Inventory SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE M_Movement SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;
UPDATE PP_Cost_Collector SET DocStatus = 'RE' WHERE DocStatus = 'VO' AND Reversal_ID > 0;

SELECT register_migration_script('201404181241_IDEMPIERE-1904.sql') FROM dual
;