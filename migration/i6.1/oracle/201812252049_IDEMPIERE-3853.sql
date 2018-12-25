SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3853 Bug in Auto Allocation
-- Dec 25, 2018, 8:48:26 PM CET
UPDATE C_Conversion_Rate SET IsActive='N',Updated=TO_DATE('2018-12-25 20:48:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Conversion_Rate_ID=137
;

-- Dec 25, 2018, 8:48:28 PM CET
UPDATE C_Conversion_Rate SET IsActive='N',Updated=TO_DATE('2018-12-25 20:48:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Conversion_Rate_ID=138
;

-- Dec 25, 2018, 8:56:17 PM CET
UPDATE AD_TableIndex SET IsUnique='Y',Updated=TO_DATE('2018-12-25 20:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=200400
;

-- Dec 25, 2018, 8:56:20 PM CET
DROP INDEX c_conversionrate_once
;

-- Dec 25, 2018, 8:56:20 PM CET
CREATE UNIQUE INDEX c_conversionrate_once ON C_Conversion_Rate (AD_Client_ID,AD_Org_ID,C_Currency_ID,C_Currency_ID_To,C_ConversionType_ID,ValidFrom)
;

-- Dec 25, 2018, 9:34:13 PM CET
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2018-12-25 21:34:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10294
;

-- Dec 25, 2018, 9:34:19 PM CET
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2018-12-25 21:34:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=786
;

-- Dec 25, 2018, 9:34:23 PM CET
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2018-12-25 21:34:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=787
;

-- Dec 25, 2018, 9:34:34 PM CET
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2018-12-25 21:34:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=453
;

-- Dec 25, 2018, 9:34:49 PM CET
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2018-12-25 21:34:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=454
;

-- Dec 25, 2018, 9:35:46 PM CET
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-25 21:35:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=436
;

-- Dec 25, 2018, 9:35:47 PM CET
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-25 21:35:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1339
;

SELECT register_migration_script('201812252049_IDEMPIERE-3853.sql') FROM dual
;

