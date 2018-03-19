-- Apr 10, 2013 9:43:29 AM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere / restore resource type window original from Compiere
UPDATE AD_Menu SET EntityType='D', IsActive='Y',Updated=TO_DATE('2013-04-10 09:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=320
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=53017, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53018
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=319
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=320
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=369
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=317
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=318
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=327
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=328
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=349
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=329
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=284
;

-- Apr 10, 2013 9:43:43 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=344
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=320
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=319
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=369
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=317
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=318
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=327
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=328
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=349
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=329
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=284
;

-- Apr 10, 2013 9:43:45 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=271, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=344
;

SELECT register_migration_script('201304100945_IDEMPIERE-362.sql') FROM dual
;

