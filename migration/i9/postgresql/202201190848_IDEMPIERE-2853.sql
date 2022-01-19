-- IDEMPIERE-2853 Panel tab as a factory
-- Jan 18, 2022, 9:01:14 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@=SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-18 21:01:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5709
;

-- Jan 19, 2022, 8:58:22 AM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@=SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-19 08:58:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5708
;

-- Jan 19, 2022, 8:59:04 AM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@!SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-19 08:59:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1546
;

-- Jan 19, 2022, 8:59:21 AM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@!SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-19 08:59:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;

-- Jan 19, 2022, 1:11:36 PM CET
UPDATE AD_ToolBarButton SET DisplayLogic='@AD_TabType@!SORT & @IsActive@=Y',Updated=TO_TIMESTAMP('2022-01-19 13:11:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200068
;

SELECT register_migration_script('202201190848_IDEMPIERE-2853.sql') FROM dual
;
