SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3057 2Pack handler for SQL Statements that must not fail
-- Mar 22, 2016 5:34:50 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200356,'SQL Mandatory',50004,'SQM',0,0,'Y',TO_DATE('2016-03-22 17:34:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-22 17:34:50','YYYY-MM-DD HH24:MI:SS'),100,'D','63605262-3ba3-4140-b839-4e5b0f8ad23d')
;

-- Mar 22, 2016 5:35:42 PM CET
UPDATE AD_Field SET DisplayLogic='@Type@=''D''|Type@=''SQL''|Type@=''SQM''',Updated=TO_DATE('2016-03-22 17:35:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50105
;

-- Mar 22, 2016 5:39:53 PM CET
UPDATE AD_Field SET DisplayLogic='@Type@=''SQL''|@Type@=''SQM''',Updated=TO_DATE('2016-03-22 17:39:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50104
;

SELECT register_migration_script('201603221737_IDEMPIERE-3057.sql') FROM dual
;

