-- Jan 29, 2013 4:07:24 PM PST
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_WF_NodeNext SET IsActive='N',Updated=TO_DATE('2013-01-29 16:07:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_NodeNext_ID=171
;

-- Jan 29, 2013 4:07:44 PM PST
UPDATE AD_WF_NodeNext SET IsActive='N',Updated=TO_DATE('2013-01-29 16:07:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_NodeNext_ID=50075
;

-- Jan 29, 2013 4:08:08 PM PST
INSERT INTO AD_WF_NodeNext (SeqNo,EntityType,IsStdUserWorkflow,AD_WF_Node_ID,AD_WF_NodeNext_ID,AD_WF_Next_ID,AD_WF_NodeNext_UU,UpdatedBy,AD_Org_ID,CreatedBy,Updated,AD_Client_ID,Created,IsActive) VALUES (10,'D','N',171,200000,161,'53e71f53-8568-40bd-bc97-264121dbaf57',100,0,100,TO_DATE('2013-01-29 16:08:07','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-01-29 16:08:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 29, 2013 4:08:16 PM PST
UPDATE AD_WF_NodeNext SET SeqNo=1,Updated=TO_DATE('2013-01-29 16:08:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_NodeNext_ID=200000
;

SELECT register_migration_script('201301291609_IDEMPIERE-362.sql') FROM dual
;

