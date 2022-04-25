SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4272 : Add GW_Sample_WebServices in default seed
-- 2020-05-09 02:02:50
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:02:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',200003,'GetListSalesRegions',TO_DATE('2020-05-09 14:02:49','YYYY-MM-DD HH24:MI:SS'),100,'GetListSalesRegions',50001,50023,230,'fea77209-0302-40e1-ad00-bb9c5367294f')
;

-- 2020-05-09 02:02:50
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200003,200020,TO_DATE('2020-05-09 14:02:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:50','YYYY-MM-DD HH24:MI:SS'),100,'AD_Reference_ID','C','144','29710eda-c179-4f77-ac33-c1787dcd58f8')
;

-- 2020-05-09 02:02:50
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,2023,0,TO_DATE('2020-05-09 14:02:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:50','YYYY-MM-DD HH24:MI:SS'),100,200021,200003,'aa535760-dc53-4a36-946d-b1021444b278')
;

-- 2020-05-09 02:02:51
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,1831,0,TO_DATE('2020-05-09 14:02:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:50','YYYY-MM-DD HH24:MI:SS'),100,200022,200003,'6591d6bd-139b-48d7-8680-225b448f1ff2')
;

-- 2020-05-09 02:02:51
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200003,TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'226a1374-1325-424b-a1c8-206b2e64f7e5')
;

-- 2020-05-09 02:02:51
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',200004,'DeleteBPartner',TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'DeleteBPartner',50001,50026,291,'eaee975a-cdce-4028-ae81-f492dbf40fe8')
;

-- 2020-05-09 02:02:51
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200004,200021,TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','8135bd37-a9bf-4488-a9b7-f1ce8f2d7be1')
;

-- 2020-05-09 02:02:52
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200004,200022,TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:51','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_BPartner','4c003876-654f-40ee-b5d5-9f85a0e59141')
;

-- 2020-05-09 02:02:52
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200004,200023,TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','Delete','6f1193d0-5715-45db-b448-7e384b0ec8c9')
;

-- 2020-05-09 02:02:52
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200004,TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'a62bf8df-e3c2-43cd-9559-cf8374a12920')
;

-- 2020-05-09 02:02:52
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',200005,'QueryBPartner',TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'QueryBPartner',50001,50028,291,'d661d17c-8931-4b55-baf5-5fd92eb9325c')
;

-- 2020-05-09 02:02:53
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200005,200024,TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:52','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_BPartner','9a4f309e-def5-46ac-8dbd-7609df6ecfd6')
;

-- 2020-05-09 02:02:53
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200005,200025,TO_DATE('2020-05-09 14:02:53','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:53','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','dc07fe13-821f-4cb6-8cf3-10a88f29943a')
;

-- 2020-05-09 02:02:53
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200005,200026,TO_DATE('2020-05-09 14:02:53','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:53','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','Read','b51ca32b-3e9a-45b8-8c61-ab189d14a4fd')
;

-- 2020-05-09 02:02:54
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200005,200027,TO_DATE('2020-05-09 14:02:53','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:53','YYYY-MM-DD HH24:MI:SS'),100,'Filter','C','name>''S''','c579fa54-02a3-436f-b7fe-44fb5e0d7782')
;

-- 2020-05-09 02:02:54
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200005,200002,TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,4940,19,'N','N','418a7a37-9802-4fb0-aec4-620040e4b197')
;

-- 2020-05-09 02:02:54
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,2901,0,TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,200023,200005,'2c46a214-6199-419e-bd77-35dd3ecddd65')
;

-- 2020-05-09 02:02:54
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,2902,0,TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,200024,200005,'df758306-5e1c-4385-9d44-0b8e806a7304')
;

-- 2020-05-09 02:02:55
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,2909,0,TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:54','YYYY-MM-DD HH24:MI:SS'),100,200025,200005,'530ef24b-0482-418c-a741-f85caa673632')
;

-- 2020-05-09 02:02:55
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200005,TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'d0665ac9-7ae8-4d27-a52e-06dd6d8da91e')
;

-- 2020-05-09 02:02:55
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',200006,'ReadBPartner',TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'ReadBPartner',50001,50027,291,'cced97cb-3990-4511-b38e-be804e564608')
;

-- 2020-05-09 02:02:55
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200006,200028,TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_BPartner','4a62c7ac-81dd-4cf7-bb0f-34d236c47865')
;

-- 2020-05-09 02:02:56
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200006,200029,TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:55','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','0f4bb083-1ffc-4212-8f83-c1f96f9a109b')
;

-- 2020-05-09 02:02:56
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200006,200030,TO_DATE('2020-05-09 14:02:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:56','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','Read','d880373b-4ac8-4165-aad5-d210e299cd03')
;

-- 2020-05-09 02:02:56
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,2901,0,TO_DATE('2020-05-09 14:02:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:56','YYYY-MM-DD HH24:MI:SS'),100,200026,200006,'36622958-90a5-4f08-8899-21cddef90c9c')
;

-- 2020-05-09 02:02:57
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,2902,0,TO_DATE('2020-05-09 14:02:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:56','YYYY-MM-DD HH24:MI:SS'),100,200027,200006,'e5d984a0-d648-4508-8a20-c923bc2fea1e')
;

-- 2020-05-09 02:02:57
INSERT INTO WS_WebServiceFieldOutput (AD_Client_ID,AD_Column_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,WS_WebServiceFieldOutput_ID,WS_WebServiceType_ID,WS_WebServiceFieldOutput_UU) VALUES (11,2909,0,TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,200028,200006,'e8e4fa68-7e6c-472d-b44f-f65ffdc13a8e')
;

-- 2020-05-09 02:02:57
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200006,TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,'36072ef8-4eaf-4a4c-a8f7-a37ed48aa1fe')
;

-- 2020-05-09 02:02:57
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,'Y',200007,'RunStorageDetail',TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,'RunStorageDetail',50001,50022,'872a5271-3f57-4ce4-8625-d393cedcbe19')
;

-- 2020-05-09 02:02:58
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200007,200031,TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_Menu_ID','F','49060eaa-c1de-4476-8211-5330b7748055')
;

-- 2020-05-09 02:02:58
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200007,200032,TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_ID','C','236','9f80bef5-7f03-4432-a1cc-484f178cefb2')
;

-- 2020-05-09 02:02:58
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200007,200033,TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'AD_Record_ID','F','e60dfeeb-28e5-4f4e-a1e9-95a2eb527641')
;

-- 2020-05-09 02:02:58
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200007,TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'35ccb304-f5e5-452b-afdf-784b322c5aa2')
;

-- 2020-05-09 02:02:59
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',200008,'ActionCompleteOrder',TO_DATE('2020-05-09 14:02:58','YYYY-MM-DD HH24:MI:SS'),100,'ActionCompleteOrder',50001,50021,259,'33243aa2-741f-43c7-8b3f-c1425517897c')
;

-- 2020-05-09 02:02:59
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200008,200034,TO_DATE('2020-05-09 14:02:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:59','YYYY-MM-DD HH24:MI:SS'),100,'tableName','C','C_Order','b01194a7-3e13-458d-b5e1-d57412843804')
;

-- 2020-05-09 02:02:59
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200008,200035,TO_DATE('2020-05-09 14:02:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:59','YYYY-MM-DD HH24:MI:SS'),100,'recordID','F','6add5e07-eea1-4b33-a99c-17e489b0c5f1')
;

-- 2020-05-09 02:03:00
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200008,200036,TO_DATE('2020-05-09 14:02:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:02:59','YYYY-MM-DD HH24:MI:SS'),100,'docAction','C','CO','ce211094-cc21-40d8-9863-78a449e4939b')
;

-- 2020-05-09 02:03:00
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200008,TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'536a255b-1bf8-4692-b79f-420e38b20933')
;

-- 2020-05-09 02:03:00
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',200009,'UpdateBPartner',TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'UpdateBPartner',50001,50025,291,'ce6c9e34-f84c-4200-8363-9a06dcb6eb6c')
;

-- 2020-05-09 02:03:00
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200009,200037,TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_BPartner','ab64c5e1-a9a2-481f-a7f0-f4a85d9f2c1a')
;

-- 2020-05-09 02:03:01
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200009,200038,TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:00','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','d19ba0d3-7519-4aef-948e-aefb1e78bdfe')
;

-- 2020-05-09 02:03:01
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200009,200039,TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','Update','0d0bdc39-d69d-446f-9dc3-56650da25c5a')
;

-- 2020-05-09 02:03:01
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200009,200003,TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,3081,40,'N','N','b14f6ab4-903a-496c-8a86-135087514ed4')
;

-- 2020-05-09 02:03:01
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200009,TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'225dfa14-87fe-4e10-abff-9d8f92c82c3f')
;

-- 2020-05-09 02:03:01
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200010,'SyncOrder',TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'SyncOrder',200001,200001,'9464709a-db49-4eca-bcd5-74c65998a9ac')
;

-- 2020-05-09 02:03:01
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200010,TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'f9da906e-eba3-4f3b-bfa1-4391c70d4cd8')
;

-- 2020-05-09 02:03:02
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200011,'CreateUpdateUser',TO_DATE('2020-05-09 14:03:01','YYYY-MM-DD HH24:MI:SS'),100,'CreateUpdateUser',50001,50024,114,'9d7cfd5f-8ee4-444a-8de9-43cad13afc1f')
;

-- 2020-05-09 02:03:02
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200011,200040,TO_DATE('2020-05-09 14:03:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:02','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','AD_User','7da295b8-85f1-435f-8e71-f1e9743a3079')
;

-- 2020-05-09 02:03:02
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200011,200041,TO_DATE('2020-05-09 14:03:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:02','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','3b72feb0-4489-482b-8077-88f242eb3514')
;

-- 2020-05-09 02:03:03
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200011,200042,TO_DATE('2020-05-09 14:03:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:02','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','CreateUpdate','083b2afb-4ebf-40ed-8719-747e3330163b')
;

-- 2020-05-09 02:03:03
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200011,200004,TO_DATE('2020-05-09 14:03:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:03','YYYY-MM-DD HH24:MI:SS'),100,8747,10,'N','N','53d775ff-3abb-45de-87fa-90d3dcc1302c')
;

-- 2020-05-09 02:03:03
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200011,200005,TO_DATE('2020-05-09 14:03:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:03','YYYY-MM-DD HH24:MI:SS'),100,5844,30,'Y','N','be7e0467-711a-4446-b55e-5d60204a35ec')
;

-- 2020-05-09 02:03:04
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200011,200006,TO_DATE('2020-05-09 14:03:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:03','YYYY-MM-DD HH24:MI:SS'),100,8746,30,'N','N','75cfec7c-1c8c-47c3-a7e2-e90d025df176')
;

-- 2020-05-09 02:03:04
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200011,200007,TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,213,10,'N','N','6b98410e-0d97-4df5-995f-b3137407c93a')
;

-- 2020-05-09 02:03:04
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200011,200008,TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,5396,10,'Y','N','55b65bbf-1baa-4f9b-8975-9b8c8f60fda6')
;

-- 2020-05-09 02:03:04
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200011,TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,'5fbe156f-543d-49a4-aa21-5ad2b9065116')
;

-- 2020-05-09 02:03:05
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',200012,'CreateUpdateLocation1',TO_DATE('2020-05-09 14:03:04','YYYY-MM-DD HH24:MI:SS'),100,'CreateUpdateLocation1',50001,50024,162,'662dd3ec-e052-4f18-a66e-65db28522665')
;

-- 2020-05-09 02:03:05
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200012,200043,TO_DATE('2020-05-09 14:03:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:05','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_Location','f73743eb-062b-42e4-a6f1-0ecf71e1c2c2')
;

-- 2020-05-09 02:03:05
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200012,200044,TO_DATE('2020-05-09 14:03:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:05','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','2ee6b319-a9d6-457b-9cb4-8620496f70d8')
;

-- 2020-05-09 02:03:06
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200012,200045,TO_DATE('2020-05-09 14:03:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:05','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','CreateUpdate','d9c807c2-b205-4c69-9200-ec9cf160d699')
;

-- 2020-05-09 02:03:06
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200012,200009,TO_DATE('2020-05-09 14:03:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:06','YYYY-MM-DD HH24:MI:SS'),100,818,10,'N','N','37d99260-84e1-41d7-9249-bee183af2c85')
;

-- 2020-05-09 02:03:06
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200012,200010,TO_DATE('2020-05-09 14:03:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:06','YYYY-MM-DD HH24:MI:SS'),100,8214,10,'N','N','951576d7-20e3-4f9f-aa9f-2ea938759975')
;

-- 2020-05-09 02:03:07
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200012,200011,TO_DATE('2020-05-09 14:03:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:06','YYYY-MM-DD HH24:MI:SS'),100,822,10,'N','N','3d38460d-ccdd-4fcd-9f92-391afff0b7fc')
;

-- 2020-05-09 02:03:07
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200012,200012,TO_DATE('2020-05-09 14:03:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:07','YYYY-MM-DD HH24:MI:SS'),100,820,19,'Y','N','36185126-03e7-4b52-8076-25abc14473f3')
;

-- 2020-05-09 02:03:07
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200012,200013,TO_DATE('2020-05-09 14:03:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:07','YYYY-MM-DD HH24:MI:SS'),100,817,10,'Y','N','b4180938-7e2b-4d52-bf65-d7bc8c418513')
;

-- 2020-05-09 02:03:08
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200012,200014,TO_DATE('2020-05-09 14:03:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:07','YYYY-MM-DD HH24:MI:SS'),100,821,19,'Y','N','10358ca1-5e52-4828-9b22-cbb9a36b463d')
;

-- 2020-05-09 02:03:08
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200012,200015,TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,819,10,'Y','N','f022495e-ed7c-437c-aa83-11d661a8ccf8')
;

-- 2020-05-09 02:03:08
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200012,TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,'856166de-e25d-4b38-af60-5b5a8ca16138')
;

-- 2020-05-09 02:03:08
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',200013,'CreateUpdateBPLocation',TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,'CreateUpdateBPLocation',50001,50024,293,'1a5064be-bd06-434d-bfe3-9796e09e00dc')
;

-- 2020-05-09 02:03:09
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200013,200046,TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:08','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_BPartner_Location','f3f1e4d8-477e-43ae-a846-3b43bee25555')
;

-- 2020-05-09 02:03:09
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200013,200047,TO_DATE('2020-05-09 14:03:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:09','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','ca135727-c0a9-4422-b584-bd04d0887d3d')
;

-- 2020-05-09 02:03:09
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200013,200048,TO_DATE('2020-05-09 14:03:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:09','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','CreateUpdate','cf8fdb24-4371-4297-a294-60085502be46')
;

-- 2020-05-09 02:03:10
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200013,200016,TO_DATE('2020-05-09 14:03:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:09','YYYY-MM-DD HH24:MI:SS'),100,3091,20,'N','N','dc4357c9-ce46-4065-9b3a-7196f72b5aca')
;

-- 2020-05-09 02:03:10
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200013,200017,TO_DATE('2020-05-09 14:03:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:10','YYYY-MM-DD HH24:MI:SS'),100,3090,20,'N','N','bb621d7f-0c05-4be0-8819-e1b0bfc4e1f3')
;

-- 2020-05-09 02:03:10
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200013,200018,TO_DATE('2020-05-09 14:03:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:10','YYYY-MM-DD HH24:MI:SS'),100,2958,30,'Y','N','8919631e-8f14-4224-980d-7c3187423f59')
;

-- 2020-05-09 02:03:11
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200013,200019,TO_DATE('2020-05-09 14:03:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:10','YYYY-MM-DD HH24:MI:SS'),100,2959,30,'Y','N','503746c7-214d-4da3-93b1-73f0253e4601')
;

-- 2020-05-09 02:03:11
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200013,TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'a6722fdf-c122-4d5f-af7a-4fac82c2c854')
;

-- 2020-05-09 02:03:11
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',200014,'createOrderRecord',TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'createOrderRecord',50001,50024,259,'93bdc3fe-85de-4c8e-9170-287b1cc6c4a2')
;

-- 2020-05-09 02:03:11
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200014,200049,TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_Order','e28ff5f4-a6de-4e23-a602-9ded14337567')
;

-- 2020-05-09 02:03:12
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200014,200050,TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:11','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','6c5c88a8-c794-444a-8224-340cedfb17d0')
;

-- 2020-05-09 02:03:12
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200014,200051,TO_DATE('2020-05-09 14:03:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:12','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','CreateUpdate','45572361-2e59-459e-a1f0-eb0384f41087')
;

-- 2020-05-09 02:03:12
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200014,200020,TO_DATE('2020-05-09 14:03:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:12','YYYY-MM-DD HH24:MI:SS'),100,2202,19,'N','N','beb0ca2d-fe12-4c70-8d8c-7ad201a1aa98')
;

-- 2020-05-09 02:03:13
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200014,200021,TO_DATE('2020-05-09 14:03:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:12','YYYY-MM-DD HH24:MI:SS'),100,2763,30,'N','N','842c9da0-edad-48a4-ade4-533d7d877958')
;

-- 2020-05-09 02:03:13
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200014,200022,TO_DATE('2020-05-09 14:03:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:13','YYYY-MM-DD HH24:MI:SS'),100,2762,30,'N','N','0ea2586c-eedf-400a-b365-b08276337585')
;

-- 2020-05-09 02:03:13
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200014,200023,TO_DATE('2020-05-09 14:03:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:13','YYYY-MM-DD HH24:MI:SS'),100,3400,30,'N','N','4a064986-0c1d-4571-8932-da6e442fceea')
;

-- 2020-05-09 02:03:14
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU,AD_Reference_Value_ID) VALUES (11,0,200014,200024,TO_DATE('2020-05-09 14:03:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:13','YYYY-MM-DD HH24:MI:SS'),100,8764,30,'N','N','ec9ce7de-76f9-4cea-8cb7-9c36ab5853bb',138)
;

-- 2020-05-09 02:03:14
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU,AD_Reference_Value_ID) VALUES (11,0,200014,200025,TO_DATE('2020-05-09 14:03:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:14','YYYY-MM-DD HH24:MI:SS'),100,8766,30,'N','N','7e14a339-5440-43c0-8c06-ca56c351c7b7',159)
;

-- 2020-05-09 02:03:14
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200014,200026,TO_DATE('2020-05-09 14:03:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:14','YYYY-MM-DD HH24:MI:SS'),100,2195,12,'N','N','d550f808-961c-48fd-a21f-1259e73693ac')
;

-- 2020-05-09 02:03:15
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200014,200027,TO_DATE('2020-05-09 14:03:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:14','YYYY-MM-DD HH24:MI:SS'),100,2169,10,'Y','N','6a347178-12d5-44ed-abf8-a62eeb02f7f3')
;

-- 2020-05-09 02:03:15
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU,AD_Reference_Value_ID) VALUES (11,0,200014,200028,TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,2173,18,'Y','N','8347d3e0-5c6f-41df-a4a3-1ec15c8a8c58',172)
;

-- 2020-05-09 02:03:15
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200014,200029,TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,3722,'N','N','65a01855-9ad1-4343-b925-93305c72e8a0')
;

-- 2020-05-09 02:03:15
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200014,TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,'8627fd68-8e7f-44d1-94eb-d2c54001fff1')
;

-- 2020-05-09 02:03:16
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',200015,'CreateOrderLine',TO_DATE('2020-05-09 14:03:15','YYYY-MM-DD HH24:MI:SS'),100,'CreateOrderLine',50001,50024,260,'031db2c6-8801-4b08-8696-7385048cae03')
;

-- 2020-05-09 02:03:16
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200015,200052,TO_DATE('2020-05-09 14:03:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:16','YYYY-MM-DD HH24:MI:SS'),100,'TableName','C','C_OrderLine','30f64fbd-5bf2-4789-a7db-f3af0e0f0525')
;

-- 2020-05-09 02:03:16
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200015,200053,TO_DATE('2020-05-09 14:03:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:16','YYYY-MM-DD HH24:MI:SS'),100,'RecordID','F','3369d9eb-d724-4e89-b04b-8fc020500299')
;

-- 2020-05-09 02:03:17
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200015,200054,TO_DATE('2020-05-09 14:03:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:16','YYYY-MM-DD HH24:MI:SS'),100,'Action','C','CreateUpdate','9c766fc1-1e87-4549-bbc1-0d3d4a35bba6')
;

-- 2020-05-09 02:03:17
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200030,TO_DATE('2020-05-09 14:03:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:17','YYYY-MM-DD HH24:MI:SS'),100,2207,19,'N','N','3fe0fa30-1c3d-4fc5-8e21-da8338d26ec8')
;

-- 2020-05-09 02:03:17
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200031,TO_DATE('2020-05-09 14:03:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:17','YYYY-MM-DD HH24:MI:SS'),100,2206,19,'N','N','3e86191f-d0fd-4e86-8a00-709c3cfdaea7')
;

-- 2020-05-09 02:03:18
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200032,TO_DATE('2020-05-09 14:03:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:17','YYYY-MM-DD HH24:MI:SS'),100,2221,30,'N','N','a955b742-6f7c-43b4-8300-66a927d95251')
;

-- 2020-05-09 02:03:18
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200033,TO_DATE('2020-05-09 14:03:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:18','YYYY-MM-DD HH24:MI:SS'),100,12876,29,'N','N','c9ff9967-d907-4a58-b02f-fc0a70c44de2')
;

-- 2020-05-09 02:03:18
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200034,TO_DATE('2020-05-09 14:03:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:18','YYYY-MM-DD HH24:MI:SS'),100,2224,29,'N','N','1124a810-d67f-424f-b757-756fe05a9f87')
;

-- 2020-05-09 02:03:19
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200035,TO_DATE('2020-05-09 14:03:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:18','YYYY-MM-DD HH24:MI:SS'),100,12875,37,'N','N','b98baa51-b069-4add-b7fc-140b234a3f16')
;

-- 2020-05-09 02:03:19
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200036,TO_DATE('2020-05-09 14:03:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:19','YYYY-MM-DD HH24:MI:SS'),100,2232,37,'N','N','536f8344-5a23-4db5-b9e3-b4e88a84e221')
;

-- 2020-05-09 02:03:19
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200037,TO_DATE('2020-05-09 14:03:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:19','YYYY-MM-DD HH24:MI:SS'),100,2213,30,'Y','N','c556f0d7-07a3-4bbb-b99b-8a8106df7ee2')
;

-- 2020-05-09 02:03:20
INSERT INTO WS_WebServiceFieldInput (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebServiceFieldInput_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_Reference_ID,IsIdentifier,IsNullIdentifier,WS_WebServiceFieldInput_UU) VALUES (11,0,200015,200038,TO_DATE('2020-05-09 14:03:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:19','YYYY-MM-DD HH24:MI:SS'),100,2214,11,'Y','N','fbb1fd90-f0fd-4b84-a39b-89c3f7fad768')
;

-- 2020-05-09 02:03:20
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200015,TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'a35a0410-e8a2-4019-82fb-05bed2059238')
;

-- 2020-05-09 02:03:20
INSERT INTO WS_WebServiceType (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,WS_WebServiceType_ID,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID,AD_Table_ID,WS_WebServiceType_UU) VALUES (11,0,TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',200016,'CompleteOrder',TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'CompleteOrder',50001,50021,259,'0dbbd62d-dd0a-40ad-9877-603e02883da2')
;

-- 2020-05-09 02:03:20
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200016,200055,TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'tableName','C','C_Order','da582114-ec57-4dd9-829b-2e33613fbf58')
;

-- 2020-05-09 02:03:21
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200016,200056,TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:20','YYYY-MM-DD HH24:MI:SS'),100,'recordID','F','99c825a7-4c51-48ad-8ee5-ba0b916309ec')
;

-- 2020-05-09 02:03:21
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,WS_WebService_Para_UU) VALUES (11,0,200016,200057,TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'),100,'recordIDVariable','F','16cfc3d6-c3d5-4595-9135-920fe6a13b54')
;

-- 2020-05-09 02:03:21
INSERT INTO WS_WebService_Para (AD_Client_ID,AD_Org_ID,WS_WebServiceType_ID,WS_WebService_Para_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,ParameterName,ParameterType,ConstantValue,WS_WebService_Para_UU) VALUES (11,0,200016,200058,TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'),100,'docAction','C','CO','150d8389-b701-4602-815e-5d7ee98a50e8')
;

-- 2020-05-09 02:03:21
INSERT INTO WS_WebServiceTypeAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,WS_WebServiceType_ID,Created,CreatedBy,IsActive,IsReadWrite,Updated,UpdatedBy,WS_WebServiceTypeAccess_UU) VALUES (11,0,50004,200016,TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'),100,'493a930d-5777-4c8e-987c-9e85a2f7bc97')
;

-- Add Storage Detail process for the role Web Service Execution
INSERT INTO AD_Process_Access (AD_Process_ID, AD_Role_ID, AD_Client_ID, AD_Org_ID, Created, CreatedBy, IsActive, Updated, UpdatedBy, IsReadWrite, AD_Process_Access_UU) VALUES (236, 50004, 11, 0, TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'), 100, 'Y', TO_DATE('2020-05-09 14:03:21','YYYY-MM-DD HH24:MI:SS'), 100, 'Y', 'a7c6bbb6-e276-4e6e-bdf3-855e9c25da43')
;

SELECT register_migration_script('202005091400_IDEMPIERE-4272.sql') FROM dual
;