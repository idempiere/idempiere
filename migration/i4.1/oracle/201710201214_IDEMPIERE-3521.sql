SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3521 InfoWindow problem on other SQL when make a register count
-- Oct 20, 2017 12:13:41 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-10-20 12:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201634
;

-- Oct 20, 2017 12:13:43 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-10-20 12:13:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13579
;

SELECT register_migration_script('201710201214_IDEMPIERE-3521.sql') FROM dual
;

