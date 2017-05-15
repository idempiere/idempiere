SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3338 Document Status Indicator
-- Apr 13, 2017 1:36:25 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2017-04-13 13:36:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212997
;

-- Apr 13, 2017 1:36:26 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Name_PrintColor_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 13, 2017 1:36:26 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Name_PrintColor_ID NULL
;

-- Apr 13, 2017 1:36:34 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2017-04-13 13:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212998
;

-- Apr 13, 2017 1:36:35 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Name_PrintFont_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 13, 2017 1:36:35 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Name_PrintFont_ID NULL
;

-- Apr 13, 2017 1:36:40 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2017-04-13 13:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212999
;

-- Apr 13, 2017 1:36:41 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Number_PrintColor_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 13, 2017 1:36:41 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Number_PrintColor_ID NULL
;

-- Apr 13, 2017 1:36:47 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2017-04-13 13:36:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213000
;

-- Apr 13, 2017 1:36:48 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Number_PrintFont_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 13, 2017 1:36:48 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY Number_PrintFont_ID NULL
;

-- Apr 13, 2017 1:49:23 PM CEST
UPDATE PA_DocumentStatus SET Name_PrintColor_ID=NULL, Name_PrintFont_ID=NULL, Number_PrintColor_ID=NULL, Number_PrintFont_ID=NULL,Updated=TO_DATE('2017-04-13 13:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200002
;

-- Apr 13, 2017 1:49:30 PM CEST
UPDATE PA_DocumentStatus SET Name_PrintColor_ID=NULL, Name_PrintFont_ID=NULL, Number_PrintColor_ID=NULL, Number_PrintFont_ID=NULL,Updated=TO_DATE('2017-04-13 13:49:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200003
;

-- Apr 13, 2017 1:49:36 PM CEST
UPDATE PA_DocumentStatus SET Name_PrintColor_ID=NULL, Name_PrintFont_ID=NULL, Number_PrintColor_ID=NULL, Number_PrintFont_ID=NULL,Updated=TO_DATE('2017-04-13 13:49:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200004
;

-- Apr 13, 2017 1:49:43 PM CEST
UPDATE PA_DocumentStatus SET Name_PrintColor_ID=NULL, Name_PrintFont_ID=NULL, Number_PrintColor_ID=NULL, Number_PrintFont_ID=NULL,Updated=TO_DATE('2017-04-13 13:49:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200005
;

SELECT register_migration_script('201704131337_IDEMPIERE-3338.sql') FROM dual
;

