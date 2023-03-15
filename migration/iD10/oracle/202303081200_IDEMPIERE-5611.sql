-- Set zoom window on tables where is empty
SELECT register_migration_script('202303081200_IDEMPIERE-5611.sql') FROM dual;

UPDATE AD_Table SET AD_Window_ID=53057 /*Depreciation Period Spread Type*/ WHERE TableName='A_Asset_Spread' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=251 /*Asset*/ WHERE TableName='A_Asset_Use' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200088 /*Context Help Suggestion*/ WHERE TableName='AD_CtxHelpSuggestion' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=111 /*Role*/ WHERE TableName='AD_Document_Action_Access' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53058 /*Depreciation Methods*/ WHERE TableName='A_Depreciation' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53060 /*Depreciation First Year Conventions */ WHERE TableName='A_Depreciation_Convention' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=326 /*Access Audit*/ WHERE TableName='A_Depreciation_Forecast' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53061 /*Depreciation Calculation Method*/ WHERE TableName='A_Depreciation_Method' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53059 /*Depreciation Tables*/ WHERE TableName='A_Depreciation_Table_Detail' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53059 /*Depreciation Tables*/ WHERE TableName='A_Depreciation_Table_Header' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200087 /*Field Suggestions*/ WHERE TableName='AD_FieldSuggestion' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=221 /*Find (indirect use)*/ WHERE TableName='AD_Find' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53063 /*House Keeping*/ WHERE TableName='AD_HouseKeeping' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=111 /*Role*/ WHERE TableName='AD_InfoWindow_Access' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200128 /*Label Category*/ WHERE TableName='AD_LabelCategory_Trl' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200129 /*Label*/ WHERE TableName='AD_Label_Trl' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53019 /*Migration Scripts*/ WHERE TableName='AD_MigrationScript' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200100 /*Print Header/Footer*/ WHERE TableName='AD_PrintHeaderFooter' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200123 /*Drill Rule*/ WHERE TableName='AD_Process_DrillRule' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=285 /*Replication Strategy*/ WHERE TableName='AD_ReplicationDocument' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200016 /*Active Session*/ WHERE TableName='AD_SessionInfo_v' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200118 /*SMTP Server*/ WHERE TableName='AD_SMTP' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200111 /*Menu user favourites*/ WHERE TableName='AD_Tree_Favorite' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200111 /*Menu user favourites*/ WHERE TableName='AD_Tree_Favorite_Node' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200110 /*Info Window Customization*/ WHERE TableName='AD_UserDef_Info_Column' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200110 /*Info Window Customization*/ WHERE TableName='AD_UserDef_Info_Related' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200020 /*Setup Wizard Maintenance*/ WHERE TableName='AD_WizardProcess' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53016 /*ASP Subscribed Modules*/ WHERE TableName='ASP_ClientException' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53016 /*ASP Subscribed Modules*/ WHERE TableName='ASP_ClientLevel' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Field' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Form' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Level' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Module' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Process' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Process_Para' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Ref_List' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Tab' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Task' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Window' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53015 /*ASP Modules*/ WHERE TableName='ASP_Workflow' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=307 /*Bid Topic*/ WHERE TableName='B_BidComment' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=307 /*Bid Topic*/ WHERE TableName='B_Offer' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=308 /*Auction Topic Type*/ WHERE TableName='B_TopicCategory' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200036 /*1099 Box*/ WHERE TableName='C_1099Box' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=140 /*Product*/ WHERE TableName='C_BPartner_Product' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200031 /*Payments into Batch*/ WHERE TableName='C_DepositBatch' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200031 /*Payments into Batch*/ WHERE TableName='C_DepositBatchLine' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessContainer' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessListBPGroup' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessListRole' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessMedia' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessNewsChannel' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessProfile' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=383 /*Web Access*/ WHERE TableName='CM_AccessStage' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=384 /*Web Broadcast Server*/ WHERE TableName='CM_BroadcastServer' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=373 /*Web Project*/ WHERE TableName='CM_CStage_Element_Trl' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=373 /*Web Project*/ WHERE TableName='CM_CStage_Trl' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=379 /*Media Item*/ WHERE TableName='CM_MediaDeploy' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=181 /*Purchase Order*/ WHERE TableName='C_OrderLandedCost' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=181 /*Purchase Order*/ WHERE TableName='C_OrderLandedCostAllocation' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=118 /*Account Element*/ WHERE TableName='C_SubAcct' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53025 /*Export Format*/ WHERE TableName='EXP_FormatLine' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53026 /*Export Processor*/ WHERE TableName='EXP_ProcessorParameter' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53125 /*Fact Reconciliation*/ WHERE TableName='Fact_Reconciliation' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53033 /*Payroll Employee*/ WHERE TableName='HR_Attribute' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53036 /*Payroll Concept Catalog*/ WHERE TableName='HR_Concept_Acct' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53041 /*Payroll Table*/ WHERE TableName='HR_ListLine' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53041 /*Payroll Table*/ WHERE TableName='HR_ListVersion' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53038 /*Payroll Definition*/ WHERE TableName='HR_PayrollConcept' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53038 /*Payroll Definition*/ WHERE TableName='HR_Year' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53028 /*Import Processor*/ WHERE TableName='IMP_ProcessorLog' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53028 /*Import Processor*/ WHERE TableName='IMP_ProcessorParameter' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=354 /*Product BOM*/ WHERE TableName='M_BOMAlternative' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=344 /*Product Costs*/ WHERE TableName='M_CostMovement_v' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=358 /*Attribute Set Instance*/ WHERE TableName='M_InOutLineMA_v' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=358 /*Attribute Set Instance*/ WHERE TableName='M_MovementLineMA_v' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200025 /*Shipment Package*/ WHERE TableName='M_PackageMPS' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=140 /*Product*/ WHERE TableName='M_ProductDownload' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53149 /*Quality Test*/ WHERE TableName='M_Product_QualityTest' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_Promotion' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionDistribution' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53073 /*Promotion Group*/ WHERE TableName='M_PromotionGroup' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53073 /*Promotion Group*/ WHERE TableName='M_PromotionGroupLine' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionLine' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionPreCondition' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53074 /*Promotion*/ WHERE TableName='M_PromotionReward' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=140 /*Product*/ WHERE TableName='M_StorageReservationLog' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=50007 /*Dashboard Content*/ WHERE TableName='PA_DashboardContent_Access' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200006 /*Dashboard Preference*/ WHERE TableName='PA_DashboardPreference' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=200090 /*Document Status*/ WHERE TableName='PA_DocumentStatusAccess' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=358 /*Attribute Set Instance*/ WHERE TableName='RV_C_InvoiceLine' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53165 /*Customer*/ WHERE TableName='RV_OrderDetail' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53064 /*View MRP Records*/ WHERE TableName='RV_PP_MRP' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=232 /*Request (all)*/ WHERE TableName='RV_RequestUpdates' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=52003 /*Web POS BlackListCheque*/ WHERE TableName='U_BlackListCheque' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=53065 /*Web POS Terminal*/ WHERE TableName='U_POSTerminal' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=52001 /*Web POS Role Menu*/ WHERE TableName='U_RoleMenu' AND AD_Window_ID IS NULL
;

UPDATE AD_Table SET AD_Window_ID=52000 /*Web POS Menu*/ WHERE TableName='U_WebMenu' AND AD_Window_ID IS NULL
;

