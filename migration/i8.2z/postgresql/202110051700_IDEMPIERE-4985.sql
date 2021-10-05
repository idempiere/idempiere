-- IDEMPIERE-4985
-- Oct 5, 2021, 4:32:36 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201091,'267c8dca-82b0-442e-915f-a1555288d857',TO_TIMESTAMP('2021-10-05 16:32:35','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','ad_userdef_field_unique',TO_TIMESTAMP('2021-10-05 16:32:35','YYYY-MM-DD HH24:MI:SS'),0,464,'N','Y','N','N','N')
;

-- Oct 5, 2021, 4:32:48 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201431,'d7ada1df-f375-41ef-82e3-09d1ae4c6c82',TO_TIMESTAMP('2021-10-05 16:32:48','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:32:48','YYYY-MM-DD HH24:MI:SS'),0,6344,201091,10)
;

-- Oct 5, 2021, 4:32:51 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201432,'f2f3159e-dad4-4414-83be-4b9e443746c9',TO_TIMESTAMP('2021-10-05 16:32:51','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:32:51','YYYY-MM-DD HH24:MI:SS'),0,6345,201091,20)
;

-- Oct 5, 2021, 4:32:55 PM CEST
CREATE UNIQUE INDEX ad_userdef_field_unique ON AD_UserDef_Field (AD_UserDef_Tab_ID,AD_Field_ID)
;

-- Oct 5, 2021, 4:33:13 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201092,'0c141aef-d3eb-472d-bcc3-11bbf67ee2b9',TO_TIMESTAMP('2021-10-05 16:33:13','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','ad_userdef_infocolumn_unique',TO_TIMESTAMP('2021-10-05 16:33:13','YYYY-MM-DD HH24:MI:SS'),0,200268,'N','Y','N','N','N')
;

-- Oct 5, 2021, 4:33:27 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201433,'8403e994-14c8-4092-b71e-949d41dcdb26',TO_TIMESTAMP('2021-10-05 16:33:27','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:33:27','YYYY-MM-DD HH24:MI:SS'),0,214314,201092,10)
;

-- Oct 5, 2021, 4:33:30 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201434,'7f0b0f42-c171-4bce-a241-e1d60ea39ba6',TO_TIMESTAMP('2021-10-05 16:33:30','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:33:30','YYYY-MM-DD HH24:MI:SS'),0,214279,201092,20)
;

-- Oct 5, 2021, 4:33:33 PM CEST
CREATE UNIQUE INDEX ad_userdef_infocolumn_unique ON AD_UserDef_Info_Column (AD_UserDef_Info_ID,AD_InfoColumn_ID)
;

-- Oct 5, 2021, 4:33:41 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201093,'eda3e660-cca5-4a42-b2d8-f1d57622de7f',TO_TIMESTAMP('2021-10-05 16:33:40','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','ad_userdef_procparam_unique',TO_TIMESTAMP('2021-10-05 16:33:40','YYYY-MM-DD HH24:MI:SS'),0,200233,'N','Y','N','N','N')
;

-- Oct 5, 2021, 4:33:47 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201435,'f99215d3-bd64-4fea-b62d-969962dd0776',TO_TIMESTAMP('2021-10-05 16:33:47','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:33:47','YYYY-MM-DD HH24:MI:SS'),0,213287,201093,10)
;

-- Oct 5, 2021, 4:33:50 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201436,'7f17e0c1-f989-4ed9-8dd7-aceeaaf0d483',TO_TIMESTAMP('2021-10-05 16:33:50','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:33:50','YYYY-MM-DD HH24:MI:SS'),0,213297,201093,20)
;

-- Oct 5, 2021, 4:33:52 PM CEST
CREATE UNIQUE INDEX ad_userdef_procparam_unique ON AD_UserDef_Proc_Parameter (AD_UserDef_Proc_ID,AD_Process_Para_ID)
;

-- Oct 5, 2021, 4:50:43 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201094,'dc122bb0-4b61-48e7-8da5-9f1067cd17a0',TO_TIMESTAMP('2021-10-05 16:50:43','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','ad_userdef_tab_unique',TO_TIMESTAMP('2021-10-05 16:50:43','YYYY-MM-DD HH24:MI:SS'),0,466,'N','Y','N','N','N')
;

-- Oct 5, 2021, 4:50:48 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201437,'d58b01a7-3d9f-4796-a044-d12dc8d2c6b1',TO_TIMESTAMP('2021-10-05 16:50:48','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:50:48','YYYY-MM-DD HH24:MI:SS'),0,6379,201094,10)
;

-- Oct 5, 2021, 4:50:51 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201438,'39790458-1783-4311-bd4b-f00e42d783a8',TO_TIMESTAMP('2021-10-05 16:50:50','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-10-05 16:50:50','YYYY-MM-DD HH24:MI:SS'),0,6380,201094,20)
;

-- Oct 5, 2021, 4:50:54 PM CEST
CREATE UNIQUE INDEX ad_userdef_tab_unique ON AD_UserDef_Tab (AD_UserDef_Win_ID,AD_Tab_ID)
;

SELECT register_migration_script('202110051700_IDEMPIERE-4985.sql') FROM dual
;
