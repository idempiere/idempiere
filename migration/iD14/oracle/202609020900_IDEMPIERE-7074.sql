-- IDEMPIERE-7074 Business Partner Info window without contact/location (one row per partner)
SELECT register_migration_script('202609020900_IDEMPIERE-7074.sql') FROM dual;

-- Sep 2, 2026, 9:00:00 AM
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,Description,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,IsDefault,IsDistinct,OrderByClause,IsValid,ImageURL) VALUES ('N','C_BPartner bp
LEFT OUTER JOIN C_BPartner_Location l ON (bp.C_BPartner_ID=l.C_BPartner_ID AND l.IsActive=''Y'')
LEFT OUTER JOIN AD_User c ON (bp.C_BPartner_ID=c.C_BPartner_ID AND (c.C_BPartner_Location_ID IS NULL OR c.C_BPartner_Location_ID=l.C_BPartner_Location_ID) AND c.IsActive=''Y'')
LEFT OUTER JOIN C_Location a ON (l.C_Location_ID=a.C_Location_ID)','6a7f7db9-ec0b-4620-95dd-937d48c55c4f',200025,291,'D','Business Partner Info (Simple)','Business Partner lookup showing one row per partner, without contact and location columns. Contacts and locations are joined for search criteria only.',0,0,TO_TIMESTAMP('2026-09-02 09:00:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-09-02 09:00:00','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','Y','Y','bp.Value','N','InfoBPartner16.png')
;

-- Sep 2, 2026, 9:00:01 AM
-- IDEMPIERE-7074 the default info window for C_BPartner is now the simplified one
UPDATE AD_InfoWindow SET IsDefault='N',Updated=TO_TIMESTAMP('2026-09-02 09:00:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200001
;

-- Sep 2, 2026, 9:00:02 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsIdentifier,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200025,'53d3c203-1f94-4f77-8986-70558cc2a2b7',10,200282,'Y','Y','D','Search key for the record in the format required - must be unique',TO_TIMESTAMP('2026-09-02 09:00:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:02','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Search Key','Y','Value','Y','Y',620,10,'Like','Upper','bp.Value')
;

-- Sep 2, 2026, 9:00:03 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsIdentifier,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200025,'4164b6da-98a2-4611-b7bc-84fadc078661',10,200283,'Y','Y','D','Alphanumeric identifier of the entity',TO_TIMESTAMP('2026-09-02 09:00:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:03','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Name','Y','Name','Y','Y',469,20,'Like','Upper','bp.Name')
;

-- Sep 2, 2026, 9:00:04 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200025,'00030160-d0de-49d6-8ec3-6be8ca5cd4ff',12,200284,'N','D','Available Credit based on Credit Limit (not Total Open Balance) and Credit Used',TO_TIMESTAMP('2026-09-02 09:00:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:04','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Credit Available','Y','SO_CreditAvailable','Y','Y',1851,30,'=','bp.SO_CreditLimit-bp.SO_CreditUsed AS SO_CreditAvailable')
;

-- Sep 2, 2026, 9:00:05 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200025,'9b82defb-78b7-48ff-968d-41bc8635657e',12,200285,'N','D','Current open balance',TO_TIMESTAMP('2026-09-02 09:00:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:05','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Credit Used','Y','SO_CreditUsed','Y','Y',554,40,'bp.SO_CreditUsed')
;

-- Sep 2, 2026, 9:00:06 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200025,'e6d16a47-fdf5-4d8d-8e0d-4d7a70a69a3b',12,200286,'N','D','Total Open Balance Amount in primary Accounting Currency',TO_TIMESTAMP('2026-09-02 09:00:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:06','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Open Balance','Y','TotalOpenBalance','Y','Y',2562,50,'bp.TotalOpenBalance')
;

-- Sep 2, 2026, 9:00:07 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause) VALUES (200025,'1cd1efda-65ec-4d06-85c3-8d361a583f1f',12,200287,'N','D',TO_TIMESTAMP('2026-09-02 09:00:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:07','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Revenue','Y','Revenue','Y','Y',60,'=','bp.ActualLifetimeValue')
;

-- Sep 2, 2026, 9:00:08 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_Reference_Value_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,DefaultValue,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SeqNoSelection,QueryOperator,SelectClause) VALUES (200025,'52111245-d661-4f50-871e-d593cf403a11',17,319,200288,'Y','D','Indicates if this Business Partner is a Customer',TO_TIMESTAMP('2026-09-02 09:00:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:08','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Customer','Y','@IsSOTrx:Y@=Y | @+IgnoreIsSOTrxInBPInfo:N@=Y','@SQL=SELECT CASE WHEN ''@IsSOTrx:X@''=''X'' OR ''@+IgnoreIsSOTrxInBPInfo:N@''=''Y'' THEN '''' WHEN ''@IsSOTrx:X@''=''Y'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL','IsCustomer','N','Y',364,160,10,'=','bp.IsCustomer')
;

-- Sep 2, 2026, 9:00:09 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_Reference_Value_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,DefaultValue,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SeqNoSelection,QueryOperator,SelectClause) VALUES (200025,'554b569a-c7db-4fa1-9ff5-6863868ff117',17,319,200289,'Y','D','Indicates if this Business Partner is a Vendor',TO_TIMESTAMP('2026-09-02 09:00:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:09','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Vendor','Y','@IsSOTrx:N@=N | @+IgnoreIsSOTrxInBPInfo:N@=Y','@SQL=SELECT CASE WHEN ''@IsSOTrx:X@''=''X'' OR ''@+IgnoreIsSOTrxInBPInfo:N@''=''Y'' THEN '''' WHEN ''@IsSOTrx:X@''=''N'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL','IsVendor','N','Y',426,170,20,'=','bp.IsVendor')
;

-- Sep 2, 2026, 9:00:10 AM
-- IDEMPIERE-7074 search criteria for contact and location (not displayed, they are joined only for filtering)
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200025,'ed45d818-eadd-4744-8ebf-16971ca7a5e9',10,200290,'N','D','Identifies a City',TO_TIMESTAMP('2026-09-02 09:00:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:10','YYYY-MM-DD HH24:MI:SS'),0,0,100,'City','Y','City','N','Y',225,90,'Like','Upper','a.City')
;

-- Sep 2, 2026, 9:00:11 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200025,'2176c78b-cb51-4387-b2af-2f0297ba539a',10,200291,'Y','D','Postal code',TO_TIMESTAMP('2026-09-02 09:00:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:11','YYYY-MM-DD HH24:MI:SS'),0,0,100,'ZIP','Y','Postal','N','Y',512,90,'Like','Upper','a.Postal')
;

-- Sep 2, 2026, 9:00:12 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200025,'f0dec6e7-bfb4-4fe2-8529-628a770cfb84',10,200292,'Y','D','Business Partner Contact Name',TO_TIMESTAMP('2026-09-02 09:00:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:12','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Contact Name','Y','ContactName','N','Y',1839,30,'Like','Upper','c.Name')
;

-- Sep 2, 2026, 9:00:13 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200025,'670d38ba-67dc-477d-ad30-4ad4d7df3733',10,200293,'Y','D','Electronic Mail Address',TO_TIMESTAMP('2026-09-02 09:00:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:13','YYYY-MM-DD HH24:MI:SS'),0,0,100,'EMail Address','Y','EMail','N','Y',881,50,'Like','Upper','c.EMail')
;

-- Sep 2, 2026, 9:00:14 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200025,'14ce6808-520f-400c-abd6-2453d80a08a6',10,200294,'Y','D','Identifies a telephone number',TO_TIMESTAMP('2026-09-02 09:00:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-02 09:00:14','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Phone','Y','Phone','N','Y',505,80,'Like','c.Phone')
;

-- Sep 2, 2026, 9:00:15 AM
-- IDEMPIERE-7074
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2026-09-02 09:00:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200025
;

-- Sep 2, 2026, 9:00:16 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('d887f25d-3eaf-41dc-9031-d36e016de388',TO_TIMESTAMP('2026-09-02 09:00:16','YYYY-MM-DD HH24:MI:SS'),100,50004,200025,11,0,TO_TIMESTAMP('2026-09-02 09:00:16','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 2, 2026, 9:00:17 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('939add50-c52a-4682-829d-de5347d19ac2',TO_TIMESTAMP('2026-09-02 09:00:17','YYYY-MM-DD HH24:MI:SS'),100,0,200025,0,0,TO_TIMESTAMP('2026-09-02 09:00:17','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 2, 2026, 9:00:18 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('66721aa2-4ef1-4a9c-9296-2f4215ed0a6a',TO_TIMESTAMP('2026-09-02 09:00:18','YYYY-MM-DD HH24:MI:SS'),100,102,200025,11,0,TO_TIMESTAMP('2026-09-02 09:00:18','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 2, 2026, 9:00:19 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('0aa8d240-610f-4438-b9b2-29d4c76ee966',TO_TIMESTAMP('2026-09-02 09:00:19','YYYY-MM-DD HH24:MI:SS'),100,103,200025,11,0,TO_TIMESTAMP('2026-09-02 09:00:19','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 2, 2026, 9:00:20 AM
-- IDEMPIERE-7074
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('8d628abc-f5d0-4906-aacd-a5e5e704cdf3',TO_TIMESTAMP('2026-09-02 09:00:20','YYYY-MM-DD HH24:MI:SS'),100,200001,200025,11,0,TO_TIMESTAMP('2026-09-02 09:00:20','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;
