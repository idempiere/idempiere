SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4542 Cannot report from window _My Unprocessed Documents_
-- Nov 12, 2020, 11:05:07 AM CET
UPDATE PA_DocumentStatus SET WhereClause='RV_Unprocessed.AD_Client_ID=@#AD_Client_ID@ AND RV_Unprocessed.CreatedBy=@#AD_User_ID@',Updated=TO_DATE('2020-11-12 11:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200005
;

-- Nov 12, 2020, 11:36:21 AM CET
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_DATE('2020-11-12 11:36:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200223
;

-- Nov 12, 2020, 11:38:45 AM CET
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_DATE('2020-11-12 11:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200191
;

-- Nov 12, 2020, 11:40:02 AM CET
UPDATE PA_DocumentStatus SET WhereClause='AD_Note.AD_Client_ID=@#AD_Client_ID@ AND AD_Note.AD_User_ID IN (0,@#AD_User_ID@) AND AD_Note.Processed=''N'' AND AD_Note.AD_BroadcastMessage_ID IS NULL',Updated=TO_DATE('2020-11-12 11:40:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200002
;

-- Nov 12, 2020, 11:40:43 AM CET
UPDATE PA_DocumentStatus SET WhereClause='(R_Request.SalesRep_ID=@#AD_User_ID@ OR R_Request.AD_Role_ID=@#AD_Role_ID@) AND R_Request.Processed=''N'' AND (R_Request.DateNextAction IS NULL OR TRUNC(R_Request.DateNextAction) <= TRUNC(SysDate)) AND (R_Request.R_Status_ID IS NULL OR R_Request.R_Status_ID IN (SELECT R_Status.R_Status_ID FROM R_Status WHERE R_Status.IsClosed=''N''))',Updated=TO_DATE('2020-11-12 11:40:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200003
;

SELECT register_migration_script('202011121113_IDEMPIERE-4542.sql') FROM dual
;

