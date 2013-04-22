-- Apr 4, 2013 11:54:26 AM COT
UPDATE AD_Element SET ColumnName='AD_User_C_BPartner_ID', Name='AD_User_C_BPartner_ID', PrintName='AD_User_C_BPartner_ID',Updated=TO_DATE('2013-04-04 11:54:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200425
;

-- Apr 4, 2013 11:54:26 AM COT
UPDATE AD_Column SET ColumnName='AD_User_C_BPartner_ID', Name='AD_User_C_BPartner_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200425
;

-- Apr 4, 2013 11:54:26 AM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_C_BPartner_ID', Name='AD_User_C_BPartner_ID', Description=NULL, Help=NULL, AD_Element_ID=200425 WHERE UPPER(ColumnName)='AD_USER_C_BPARTNER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 11:54:26 AM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_C_BPartner_ID', Name='AD_User_C_BPartner_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200425 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 11:54:26 AM COT
UPDATE AD_InfoColumn SET ColumnName='AD_User_C_BPartner_ID', Name='AD_User_C_BPartner_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200425 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 11:54:26 AM COT
UPDATE AD_Field SET Name='AD_User_C_BPartner_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200425) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 11:54:26 AM COT
UPDATE AD_PrintFormatItem SET PrintName='AD_User_C_BPartner_ID', Name='AD_User_C_BPartner_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200425)
;

-- Apr 4, 2013 11:54:43 AM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='AD_User_C_BPartner_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 11:54:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210163
;

-- Apr 4, 2013 11:58:20 AM COT
UPDATE AD_Element SET ColumnName='AD_User_C_Greeting_ID', Name='AD_User_C_Greeting_ID', PrintName='AD_User_C_Greeting_ID',Updated=TO_DATE('2013-04-04 11:58:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200427
;

-- Apr 4, 2013 11:58:20 AM COT
UPDATE AD_Column SET ColumnName='AD_User_C_Greeting_ID', Name='AD_User_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200427
;

-- Apr 4, 2013 11:58:21 AM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_C_Greeting_ID', Name='AD_User_C_Greeting_ID', Description=NULL, Help=NULL, AD_Element_ID=200427 WHERE UPPER(ColumnName)='AD_USER_C_GREETING_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 11:58:21 AM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_C_Greeting_ID', Name='AD_User_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200427 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 11:58:21 AM COT
UPDATE AD_InfoColumn SET ColumnName='AD_User_C_Greeting_ID', Name='AD_User_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200427 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 11:58:21 AM COT
UPDATE AD_Field SET Name='AD_User_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200427) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 11:58:21 AM COT
UPDATE AD_PrintFormatItem SET PrintName='AD_User_C_Greeting_ID', Name='AD_User_C_Greeting_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200427)
;

-- Apr 4, 2013 12:03:13 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='AD_User_C_Greeting_ID', Name='AD_User_C_Greeting_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 12:03:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210164
;

-- Apr 4, 2013 12:08:06 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_PO_PriceList_ID', Name='C_BPartner_PO_PriceList_ID', PrintName='C_BPartner_PO_PriceList_ID',Updated=TO_DATE('2013-04-04 12:08:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200385
;

-- Apr 4, 2013 12:08:06 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_PO_PriceList_ID', Name='C_BPartner_PO_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200385
;

-- Apr 4, 2013 12:08:06 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_PO_PriceList_ID', Name='C_BPartner_PO_PriceList_ID', Description=NULL, Help=NULL, AD_Element_ID=200385 WHERE UPPER(ColumnName)='C_BPARTNER_PO_PRICELIST_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 12:08:06 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_PO_PriceList_ID', Name='C_BPartner_PO_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200385 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:08:06 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_PO_PriceList_ID', Name='C_BPartner_PO_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200385 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:08:06 PM COT
UPDATE AD_Field SET Name='C_BPartner_PO_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200385) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:08:06 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_PO_PriceList_ID', Name='C_BPartner_PO_PriceList_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200385)
;

-- Apr 4, 2013 12:09:04 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_BPartner_PO_PriceList_ID', Name='C_BPartner_PO_PriceList_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 12:09:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210162
;

-- Apr 4, 2013 12:13:40 PM COT
UPDATE AD_Element SET ColumnName='SalesRep_AD_Org_ID', Name='SalesRep_AD_Org_ID', PrintName='SalesRep_AD_Org_ID',Updated=TO_DATE('2013-04-04 12:13:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200458
;

-- Apr 4, 2013 12:13:40 PM COT
UPDATE AD_Column SET ColumnName='SalesRep_AD_Org_ID', Name='SalesRep_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200458
;

-- Apr 4, 2013 12:13:40 PM COT
UPDATE AD_Process_Para SET ColumnName='SalesRep_AD_Org_ID', Name='SalesRep_AD_Org_ID', Description=NULL, Help=NULL, AD_Element_ID=200458 WHERE UPPER(ColumnName)='SALESREP_AD_ORG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 12:13:40 PM COT
UPDATE AD_Process_Para SET ColumnName='SalesRep_AD_Org_ID', Name='SalesRep_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200458 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:13:40 PM COT
UPDATE AD_InfoColumn SET ColumnName='SalesRep_AD_Org_ID', Name='SalesRep_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200458 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:13:40 PM COT
UPDATE AD_Field SET Name='SalesRep_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200458) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:13:40 PM COT
UPDATE AD_PrintFormatItem SET PrintName='SalesRep_AD_Org_ID', Name='SalesRep_AD_Org_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200458)
;

-- Apr 4, 2013 12:14:05 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='SalesRep_AD_Org_ID', Name='SalesRep_AD_Org_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 12:14:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210166
;

-- Apr 4, 2013 12:16:09 PM COT
UPDATE AD_Element SET ColumnName='SalesRep_C_BP_Location_ID',Updated=TO_DATE('2013-04-04 12:16:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200462
;

-- Apr 4, 2013 12:16:09 PM COT
UPDATE AD_Column SET ColumnName='SalesRep_C_BP_Location_ID', Name='Sales Representative Location', Description=NULL, Help=NULL WHERE AD_Element_ID=200462
;

-- Apr 4, 2013 12:16:10 PM COT
UPDATE AD_Process_Para SET ColumnName='SalesRep_C_BP_Location_ID', Name='Sales Representative Location', Description=NULL, Help=NULL, AD_Element_ID=200462 WHERE UPPER(ColumnName)='SALESREP_C_BP_LOCATION_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 12:16:10 PM COT
UPDATE AD_Process_Para SET ColumnName='SalesRep_C_BP_Location_ID', Name='Sales Representative Location', Description=NULL, Help=NULL WHERE AD_Element_ID=200462 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:16:10 PM COT
UPDATE AD_InfoColumn SET ColumnName='SalesRep_C_BP_Location_ID', Name='Sales Representative Location', Description=NULL, Help=NULL WHERE AD_Element_ID=200462 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 12:16:44 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='SalesRep_C_BP_Location_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 12:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210167
;

-- Apr 4, 2013 2:28:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:28:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=201273
;

-- Apr 4, 2013 2:29:42 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:29:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210165
;

-- Apr 4, 2013 2:30:50 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:30:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210168
;

-- Apr 4, 2013 2:33:07 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:33:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210171
;

-- Apr 4, 2013 2:35:08 PM COT
UPDATE AD_Element SET ColumnName='C_Invoice_AD_Org_ID', Name='C_Invoice_AD_Org_ID', PrintName='C_Invoice_AD_Org_ID',Updated=TO_DATE('2013-04-04 14:35:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200544
;

-- Apr 4, 2013 2:35:08 PM COT
UPDATE AD_Column SET ColumnName='C_Invoice_AD_Org_ID', Name='C_Invoice_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200544
;

-- Apr 4, 2013 2:35:08 PM COT
UPDATE AD_Process_Para SET ColumnName='C_Invoice_AD_Org_ID', Name='C_Invoice_AD_Org_ID', Description=NULL, Help=NULL, AD_Element_ID=200544 WHERE UPPER(ColumnName)='C_INVOICE_AD_ORG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 2:35:08 PM COT
UPDATE AD_Process_Para SET ColumnName='C_Invoice_AD_Org_ID', Name='C_Invoice_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200544 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:35:08 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_Invoice_AD_Org_ID', Name='C_Invoice_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200544 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:35:08 PM COT
UPDATE AD_Field SET Name='C_Invoice_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200544) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:35:08 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_Invoice_AD_Org_ID', Name='C_Invoice_AD_Org_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200544)
;

-- Apr 4, 2013 2:35:47 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:35:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210169
;

-- Apr 4, 2013 2:36:58 PM COT
UPDATE AD_Element SET ColumnName='C_Payment_C_Charge_ID', Name='C_Payment_C_Charge_ID', PrintName='C_Payment_C_Charge_ID',Updated=TO_DATE('2013-04-04 14:36:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200564
;

-- Apr 4, 2013 2:36:58 PM COT
UPDATE AD_Column SET ColumnName='C_Payment_C_Charge_ID', Name='C_Payment_C_Charge_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200564
;

-- Apr 4, 2013 2:36:58 PM COT
UPDATE AD_Process_Para SET ColumnName='C_Payment_C_Charge_ID', Name='C_Payment_C_Charge_ID', Description=NULL, Help=NULL, AD_Element_ID=200564 WHERE UPPER(ColumnName)='C_PAYMENT_C_CHARGE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 2:36:58 PM COT
UPDATE AD_Process_Para SET ColumnName='C_Payment_C_Charge_ID', Name='C_Payment_C_Charge_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200564 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:36:58 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_Payment_C_Charge_ID', Name='C_Payment_C_Charge_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200564 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:36:58 PM COT
UPDATE AD_Field SET Name='C_Payment_C_Charge_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200564) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:36:58 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_Payment_C_Charge_ID', Name='C_Payment_C_Charge_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200564)
;

-- Apr 4, 2013 2:38:14 PM COT
UPDATE AD_Element SET ColumnName='C_Payment_C_Invoice_ID', Name='C_Payment_C_Invoice_ID', PrintName='C_Payment_C_Invoice_ID',Updated=TO_DATE('2013-04-04 14:38:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200566
;

-- Apr 4, 2013 2:38:14 PM COT
UPDATE AD_Column SET ColumnName='C_Payment_C_Invoice_ID', Name='C_Payment_C_Invoice_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200566
;

-- Apr 4, 2013 2:38:14 PM COT
UPDATE AD_Process_Para SET ColumnName='C_Payment_C_Invoice_ID', Name='C_Payment_C_Invoice_ID', Description=NULL, Help=NULL, AD_Element_ID=200566 WHERE UPPER(ColumnName)='C_PAYMENT_C_INVOICE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 2:38:14 PM COT
UPDATE AD_Process_Para SET ColumnName='C_Payment_C_Invoice_ID', Name='C_Payment_C_Invoice_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200566 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:38:14 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_Payment_C_Invoice_ID', Name='C_Payment_C_Invoice_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200566 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:38:14 PM COT
UPDATE AD_Field SET Name='C_Payment_C_Invoice_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200566) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:38:14 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_Payment_C_Invoice_ID', Name='C_Payment_C_Invoice_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200566)
;

-- Apr 4, 2013 2:39:28 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:39:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210176
;

-- Apr 4, 2013 2:40:07 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:40:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210175
;

-- Apr 4, 2013 2:43:11 PM COT
UPDATE AD_Element SET ColumnName='C_PaymentTerm_AD_Org_ID', Name='C_PaymentTerm_AD_Org_ID', PrintName='C_PaymentTerm_AD_Org_ID',Updated=TO_DATE('2013-04-04 14:43:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200558
;

-- Apr 4, 2013 2:43:11 PM COT
UPDATE AD_Column SET ColumnName='C_PaymentTerm_AD_Org_ID', Name='C_PaymentTerm_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200558
;

-- Apr 4, 2013 2:43:11 PM COT
UPDATE AD_Process_Para SET ColumnName='C_PaymentTerm_AD_Org_ID', Name='C_PaymentTerm_AD_Org_ID', Description=NULL, Help=NULL, AD_Element_ID=200558 WHERE UPPER(ColumnName)='C_PAYMENTTERM_AD_ORG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 2:43:11 PM COT
UPDATE AD_Process_Para SET ColumnName='C_PaymentTerm_AD_Org_ID', Name='C_PaymentTerm_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200558 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:43:11 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_PaymentTerm_AD_Org_ID', Name='C_PaymentTerm_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200558 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:43:11 PM COT
UPDATE AD_Field SET Name='C_PaymentTerm_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200558) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:43:11 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_PaymentTerm_AD_Org_ID', Name='C_PaymentTerm_AD_Org_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200558)
;

-- Apr 4, 2013 2:43:59 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:43:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210174
;

-- Apr 4, 2013 2:44:41 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:44:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210172
;

-- Apr 4, 2013 2:53:01 PM COT
UPDATE AD_Element SET ColumnName='AD_User_AD_OrgTrx_ID', Name='AD_User_AD_OrgTrx_ID', PrintName='AD_User_AD_OrgTrx_ID',Updated=TO_DATE('2013-04-04 14:53:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200423
;

-- Apr 4, 2013 2:53:01 PM COT
UPDATE AD_Column SET ColumnName='AD_User_AD_OrgTrx_ID', Name='AD_User_AD_OrgTrx_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200423
;

-- Apr 4, 2013 2:53:01 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_AD_OrgTrx_ID', Name='AD_User_AD_OrgTrx_ID', Description=NULL, Help=NULL, AD_Element_ID=200423 WHERE UPPER(ColumnName)='AD_USER_AD_ORGTRX_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 2:53:01 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_AD_OrgTrx_ID', Name='AD_User_AD_OrgTrx_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200423 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:53:01 PM COT
UPDATE AD_InfoColumn SET ColumnName='AD_User_AD_OrgTrx_ID', Name='AD_User_AD_OrgTrx_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200423 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:53:01 PM COT
UPDATE AD_Field SET Name='AD_User_AD_OrgTrx_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200423) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:53:01 PM COT
UPDATE AD_PrintFormatItem SET PrintName='AD_User_AD_OrgTrx_ID', Name='AD_User_AD_OrgTrx_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200423)
;

-- Apr 4, 2013 2:53:30 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:53:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210182
;

-- Apr 4, 2013 2:55:03 PM COT
UPDATE AD_Element SET ColumnName='AD_User_AD_Org_ID', Name='AD_User_AD_Org_ID', PrintName='AD_User_AD_Org_ID',Updated=TO_DATE('2013-04-04 14:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200422
;

-- Apr 4, 2013 2:55:03 PM COT
UPDATE AD_Column SET ColumnName='AD_User_AD_Org_ID', Name='AD_User_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200422
;

-- Apr 4, 2013 2:55:03 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_AD_Org_ID', Name='AD_User_AD_Org_ID', Description=NULL, Help=NULL, AD_Element_ID=200422 WHERE UPPER(ColumnName)='AD_USER_AD_ORG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 2:55:03 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_AD_Org_ID', Name='AD_User_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200422 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:55:03 PM COT
UPDATE AD_InfoColumn SET ColumnName='AD_User_AD_Org_ID', Name='AD_User_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200422 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:55:03 PM COT
UPDATE AD_Field SET Name='AD_User_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200422) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 2:55:04 PM COT
UPDATE AD_PrintFormatItem SET PrintName='AD_User_AD_Org_ID', Name='AD_User_AD_Org_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200422)
;

-- Apr 4, 2013 2:55:33 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 14:55:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210181
;

-- Apr 4, 2013 3:21:57 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='BPartner_Parent_ID', Name='BPartner_Parent_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 15:21:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210177
;

-- Apr 4, 2013 3:21:57 PM COT
UPDATE AD_Field SET Name='BPartner_Parent_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=210177 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:33:09 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_C_BP_Group_ID', Name='C_BPartner_C_BP_Group_ID', PrintName='C_BPartner_C_BP_Group_ID',Updated=TO_DATE('2013-04-04 15:33:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200349
;

-- Apr 4, 2013 3:33:09 PM COT
UPDATE AD_Column SET ColumnName='C_BP_Group_ID', Name='C_BP_Group_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=210178
;

-- Apr 4, 2013 3:33:09 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BP_Group_ID', Name='C_BP_Group_ID', Description=NULL, Help=NULL, AD_Element_ID=200349 WHERE UPPER(ColumnName)='C_BP_GROUP_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 3:33:09 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BP_Group_ID', Name='C_BP_Group_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200349 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:33:09 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BP_Group_ID', Name='C_BP_Group_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200349 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:33:09 PM COT
UPDATE AD_Field SET Name='C_BP_Group_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200349) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:33:09 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BP_Group_ID', Name='C_BP_Group_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200349)
;

-- Apr 4, 2013 3:38:14 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_C_Dunning_ID', Name='C_BPartner_C_Dunning_ID', PrintName='C_BPartner_C_Dunning_ID',Updated=TO_DATE('2013-04-04 15:38:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200978
;

-- Apr 4, 2013 3:38:14 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_C_Dunning_ID', Name='C_BPartner_C_Dunning_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200978
;

-- Apr 4, 2013 3:38:14 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_Dunning_ID', Name='C_BPartner_C_Dunning_ID', Description=NULL, Help=NULL, AD_Element_ID=200978 WHERE UPPER(ColumnName)='C_BPartner_C_Dunning_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 3:38:14 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_Dunning_ID', Name='C_BPartner_C_Dunning_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200978 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:38:14 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_C_Dunning_ID', Name='C_BPartner_C_Dunning_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200978 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:38:14 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_Dunning_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200978) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:38:14 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_C_Dunning_ID', Name='C_BPartner_C_Dunning_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200978)
;

-- Apr 4, 2013 3:39:45 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 15:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210179
;

-- Apr 4, 2013 3:42:08 PM COT
UPDATE AD_Element SET Name='C_BPartner_InvoiceSchedule_ID', PrintName='C_BPartner_InvoiceSchedule_ID',Updated=TO_DATE('2013-04-04 15:42:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200980
;

-- Apr 4, 2013 3:42:08 PM COT
UPDATE AD_Column SET ColumnName='bp_c_invoiceschedule_id', Name='C_BPartner_InvoiceSchedule_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200980
;

-- Apr 4, 2013 3:42:08 PM COT
UPDATE AD_Process_Para SET ColumnName='bp_c_invoiceschedule_id', Name='C_BPartner_InvoiceSchedule_ID', Description=NULL, Help=NULL, AD_Element_ID=200980 WHERE UPPER(ColumnName)='BP_C_INVOICESCHEDULE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 3:42:08 PM COT
UPDATE AD_Process_Para SET ColumnName='bp_c_invoiceschedule_id', Name='C_BPartner_InvoiceSchedule_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200980 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:42:08 PM COT
UPDATE AD_InfoColumn SET ColumnName='bp_c_invoiceschedule_id', Name='C_BPartner_InvoiceSchedule_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200980 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:42:08 PM COT
UPDATE AD_Field SET Name='C_BPartner_InvoiceSchedule_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200980) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:42:08 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_InvoiceSchedule_ID', Name='C_BPartner_InvoiceSchedule_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200980)
;

-- Apr 4, 2013 3:42:31 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_InvoiceSchedule_ID', Name='C_BPartner_InvoiceSchedule_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 15:42:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210180
;

-- Apr 4, 2013 3:46:57 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_SalesRep_ID', Name='C_BPartner_SalesRep_ID', PrintName='C_BPartner_SalesRep_ID',Updated=TO_DATE('2013-04-04 15:46:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200389
;

-- Apr 4, 2013 3:46:57 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_SalesRep_ID', Name='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200389
;

-- Apr 4, 2013 3:46:57 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_SalesRep_ID', Name='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL, AD_Element_ID=200389 WHERE UPPER(ColumnName)='C_BPARTNER_SALESREP_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 3:46:57 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_SalesRep_ID', Name='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200389 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:46:57 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_SalesRep_ID', Name='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200389 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:46:57 PM COT
UPDATE AD_Field SET Name='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200389) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:46:57 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_SalesRep_ID', Name='C_BPartner_SalesRep_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200389)
;

-- Apr 4, 2013 3:47:31 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_BPartner_SalesRep_ID', Name='C_BPartner_SalesRep_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 15:47:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=203538
;

-- Apr 4, 2013 3:47:31 PM COT
UPDATE AD_Field SET Name='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=203538 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:55:36 PM COT
UPDATE AD_Column SET AD_Element_ID=200348, ColumnName='c_bpartner_bpartner_parent_id', Description=NULL, Help=NULL, Name='c_bpartner_bpartner_parent_id',Updated=TO_DATE('2013-04-04 15:55:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210177
;

-- Apr 4, 2013 3:55:36 PM COT
UPDATE AD_Field SET Name='c_bpartner_bpartner_parent_id', Description=NULL, Help=NULL WHERE AD_Column_ID=210177 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:56:57 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_BPartner_Parent_ID', Name='C_BPartner_BPartner_Parent_ID', PrintName='C_BPartner_BPartner_Parent_ID',Updated=TO_DATE('2013-04-04 15:56:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200348
;

-- Apr 4, 2013 3:56:57 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_BPartner_Parent_ID', Name='C_BPartner_BPartner_Parent_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200348
;

-- Apr 4, 2013 3:56:57 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_BPartner_Parent_ID', Name='C_BPartner_BPartner_Parent_ID', Description=NULL, Help=NULL, AD_Element_ID=200348 WHERE UPPER(ColumnName)='C_BPARTNER_BPARTNER_PARENT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 3:56:57 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_BPartner_Parent_ID', Name='C_BPartner_BPartner_Parent_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200348 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:56:57 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_BPartner_Parent_ID', Name='C_BPartner_BPartner_Parent_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200348 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:56:57 PM COT
UPDATE AD_Field SET Name='C_BPartner_BPartner_Parent_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200348) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 3:56:57 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_BPartner_Parent_ID', Name='C_BPartner_BPartner_Parent_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200348)
;

-- Apr 4, 2013 3:59:44 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-04 15:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210178
;

-- Apr 4, 2013 4:06:17 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200351, ColumnName='C_BPartner_InvoiceSchedule_ID', Description=NULL, Help=NULL, Name='C_BPartner_InvoiceSchedule_ID',Updated=TO_DATE('2013-04-04 16:06:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210180
;

-- Apr 4, 2013 4:08:47 PM COT
UPDATE AD_Column SET AD_Element_ID=200389, ColumnName='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL, Name='C_BPartner_SalesRep_ID',Updated=TO_DATE('2013-04-04 16:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=203538
;

-- Apr 4, 2013 4:12:32 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:12:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205741
;

-- Apr 4, 2013 4:15:01 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:15:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205915
;

-- Apr 4, 2013 4:19:51 PM COT
UPDATE AD_Element SET ColumnName='AD_User_Supervisor_ID', Name='AD_User_Supervisor_ID', PrintName='AD_User_Supervisor_ID',Updated=TO_DATE('2013-04-04 16:19:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200439
;

-- Apr 4, 2013 4:19:51 PM COT
UPDATE AD_Column SET ColumnName='AD_User_Supervisor_ID', Name='AD_User_Supervisor_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200439
;

-- Apr 4, 2013 4:19:51 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_Supervisor_ID', Name='AD_User_Supervisor_ID', Description=NULL, Help=NULL, AD_Element_ID=200439 WHERE UPPER(ColumnName)='AD_USER_SUPERVISOR_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 4:19:51 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_Supervisor_ID', Name='AD_User_Supervisor_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200439 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:19:51 PM COT
UPDATE AD_InfoColumn SET ColumnName='AD_User_Supervisor_ID', Name='AD_User_Supervisor_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200439 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:19:51 PM COT
UPDATE AD_Field SET Name='AD_User_Supervisor_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200439) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:19:51 PM COT
UPDATE AD_PrintFormatItem SET PrintName='AD_User_Supervisor_ID', Name='AD_User_Supervisor_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200439)
;

-- Apr 4, 2013 4:24:28 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_AD_OrgBP_ID', Name='C_BPartner_AD_OrgBP_ID', PrintName='C_BPartner_AD_OrgBP_ID',Updated=TO_DATE('2013-04-04 16:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200346
;

-- Apr 4, 2013 4:24:28 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_AD_OrgBP_ID', Name='C_BPartner_AD_OrgBP_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200346
;

-- Apr 4, 2013 4:24:28 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_AD_OrgBP_ID', Name='C_BPartner_AD_OrgBP_ID', Description=NULL, Help=NULL, AD_Element_ID=200346 WHERE UPPER(ColumnName)='C_BPARTNER_AD_ORGBP_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 4:24:28 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_AD_OrgBP_ID', Name='C_BPartner_AD_OrgBP_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200346 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:24:28 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_AD_OrgBP_ID', Name='C_BPartner_AD_OrgBP_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200346 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:24:28 PM COT
UPDATE AD_Field SET Name='C_BPartner_AD_OrgBP_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200346) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:24:28 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_AD_OrgBP_ID', Name='C_BPartner_AD_OrgBP_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200346)
;

-- Apr 4, 2013 4:26:14 PM COT
UPDATE AD_Column SET AD_Element_ID=200346, ColumnName='C_BPartner_AD_OrgBP_ID', Description=NULL, Help=NULL, Name='C_BPartner_AD_OrgBP_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:26:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205820
;

-- Apr 4, 2013 4:26:14 PM COT
UPDATE AD_Field SET Name='C_BPartner_AD_OrgBP_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205820 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:26:38 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-04 16:26:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205820
;

-- Apr 4, 2013 4:30:05 PM COT
UPDATE AD_Element SET ColumnName='AD_User_C_BPartner_Location_ID', Name='AD_User_C_BPartner_Location_ID', PrintName='AD_User_C_BPartner_Location_ID',Updated=TO_DATE('2013-04-04 16:30:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200426
;

-- Apr 4, 2013 4:30:05 PM COT
UPDATE AD_Column SET ColumnName='AD_User_C_BPartner_Location_ID', Name='AD_User_C_BPartner_Location_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200426
;

-- Apr 4, 2013 4:30:05 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_C_BPartner_Location_ID', Name='AD_User_C_BPartner_Location_ID', Description=NULL, Help=NULL, AD_Element_ID=200426 WHERE UPPER(ColumnName)='AD_USER_C_BPARTNER_LOCATION_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 4:30:05 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_C_BPartner_Location_ID', Name='AD_User_C_BPartner_Location_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200426 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:30:05 PM COT
UPDATE AD_InfoColumn SET ColumnName='AD_User_C_BPartner_Location_ID', Name='AD_User_C_BPartner_Location_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200426 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:30:05 PM COT
UPDATE AD_Field SET Name='AD_User_C_BPartner_Location_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200426) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:30:05 PM COT
UPDATE AD_PrintFormatItem SET PrintName='AD_User_C_BPartner_Location_ID', Name='AD_User_C_BPartner_Location_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200426)
;

-- Apr 4, 2013 4:30:37 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='AD_User_C_BPartner_Location_ID', Name='AD_User_C_BPartner_Location_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205916
;

-- Apr 4, 2013 4:36:29 PM COT
UPDATE AD_Column SET AD_Element_ID=200347, ColumnName='c_bpartner_ad_org_id', Description=NULL, Help=NULL, Name='c_bpartner_ad_org_id', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205821
;

-- Apr 4, 2013 4:36:29 PM COT
UPDATE AD_Field SET Name='c_bpartner_ad_org_id', Description=NULL, Help=NULL WHERE AD_Column_ID=205821 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:37:04 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_AD_Org_ID', Name='C_BPartner_AD_Org_ID', PrintName='C_BPartner_AD_Org_ID',Updated=TO_DATE('2013-04-04 16:37:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200347
;

-- Apr 4, 2013 4:37:04 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_AD_Org_ID', Name='C_BPartner_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200347
;

-- Apr 4, 2013 4:37:04 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_AD_Org_ID', Name='C_BPartner_AD_Org_ID', Description=NULL, Help=NULL, AD_Element_ID=200347 WHERE UPPER(ColumnName)='C_BPARTNER_AD_ORG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 4:37:04 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_AD_Org_ID', Name='C_BPartner_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200347 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:37:04 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_AD_Org_ID', Name='C_BPartner_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200347 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:37:04 PM COT
UPDATE AD_Field SET Name='C_BPartner_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200347) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:37:04 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_AD_Org_ID', Name='C_BPartner_AD_Org_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200347)
;

-- Apr 4, 2013 4:37:51 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_BPartner_AD_Org_ID', Name='C_BPartner_AD_Org_ID',Updated=TO_DATE('2013-04-04 16:37:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205821
;

-- Apr 4, 2013 4:39:28 PM COT
UPDATE AD_Column SET AD_Element_ID=200348, ColumnName='C_BPartner_BPartner_Parent_ID', Description=NULL, Help=NULL, Name='C_BPartner_BPartner_Parent_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:39:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205822
;

-- Apr 4, 2013 4:39:28 PM COT
UPDATE AD_Field SET Name='C_BPartner_BPartner_Parent_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205822 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:39:45 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-04 16:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205822
;

-- Apr 4, 2013 4:43:38 PM COT
UPDATE AD_Column SET AD_Element_ID=200349, ColumnName='C_BPartner_C_BP_Group_ID', Description=NULL, Help=NULL, Name='C_BPartner_C_BP_Group_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:43:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205823
;

-- Apr 4, 2013 4:43:38 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_BP_Group_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205823 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 4:45:03 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-04 16:45:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205823
;

-- Apr 4, 2013 4:49:01 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-04 16:49:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205824
;

-- Apr 4, 2013 5:09:18 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_C_Greeting_ID', Name='C_BPartner_C_Greeting_ID', PrintName='C_BPartner_C_Greeting_ID',Updated=TO_DATE('2013-04-04 17:09:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200350
;

-- Apr 4, 2013 5:09:18 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_C_Greeting_ID', Name='C_BPartner_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200350
;

-- Apr 4, 2013 5:09:18 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_Greeting_ID', Name='C_BPartner_C_Greeting_ID', Description=NULL, Help=NULL, AD_Element_ID=200350 WHERE UPPER(ColumnName)='C_BPARTNER_C_GREETING_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 5:09:18 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_Greeting_ID', Name='C_BPartner_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200350 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:09:18 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_C_Greeting_ID', Name='C_BPartner_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200350 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:09:18 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200350) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:09:18 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_C_Greeting_ID', Name='C_BPartner_C_Greeting_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200350)
;

-- Apr 4, 2013 5:10:14 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200350, ColumnName='C_BPartner_C_Greeting_ID', Description=NULL, Help=NULL, Name='C_BPartner_C_Greeting_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 17:10:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205825
;

-- Apr 4, 2013 5:10:14 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_Greeting_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205825 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:13:00 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200351, ColumnName='C_BPartner_InvoiceSchedule_ID', Description=NULL, Help=NULL, Name='C_BPartner_InvoiceSchedule_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 17:13:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205826
;

-- Apr 4, 2013 5:22:11 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_C_PaymentTerm_ID', Name='C_BPartner_C_PaymentTerm_ID', PrintName='C_BPartner_C_PaymentTerm_ID',Updated=TO_DATE('2013-04-04 17:22:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200352
;

-- Apr 4, 2013 5:22:11 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_C_PaymentTerm_ID', Name='C_BPartner_C_PaymentTerm_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200352
;

-- Apr 4, 2013 5:22:11 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_PaymentTerm_ID', Name='C_BPartner_C_PaymentTerm_ID', Description=NULL, Help=NULL, AD_Element_ID=200352 WHERE UPPER(ColumnName)='C_BPARTNER_C_PAYMENTTERM_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 5:22:11 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_PaymentTerm_ID', Name='C_BPartner_C_PaymentTerm_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200352 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:22:11 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_C_PaymentTerm_ID', Name='C_BPartner_C_PaymentTerm_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200352 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:22:11 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_PaymentTerm_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200352) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:22:11 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_C_PaymentTerm_ID', Name='C_BPartner_C_PaymentTerm_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200352)
;

-- Apr 4, 2013 5:27:02 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200352, ColumnName='C_BPartner_C_PaymentTerm_ID', Description=NULL, Help=NULL, Name='C_BPartner_C_PaymentTerm_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 17:27:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205827
;

-- Apr 4, 2013 5:27:02 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_PaymentTerm_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205827 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:31:07 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_C_TaxGroup_ID', Name='C_BPartner_C_TaxGroup_ID', PrintName='C_BPartner_C_TaxGroup_ID',Updated=TO_DATE('2013-04-04 17:31:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200355
;

-- Apr 4, 2013 5:31:07 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_C_TaxGroup_ID', Name='C_BPartner_C_TaxGroup_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200355
;

-- Apr 4, 2013 5:31:07 PM COT

UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_TaxGroup_ID', Name='C_BPartner_C_TaxGroup_ID', Description=NULL, Help=NULL, AD_Element_ID=200355 WHERE UPPER(ColumnName)='C_BPARTNER_C_TAXGROUP_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2013 5:31:07 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_C_TaxGroup_ID', Name='C_BPartner_C_TaxGroup_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200355 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:31:07 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_C_TaxGroup_ID', Name='C_BPartner_C_TaxGroup_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200355 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:31:07 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_TaxGroup_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200355) AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2013 5:31:07 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_C_TaxGroup_ID', Name='C_BPartner_C_TaxGroup_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200355)
;

-- Apr 4, 2013 5:32:32 PM COT
UPDATE AD_Column SET AD_Element_ID=200355, ColumnName='C_BPartner_C_TaxGroup_ID', Description=NULL, Help=NULL, Name='C_BPartner_C_TaxGroup_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-04 17:32:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205830
;

-- Apr 4, 2013 5:32:32 PM COT
UPDATE AD_Field SET Name='C_BPartner_C_TaxGroup_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205830 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 4:44:44 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200406, ColumnName='c_bpartner_location_ad_org_id', Description=NULL, Help=NULL, Name='c_bpartner_location_ad_org_id', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 16:44:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205880
;

-- Apr 5, 2013 4:44:44 PM COT
UPDATE AD_Field SET Name='c_bpartner_location_ad_org_id', Description=NULL, Help=NULL WHERE AD_Column_ID=205880 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 4:44:57 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_Location_AD_Org_ID', Name='C_BPartner_Location_AD_Org_ID', PrintName='C_BPartner_Location_AD_Org_ID',Updated=TO_DATE('2013-04-05 16:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200406
;

-- Apr 5, 2013 4:44:57 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_Location_AD_Org_ID', Name='C_BPartner_Location_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200406
;

-- Apr 5, 2013 4:44:57 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_Location_AD_Org_ID', Name='C_BPartner_Location_AD_Org_ID', Description=NULL, Help=NULL, AD_Element_ID=200406 WHERE UPPER(ColumnName)='C_BPARTNER_LOCATION_AD_ORG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 5, 2013 4:44:57 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_Location_AD_Org_ID', Name='C_BPartner_Location_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200406 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 4:44:57 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_Location_AD_Org_ID', Name='C_BPartner_Location_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200406 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 4:44:57 PM COT
UPDATE AD_Field SET Name='C_BPartner_Location_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200406) AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 4:44:57 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_Location_AD_Org_ID', Name='C_BPartner_Location_AD_Org_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200406)
;

-- Apr 5, 2013 5:02:21 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-05 17:02:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205881
;

-- Apr 5, 2013 5:03:18 PM COT
UPDATE AD_Element SET ColumnName='BP_Location_C_SalesRegion_ID', Name='BP_Location_C_SalesRegion_ID', PrintName='BP_Location_C_SalesRegion_ID',Updated=TO_DATE('2013-04-05 17:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=201621
;

-- Apr 5, 2013 5:03:18 PM COT
UPDATE AD_Column SET ColumnName='BP_Location_C_SalesRegion_ID', Name='BP_Location_C_SalesRegion_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=201621
;

-- Apr 5, 2013 5:03:19 PM COT
UPDATE AD_Process_Para SET ColumnName='BP_Location_C_SalesRegion_ID', Name='BP_Location_C_SalesRegion_ID', Description=NULL, Help=NULL, AD_Element_ID=201621 WHERE UPPER(ColumnName)='BP_LOCATION_C_SALESREGION_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 5, 2013 5:03:19 PM COT
UPDATE AD_Process_Para SET ColumnName='BP_Location_C_SalesRegion_ID', Name='BP_Location_C_SalesRegion_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=201621 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:03:19 PM COT
UPDATE AD_InfoColumn SET ColumnName='BP_Location_C_SalesRegion_ID', Name='BP_Location_C_SalesRegion_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=201621 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:03:19 PM COT
UPDATE AD_Field SET Name='BP_Location_C_SalesRegion_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=201621) AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:03:19 PM COT
UPDATE AD_PrintFormatItem SET PrintName='BP_Location_C_SalesRegion_ID', Name='BP_Location_C_SalesRegion_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=201621)
;

-- Apr 5, 2013 5:03:28 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='BP_Location_C_SalesRegion_ID', Name='BP_Location_C_SalesRegion_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 17:03:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205884
;

-- Apr 5, 2013 5:04:56 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_Logo_ID', Name='C_BPartner_Logo_ID', PrintName='C_BPartner_Logo_ID',Updated=TO_DATE('2013-04-05 17:04:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200376
;

-- Apr 5, 2013 5:04:56 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_Logo_ID', Name='C_BPartner_Logo_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200376
;

-- Apr 5, 2013 5:04:56 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_Logo_ID', Name='C_BPartner_Logo_ID', Description=NULL, Help=NULL, AD_Element_ID=200376 WHERE UPPER(ColumnName)='C_BPARTNER_LOGO_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 5, 2013 5:04:56 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_Logo_ID', Name='C_BPartner_Logo_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200376 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:04:56 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_Logo_ID', Name='C_BPartner_Logo_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200376 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:04:56 PM COT
UPDATE AD_Field SET Name='C_BPartner_Logo_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200376) AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:04:56 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_Logo_ID', Name='C_BPartner_Logo_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200376)
;

-- Apr 5, 2013 5:05:10 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200376, ColumnName='C_BPartner_Logo_ID', Description=NULL, Help=NULL, Name='C_BPartner_Logo_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 17:05:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205851
;

-- Apr 5, 2013 5:05:10 PM COT
UPDATE AD_Field SET Name='C_BPartner_Logo_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205851 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:07:35 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_M_DiscountSchema_ID', Name='C_BPartner_M_DiscountSchema_ID', PrintName='C_BPartner_M_DiscountSchema_ID',Updated=TO_DATE('2013-04-05 17:07:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200377
;

-- Apr 5, 2013 5:07:35 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_M_DiscountSchema_ID', Name='C_BPartner_M_DiscountSchema_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200377
;

-- Apr 5, 2013 5:07:35 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_M_DiscountSchema_ID', Name='C_BPartner_M_DiscountSchema_ID', Description=NULL, Help=NULL, AD_Element_ID=200377 WHERE UPPER(ColumnName)='C_BPARTNER_M_DISCOUNTSCHEMA_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 5, 2013 5:07:35 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_M_DiscountSchema_ID', Name='C_BPartner_M_DiscountSchema_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200377 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:07:35 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_M_DiscountSchema_ID', Name='C_BPartner_M_DiscountSchema_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200377 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:07:35 PM COT
UPDATE AD_Field SET Name='C_BPartner_M_DiscountSchema_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200377) AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:07:35 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_M_DiscountSchema_ID', Name='C_BPartner_M_DiscountSchema_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200377)
;

-- Apr 5, 2013 5:07:43 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200377, ColumnName='C_BPartner_M_DiscountSchema_ID', Description=NULL, Help=NULL, Name='C_BPartner_M_DiscountSchema_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 17:07:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205852
;

-- Apr 5, 2013 5:07:43 PM COT
UPDATE AD_Field SET Name='C_BPartner_M_DiscountSchema_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205852 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:08:59 PM COT
UPDATE AD_Element SET ColumnName='C_BPartner_M_PriceList_ID', Name='C_BPartner_M_PriceList_ID', PrintName='C_BPartner_M_PriceList_ID',Updated=TO_DATE('2013-04-05 17:08:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=200378
;

-- Apr 5, 2013 5:08:59 PM COT
UPDATE AD_Column SET ColumnName='C_BPartner_M_PriceList_ID', Name='C_BPartner_M_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200378
;

-- Apr 5, 2013 5:08:59 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_M_PriceList_ID', Name='C_BPartner_M_PriceList_ID', Description=NULL, Help=NULL, AD_Element_ID=200378 WHERE UPPER(ColumnName)='C_BPARTNER_M_PRICELIST_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 5, 2013 5:08:59 PM COT
UPDATE AD_Process_Para SET ColumnName='C_BPartner_M_PriceList_ID', Name='C_BPartner_M_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200378 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:08:59 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_BPartner_M_PriceList_ID', Name='C_BPartner_M_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200378 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:08:59 PM COT
UPDATE AD_Field SET Name='C_BPartner_M_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200378) AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:08:59 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_BPartner_M_PriceList_ID', Name='C_BPartner_M_PriceList_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200378)
;

-- Apr 5, 2013 5:09:23 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200378, ColumnName='C_BPartner_M_PriceList_ID', Description=NULL, Help=NULL, Name='C_BPartner_M_PriceList_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 17:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205853
;

-- Apr 5, 2013 5:09:23 PM COT
UPDATE AD_Field SET Name='C_BPartner_M_PriceList_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205853 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 5:20:34 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=1717, ColumnName='PO_DiscountSchema_ID', Description='Schema to calculate the purchase trade discount percentage', Help=NULL, Name='PO Discount Schema', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 17:20:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205857
;

-- Apr 5, 2013 5:20:34 PM COT
UPDATE AD_Field SET Name='PO Discount Schema', Description='Schema to calculate the purchase trade discount percentage', Help=NULL WHERE AD_Column_ID=205857 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 6:08:15 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=1576, ColumnName='PO_PaymentTerm_ID', Description='Payment rules for a purchase order', Help='The PO Payment Term indicates the payment term that will be used when this purchase order becomes an invoice.', Name='PO Payment Term', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 18:08:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205858
;

-- Apr 5, 2013 6:08:15 PM COT
UPDATE AD_Field SET Name='PO Payment Term', Description='Payment rules for a purchase order', Help='The PO Payment Term indicates the payment term that will be used when this purchase order becomes an invoice.' WHERE AD_Column_ID=205858 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 6:09:24 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=480, ColumnName='PO_PriceList_ID', Description='Price List used by this Business Partner', Help='Identifies the price list used by a Vendor for products purchased by this organization.', Name='Purchase Pricelist', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 18:09:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205859
;

-- Apr 5, 2013 6:09:24 PM COT
UPDATE AD_Field SET Name='Purchase Pricelist', Description='Price List used by this Business Partner', Help='Identifies the price list used by a Vendor for products purchased by this organization.' WHERE AD_Column_ID=205859 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 6:10:37 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Element_ID=200389, ColumnName='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL, Name='C_BPartner_SalesRep_ID', IsToolbarButton='N',Updated=TO_DATE('2013-04-05 18:10:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205863
;

-- Apr 5, 2013 6:10:37 PM COT
UPDATE AD_Field SET Name='C_BPartner_SalesRep_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205863 AND IsCentrallyMaintained='Y'
;

-- Apr 5, 2013 6:11:02 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-05 18:11:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205749
;

-- Apr 8, 2013 3:16:06 PM COT
UPDATE AD_Column SET ColumnName='C_Greeting_AD_Org_ID', Name='C_Greeting_AD_Org_ID',Updated=TO_DATE('2013-04-08 15:16:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205876
;

-- Apr 8, 2013 3:16:06 PM COT
UPDATE AD_Field SET Name='C_Greeting_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205876 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 3:16:06 PM COT
UPDATE AD_Column SET ColumnName='C_Location_AD_Org_ID', Name='C_Location_AD_Org_ID',Updated=TO_DATE('2013-04-08 15:16:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205901
;

-- Apr 8, 2013 3:16:06 PM COT
UPDATE AD_Field SET Name='C_Location_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205901 AND IsCentrallyMaintained='Y'
;
-- Apr 8, 2013 3:30:12 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_PaymentTerm_AD_Org_ID', Name='C_PaymentTerm_AD_Org_ID',Updated=TO_DATE('2013-04-08 15:30:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205797
;

-- Apr 8, 2013 3:30:12 PM COT
UPDATE AD_Field SET Name='C_PaymentTerm_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205797 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 3:36:17 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_User_Greeting_AD_Org_ID', Name='C_User_Greeting_AD_Org_ID',Updated=TO_DATE('2013-04-08 15:36:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205932
;

-- Apr 8, 2013 3:36:17 PM COT
UPDATE AD_Field SET Name='C_User_Greeting_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205932 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 3:56:27 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_Order_DropShip_BPartner_ID', Name='C_Order_DropShip_BPartner_ID',Updated=TO_DATE('2013-04-08 15:56:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205757
;

-- Apr 8, 2013 3:56:27 PM COT
UPDATE AD_Field SET Name='C_Order_DropShip_BPartner_ID', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Column_ID=205757 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 4:04:15 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_Order_DropShip_Location_ID', Name='Drop Shipment Location',Updated=TO_DATE('2013-04-08 16:04:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205758
;

-- Apr 8, 2013 4:04:15 PM COT
UPDATE AD_Field SET Name='Drop Shipment Location', Description='Business Partner Location for shipping to', Help=NULL WHERE AD_Column_ID=205758 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 4:11:55 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_Order_DropShip_User_ID', Name='Drop Shipment Contact',Updated=TO_DATE('2013-04-08 16:11:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205759
;

-- Apr 8, 2013 4:11:55 PM COT
UPDATE AD_Field SET Name='Drop Shipment Contact', Description='Business Partner Contact for drop shipment', Help=NULL WHERE AD_Column_ID=205759 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 4:14:08 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_Order_Link_Order_ID', Name='Linked Order',Updated=TO_DATE('2013-04-08 16:14:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205773
;

-- Apr 8, 2013 4:14:08 PM COT
UPDATE AD_Field SET Name='Linked Order', Description='This field links a sales order to the purchase order that is generated from it.', Help=NULL WHERE AD_Column_ID=205773 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 4:14:58 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='M_Warehouse_AD_Org_ID', Name='M_Warehouse_AD_Org_ID',Updated=TO_DATE('2013-04-08 16:14:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205787
;

-- Apr 8, 2013 4:14:58 PM COT
UPDATE AD_Field SET Name='M_Warehouse_AD_Org_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205787 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 4:17:56 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='M_WarehouseSource_ID', Name='Source Warehouse',Updated=TO_DATE('2013-04-08 16:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205792
;

-- Apr 8, 2013 4:17:56 PM COT
UPDATE AD_Field SET Name='Source Warehouse', Description='Optional Warehouse to replenish from', Help='If defined, the warehouse selected is used to replenish the product(s)' WHERE AD_Column_ID=205792 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 4:22:07 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='Pay_BPartner_ID',Updated=TO_DATE('2013-04-08 16:22:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205776
;


-- Apr 8, 2013 5:27:37 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_Order_Ref_Order_ID', Name='C_Order_Ref_Order_ID',Updated=TO_DATE('2013-04-08 17:27:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205783
;

-- Apr 8, 2013 5:27:37 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET Name='C_Order_Ref_Order_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205783 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 5:30:29 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET AD_Reference_ID=19, ColumnName='C_Order_User1_ID ', Name='C_Order_User1_ID ',Updated=TO_DATE('2013-04-08 17:30:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205785
;

-- Apr 8, 2013 5:30:29 PM COT
UPDATE AD_Field SET Name='C_Order_User1_ID ', Description=NULL, Help=NULL WHERE AD_Column_ID=205785 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 5:30:39 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_Order_User1_ID', Name='C_Order_User1_ID',Updated=TO_DATE('2013-04-08 17:30:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=205785
;

-- Apr 8, 2013 5:30:39 PM COT
UPDATE AD_Field SET Name='C_Order_User1_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=205785 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 5:51:47 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='C_OrderLine_User1_ID', Name='C_OrderLine_User1_ID',Updated=TO_DATE('2013-04-08 17:51:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=210184
;

-- Apr 8, 2013 5:51:47 PM COT
UPDATE AD_Field SET Name='C_OrderLine_User1_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=210184 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 5:56:09 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='AD_User_AD_OrgTrx_ID', Name='AD_User_AD_OrgTrx_ID',Updated=TO_DATE('2013-04-08 17:56:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=206959
;

-- Apr 8, 2013 5:56:09 PM COT
UPDATE AD_Field SET Name='AD_User_AD_OrgTrx_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=206959 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 5:56:39 PM COT
UPDATE AD_Column SET AD_Reference_ID=19, ColumnName='AD_User_C_BPartner_ID ', Name='AD_User_C_BPartner_ID ',Updated=TO_DATE('2013-04-08 17:56:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=206961
;

-- Apr 8, 2013 5:56:39 PM COT
UPDATE AD_Field SET Name='AD_User_C_BPartner_ID ', Description=NULL, Help=NULL WHERE AD_Column_ID=206961 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 6:10:25 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, ColumnName='AD_User_C_BPartner_ID', Name='AD_User_C_BPartner_ID',Updated=TO_DATE('2013-04-08 18:10:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=206961
;

-- Apr 8, 2013 6:10:25 PM COT
UPDATE AD_Field SET Name='AD_User_C_BPartner_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=206961 AND IsCentrallyMaintained='Y'
;

-- Apr 8, 2013 6:49:47 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 18:49:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=57593
;

-- Apr 8, 2013 6:58:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 18:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=57598
;

-- Apr 8, 2013 6:58:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 18:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=57597
;

-- Apr 8, 2013 6:58:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 18:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=59577
;


-- Apr 8, 2013 6:58:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 18:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=207021
;

-- Apr 8, 2013 6:58:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 18:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=207205
;

-- Apr 8, 2013 6:58:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 18:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=207056
;

-- Apr 8, 2013 6:58:48 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,FieldLength=10, Name='C_OrderLine_M_Shipper_ID',Updated=TO_DATE('2013-04-08 18:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=207056
;

-- Apr 8, 2013 7:56:10 PM COT
UPDATE AD_Column SET AD_Reference_ID=18,Updated=TO_DATE('2013-04-08 19:56:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=57338
;

-- Apr 8, 2013 7:57:52 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-08 19:57:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=204815
;

-- Apr 8, 2013 7:57:52 PM COT
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-08 19:57:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=204815
;

-- Apr 9, 2013 10:07:55 AM COT
UPDATE AD_Column SET ColumnName='DropShip_User_ID',Updated=TO_DATE('2013-04-09 10:07:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=205759
;

-- Apr 9, 2013 10:39:53 AM COT
UPDATE AD_Element SET ColumnName='DropShip_BPartner_ID', Name='DropShip_BPartner_ID', PrintName='DropShip_BPartner_ID',Updated=TO_DATE('2013-04-09 10:39:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53458
;

-- Apr 9, 2013 10:39:53 AM COT
UPDATE AD_Column SET ColumnName='DropShip_BPartner_ID', Name='DropShip_BPartner_ID', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Element_ID=53458
;

-- Apr 9, 2013 10:39:53 AM COT
UPDATE AD_Process_Para SET ColumnName='DropShip_BPartner_ID', Name='DropShip_BPartner_ID', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.', AD_Element_ID=53458 WHERE UPPER(ColumnName)='DROPSHIP_BPARTNER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 9, 2013 10:39:53 AM COT
UPDATE AD_Process_Para SET ColumnName='DropShip_BPartner_ID', Name='DropShip_BPartner_ID', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Element_ID=53458 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 10:39:53 AM COT
UPDATE AD_InfoColumn SET ColumnName='DropShip_BPartner_ID', Name='DropShip_BPartner_ID', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Element_ID=53458 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 10:39:53 AM COT
UPDATE AD_Field SET Name='DropShip_BPartner_ID', Description='Business Partner to ship to', Help='If empty the business partner will be shipped to.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53458) AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 10:39:54 AM COT
UPDATE AD_PrintFormatItem SET PrintName='DropShip_BPartner_ID', Name='DropShip_BPartner_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53458)
;

-- Apr 9, 2013 10:40:50 AM COT
UPDATE AD_Column SET ColumnName='AD_Client_ID',Updated=TO_DATE('2013-04-09 10:40:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7086
;

-- Apr 9, 2013 10:53:45 AM COT
UPDATE AD_Element SET ColumnName='DropShip_User_ID',Updated=TO_DATE('2013-04-09 10:53:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53460
;

-- Apr 9, 2013 10:53:45 AM COT
UPDATE AD_Column SET ColumnName='DropShip_User_ID', Name='Drop Shipment Contact', Description='Business Partner Contact for drop shipment', Help=NULL WHERE AD_Element_ID=53460
;

-- Apr 9, 2013 10:53:45 AM COT
UPDATE AD_Process_Para SET ColumnName='DropShip_User_ID', Name='Drop Shipment Contact', Description='Business Partner Contact for drop shipment', Help=NULL, AD_Element_ID=53460 WHERE UPPER(ColumnName)='DROPSHIP_USER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 9, 2013 10:53:45 AM COT
UPDATE AD_Process_Para SET ColumnName='DropShip_User_ID', Name='Drop Shipment Contact', Description='Business Partner Contact for drop shipment', Help=NULL WHERE AD_Element_ID=53460 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 10:53:45 AM COT
UPDATE AD_InfoColumn SET ColumnName='DropShip_User_ID', Name='Drop Shipment Contact', Description='Business Partner Contact for drop shipment', Help=NULL WHERE AD_Element_ID=53460 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 11:05:15 AM COT
UPDATE AD_Element SET ColumnName='Link_Order_ID',Updated=TO_DATE('2013-04-09 11:05:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53462
;

-- Apr 9, 2013 11:05:15 AM COT
UPDATE AD_Column SET ColumnName='Link_Order_ID', Name='Linked Order', Description='This field links a sales order to the purchase order that is generated from it.', Help=NULL WHERE AD_Element_ID=53462
;

-- Apr 9, 2013 11:05:15 AM COT
UPDATE AD_Process_Para SET ColumnName='Link_Order_ID', Name='Linked Order', Description='This field links a sales order to the purchase order that is generated from it.', Help=NULL, AD_Element_ID=53462 WHERE UPPER(ColumnName)='LINK_ORDER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 9, 2013 11:05:15 AM COT
UPDATE AD_Process_Para SET ColumnName='Link_Order_ID', Name='Linked Order', Description='This field links a sales order to the purchase order that is generated from it.', Help=NULL WHERE AD_Element_ID=53462 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 11:05:15 AM COT
UPDATE AD_InfoColumn SET ColumnName='Link_Order_ID', Name='Linked Order', Description='This field links a sales order to the purchase order that is generated from it.', Help=NULL WHERE AD_Element_ID=53462 AND IsCentrallyMaintained='Y'
;


-- Apr 9, 2013 11:08:36 AM COT
UPDATE AD_Element SET ColumnName='Pay_Location_ID',Updated=TO_DATE('2013-04-09 11:08:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2421
;

-- Apr 9, 2013 11:08:36 AM COT
UPDATE AD_Column SET ColumnName='Pay_Location_ID', Name='Payment Location', Description='Location of the Business Partner responsible for the payment', Help=NULL WHERE AD_Element_ID=2421
;

-- Apr 9, 2013 11:08:36 AM COT
UPDATE AD_Process_Para SET ColumnName='Pay_Location_ID', Name='Payment Location', Description='Location of the Business Partner responsible for the payment', Help=NULL, AD_Element_ID=2421 WHERE UPPER(ColumnName)='PAY_LOCATION_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 9, 2013 11:08:36 AM COT
UPDATE AD_Process_Para SET ColumnName='Pay_Location_ID', Name='Payment Location', Description='Location of the Business Partner responsible for the payment', Help=NULL WHERE AD_Element_ID=2421 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 11:08:36 AM COT
UPDATE AD_InfoColumn SET ColumnName='Pay_Location_ID', Name='Payment Location', Description='Location of the Business Partner responsible for the payment', Help=NULL WHERE AD_Element_ID=2421 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 12:06:58 PM COT
UPDATE AD_Column SET AD_Element_ID=455, ColumnName='M_Shipper_ID', Description='Method or manner of product delivery', Help='The Shipper indicates the method of delivering product', Name='Shipper',Updated=TO_DATE('2013-04-09 12:06:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208087
;

-- Apr 9, 2013 12:06:58 PM COT
UPDATE AD_Field SET Name='Shipper', Description='Method or manner of product delivery', Help='The Shipper indicates the method of delivering product' WHERE AD_Column_ID=208087 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 1:43:32 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200037,Updated=TO_DATE('2013-04-09 13:43:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208053
;

-- Apr 9, 2013 2:10:48 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200037,Updated=TO_DATE('2013-04-09 14:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208087
;

-- Apr 9, 2013 2:31:03 PM COT
UPDATE AD_Column SET AD_Element_ID=201126, ColumnName='C_OrderLine_M_Shipper_ID', Description=NULL, Help=NULL, Name='C_OrderLine_M_Shipper_ID',Updated=TO_DATE('2013-04-09 14:31:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208087
;

-- Apr 9, 2013 2:31:03 PM COT
UPDATE AD_Field SET Name='C_OrderLine_M_Shipper_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=208087 AND IsCentrallyMaintained='Y'
;

-- Apr 9, 2013 2:39:53 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=271,Updated=TO_DATE('2013-04-09 14:39:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210206
;

SELECT register_migration_script('201304091604_IDEMPIERE-794.sql') FROM dual
;

