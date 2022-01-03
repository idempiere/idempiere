SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5109 Release 9 Horizon
-- Dec 23, 2021, 6:12:35 PM CET
UPDATE AD_Element SET Name='Business Partner', PrintName='Business Partner',Updated=TO_DATE('2021-12-23 18:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=187
;

-- Dec 23, 2021, 6:12:35 PM CET
UPDATE AD_Column SET ColumnName='C_BPartner_ID', Name='Business Partner', Description='Identifies a Business Partner', Help='A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson', Placeholder=NULL WHERE AD_Element_ID=187
;

-- Dec 23, 2021, 6:12:35 PM CET
UPDATE AD_Process_Para SET ColumnName='C_BPartner_ID', Name='Business Partner', Description='Identifies a Business Partner', Help='A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson', AD_Element_ID=187 WHERE UPPER(ColumnName)='C_BPARTNER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 23, 2021, 6:12:35 PM CET
UPDATE AD_Process_Para SET ColumnName='C_BPartner_ID', Name='Business Partner', Description='Identifies a Business Partner', Help='A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson', Placeholder=NULL WHERE AD_Element_ID=187 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:12:35 PM CET
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_ID', Name='Business Partner', Description='Identifies a Business Partner', Help='A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson', Placeholder=NULL WHERE AD_Element_ID=187 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:12:35 PM CET
UPDATE AD_Field SET Name='Business Partner', Description='Identifies a Business Partner', Help='A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=187) AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:12:36 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Business Partner', Name='Business Partner' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=187)
;

-- Dec 23, 2021, 6:12:50 PM CET
UPDATE AD_Element SET Name='Access Advanced', PrintName='Access Advanced',Updated=TO_DATE('2021-12-23 18:12:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202575
;

-- Dec 23, 2021, 6:12:50 PM CET
UPDATE AD_Column SET ColumnName='IsAccessAdvanced', Name='Access Advanced', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202575
;

-- Dec 23, 2021, 6:12:50 PM CET
UPDATE AD_Process_Para SET ColumnName='IsAccessAdvanced', Name='Access Advanced', Description=NULL, Help=NULL, AD_Element_ID=202575 WHERE UPPER(ColumnName)='ISACCESSADVANCED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 23, 2021, 6:12:50 PM CET
UPDATE AD_Process_Para SET ColumnName='IsAccessAdvanced', Name='Access Advanced', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202575 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:12:50 PM CET
UPDATE AD_InfoColumn SET ColumnName='IsAccessAdvanced', Name='Access Advanced', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202575 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:12:50 PM CET
UPDATE AD_Field SET Name='Access Advanced', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202575) AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:12:50 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Access Advanced', Name='Access Advanced' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202575)
;

-- Dec 23, 2021, 6:13:01 PM CET
UPDATE AD_Element SET Name='Image Alpha',Updated=TO_DATE('2021-12-23 18:13:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1719
;

-- Dec 23, 2021, 6:13:01 PM CET
UPDATE AD_Column SET ColumnName='ImageAlpha', Name='Image Alpha', Description='Image Texture Composite Alpha', Help='Composite Alpha factor for taint color.', Placeholder=NULL WHERE AD_Element_ID=1719
;

-- Dec 23, 2021, 6:13:01 PM CET
UPDATE AD_Process_Para SET ColumnName='ImageAlpha', Name='Image Alpha', Description='Image Texture Composite Alpha', Help='Composite Alpha factor for taint color.', AD_Element_ID=1719 WHERE UPPER(ColumnName)='IMAGEALPHA' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 23, 2021, 6:13:01 PM CET
UPDATE AD_Process_Para SET ColumnName='ImageAlpha', Name='Image Alpha', Description='Image Texture Composite Alpha', Help='Composite Alpha factor for taint color.', Placeholder=NULL WHERE AD_Element_ID=1719 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:01 PM CET
UPDATE AD_InfoColumn SET ColumnName='ImageAlpha', Name='Image Alpha', Description='Image Texture Composite Alpha', Help='Composite Alpha factor for taint color.', Placeholder=NULL WHERE AD_Element_ID=1719 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:01 PM CET
UPDATE AD_Field SET Name='Image Alpha', Description='Image Texture Composite Alpha', Help='Composite Alpha factor for taint color.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1719) AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:01 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Image Alpha', Name='Image Alpha' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1719)
;

-- Dec 23, 2021, 6:13:18 PM CET
UPDATE AD_Element SET Name='Quantity Invoiced',Updated=TO_DATE('2021-12-23 18:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2045
;

-- Dec 23, 2021, 6:13:18 PM CET
UPDATE AD_Column SET ColumnName='InvoicedQty', Name='Quantity Invoiced', Description='The quantity invoiced', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2045
;

-- Dec 23, 2021, 6:13:18 PM CET
UPDATE AD_Process_Para SET ColumnName='InvoicedQty', Name='Quantity Invoiced', Description='The quantity invoiced', Help=NULL, AD_Element_ID=2045 WHERE UPPER(ColumnName)='INVOICEDQTY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 23, 2021, 6:13:18 PM CET
UPDATE AD_Process_Para SET ColumnName='InvoicedQty', Name='Quantity Invoiced', Description='The quantity invoiced', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2045 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:18 PM CET
UPDATE AD_InfoColumn SET ColumnName='InvoicedQty', Name='Quantity Invoiced', Description='The quantity invoiced', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2045 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:18 PM CET
UPDATE AD_Field SET Name='Quantity Invoiced', Description='The quantity invoiced', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2045) AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:18 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Quantity Invoiced', Name='Quantity Invoiced' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2045)
;

-- Dec 23, 2021, 6:13:27 PM CET
UPDATE AD_Element SET Name='Print detail records on invoice',Updated=TO_DATE('2021-12-23 18:13:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1175
;

-- Dec 23, 2021, 6:13:27 PM CET
UPDATE AD_Column SET ColumnName='IsInvoicePrintDetails', Name='Print detail records on invoice', Description='Print detail BOM elements on the invoice', Help='The Print Details on Invoice indicates that the BOM element products will print on the Invoice as opposed to this product.', Placeholder=NULL WHERE AD_Element_ID=1175
;

-- Dec 23, 2021, 6:13:27 PM CET
UPDATE AD_Process_Para SET ColumnName='IsInvoicePrintDetails', Name='Print detail records on invoice', Description='Print detail BOM elements on the invoice', Help='The Print Details on Invoice indicates that the BOM element products will print on the Invoice as opposed to this product.', AD_Element_ID=1175 WHERE UPPER(ColumnName)='ISINVOICEPRINTDETAILS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 23, 2021, 6:13:27 PM CET
UPDATE AD_Process_Para SET ColumnName='IsInvoicePrintDetails', Name='Print detail records on invoice', Description='Print detail BOM elements on the invoice', Help='The Print Details on Invoice indicates that the BOM element products will print on the Invoice as opposed to this product.', Placeholder=NULL WHERE AD_Element_ID=1175 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:27 PM CET
UPDATE AD_InfoColumn SET ColumnName='IsInvoicePrintDetails', Name='Print detail records on invoice', Description='Print detail BOM elements on the invoice', Help='The Print Details on Invoice indicates that the BOM element products will print on the Invoice as opposed to this product.', Placeholder=NULL WHERE AD_Element_ID=1175 AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:27 PM CET
UPDATE AD_Field SET Name='Print detail records on invoice', Description='Print detail BOM elements on the invoice', Help='The Print Details on Invoice indicates that the BOM element products will print on the Invoice as opposed to this product.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1175) AND IsCentrallyMaintained='Y'
;

-- Dec 23, 2021, 6:13:27 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Print detail on invoice', Name='Print detail records on invoice' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1175)
;

SELECT register_migration_script('202112231814_IDEMPIERE-5109_CleanTrailingSpace.sql') FROM dual
;

