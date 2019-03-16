SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3916 Process to move client between databases
-- Mar 13, 2019 1:17:24 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200110,0,0,'Y',TO_DATE('2019-03-13 13:17:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:17:24','YYYY-MM-DD HH24:MI:SS'),100,'Move Client','Process to move a client from an external database to current','N','MoveClient','N','org.idempiere.process.MoveClient','4','D',0,0,'N','N','Y','N','365a132a-7b8e-4f0f-b1d3-70db173df7f9')
;

-- Mar 13, 2019 1:17:54 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200168,'Move Client','Process to move a client from an external database to current','P',0,0,'Y',TO_DATE('2019-03-13 13:17:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:17:53','YYYY-MM-DD HH24:MI:SS'),100,'N',200110,'Y','N','D','Y','63aa38c7-b332-42d3-813e-912389e4f767')
;

-- Mar 13, 2019 1:17:54 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200168, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200168)
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000016
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000036
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000095
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 13, 2019 1:18:30 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 13, 2019 1:19:21 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203294,0,0,'Y',TO_DATE('2019-03-13 13:19:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:19:21','YYYY-MM-DD HH24:MI:SS'),100,'ClientsToExclude','Clients to Exclude','Comma separated list of client IDs to exclude','Clients to Exclude','D','6e7efabf-8c3c-424a-a22f-ccfcb7ff426d')
;

-- Mar 13, 2019 1:20:08 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203295,0,0,'Y',TO_DATE('2019-03-13 13:20:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:20:08','YYYY-MM-DD HH24:MI:SS'),100,'ClientsToInclude','Clients to Include','Comma separated list of client IDs to include','Clients to Include','D','d43df270-66c5-4f08-a3a0-7a9125f2b19a')
;

-- Mar 13, 2019 1:20:21 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203296,0,0,'Y',TO_DATE('2019-03-13 13:20:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:20:21','YYYY-MM-DD HH24:MI:SS'),100,'TablesToExclude','Tables to Exclude','Comma separated list of tables to exclude','Tables to Exclude','D','9e56bd23-c125-46a4-a1e7-c126c8398888')
;

-- Mar 13, 2019 1:20:34 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203297,0,0,'Y',TO_DATE('2019-03-13 13:20:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:20:34','YYYY-MM-DD HH24:MI:SS'),100,'JDBC_URL','JDBC URL','JDBC URL','D','dcae66f5-4e3c-4ede-9cc1-f590e4e01ff1')
;

-- Mar 13, 2019 1:21:19 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200256,0,0,'Y',TO_DATE('2019-03-13 13:21:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:21:19','YYYY-MM-DD HH24:MI:SS'),100,'JDBC URL',200110,10,10,'N',1000,'Y','JDBC_URL','Y','D',203297,'d85a4590-ebdb-412a-8356-8acd1afc2d58','N')
;

-- Mar 13, 2019 1:21:42 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200257,0,0,'Y',TO_DATE('2019-03-13 13:21:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:21:41','YYYY-MM-DD HH24:MI:SS'),100,'User Name',200110,20,10,'N',100,'N','UserName','Y','D',1903,'47c346a2-5bdf-46e2-baef-43c5b5e4c800','N')
;

-- Mar 13, 2019 1:22:13 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200258,0,0,'Y',TO_DATE('2019-03-13 13:22:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:22:12','YYYY-MM-DD HH24:MI:SS'),100,'Password','Password of any length (case sensitive)','The Password for this User.  Passwords are required to identify authorized users.  For iDempiere Users, you can change the password via the Process "Reset Password".',200110,30,10,'N',100,'N','Password','Y','D',498,'7e5b47a3-5bd1-4e92-adb7-d58d4a725932','Y')
;

-- Mar 13, 2019 1:22:34 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200259,0,0,'Y',TO_DATE('2019-03-13 13:22:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:22:34','YYYY-MM-DD HH24:MI:SS'),100,'Tables to Exclude','Comma separated list of tables to exclude',200110,40,10,'N',32000,'N','TablesToExclude','Y','D',203296,'25677162-7d62-4319-9c0e-1ff8dfbccf09','N')
;

-- Mar 13, 2019 1:23:04 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200260,0,0,'Y',TO_DATE('2019-03-13 13:23:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:23:04','YYYY-MM-DD HH24:MI:SS'),100,'Clients to Include','Comma separated list of client IDs to include',200110,50,10,'N',32000,'N','ClientsToInclude','Y','D',203295,'3284012a-252f-4410-9a55-ae8f1c121f5a','N')
;

-- Mar 13, 2019 1:23:30 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200261,0,0,'Y',TO_DATE('2019-03-13 13:23:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:23:30','YYYY-MM-DD HH24:MI:SS'),100,'Clients to Exclude','Comma separated list of client IDs to exclude',200110,60,10,'N',32000,'N','ClientsToExclude','Y','D',203294,'cac0280e-0e34-4c66-b055-51276d75821c','N')
;

-- Mar 13, 2019 1:23:54 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200262,0,0,'Y',TO_DATE('2019-03-13 13:23:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:23:54','YYYY-MM-DD HH24:MI:SS'),100,'Only Validate Data','Validate the date and do not process',200110,70,20,'N',0,'Y','Y','IsValidateOnly','Y','D',2168,'cb303081-dc25-48b1-b6d4-dcf8d17708c2','N')
;

-- Mar 13, 2019 1:24:35 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203298,0,0,'Y',TO_DATE('2019-03-13 13:24:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:24:34','YYYY-MM-DD HH24:MI:SS'),100,'IsPreserveIDs','Preserve IDs','Preserve IDs','D','717c4728-0178-499b-a846-e70a790e7f96')
;

-- Mar 13, 2019 1:24:55 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200263,0,0,'Y',TO_DATE('2019-03-13 13:24:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-13 13:24:55','YYYY-MM-DD HH24:MI:SS'),100,'Preserve IDs',200110,80,20,'N',1,'Y','N','IsPreserveIDs','Y','D',203298,'e81f21da-5126-4009-876b-c477315ba0ea','N')
;

-- Mar 13, 2019 1:25:01 PM CET
UPDATE AD_Process_Para SET FieldLength=1,Updated=TO_DATE('2019-03-13 13:25:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200262
;

-- Mar 13, 2019 6:39:33 PM CET
UPDATE AD_Process_Para SET Description='Comma separated list of tables that require to preserve the IDs', AD_Reference_ID=10, FieldLength=32000, IsMandatory='N', DefaultValue=NULL,Updated=TO_DATE('2019-03-13 18:39:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200263
;

CREATE TABLE T_MoveClient (AD_PInstance_ID NUMBER(10), TableName VARCHAR2(40), Source_ID NUMBER(10), Target_ID NUMBER(10))
;

CREATE UNIQUE INDEX UX_T_MoveClient ON T_MoveClient (AD_PInstance_ID,TableName,Source_ID)
;

-- Mar 13, 2019 7:28:16 PM CET
UPDATE AD_Process_Para SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:28:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200259
;

-- Mar 13, 2019 7:28:19 PM CET
UPDATE AD_Process_Para SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:28:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200260
;

-- Mar 13, 2019 7:28:22 PM CET
UPDATE AD_Process_Para SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:28:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200261
;

-- Mar 13, 2019 7:28:27 PM CET
UPDATE AD_Process_Para SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:28:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200263
;

-- Mar 13, 2019 7:29:49 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:29:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5664
;

-- Mar 13, 2019 7:29:51 PM CET
-- ALTER TABLE AD_PInstance_Para MODIFY Info VARCHAR2(4000) DEFAULT NULL 
ALTER TABLE AD_PInstance_Para ADD Tmp_Info VARCHAR2(4000) DEFAULT NULL;
UPDATE AD_PInstance_Para SET Tmp_Info = Info;
ALTER TABLE AD_PInstance_Para DROP COLUMN Info;
ALTER TABLE AD_PInstance_Para RENAME COLUMN Tmp_Info TO Info;

-- Mar 13, 2019 7:29:59 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:29:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5665
;

-- Mar 13, 2019 7:30:00 PM CET
-- ALTER TABLE AD_PInstance_Para MODIFY Info_To VARCHAR2(4000) DEFAULT NULL 
ALTER TABLE AD_PInstance_Para ADD Tmp_Info_To VARCHAR2(4000) DEFAULT NULL;
UPDATE AD_PInstance_Para SET Tmp_Info_To = Info_To;
ALTER TABLE AD_PInstance_Para DROP COLUMN Info_To;
ALTER TABLE AD_PInstance_Para RENAME COLUMN Tmp_Info_To TO Info_To;

-- Mar 13, 2019 7:30:20 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:30:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2791
;

-- Mar 13, 2019 7:30:21 PM CET
-- ALTER TABLE AD_PInstance_Para MODIFY P_String VARCHAR2(4000) DEFAULT NULL 
ALTER TABLE AD_PInstance_Para ADD Tmp_P_String VARCHAR2(4000) DEFAULT NULL;
UPDATE AD_PInstance_Para SET Tmp_P_String = P_String;
ALTER TABLE AD_PInstance_Para DROP COLUMN P_String;
ALTER TABLE AD_PInstance_Para RENAME COLUMN Tmp_P_String TO P_String;

-- Mar 13, 2019 7:30:28 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_DATE('2019-03-13 19:30:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2792
;

-- Mar 13, 2019 7:30:30 PM CET
-- ALTER TABLE AD_PInstance_Para MODIFY P_String_To VARCHAR2(4000) DEFAULT NULL 
ALTER TABLE AD_PInstance_Para ADD Tmp_P_String_To VARCHAR2(4000) DEFAULT NULL;
UPDATE AD_PInstance_Para SET Tmp_P_String_To = P_String_To;
ALTER TABLE AD_PInstance_Para DROP COLUMN P_String_To;
ALTER TABLE AD_PInstance_Para RENAME COLUMN Tmp_P_String_To TO P_String_To;

SELECT register_migration_script('201903131326_IDEMPIERE-3916.sql') FROM dual
;

