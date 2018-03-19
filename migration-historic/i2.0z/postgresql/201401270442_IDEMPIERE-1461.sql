-- Jan 27, 2014 11:46:20 AM MYT
-- IDEMPIERE-1461 Zoom Condition doesn't work on empty fields
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Window_ID,AD_ZoomCondition_ID,AD_ZoomCondition_UU,Created,CreatedBy,IsActive,Name,SeqNo,Updated,UpdatedBy,WhereClause,ZoomLogic) VALUES (0,0,259,143,200005,'2f15e1d6-73d3-417b-abc9-ef38c730cc4e',TO_TIMESTAMP('2014-01-27 11:46:18','YYYY-MM-DD HH24:MI:SS'),100,'Y','Sales Order',10,TO_TIMESTAMP('2014-01-27 11:46:18','YYYY-MM-DD HH24:MI:SS'),100,'''SOO'' = (SELECT DocBaseType FROM C_DocType WHERE C_DocType_ID=C_Order.C_DocTypeTarget_ID AND AD_Client_ID = C_Order.AD_Client_ID)','@IsSOTrx@=Y')
;

-- Jan 27, 2014 11:47:09 AM MYT
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Window_ID,AD_ZoomCondition_ID,AD_ZoomCondition_UU,Created,CreatedBy,IsActive,Name,SeqNo,Updated,UpdatedBy,WhereClause,ZoomLogic) VALUES (0,0,259,181,200006,'5b6bd15a-f074-47a0-822c-3b8a2ea39239',TO_TIMESTAMP('2014-01-27 11:47:07','YYYY-MM-DD HH24:MI:SS'),100,'Y','Purchase Order',20,TO_TIMESTAMP('2014-01-27 11:47:07','YYYY-MM-DD HH24:MI:SS'),100,'''POO'' = (SELECT DocBaseType FROM C_DocType WHERE C_DocType_ID=C_Order.C_DocTypeTarget_ID AND AD_Client_ID = C_Order.AD_Client_ID)','@IsSOTrx@=N')
;

-- Jan 27, 2014 11:53:11 AM MYT
UPDATE AD_Field SET DefaultValue='N',Updated=TO_TIMESTAMP('2014-01-27 11:53:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3499
;

SELECT register_migration_script('201401270442_IDEMPIERE-1461.sql') FROM dual
;

