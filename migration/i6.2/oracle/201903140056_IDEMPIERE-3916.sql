SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3916 Process to migrate IDs
-- Mar 14, 2019 12:43:30 AM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200111,0,0,'Y',TO_DATE('2019-03-14 00:43:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:43:29','YYYY-MM-DD HH24:MI:SS'),100,'Migrate ID','Process to migrate an ID or a UUID','N','MigrateID','N','org.idempiere.process.MigraID','4','D',0,0,'N','N','Y','N','81e52777-5d7b-4a5b-b5e2-c7a4a15c38d8')
;

-- Mar 14, 2019 12:43:43 AM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200169,'Migrate ID','Process to migrate an ID or a UUID','P',0,0,'Y',TO_DATE('2019-03-14 00:43:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:43:43','YYYY-MM-DD HH24:MI:SS'),100,'N',200111,'Y','N','D','Y','f5af6aa0-8dfc-4274-a304-7a5c969b2ec8')
;

-- Mar 14, 2019 12:43:43 AM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200169, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200169)
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000016
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000036
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000095
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000091
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 14, 2019 12:44:04 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 14, 2019 12:47:49 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200165,'AD_Table with ID Column','T',0,0,'Y',TO_DATE('2019-03-14 00:47:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:47:48','YYYY-MM-DD HH24:MI:SS'),100,'D','N','5fc414bf-781e-4171-a543-6aa057de1a58')
;

-- Mar 14, 2019 12:49:52 AM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,OrderByClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200165,100,100,102,'AD_Table.IsView=''N'' AND AD_Table.IsActive=''Y'' AND EXISTS (SELECT 1 FROM AD_Column c WHERE c.AD_Table_ID=AD_Table.AD_Table_ID AND c.ColumnName=AD_Table.TableName||''_ID'' AND c.IsActive=''Y'')','AD_Table.TableName',0,0,'Y',TO_DATE('2019-03-14 00:49:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:49:52','YYYY-MM-DD HH24:MI:SS'),100,'N','D','62fe46c3-2b6f-4c6b-8f0d-fa05cae312c9')
;

-- Mar 14, 2019 12:50:02 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200264,0,0,'Y',TO_DATE('2019-03-14 00:50:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:50:02','YYYY-MM-DD HH24:MI:SS'),100,'Table','Database Table information','The Database Table provides the information of the table definition',200111,10,30,200165,'N',22,'Y','AD_Table_ID','Y','D',126,'6411cc15-450e-43b5-886e-1d510552b951','N')
;

-- Mar 14, 2019 12:51:17 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200265,0,0,'Y',TO_DATE('2019-03-14 00:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:51:16','YYYY-MM-DD HH24:MI:SS'),100,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200111,20,11,'N',22,'Y','Record_ID','Y','D',538,'e1d21139-e7d0-4501-a693-c448f4f10ae1','N')
;

-- Mar 14, 2019 12:51:47 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203299,0,0,'Y',TO_DATE('2019-03-14 00:51:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:51:25','YYYY-MM-DD HH24:MI:SS'),100,'To_Record_ID','To Record ID',NULL,NULL,'To Record ID','D','355c16ed-7b65-4d77-9802-a308e6ac24f2')
;

-- Mar 14, 2019 12:51:58 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200266,0,0,'Y',TO_DATE('2019-03-14 00:51:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:51:57','YYYY-MM-DD HH24:MI:SS'),100,'To Record ID',200111,30,11,'N',22,'N','To_Record_ID','Y','D',203299,'5b115049-5cf3-4059-938e-9e9f26f05e37','N')
;

-- Mar 14, 2019 12:54:00 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,MandatoryLogic) VALUES (200267,0,0,'Y',TO_DATE('2019-03-14 00:54:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:54:00','YYYY-MM-DD HH24:MI:SS'),100,'Source UUID','UUID from the source client',200111,40,10,'N',36,'N','@Record_ID:0@=0','Source_UUID','Y','D',202602,'cff91029-d160-4577-8192-6c2eef52be11','N','@Record_ID:0@=0')
;

-- Mar 14, 2019 12:54:18 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,MandatoryLogic) VALUES (200268,0,0,'Y',TO_DATE('2019-03-14 00:54:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-14 00:54:17','YYYY-MM-DD HH24:MI:SS'),100,'Target UUID','New UUID created by the pack in client',200111,50,10,'N',36,'N','@Record_ID:0@=0','Target_UUID','Y','D',202603,'442badef-4200-45e3-9850-c62b4fdc6631','N',NULL)
;

-- Mar 14, 2019 12:54:55 AM CET
UPDATE AD_Process_Para SET IsMandatory='N', DisplayLogic='@Source_UUID@=''''', MandatoryLogic='@Source_UUID@=''''',Updated=TO_DATE('2019-03-14 00:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200265
;

-- Mar 14, 2019 12:55:03 AM CET
UPDATE AD_Process_Para SET DisplayLogic='@Source_UUID@=''''',Updated=TO_DATE('2019-03-14 00:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200266
;

-- Mar 14, 2019 12:55:11 AM CET
UPDATE AD_Process_Para SET DefaultValue=NULL, DisplayLogic='@Record_ID:0@=0',Updated=TO_DATE('2019-03-14 00:55:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200267
;

-- Mar 14, 2019 12:55:18 AM CET
UPDATE AD_Process_Para SET DefaultValue=NULL, DisplayLogic='@Record_ID:0@=0',Updated=TO_DATE('2019-03-14 00:55:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200268
;

SELECT register_migration_script('201903140056_IDEMPIERE-3916.sql') FROM dual
;

