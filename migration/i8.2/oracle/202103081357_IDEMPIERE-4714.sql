-- IDEMPIERE-4714 email password changes being displayed in the change log

-- set non-secure the columns that are not passwords or really sensitive
UPDATE AD_Column
SET IsSecure='N' WHERE IsSecure='Y' AND AD_Column_ID IN (
6559 /* AD_Client.RequestUser */,
4771 /* AD_Client.SMTPHost */,
200972 /* AD_StorageProvider.Folder */,
200971 /* AD_StorageProvider.URL */,
200973 /* AD_StorageProvider.UserName */,
12943 /* AD_System.DBAddress */,
12944 /* AD_System.DBInstance */,
12402 /* AD_System.LDAPDomain */,
12409 /* AD_System.LDAPHost */,
14856 /* AD_System.SupportEMail */,
7806 /* AD_System.UserName */,
7793 /* AD_User.EMailUser */,
213690 /* AD_User.IsNoExpire */,
200409 /* AD_User.IsNoPasswordReset */,
12401 /* AD_User.LDAPUser */,
210755 /* C_AddressValidation.ConnectionKey */,
210766 /* C_AddressValidation.UserID */,
210738 /* C_AddressValidationCfg.HostAddress */,
210744 /* C_AddressValidationCfg.ProxyAddress */,
210745 /* C_AddressValidationCfg.ProxyLogon */,
200895 /* C_BankAccount_Processor.PartnerID */,
200897 /* C_BankAccount_Processor.UserID */,
200896 /* C_BankAccount_Processor.VendorID */,
10365 /* C_BankStatementLoader.HostAddress */,
10350 /* C_BankStatementLoader.ProxyAddress */,
10356 /* C_BankStatementLoader.ProxyLogon */,
10360 /* C_BankStatementLoader.UserID */,
201174 /* C_BP_ShippingAcct.DutiesShipperAccount */,
201176 /* C_BP_ShippingAcct.ShipperAccount */,
201177 /* C_BP_ShippingAcct.ShipperMeter */,
200612 /* C_BPartner.CustomerProfileID */,
5060 /* C_PaymentProcessor.HostAddress */,
5062 /* C_PaymentProcessor.ProxyAddress */,
5064 /* C_PaymentProcessor.ProxyLogon */,
54539 /* EXP_Processor.Account */,
54537 /* EXP_Processor.Host */,
54589 /* IMP_Processor.Account */,
54587 /* IMP_Processor.Host */,
201024 /* M_ShippingProcessor.ConnectionKey */,
201034 /* M_ShippingProcessor.UserID */,
202058 /* M_ShippingProcessorCfg.HostAddress */,
202064 /* M_ShippingProcessorCfg.ProxyAddress */,
202065 /* M_ShippingProcessorCfg.ProxyLogon */,
202216 /* M_ShippingTransaction.ShipperAccount */)
;

-- set secure the columns that are password related
UPDATE AD_Column
SET IsSecure='Y' WHERE IsSecure='N' AND AD_Column_ID IN (
213173 /* AD_AllUsers_V.UserPIN */,
212109 /* AD_Password_History.Password */,
9340 /* AD_System.Password */,
51004 /* C_Country.LookupPassword */,
15243 /* CM_Media_Server.Password */,
7891 /* I_BPartner.Password */)
;

-- disallow logging for secure content
UPDATE AD_Column SET IsAllowLogging='N' WHERE IsAllowLogging='Y' AND IsSecure='Y'
;

SELECT register_migration_script('202103081357_IDEMPIERE-4714.sql') FROM dual
;

