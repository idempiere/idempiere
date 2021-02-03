-- IDEMPIERE-4645 Search by special field types failing
-- Jan 13, 2021, 10:35:06 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200180,'M_AttributeSetInstance','Attribute Set Instance','T',0,0,'Y',TO_TIMESTAMP('2021-01-13 10:35:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:35:06','YYYY-MM-DD HH24:MI:SS'),100,'D','N','b5bbd62d-3952-41a0-a24a-552917766c57')
;

-- Jan 13, 2021, 10:35:52 AM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200180,559,8472,8479,0,0,'Y',TO_TIMESTAMP('2021-01-13 10:35:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:35:52','YYYY-MM-DD HH24:MI:SS'),100,'N','D','4606d4f7-fa80-424a-b8fb-ab7930a5505f')
;

-- Jan 13, 2021, 10:36:17 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200181,'S_ResourceAssignment','Resource Assignment','T',0,0,'Y',TO_TIMESTAMP('2021-01-13 10:36:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:36:17','YYYY-MM-DD HH24:MI:SS'),100,'D','N','0fbb9b88-bec0-437e-baff-b5fc8d98f5e0')
;

-- Jan 13, 2021, 10:37:56 AM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200181,485,6834,6937,0,0,'Y',TO_TIMESTAMP('2021-01-13 10:37:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:37:56','YYYY-MM-DD HH24:MI:SS'),100,'N','D','3c361623-901d-4232-a71f-9633cdb68a5c')
;

-- Jan 13, 2021, 10:38:14 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200182,'AD_Image','Image','T',0,0,'Y',TO_TIMESTAMP('2021-01-13 10:38:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:38:14','YYYY-MM-DD HH24:MI:SS'),100,'D','N','3c7cb70b-e7e0-47e6-a21b-da42a725e5d5')
;

-- Jan 13, 2021, 10:38:32 AM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200182,461,6287,6295,0,0,'Y',TO_TIMESTAMP('2021-01-13 10:38:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:38:32','YYYY-MM-DD HH24:MI:SS'),100,'N','D','04075c33-d72b-400c-8221-555c030f2b02')
;

-- Jan 13, 2021, 10:39:01 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200183,'AD_Chart','Chart','T',0,0,'Y',TO_TIMESTAMP('2021-01-13 10:39:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:39:01','YYYY-MM-DD HH24:MI:SS'),100,'D','N','19401d65-0125-41ab-a79d-6a149aa4d670')
;

-- Jan 13, 2021, 10:39:27 AM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200183,53284,59694,59696,0,0,'Y',TO_TIMESTAMP('2021-01-13 10:39:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-13 10:39:26','YYYY-MM-DD HH24:MI:SS'),100,'N','D','ec15b1d8-3800-43b8-b311-1e5ef9ce09e4')
;

-- Jan 13, 2021, 11:45:32 AM CET
UPDATE AD_Ref_Table SET AD_Display=2400,Updated=TO_TIMESTAMP('2021-01-13 11:45:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=175
;

SELECT register_migration_script('202101131048_IDEMPIERE-4645.sql') FROM dual
;

