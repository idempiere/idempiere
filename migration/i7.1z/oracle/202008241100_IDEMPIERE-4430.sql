SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 24, 2020, 11:30:58 AM MYT
-- IDEMPIERE-4430 Process_Production workflow missing transition node from start to docprepare
INSERT INTO AD_WF_NodeNext (AD_WF_NodeNext_ID,Created,Updated,AD_Client_ID,AD_Org_ID,SeqNo,EntityType,Description,IsStdUserWorkflow,AD_WF_Next_ID,UpdatedBy,CreatedBy,IsActive,AD_WF_NodeNext_UU,AD_WF_Node_ID) VALUES (200026,TO_DATE('2020-08-24 11:30:57','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2020-08-24 11:30:57','YYYY-MM-DD HH24:MI:SS'),0,0,10,'D','(Standard Approval)','Y',200010,100,100,'Y','65720e30-02c5-4861-a25f-3d860ac4565f',200011)
;

-- Aug 24, 2020, 11:20:02 AM CEST
UPDATE AD_WF_NodeNext SET Description='(Standard Transition)',Updated=TO_DATE('2020-08-24 11:20:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_NodeNext_ID=200008
;

-- Aug 24, 2020, 11:20:43 AM CEST
UPDATE AD_WF_NodeNext SET IsActive='Y', SeqNo=100, Description='(Standard Transition)',Updated=TO_DATE('2020-08-24 11:20:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_NodeNext_ID=200007
;

SELECT register_migration_script('202008241100_IDEMPIERE-4430.sql') FROM dual
;

