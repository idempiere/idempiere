-- 
SELECT register_migration_script('202303081200_IDEMPIERE-5611.sql') FROM dual;

UPDATE AD_Table SET AD_Window_ID=53057 /*Depreciation Period Spread Type*/ WHERE TableName='A_Asset_Spread'
;

UPDATE AD_Table SET AD_Window_ID=251 /*Asset*/ WHERE TableName='A_Asset_Use'
;

UPDATE AD_Table SET AD_Window_ID=200088 /*Context Help Suggestion*/ WHERE TableName='AD_CtxHelpSuggestion'
;

UPDATE AD_Table SET AD_Window_ID=111 /*Role*/ WHERE TableName='AD_Document_Action_Access'
;

UPDATE AD_Table SET AD_Window_ID=53058 /*Depreciation Methods*/ WHERE TableName='A_Depreciation'
;

UPDATE AD_Table SET AD_Window_ID=53060 /*Depreciation First Year Conventions */ WHERE TableName='A_Depreciation_Convention'
;

UPDATE AD_Table SET AD_Window_ID=326 /*Access Audit*/ WHERE TableName='A_Depreciation_Forecast'
;

UPDATE AD_Table SET AD_Window_ID=53061 /*Depreciation Calculation Method*/ WHERE TableName='A_Depreciation_Method'
;

UPDATE AD_Table SET AD_Window_ID=53059 /*Depreciation Tables*/ WHERE TableName='A_Depreciation_Table_Detail'
;

UPDATE AD_Table SET AD_Window_ID=53059 /*Depreciation Tables*/ WHERE TableName='A_Depreciation_Table_Header'
;

UPDATE AD_Table SET AD_Window_ID=200087 /*Field Suggestions*/ WHERE TableName='AD_FieldSuggestion'
;

UPDATE AD_Table SET AD_Window_ID=221 /*Find (indirect use)*/ WHERE TableName='AD_Find'
;

UPDATE AD_Table SET AD_Window_ID=53063 /*House Keeping*/ WHERE TableName='AD_HouseKeeping'
;

UPDATE AD_Table SET AD_Window_ID=111 /*Role*/ WHERE TableName='AD_InfoWindow_Access'
;

UPDATE AD_Table SET AD_Window_ID=200128 /*Label Category*/ WHERE TableName='AD_LabelCategory_Trl'
;

UPDATE AD_Table SET AD_Window_ID=200129 /*Label*/ WHERE TableName='AD_Label_Trl'
;

UPDATE AD_Table SET AD_Window_ID=53019 /*Migration Scripts*/ WHERE TableName='AD_MigrationScript'
;

UPDATE AD_Table SET AD_Window_ID=200100 /*Print Header/Footer*/ WHERE TableName='AD_PrintHeaderFooter'
;

UPDATE AD_Table SET AD_Window_ID=200123 /*Drill Rule*/ WHERE TableName='AD_Process_DrillRule'
;

UPDATE AD_Table SET AD_Window_ID=285 /*Replication Strategy*/ WHERE TableName='AD_ReplicationDocument'
;

UPDATE AD_Table SET AD_Window_ID=200016 /*Active Session*/ WHERE TableName='AD_SessionInfo_v'
;

UPDATE AD_Table SET AD_Window_ID=200118 /*SMTP Server*/ WHERE TableName='AD_SMTP'
;

UPDATE AD_Table SET AD_Window_ID=200111 /*Menu user favourites*/ WHERE TableName='AD_Tree_Favorite'
;

UPDATE AD_Table SET AD_Window_ID=200111 /*Menu user favourites*/ WHERE TableName='AD_Tree_Favorite_Node'
;

UPDATE AD_Table SET AD_Window_ID=200110 /*Info Window Customization*/ WHERE TableName='AD_UserDef_Info_Column'
;

UPDATE AD_Table SET AD_Window_ID=200110 /*Info Window Customization*/ WHERE TableName='AD_UserDef_Info_Related'
;

UPDATE AD_Table SET AD_Window_ID=200020 /*Setup Wizard Maintenance*/ WHERE TableName='AD_WizardProcess'
;

UPDATE AD_Table SET AD_Window_ID=53016 /*ASP Subscribed Modules*/ WHERE TableName='ASP_ClientException'
;

UPDATE AD_Table SET AD_Window_ID=53016 /*ASP Subscribed Modules*/ WHERE TableName='ASP_ClientLevel'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Field'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Form'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Level'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Module'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Process'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Process_Para'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Ref_List'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Tab'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Task'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Window'
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Workflow'
;

UPDATE AD_Table SET AD_Window_ID=307 /*Bid Topic*/ WHERE TableName='B_BidComment'
;

UPDATE AD_Table SET AD_Window_ID=307 /*Bid Topic*/ WHERE TableName='B_Offer'
;

UPDATE AD_Table SET AD_Window_ID=308 /*Auction Topic Type*/ WHERE TableName='B_TopicCategory'
;

UPDATE AD_Table SET AD_Window_ID=200036 /*1099 Box*/ WHERE TableName='C_1099Box'
;

UPDATE AD_Table SET AD_Window_ID=140 /*Product*/ WHERE TableName='C_BPartner_Product'
;

UPDATE AD_Table SET AD_Window_ID=200031 /*Payments into Batch*/ WHERE TableName='C_DepositBatch'
;

UPDATE AD_Table SET AD_Window_ID=200031 /*Payments into Batch*/ WHERE TableName='C_DepositBatchLine'
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessContainer'
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessListBPGroup'
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessListRole'
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessMedia'
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessNewsChannel'
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessProfile'
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessStage'
;

UPDATE AD_Table SET AD_Window_ID=384 /*Web Broadcast Server*/ WHERE TableName='CM_BroadcastServer'
;

UPDATE AD_Table SET AD_Window_ID=373 /*Web Project*/ WHERE TableName='CM_CStage_Element_Trl'
;

UPDATE AD_Table SET AD_Window_ID=373 /*Web Project*/ WHERE TableName='CM_CStage_Trl'
;

UPDATE AD_Table SET AD_Window_ID=379 /*Media Item*/ WHERE TableName='CM_MediaDeploy'
;

UPDATE AD_Table SET AD_Window_ID=181 /*Purchase Order*/ WHERE TableName='C_OrderLandedCost'
;

UPDATE AD_Table SET AD_Window_ID=181 /*Purchase Order*/ WHERE TableName='C_OrderLandedCostAllocation'
;

UPDATE AD_Table SET AD_Window_ID=118 /*Account Element*/ WHERE TableName='C_SubAcct'
;

UPDATE AD_Table SET AD_Window_ID=53025 /*Export Format*/ WHERE TableName='EXP_FormatLine'
;

UPDATE AD_Table SET AD_Window_ID=53026 /*Export Processor*/ WHERE TableName='EXP_ProcessorParameter'
;

UPDATE AD_Table SET AD_Window_ID=53125 /*Fact Reconciliation*/ WHERE TableName='Fact_Reconciliation'
;

UPDATE AD_Table SET AD_Window_ID=53033 /*Payroll Employee*/ WHERE TableName='HR_Attribute'
;

UPDATE AD_Table SET AD_Window_ID=53036 /*Payroll Concept Catalog*/ WHERE TableName='HR_Concept_Acct'
;

UPDATE AD_Table SET AD_Window_ID=53041 /*Payroll Table*/ WHERE TableName='HR_ListLine'
;

UPDATE AD_Table SET AD_Window_ID=53041 /*Payroll Table*/ WHERE TableName='HR_ListVersion'
;

UPDATE AD_Table SET AD_Window_ID=53038 /*Payroll Definition*/ WHERE TableName='HR_PayrollConcept'
;

UPDATE AD_Table SET AD_Window_ID=53038 /*Payroll Definition*/ WHERE TableName='HR_Year'
;

UPDATE AD_Table SET AD_Window_ID=53028 /*Import Processor*/ WHERE TableName='IMP_ProcessorLog'
;

UPDATE AD_Table SET AD_Window_ID=53028 /*Import Processor*/ WHERE TableName='IMP_ProcessorParameter'
;

UPDATE AD_Table SET AD_Window_ID=354 /*Product BOM*/ WHERE TableName='M_BOMAlternative'
;

UPDATE AD_Table SET AD_Window_ID=344 /*Product Costs*/ WHERE TableName='M_CostMovement_v'
;

UPDATE AD_Table SET AD_Window_ID=358 /*Attribute Set Instance*/ WHERE TableName='M_InOutLineMA_v'
;

UPDATE AD_Table SET AD_Window_ID=358 /*Attribute Set Instance*/ WHERE TableName='M_MovementLineMA_v'
;

UPDATE AD_Table SET AD_Window_ID=200025 /*Shipment Package*/ WHERE TableName='M_PackageMPS'
;

UPDATE AD_Table SET AD_Window_ID=140 /*Product*/ WHERE TableName='M_ProductDownload'
;

UPDATE AD_Table SET AD_Window_ID=53149 /*Quality Test*/ WHERE TableName='M_Product_QualityTest'
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_Promotion'
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionDistribution'
;

UPDATE AD_Table SET AD_Window_ID=53073 /*Promotion Group*/ WHERE TableName='M_PromotionGroup'
;

UPDATE AD_Table SET AD_Window_ID=53073 /*Promotion Group*/ WHERE TableName='M_PromotionGroupLine'
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionLine'
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionPreCondition'
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionReward'
;

UPDATE AD_Table SET AD_Window_ID=140 /*Product*/ WHERE TableName='M_StorageReservationLog'
;

UPDATE AD_Table SET AD_Window_ID=50007 /*Dashboard Content*/ WHERE TableName='PA_DashboardContent_Access'
;

UPDATE AD_Table SET AD_Window_ID=200006 /*Dashboard Preference*/ WHERE TableName='PA_DashboardPreference'
;

UPDATE AD_Table SET AD_Window_ID=200090 /*Document Status*/ WHERE TableName='PA_DocumentStatusAccess'
;

UPDATE AD_Table SET AD_Window_ID=358 /*Attribute Set Instance*/ WHERE TableName='RV_C_InvoiceLine'
;

UPDATE AD_Table SET AD_Window_ID=53165 /*Customer*/ WHERE TableName='RV_OrderDetail'
;

UPDATE AD_Table SET AD_Window_ID=53064 /*View MRP Records*/ WHERE TableName='RV_PP_MRP'
;

UPDATE AD_Table SET AD_Window_ID=232 /*Request (all)*/ WHERE TableName='RV_RequestUpdates'
;

UPDATE AD_Table SET AD_Window_ID=52003 /*Web POS BlackListCheque*/ WHERE TableName='U_BlackListCheque'
;

UPDATE AD_Table SET AD_Window_ID=53065 /*Web POS Terminal*/ WHERE TableName='U_POSTerminal'
;

UPDATE AD_Table SET AD_Window_ID=52001 /*Web POS Role Menu*/ WHERE TableName='U_RoleMenu'
;

UPDATE AD_Table SET AD_Window_ID=52000 /*Web POS Menu*/ WHERE TableName='U_WebMenu'
;

