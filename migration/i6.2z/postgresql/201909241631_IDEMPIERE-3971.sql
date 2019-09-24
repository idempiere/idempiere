-- IDEMPIERE-3971 Copy the link to this issue  Process Customization
-- Sep 24, 2019, 4:23:34 PM CEST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2019-09-24 16:23:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200232
;

-- Sep 24, 2019, 4:23:37 PM CEST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2019-09-24 16:23:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200233
;

-- Sep 24, 2019, 4:25:21 PM CEST
UPDATE AD_Window SET Description='Define Process Customization for Role/User', Help='The customization values defined here overwrite/replace the default system definition if defined.',Updated=TO_TIMESTAMP('2019-09-24 16:25:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200095
;

-- Sep 24, 2019, 4:25:21 PM CEST
UPDATE AD_Menu SET Name='Process Customization', Description='Define Process Customization for Role/User', IsActive='Y',Updated=TO_TIMESTAMP('2019-09-24 16:25:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200150
;

-- Sep 24, 2019, 4:29:43 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-09-24 16:29:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205274
;

-- Sep 24, 2019, 4:29:43 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-09-24 16:29:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205261
;

-- Sep 24, 2019, 4:35:49 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-09-24 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205275
;

-- Sep 24, 2019, 4:35:52 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-09-24 16:35:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205270
;

-- Sep 24, 2019, 4:35:54 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-09-24 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205276
;

-- Sep 24, 2019, 4:35:56 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-09-24 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205269
;

-- Sep 24, 2019, 4:38:44 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-09-24 16:38:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5052
;

-- Sep 24, 2019, 4:40:10 PM CEST
UPDATE AD_Column SET DefaultValue=NULL, AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_TIMESTAMP('2019-09-24 16:40:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213291
;

-- Sep 24, 2019, 4:40:12 PM CEST
INSERT INTO t_alter_column values('ad_userdef_proc_parameter','IsDisplayed','CHAR(1)',null,'NULL')
;

-- Sep 24, 2019, 4:45:30 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-09-24 16:45:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

SELECT register_migration_script('201909241631_IDEMPIERE-3971.sql') FROM dual
;

