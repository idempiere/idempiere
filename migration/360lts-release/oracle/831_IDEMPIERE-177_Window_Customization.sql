-- Apr 4, 2012 10:13:06 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET IsIdentifier='N',Updated=TO_DATE('2012-04-04 10:13:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6396
;

-- Apr 4, 2012 10:13:09 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Win MODIFY Name NVARCHAR2(60) DEFAULT NULL 
;

-- Apr 4, 2012 10:13:10 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Win MODIFY Name NULL
;

-- Apr 4, 2012 10:13:27 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=1,Updated=TO_DATE('2012-04-04 10:13:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6395
;

-- Apr 4, 2012 10:18:27 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET IsIdentifier='N',Updated=TO_DATE('2012-04-04 10:18:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6381
;

-- Apr 4, 2012 10:18:29 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Tab MODIFY Name NVARCHAR2(60) DEFAULT NULL 
;

-- Apr 4, 2012 10:18:30 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Tab MODIFY Name NULL
;

-- Apr 4, 2012 10:18:47 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=1,Updated=TO_DATE('2012-04-04 10:18:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6380
;

-- Apr 4, 2012 10:26:05 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET AD_Val_Rule_ID=158,Updated=TO_DATE('2012-04-04 10:26:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13425
;

-- Apr 4, 2012 10:26:36 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Field MODIFY DisplayLogic NVARCHAR2(2000) DEFAULT NULL
;

-- Apr 4, 2012 10:26:36 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Field MODIFY DisplayLogic NULL
;

-- Apr 4, 2012 10:29:08 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-04-04 10:29:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6351
;

-- Apr 4, 2012 10:29:11 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Field MODIFY DisplayLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Apr 4, 2012 10:44:18 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET IsIdentifier='N',Updated=TO_DATE('2012-04-04 10:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6346
;

-- Apr 4, 2012 10:44:21 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Field MODIFY Name NVARCHAR2(60) DEFAULT NULL 
;

-- Apr 4, 2012 10:44:21 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
ALTER TABLE AD_UserDef_Field MODIFY Name NULL
;

-- Apr 4, 2012 10:44:36 AM COT
-- IDEMPIERE-177 Complete Window Customization functionality
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=1,Updated=TO_DATE('2012-04-04 10:44:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6345
;

UPDATE AD_System
  SET LastMigrationScriptApplied='831_IDEMPIERE-177_Window_Customization.sql'
WHERE LastMigrationScriptApplied<'831_IDEMPIERE-177_Window_Customization.sql'
   OR LastMigrationScriptApplied IS NULL
;
