SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3358 Dictionary fixes - ASP Indexes
-- Apr 29, 2017 7:12:32 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201043,'91594b00-79b0-4324-a4d0-b4cd28e20a7b',TO_DATE('2017-04-29 19:12:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_clientexception_uniq',TO_DATE('2017-04-29 19:12:31','YYYY-MM-DD HH24:MI:SS'),100,53057,'N','Y','N','N','N')
;

-- Apr 29, 2017 7:14:20 PM CEST
UPDATE AD_TableIndex SET Name='asp_clientexception_unq',Updated=TO_DATE('2017-04-29 19:14:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201043
;

-- Apr 29, 2017 7:14:41 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201280,'462971d8-931b-48e8-b808-4bd470506598',TO_DATE('2017-04-29 19:14:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:14:41','YYYY-MM-DD HH24:MI:SS'),100,54234,201043,0)
;

-- Apr 29, 2017 7:15:54 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201281,'89628cfe-84f2-44df-bda1-ff6c03f2d722',TO_DATE('2017-04-29 19:15:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:15:53','YYYY-MM-DD HH24:MI:SS'),100,54235,201043,0)
;

-- Apr 29, 2017 7:15:58 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201282,'3d0b0227-f399-48ce-93b0-3798ec5db70f',TO_DATE('2017-04-29 19:15:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:15:57','YYYY-MM-DD HH24:MI:SS'),100,54219,201043,0)
;

-- Apr 29, 2017 7:16:07 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201283,'a4ba9a7a-bf73-4802-985c-1d87fa30c19b',TO_DATE('2017-04-29 19:16:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:16:07','YYYY-MM-DD HH24:MI:SS'),100,54223,201043,0)
;

-- Apr 29, 2017 7:16:12 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201284,'9d2d912e-27e7-45dd-abcf-1d828ec99691',TO_DATE('2017-04-29 19:16:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:16:12','YYYY-MM-DD HH24:MI:SS'),100,54231,201043,0)
;

-- Apr 29, 2017 7:16:16 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201285,'dcef9c04-dbd2-4066-bd5a-4d3a35f9b2b9',TO_DATE('2017-04-29 19:16:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:16:16','YYYY-MM-DD HH24:MI:SS'),100,54230,201043,0)
;

-- Apr 29, 2017 7:16:20 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201286,'77dca6d4-3dbd-475a-bf72-0fcfc22cc6e1',TO_DATE('2017-04-29 19:16:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:16:20','YYYY-MM-DD HH24:MI:SS'),100,54221,201043,0)
;

-- Apr 29, 2017 7:16:26 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201288,'683ae08d-833e-4002-bcd7-d102a625e9a0',TO_DATE('2017-04-29 19:16:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:16:25','YYYY-MM-DD HH24:MI:SS'),100,54220,201043,0)
;

-- Apr 29, 2017 7:16:31 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201289,'042a2334-92da-47b1-8ebc-4b66253ac2be',TO_DATE('2017-04-29 19:16:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:16:31','YYYY-MM-DD HH24:MI:SS'),100,54229,201043,0)
;

-- Apr 29, 2017 7:16:40 PM CEST
UPDATE AD_IndexColumn SET SeqNo=1,Updated=TO_DATE('2017-04-29 19:16:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201280
;

-- Apr 29, 2017 7:16:43 PM CEST
UPDATE AD_IndexColumn SET SeqNo=2,Updated=TO_DATE('2017-04-29 19:16:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201281
;

-- Apr 29, 2017 7:16:46 PM CEST
UPDATE AD_IndexColumn SET SeqNo=3,Updated=TO_DATE('2017-04-29 19:16:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201282
;

-- Apr 29, 2017 7:16:49 PM CEST
UPDATE AD_IndexColumn SET SeqNo=4,Updated=TO_DATE('2017-04-29 19:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201283
;

-- Apr 29, 2017 7:16:53 PM CEST
UPDATE AD_IndexColumn SET SeqNo=5,Updated=TO_DATE('2017-04-29 19:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201284
;

-- Apr 29, 2017 7:16:56 PM CEST
UPDATE AD_IndexColumn SET SeqNo=6,Updated=TO_DATE('2017-04-29 19:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201285
;

-- Apr 29, 2017 7:16:58 PM CEST
UPDATE AD_IndexColumn SET SeqNo=7,Updated=TO_DATE('2017-04-29 19:16:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201286
;

-- Apr 29, 2017 7:17:04 PM CEST
UPDATE AD_IndexColumn SET SeqNo=9,Updated=TO_DATE('2017-04-29 19:17:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201288
;

-- Apr 29, 2017 7:17:07 PM CEST
UPDATE AD_IndexColumn SET SeqNo=10,Updated=TO_DATE('2017-04-29 19:17:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201289
;

-- Apr 29, 2017 7:18:49 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201290,'05eebc2e-9637-45fa-8bf9-6881c1c0ec22',TO_DATE('2017-04-29 19:18:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:18:48','YYYY-MM-DD HH24:MI:SS'),100,54218,201043,8)
;

-- Apr 29, 2017 7:22:38 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Field_ID,0)',Updated=TO_DATE('2017-04-29 19:22:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201281
;

-- Apr 29, 2017 7:22:45 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Form_ID,0)',Updated=TO_DATE('2017-04-29 19:22:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201282
;

-- Apr 29, 2017 7:22:59 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Process_ID,0)',Updated=TO_DATE('2017-04-29 19:22:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201283
;

-- Apr 29, 2017 7:23:09 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Process_Para_ID,0)',Updated=TO_DATE('2017-04-29 19:23:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201284
;

-- Apr 29, 2017 7:23:18 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Tab_ID,0)',Updated=TO_DATE('2017-04-29 19:23:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201285
;

-- Apr 29, 2017 7:23:29 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Task_ID,0)',Updated=TO_DATE('2017-04-29 19:23:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201286
;

-- Apr 29, 2017 7:23:42 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_WF_Node_ID,0)',Updated=TO_DATE('2017-04-29 19:23:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201288
;

-- Apr 29, 2017 7:23:50 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Window_ID,0)',Updated=TO_DATE('2017-04-29 19:23:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201289
;

-- Apr 29, 2017 7:24:00 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Workflow_ID,0)',Updated=TO_DATE('2017-04-29 19:24:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201290
;

-- Apr 29, 2017 7:24:12 PM CEST
CREATE UNIQUE INDEX asp_clientexception_unq ON ASP_ClientException (AD_Client_ID,COALESCE(AD_Field_ID,0),COALESCE(AD_Form_ID,0),COALESCE(AD_Process_ID,0),COALESCE(AD_Process_Para_ID,0),COALESCE(AD_Tab_ID,0),COALESCE(AD_Task_ID,0),COALESCE(AD_Workflow_ID,0),COALESCE(AD_WF_Node_ID,0),COALESCE(AD_Window_ID,0))
;

-- Apr 29, 2017 7:31:04 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201044,'7ac40a9e-1f60-4826-b12c-bc8b4054e260',TO_DATE('2017-04-29 19:31:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_clientlevel_unq',TO_DATE('2017-04-29 19:31:04','YYYY-MM-DD HH24:MI:SS'),100,53056,'N','Y','N','N','N')
;

-- Apr 29, 2017 7:31:15 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201291,'347a497f-c5cf-4108-94c5-6c3b3aa0b3c5',TO_DATE('2017-04-29 19:31:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:31:15','YYYY-MM-DD HH24:MI:SS'),100,54207,201044,1)
;

-- Apr 29, 2017 7:31:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201292,'affe96bc-93a1-4e97-9579-36dccaf6fa59',TO_DATE('2017-04-29 19:31:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:31:21','YYYY-MM-DD HH24:MI:SS'),100,54211,201044,2)
;

-- Apr 29, 2017 7:31:24 PM CEST
CREATE UNIQUE INDEX asp_clientlevel_unq ON ASP_ClientLevel (AD_Client_ID,ASP_Level_ID)
;

-- Apr 29, 2017 7:33:18 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201045,'122bf156-6579-4bd5-ae53-e2fe3f30efae',TO_DATE('2017-04-29 19:33:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_module_unq',TO_DATE('2017-04-29 19:33:17','YYYY-MM-DD HH24:MI:SS'),100,53054,'N','N','N','N','N')
;

-- Apr 29, 2017 7:33:43 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201293,'fcc0cbb1-47a2-458e-b3b2-21cef56f7ecd',TO_DATE('2017-04-29 19:33:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:33:43','YYYY-MM-DD HH24:MI:SS'),100,54191,201045,1)
;

-- Apr 29, 2017 7:34:09 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201294,'60a70857-68a3-4830-a397-dfb4b46b2b9a',TO_DATE('2017-04-29 19:34:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:34:09','YYYY-MM-DD HH24:MI:SS'),100,54186,201045,2)
;

-- Apr 29, 2017 7:34:28 PM CEST
CREATE INDEX asp_module_unq ON ASP_Module (AD_Client_ID,Value)
;

-- Apr 29, 2017 7:37:36 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201046,'ed183a9e-7713-4f7e-80d7-b7f0835e75a7',TO_DATE('2017-04-29 19:37:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_window_unq',TO_DATE('2017-04-29 19:37:36','YYYY-MM-DD HH24:MI:SS'),100,53046,'N','Y','N','N')
;

-- Apr 29, 2017 7:37:52 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201295,'4cdf64bf-8d11-4ef4-81ca-2e410c4a53b7',TO_DATE('2017-04-29 19:37:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:37:52','YYYY-MM-DD HH24:MI:SS'),100,54099,201046,1)
;

-- Apr 29, 2017 7:38:04 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201296,'52514e7e-1a1e-497e-8884-83b7b3673e00',TO_DATE('2017-04-29 19:38:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:38:03','YYYY-MM-DD HH24:MI:SS'),100,54098,201046,2)
;

-- Apr 29, 2017 7:38:07 PM CEST
CREATE UNIQUE INDEX asp_window_unq ON ASP_Window (ASP_Level_ID,AD_Window_ID)
;

-- Apr 29, 2017 7:46:19 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201047,'77449d1b-10c3-4af2-9606-781fa6bdb74e',TO_DATE('2017-04-29 19:46:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_tab_unq',TO_DATE('2017-04-29 19:46:18','YYYY-MM-DD HH24:MI:SS'),100,53047,'N','Y','N','N')
;

-- Apr 29, 2017 7:46:34 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201297,'2a7c9e27-3fc5-42ba-972e-7ef4b5489246',TO_DATE('2017-04-29 19:46:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:46:34','YYYY-MM-DD HH24:MI:SS'),100,56672,201047,1)
;

-- Apr 29, 2017 7:46:44 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201298,'d77a7037-9feb-48ae-ae05-ad2b71886b0c',TO_DATE('2017-04-29 19:46:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:46:44','YYYY-MM-DD HH24:MI:SS'),100,54108,201047,2)
;

-- Apr 29, 2017 7:46:47 PM CEST
CREATE UNIQUE INDEX asp_tab_unq ON ASP_Tab (ASP_Window_ID,AD_Tab_ID)
;

-- Apr 29, 2017 7:47:17 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201048,'a80698ee-4c3b-466c-b8b1-373fd837a522',TO_DATE('2017-04-29 19:47:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_field_unq',TO_DATE('2017-04-29 19:47:17','YYYY-MM-DD HH24:MI:SS'),100,53048,'N','Y','N','N')
;

-- Apr 29, 2017 7:47:25 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201299,'d802c76b-04fb-46e1-954d-755196549b6f',TO_DATE('2017-04-29 19:47:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:47:24','YYYY-MM-DD HH24:MI:SS'),100,56673,201048,1)
;

-- Apr 29, 2017 7:47:31 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201300,'81aa2737-96a0-4a9b-be08-af0e3936ed44',TO_DATE('2017-04-29 19:47:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:47:31','YYYY-MM-DD HH24:MI:SS'),100,54120,201048,2)
;

-- Apr 29, 2017 7:47:36 PM CEST
CREATE UNIQUE INDEX asp_field_unq ON ASP_Field (ASP_Tab_ID,AD_Field_ID)
;

-- Apr 29, 2017 7:47:59 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201049,'6c656e70-1818-4b79-839c-a3cdb5c75b4d',TO_DATE('2017-04-29 19:47:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_process_unq',TO_DATE('2017-04-29 19:47:59','YYYY-MM-DD HH24:MI:SS'),100,53049,'N','Y','N','N')
;

-- Apr 29, 2017 7:48:11 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201301,'0ec7f231-7c88-4c1e-86ba-d26686e716f3',TO_DATE('2017-04-29 19:48:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:48:11','YYYY-MM-DD HH24:MI:SS'),100,54133,201049,1)
;

-- Apr 29, 2017 7:48:17 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201302,'98c44cbe-452c-475b-9698-a9ce613a5397',TO_DATE('2017-04-29 19:48:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:48:17','YYYY-MM-DD HH24:MI:SS'),100,54132,201049,2)
;

-- Apr 29, 2017 7:48:19 PM CEST
CREATE UNIQUE INDEX asp_process_unq ON ASP_Process (ASP_Level_ID,AD_Process_ID)
;

-- Apr 29, 2017 7:48:40 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201050,'8496f351-7000-42b8-b1b2-3c1cf020e0f3',TO_DATE('2017-04-29 19:48:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_process_para_unq',TO_DATE('2017-04-29 19:48:39','YYYY-MM-DD HH24:MI:SS'),100,53050,'N','Y','N','N')
;

-- Apr 29, 2017 7:48:53 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201303,'9d7e184b-f6d9-4fcb-98cd-7d9d0bbb8f94',TO_DATE('2017-04-29 19:48:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:48:53','YYYY-MM-DD HH24:MI:SS'),100,56674,201050,1)
;

-- Apr 29, 2017 7:49:02 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201304,'a13cb2cd-a3ee-4b3c-a4ba-10c43a663b0b',TO_DATE('2017-04-29 19:49:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:49:01','YYYY-MM-DD HH24:MI:SS'),100,54143,201050,2)
;

-- Apr 29, 2017 7:49:05 PM CEST
CREATE UNIQUE INDEX asp_process_para_unq ON ASP_Process_Para (ASP_Process_ID,AD_Process_Para_ID)
;

-- Apr 29, 2017 7:50:20 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201051,'6817bd47-8b0b-4ca9-99b7-1fb0ab7693a4',TO_DATE('2017-04-29 19:50:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_form_unq',TO_DATE('2017-04-29 19:50:20','YYYY-MM-DD HH24:MI:SS'),100,53051,'N','Y','N','N')
;

-- Apr 29, 2017 7:50:37 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201305,'7b5fa088-9f28-4a7e-b586-55dfb8224061',TO_DATE('2017-04-29 19:50:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:50:37','YYYY-MM-DD HH24:MI:SS'),100,54154,201051,1)
;

-- Apr 29, 2017 7:50:45 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201306,'5dbfb1d3-8fe3-4c9f-85b3-31371bed867e',TO_DATE('2017-04-29 19:50:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:50:44','YYYY-MM-DD HH24:MI:SS'),100,54152,201051,2)
;

-- Apr 29, 2017 7:50:47 PM CEST
CREATE UNIQUE INDEX asp_form_unq ON ASP_Form (ASP_Level_ID,AD_Form_ID)
;

-- Apr 29, 2017 7:51:14 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201052,'56958589-cab4-4c7a-b45a-9becd0deadc8',TO_DATE('2017-04-29 19:51:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_workflow_unq',TO_DATE('2017-04-29 19:51:13','YYYY-MM-DD HH24:MI:SS'),100,53053,'N','Y','N','N')
;

-- Apr 29, 2017 7:51:24 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201307,'4a8110e5-5292-4cf1-9c2c-ae9a6d4b6fa2',TO_DATE('2017-04-29 19:51:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:51:24','YYYY-MM-DD HH24:MI:SS'),100,54174,201052,1)
;

-- Apr 29, 2017 7:51:32 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201308,'02c32df1-201a-4b47-ad2f-b64ec2d33bb1',TO_DATE('2017-04-29 19:51:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:51:32','YYYY-MM-DD HH24:MI:SS'),100,54173,201052,2)
;

-- Apr 29, 2017 7:51:36 PM CEST
CREATE UNIQUE INDEX asp_workflow_unq ON ASP_Workflow (ASP_Level_ID,AD_Workflow_ID)
;

-- Apr 29, 2017 7:51:56 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201053,'ed29a5db-5e12-4c67-8607-1ec8c248cf16',TO_DATE('2017-04-29 19:51:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_task_unq',TO_DATE('2017-04-29 19:51:56','YYYY-MM-DD HH24:MI:SS'),100,53052,'N','Y','N','N')
;

-- Apr 29, 2017 7:52:03 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201309,'cffe2cdc-8560-4e3a-965b-a73d6bfcbc2a',TO_DATE('2017-04-29 19:52:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:52:03','YYYY-MM-DD HH24:MI:SS'),100,54164,201053,1)
;

-- Apr 29, 2017 7:52:11 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201310,'24329c58-5703-4b7b-b7d4-60d8d9a07d90',TO_DATE('2017-04-29 19:52:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:52:11','YYYY-MM-DD HH24:MI:SS'),100,54163,201053,2)
;

-- Apr 29, 2017 7:52:13 PM CEST
CREATE UNIQUE INDEX asp_task_unq ON ASP_Task (ASP_Level_ID,AD_Task_ID)
;

-- Apr 29, 2017 7:52:47 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201054,'bdd318e2-2c1a-4ee3-a91f-3ac5d783e7db',TO_DATE('2017-04-29 19:52:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','asp_ref_list_unq',TO_DATE('2017-04-29 19:52:47','YYYY-MM-DD HH24:MI:SS'),100,200011,'N','Y','N','N')
;

-- Apr 29, 2017 7:52:54 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201311,'f069dc9b-201b-4dc8-b024-2a6ea8dfed43',TO_DATE('2017-04-29 19:52:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:52:53','YYYY-MM-DD HH24:MI:SS'),100,200305,201054,1)
;

-- Apr 29, 2017 7:53:02 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201312,'bede6115-723f-4ce9-a9ae-c8980454f6ad',TO_DATE('2017-04-29 19:53:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 19:53:02','YYYY-MM-DD HH24:MI:SS'),100,200303,201054,2)
;

-- Apr 29, 2017 7:53:04 PM CEST
CREATE UNIQUE INDEX asp_ref_list_unq ON ASP_Ref_List (ASP_Level_ID,AD_Ref_List_ID)
;

-- IDEMPIERE-3358 Dictionary fixes - ASP Indexes / Default for ASP_Status = S
-- Apr 29, 2017 7:55:06 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54105
;

-- Apr 29, 2017 7:55:16 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:55:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54111
;

-- Apr 29, 2017 7:55:36 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:55:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54129
;

-- Apr 29, 2017 7:55:47 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:55:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54139
;

-- Apr 29, 2017 7:56:07 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:56:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54150
;

-- Apr 29, 2017 7:56:14 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:56:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54160
;

-- Apr 29, 2017 7:56:22 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:56:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54170
;

-- Apr 29, 2017 7:56:30 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:56:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54180
;

-- Apr 29, 2017 7:56:39 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:56:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54222
;

-- Apr 29, 2017 7:56:47 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_DATE('2017-04-29 19:56:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200302
;

SELECT register_migration_script('201704291925_IDEMPIERE-3358_ASP_indexes.sql') FROM dual
;

