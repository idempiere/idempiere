SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2853 Panel tab as a factory 
-- preserve AD_Tab.IsSortTab for backward compatibility
-- Sep 17, 2021, 2:24:03 PM CEST
UPDATE AD_Field SET IsDisplayed='N', IsActive='Y', IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_DATE('2021-09-17 14:24:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5707
;

UPDATE AD_Tab SET IsSortTab='Y' WHERE AD_TabType='SORT' AND (IsSortTab IS NULL OR IsSortTab!='Y');

UPDATE AD_Tab SET IsSortTab='N' WHERE AD_TabType!='SORT' AND (IsSortTab IS NULL OR IsSortTab!='N');

SELECT register_migration_script('202109171424_IDEMPIERE-2853.sql') FROM dual
;

