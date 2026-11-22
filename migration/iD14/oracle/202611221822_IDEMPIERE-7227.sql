-- IDEMPIERE-7227 Show related orders and invoices on Business Partner Info
SELECT register_migration_script('202611221822_IDEMPIERE-7227.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 22, 2026, 6:22:30 PM CET
INSERT INTO AD_InfoRelated (AD_InfoRelated_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,SeqNo,RelatedInfo_ID,RelatedColumn_ID,AD_InfoRelated_UU,EntityType) VALUES (200001,0,0,'Y',TO_TIMESTAMP('2026-11-22 18:22:29','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-22 18:22:29','YYYY-MM-DD HH24:MI:SS'),10,'Orders',200001,10,200002,200039,'01a20447-e4ba-70f1-8d28-488dcf9ecf54','D')
;

-- Nov 22, 2026, 6:22:41 PM CET
INSERT INTO AD_InfoRelated (AD_InfoRelated_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,SeqNo,RelatedInfo_ID,RelatedColumn_ID,AD_InfoRelated_UU,EntityType) VALUES (200002,0,0,'Y',TO_TIMESTAMP('2026-11-22 18:22:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-22 18:22:40','YYYY-MM-DD HH24:MI:SS'),10,'Invoices',200001,20,200003,200052,'01a20448-0eec-7d67-80b5-ad37460d3e26','D')
;

-- Nov 22, 2026, 6:37:07 PM CET
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete,IsQueryAfterChange,IsRange) VALUES (200316,0,0,'Y',TO_TIMESTAMP('2026-11-22 18:37:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-22 18:37:07','YYYY-MM-DD HH24:MI:SS'),100,'IsNotOpenAsRelated','Dummy query criteria just to set the variable IsNotOpenAsRelated=Y',200002,'D','NULL',150,'N','Y',20,'01a20455-47b4-7663-8864-8b183b6cd72c','Y','1=0','IsNotOpenAsRelated','=','Y','N',100,'Y','N','N','Y','N','N','N')
;

-- Nov 22, 2026, 6:37:27 PM CET
UPDATE AD_InfoColumn SET DisplayLogic='@IsNotOpenAsRelated@=Y',Updated=TO_TIMESTAMP('2026-11-22 18:37:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200039
;

-- Nov 22, 2026, 6:39:36 PM CET
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete,IsQueryAfterChange,IsRange) VALUES (200317,0,0,'Y',TO_TIMESTAMP('2026-11-22 18:39:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-22 18:39:36','YYYY-MM-DD HH24:MI:SS'),100,'IsNotOpenAsRelated','Dummy query criteria just to set the variable IsNotOpenAsRelated=Y',200003,'D','NULL',200,'N','Y',20,'01a20457-8d65-71e3-b9ea-4c107dd39165','Y','1=0','IsNotOpenAsRelated','=','Y','N',100,'Y','N','N','Y','N','N','N')
;

-- Nov 22, 2026, 6:39:56 PM CET
UPDATE AD_InfoColumn SET DisplayLogic='@IsNotOpenAsRelated@=Y',Updated=TO_TIMESTAMP('2026-11-22 18:39:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200052
;

-- Nov 22, 2026, 6:46:42 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=110,Updated=TO_TIMESTAMP('2026-11-22 18:46:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200316
;

-- Nov 22, 2026, 6:48:17 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=110,Updated=TO_TIMESTAMP('2026-11-22 18:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200317
;

