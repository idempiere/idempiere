-- Jul 18, 2013 11:52:55 PM COT
-- Generate pending sequences
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200093,'Table C_BankAccount_Processor','C_BankAccount_Processor',1,'82e01e94-d7bd-4b8c-94ac-8393ca12b33e',0,TO_TIMESTAMP('2013-07-18 23:52:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:52:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:52:56 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200094,'Table AD_InfoWindow_Access','AD_InfoWindow_Access',1,'78a5b615-6569-4275-81e3-43785535fd25',0,TO_TIMESTAMP('2013-07-18 23:52:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:52:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:52:56 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200095,'Table AD_TableIndex','AD_TableIndex',1,'a9d07975-37d7-46f3-b8f8-946dd05e82b6',0,TO_TIMESTAMP('2013-07-18 23:52:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:52:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:52:56 PM COT
UPDATE AD_Sequence SET Name = (SELECT TableName FROM AD_Table t WHERE t.IsView='N' AND UPPER(AD_Sequence.Name)=UPPER(t.TableName)) WHERE AD_Sequence.IsTableID='Y' AND EXISTS (SELECT * FROM AD_Table t WHERE t.IsActive='Y' AND t.IsView='N' AND UPPER(AD_Sequence.Name)=UPPER(t.TableName) AND AD_Sequence.Name<>t.TableName)
;

-- Jul 18, 2013 11:53:00 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200096,'DocumentNo/Value for Table I_Movement','DocumentNo_I_Movement',1,'de828ae2-3342-401d-818e-e36cfb333dde',0,TO_TIMESTAMP('2013-07-18 23:52:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:52:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:00 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200097,'DocumentNo/Value for Table C_CashPlan','DocumentNo_C_CashPlan',1,'847046e7-51fe-42a5-a011-1f8faa1c59a4',0,TO_TIMESTAMP('2013-07-18 23:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:01 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200098,'DocumentNo/Value for Table C_POSTenderType','DocumentNo_C_POSTenderType',1,'54478099-8739-4311-8260-abddf7e35569',0,TO_TIMESTAMP('2013-07-18 23:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:01 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200099,'DocumentNo/Value for Table A_FundingMode','DocumentNo_A_FundingMode',1,'71f1d37f-359b-4c08-a690-85b2f5fece48',0,TO_TIMESTAMP('2013-07-18 23:53:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:02 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200100,'DocumentNo/Value for Table T_1099Extract','DocumentNo_T_1099Extract',1,'cdc49a33-8359-4aff-86ab-67c04215bd96',0,TO_TIMESTAMP('2013-07-18 23:53:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:02 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200101,'DocumentNo/Value for Table T_BankRegister','DocumentNo_T_BankRegister',1,'424c6483-8647-461e-be75-be64ac96e2dc',0,TO_TIMESTAMP('2013-07-18 23:53:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:02 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200102,'DocumentNo/Value for Table C_BankAccount','DocumentNo_C_BankAccount',1,'96144ade-fbf5-4563-b830-00d5b7b370b2',0,TO_TIMESTAMP('2013-07-18 23:53:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:03 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200103,'DocumentNo/Value for Table M_ShipperPackagingCfg','DocumentNo_M_ShipperPackagingCfg',1,'a9435227-64d1-4e60-a278-e3e51b304145',0,TO_TIMESTAMP('2013-07-18 23:53:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:03 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200104,'DocumentNo/Value for Table M_Product_BOM','DocumentNo_M_Product_BOM',1,'8995cbd2-4d94-4729-b933-a8f66ea0de11',0,TO_TIMESTAMP('2013-07-18 23:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:04 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200105,'DocumentNo/Value for Table A_Asset_Transfer','DocumentNo_A_Asset_Transfer',1,'53bef476-c836-41be-b6e9-92ec2f5e0368',0,TO_TIMESTAMP('2013-07-18 23:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:04 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200106,'DocumentNo/Value for Table A_Asset_Type','DocumentNo_A_Asset_Type',1,'48cb5531-03e7-4d3e-acdb-2aceedb4ecde',0,TO_TIMESTAMP('2013-07-18 23:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:05 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200107,'DocumentNo/Value for Table A_Asset_Class','DocumentNo_A_Asset_Class',1,'72547e8f-5a90-450f-820d-2c81d4970a43',0,TO_TIMESTAMP('2013-07-18 23:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:05 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200108,'DocumentNo/Value for Table A_Asset_Reval','DocumentNo_A_Asset_Reval',1,'f6b271f3-f32b-43e6-9f7d-6814dc6484d9',0,TO_TIMESTAMP('2013-07-18 23:53:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:06 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200109,'DocumentNo/Value for Table C_DepositBatch','DocumentNo_C_DepositBatch',1,'f1db4b67-d826-43c5-9e39-da5999237333',0,TO_TIMESTAMP('2013-07-18 23:53:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:06 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200110,'DocumentNo/Value for Table M_ShipperPickupTypesCfg','DocumentNo_M_ShipperPickupTypesCfg',1,'de9969d1-5903-4e0d-ba3e-5ef6e2a26807',0,TO_TIMESTAMP('2013-07-18 23:53:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:06 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200111,'DocumentNo/Value for Table M_ShipperLabelsCfg','DocumentNo_M_ShipperLabelsCfg',1,'4f963529-034f-44ce-8707-582dc1996ce4',0,TO_TIMESTAMP('2013-07-18 23:53:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:07 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200112,'DocumentNo/Value for Table C_1099Box','DocumentNo_C_1099Box',1,'272372fc-042d-4f58-834e-62355dd23923',0,TO_TIMESTAMP('2013-07-18 23:53:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:07 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200113,'DocumentNo/Value for Table A_Asset_Disposed','DocumentNo_A_Asset_Disposed',1,'e39d90c8-e59f-4259-99fd-f3b816abb595',0,TO_TIMESTAMP('2013-07-18 23:53:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:08 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200114,'DocumentNo/Value for Table M_Production','DocumentNo_M_Production',1,'c4829f50-fbeb-4364-ac1e-4eb4364e10cf',0,TO_TIMESTAMP('2013-07-18 23:53:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,11)
;

-- Jul 18, 2013 11:53:08 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200115,'DocumentNo/Value for Table I_Movement','DocumentNo_I_Movement',1,'88318581-2516-4f75-b82d-95c9bbdb78f3',0,TO_TIMESTAMP('2013-07-18 23:53:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:09 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200116,'DocumentNo/Value for Table C_CashPlan','DocumentNo_C_CashPlan',1,'38a73ca8-b9ba-4dc9-8abe-a3691b211478',0,TO_TIMESTAMP('2013-07-18 23:53:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:09 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200117,'DocumentNo/Value for Table C_POSTenderType','DocumentNo_C_POSTenderType',1,'03dd99d9-90d7-407e-918e-565f7e3f371b',0,TO_TIMESTAMP('2013-07-18 23:53:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:10 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200118,'DocumentNo/Value for Table A_FundingMode','DocumentNo_A_FundingMode',1,'ba3767a9-d4f6-47eb-bfc3-4b221b81201d',0,TO_TIMESTAMP('2013-07-18 23:53:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:10 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200119,'DocumentNo/Value for Table T_1099Extract','DocumentNo_T_1099Extract',1,'bcb31d40-a3f1-402b-942a-99b3fd0b3527',0,TO_TIMESTAMP('2013-07-18 23:53:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:11 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200120,'DocumentNo/Value for Table T_BankRegister','DocumentNo_T_BankRegister',1,'7c3d543b-9a8d-4de2-aa90-22126af09293',0,TO_TIMESTAMP('2013-07-18 23:53:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:11 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200121,'DocumentNo/Value for Table C_BankAccount','DocumentNo_C_BankAccount',1,'18d6ef65-15c1-4968-a607-ba437cebc353',0,TO_TIMESTAMP('2013-07-18 23:53:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:12 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200122,'DocumentNo/Value for Table M_ShipperPackagingCfg','DocumentNo_M_ShipperPackagingCfg',1,'140b230c-19a8-4c2f-b915-06f31b3a4d55',0,TO_TIMESTAMP('2013-07-18 23:53:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:12 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200123,'DocumentNo/Value for Table M_Product_BOM','DocumentNo_M_Product_BOM',1,'80e5942b-662b-4b08-a90b-1e2fd2f6ae92',0,TO_TIMESTAMP('2013-07-18 23:53:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:13 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200124,'DocumentNo/Value for Table A_Asset_Transfer','DocumentNo_A_Asset_Transfer',1,'8a607f0e-f50a-4ffc-b0c3-f0028c957e40',0,TO_TIMESTAMP('2013-07-18 23:53:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:13 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200125,'DocumentNo/Value for Table A_Asset_Type','DocumentNo_A_Asset_Type',1,'87c6dbde-1573-4dec-a4a0-fe3da6aa1a9f',0,TO_TIMESTAMP('2013-07-18 23:53:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:13 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200126,'DocumentNo/Value for Table A_Asset_Class','DocumentNo_A_Asset_Class',1,'f14ea26c-2617-4a28-adb8-52a1c56cc592',0,TO_TIMESTAMP('2013-07-18 23:53:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:14 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200127,'DocumentNo/Value for Table A_Asset_Reval','DocumentNo_A_Asset_Reval',1,'c358541f-82c0-464b-97d1-9d1ca02bf933',0,TO_TIMESTAMP('2013-07-18 23:53:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:15 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200128,'DocumentNo/Value for Table C_DepositBatch','DocumentNo_C_DepositBatch',1,'3e766e08-0a10-4e10-9871-2858d45557cd',0,TO_TIMESTAMP('2013-07-18 23:53:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:15 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200129,'DocumentNo/Value for Table M_ShipperPickupTypesCfg','DocumentNo_M_ShipperPickupTypesCfg',1,'c10b06e7-7b76-45a0-81a0-32284da3f46a',0,TO_TIMESTAMP('2013-07-18 23:53:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:16 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200130,'DocumentNo/Value for Table M_ShipperLabelsCfg','DocumentNo_M_ShipperLabelsCfg',1,'55a4949d-c68f-4058-8cf6-9877a379d95c',0,TO_TIMESTAMP('2013-07-18 23:53:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:16 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200131,'DocumentNo/Value for Table C_1099Box','DocumentNo_C_1099Box',1,'97487b2d-22ed-4fc3-9052-35646c86c236',0,TO_TIMESTAMP('2013-07-18 23:53:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:17 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200132,'DocumentNo/Value for Table A_Asset_Disposed','DocumentNo_A_Asset_Disposed',1,'77d76aa3-b0b0-478a-b78e-dd2de6a6a32f',0,TO_TIMESTAMP('2013-07-18 23:53:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jul 18, 2013 11:53:17 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'N',1000000,'N','Y',200133,'DocumentNo/Value for Table M_Production','DocumentNo_M_Production',1,'20b00ea5-f830-4af6-94db-2496bf351a95',0,TO_TIMESTAMP('2013-07-18 23:53:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 23:53:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

SELECT register_migration_script('201307182355_PendingSequences.sql') FROM dual
;

