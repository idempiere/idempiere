SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2395 NoteDelete leaving orphan attachments
-- Oct 6, 2018 11:05:15 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200102,0,0,'Y',TO_DATE('2018-10-06 23:05:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-10-06 23:05:15','YYYY-MM-DD HH24:MI:SS'),100,'Clean Orphan Cascade Records','Some processes accessing directly the database can leave orphan records, this process clean those orphan records deleting them','N','CleanOrphanCascade','N','org.idempiere.process.CleanOrphanCascade','4','D',0,0,'N','N','Y','N','d3826a84-1467-4d6e-931b-e395f349f60c')
;

-- Oct 6, 2018 11:05:55 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200161,'Clean Orphan Cascade Records','P',0,0,'Y',TO_DATE('2018-10-06 23:05:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-10-06 23:05:55','YYYY-MM-DD HH24:MI:SS'),100,'N',200102,'Y','N','D','Y','67e5ec6c-93d0-47f9-bd45-f0d60d552b16')
;

-- Oct 6, 2018 11:05:55 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200161, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200161)
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Oct 6, 2018 11:07:01 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200161
;

SELECT register_migration_script('201810062307_IDEMPIERE-2395.sql') FROM dual
;

