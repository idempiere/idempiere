-- IDEMPIERE-2853 : Correction Display Logic
-- Sep 7, 2021, 7:41:48 PM IST
UPDATE AD_ToolBarButton SET DisplayLogic='@IsActive@=Y & @AD_TabType@!SORT',Updated=TO_TIMESTAMP('2021-09-07 19:41:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200068
;

-- Sep 7, 2021, 7:44:21 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@=SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-09-07 19:44:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5709
;

-- Sep 7, 2021, 7:44:40 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@=SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-09-07 19:44:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5708
;

-- Sep 7, 2021, 7:44:53 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@!SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-09-07 19:44:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1546
;

-- Sep 7, 2021, 7:45:22 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_TabType@!SORT', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-09-07 19:45:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;


SELECT register_migration_script('202109031744_IDEMPIERE-2853.sql') FROM dual
;
