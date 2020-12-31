-- Dec 15, 2020, 4:07:23 PM CET
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200015,0,0,'Y',TO_TIMESTAMP('2020-12-15 16:07:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-12-15 16:07:23','YYYY-MM-DD HH24:MI:SS'),100,'Plugin Manager','Plugin Manager','Plugin Manager','org.adempiere.webui.apps.form.WPluginManager','4','D','N','4641c756-4c24-4c2f-9c27-f62c86f0b940')
;

-- Dec 15, 2020, 4:07:52 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,AD_Form_ID,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200177,'Plugin Manager','X',0,0,'Y',TO_TIMESTAMP('2020-12-15 16:07:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-12-15 16:07:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200015,'N','D','Y','bb2ed8f6-2189-4d23-bf95-2a42abac4e64')
;

-- Dec 15, 2020, 4:07:52 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200177, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200177)
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Dec 15, 2020, 4:08:26 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200177
;

SELECT register_migration_script('202012151609_IDEMPIERE-4601.sql') FROM dual
;

