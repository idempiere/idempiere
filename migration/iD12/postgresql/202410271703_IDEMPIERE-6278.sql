-- IDEMPIERE-6278 Improve OrderBy on Windows
SELECT register_migration_script('202410271703_IDEMPIERE-6278.sql') FROM dual;

-- Oct 27, 2024, 5:03:38 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT Name FROM AD_Window WHERE AD_Window_ID=AD_UserDef_Win.AD_Window_ID)',Updated=TO_TIMESTAMP('2024-10-27 17:03:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=393
;

-- Oct 27, 2024, 5:05:03 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT SeqNo FROM AD_Tab WHERE AD_Tab_ID=AD_UserDef_Tab.AD_Tab_ID)',Updated=TO_TIMESTAMP('2024-10-27 17:05:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=394
;

-- Oct 27, 2024, 5:09:28 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT CASE WHEN AD_Field.IsActive=''Y'' AND (AD_Field.IsDisplayed=''Y'' OR AD_Field.IsDisplayedGrid=''Y'') THEN 0 ELSE 1000000 END + AD_Field.SeqNo END FROM AD_Field WHERE AD_Field_ID=AD_UserDef_Field.AD_Field_ID)',Updated=TO_TIMESTAMP('2024-10-27 17:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=395
;

-- Oct 27, 2024, 5:10:47 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT Value FROM AD_Process WHERE AD_Process_ID=AD_UserDef_Proc.AD_Process_ID)',Updated=TO_TIMESTAMP('2024-10-27 17:10:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200234
;

-- Oct 27, 2024, 5:11:30 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT SeqNo FROM AD_Process_Para WHERE AD_Process_Para_ID=AD_UserDef_Proc_Parameter.AD_Process_Para_ID)',Updated=TO_TIMESTAMP('2024-10-27 17:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200235
;

-- Oct 27, 2024, 5:12:28 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT Name FROM AD_InfoWindow WHERE AD_InfoWindow_ID=AD_UserDef_Info.AD_InfoWindow_ID)',Updated=TO_TIMESTAMP('2024-10-27 17:12:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200280
;

-- Oct 27, 2024, 5:13:12 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT SeqNo FROM AD_InfoColumn WHERE AD_InfoColumn_ID=AD_UserDef_Info_Column.AD_InfoColumn_ID)',Updated=TO_TIMESTAMP('2024-10-27 17:13:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200279
;

-- Oct 27, 2024, 5:24:52 PM CET
UPDATE AD_Tab SET OrderByClause='(SELECT Value FROM AD_Message WHERE AD_Message_ID=AD_Message_Trl.AD_Message_ID), AD_Message_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200302
;

UPDATE AD_Tab SET OrderByClause='C_ElementValue_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=232 /* Account Element (Chart of Accounts) > Translation */;

UPDATE AD_Tab SET OrderByClause='C_Activity_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200126 /* Activity (ABC) > Translation */;

UPDATE AD_Tab SET OrderByClause='A_Asset_Group_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200123 /* Asset Group > Translation */;

UPDATE AD_Tab SET OrderByClause='PP_Product_BOM_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53215 /* Bill of Materials and Formula > Parent Product Translation */;

UPDATE AD_Tab SET OrderByClause='PP_Product_BOMLine_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53216 /* Bill of Materials and Formula > Components Translation */;

UPDATE AD_Tab SET OrderByClause='AD_BroadcastMessage_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200133 /* Broadcast Message > Translation */;

UPDATE AD_Tab SET OrderByClause='C_Charge_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53210 /* Charge > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_ChartDatasource_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200329 /* Chart > Datasource Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Chart_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200132 /* Chart > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_CtxHelpMsg_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200076 /* Context Help > Translation */;

UPDATE AD_Tab SET OrderByClause='C_CountryGroup_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200159 /* Country Group > Translation */;

UPDATE AD_Tab SET OrderByClause='C_Country_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=549 /* Country Region and City > Translation */;

UPDATE AD_Tab SET OrderByClause='C_Currency_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=557 /* Currency > Translation */;

UPDATE AD_Tab SET OrderByClause='PA_DashboardContent_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53372 /* Dashboard Content > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Desktop_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=389 /* Desktop > Translation */;

UPDATE AD_Tab SET OrderByClause='PA_DocumentStatus_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200223 /* Document Status > Document Status Translation */;

UPDATE AD_Tab SET OrderByClause='C_DocType_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=230 /* Document Type > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Process_DrillRule_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200322 /* Drill Rule > Drill Rule Translation */;

UPDATE AD_Tab SET OrderByClause='C_DunningLevel_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=269 /* Dunning > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Element_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=204 /* Element > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_FieldGroup_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=343 /* Field Group > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Form_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=303 /* Form > Translation */;

UPDATE AD_Tab SET OrderByClause='GL_Category_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200121 /* GL Category > Translation */;

UPDATE AD_Tab SET OrderByClause='C_Greeting_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=283 /* Greeting > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_InfoColumn_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=845 /* Info Window > Column Translation */;

UPDATE AD_Tab SET OrderByClause='AD_InfoWindow_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=843 /* Info Window > Window Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Label_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200321 /* Label > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_LabelCategory_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200319 /* Label Category > Translation */;

UPDATE AD_Tab SET OrderByClause='R_MailText_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=775 /* Mail Template > Translation */;

UPDATE AD_Tab SET OrderByClause='PP_Order_BOM_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53217 /* Manufacturing Order > Orden BOM Translation */;

UPDATE AD_Tab SET OrderByClause='PP_Order_BOMLine_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53218 /* Manufacturing Order > Order Components Translation */;

UPDATE AD_Tab SET OrderByClause='PP_Order_Workflow_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53213 /* Manufacturing Order > Workflow Translation */;

UPDATE AD_Tab SET OrderByClause='PP_Order_Node_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53214 /* Manufacturing Order > Order Activity Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Workflow_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53019 /* Manufacturing Workflows > Manufacturing Workflows Translation */;

UPDATE AD_Tab SET OrderByClause='AD_WF_Node_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53023 /* Manufacturing Workflows > Node Translation */;

UPDATE AD_Tab SET OrderByClause='C_Campaign_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200127 /* Marketing Campaign > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Menu_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=111 /* Menu > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Message_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=113 /* Message > Translation */;

UPDATE AD_Tab SET OrderByClause='C_PaymentTerm_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=233 /* Payment Term > Translation */;

UPDATE AD_Tab SET OrderByClause='M_PriceList_Version_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200131 /* Price List > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_PrintFormatItem_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=433 /* Print Format > Item Translation */;

UPDATE AD_Tab SET OrderByClause='AD_PrintFormat_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200143 /* Print Format > Translate */;

UPDATE AD_Tab SET OrderByClause='AD_PrintLabelLine_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=474 /* Print Label > Translation */;

UPDATE AD_Tab SET OrderByClause='M_Product_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=235 /* Product > Translation */;

UPDATE AD_Tab SET OrderByClause='M_Product_Category_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200122 /* Product Category > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Ref_List_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=172 /* Reference > List Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Reference_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=171 /* Reference > Reference Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Process_Para_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=247 /* Report and Process > Parameter Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Process_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=248 /* Report and Process > Report Translation */;

UPDATE AD_Tab SET OrderByClause='PA_ReportColumn_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200272 /* Report Column Set > Translation */;

UPDATE AD_Tab SET OrderByClause='PA_ReportLine_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200271 /* Report Line Set > Translation */;

UPDATE AD_Tab SET OrderByClause='C_SalesRegion_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200129 /* Sales Region > Translation */;

UPDATE AD_Tab SET OrderByClause='C_SalesStage_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200134 /* Sales Stage > Translation */;

UPDATE AD_Tab SET OrderByClause='M_Product_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53048 /* Spare parts > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Color_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200124 /* System Color > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Element_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=446 /* System Translation Check > Element Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Message_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=447 /* System Translation Check > Message Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Window_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=448 /* System Translation Check > Window Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Tab_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=527 /* System Translation Check > Tab Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Field_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=529 /* System Translation Check > Field Translation */;

UPDATE AD_Tab SET OrderByClause='AD_FieldGroup_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=530 /* System Translation Check > Field Group Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Process_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=449 /* System Translation Check > Process Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Form_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=531 /* System Translation Check > Form Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Task_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=532 /* System Translation Check > Task Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Workflow_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=533 /* System Translation Check > Workflow Translation */;

UPDATE AD_Tab SET OrderByClause='AD_WF_Node_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=534 /* System Translation Check > Workflow Node Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Menu_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=535 /* System Translation Check > Menu Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Ref_List_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=528 /* System Translation Check > Reference List Translation */;

UPDATE AD_Tab SET OrderByClause='AD_InfoWindow_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200355 /* System Translation Check > Info Window Translation */;

UPDATE AD_Tab SET OrderByClause='AD_InfoColumn_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200356 /* System Translation Check > Info Column Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Table_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200358 /* System Translation Check > Table Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Column_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200359 /* System Translation Check > Column Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Column_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=681 /* Table and Column > Column Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Table_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=673 /* Table and Column > Table Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Task_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=126 /* Task > Task Translation */;

UPDATE AD_Tab SET OrderByClause='C_TaxCategory_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=284 /* Tax Category > Translation */;

UPDATE AD_Tab SET OrderByClause='C_Tax_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=458 /* Tax Rate > Translation */;

UPDATE AD_Tab SET OrderByClause='C_Tax_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53081 /* Tax Rate Parent > Translation */;

UPDATE AD_Tab SET OrderByClause='TestUU_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200371 /* Test UU Based Table > Test UU Based Table Trl */;

UPDATE AD_Tab SET OrderByClause='C_UOM_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=273 /* Unit of Measure > Translation */;

UPDATE AD_Tab SET OrderByClause='CM_Container_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=813 /* Web Project > Container Translation */;

UPDATE AD_Tab SET OrderByClause='CM_Container_Element_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=815 /* Web Project > Container Element Translation */;

UPDATE AD_Tab SET OrderByClause='CM_CStage_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=811 /* Web Project > Stage Translation */;

UPDATE AD_Tab SET OrderByClause='CM_CStage_Element_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=817 /* Web Project > Stage Element Translation */;

UPDATE AD_Tab SET OrderByClause='W_Store_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=711 /* Web Store > Store Translation */;

UPDATE AD_Tab SET OrderByClause='W_MailMsg_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=713 /* Web Store > Message Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Field_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=115 /* Window, Tab and Field > Field Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Tab_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=116 /* Window, Tab and Field > Tab Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Window_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=117 /* Window, Tab and Field > Window Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Workbench_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=399 /* Workbench > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_WF_Node_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=123 /* Workflow > Node Translation */;

UPDATE AD_Tab SET OrderByClause='AD_Workflow_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=149 /* Workflow > Workflow Translation */;

UPDATE AD_Tab SET OrderByClause='C_Region_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200128 /* Country Region and City > Translation */;

UPDATE AD_Tab SET OrderByClause='M_PriceList_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200130 /* Price List > Translation */;

UPDATE AD_Tab SET OrderByClause='AD_PrintColor_Trl.AD_Language',Updated=TO_TIMESTAMP('2024-10-27 17:24:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200125 /* Print Color > Translation */;

