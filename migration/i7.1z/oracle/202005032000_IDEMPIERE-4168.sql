SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4168 Move Webstore out of core
-- May 3, 2020, 1:18:52 PM MYT
INSERT INTO AD_EntityType (EntityType,AD_Client_ID,AD_Org_ID,AD_EntityType_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Processing,AD_EntityType_UU) VALUES ('WSTORE',0,0,200015,'Y',TO_DATE('2020-05-03 13:18:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-03 13:18:51','YYYY-MM-DD HH24:MI:SS'),100,'Web Store','N','74d37167-4cda-415c-b70c-719669a42418')
;

-- May 3, 2020, 1:37:47 PM MYT
UPDATE AD_Column SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13700
;

UPDATE AD_Field SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13700
;

UPDATE AD_Table SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE TableName LIKE 'W\_%' AND EntityType='D'
;

UPDATE AD_Column SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE EntityType='D'
AND AD_Table_ID IN (SELECT AD_Table_ID FROM AD_Table WHERE EntityType='WSTORE' AND TableName LIKE 'W\_%')
;

UPDATE AD_Column SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE EntityType='D'
AND ColumnName LIKE 'W\_%' AND AD_Reference_ID IN (18,19,30)
;

UPDATE AD_Field SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE EntityType='D'
AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE EntityType = 'WSTORE')
;

UPDATE AD_Tab SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE EntityType='D'
AND AD_Table_ID IN (SELECT AD_Table_ID FROM AD_Table WHERE EntityType='WSTORE')
;

UPDATE AD_Window SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE EntityType='D'
AND AD_Window_ID IN (SELECT AD_Window_ID FROM AD_Tab WHERE EntityType='WSTORE')
;

UPDATE AD_Menu SET EntityType='WSTORE',Updated=TO_DATE('2020-05-03 13:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE EntityType='D'
AND AD_Window_ID IN (SELECT AD_Window_ID FROM AD_Window WHERE EntityType='WSTORE')
;

SELECT register_migration_script('202005032000_IDEMPIERE-4168.sql') FROM dual
;

