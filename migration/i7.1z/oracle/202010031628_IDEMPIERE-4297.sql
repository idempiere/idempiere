SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4297 Improve test data
-- Oct 3, 2020, 3:53:25 PM CEST
INSERT INTO C_AcctSchema (C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,GAAP,IsAccrual,CostingMethod,C_Currency_ID,AutoPeriodControl,C_Period_ID,Period_OpenHistory,Period_OpenFuture,Separator,HasAlias,HasCombination,IsTradeDiscountPosted,IsDiscountCorrectsTax,M_CostType_ID,CostingLevel,IsAdjustCOGS,IsPostServices,IsExplicitCostAdjustment,CommitmentType,Processing,TaxCorrectionType,IsAllowNegativePosting,IsPostIfClearingEqual,C_AcctSchema_UU) VALUES (200000,11,0,'Y',TO_DATE('2020-10-03 15:53:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 15:53:24','YYYY-MM-DD HH24:MI:SS'),100,'GardenWorld Euro','UN','Y','A',102,'Y',200104,10000,100,'-','Y','N','N','N',100,'C','N','N','N','N','N','N','Y','Y','546a277d-0ad3-4935-bf2a-7eb6d348b978')
;

-- Oct 3, 2020, 3:54:19 PM CEST
UPDATE C_AcctSchema SET Name='Second Schema GardenWorld Euro',Updated=TO_DATE('2020-10-03 15:54:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctSchema_ID=200000
;

-- Oct 3, 2020, 3:54:49 PM CEST
INSERT INTO C_AcctSchema_Element (C_AcctSchema_Element_ID,C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ElementType,Name,SeqNo,IsBalanced,IsMandatory,Org_ID,C_AcctSchema_Element_UU) VALUES (200000,200000,11,0,'Y',TO_DATE('2020-10-03 15:54:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 15:54:49','YYYY-MM-DD HH24:MI:SS'),100,'OT','Organization',10,'Y','Y',11,'7bdfbc07-9f1c-44ce-ba65-67210574b473')
;

-- Oct 3, 2020, 3:55:17 PM CEST
INSERT INTO C_AcctSchema_Element (C_AcctSchema_Element_ID,C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ElementType,Name,SeqNo,C_Element_ID,IsBalanced,IsMandatory,C_ElementValue_ID,C_AcctSchema_Element_UU) VALUES (200001,200000,11,0,'Y',TO_DATE('2020-10-03 15:55:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 15:55:17','YYYY-MM-DD HH24:MI:SS'),100,'AC','Account',20,105,'N','Y',697,'d41a7fae-bd50-47c8-9c2e-aafb487c66a8')
;

-- Oct 3, 2020, 3:55:48 PM CEST
INSERT INTO C_AcctSchema_Element (C_AcctSchema_Element_ID,C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ElementType,Name,SeqNo,IsBalanced,IsMandatory,M_Product_ID,C_AcctSchema_Element_UU) VALUES (200002,200000,11,0,'Y',TO_DATE('2020-10-03 15:55:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 15:55:47','YYYY-MM-DD HH24:MI:SS'),100,'PR','Product',30,'N','N',122,'ae46e546-54ef-4552-8273-e06b969fd7d7')
;

-- Oct 3, 2020, 3:56:07 PM CEST
INSERT INTO C_AcctSchema_Element (C_AcctSchema_Element_ID,C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ElementType,Name,SeqNo,IsBalanced,IsMandatory,C_BPartner_ID,C_AcctSchema_Element_UU) VALUES (200003,200000,11,0,'Y',TO_DATE('2020-10-03 15:56:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 15:56:06','YYYY-MM-DD HH24:MI:SS'),100,'BP','Bus.Partner',40,'N','N',112,'b0954a50-1a6e-4dbc-b65a-47b17a92e24e')
;

-- Oct 3, 2020, 3:56:23 PM CEST
INSERT INTO C_AcctSchema_Element (C_AcctSchema_Element_ID,C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ElementType,Name,SeqNo,IsBalanced,IsMandatory,C_Project_ID,C_AcctSchema_Element_UU) VALUES (200004,200000,11,0,'Y',TO_DATE('2020-10-03 15:56:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 15:56:23','YYYY-MM-DD HH24:MI:SS'),100,'PJ','Project',50,'N','N',100,'4082da45-d7b8-4ab2-9cb5-d89b5b0e12e1')
;

-- Oct 3, 2020, 3:56:34 PM CEST
INSERT INTO C_AcctSchema_Element (C_AcctSchema_Element_ID,C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ElementType,Name,SeqNo,IsBalanced,IsMandatory,C_Campaign_ID,C_AcctSchema_Element_UU) VALUES (200005,200000,11,0,'Y',TO_DATE('2020-10-03 15:56:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 15:56:34','YYYY-MM-DD HH24:MI:SS'),100,'MC','Campaign',60,'N','N',101,'cb032bf7-a8ad-45f9-ac04-7c3ccc18eff8')
;

-- Oct 3, 2020, 3:58:53 PM CEST
UPDATE C_AcctSchema_Element SET ElementType='OO',Updated=TO_DATE('2020-10-03 15:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctSchema_Element_ID=200000
;

-- Oct 3, 2020, 4:00:05 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200018,11,11,'Y',TO_DATE('2020-10-03 16:00:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:00:05','YYYY-MM-DD HH24:MI:SS'),100,200000,600,'HQ-21800-_-_-_-_','Y','HQ-Intercompany Due To-_-_-_-_','40d3d702-d97c-4b39-aa11-fa8187b6001c')
;

-- Oct 3, 2020, 4:00:31 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200019,11,11,'Y',TO_DATE('2020-10-03 16:00:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:00:31','YYYY-MM-DD HH24:MI:SS'),100,200000,698,'HQ-79200-_-_-_-_','Y','HQ-Suspense balancing-_-_-_-_','7f4b4950-b672-415d-b6cb-ddf836648d95')
;

-- Oct 3, 2020, 4:00:44 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200020,11,11,'Y',TO_DATE('2020-10-03 16:00:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:00:44','YYYY-MM-DD HH24:MI:SS'),100,200000,724,'HQ-82550-_-_-_-_','Y','HQ-Currency balancing-_-_-_-_','e6f6a427-1432-4a2e-941b-9dce02ae40d8')
;

-- Oct 3, 2020, 4:00:55 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200021,11,11,'Y',TO_DATE('2020-10-03 16:00:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:00:55','YYYY-MM-DD HH24:MI:SS'),100,200000,635,'HQ-58300-_-_-_-_','Y','HQ-Purchase price variance Offset-_-_-_-_','b648cc53-e419-42dd-b4e4-1efdb38d3c2e')
;

-- Oct 3, 2020, 4:01:13 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200022,11,11,'Y',TO_DATE('2020-10-03 16:01:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:01:13','YYYY-MM-DD HH24:MI:SS'),100,200000,736,'HQ-952-_-_-_-_','Y','HQ-PO Commitment-_-_-_-_','ba56155d-8206-4eb0-b90e-ddca2823dbea')
;

-- Oct 3, 2020, 4:01:21 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200023,11,11,'Y',TO_DATE('2020-10-03 16:01:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:01:20','YYYY-MM-DD HH24:MI:SS'),100,200000,50000,'HQ-953-_-_-_-_','Y','HQ-SO Commitment-_-_-_-_','8cf2d42e-2cff-4213-b7ed-34cfa92eeb97')
;

-- Oct 3, 2020, 4:01:35 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200024,11,11,'Y',TO_DATE('2020-10-03 16:01:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:01:35','YYYY-MM-DD HH24:MI:SS'),100,200000,741,'HQ-12800-_-_-_-_','Y','HQ-Intercompany Due From-_-_-_-_','cc8d50db-5fcc-44ab-ac63-f932c2ae0c25')
;

-- Oct 3, 2020, 4:01:50 PM CEST
INSERT INTO C_AcctSchema_GL (C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,UseSuspenseBalancing,SuspenseBalancing_Acct,UseSuspenseError,UseCurrencyBalancing,CurrencyBalancing_Acct,IntercompanyDueTo_Acct,IntercompanyDueFrom_Acct,PPVOffset_Acct,CommitmentOffset_Acct,CommitmentOffsetSales_Acct,C_AcctSchema_GL_UU) VALUES (200000,11,0,'Y',TO_DATE('2020-10-03 16:01:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:01:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',200019,'N','Y',200020,200018,200024,200021,200022,200023,'70fa4a86-c404-459e-b81f-aee6ab558e31')
;

-- Oct 3, 2020, 4:03:00 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200025,11,11,'Y',TO_DATE('2020-10-03 16:02:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:02:59','YYYY-MM-DD HH24:MI:SS'),100,200000,712,'HQ-80530-_-_-_-_','Y','HQ-Unrealized gain-_-_-_-_','a70553f0-ce3d-468e-9947-a51734c501a0')
;

-- Oct 3, 2020, 4:03:20 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200026,11,11,'Y',TO_DATE('2020-10-03 16:03:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:03:20','YYYY-MM-DD HH24:MI:SS'),100,200000,722,'HQ-82530-_-_-_-_','Y','HQ-Unrealized loss-_-_-_-_','11d0be92-c065-438d-b42c-18a745f0257d')
;

-- Oct 3, 2020, 4:03:34 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200027,11,11,'Y',TO_DATE('2020-10-03 16:03:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:03:33','YYYY-MM-DD HH24:MI:SS'),100,200000,767,'HQ-80540-_-_-_-_','Y','HQ-Realized gain-_-_-_-_','9f873f6b-e61c-4a69-b186-77c675d719a8')
;

-- Oct 3, 2020, 4:03:47 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200028,11,11,'Y',TO_DATE('2020-10-03 16:03:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:03:47','YYYY-MM-DD HH24:MI:SS'),100,200000,723,'HQ-82540-_-_-_-_','Y','HQ-Realized loss-_-_-_-_','4fcef44a-e500-42fc-82af-4daf76a63616')
;

-- Oct 3, 2020, 4:07:13 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200029,11,11,'Y',TO_DATE('2020-10-03 16:07:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:07:12','YYYY-MM-DD HH24:MI:SS'),100,200000,587,'HQ-21190-_-_-_-_','Y','HQ-Not invoiced receipts-_-_-_-_','1dc6e167-52b1-472f-aee1-839c96da387a')
;

-- Oct 3, 2020, 4:07:24 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200030,11,11,'Y',TO_DATE('2020-10-03 16:07:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:07:24','YYYY-MM-DD HH24:MI:SS'),100,200000,423,'HQ-47000-_-_-_-_','Y','HQ-Unearned revenue-_-_-_-_','0b842408-a127-4df6-b2d3-f67e31818228')
;

-- Oct 3, 2020, 4:07:37 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200031,11,11,'Y',TO_DATE('2020-10-03 16:07:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:07:37','YYYY-MM-DD HH24:MI:SS'),100,200000,427,'HQ-59201-_-_-_-_','Y','HQ-Payment discount revenue-_-_-_-_','212854c7-4edc-4c1d-ab32-7e11e09d3489')
;

-- Oct 3, 2020, 4:07:51 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200032,11,11,'Y',TO_DATE('2020-10-03 16:07:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:07:51','YYYY-MM-DD HH24:MI:SS'),100,200000,448,'HQ-59200-_-_-_-_','Y','HQ-Payment discount revenue-_-_-_-_','708fbab9-1b54-4a07-ac7c-31f9fbfddbef')
;

-- Oct 3, 2020, 4:08:06 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200033,11,11,'Y',TO_DATE('2020-10-03 16:08:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:08:06','YYYY-MM-DD HH24:MI:SS'),100,200000,765,'HQ-78100-_-_-_-_','Y','HQ-Bad Debts Write-off-_-_-_-_','ee46799d-9304-46bc-b055-f1b84cd50ddb')
;

-- Oct 3, 2020, 4:08:21 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200034,11,11,'Y',TO_DATE('2020-10-03 16:08:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:08:21','YYYY-MM-DD HH24:MI:SS'),100,200000,518,'HQ-12110-_-_-_-_','Y','HQ-Accounts Receivable - Trade-_-_-_-_','5383b624-ce7f-499d-9812-bfaf45a8485b')
;

-- Oct 3, 2020, 4:08:33 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200035,11,11,'Y',TO_DATE('2020-10-03 16:08:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:08:33','YYYY-MM-DD HH24:MI:SS'),100,200000,749,'HQ-21100-_-_-_-_','Y','HQ-Accounts Payable Trade-_-_-_-_','bee3b4d9-13ef-492b-9df6-d46cd46f56e7')
;

-- Oct 3, 2020, 4:08:46 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200036,11,11,'Y',TO_DATE('2020-10-03 16:08:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:08:46','YYYY-MM-DD HH24:MI:SS'),100,200000,750,'HQ-21510-_-_-_-_','Y','HQ-Customer Prepayments-_-_-_-_','b2993096-d684-4ca9-a926-ebca3bac2b50')
;

-- Oct 3, 2020, 4:09:00 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200037,11,11,'Y',TO_DATE('2020-10-03 16:08:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:08:59','YYYY-MM-DD HH24:MI:SS'),100,200000,532,'HQ-12510-_-_-_-_','Y','HQ-Vendor prepayment-_-_-_-_','aeadc31e-dbe9-447a-a7b5-f5eddad22ee9')
;

-- Oct 3, 2020, 4:09:15 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200038,11,11,'Y',TO_DATE('2020-10-03 16:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:09:15','YYYY-MM-DD HH24:MI:SS'),100,200000,742,'HQ-14120-_-_-_-_','Y','HQ-Product asset-_-_-_-_','17814a17-f4e2-4e05-9efc-00e32f1626aa')
;

-- Oct 3, 2020, 4:09:28 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200039,11,11,'Y',TO_DATE('2020-10-03 16:09:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:09:27','YYYY-MM-DD HH24:MI:SS'),100,200000,431,'HQ-51200-_-_-_-_','Y','HQ-Product Expense-_-_-_-_','9471ceea-438a-4200-895e-a4b56973ee3c')
;

-- Oct 3, 2020, 4:09:38 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200040,11,11,'Y',TO_DATE('2020-10-03 16:09:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:09:38','YYYY-MM-DD HH24:MI:SS'),100,200000,781,'HQ-51300-_-_-_-_','Y','HQ-Cost Adjustments-_-_-_-_','85b2df15-9430-42d5-b4e6-9f9e2bc9e4e9')
;

-- Oct 3, 2020, 4:09:46 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200041,11,11,'Y',TO_DATE('2020-10-03 16:09:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:09:46','YYYY-MM-DD HH24:MI:SS'),100,200000,780,'HQ-51400-_-_-_-_','Y','HQ-Inventory Clearing-_-_-_-_','549543cf-703a-4314-ad5f-b5b408810a2d')
;

-- Oct 3, 2020, 4:09:58 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200042,11,11,'Y',TO_DATE('2020-10-03 16:09:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:09:58','YYYY-MM-DD HH24:MI:SS'),100,200000,430,'HQ-51100-_-_-_-_','Y','HQ-Product CoGs-_-_-_-_','5afcef6c-6ad4-4630-a38f-9a6ca2bde601')
;

-- Oct 3, 2020, 4:10:08 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200043,11,11,'Y',TO_DATE('2020-10-03 16:10:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:10:07','YYYY-MM-DD HH24:MI:SS'),100,200000,758,'HQ-41000-_-_-_-_','Y','HQ-Trade Revenue-_-_-_-_','4c1ad149-bcc7-467d-8bfc-67e1c74567b2')
;

-- Oct 3, 2020, 4:10:18 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200044,11,11,'Y',TO_DATE('2020-10-03 16:10:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:10:18','YYYY-MM-DD HH24:MI:SS'),100,200000,445,'HQ-58200-_-_-_-_','Y','HQ-Purchase price variance-_-_-_-_','5274fc63-f567-4933-89be-91a50acf8ea5')
;

-- Oct 3, 2020, 4:10:30 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200045,11,11,'Y',TO_DATE('2020-10-03 16:10:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:10:29','YYYY-MM-DD HH24:MI:SS'),100,200000,444,'HQ-58100-_-_-_-_','Y','HQ-Invoice price variance-_-_-_-_','9b74a853-ad13-4792-acf9-ce1f5a7067c3')
;

-- Oct 3, 2020, 4:10:41 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200046,11,11,'Y',TO_DATE('2020-10-03 16:10:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:10:41','YYYY-MM-DD HH24:MI:SS'),100,200000,447,'HQ-59100-_-_-_-_','Y','HQ-Trade discounts received-_-_-_-_','652d73a1-2c47-4d91-89b3-b93c129398ed')
;

-- Oct 3, 2020, 4:10:49 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200047,11,11,'Y',TO_DATE('2020-10-03 16:10:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:10:49','YYYY-MM-DD HH24:MI:SS'),100,200000,426,'HQ-59101-_-_-_-_','Y','HQ-Trade Discounts-_-_-_-_','0bcd8912-0b84-4f64-af24-382cf15c6735')
;

-- Oct 3, 2020, 4:11:00 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200048,11,11,'Y',TO_DATE('2020-10-03 16:11:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:11:00','YYYY-MM-DD HH24:MI:SS'),100,200000,50003,'HQ-58600-_-_-_-_','Y','HQ-Rate Variance-_-_-_-_','43e17565-7f42-4ed6-a47f-9c43d8ecd398')
;

-- Oct 3, 2020, 4:11:11 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200049,11,11,'Y',TO_DATE('2020-10-03 16:11:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:11:11','YYYY-MM-DD HH24:MI:SS'),100,200000,50017,'HQ-58800-_-_-_-_','Y','HQ-Average Cost Variance-_-_-_-_','928a6f49-b982-42af-be0a-45aa1249fded')
;

-- Oct 3, 2020, 4:11:22 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200050,11,11,'Y',TO_DATE('2020-10-03 16:11:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:11:22','YYYY-MM-DD HH24:MI:SS'),100,200000,200000,'HQ-58900-_-_-_-_','Y','HQ-Landed Cost Clearing-_-_-_-_','9fe2d70e-2f09-4c7d-b75d-4ee5a5fb0df9')
;

-- Oct 3, 2020, 4:11:33 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200051,11,11,'Y',TO_DATE('2020-10-03 16:11:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:11:33','YYYY-MM-DD HH24:MI:SS'),100,200000,439,'HQ-56100-_-_-_-_','Y','HQ-Inventory Shrinkage-_-_-_-_','9debdae9-349c-4bc6-9e44-a60f018d0429')
;

-- Oct 3, 2020, 4:11:46 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200052,11,11,'Y',TO_DATE('2020-10-03 16:11:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:11:46','YYYY-MM-DD HH24:MI:SS'),100,200000,508,'HQ-11100-_-_-_-_','Y','HQ-Checking Account-_-_-_-_','e68d8be4-24ff-425b-96d0-dfba116b48b4')
;

-- Oct 3, 2020, 4:11:58 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200053,11,11,'Y',TO_DATE('2020-10-03 16:11:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:11:58','YYYY-MM-DD HH24:MI:SS'),100,200000,509,'HQ-11110-_-_-_-_','Y','HQ-Checking In-Transfer-_-_-_-_','5c4a96a2-ddc6-444e-a2fe-d9f148c7e7fd')
;

-- Oct 3, 2020, 4:12:14 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200054,11,11,'Y',TO_DATE('2020-10-03 16:12:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:12:14','YYYY-MM-DD HH24:MI:SS'),100,200000,589,'HQ-21300-_-_-_-_','Y','HQ-Payment selection-_-_-_-_','3898e168-a978-4e3c-9c5b-03ec7d7daa89')
;

-- Oct 3, 2020, 4:12:27 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200055,11,11,'Y',TO_DATE('2020-10-03 16:12:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:12:27','YYYY-MM-DD HH24:MI:SS'),100,200000,511,'HQ-11130-_-_-_-_','Y','HQ-Checking Unallocated Receipts-_-_-_-_','64afd8d6-f875-43f1-972d-21eb7cc99d92')
;

-- Oct 3, 2020, 4:12:39 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200056,11,11,'Y',TO_DATE('2020-10-03 16:12:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:12:38','YYYY-MM-DD HH24:MI:SS'),100,200000,717,'HQ-82100-_-_-_-_','Y','HQ-Interest Expense-_-_-_-_','ae0acc58-fcbb-4931-800b-f99a37e06238')
;

-- Oct 3, 2020, 4:12:48 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200057,11,11,'Y',TO_DATE('2020-10-03 16:12:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:12:48','YYYY-MM-DD HH24:MI:SS'),100,200000,705,'HQ-80100-_-_-_-_','Y','HQ-Interest Income-_-_-_-_','c1f1a68e-4b3d-4096-a2fa-269626d91c6b')
;

-- Oct 3, 2020, 4:13:00 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200058,11,11,'Y',TO_DATE('2020-10-03 16:13:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:13:00','YYYY-MM-DD HH24:MI:SS'),100,200000,596,'HQ-21610-_-_-_-_','Y','HQ-Tax due-_-_-_-_','7c62099c-2acb-4fe6-b0af-9ab11e57f34e')
;

-- Oct 3, 2020, 4:13:12 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200059,11,11,'Y',TO_DATE('2020-10-03 16:13:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:13:12','YYYY-MM-DD HH24:MI:SS'),100,200000,534,'HQ-12610-_-_-_-_','Y','HQ-Tax credit A/R-_-_-_-_','1a4c6b05-ebb7-424b-8090-bfa982c9da5e')
;

-- Oct 3, 2020, 4:13:22 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200060,11,11,'Y',TO_DATE('2020-10-03 16:13:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:13:22','YYYY-MM-DD HH24:MI:SS'),100,200000,760,'HQ-74100-_-_-_-_','Y','HQ-Tax expense-_-_-_-_','edaed71e-9e74-46ca-b7fb-96bae8cb72d1')
;

-- Oct 3, 2020, 4:13:32 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200061,11,11,'Y',TO_DATE('2020-10-03 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,200000,702,'HQ-79600-_-_-_-_','Y','HQ-Charge expense-_-_-_-_','56955cff-fc23-46ef-a9a9-677457733b1e')
;

-- Oct 3, 2020, 4:13:43 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200062,11,11,'Y',TO_DATE('2020-10-03 16:13:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:13:43','YYYY-MM-DD HH24:MI:SS'),100,200000,567,'HQ-17710-_-_-_-_','Y','HQ-Project asset-_-_-_-_','0ed7c0c8-57dd-4410-84a9-bed51045f3d6')
;

-- Oct 3, 2020, 4:13:55 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200063,11,11,'Y',TO_DATE('2020-10-03 16:13:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:13:55','YYYY-MM-DD HH24:MI:SS'),100,200000,568,'HQ-17720-_-_-_-_','Y','HQ-Project WIP-_-_-_-_','7da2f078-2d87-4da0-9768-c8aee0ab9307')
;

-- Oct 3, 2020, 4:14:01 PM CEST
INSERT INTO C_AcctSchema_Default (C_AcctSchema_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,W_Differences_Acct,P_Revenue_Acct,P_Expense_Acct,P_Asset_Acct,P_COGS_Acct,C_Receivable_Acct,C_Prepayment_Acct,V_Liability_Acct,V_Prepayment_Acct,PJ_Asset_Acct,NotInvoicedReceipts_Acct,Processing,P_PurchasePriceVariance_Acct,PayDiscount_Exp_Acct,WriteOff_Acct,PayDiscount_Rev_Acct,UnrealizedGain_Acct,UnrealizedLoss_Acct,RealizedGain_Acct,RealizedLoss_Acct,PJ_WIP_Acct,T_Expense_Acct,T_Due_Acct,T_Credit_Acct,B_InTransit_Acct,B_Asset_Acct,B_InterestRev_Acct,B_InterestExp_Acct,Ch_Expense_Acct,UnEarnedRevenue_Acct,P_InvoicePriceVariance_Acct,P_TradeDiscountRec_Acct,P_TradeDiscountGrant_Acct,B_PaymentSelect_Acct,B_UnallocatedCash_Acct,P_InventoryClearing_Acct,P_CostAdjustment_Acct,P_RateVariance_Acct,P_AverageCostVariance_Acct,C_AcctSchema_Default_UU,P_LandedCostClearing_Acct) VALUES (200000,11,0,'Y',TO_DATE('2020-10-03 16:14:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 16:14:01','YYYY-MM-DD HH24:MI:SS'),100,200051,200043,200039,200038,200042,200034,200036,200035,200037,200062,200029,'N',200044,200031,200033,200032,200025,200026,200027,200028,200063,200060,200058,200059,200053,200052,200057,200056,200061,200030,200045,200046,200047,200054,200055,200041,200040,200048,200049,'05255bb9-df82-47c1-82d5-6af8d5106bdf',200050)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO M_Product_Category_Acct (M_Product_Category_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, P_Revenue_Acct, P_Expense_Acct, P_CostAdjustment_Acct, P_InventoryClearing_Acct, P_Asset_Acct, P_CoGs_Acct, P_PurchasePriceVariance_Acct, P_InvoicePriceVariance_Acct, P_AverageCostVariance_Acct, P_TradeDiscountRec_Acct, P_TradeDiscountGrant_Acct, P_RateVariance_Acct, P_LandedCostClearing_Acct)  SELECT p.M_Product_Category_ID, acct.C_AcctSchema_ID, p.AD_Client_ID, p.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.P_Revenue_Acct, acct.P_Expense_Acct, acct.P_CostAdjustment_Acct, acct.P_InventoryClearing_Acct, acct.P_Asset_Acct, acct.P_CoGs_Acct, acct.P_PurchasePriceVariance_Acct, acct.P_InvoicePriceVariance_Acct, acct.P_AverageCostVariance_Acct, acct.P_TradeDiscountRec_Acct, acct.P_TradeDiscountGrant_Acct, acct.P_RateVariance_Acct, acct.P_LandedCostClearing_Acct FROM M_Product_Category p INNER JOIN C_AcctSchema_Default acct ON (p.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM M_Product_Category_Acct pa WHERE pa.M_Product_Category_ID=p.M_Product_Category_ID AND pa.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO M_Product_Acct (M_Product_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, P_Revenue_Acct, P_Expense_Acct, P_CostAdjustment_Acct, P_InventoryClearing_Acct, P_Asset_Acct, P_CoGs_Acct, P_PurchasePriceVariance_Acct, P_InvoicePriceVariance_Acct, P_AverageCostVariance_Acct, P_TradeDiscountRec_Acct, P_TradeDiscountGrant_Acct,  P_RateVariance_Acct, P_LandedCostClearing_Acct) SELECT p.M_Product_ID, acct.C_AcctSchema_ID, p.AD_Client_ID, p.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.P_Revenue_Acct, acct.P_Expense_Acct, acct.P_CostAdjustment_Acct, acct.P_InventoryClearing_Acct, acct.P_Asset_Acct, acct.P_CoGs_Acct, acct.P_PurchasePriceVariance_Acct, acct.P_InvoicePriceVariance_Acct, acct.P_AverageCostVariance_Acct, acct.P_TradeDiscountRec_Acct, acct.P_TradeDiscountGrant_Acct, acct.P_RateVariance_Acct, acct.P_LandedCostClearing_Acct FROM M_Product p INNER JOIN M_Product_Category_Acct acct ON (acct.M_Product_Category_ID=p.M_Product_Category_ID)WHERE acct.C_AcctSchema_ID=200000 AND p.M_Product_Category_ID=acct.M_Product_Category_ID AND NOT EXISTS (SELECT * FROM M_Product_Acct pa WHERE pa.M_Product_ID=p.M_Product_ID AND pa.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_BP_Group_Acct (C_BP_Group_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, C_Receivable_Acct, C_Receivable_Services_Acct, C_PrePayment_Acct, V_Liability_Acct, V_Liability_Services_Acct, V_PrePayment_Acct, PayDiscount_Exp_Acct, PayDiscount_Rev_Acct, WriteOff_Acct, NotInvoicedReceipts_Acct, UnEarnedRevenue_Acct) SELECT x.C_BP_Group_ID, acct.C_AcctSchema_ID, x.AD_Client_ID, x.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.C_Receivable_Acct, acct.C_Receivable_Services_Acct, acct.C_PrePayment_Acct, acct.V_Liability_Acct, acct.V_Liability_Services_Acct, acct.V_PrePayment_Acct, acct.PayDiscount_Exp_Acct, acct.PayDiscount_Rev_Acct, acct.WriteOff_Acct, acct.NotInvoicedReceipts_Acct, acct.UnEarnedRevenue_Acct FROM C_BP_Group x INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM C_BP_Group_Acct a WHERE a.C_BP_Group_ID=x.C_BP_Group_ID AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_BP_Customer_Acct (C_BPartner_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, C_Receivable_Acct, C_Receivable_Services_Acct, C_PrePayment_Acct) SELECT p.C_BPartner_ID, acct.C_AcctSchema_ID, p.AD_Client_ID, p.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.C_Receivable_Acct, acct.C_Receivable_Services_Acct, acct.C_PrePayment_Acct FROM C_BPartner p INNER JOIN C_BP_Group_Acct acct ON (acct.C_BP_Group_ID=p.C_BP_Group_ID)WHERE acct.C_AcctSchema_ID=200000 AND p.C_BP_Group_ID=acct.C_BP_Group_ID AND NOT EXISTS (SELECT * FROM C_BP_Customer_Acct ca WHERE ca.C_BPartner_ID=p.C_BPartner_ID AND ca.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_BP_Vendor_Acct (C_BPartner_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, V_Liability_Acct, V_Liability_Services_Acct, V_PrePayment_Acct) SELECT p.C_BPartner_ID, acct.C_AcctSchema_ID, p.AD_Client_ID, p.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.V_Liability_Acct, acct.V_Liability_Services_Acct, acct.V_PrePayment_Acct FROM C_BPartner p INNER JOIN C_BP_Group_Acct acct ON (acct.C_BP_Group_ID=p.C_BP_Group_ID)WHERE acct.C_AcctSchema_ID=200000 AND p.C_BP_Group_ID=acct.C_BP_Group_ID AND NOT EXISTS (SELECT * FROM C_BP_Vendor_Acct va WHERE va.C_BPartner_ID=p.C_BPartner_ID AND va.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO M_Warehouse_Acct (M_Warehouse_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, W_Differences_Acct) SELECT x.M_Warehouse_ID, acct.C_AcctSchema_ID, x.AD_Client_ID, x.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.W_Differences_Acct FROM M_Warehouse x INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM M_Warehouse_Acct a WHERE a.M_Warehouse_ID=x.M_Warehouse_ID AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_Project_Acct (C_Project_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, PJ_Asset_Acct, PJ_WIP_Acct) SELECT x.C_Project_ID, acct.C_AcctSchema_ID, x.AD_Client_ID, x.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.PJ_Asset_Acct, acct.PJ_WIP_Acct FROM C_Project x INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM C_Project_Acct a WHERE a.C_Project_ID=x.C_Project_ID AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_Tax_Acct (C_Tax_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, T_Due_Acct, T_Credit_Acct, T_Expense_Acct) SELECT x.C_Tax_ID, acct.C_AcctSchema_ID, x.AD_Client_ID, x.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.T_Due_Acct, acct.T_Credit_Acct, acct.T_Expense_Acct FROM C_Tax x INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM C_Tax_Acct a WHERE a.C_Tax_ID=x.C_Tax_ID AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_BankAccount_Acct (C_BankAccount_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, B_InTransit_Acct, B_Asset_Acct, B_InterestRev_Acct, B_InterestExp_Acct, B_UnallocatedCash_Acct, B_PaymentSelect_Acct) SELECT x.C_BankAccount_ID, acct.C_AcctSchema_ID, x.AD_Client_ID, x.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.B_InTransit_Acct, acct.B_Asset_Acct, acct.B_InterestRev_Acct, acct.B_InterestExp_Acct, acct.B_UnallocatedCash_Acct, acct.B_PaymentSelect_Acct FROM C_BankAccount x INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM C_BankAccount_Acct a WHERE a.C_BankAccount_ID=x.C_BankAccount_ID AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_Charge_Acct (C_Charge_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, Ch_Expense_Acct) SELECT x.C_Charge_ID, acct.C_AcctSchema_ID, x.AD_Client_ID, x.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.Ch_Expense_Acct FROM C_Charge x INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM C_Charge_Acct a WHERE a.C_Charge_ID=x.C_Charge_ID AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

-- Oct 3, 2020, 4:18:29 PM CEST
INSERT INTO C_Cashbook_Acct (C_Cashbook_ID, C_AcctSchema_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, CB_Asset_Acct, CB_Differences_Acct, CB_CashTransfer_Acct, CB_Expense_Acct, CB_Receipt_Acct) SELECT x.C_Cashbook_ID, acct.C_AcctSchema_ID, x.AD_Client_ID, x.AD_Org_ID, 'Y', getDate(), 0, getDate(), 0, acct.CB_Asset_Acct, acct.CB_Differences_Acct, acct.CB_CashTransfer_Acct, acct.CB_Expense_Acct, acct.CB_Receipt_Acct FROM C_Cashbook x INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) WHERE acct.C_AcctSchema_ID=200000 AND NOT EXISTS (SELECT * FROM C_Cashbook_Acct a WHERE a.C_Cashbook_ID=x.C_Cashbook_ID AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)
;

UPDATE C_BankAccount_Acct SET C_BankAccount_Acct_UU='2897d2a7-b378-4b06-a9bd-706b6dda50a8' WHERE C_AcctSchema_ID=200000 AND C_BankAccount_ID=100
;

UPDATE C_BankAccount_Acct SET C_BankAccount_Acct_UU='9caff9eb-fba7-4a5a-928b-1eea7e03b200' WHERE C_AcctSchema_ID=200000 AND C_BankAccount_ID=200000
;

UPDATE C_BankAccount_Acct SET C_BankAccount_Acct_UU='db09dc3c-1398-4258-824b-332b4ffb3e16' WHERE C_AcctSchema_ID=200000 AND C_BankAccount_ID=101
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='04829b6e-ef28-452d-ba7d-a2b9ac9afb49' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=119
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='12397047-6260-4a71-8ebb-2fdd14ac0bc0' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=112
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='21874b2b-60bb-4374-94d8-179bd27cf545' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50003
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='2884f6fd-a390-44c5-ba2f-e6c50a67f73f' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50008
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='2f6ef7df-b5a8-41e1-b66d-aa372c85fe1c' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=117
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='4f74fb5c-82a3-4f6b-a66b-3d6e0c8466a3' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50004
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='57088f69-c93e-4ebb-b487-2e6a31609a48' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50007
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='63dff92e-dd8e-450d-8c4c-de8943be2e6b' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=118
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='71a73280-f551-455e-b750-9d9c9bfcde22' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50005
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='83c801f3-84a3-4025-a0ca-47d66cc36205' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50001
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='862627ce-6c57-4ea6-8ea9-945f4f467ecc' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=113
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='9329e64c-6475-4880-b961-5d2d4d25db66' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50002
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='a15d7fc3-a5ad-4a40-9197-32f22966793b' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=114
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='b614c957-8d65-4f02-b482-4bfeaf6e9646' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50009
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='d405c6d1-f29c-4b1d-aa2a-722ec3822417' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50000
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='dee31c4f-d35d-470d-8b60-22ee51d89248' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=120
;

UPDATE C_BP_Customer_Acct SET C_BP_Customer_Acct_UU='e52cbb6a-d0cc-464d-84cd-3632a4559858' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=121
;

UPDATE C_BP_Group_Acct SET C_BP_Group_Acct_UU='4edf9f60-a343-4bd8-aa3f-8846d9d54640' WHERE C_AcctSchema_ID=200000 AND C_BP_Group_ID=103
;

UPDATE C_BP_Group_Acct SET C_BP_Group_Acct_UU='4f425d05-dc4a-4d04-bbf7-867f1f08e7ae' WHERE C_AcctSchema_ID=200000 AND C_BP_Group_ID=104
;

UPDATE C_BP_Group_Acct SET C_BP_Group_Acct_UU='d26579b0-8441-4dba-a845-7d91473c00ea' WHERE C_AcctSchema_ID=200000 AND C_BP_Group_ID=105
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='0f6601a6-f3f4-411d-8c19-d9014116f485' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=119
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='1a91ba21-1334-4f0c-9138-5aa19a1ff548' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50000
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='2332be4e-9b45-423f-9300-41edeb4297fb' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50004
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='45bd491a-c377-4650-938d-a4a4c68fc616' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50005
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='5c8d13d1-0e65-4ffc-bde6-f364f99cc534' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50009
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='5f33278e-3b74-48f1-9a05-c10e39eb4abf' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=118
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='60186e2c-e387-46a6-81f1-0c7e89510c0f' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50001
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='63b32bfd-8889-4615-8c69-c305d3866163' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=113
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='6df4eb59-b9a9-433a-a2e6-d590caf2cd32' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=120
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='6efbe5ac-a99d-4a20-8430-361fb41064f1' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50003
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='6efe850a-2da3-42b9-b932-b7a9d661a0a1' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=121
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='71ee6c36-5e61-4120-b498-59f2fc2ef85f' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=112
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='ae32753a-4396-4432-af0b-534af24739f3' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50008
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='ba00e635-3dee-4c7e-9f02-f13bd3138a50' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50007
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='cee32ad6-8de1-463b-9824-3e5d1619fa10' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=50002
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='d4ec5408-98ff-47c9-b377-112d61a294c1' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=114
;

UPDATE C_BP_Vendor_Acct SET C_BP_Vendor_Acct_UU='e37c4b49-bb74-4868-aaa5-e84a16885d09' WHERE C_AcctSchema_ID=200000 AND C_BPartner_ID=117
;

UPDATE C_CashBook_Acct SET C_CashBook_Acct_UU='b0ad96ce-2c6a-4864-8ce7-a7c19d4ff67b' WHERE C_AcctSchema_ID=200000 AND C_CashBook_ID=101
;

UPDATE C_CashBook_Acct SET C_CashBook_Acct_UU='edc4604f-f76c-420b-b4b6-b49e634b259c' WHERE C_AcctSchema_ID=200000 AND C_CashBook_ID=102
;

UPDATE C_Charge_Acct SET C_Charge_Acct_UU='0c8a6a6f-0ca2-43cd-a275-272f95fa9ae5' WHERE C_AcctSchema_ID=200000 AND C_Charge_ID=100
;

UPDATE C_Charge_Acct SET C_Charge_Acct_UU='43459a63-c8d3-4c64-ba23-d3e7f65038ab' WHERE C_AcctSchema_ID=200000 AND C_Charge_ID=200000
;

UPDATE C_Charge_Acct SET C_Charge_Acct_UU='fd59b02e-4d15-4bca-af55-2d5ec37a2e31' WHERE C_AcctSchema_ID=200000 AND C_Charge_ID=101
;

UPDATE C_Project_Acct SET C_Project_Acct_UU='3f75313e-50f0-41b5-ab4d-3ff71760a080' WHERE C_AcctSchema_ID=200000 AND C_Project_ID=101
;

UPDATE C_Project_Acct SET C_Project_Acct_UU='ad016b6b-2e07-454b-9bda-a59ec56ac899' WHERE C_AcctSchema_ID=200000 AND C_Project_ID=100
;

UPDATE C_Tax_Acct SET C_Tax_Acct_UU='2158ef33-88f0-4079-8c9a-6ea6a5fe3717' WHERE C_AcctSchema_ID=200000 AND C_Tax_ID=106
;

UPDATE C_Tax_Acct SET C_Tax_Acct_UU='23725325-e80e-45e1-bdd5-2556950d8865' WHERE C_AcctSchema_ID=200000 AND C_Tax_ID=108
;

UPDATE C_Tax_Acct SET C_Tax_Acct_UU='5abf9c70-b5ae-44b4-bda0-6a3f408aec79' WHERE C_AcctSchema_ID=200000 AND C_Tax_ID=105
;

UPDATE C_Tax_Acct SET C_Tax_Acct_UU='5e83af66-8bd8-45d7-badd-07d90fa5a648' WHERE C_AcctSchema_ID=200000 AND C_Tax_ID=104
;

UPDATE C_Tax_Acct SET C_Tax_Acct_UU='8c399f57-aa6d-4642-b7ae-048e25f6b26b' WHERE C_AcctSchema_ID=200000 AND C_Tax_ID=107
;

UPDATE C_Tax_Acct SET C_Tax_Acct_UU='a83e14a5-8577-4569-a538-285ea758383a' WHERE C_AcctSchema_ID=200000 AND C_Tax_ID=109
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='03fa4e97-8cc1-4e75-bd58-23c20a3a9caa' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=125
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='04afdb5c-a9dd-4af8-88f3-3bd4320d9c7a' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50025
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='0948fd54-1505-4f7e-8a00-fdb961ac263a' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=132
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='25c1781a-90f1-4d69-a123-21fafc1fbd74' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50000
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='28b1cf81-0882-46e2-98ec-84ac35363e18' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50020
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='2a7d6c0e-6664-46a9-a55c-2582f2a402bd' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50026
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='2c190834-5d46-43df-ad73-70a4179d8cb5' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50004
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='405f1339-1a6f-418d-8c41-067979d80bb5' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50017
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='42d78c75-6524-4ac9-8971-41132c4c8bdf' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=126
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='46c57b96-587e-49f9-9e2e-3d0e6752f532' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50015
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='47e0729b-26dc-4e7a-a6fb-1c009f7f6bbd' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50027
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='4a1733dd-a0c3-4d43-a2ed-506f1ce1fc35' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50009
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='4ba76894-a2de-4c81-83e7-93c5638cc688' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=200001
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='4da56d0c-6d7d-4dbd-83f0-280664accdad' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=200002
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='52181a50-38a9-46a1-ac51-1819af0c0137' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=137
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='5414d735-f44e-43ae-af31-c00c1b14a11e' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=136
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='54cb435a-bdf7-42a5-8566-1c370ddc213c' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50005
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='5dfb6ca7-d980-41e3-9d92-87b56991efec' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=141
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='62dfa1ee-030a-48ac-b7ba-df43f3fa412a' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=147
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='674ebd0f-6c66-4e6d-9c28-3034f29bad2f' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=124
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='6968960d-c9cc-4d2e-aa72-0d92de5c18ac' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50008
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='6cbbae36-d419-4344-9003-70f6b1167f66' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=122
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='729f97f4-cae9-4e8a-954c-ded771aceb7b' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50024
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='733e155b-30a6-463b-802a-be1675293fbb' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=138
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='819291ae-8316-4d92-ba87-49dca4ba75aa' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50013
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='8632c44a-44bc-4711-b121-7c243a7a2c38' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=145
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='8a4baf9b-ef55-4d47-94de-5cf8c4369031' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=148
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='8e77660e-da60-4914-aebb-ed6d35540c97' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50016
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='920d9f0f-cf07-4329-a582-2fb8a9154e09' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50003
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='96e64a75-44b6-4c10-a7c8-4900b39aef3d' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50021
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='96fb63d7-5db3-4434-96d2-2cd85f9ae543' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=133
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='9aa6b465-998f-498e-a3e6-d0cd071d5d2e' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50012
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='9af314a3-4407-4ba8-b514-b6d0c0ee551e' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=139
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='9c75549f-e409-46c6-8295-0304266bfb6b' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50019
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='9c94354a-62e8-44a6-b163-a73733e8bfd9' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=142
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='9c962fc1-66f3-4c97-bbe6-9db5d21803ad' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=135
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='9e4e07f7-82f5-42d9-8a5e-96e3c05133ab' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50022
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='a4030981-657a-4b29-936c-89a0ebb48015' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50002
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='ad45dd42-8008-4a55-a24c-5fa3ff5aaa5a' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=134
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='b1f5eb67-2b3e-437f-ad76-86359348ecdf' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=144
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='b2a18bc6-c347-4009-bdf1-0b5a58763441' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50023
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='b5006ec7-f1df-41ce-afad-1b7cb558a5a2' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=131
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='ba8f47b3-8346-471b-ba4f-90469532054a' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=127
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='bdf7012a-41d1-46f6-be66-e21f139c6a7a' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50014
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='c51dec40-4f1c-4408-b5b3-7ced3345a5e3' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=146
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='c9fa5e1a-755b-4acf-8c25-97e944c790b9' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=140
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='cc09e18e-41f1-4a93-96a6-2d4cede173c6' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=130
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='d6b860fd-6280-4e11-9a86-986bd5d52f31' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50007
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='d6e6c9a4-b139-42ee-b381-d7c480023654' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50018
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='de9ae218-d5d7-4451-87fe-e430b3a264c4' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50001
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='f180a713-7e20-492c-a0f1-ba38f5a9af09' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=123
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='f2482f5c-7f78-4c3f-aae4-7c38a67d96fe' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=129
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='f2a17f77-334b-4d1b-a279-3449b7db0af8' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=143
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='f664d8a7-d861-4e5d-85cc-5cdbb3556049' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=128
;

UPDATE M_Product_Acct SET M_Product_Acct_UU='f9ab82a4-e77a-4a96-9d2d-d168e7c8f2ca' WHERE C_AcctSchema_ID=200000 AND M_Product_ID=50010
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='0af94911-d24f-4cb9-8255-7740b9c82d99' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=108
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='198456da-1a89-47ad-9b5d-a0bbdb7e664c' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=109
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='3231f554-1971-4a54-8f9c-212edb98f881' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=112
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='58d0664d-f41f-4a28-bba4-a5ceb30f00b7' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=106
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='6147cd49-eff9-4efe-b7b0-2f162d786510' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=200000
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='7fdd7516-1054-4d03-91e2-28974c0ecf7a' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=200001
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='9c20e98e-6be4-4133-ac6c-0e5092eec3bc' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=111
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='aaaa8de9-5e42-4496-8615-db83a3f07d1e' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=50003
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='bfb1ad4c-986e-40e6-b94f-20cb3d98bb02' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=107
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='db8226a5-26b1-425b-a83f-5727eb07be36' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=110
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='e8161082-1baa-4fcd-99a3-44306b212ea5' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=50002
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='e8acb2e3-e45b-4a25-943f-c0b7877117ad' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=105
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='ead0a796-756b-4a1f-817c-b09d1e706498' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=50000
;

UPDATE M_Product_Category_Acct SET M_Product_Category_Acct_UU='f8236a9a-c09d-466c-aba6-6098821d2f8d' WHERE C_AcctSchema_ID=200000 AND M_Product_Category_ID=50001
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='10a72d67-870c-4cd3-9a92-ae3924309a65' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50004
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='110bffd6-4544-40c1-aa88-fac6231055da' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50006
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='527c87fb-8b2d-4f10-990f-d83efe067fc7' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50002
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='8992364b-c7d2-4c7b-8c8d-26c6816f3281' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50007
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='8f33483a-63a0-48ab-9980-c092cfabd160' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50003
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='9dc79a83-f4b6-40e1-8c4a-d0e94f9d86d7' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=104
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='b4e395d3-91fa-4e41-be3f-f4435bf41139' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50000
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='bd8275b3-5267-4212-acff-1c5cb2a4c31d' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50005
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='bfc9b099-f24d-45ea-bacc-ff28cf0a4a66' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=103
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='df8c29df-550f-443d-834e-50729afb8936' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50001
;

UPDATE M_Warehouse_Acct SET M_Warehouse_Acct_UU='f1216443-eac4-47e7-a7cf-cc69db6a31bd' WHERE C_AcctSchema_ID=200000 AND M_Warehouse_ID=50008
;

UPDATE C_Conversion_Rate SET validfrom = to_date('2000-01-01','yyyy-mm-dd') WHERE C_Conversion_Rate_ID IN (135,136)
;

-- Oct 3, 2020, 5:01:30 PM CEST
INSERT INTO AD_UserQuery (AD_UserQuery_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,AD_Tab_ID,AD_UserQuery_UU,AD_Window_ID) VALUES (200000,11,11,'Y',TO_DATE('2020-10-03 17:01:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 17:01:29','YYYY-MM-DD HH24:MI:SS'),100,'Not Draft',635,662,'92b2d5dd-d670-4414-92a1-c189a921a281',294)
;

-- Oct 3, 2020, 5:32:18 PM CEST
UPDATE AD_UserQuery SET Code='DocStatus<^>!=<^>DR<^><^><^><^><~>IsActive<^>=<^>Y<^><^>AND<^><^>' WHERE AD_UserQuery_ID=200000
;

-- Oct 3, 2020, 5:13:50 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,IsPayScheduleValid,C_Order_UU) VALUES (200002,11,11,'Y',TO_DATE('2020-10-03 17:13:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 17:13:50','YYYY-MM-DD HH24:MI:SS'),100,'8000','DR','CO',0,126,'N','N','N','N','N','N',TO_DATE('2002-02-22','YYYY-MM-DD'),TO_DATE('2002-02-22','YYYY-MM-DD'),TO_DATE('2002-02-22','YYYY-MM-DD'),101,106,100,'D',0,'P','5',0,0,103,101,'N',114,103,0,'N',109,'N','A','I','P','Y','N','N','N','N',103,114,'N',109,'N',114,'N','N','133084b2-38de-4076-864c-b193ad0cc225')
;

-- Oct 3, 2020, 5:14:33 PM CEST
UPDATE C_Order SET M_PriceList_ID=102,Updated=TO_DATE('2020-10-03 17:14:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:16:04 PM CEST
UPDATE M_PriceList_Version SET IsActive='Y',Updated=TO_DATE('2020-10-03 17:16:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_PriceList_Version_ID=102
;

-- Oct 3, 2020, 5:16:19 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU) VALUES (200002,11,11,'Y',TO_DATE('2020-10-03 17:16:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 17:16:19','YYYY-MM-DD HH24:MI:SS'),100,200002,10,TO_DATE('2002-02-22','YYYY-MM-DD'),TO_DATE('2002-02-22','YYYY-MM-DD'),123,100,103,10,0,0,0,100,60,36,104,114,0,109,360,24,40.00,0,'N','N',36,10,0,0,0,'0d8196ae-d638-4865-b8e5-aa1c26ca0aae')
;

-- Oct 3, 2020, 5:16:19 PM CEST
UPDATE C_Order i SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE i.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:16:19 PM CEST
UPDATE C_Order i  SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE i.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:16:31 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU) VALUES (200003,11,11,'Y',TO_DATE('2020-10-03 17:16:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 17:16:31','YYYY-MM-DD HH24:MI:SS'),100,200002,20,TO_DATE('2002-02-22','YYYY-MM-DD'),TO_DATE('2002-02-22','YYYY-MM-DD'),130,100,103,10,0,0,0,100,50,30,104,114,0,109,300,20,40.00,0,'N','N',30,10,0,0,0,'66b7002c-feba-4def-8bd2-619e52a32409')
;

-- Oct 3, 2020, 5:16:31 PM CEST
UPDATE C_Order i SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE i.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:16:31 PM CEST
UPDATE C_Order i  SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE i.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:22 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_DATE('2020-10-03 17:20:22','YYYY-MM-DD HH24:MI:SS'),'N',TO_DATE('2020-10-03 17:20:22','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,11,'ON',101,100,101,200004,'8000: Grand Total=660',259,0,200002,'b8b04ff8-10d0-4fa1-b2e3-6275370d34a9')
;

-- Oct 3, 2020, 5:20:22 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_DATE('2020-10-03 17:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200004
;

-- Oct 3, 2020, 5:20:22 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,11,100,101,200012,200004,'Y','N','N','ON',TO_DATE('2020-10-03 17:20:22','YYYY-MM-DD HH24:MI:SS'),100,11,TO_DATE('2020-10-03 17:20:22','YYYY-MM-DD HH24:MI:SS'),116,0,200002,259,'2680a35c-0f94-430b-85e7-2a4932850c58')
;

-- Oct 3, 2020, 5:20:23 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_DATE('2020-10-03 17:20:22','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_DATE('2020-10-03 17:20:22','YYYY-MM-DD HH24:MI:SS'),200012,'PC',200004,259,183,200002,0.0,'9c4656a4-d20b-438c-9eae-1c6cf4612862')
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200012
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200012
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200012
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=1117,Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200012
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200012
;

-- Oct 3, 2020, 5:20:23 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,11,100,101,200013,200004,'Y','N','N','ON',TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,11,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),116,0,200002,259,'59634df8-04cc-4fe5-9b3b-2d19c132d887')
;

-- Oct 3, 2020, 5:20:23 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),200013,'PC',200004,259,185,200002,0.0,'35c60f8f-e874-4889-96b0-f8caf6f1b99b')
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200013
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200013
;

-- Oct 3, 2020, 5:20:23 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,11,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,103,123,0.0,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,'N','202ee7de-9839-41fa-ac05-caf4a740442b')
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE C_OrderLine SET QtyReserved=10, LineNetAmt=360, Discount=40.00,Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200002
;

-- Oct 3, 2020, 5:20:23 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,11,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,103,130,0.0,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,'N','6fc62202-3ef5-4a18-b4c9-bc09f9198689')
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE C_OrderLine SET QtyReserved=10, LineNetAmt=300, Discount=40.00,Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200003
;

-- Oct 3, 2020, 5:20:23 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:23 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,11,'Y',TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,200002,104,660.0,0.0,'N','N','10464771-d9fa-4f4e-8ba2-a5ad1cd19751')
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=126, TotalLines=660.0, GrandTotal=660.0, Volume=0.0, Weight=0.0,Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='8000: Grand Total=660.0 (#2)',Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200013
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='8000: Grand Total=660.0 (#2)', ElapsedTimeMS=880,Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200013
;

-- Oct 3, 2020, 5:20:23 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200013
;

-- Oct 3, 2020, 5:20:24 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,11,100,101,200014,200004,'Y','N','N','ON',TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),100,11,TO_DATE('2020-10-03 17:20:23','YYYY-MM-DD HH24:MI:SS'),116,0,200002,259,'bb933a5d-dce5-4610-a12f-4041bca9b239')
;

-- Oct 3, 2020, 5:20:24 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),200014,'PC',200004,259,186,200002,0.0,'7afb7293-44f9-4efd-b225-8f6d3628efa9')
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200014
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200014
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1601738424536.5366,Updated=TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200002 AND Processed='Y' AND IsActive='Y'
;

-- Oct 3, 2020, 5:20:24 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200002 AND C_AcctSchema_ID=101
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE M_Product_PO po SET PriceLastPO = (SELECT currencyConvert(ol.PriceActual,ol.C_Currency_ID,po.C_Currency_ID,o.DateOrdered,o.C_ConversionType_ID,o.AD_Client_ID,o.AD_Org_ID) FROM C_Order o, C_OrderLine ol WHERE o.C_Order_ID=ol.C_Order_ID AND po.M_Product_ID=ol.M_Product_ID AND po.C_BPartner_ID=o.C_BPartner_ID  AND ol.C_OrderLine_ID = (SELECT MIN(ol1.C_OrderLine_ID) FROM C_Order o1, C_OrderLine ol1 WHERE o1.C_Order_ID=ol1.C_Order_ID AND po.M_Product_ID=ol1.M_Product_ID AND po.C_BPartner_ID=o1.C_BPartner_ID  AND o1.C_Order_ID=200002)   AND o.C_Order_ID=200002) WHERE EXISTS (SELECT * FROM C_Order o, C_OrderLine ol WHERE o.C_Order_ID=ol.C_Order_ID AND po.M_Product_ID=ol.M_Product_ID AND po.C_BPartner_ID=o.C_BPartner_ID AND o.C_Order_ID=200002)
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200002 AND Processed='Y' AND IsActive='Y'
;

-- Oct 3, 2020, 5:20:24 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200002 AND C_AcctSchema_ID=200000
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200002
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='8000: Grand Total=660.0',Updated=TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200014
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='8000: Grand Total=660.0', ElapsedTimeMS=601,Updated=TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200014
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200014
;

-- Oct 3, 2020, 5:20:24 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_DATE('2020-10-03 17:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200004
;

-- Oct 3, 2020, 5:21:30 PM CEST
UPDATE C_OrderLine SET QtyReserved=0.0, LineNetAmt=360, Discount=40.00,Updated=TO_DATE('2020-10-03 17:21:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200002
;

-- Oct 3, 2020, 5:21:30 PM CEST
UPDATE M_InOutLine SET C_OrderLine_ID=200002,Updated=TO_DATE('2020-10-03 17:21:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_InOutLine_ID=106
;

-- Oct 3, 2020, 5:21:30 PM CEST
INSERT INTO M_MatchPO (M_MatchPO_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_InOutLine_ID,C_OrderLine_ID,M_Product_ID,DateTrx,Processing,Processed,Posted,Qty,C_InvoiceLine_ID,DocumentNo,DateAcct,M_AttributeSetInstance_ID,PriceMatchDifference,IsApproved,ProcessedOn,M_MatchPO_UU) VALUES (200002,11,11,'Y',TO_DATE('2020-10-03 17:21:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 17:21:30','YYYY-MM-DD HH24:MI:SS'),100,106,200002,123,TO_DATE('2020-10-03','YYYY-MM-DD'),'N','Y','N',10.0,106,'10000000',TO_DATE('2002-09-07','YYYY-MM-DD'),0,0,'Y',1601738490317.3174,'45ee5d8a-c62d-44ce-bf2c-79b5c00d629e')
;

-- Oct 3, 2020, 5:21:30 PM CEST
UPDATE C_OrderLine SET DateDelivered=TO_DATE('2020-10-03','YYYY-MM-DD'), DateInvoiced=TO_DATE('2020-10-03','YYYY-MM-DD'), QtyDelivered=10.0, QtyInvoiced=10.0, LineNetAmt=360, Discount=40.00, M_AttributeSetInstance_ID=0,Updated=TO_DATE('2020-10-03 17:21:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200002
;

-- Oct 3, 2020, 5:21:35 PM CEST
UPDATE C_OrderLine SET QtyReserved=0.0, LineNetAmt=300, Discount=40.00,Updated=TO_DATE('2020-10-03 17:21:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200003
;

-- Oct 3, 2020, 5:21:35 PM CEST
UPDATE M_InOutLine SET C_OrderLine_ID=200003,Updated=TO_DATE('2020-10-03 17:21:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_InOutLine_ID=102
;

-- Oct 3, 2020, 5:21:35 PM CEST
INSERT INTO M_MatchPO (M_MatchPO_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_InOutLine_ID,C_OrderLine_ID,M_Product_ID,DateTrx,Processing,Processed,Posted,Qty,C_InvoiceLine_ID,DocumentNo,DateAcct,M_AttributeSetInstance_ID,PriceMatchDifference,ProcessedOn,M_MatchPO_UU) VALUES (200003,11,11,'Y',TO_DATE('2020-10-03 17:21:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-03 17:21:35','YYYY-MM-DD HH24:MI:SS'),100,102,200003,130,TO_DATE('2020-10-03','YYYY-MM-DD'),'N','Y','N',10.0,102,'10000001',TO_DATE('2002-02-22','YYYY-MM-DD'),0,100.0,1601738495620.62,'561fc311-1055-4464-b988-27201e37486d')
;

-- Oct 3, 2020, 5:21:36 PM CEST
UPDATE C_OrderLine SET DateDelivered=TO_DATE('2020-10-03','YYYY-MM-DD'), DateInvoiced=TO_DATE('2020-10-03','YYYY-MM-DD'), QtyDelivered=10.0, QtyInvoiced=10.0, LineNetAmt=300, Discount=40.00, M_AttributeSetInstance_ID=0,Updated=TO_DATE('2020-10-03 17:21:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200003
;

-- Oct 3, 2020, 6:21:35 PM CEST
UPDATE AD_SysConfig SET Value='I',Updated=TO_DATE('2020-10-03 18:21:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50034
;

DELETE FROM Fact_Acct WHERE AD_Client_ID=11
;

UPDATE A_Asset_Addition SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE A_Asset_Disposed SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE A_Asset_Reval SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE A_Asset_Transfer SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE A_Depreciation_Entry SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_AllocationHdr SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_BankStatement SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_Cash SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_Invoice SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_Order SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_Payment SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_ProjectIssue SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE DD_Order SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE GL_Journal SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE HR_Process SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE M_InOut SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE M_Inventory SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE M_MatchInv SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE M_MatchPO SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE M_Movement SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE M_Production SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE M_Requisition SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE PP_Cost_Collector SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE PP_Order SET Posted='N', Processing='N' WHERE AD_Client_ID=11
;

UPDATE C_Cash SET IsActive='N' WHERE AD_Client_ID=11
;

UPDATE C_Order SET ProcessedOn=1014415463000 WHERE C_Order_ID=104
;

UPDATE C_Order SET ProcessedOn=1014415464000 WHERE C_Order_ID=200002
;

UPDATE C_Invoice SET ProcessedOn=1014415465000 WHERE C_Invoice_ID=102
;

UPDATE M_MatchPO SET ProcessedOn=1014415465500 WHERE M_MatchPO_ID IN (200002,200003)
;

SELECT register_migration_script('202010031628_IDEMPIERE-4297.sql') FROM dual
;

