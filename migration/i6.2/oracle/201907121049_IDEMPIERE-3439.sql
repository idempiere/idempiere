SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3439 Create System windows to analyze all clients and users
-- Jul 12, 2019, 10:42:21 AM CEST
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206017
;

-- Jul 12, 2019, 10:42:21 AM CEST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206016
;

-- Jul 12, 2019, 10:42:21 AM CEST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=206033
;

-- Jul 12, 2019, 10:42:49 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-07-12 10:42:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206017
;

-- Jul 12, 2019, 10:42:49 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2019-07-12 10:42:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206033
;

-- Jul 12, 2019, 10:45:02 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-07-12 10:45:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206033
;

SELECT register_migration_script('201907121049_IDEMPIERE-3439.sql') FROM dual
;

