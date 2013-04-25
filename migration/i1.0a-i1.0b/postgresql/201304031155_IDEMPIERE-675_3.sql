-- Apr 3, 2013 10:51:54 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Element SET Help='The Inventory Sub Type indicates the type of inventory this document refers to.  This field only appears when the Document Base Type is Material Physical Inventory.  The selection made here will determine which window must be used and which data in the lines is relevant for the document.  Internal Use inventory (based on Internal Used Quantity) or Physical Inventory (based on difference between Qty Counted vs Qty Book)', Name='Inv Sub Type', Description='Inventory Sub Type', PrintName='Inv Sub Type',Updated=TO_TIMESTAMP('2013-04-03 10:51:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202506
;

-- Apr 3, 2013 10:51:54 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Column SET ColumnName='DocSubTypeInv', Name='Inv Sub Type', Description='Inventory Sub Type', Help='The Inventory Sub Type indicates the type of inventory this document refers to.  This field only appears when the Document Base Type is Material Physical Inventory.  The selection made here will determine which window must be used and which data in the lines is relevant for the document.  Internal Use inventory (based on Internal Used Quantity) or Physical Inventory (based on difference between Qty Counted vs Qty Book)' WHERE AD_Element_ID=202506
;

-- Apr 3, 2013 10:51:54 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Process_Para SET ColumnName='DocSubTypeInv', Name='Inv Sub Type', Description='Inventory Sub Type', Help='The Inventory Sub Type indicates the type of inventory this document refers to.  This field only appears when the Document Base Type is Material Physical Inventory.  The selection made here will determine which window must be used and which data in the lines is relevant for the document.  Internal Use inventory (based on Internal Used Quantity) or Physical Inventory (based on difference between Qty Counted vs Qty Book)', AD_Element_ID=202506 WHERE UPPER(ColumnName)='DOCSUBTYPEINV' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 3, 2013 10:51:54 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Process_Para SET ColumnName='DocSubTypeInv', Name='Inv Sub Type', Description='Inventory Sub Type', Help='The Inventory Sub Type indicates the type of inventory this document refers to.  This field only appears when the Document Base Type is Material Physical Inventory.  The selection made here will determine which window must be used and which data in the lines is relevant for the document.  Internal Use inventory (based on Internal Used Quantity) or Physical Inventory (based on difference between Qty Counted vs Qty Book)' WHERE AD_Element_ID=202506 AND IsCentrallyMaintained='Y'
;

-- Apr 3, 2013 10:51:54 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_InfoColumn SET ColumnName='DocSubTypeInv', Name='Inv Sub Type', Description='Inventory Sub Type', Help='The Inventory Sub Type indicates the type of inventory this document refers to.  This field only appears when the Document Base Type is Material Physical Inventory.  The selection made here will determine which window must be used and which data in the lines is relevant for the document.  Internal Use inventory (based on Internal Used Quantity) or Physical Inventory (based on difference between Qty Counted vs Qty Book)' WHERE AD_Element_ID=202506 AND IsCentrallyMaintained='Y'
;

-- Apr 3, 2013 10:51:54 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET Name='Inv Sub Type', Description='Inventory Sub Type', Help='The Inventory Sub Type indicates the type of inventory this document refers to.  This field only appears when the Document Base Type is Material Physical Inventory.  The selection made here will determine which window must be used and which data in the lines is relevant for the document.  Internal Use inventory (based on Internal Used Quantity) or Physical Inventory (based on difference between Qty Counted vs Qty Book)' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202506) AND IsCentrallyMaintained='Y'
;

-- Apr 3, 2013 10:51:54 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_PrintFormatItem SET PrintName='Inv Sub Type', Name='Inv Sub Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202506)
;

-- Apr 3, 2013 10:54:01 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2013-04-03 10:54:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210208
;

-- Apr 3, 2013 10:59:14 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Val_Rule SET EntityType='D',Updated=TO_TIMESTAMP('2013-04-03 10:59:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200034
;

-- Apr 3, 2013 11:47:25 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Tab SET WhereClause='M_Inventory.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType Where DocBaseType=''MMI'' AND (DocSubTypeInv=''PI'' OR DocSubTypeInv IS NULL))',Updated=TO_TIMESTAMP('2013-04-03 11:47:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=255
;

-- Apr 3, 2013 11:47:56 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Tab SET WhereClause='M_Inventory.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType Where DocBaseType=''MMI'' AND (DocSubTypeInv=''IU'' OR DocSubTypeInv IS NULL))',Updated=TO_TIMESTAMP('2013-04-03 11:47:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=682
;

-- Apr 3, 2013 11:53:18 AM COT
-- IDEMPIERE-675 Internal Use with zero qty is dropping the inventory
UPDATE AD_Field SET MandatoryLogic='@DocBaseType@=''MMI''',Updated=TO_TIMESTAMP('2013-04-03 11:53:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201886
;

SELECT register_migration_script('201304031155_IDEMPIERE-675_3.sql') FROM dual
;

