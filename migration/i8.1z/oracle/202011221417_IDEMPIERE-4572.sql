SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4572 NPE - Error posting Asset addition
-- Nov 22, 2020, 2:16:33 PM CET
INSERT INTO A_Asset_Group_Acct (A_Asset_Group_Acct_ID,AD_Client_ID,AD_Org_ID,A_Asset_Group_ID,A_Depreciation_Acct,A_Depreciation_ID,C_AcctSchema_ID,A_Split_Percent,UseLifeYears,UseLifeMonths,UpdatedBy,Updated,Processing,PostingType,IsActive,CreatedBy,Created,A_Accumdepreciation_Acct,A_Asset_Acct,A_Disposal_Loss_Acct,A_Disposal_Revenue_Acct,A_Depreciation_F_ID,UseLifeYears_F,UseLifeMonths_F,A_Asset_Group_Acct_UU) VALUES (200005,11,11,50007,200001,50003,200000,1,0,0,100,TO_DATE('2020-11-22 14:16:33','YYYY-MM-DD HH24:MI:SS'),'N','A','Y',100,TO_DATE('2020-11-22 14:16:33','YYYY-MM-DD HH24:MI:SS'),200004,200013,200006,200005,50003,0,0,'ce481c3c-d8fe-4a3c-9311-5878d18da086')
;

-- Nov 22, 2020, 2:16:33 PM CET
INSERT INTO A_Asset_Group_Acct (A_Asset_Group_Acct_ID,AD_Client_ID,AD_Org_ID,A_Asset_Group_ID,A_Depreciation_Acct,A_Depreciation_ID,C_AcctSchema_ID,A_Split_Percent,UseLifeYears,UseLifeMonths,UpdatedBy,Updated,Processing,PostingType,IsActive,CreatedBy,Created,A_Accumdepreciation_Acct,A_Asset_Acct,A_Disposal_Loss_Acct,A_Disposal_Revenue_Acct,A_Depreciation_F_ID,UseLifeYears_F,UseLifeMonths_F,A_Asset_Group_Acct_UU) VALUES (200006,11,11,50000,200007,50003,200000,1,0,0,100,TO_DATE('2020-11-22 14:16:33','YYYY-MM-DD HH24:MI:SS'),'N','A','Y',100,TO_DATE('2020-11-22 14:16:33','YYYY-MM-DD HH24:MI:SS'),200011,200010,200009,200005,50003,0,0,'69282a7a-29da-4191-922b-6f3f1998e821')
;

-- Nov 22, 2020, 2:16:34 PM CET
INSERT INTO A_Asset_Group_Acct (A_Asset_Group_Acct_ID,AD_Client_ID,AD_Org_ID,A_Asset_Group_ID,A_Depreciation_Acct,A_Depreciation_ID,C_AcctSchema_ID,A_Split_Percent,UseLifeYears,UseLifeMonths,UpdatedBy,Updated,Processing,PostingType,IsActive,CreatedBy,Created,A_Accumdepreciation_Acct,A_Asset_Acct,A_Disposal_Loss_Acct,A_Disposal_Revenue_Acct,A_Depreciation_F_ID,UseLifeYears_F,UseLifeMonths_F,A_Asset_Group_Acct_UU) VALUES (200007,11,11,50006,200016,50003,200000,1,0,0,100,TO_DATE('2020-11-22 14:16:33','YYYY-MM-DD HH24:MI:SS'),'N','A','Y',100,TO_DATE('2020-11-22 14:16:33','YYYY-MM-DD HH24:MI:SS'),200015,200014,200006,200005,50003,0,0,'02dcd00d-82d0-4784-ad7d-ab7a1de8d5f6')
;

SELECT register_migration_script('202011221417_IDEMPIERE-4572.sql') FROM dual
;

