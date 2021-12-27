SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4448 Autocomplete/Info Window doesn't work correctly with Search fields with Reference
UPDATE AD_Ref_Table SET AD_Display=213145,IsValueDisplayed='N' WHERE AD_Reference_ID=200144 /* AD_Client All Clients - AD_AllClients_V_ID */
;

UPDATE AD_Ref_Table SET AD_Display=213158,IsValueDisplayed='N' WHERE AD_Reference_ID=200145 /* AD_User Users from all Clients - AD_AllUsers_V_ID */
;

UPDATE AD_Ref_Table SET AD_Display=59694,IsValueDisplayed='N' WHERE AD_Reference_ID=200183 /* AD_Chart - AD_Chart_ID */
;

UPDATE AD_Ref_Table SET AD_Display=207,IsValueDisplayed='N' WHERE AD_Reference_ID=129 /* AD_Client - AD_Client_ID */
;

UPDATE AD_Ref_Table SET AD_Display=15595,IsValueDisplayed='N' WHERE AD_Reference_ID=389 /* _EntityTypeNew - AD_EntityType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6287,IsValueDisplayed='N' WHERE AD_Reference_ID=200182 /* AD_Image - AD_Image_ID */
;

UPDATE AD_Ref_Table SET AD_Display=15744,IsValueDisplayed='N' WHERE AD_Reference_ID=200071 /* AD_RelatedInfoWindow - AD_InfoWindow_ID */
;

UPDATE AD_Ref_Table SET AD_Display=9622,IsValueDisplayed='N' WHERE AD_Reference_ID=106 /* AD_Language - AD_Language_ID */
;

UPDATE AD_Ref_Table SET AD_Display=9622,IsValueDisplayed='N' WHERE AD_Reference_ID=200069 /* AD_Language NOT System/Base - AD_Language_ID */
;

UPDATE AD_Ref_Table SET AD_Display=9622,IsValueDisplayed='N' WHERE AD_Reference_ID=327 /* AD_Language System - AD_Language_ID */
;

UPDATE AD_Ref_Table SET AD_Display=228,IsValueDisplayed='N' WHERE AD_Reference_ID=105 /* AD_Menu Parent - AD_Menu_ID */
;

UPDATE AD_Ref_Table SET AD_Display=528,IsValueDisplayed='N' WHERE AD_Reference_ID=113 /* AD_Org Parent - AD_Org_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6975,IsValueDisplayed='N' WHERE AD_Reference_ID=266 /* AD_PrintColor - AD_PrintColor_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6989,IsValueDisplayed='N' WHERE AD_Reference_ID=267 /* AD_PrintFont - AD_PrintFont_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=269 /* AD_PrintFormat Not TableBased - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=53282 /* AD_PrintFormat Distribution Order - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=261 /* AD_PrintFormat Invoice - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=53281 /* AD_PrintFormat Manufacturing Order - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=263 /* AD_PrintFormat Shipment - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=262 /* AD_PrintFormat Order - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=259 /* AD_PrintFormat - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=7026,IsValueDisplayed='N' WHERE AD_Reference_ID=268 /* AD_PrintFormat Check - AD_PrintFormat_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6954,IsValueDisplayed='N' WHERE AD_Reference_ID=264 /* AD_PrintFormatItem - AD_PrintFormatItem_ID */
;

UPDATE AD_Ref_Table SET AD_Display=531,IsValueDisplayed='N' WHERE AD_Reference_ID=53317 /* AD_Role - AD_Role_ID */
;

UPDATE AD_Ref_Table SET AD_Display=54248,IsValueDisplayed='N' WHERE AD_Reference_ID=53372 /* Reconciliation Rules - AD_Rule_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1186,IsValueDisplayed='N' WHERE AD_Reference_ID=128 /* AD_Sequence for Documents - AD_Sequence_ID */
;

UPDATE AD_Ref_Table SET AD_Display=212734,IsValueDisplayed='N' WHERE AD_Reference_ID=200121 /* AD_Style - AD_Style_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2856,IsValueDisplayed='N' WHERE AD_Reference_ID=184 /* AD_Tree - AD_Tree_ID */
;

UPDATE AD_Ref_Table SET AD_Display=212,IsValueDisplayed='N' WHERE AD_Reference_ID=286 /* AD_User - Internal - AD_User_ID */
;

UPDATE AD_Ref_Table SET AD_Display=212,IsValueDisplayed='N' WHERE AD_Reference_ID=110 /* AD_User - AD_User_ID */
;

UPDATE AD_Ref_Table SET AD_Display=212,IsValueDisplayed='N' WHERE AD_Reference_ID=190 /* AD_User - SalesRep - AD_User_ID */
;

UPDATE AD_Ref_Table SET AD_Display=212,IsValueDisplayed='N' WHERE AD_Reference_ID=316 /* AD_User - Supervisor - AD_User_ID */
;

UPDATE AD_Ref_Table SET AD_Display=187,IsValueDisplayed='N' WHERE AD_Reference_ID=100 /* AD_Validation Rules Parent - AD_Val_Rule_ID */
;

UPDATE AD_Ref_Table SET AD_Display=293,IsValueDisplayed='N' WHERE AD_Reference_ID=109 /* AD_WF_Next Nodes - AD_WF_Node_ID */
;

UPDATE AD_Ref_Table SET AD_Display=155,IsValueDisplayed='N' WHERE AD_Reference_ID=284 /* AD_Window - AD_Window_ID */
;

UPDATE AD_Ref_Table SET AD_Display=351,IsValueDisplayed='N' WHERE AD_Reference_ID=53319 /* AD_Workflow_Manufacturing - AD_Workflow_ID */
;

UPDATE AD_Ref_Table SET AD_Display=351,IsValueDisplayed='N' WHERE AD_Reference_ID=174 /* AD_Workflow - AD_Workflow_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2463,IsValueDisplayed='N' WHERE AD_Reference_ID=136 /* C_AcctSchema - C_AcctSchema_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3457,IsValueDisplayed='N' WHERE AD_Reference_ID=142 /* C_Activity (No summary) - C_Activity_ID */
;

UPDATE AD_Ref_Table SET AD_Display=12310,IsValueDisplayed='N' WHERE AD_Reference_ID=323 /* C_Allocation - C_AllocationHdr_ID */
;

UPDATE AD_Ref_Table SET AD_Display=4961,IsValueDisplayed='N' WHERE AD_Reference_ID=200045 /* C_BP_Group - C_BP_Group_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=353 /* C_BPartner SalesRep - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=223 /* C_BPartner Vendors Avtive - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=192 /* C_BPartner Vendors - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=200175 /* C_BPartner (all) - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=232 /* C_BPartner Vendor or SalesRep - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=124 /* C_BPartner Parent - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=53335 /* C_BPartner -Active,Manufacturer, Non summary - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=277 /* C_BPartner Employee w Address - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=252 /* C_BPartner Employee - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=173 /* C_BPartner Customers - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3434,IsValueDisplayed='N' WHERE AD_Reference_ID=159 /* C_BPartner Location - C_BPartner_Location_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5260,IsValueDisplayed='N' WHERE AD_Reference_ID=52004 /* C_CashBook - C_CashBook_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3333,IsValueDisplayed='N' WHERE AD_Reference_ID=200 /* C_Charge - C_Charge_ID */
;

UPDATE AD_Ref_Table SET AD_Display=10269,IsValueDisplayed='N' WHERE AD_Reference_ID=352 /* C_ConversionType - C_ConversionType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=941,IsValueDisplayed='N' WHERE AD_Reference_ID=156 /* C_Country - C_Country_ID */
;

UPDATE AD_Ref_Table SET AD_Display=457,IsValueDisplayed='N' WHERE AD_Reference_ID=112 /* C_Currencies - C_Currency_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1501,IsValueDisplayed='N' WHERE AD_Reference_ID=53233 /* C_DocType MFG - C_DocType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1501,IsValueDisplayed='N' WHERE AD_Reference_ID=172 /* C_DocType SO - C_DocType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1501,IsValueDisplayed='N' WHERE AD_Reference_ID=170 /* C_DocType - C_DocType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1501,IsValueDisplayed='N' WHERE AD_Reference_ID=53289 /* C_DocType MFG Cost Collector - C_DocType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1501,IsValueDisplayed='N' WHERE AD_Reference_ID=321 /* C_DocType RMA - C_DocType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3137,IsValueDisplayed='N' WHERE AD_Reference_ID=200044 /* C_Dunning - C_Dunning_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3701,IsValueDisplayed='N' WHERE AD_Reference_ID=200043 /* C_DunningLevel - C_DunningLevel_ID */
;

UPDATE AD_Ref_Table SET AD_Display=464,IsValueDisplayed='N' WHERE AD_Reference_ID=145 /* C_Element - C_Element_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1125,IsValueDisplayed='N' WHERE AD_Reference_ID=132 /* Account_ID (Trx) - C_ElementValue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1125,IsValueDisplayed='N' WHERE AD_Reference_ID=134 /* Account_ID - User1 - C_ElementValue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1125,IsValueDisplayed='N' WHERE AD_Reference_ID=182 /* C_ElementValue (all) - C_ElementValue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1125,IsValueDisplayed='N' WHERE AD_Reference_ID=200002 /* C_ElementValue (trx) Not Doc Controlled - C_ElementValue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1125,IsValueDisplayed='N' WHERE AD_Reference_ID=331 /* Account_ID - C_ElementValue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1125,IsValueDisplayed='N' WHERE AD_Reference_ID=362 /* C_ElementValue (trx) - C_ElementValue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1125,IsValueDisplayed='N' WHERE AD_Reference_ID=137 /* Account_ID - User2 - C_ElementValue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=4069,IsValueDisplayed='N' WHERE AD_Reference_ID=356 /* C_Greeting - C_Greeting_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2136,IsValueDisplayed='N' WHERE AD_Reference_ID=200046 /* C_InvoiceSchedule - C_InvoiceSchedule_ID */
;

UPDATE AD_Ref_Table SET AD_Display=808,IsValueDisplayed='N' WHERE AD_Reference_ID=133 /* C_Location - C_Location_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2027,IsValueDisplayed='N' WHERE AD_Reference_ID=53384 /* C_PaymentTerm Purchases - C_PaymentTerm_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2027,IsValueDisplayed='N' WHERE AD_Reference_ID=53383 /* C_PaymentTerm Sales - C_PaymentTerm_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2027,IsValueDisplayed='N' WHERE AD_Reference_ID=227 /* C_PaymentTerm - C_PaymentTerm_ID */
;

UPDATE AD_Ref_Table SET AD_Display=837,IsValueDisplayed='N' WHERE AD_Reference_ID=53366 /* C_Period - all, acct, sysdate, desc - C_Period_ID */
;

UPDATE AD_Ref_Table SET AD_Display=837,IsValueDisplayed='N' WHERE AD_Reference_ID=233 /* C_Period (Open) - C_Period_ID */
;

UPDATE AD_Ref_Table SET AD_Display=837,IsValueDisplayed='N' WHERE AD_Reference_ID=275 /* C_Period (all) - C_Period_ID */
;

UPDATE AD_Ref_Table SET AD_Display=12758,IsValueDisplayed='N' WHERE AD_Reference_ID=53350 /* C_POSKeyLayout - C_POSKeyLayout_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1349,IsValueDisplayed='N' WHERE AD_Reference_ID=141 /* C_Project (No summary) - C_Project_ID */
;

UPDATE AD_Ref_Table SET AD_Display=8709,IsValueDisplayed='N' WHERE AD_Reference_ID=200059 /* C_ProjectType - C_ProjectType_ID */
;

UPDATE AD_Ref_Table SET AD_Display=856,IsValueDisplayed='N' WHERE AD_Reference_ID=157 /* C_Region - C_Region_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1823,IsValueDisplayed='N' WHERE AD_Reference_ID=179 /* C_SalesRegion Parent - C_SalesRegion_ID */
;

UPDATE AD_Ref_Table SET AD_Display=62154,IsValueDisplayed='N' WHERE AD_Reference_ID=53424 /* C_SalesStage - C_SalesStage_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2240,IsValueDisplayed='N' WHERE AD_Reference_ID=158 /* C_Tax - C_Tax_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2066,IsValueDisplayed='N' WHERE AD_Reference_ID=200053 /* C_TaxCategory - C_TaxCategory_ID */
;

UPDATE AD_Ref_Table SET AD_Display=54398,IsValueDisplayed='N' WHERE AD_Reference_ID=200047 /* C_TaxGroup - C_TaxGroup_ID */
;

UPDATE AD_Ref_Table SET AD_Display=485,IsValueDisplayed='N' WHERE AD_Reference_ID=114 /* C_UOM - C_UOM_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1014,IsValueDisplayed='N' WHERE AD_Reference_ID=175 /* C_ValidCombination - C_ValidCombination_ID */
;

UPDATE AD_Ref_Table SET AD_Display=15147,IsValueDisplayed='N' WHERE AD_Reference_ID=386 /* CM_Container - CM_Container_ID */
;

UPDATE AD_Ref_Table SET AD_Display=15323,IsValueDisplayed='N' WHERE AD_Reference_ID=387 /* CM_CStage - CM_CStage_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1617,IsValueDisplayed='N' WHERE AD_Reference_ID=53250 /* GL_Journal - GL_Journal_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1641,IsValueDisplayed='N' WHERE AD_Reference_ID=53251 /* GL_JournalBatch - GL_JournalBatch_ID */
;

UPDATE AD_Ref_Table SET AD_Display=54804,IsValueDisplayed='N' WHERE AD_Reference_ID=53244 /* HR Job - HR_Job_ID */
;

UPDATE AD_Ref_Table SET AD_Display=54988,IsValueDisplayed='N' WHERE AD_Reference_ID=53246 /* HR Table - HR_List_ID */
;

UPDATE AD_Ref_Table SET AD_Display=9498,IsValueDisplayed='N' WHERE AD_Reference_ID=285 /* K_Entry Related - K_Entry_ID */
;

UPDATE AD_Ref_Table SET AD_Display=8490,IsValueDisplayed='N' WHERE AD_Reference_ID=200055 /* M_AttributeSet - M_AttributeSet_ID */
;

UPDATE AD_Ref_Table SET AD_Display=13924,IsValueDisplayed='N' WHERE AD_Reference_ID=351 /* M_ChangeNotice - M_ChangeNotice_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6581,IsValueDisplayed='N' WHERE AD_Reference_ID=249 /* M_DiscountSchema - M_DiscountSchema_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6581,IsValueDisplayed='N' WHERE AD_Reference_ID=53343 /* M_DiscountSchema PL - M_DiscountSchema_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6581,IsValueDisplayed='N' WHERE AD_Reference_ID=325 /* M_DiscountSchema not PL - M_DiscountSchema_ID */
;

UPDATE AD_Ref_Table SET AD_Display=9093,IsValueDisplayed='N' WHERE AD_Reference_ID=200051 /* M_FreightCategory - M_FreightCategory_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3542,IsValueDisplayed='N' WHERE AD_Reference_ID=53249 /* M_Inventory - M_Inventory_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1389,IsValueDisplayed='N' WHERE AD_Reference_ID=191 /* M_Locator - M_Locator_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6497,IsValueDisplayed='N' WHERE AD_Reference_ID=53363 /* M_MatchInv for Asset Addition - M_MatchInv_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6497,IsValueDisplayed='N' WHERE AD_Reference_ID=200018 /* M_MatchInv - M_MatchInv_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6513,IsValueDisplayed='N' WHERE AD_Reference_ID=200017 /* M_MatchPO - M_MatchPO_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3569,IsValueDisplayed='N' WHERE AD_Reference_ID=53252 /* M_Movement - M_Movement_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2100,IsValueDisplayed='N' WHERE AD_Reference_ID=166 /* M_PriceList - M_PriceList_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2987,IsValueDisplayed='N' WHERE AD_Reference_ID=199 /* M_PriceList_Version for Client - M_PriceList_Version_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2987,IsValueDisplayed='N' WHERE AD_Reference_ID=188 /* M_PriceList Version - M_PriceList_Version_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3596,IsValueDisplayed='N' WHERE AD_Reference_ID=200080 /* M_Production - M_Production_ID */
;

UPDATE AD_Ref_Table SET AD_Display=57057,IsValueDisplayed='N' WHERE AD_Reference_ID=200048 /* M_Promotion - M_Promotion_ID */
;

UPDATE AD_Ref_Table SET AD_Display=10847,IsValueDisplayed='N' WHERE AD_Reference_ID=53306 /* M_RMA - M_RMA_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2077,IsValueDisplayed='N' WHERE AD_Reference_ID=200037 /* M_Shipper - M_Shipper_ID */
;

UPDATE AD_Ref_Table SET AD_Display=201094,IsValueDisplayed='N' WHERE AD_Reference_ID=200040 /* M_ShipperLabels - M_ShipperLabels_ID */
;

UPDATE AD_Ref_Table SET AD_Display=201118,IsValueDisplayed='N' WHERE AD_Reference_ID=200039 /* M_ShipperPackaging - M_ShipperPackaging_ID */
;

UPDATE AD_Ref_Table SET AD_Display=201133,IsValueDisplayed='N' WHERE AD_Reference_ID=200041 /* M_ShipperPickupTypes - M_ShipperPickupTypes_ID */
;

UPDATE AD_Ref_Table SET AD_Display=201018,IsValueDisplayed='N' WHERE AD_Reference_ID=200038 /* M_ShippingProcessor - M_ShippingProcessor_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1151,IsValueDisplayed='N' WHERE AD_Reference_ID=197 /* M_Warehouse of Client - M_Warehouse_ID */
;

UPDATE AD_Ref_Table SET AD_Display=214429,IsValueDisplayed='N' WHERE AD_Reference_ID=200191 /* MFA_Method - on client rule - MFA_Method_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5856,IsValueDisplayed='N' WHERE AD_Reference_ID=229 /* PA_Achievement Parent - PA_Achievement_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5884,IsValueDisplayed='N' WHERE AD_Reference_ID=228 /* PA_Goal - PA_Goal_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5884,IsValueDisplayed='N' WHERE AD_Reference_ID=230 /* PA_Goal Parent - PA_Goal_ID */
;

UPDATE AD_Ref_Table SET AD_Display=14813,IsValueDisplayed='N' WHERE AD_Reference_ID=371 /* PA_Ratio - PA_Ratio_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5999,IsValueDisplayed='N' WHERE AD_Reference_ID=239 /* PA_ReportColumn - PA_ReportColumn_ID */
;

UPDATE AD_Ref_Table SET AD_Display=57562,IsValueDisplayed='N' WHERE AD_Reference_ID=53299 /* PA_ReportCube - PA_ReportCube_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6045,IsValueDisplayed='N' WHERE AD_Reference_ID=242 /* PA_ReportLine Parent - PA_ReportLine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6045,IsValueDisplayed='N' WHERE AD_Reference_ID=240 /* PA_ReportLine - PA_ReportLine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=53486,IsValueDisplayed='N' WHERE AD_Reference_ID=53232 /* PP_Order_Node - PP_Order_Node_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5403,IsValueDisplayed='N' WHERE AD_Reference_ID=274 /* R_MailText - R_MailText_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5415,IsValueDisplayed='N' WHERE AD_Reference_ID=341 /* R_Request - R_Request_ID */
;

UPDATE AD_Ref_Table SET AD_Display=6862,IsValueDisplayed='N' WHERE AD_Reference_ID=53320 /* S_Resource_Manufacturing - S_Resource_ID */
;

UPDATE AD_Ref_Table SET AD_Display=52041,IsValueDisplayed='N' WHERE AD_Reference_ID=52000 /* U_WebMenu_ID - U_WebMenu_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1402,IsValueDisplayed='N' WHERE AD_Reference_ID=162 /* M_Product (no summary) - M_Product_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1402,IsValueDisplayed='N' WHERE AD_Reference_ID=171 /* M_Product (stocked) - M_Product_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1402,IsValueDisplayed='N' WHERE AD_Reference_ID=211 /* M_Product BOM (stocked) - M_Product_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1402,IsValueDisplayed='N' WHERE AD_Reference_ID=161 /* M_Product Parent - M_Product_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1402,IsValueDisplayed='N' WHERE AD_Reference_ID=200176 /* M_Product (all) - M_Product_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2205,IsValueDisplayed='N' WHERE AD_Reference_ID=271 /* C_OrderLine - C_OrderLine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=9850,IsValueDisplayed='N' WHERE AD_Reference_ID=200060 /* C_ProjectIssue - C_ProjectIssue_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2594,IsValueDisplayed='N' WHERE AD_Reference_ID=200190 /* AD_Element - AD_Element_ID */
;

UPDATE AD_Ref_Table SET AD_Display=109,IsValueDisplayed='N' WHERE AD_Reference_ID=3 /* AD_Column ColumName - AD_Column_ID */
;

UPDATE AD_Ref_Table SET AD_Display=109,IsValueDisplayed='N' WHERE AD_Reference_ID=257 /* AD_Column Integer - AD_Column_ID */
;

UPDATE AD_Ref_Table SET AD_Display=109,IsValueDisplayed='N' WHERE AD_Reference_ID=244 /* AD_Column Key ColumnNames - AD_Column_ID */
;

UPDATE AD_Ref_Table SET AD_Display=109,IsValueDisplayed='N' WHERE AD_Reference_ID=251 /* AD_Column Name - AD_Column_ID */
;

UPDATE AD_Ref_Table SET AD_Display=109,IsValueDisplayed='N' WHERE AD_Reference_ID=258 /* AD_Column YesNo - AD_Column_ID */
;

UPDATE AD_Ref_Table SET AD_Display=109,IsValueDisplayed='N' WHERE AD_Reference_ID=272 /* I_ElementValue Column - AD_Column_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3484,IsValueDisplayed='N' WHERE AD_Reference_ID=336 /* C_Invoice - C_Invoice_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3484,IsValueDisplayed='N' WHERE AD_Reference_ID=53274 /* DocumentNo Invoice Vendor - C_Invoice_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2161,IsValueDisplayed='N' WHERE AD_Reference_ID=290 /* C_Order - C_Order_ID */
;

UPDATE AD_Ref_Table SET AD_Display=5043,IsValueDisplayed='N' WHERE AD_Reference_ID=343 /* C_Payment - C_Payment_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3521,IsValueDisplayed='N' WHERE AD_Reference_ID=337 /* M_InOut - M_InOut_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3582,IsValueDisplayed='N' WHERE AD_Reference_ID=53284 /* M_MovementLine - M_MovementLine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3529,IsValueDisplayed='N' WHERE AD_Reference_ID=295 /* M_InOutLine - M_InOutLine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3555,IsValueDisplayed='N' WHERE AD_Reference_ID=296 /* M_InventoryLine - M_InventoryLine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3611,IsValueDisplayed='N' WHERE AD_Reference_ID=297 /* M_ProductionLine - M_ProductionLine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=10831,IsValueDisplayed='N' WHERE AD_Reference_ID=53307 /* M_RMALine - M_RMALine_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3658,IsValueDisplayed='N' WHERE AD_Reference_ID=298 /* M_Transaction - M_Transaction_ID */
;

UPDATE AD_Ref_Table SET AD_Display=528,IsValueDisplayed='N' WHERE AD_Reference_ID=322 /* AD_Org (all but 0) - AD_Org_ID */
;

UPDATE AD_Ref_Table SET AD_Display=528,IsValueDisplayed='N' WHERE AD_Reference_ID=276 /* AD_Org (all) - AD_Org_ID */
;

UPDATE AD_Ref_Table SET AD_Display=528,IsValueDisplayed='N' WHERE AD_Reference_ID=130 /* AD_Org (Trx) - AD_Org_ID */
;

UPDATE AD_Ref_Table SET AD_Display=208688,IsValueDisplayed='N' WHERE AD_Reference_ID=200065 /* ASU_1099Box - C_1099Box_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2893,IsValueDisplayed='N' WHERE AD_Reference_ID=138 /* C_BPartner (Trx) - C_BPartner_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2570,IsValueDisplayed='N' WHERE AD_Reference_ID=143 /* C_Campaign (No summary) - C_Campaign_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1823,IsValueDisplayed='N' WHERE AD_Reference_ID=144 /* C_Sales Region (No summary) - C_SalesRegion_ID */
;

UPDATE AD_Ref_Table SET AD_Display=211620,IsValueDisplayed='N' WHERE AD_Reference_ID=200092 /* Country Group - C_CountryGroup_ID */
;

UPDATE AD_Ref_Table SET AD_Display=54487,IsValueDisplayed='N' WHERE AD_Reference_ID=53242 /* EXP_Format - EXP_Format_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2020,IsValueDisplayed='N' WHERE AD_Reference_ID=163 /* M_Product Category  - M_Product_Category_ID */
;

UPDATE AD_Ref_Table SET AD_Display=160,IsValueDisplayed='N' WHERE AD_Reference_ID=278 /* AD_Tab - AD_Tab_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3077,IsValueDisplayed='N' WHERE AD_Reference_ID=53283 /* C_BankAccount - C_BankAccount_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3077,IsValueDisplayed='N' WHERE AD_Reference_ID=193 /* C_BankAccount for Credit Card - C_BankAccount_ID */
;

UPDATE AD_Ref_Table SET AD_Display=8728,IsValueDisplayed='N' WHERE AD_Reference_ID=200058 /* C_Phase - C_Phase_ID */
;

UPDATE AD_Ref_Table SET AD_Display=3031,IsValueDisplayed='N' WHERE AD_Reference_ID=52001 /* C_Bank - C_Bank_ID */
;

UPDATE AD_Ref_Table SET AD_Display=15773,IsValueDisplayed='N' WHERE AD_Reference_ID=200072 /* AD_LinkInfowindow - AD_InfoColumn_ID */
;

UPDATE AD_Ref_Table SET AD_Display=2801,IsValueDisplayed='N' WHERE AD_Reference_ID=400 /* AD_Process_JasperReports - AD_Process_ID */
;

UPDATE AD_Ref_Table SET AD_Display=57098,IsValueDisplayed='N' WHERE AD_Reference_ID=53297 /* M_PromotionDistribution - M_PromotionDistribution_ID */
;

UPDATE AD_Ref_Table SET AD_Display=8972,IsValueDisplayed='N' WHERE AD_Reference_ID=200056 /* C_ProjectPhase - C_ProjectPhase_ID */
;

UPDATE AD_Ref_Table SET AD_Display=8900,IsValueDisplayed='N' WHERE AD_Reference_ID=200057 /* C_ProjectTask - C_ProjectTask_ID */
;

UPDATE AD_Ref_Table SET AD_Display=13562,IsValueDisplayed='N' WHERE AD_Reference_ID=345 /* R_Status - R_Status_ID */
;

UPDATE AD_Ref_Table SET AD_Display=100,IsValueDisplayed='N' WHERE AD_Reference_ID=206 /* AD_Table Posting - AD_Table_ID */
;

UPDATE AD_Ref_Table SET AD_Display=100,IsValueDisplayed='N' WHERE AD_Reference_ID=53290 /* AD_Table TableName - AD_Table_ID */
;

UPDATE AD_Ref_Table SET AD_Display=100,IsValueDisplayed='N' WHERE AD_Reference_ID=200179 /* AD_Table Trl - AD_Table_ID */
;

UPDATE AD_Ref_Table SET AD_Display=100,IsValueDisplayed='N' WHERE AD_Reference_ID=200165 /* AD_Table with ID Column - AD_Table_ID */
;

UPDATE AD_Ref_Table SET AD_Display=1349,IsValueDisplayed='N' WHERE AD_Reference_ID=169 /* C_Project Parent - C_Project_ID */
;

SELECT register_migration_script('202112161318_IDEMPIERE-4448.sql') FROM dual
;
