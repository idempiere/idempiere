-- IDEMPIERE-5221 Performance - indexes on heavily used queries / FHCA-3486
SELECT register_migration_script('202203161342_IDEMPIERE-5221.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 16, 2022, 1:42:21 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201103,'734ba522-a9c7-4dce-bc92-4c1ab204ff4f',TO_TIMESTAMP('2022-03-16 13:42:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_session_websession_servername_processed',TO_TIMESTAMP('2022-03-16 13:42:21','YYYY-MM-DD HH24:MI:SS'),100,566,'N','N','N','N','N')
;

-- Mar 16, 2022, 1:42:29 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201456,'b44e086b-1580-4faa-9224-7f780280a027',TO_TIMESTAMP('2022-03-16 13:42:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:42:29','YYYY-MM-DD HH24:MI:SS'),100,8584,201103,10)
;

-- Mar 16, 2022, 1:42:32 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201457,'a5510d94-bbfd-4c98-88d6-d83bbbd6fd65',TO_TIMESTAMP('2022-03-16 13:42:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:42:31','YYYY-MM-DD HH24:MI:SS'),100,200613,201103,20)
;

-- Mar 16, 2022, 1:42:39 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201458,'58cf711f-b645-4cd5-8bd1-a4b61384fa3f',TO_TIMESTAMP('2022-03-16 13:42:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:42:39','YYYY-MM-DD HH24:MI:SS'),100,8773,201103,30)
;

-- Mar 16, 2022, 1:42:51 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_session_websession_servername_processed'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 1:43:12 PM CET
CREATE INDEX ad_session_websession_servername_processed ON AD_Session (WebSession,ServerName,Processed)
;

-- Mar 16, 2022, 1:45:04 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201104,'90f2c197-d992-4bea-94e4-dfe8fa6522bb',TO_TIMESTAMP('2022-03-16 13:45:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_window_access_ad_role_id',TO_TIMESTAMP('2022-03-16 13:45:04','YYYY-MM-DD HH24:MI:SS'),100,201,'N','N','N','N','N')
;

-- Mar 16, 2022, 1:45:11 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201459,'8d41bb87-8db3-4166-bc9f-2f69c2553e62',TO_TIMESTAMP('2022-03-16 13:45:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:45:10','YYYY-MM-DD HH24:MI:SS'),100,4637,201104,10)
;

-- Mar 16, 2022, 1:45:19 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_window_access_ad_role_id'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 1:45:23 PM CET
CREATE INDEX ad_window_access_ad_role_id ON AD_Window_Access (AD_Role_ID)
;

-- Mar 16, 2022, 1:51:27 PM CET
UPDATE AD_Column SET FieldLength=128, SeqNoSelection=10,Updated=TO_TIMESTAMP('2022-03-16 13:51:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210522
;

-- avoid error ORA-30556 either functional or bitmap join index is defined on the column to be modified
DROP INDEX ad_tableindex_name
;

-- Mar 16, 2022, 1:51:31 PM CET
ALTER TABLE AD_TableIndex MODIFY Name VARCHAR2(128 CHAR)
;

CREATE UNIQUE INDEX ad_tableindex_name ON AD_TableIndex (UPPER(Name))
;

-- Mar 16, 2022, 1:53:05 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201105,'a8effe10-7b8c-4c3e-baaa-aedbac4e0f05',TO_TIMESTAMP('2022-03-16 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_private_access_ad_table_id_isactive_ad_user_id_record_id',TO_TIMESTAMP('2022-03-16 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,627,'N','N','N','N','N')
;

-- Mar 16, 2022, 1:53:14 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201460,'532444e9-8517-4219-9aec-32e078f42713',TO_TIMESTAMP('2022-03-16 13:53:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:53:14','YYYY-MM-DD HH24:MI:SS'),100,9940,201105,10)
;

-- Mar 16, 2022, 1:53:18 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201461,'7b1c4b33-6b60-4dce-b0ba-b8e7bbc0be31',TO_TIMESTAMP('2022-03-16 13:53:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:53:17','YYYY-MM-DD HH24:MI:SS'),100,9946,201105,20)
;

-- Mar 16, 2022, 1:53:23 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201462,'86ce5891-b01b-4410-a39a-65e12da20c5d',TO_TIMESTAMP('2022-03-16 13:53:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:53:22','YYYY-MM-DD HH24:MI:SS'),100,9942,201105,30)
;

-- Mar 16, 2022, 1:53:27 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201463,'00a311da-77a9-4019-8bbd-de0adade14a0',TO_TIMESTAMP('2022-03-16 13:53:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:53:26','YYYY-MM-DD HH24:MI:SS'),100,9943,201105,40)
;

-- Mar 16, 2022, 1:53:32 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_private_access_ad_table_id_isactive_ad_user_id_record_id'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 1:53:35 PM CET
CREATE INDEX ad_private_access_ad_table_id_isactive_ad_user_id_record_id ON AD_Private_Access (AD_Table_ID,IsActive,AD_User_ID,Record_ID)
;

-- Mar 16, 2022, 1:54:39 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201106,'fe46ed64-191b-467a-9a30-c8ea318fd9c5',TO_TIMESTAMP('2022-03-16 13:54:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_note_ad_client_id_processed_ad_user_id_ad_broadcastmessage',TO_TIMESTAMP('2022-03-16 13:54:39','YYYY-MM-DD HH24:MI:SS'),100,389,'N','N','N','N','N')
;

-- Mar 16, 2022, 1:54:41 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201464,'c6ec1851-1f51-46fc-96fc-bea2100e3784',TO_TIMESTAMP('2022-03-16 13:54:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:54:41','YYYY-MM-DD HH24:MI:SS'),100,4826,201106,10)
;

-- Mar 16, 2022, 1:54:45 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201465,'0ae9c7ba-1d03-4a87-8921-0c576d4291d9',TO_TIMESTAMP('2022-03-16 13:54:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:54:45','YYYY-MM-DD HH24:MI:SS'),100,5949,201106,20)
;

-- Mar 16, 2022, 1:54:50 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201466,'7e8c9121-25dc-40c0-a364-5f72c49c811f',TO_TIMESTAMP('2022-03-16 13:54:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:54:50','YYYY-MM-DD HH24:MI:SS'),100,5946,201106,30)
;

-- Mar 16, 2022, 1:54:56 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201467,'ff52763c-fb22-426d-a4e9-be2b9dbeb869',TO_TIMESTAMP('2022-03-16 13:54:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:54:55','YYYY-MM-DD HH24:MI:SS'),100,201000,201106,40)
;

-- Mar 16, 2022, 1:55:05 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_note_ad_client_id_processed_ad_user_id_ad_broadcastmessage'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 1:55:08 PM CET
CREATE INDEX ad_note_ad_client_id_processed_ad_user_id_ad_broadcastmessage ON AD_Note (AD_Client_ID,Processed,AD_User_ID,AD_BroadcastMessage_ID)
;

-- Mar 16, 2022, 1:56:19 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201107,'de58034c-ae5b-4bda-ab6a-6e96a1272b2e',TO_TIMESTAMP('2022-03-16 13:56:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Form_Access_AD_Role_ID',TO_TIMESTAMP('2022-03-16 13:56:18','YYYY-MM-DD HH24:MI:SS'),100,378,'N','N','N','N','N')
;

-- Mar 16, 2022, 1:56:23 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201468,'b2fbf19b-35fa-4a04-b47a-eca0f9fa1c90',TO_TIMESTAMP('2022-03-16 13:56:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:56:22','YYYY-MM-DD HH24:MI:SS'),100,4624,201107,10)
;

-- Mar 16, 2022, 1:56:27 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX AD_Form_Access_AD_Role_ID'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 1:56:29 PM CET
CREATE INDEX AD_Form_Access_AD_Role_ID ON AD_Form_Access (AD_Role_ID)
;

-- Mar 16, 2022, 1:57:06 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201108,'903ab119-c7a7-40d9-b9fd-11984094b581',TO_TIMESTAMP('2022-03-16 13:57:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_user_c_bpartner_id',TO_TIMESTAMP('2022-03-16 13:57:06','YYYY-MM-DD HH24:MI:SS'),100,114,'N','N','N','N','N')
;

-- Mar 16, 2022, 1:57:10 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201469,'8f71c813-956f-44ef-b89c-038d1c7e4566',TO_TIMESTAMP('2022-03-16 13:57:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:57:10','YYYY-MM-DD HH24:MI:SS'),100,5844,201108,10)
;

-- Mar 16, 2022, 1:57:13 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_user_c_bpartner_id'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 1:57:16 PM CET
CREATE INDEX ad_user_c_bpartner_id ON AD_User (C_BPartner_ID)
;

-- Mar 16, 2022, 1:59:29 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201109,'b944cb5f-2303-4326-af6f-e13d46a84336',TO_TIMESTAMP('2022-03-16 13:59:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_sequence_name_ad_client_id',TO_TIMESTAMP('2022-03-16 13:59:29','YYYY-MM-DD HH24:MI:SS'),100,115,'N','N','N','N','N')
;

-- Mar 16, 2022, 1:59:37 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201470,'4cfe7b5c-a191-4799-bbde-b3d9dd7bc8fe',TO_TIMESTAMP('2022-03-16 13:59:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:59:37','YYYY-MM-DD HH24:MI:SS'),100,201109,'UPPER(Name)',10)
;

-- Mar 16, 2022, 1:59:44 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201471,'c5358dfe-bb1a-425b-bb98-3318c87cd613',TO_TIMESTAMP('2022-03-16 13:59:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 13:59:44','YYYY-MM-DD HH24:MI:SS'),100,426,201109,20)
;

-- Mar 16, 2022, 1:59:47 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_sequence_name_ad_client_id'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 1:59:50 PM CET
CREATE INDEX ad_sequence_name_ad_client_id ON AD_Sequence (UPPER(Name),AD_Client_ID)
;

-- Mar 16, 2022, 2:00:26 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201110,'f5471ac0-0cf7-4017-b47a-cd756e41acaf',TO_TIMESTAMP('2022-03-16 14:00:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_user_roles_ad_role_id',TO_TIMESTAMP('2022-03-16 14:00:26','YYYY-MM-DD HH24:MI:SS'),100,157,'N','N','N','N','N')
;

-- Mar 16, 2022, 2:00:31 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201472,'64f5b577-9454-4ccc-91c8-0feacc00ba8a',TO_TIMESTAMP('2022-03-16 14:00:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:00:31','YYYY-MM-DD HH24:MI:SS'),100,542,201110,10)
;

-- Mar 16, 2022, 2:00:32 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,SeqNo) VALUES (0,0,201473,'53492333-d2fc-4c8a-ac9c-592b6bc9a9be',TO_TIMESTAMP('2022-03-16 14:00:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:00:32','YYYY-MM-DD HH24:MI:SS'),100,201110,20)
;

-- Mar 16, 2022, 2:00:36 PM CET
UPDATE AD_IndexColumn SET AD_Column_ID=972,Updated=TO_TIMESTAMP('2022-03-16 14:00:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201473
;

-- Mar 16, 2022, 2:00:40 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201474,'6cc8720d-90af-4720-a8bb-db23f99d5347',TO_TIMESTAMP('2022-03-16 14:00:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:00:40','YYYY-MM-DD HH24:MI:SS'),100,973,201110,30)
;

-- Mar 16, 2022, 2:00:44 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201475,'4c913fa4-3496-4ced-85bb-0d2b1c0707ac',TO_TIMESTAMP('2022-03-16 14:00:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:00:44','YYYY-MM-DD HH24:MI:SS'),100,721,201110,40)
;

-- Mar 16, 2022, 2:00:48 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201476,'9f7418c5-40b4-4a41-aad5-dc0b72b7f3d1',TO_TIMESTAMP('2022-03-16 14:00:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:00:48','YYYY-MM-DD HH24:MI:SS'),100,971,201110,50)
;

-- Mar 16, 2022, 2:00:54 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_user_roles_ad_role_id'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 2:00:57 PM CET
CREATE INDEX ad_user_roles_ad_role_id ON AD_User_Roles (AD_Role_ID,AD_Client_ID,AD_Org_ID,IsActive,AD_User_ID)
;

-- Mar 16, 2022, 2:01:18 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201111,'0853e33c-ad65-4a85-935c-6c569a6010a1',TO_TIMESTAMP('2022-03-16 14:01:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_role_included_included_role_id',TO_TIMESTAMP('2022-03-16 14:01:18','YYYY-MM-DD HH24:MI:SS'),100,53222,'N','N','N','N','N')
;

-- Mar 16, 2022, 2:01:26 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201477,'79af7337-f77c-4322-9e77-eaf45ac244d4',TO_TIMESTAMP('2022-03-16 14:01:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:01:25','YYYY-MM-DD HH24:MI:SS'),100,57949,201111,10)
;

-- Mar 16, 2022, 2:01:29 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201478,'0ab73b2b-047b-4e44-bd45-1b35381d96eb',TO_TIMESTAMP('2022-03-16 14:01:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:01:29','YYYY-MM-DD HH24:MI:SS'),100,57940,201111,20)
;

-- Mar 16, 2022, 2:01:33 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201479,'0473d14e-d820-4c98-b759-51c3850b9da5',TO_TIMESTAMP('2022-03-16 14:01:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:01:32','YYYY-MM-DD HH24:MI:SS'),100,57941,201111,30)
;

-- Mar 16, 2022, 2:01:37 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_role_included_included_role_id'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 2:01:40 PM CET
CREATE INDEX ad_role_included_included_role_id ON AD_Role_Included (Included_Role_ID,AD_Client_ID,AD_Org_ID)
;

-- Mar 16, 2022, 2:02:02 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201112,'1a7e074a-7190-45a9-ab31-d7abfbc63f40',TO_TIMESTAMP('2022-03-16 14:02:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_infowindow_access_ad_infowindow_id',TO_TIMESTAMP('2022-03-16 14:02:02','YYYY-MM-DD HH24:MI:SS'),100,200054,'N','N','N','N','N')
;

-- Mar 16, 2022, 2:02:06 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201480,'277d6fd6-9fee-420b-8076-012aaae7c073',TO_TIMESTAMP('2022-03-16 14:02:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:02:06','YYYY-MM-DD HH24:MI:SS'),100,208377,201112,10)
;

-- Mar 16, 2022, 2:02:13 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_infowindow_access_ad_infowindow_id'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 2:02:16 PM CET
CREATE INDEX ad_infowindow_access_ad_infowindow_id ON AD_InfoWindow_Access (AD_InfoWindow_ID)
;

-- Mar 16, 2022, 2:07:12 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201113,'c4060299-7819-4980-af18-8c87b2ab7ddf',TO_TIMESTAMP('2022-03-16 14:07:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_user_name',TO_TIMESTAMP('2022-03-16 14:07:12','YYYY-MM-DD HH24:MI:SS'),100,114,'N','N','N','N','N')
;

-- Mar 16, 2022, 2:07:21 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201481,'0e140fde-4c46-4e7f-a293-0ed2ad4a8634',TO_TIMESTAMP('2022-03-16 14:07:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:07:21','YYYY-MM-DD HH24:MI:SS'),100,213,201113,10)
;

-- Mar 16, 2022, 2:07:28 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201482,'0de958e3-0d20-4a15-80ec-1aae958debea',TO_TIMESTAMP('2022-03-16 14:07:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:07:27','YYYY-MM-DD HH24:MI:SS'),100,212,201113,20)
;

-- Mar 16, 2022, 2:07:33 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX ad_user_name'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 2:07:36 PM CET
CREATE INDEX ad_user_name ON AD_User (Name,AD_User_ID)
;

-- Mar 16, 2022, 2:12:31 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201114,'6216db59-f058-401a-a7a5-4aedd3dc8b62',TO_TIMESTAMP('2022-03-16 14:12:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Note_Record_ID_AD_Table_ID',TO_TIMESTAMP('2022-03-16 14:12:30','YYYY-MM-DD HH24:MI:SS'),100,389,'N','N','N','N','N')
;

-- Mar 16, 2022, 2:12:39 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201483,'007f6b56-408b-4504-8956-7227a6530ded',TO_TIMESTAMP('2022-03-16 14:12:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:12:38','YYYY-MM-DD HH24:MI:SS'),100,5958,201114,10)
;

-- Mar 16, 2022, 2:12:40 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201484,'ccfa6d75-ccf1-40ad-be67-e2b05dab2506',TO_TIMESTAMP('2022-03-16 14:12:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:12:40','YYYY-MM-DD HH24:MI:SS'),100,5957,201114,20)
;

-- Mar 16, 2022, 2:12:45 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX AD_Note_Record_ID_AD_Table_ID'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 2:12:48 PM CET
CREATE INDEX AD_Note_Record_ID_AD_Table_ID ON AD_Note (Record_ID,AD_Table_ID)
;

-- Mar 16, 2022, 2:19:18 PM CET
UPDATE AD_IndexColumn SET SeqNo=10,Updated=TO_TIMESTAMP('2022-03-16 14:19:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200047
;

-- Mar 16, 2022, 2:19:22 PM CET
UPDATE AD_IndexColumn SET SeqNo=20,Updated=TO_TIMESTAMP('2022-03-16 14:19:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200048
;

-- Mar 16, 2022, 2:19:25 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201485,'c6030359-2549-487b-9003-1954eca99677',TO_TIMESTAMP('2022-03-16 14:19:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:19:25','YYYY-MM-DD HH24:MI:SS'),100,2087,200047,30)
;

-- Mar 16, 2022, 2:22:34 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201115,'9f3e35c8-1ce2-413b-888f-58d408c3c68c',TO_TIMESTAMP('2022-03-16 14:22:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PostIt_Record_ID_AD_Table_ID',TO_TIMESTAMP('2022-03-16 14:22:34','YYYY-MM-DD HH24:MI:SS'),100,200215,'N','Y','N','N','N')
;

-- Mar 16, 2022, 2:22:39 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201487,'45979227-65e8-4f1e-a792-394f08abf69b',TO_TIMESTAMP('2022-03-16 14:22:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:22:39','YYYY-MM-DD HH24:MI:SS'),100,212930,201115,10)
;

-- Mar 16, 2022, 2:22:42 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201488,'2fa2c704-e7c9-4656-86b1-85771fd41afe',TO_TIMESTAMP('2022-03-16 14:22:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:22:41','YYYY-MM-DD HH24:MI:SS'),100,212925,201115,20)
;

-- Mar 16, 2022, 2:22:47 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX AD_PostIt_Record_ID_AD_Table_ID'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 2:22:49 PM CET
CREATE UNIQUE INDEX AD_PostIt_Record_ID_AD_Table_ID ON AD_PostIt (Record_ID,AD_Table_ID)
;

-- Mar 16, 2022, 2:23:26 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201116,'981f4c91-12c9-42bb-a54c-81c65661f085',TO_TIMESTAMP('2022-03-16 14:23:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_RecentItem_Record_ID_AD_Table_ID',TO_TIMESTAMP('2022-03-16 14:23:26','YYYY-MM-DD HH24:MI:SS'),100,200000,'N','N','N','N','N')
;

-- Mar 16, 2022, 2:23:30 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201489,'dcad12c8-30c3-440e-a52c-1afb4814ccaf',TO_TIMESTAMP('2022-03-16 14:23:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:23:30','YYYY-MM-DD HH24:MI:SS'),100,200011,201116,10)
;

-- Mar 16, 2022, 2:23:38 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201490,'1f2caab5-4e0b-44cf-9d81-3a6e681e42d2',TO_TIMESTAMP('2022-03-16 14:23:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-16 14:23:38','YYYY-MM-DD HH24:MI:SS'),100,200005,201116,20)
;

-- Mar 16, 2022, 2:23:43 PM CET
BEGIN EXECUTE IMMEDIATE 'DROP INDEX AD_RecentItem_Record_ID_AD_Table_ID'; EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1418 THEN NULL; ELSE RAISE; END IF; END;
/

-- Mar 16, 2022, 2:23:46 PM CET
CREATE INDEX AD_RecentItem_Record_ID_AD_Table_ID ON AD_RecentItem (Record_ID,AD_Table_ID)
;

