SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2675 Supporting tree on any custom table
-- Aug 5, 2015 11:07:44 AM COT
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_DATE('2015-08-05 11:07:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=888
;

-- Aug 5, 2015 11:07:47 AM COT
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_DATE('2015-08-05 11:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=891
;

-- Aug 5, 2015 11:07:52 AM COT
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_DATE('2015-08-05 11:07:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=889
;

-- Aug 5, 2015 11:07:55 AM COT
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_DATE('2015-08-05 11:07:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=890
;

-- Aug 5, 2015 11:15:48 AM COT
UPDATE AD_Tree SET IsActive='N', IsDefault='N',Updated=TO_DATE('2015-08-05 11:15:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=115
;

-- Aug 5, 2015 11:15:59 AM COT
UPDATE AD_Tree SET IsActive='N', IsDefault='N',Updated=TO_DATE('2015-08-05 11:15:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=118
;

-- Aug 5, 2015 11:16:01 AM COT
UPDATE AD_Tree SET IsActive='N', IsDefault='N',Updated=TO_DATE('2015-08-05 11:16:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=116
;

-- Aug 5, 2015 11:16:04 AM COT
UPDATE AD_Tree SET IsActive='N', IsDefault='N',Updated=TO_DATE('2015-08-05 11:16:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=117
;

-- Aug 5, 2015 11:25:19 AM COT
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2015-08-05 11:25:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212212
;

-- Aug 5, 2015 11:25:59 AM COT
UPDATE AD_Column SET MandatoryLogic='@TreeType@=''TL''',Updated=TO_DATE('2015-08-05 11:25:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212212
;

-- Aug 5, 2015 11:29:40 AM COT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200083,'AD_Table with IsSummary','S','EXISTS (SELECT * FROM AD_Column c WHERE AD_Table.AD_Table_ID=c.AD_Table_ID AND c.ColumnName=''IsSummary'' AND c.IsActive=''Y'') AND AD_Table.IsView=''N''',0,0,'Y',TO_DATE('2015-08-05 11:29:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-05 11:29:39','YYYY-MM-DD HH24:MI:SS'),100,'D','8a00a911-354b-40c8-9cfa-a40ec65df11d')
;

-- Aug 5, 2015 11:29:51 AM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200083,Updated=TO_DATE('2015-08-05 11:29:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212212
;

SELECT register_migration_script('201508051109_IDEMPIERE-2675.sql') FROM dual
;

