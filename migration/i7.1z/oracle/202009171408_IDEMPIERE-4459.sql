SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4459
-- Sep 17, 2020, 2:08:23 PM CEST
UPDATE AD_Column SET DefaultValue=NULL, IsMandatory='N', AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2020-09-17 14:08:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214313
;

-- Sep 17, 2020, 2:08:24 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsAutocomplete CHAR(1) DEFAULT NULL 
;

-- Sep 17, 2020, 2:08:25 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsAutocomplete NULL
;

-- Sep 17, 2020, 2:09:27 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-17 14:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Sep 17, 2020, 2:09:58 PM CEST
UPDATE AD_Column SET IsMandatory='N', AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2020-09-17 14:09:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214309
;

-- Sep 17, 2020, 2:09:59 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsReadOnly CHAR(1) DEFAULT NULL 
;

-- Sep 17, 2020, 2:09:59 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsReadOnly NULL
;

-- Sep 17, 2020, 2:10:16 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-17 14:10:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206464
;

-- Sep 17, 2020, 2:12:07 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-17 14:12:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206498
;

SELECT register_migration_script('202009171408_IDEMPIERE-4459.sql') FROM dual
;
