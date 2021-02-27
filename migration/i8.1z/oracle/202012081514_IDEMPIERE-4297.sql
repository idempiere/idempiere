SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4297 Improve test data
-- Dec 8, 2020, 3:09:18 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU,StartNewMonth,IsOrgLevelSequence) VALUES ('Warehouse Purchase Order',500000,'N','N','Y','N',11,0,TO_DATE('2020-12-08 15:09:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-12-08 15:09:17','YYYY-MM-DD HH24:MI:SS'),100,200336,'Y',500000,1,8000,'a14e492d-d3de-42fc-a23a-c7f9d4d828b0','N','N')
;

-- Dec 8, 2020, 3:09:33 PM CET
INSERT INTO C_DocType (C_DocType_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsDocNoControlled,DocNoSequence_ID,GL_Category_ID,PrintName,DocBaseType,DocSubTypeSO,HasCharges,HasProforma,IsDefault,DocumentCopies,IsSOTrx,IsDefaultCounterDoc,IsPickQAConfirm,IsShipConfirm,IsInTransit,IsSplitWhenDifference,IsCreateCounter,IsIndexed,IsOverwriteSeqOnComplete,IsOverwriteDateOnComplete,IsPrepareSplitDocument,C_DocType_UU,IsChargeOrProductMandatory) VALUES (200026,11,0,'Y',TO_DATE('2020-12-08 15:09:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-12-08 15:09:32','YYYY-MM-DD HH24:MI:SS'),100,'Warehouse Purchase Order','Y',200336,0,'Warehouse Purchase Order','POO','WP','N','N','N',0,'N','Y','N','N','N','N','Y','Y','N','N','Y','49a114a0-0fac-4582-b3b9-840702c6ae6c','N')
;

-- Dec 8, 2020, 3:11:05 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU,StartNewMonth,IsOrgLevelSequence) VALUES ('Point of Purchase Order',600000,'N','N','Y','N',11,0,TO_DATE('2020-12-08 15:11:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-12-08 15:11:05','YYYY-MM-DD HH24:MI:SS'),100,200337,'Y',600000,1,8000,'90c3ce7a-3fa0-40f0-8a4c-55bbd8f23e4e','N','N')
;

-- Dec 8, 2020, 3:11:23 PM CET
INSERT INTO C_DocType (C_DocType_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsDocNoControlled,DocNoSequence_ID,GL_Category_ID,PrintName,DocBaseType,DocSubTypeSO,HasCharges,HasProforma,C_DocTypeShipment_ID,C_DocTypeInvoice_ID,IsDefault,DocumentCopies,IsSOTrx,IsDefaultCounterDoc,IsPickQAConfirm,IsShipConfirm,IsInTransit,IsSplitWhenDifference,IsCreateCounter,IsIndexed,IsOverwriteSeqOnComplete,IsOverwriteDateOnComplete,IsPrepareSplitDocument,C_DocType_UU,IsChargeOrProductMandatory) VALUES (200027,11,0,'Y',TO_DATE('2020-12-08 15:11:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-12-08 15:11:23','YYYY-MM-DD HH24:MI:SS'),100,'Point of Purchase Order','Y',200337,0,'POP Order','POO','WR','N','N',122,123,'N',0,'N','Y','N','N','N','N','Y','Y','N','N','Y','6c86e67d-fe95-4ba8-b05c-64b3fae21870','N')
;

-- Dec 8, 2020, 3:11:34 PM CET
UPDATE C_DocType SET C_DocTypeShipment_ID=122,Updated=TO_DATE('2020-12-08 15:11:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_DocType_ID=200026
;

SELECT register_migration_script('202012081514_IDEMPIERE-4297.sql') FROM dual
;

