-- Columns in dictionary not in DB
UPDATE AD_Column SET IsActive='N'
WHERE AD_Column_ID IN (
201380, /*  C_Dunning_Header_v.AD_User_AD_OrgTrx_ID  */
210182, /*  C_Invoice_Header_v.AD_User_AD_OrgTrx_ID  */
210177, /*  C_Invoice_Header_v.C_BPartner_BPartner_Parent_ID  */
210179, /*  C_Invoice_Header_v.C_BPartner_C_Dunning_ID  */
210180, /*  C_Invoice_Header_v.C_BPartner_InvoiceSchedule_ID  */
203538, /*  C_Invoice_Header_v.C_BPartner_SalesRep_ID  */
205820, /*  C_Order_Header_v.C_BPartner_AD_OrgBP_ID  */
205821, /*  C_Order_Header_v.C_BPartner_AD_Org_ID  */
205822, /*  C_Order_Header_v.C_BPartner_BPartner_Parent_ID  */
205823, /*  C_Order_Header_v.C_BPartner_C_BP_Group_ID  */
205824, /*  C_Order_Header_v.C_BPartner_C_Dunning_ID  */
205825, /*  C_Order_Header_v.C_BPartner_C_Greeting_ID  */
205827, /*  C_Order_Header_v.C_BPartner_C_PaymentTerm_ID  */
205830, /*  C_Order_Header_v.C_BPartner_C_TaxGroup_ID  */
205826, /*  C_Order_Header_v.C_BPartner_InvoiceSchedule_ID  */
205880, /*  C_Order_Header_v.C_BPartner_Location_AD_Org_ID  */
205851, /*  C_Order_Header_v.C_BPartner_Logo_ID  */
205852, /*  C_Order_Header_v.C_BPartner_M_DiscountSchema_ID  */
205853, /*  C_Order_Header_v.C_BPartner_M_PriceList_ID  */
205863, /*  C_Order_Header_v.C_BPartner_SalesRep_ID  */
205857, /*  C_Order_Header_v.PO_DiscountSchema_ID  */
205858, /*  C_Order_Header_v.PO_PaymentTerm_ID  */
205859, /*  C_Order_Header_v.PO_PriceList_ID  */
204009, /*  C_Order_LineTax_v.C_Charge_AD_Org_ID  */
207159, /*  M_InOut_Header_v.AD_User_AD_OrgTrx_ID  */
53004,  /*  M_Product_Stock_V.M_Product_ID  */
53005,  /*  M_Product_Stock_V.Name  */
53023,  /*  M_Product_SubstituteRelated_V.Description  */
57492,  /*  PP_Order_Workflow_Header_v.QtyBatchSize  */
53783,  /*  RV_PP_Order_Transactions.AD_User_ID  */
53802,  /*  RV_PP_Order_Transactions.UserAgent  */
54016,  /*  RV_PP_Product_Costing.AD_Client_ID  */
54017,  /*  RV_PP_Product_Costing.AD_Org_ID  */
54018,  /*  RV_PP_Product_Costing.Created  */
54019,  /*  RV_PP_Product_Costing.CreatedBy  */
54020,  /*  RV_PP_Product_Costing.IsActive  */
54021,  /*  RV_PP_Product_Costing.Updated  */
54022)  /*  RV_PP_Product_Costing.UpdatedBy  */
;

-- Tables in dictionary not in DB
UPDATE AD_Table SET IsActive='N'
WHERE AD_Table_ID IN (
53033, /*  RV_PP_WIP  */
53042) /*  RV_PP_Product_Costing  */
;

-- Jun 26, 2013 6:32:13 PM COT
-- Fix window without tablevel 0
UPDATE AD_Tab SET TabLevel=0,Updated=TO_TIMESTAMP('2013-06-26 18:32:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53325
;

SELECT register_migration_script('201306261814_PreReleaseCleanup.sql') FROM dual
;

