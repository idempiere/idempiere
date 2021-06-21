SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4813 Process Customization Cross Tenant Error
-- Jun 2, 2021, 9:43:42 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 09:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206478
;

-- Jun 2, 2021, 9:44:42 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 09:44:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206476
;

-- Jun 2, 2021, 9:44:49 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 09:44:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206477
;

-- Jun 2, 2021, 9:45:07 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 09:45:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206479
;

-- Jun 2, 2021, 9:48:21 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 09:48:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205253
;

-- Jun 2, 2021, 9:48:25 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 09:48:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205254
;

-- Jun 2, 2021, 9:48:39 AM CEST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2021-06-02 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213295
;

-- Jun 2, 2021, 9:48:55 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 09:48:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205255
;

-- Jun 2, 2021, 10:03:04 AM CEST
UPDATE AD_Column SET Callout=NULL,Updated=TO_DATE('2021-06-02 10:03:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213295
;

-- Jun 2, 2021, 10:06:17 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201083,'e86fddb9-dec0-4902-be58-f60c64045ea6',TO_DATE('2021-06-02 10:06:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_userdef_proc_unq',TO_DATE('2021-06-02 10:06:17','YYYY-MM-DD HH24:MI:SS'),100,200232,'N','Y','N','N','N')
;

-- Jun 2, 2021, 10:06:37 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201403,'a4784145-4efb-450c-9154-43fbe7d7751b',TO_DATE('2021-06-02 10:06:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:06:36','YYYY-MM-DD HH24:MI:SS'),100,213295,201083,1)
;

-- Jun 2, 2021, 10:06:47 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201404,'d29f9238-dd6d-4c8c-8bda-72e906332a8b',TO_DATE('2021-06-02 10:06:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:06:47','YYYY-MM-DD HH24:MI:SS'),100,213262,201083,2)
;

-- Jun 2, 2021, 10:07:28 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201405,'ea11e757-6afe-4ce8-9f02-53aea765a83a',TO_DATE('2021-06-02 10:07:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:07:27','YYYY-MM-DD HH24:MI:SS'),100,213263,201083,3)
;

-- Jun 2, 2021, 10:07:35 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201406,'db4f27e1-7486-41fb-87e5-ff2c3b866b28',TO_DATE('2021-06-02 10:07:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:07:35','YYYY-MM-DD HH24:MI:SS'),100,213269,201083,0)
;

-- Jun 2, 2021, 10:07:39 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201407,'2f9798db-99f1-4315-b130-537169e6d8be',TO_DATE('2021-06-02 10:07:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:07:39','YYYY-MM-DD HH24:MI:SS'),100,213270,201083,0)
;

-- Jun 2, 2021, 10:07:49 AM CEST
UPDATE AD_IndexColumn SET SeqNo=4,Updated=TO_DATE('2021-06-02 10:07:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201407
;

-- Jun 2, 2021, 10:07:52 AM CEST
UPDATE AD_IndexColumn SET SeqNo=5,Updated=TO_DATE('2021-06-02 10:07:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201406
;

-- Jun 2, 2021, 10:09:17 AM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_Role_ID,0)',Updated=TO_DATE('2021-06-02 10:09:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201406
;

-- Jun 2, 2021, 10:09:36 AM CEST
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(AD_User_ID,0)',Updated=TO_DATE('2021-06-02 10:09:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201407
;

-- Jun 2, 2021, 10:10:15 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201408,'30538a6b-9126-4c4f-96ba-640a43e5d51c',TO_DATE('2021-06-02 10:10:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:10:15','YYYY-MM-DD HH24:MI:SS'),100,213274,201083,'COALESCE(AD_Language,'''')',6)
;

-- Jun 2, 2021, 10:10:23 AM CEST
CREATE UNIQUE INDEX ad_userdef_proc_unq ON AD_UserDef_Proc (AD_Process_ID,AD_Client_ID,AD_Org_ID,COALESCE(AD_User_ID,0),COALESCE(AD_Role_ID,0),COALESCE(AD_Language,''))
;

-- Jun 2, 2021, 10:22:44 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201084,'33fa0f76-dbdc-413e-852c-0baef626136f',TO_DATE('2021-06-02 10:22:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_userdef_info_unq',TO_DATE('2021-06-02 10:22:43','YYYY-MM-DD HH24:MI:SS'),100,200266,'N','Y','N','N','N')
;

-- Jun 2, 2021, 10:26:11 AM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_IndexColumn WHERE AD_TableIndex_ID=@AD_TableIndex_ID@',Updated=TO_DATE('2021-06-02 10:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210548
;

-- Jun 2, 2021, 10:26:53 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201409,'8d6cb346-17c6-4e8c-947e-34385480e253',TO_DATE('2021-06-02 10:26:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:26:53','YYYY-MM-DD HH24:MI:SS'),100,214237,201084,10)
;

-- Jun 2, 2021, 10:27:21 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201410,'a07abfee-650a-4687-a78e-f8d6acc29837',TO_DATE('2021-06-02 10:27:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:27:20','YYYY-MM-DD HH24:MI:SS'),100,214228,201084,20)
;

-- Jun 2, 2021, 10:27:25 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201411,'d1f54bc3-c82f-4359-b397-88e33007cdc1',TO_DATE('2021-06-02 10:27:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:27:25','YYYY-MM-DD HH24:MI:SS'),100,214229,201084,30)
;

-- Jun 2, 2021, 10:27:42 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201412,'54d50300-b5e8-489f-9603-f6371b0084e7',TO_DATE('2021-06-02 10:27:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:27:42','YYYY-MM-DD HH24:MI:SS'),100,214236,201084,'COALESCE(AD_User_ID,0)',40)
;

-- Jun 2, 2021, 10:27:53 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201413,'5cc463b4-a492-41c7-8743-e6549b8ec909',TO_DATE('2021-06-02 10:27:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:27:53','YYYY-MM-DD HH24:MI:SS'),100,214235,201084,'COALESCE(AD_Role_ID,0)',50)
;

-- Jun 2, 2021, 10:28:03 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201414,'b058f75c-2aee-478f-9301-f593ed974c0c',TO_DATE('2021-06-02 10:28:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:28:03','YYYY-MM-DD HH24:MI:SS'),100,214241,201084,'COALESCE(AD_Language,'''')',60)
;

-- Jun 2, 2021, 10:28:11 AM CEST
CREATE UNIQUE INDEX ad_userdef_info_unq ON AD_UserDef_Info (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,COALESCE(AD_User_ID,0),COALESCE(AD_Role_ID,0),COALESCE(AD_Language,''))
;

-- Jun 2, 2021, 10:29:56 AM CEST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2021-06-02 10:29:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6395
;

-- Jun 2, 2021, 10:30:20 AM CEST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2021-06-02 10:30:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6380
;

-- Jun 2, 2021, 10:31:45 AM CEST
UPDATE AD_Column SET Callout=NULL,Updated=TO_DATE('2021-06-02 10:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6395
;

-- Jun 2, 2021, 10:32:08 AM CEST
UPDATE AD_Column SET Callout=NULL,Updated=TO_DATE('2021-06-02 10:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6380
;

-- Jun 2, 2021, 10:32:29 AM CEST
UPDATE AD_Column SET Callout=NULL,Updated=TO_DATE('2021-06-02 10:32:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6345
;

-- Jun 2, 2021, 10:32:52 AM CEST
UPDATE AD_Field SET DisplayLogic='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 10:32:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11250
;

-- Jun 2, 2021, 10:33:02 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 10:33:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5020
;

-- Jun 2, 2021, 10:33:08 AM CEST
UPDATE AD_Field SET DisplayLogic=NULL, DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 10:33:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11250
;

-- Jun 2, 2021, 10:33:16 AM CEST
UPDATE AD_Field SET DefaultValue='NULL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 10:33:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5026
;

-- Jun 2, 2021, 10:34:54 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201085,'96972b66-eac6-479e-8d4e-f2a7d6b14e10',TO_DATE('2021-06-02 10:34:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_userdef_win_unq',TO_DATE('2021-06-02 10:34:54','YYYY-MM-DD HH24:MI:SS'),100,467,'N','Y','N','N','N')
;

-- Jun 2, 2021, 10:35:05 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201415,'aaf0a457-527f-4760-ab10-68dfdc732554',TO_DATE('2021-06-02 10:35:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:35:04','YYYY-MM-DD HH24:MI:SS'),100,6395,201085,10)
;

-- Jun 2, 2021, 10:35:09 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201416,'e2126294-294e-49d8-bc2b-5aca5fb1dd3a',TO_DATE('2021-06-02 10:35:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:35:09','YYYY-MM-DD HH24:MI:SS'),100,6387,201085,20)
;

-- Jun 2, 2021, 10:35:13 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201417,'c6e164ea-bb35-4103-b2b4-f0019ee1a9db',TO_DATE('2021-06-02 10:35:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:35:13','YYYY-MM-DD HH24:MI:SS'),100,6388,201085,30)
;

-- Jun 2, 2021, 10:35:14 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,SeqNo) VALUES (0,0,201418,'e5070b4f-0c7a-4ae3-acc5-4813bb58fca1',TO_DATE('2021-06-02 10:35:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:35:14','YYYY-MM-DD HH24:MI:SS'),100,201085,40)
;

-- Jun 2, 2021, 10:35:23 AM CEST
UPDATE AD_IndexColumn SET AD_Column_ID=6389, ColumnSQL='COALESCE(AD_User_ID,0)',Updated=TO_DATE('2021-06-02 10:35:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201418
;

-- Jun 2, 2021, 10:35:33 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201419,'76ce2156-cc60-49e2-80ba-72caf0ae6079',TO_DATE('2021-06-02 10:35:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:35:33','YYYY-MM-DD HH24:MI:SS'),100,13425,201085,'COALESCE(AD_Role_ID,0)',50)
;

-- Jun 2, 2021, 10:35:42 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201420,'653d5e4a-32cb-4af1-9877-d5fdac6eae36',TO_DATE('2021-06-02 10:35:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-02 10:35:41','YYYY-MM-DD HH24:MI:SS'),100,6399,201085,'COALESCE(AD_Language,'''')',60)
;

-- Jun 2, 2021, 10:35:46 AM CEST
CREATE UNIQUE INDEX ad_userdef_win_unq ON AD_UserDef_Win (AD_Window_ID,AD_Client_ID,AD_Org_ID,COALESCE(AD_User_ID,0),COALESCE(AD_Role_ID,0),COALESCE(AD_Language,''))
;

SELECT register_migration_script('202106021000_IDEMPIERE-4813.sql') FROM dual
;

