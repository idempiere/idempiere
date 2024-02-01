-- IDEMPIERE-6019 Add query to help finding customizations to official dictionary
SELECT register_migration_script('202401271444_IDEMPIERE-6019.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 27, 2024, 2:39:14 PM CET
INSERT INTO AD_UserQuery (AD_UserQuery_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_User_ID,AD_Table_ID,Code,AD_Tab_ID,AD_UserQuery_UU,AD_Window_ID,IsDefault) VALUES (200001,0,0,'Y',TO_TIMESTAMP('2024-01-27 14:39:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-27 14:39:14','YYYY-MM-DD HH24:MI:SS'),100,'Customizations to Official Dict','This query shows the customizations made to official entries in the dictionary',100,580,'@SQL=AD_ChangeLog.AD_Client_ID = 0
AND AD_ChangeLog.AD_Table_ID<=999999
AND AD_ChangeLog.Record_ID<=999999
AND AD_ChangeLog.EventChangeLog = ''U''
AND AD_ChangeLog.AD_ChangeLog_ID = 
(SELECT MAX(clm.AD_ChangeLog_ID)  
   FROM AD_ChangeLog clm 
   WHERE AD_ChangeLog.AD_Client_ID = clm.AD_Client_ID
     AND AD_ChangeLog.AD_Table_ID = clm.AD_Table_ID 
     AND AD_ChangeLog.Record_ID = clm.Record_ID
     AND AD_ChangeLog.AD_Column_ID = clm.AD_Column_ID
     AND AD_ChangeLog.EventChangeLog = clm.EventChangeLog)',488,'fce7dfc0-eae7-45e1-b4ea-9e461f06c4f0',270,'N')
;

-- Jan 27, 2024, 2:44:54 PM CET
UPDATE AD_UserQuery SET AD_User_ID=NULL, AD_Role_ID=0,Updated=TO_TIMESTAMP('2024-01-27 14:44:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_UserQuery_ID=200001
;

