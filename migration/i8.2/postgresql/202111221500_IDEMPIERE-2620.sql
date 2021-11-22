-- IDEMPIERE-2620 Customer Drop Ships not implemented
-- Nov 22, 2021, 2:57:04 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@IsDropShip@=''Y''', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-22 14:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55410
;

-- Nov 22, 2021, 2:57:13 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@IsDropShip@=''Y''', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-22 14:57:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55411
;

-- Nov 22, 2021, 2:57:56 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@IsDropShip@=''Y''', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-22 14:57:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55429
;

-- Nov 22, 2021, 2:58:03 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@IsDropShip@=''Y''', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-22 14:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55430
;

SELECT register_migration_script('202111221500_IDEMPIERE-2620.sql') FROM dual
;

