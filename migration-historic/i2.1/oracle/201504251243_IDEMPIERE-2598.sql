SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2598 minor dictionary improvements
-- Apr 25, 2015 10:50:33 AM COT
UPDATE AD_Element SET Name='Drop Ship Business Partner', PrintName='Drop Ship Business Partner',Updated=TO_DATE('2015-04-25 10:50:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53458
;

-- Apr 25, 2015 10:50:33 AM COT
UPDATE AD_Column SET ColumnName='DropShip_BPartner_ID', Name='Drop Ship Business Partner', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Element_ID=53458
;

-- Apr 25, 2015 10:50:33 AM COT
UPDATE AD_Process_Para SET ColumnName='DropShip_BPartner_ID', Name='Drop Ship Business Partner', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.', AD_Element_ID=53458 WHERE UPPER(ColumnName)='DROPSHIP_BPARTNER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 25, 2015 10:50:33 AM COT
UPDATE AD_Process_Para SET ColumnName='DropShip_BPartner_ID', Name='Drop Ship Business Partner', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Element_ID=53458 AND IsCentrallyMaintained='Y'
;

-- Apr 25, 2015 10:50:33 AM COT
UPDATE AD_InfoColumn SET ColumnName='DropShip_BPartner_ID', Name='Drop Ship Business Partner', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Element_ID=53458 AND IsCentrallyMaintained='Y'
;

-- Apr 25, 2015 10:50:33 AM COT
UPDATE AD_Field SET Name='Drop Ship Business Partner', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53458) AND IsCentrallyMaintained='Y'
;

-- Apr 25, 2015 10:50:33 AM COT
UPDATE AD_PrintFormatItem SET PrintName='Drop Ship Business Partner', Name='Drop Ship Business Partner' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53458)
;

-- Apr 25, 2015 10:52:36 AM COT
UPDATE AD_OrgInfo SET M_Warehouse_ID=103,Updated=TO_DATE('2015-04-25 10:52:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Org_ID=11
;

-- Apr 25, 2015 10:52:49 AM COT
UPDATE AD_OrgInfo SET M_Warehouse_ID=50001,Updated=TO_DATE('2015-04-25 10:52:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Org_ID=50000
;

-- Apr 25, 2015 10:52:58 AM COT
UPDATE AD_OrgInfo SET M_Warehouse_ID=50002,Updated=TO_DATE('2015-04-25 10:52:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Org_ID=50001
;

-- Apr 25, 2015 11:01:37 AM COT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='C',Updated=TO_DATE('2015-04-25 11:01:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208569
;

-- Apr 25, 2015 11:01:39 AM COT
ALTER TABLE AD_CtxHelpMsg_Trl MODIFY AD_CtxHelpMsg_ID NUMBER(10)
;

-- Apr 25, 2015 11:01:39 AM COT
ALTER TABLE AD_CtxHelpMsg_Trl DROP CONSTRAINT adctxhelpmsg_adctxhelpmsgtrl
;

-- Apr 25, 2015 11:01:39 AM COT
ALTER TABLE AD_CtxHelpMsg_Trl ADD CONSTRAINT adctxhelpmsg_adctxhelpmsgtrl FOREIGN KEY (AD_CtxHelpMsg_ID) REFERENCES ad_ctxhelpmsg(ad_ctxhelpmsg_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 25, 2015 11:02:18 AM COT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='M',Updated=TO_DATE('2015-04-25 11:02:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208566
;

-- Apr 25, 2015 11:04:18 AM COT
UPDATE AD_Field SET DisplayLogic='@Processed@=N',Updated=TO_DATE('2015-04-25 11:04:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4244
;

-- Apr 25, 2015 11:04:54 AM COT
UPDATE AD_Field SET DisplayLogic='@Processed@=N',Updated=TO_DATE('2015-04-25 11:04:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4246
;

-- Apr 25, 2015 11:07:45 AM COT
UPDATE AD_Table SET AD_Window_ID=53165,Updated=TO_DATE('2015-04-25 11:07:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53325
;

-- Apr 25, 2015 11:08:52 AM COT
UPDATE AD_Table SET AD_Window_ID=139,Updated=TO_DATE('2015-04-25 11:08:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=329
;

-- Apr 25, 2015 11:10:22 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2015-04-25 11:10:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4922
;

-- Apr 25, 2015 11:11:21 AM COT
UPDATE AD_SysConfig SET Description='Define the start value for C_BPartner_Location.Name (possible values 0 to 4) - complete definition here http://wiki.idempiere.org/en/System_Configurator_(Window_ID-50006)#START_VALUE_BPLOCATION_NAME',Updated=TO_DATE('2015-04-25 11:11:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50017
;

-- Apr 25, 2015 11:13:10 AM COT
UPDATE AD_Column SET FKConstraintType='N',Updated=TO_DATE('2015-04-25 11:13:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6949
;

-- Apr 25, 2015 11:13:44 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2015-04-25 11:13:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6949
;

-- Apr 25, 2015 11:13:47 AM COT
ALTER TABLE AD_PrintFormatItem MODIFY AD_Column_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 25, 2015 11:13:47 AM COT
ALTER TABLE AD_PrintFormatItem DROP CONSTRAINT adcolumn_adprintformatitem
;

-- Apr 25, 2015 11:13:47 AM COT
ALTER TABLE AD_PrintFormatItem ADD CONSTRAINT adcolumn_adprintformatitem FOREIGN KEY (AD_Column_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 25, 2015 11:20:55 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2015-04-25 11:20:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6652
;

-- Apr 25, 2015 11:20:58 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2015-04-25 11:20:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6653
;

-- Apr 25, 2015 11:24:36 AM COT
UPDATE AD_Val_Rule SET Code='DocStatus NOT IN (''DR'',''IP'',''IN'')  AND EXISTS (SELECT * FROM C_OrderLine WHERE C_Order.C_Order_ID=C_OrderLine.C_Order_ID AND QtyOrdered <> QtyInvoiced) AND IsSOTrx=''Y'' AND NOT EXISTS (SELECT * FROM C_Invoice i WHERE i.C_Order_ID=C_Order.C_Order_ID AND i.DocStatus IN (''IP'', ''CO'', ''CL''))',Updated=TO_DATE('2015-04-25 11:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=134
;

-- Apr 25, 2015 11:31:42 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2015-04-25 11:31:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2919
;

-- Apr 25, 2015 11:32:31 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2015-04-25 11:32:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12533
;

-- Apr 25, 2015 11:42:12 AM COT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='C',Updated=TO_DATE('2015-04-25 11:42:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5385
;

-- Apr 25, 2015 11:42:14 AM COT
ALTER TABLE AD_FieldGroup_Trl MODIFY AD_FieldGroup_ID NUMBER(10)
;

-- Apr 25, 2015 11:42:14 AM COT
ALTER TABLE AD_FieldGroup_Trl DROP CONSTRAINT adfieldgroup_trl
;

-- Apr 25, 2015 11:42:14 AM COT
ALTER TABLE AD_FieldGroup_Trl ADD CONSTRAINT adfieldgroup_trl FOREIGN KEY (AD_FieldGroup_ID) REFERENCES ad_fieldgroup(ad_fieldgroup_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 25, 2015 11:46:29 AM COT
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_DATE('2015-04-25 11:46:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12131
;

-- Apr 25, 2015 11:48:48 AM COT
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_DATE('2015-04-25 11:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8944
;

SELECT register_migration_script('201504251243_IDEMPIERE-2598.sql') FROM dual
;

