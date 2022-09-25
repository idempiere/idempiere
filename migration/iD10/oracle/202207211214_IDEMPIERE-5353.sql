-- IDEMPIERE-5353 Entity type field in the Column tab becomes read-only when you enter a wrong value
SELECT register_migration_script('202207211214_IDEMPIERE-5353.sql') FROM dual
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ChartDatasource_ID@>0' WHERE AD_Column_ID=59675
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Chart_ID@>0' WHERE AD_Column_ID=210849
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Column_ID@>0' WHERE AD_Column_ID=6482
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Element_ID@>0' WHERE AD_Column_ID=6484
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_FieldGroup_ID@>0' WHERE AD_Column_ID=10013
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Field_ID@>0' WHERE AD_Column_ID=7714
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Form_ID@>0' WHERE AD_Column_ID=7708
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Image_ID@>0' WHERE AD_Column_ID=10574
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_IndexColumn_ID@>0' WHERE AD_Column_ID=210539
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_InfoColumn_ID@>0' WHERE AD_Column_ID=15785
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_InfoProcess_ID@>0' WHERE AD_Column_ID=213906
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_InfoRelated_ID@>0' WHERE AD_Column_ID=213905
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_InfoWindow_ID@>0' WHERE AD_Column_ID=15756
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Menu_ID@>0' WHERE AD_Column_ID=7721
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Message_ID@>0' WHERE AD_Column_ID=7716
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ModelValidator_ID@>0' WHERE AD_Column_ID=53263
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Modification_ID@>0' WHERE AD_Column_ID=15620
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Process_ID@>0' WHERE AD_Column_ID=6485
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Process_Para_ID@>0' WHERE AD_Column_ID=7728
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Reference_ID@>0' WHERE AD_Column_ID=6486
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Ref_List_ID@>0' WHERE AD_Column_ID=7712
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Ref_Table_ID@>0' WHERE AD_Column_ID=7711
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_RelationType_ID@>0' WHERE AD_Column_ID=212980
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ReplicationStrategy_ID@>0' WHERE AD_Column_ID=9365
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ReplicationTable_ID@>0' WHERE AD_Column_ID=9343
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ReportView_ID@>0' WHERE AD_Column_ID=10032
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Rule_ID@>0' WHERE AD_Column_ID=54253
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_SearchDefinition_ID@>0' WHERE AD_Column_ID=213903
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_StatusLine_ID@>0' WHERE AD_Column_ID=210904
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_StatusLineUsedIn_ID@>0' WHERE AD_Column_ID=212979
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Style_ID@>0' WHERE AD_Column_ID=213900
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_StyleLine_ID@>0' WHERE AD_Column_ID=213901
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_SysConfig_ID@>0' WHERE AD_Column_ID=53270
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Tab_ID@>0' WHERE AD_Column_ID=7713
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Table_ID@>0' WHERE AD_Column_ID=6488
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_TableIndex_ID@>0' WHERE AD_Column_ID=210520
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Task_ID@>0' WHERE AD_Column_ID=7723
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ToolBarButton_ID@>0' WHERE AD_Column_ID=213902
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Val_Rule_ID@>0' WHERE AD_Column_ID=7715
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ViewColumn_ID@>0' WHERE AD_Column_ID=210578
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ViewComponent_ID@>0' WHERE AD_Column_ID=210557
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_WF_NextCondition_ID@>0' WHERE AD_Column_ID=11577
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_WF_Node_ID@>0' WHERE AD_Column_ID=7725
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_WF_NodeNext_ID@>0' WHERE AD_Column_ID=10569
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_WF_Node_Para_ID@>0' WHERE AD_Column_ID=10565
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_WF_Responsible_ID@>0' WHERE AD_Column_ID=10566
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Window_ID@>0' WHERE AD_Column_ID=6490
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_Workflow_ID@>0' WHERE AD_Column_ID=7722
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @AD_ZoomCondition_ID@>0' WHERE AD_Column_ID=213899
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @PA_ColorSchema_ID@>0' WHERE AD_Column_ID=15023
;

UPDATE AD_Column SET ReadOnlyLogic='@EntityType@=D & @PA_DocumentStatus_ID@>0' WHERE AD_Column_ID=213904
;


UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_ChartDatasource_ID@>0' WHERE AD_Field_ID=59611 /* Chart > Datasource */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_StyleLine_ID@>0' WHERE AD_Field_ID=206038 /* CSS Style > Style Line */
;

UPDATE AD_Field SET ReadOnlyLogic='@2|EntityType@=D & @AD_Column_ID@>0' WHERE AD_Field_ID=5129 /* Element > Used in Column */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_InfoColumn_ID@>0' WHERE AD_Field_ID=13597 /* Info Window > Column */
;

UPDATE AD_Field SET ReadOnlyLogic='@4|EntityType@=D & @AD_InfoRelated_ID@>0' WHERE AD_Field_ID=206043 /* Info Window > Related Info Window */
;

UPDATE AD_Field SET ReadOnlyLogic='@5|EntityType@=D & @AD_InfoProcess_ID@>0' WHERE AD_Field_ID=206044 /* Info Window > Process */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_Ref_List_ID@>0' WHERE AD_Field_ID=5823 /* Reference > List Validation */
;

UPDATE AD_Field SET ReadOnlyLogic='@3|EntityType@=D & @AD_Reference_ID@>0' WHERE AD_Field_ID=5815 /* Reference > Table Validation */
;

UPDATE AD_Field SET ReadOnlyLogic='@4|EntityType@=D & @AD_Column_ID@>0' WHERE AD_Field_ID=12570 /* Reference > Used in Column */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_ReplicationTable_ID@>0' WHERE AD_Field_ID=7521 /* Replication Strategy > Replication Table */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_Process_Para_ID@>0' WHERE AD_Field_ID=5817 /* Report & Process > Parameter */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_StatusLineUsedIn_ID@>0' WHERE AD_Field_ID=204396 /* Status Line > Used In */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_Column_ID@>0' WHERE AD_Field_ID=5121 /* Table and Column > Column */
;

UPDATE AD_Field SET ReadOnlyLogic='@7|EntityType@=D & @AD_TableIndex_ID@>0' WHERE AD_Field_ID=202206 /* Table and Column > Table Index */
;

UPDATE AD_Field SET ReadOnlyLogic='@8|EntityType@=D & @AD_IndexColumn_ID@>0' WHERE AD_Field_ID=202216 /* Table and Column > Index Column */
;

UPDATE AD_Field SET ReadOnlyLogic='@9|EntityType@=D & @AD_ViewComponent_ID@>0' WHERE AD_Field_ID=202229 /* Table and Column > View Component */
;

UPDATE AD_Field SET ReadOnlyLogic='@10|EntityType@=D & @AD_ViewColumn_ID@>0' WHERE AD_Field_ID=202244 /* Table and Column > View Column */
;

UPDATE AD_Field SET ReadOnlyLogic='@4|EntityType@=D & @AD_ZoomCondition_ID@>0' WHERE AD_Field_ID=206036 /* Table and Column > Zoom Condition */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_Column_ID@>0' WHERE AD_Field_ID=12535 /* Validation Rules > Used in Column */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_Tab_ID@>0' WHERE AD_Field_ID=5824 /* Window, Tab & Field > Tab */
;

UPDATE AD_Field SET ReadOnlyLogic='@2|EntityType@=D & @AD_Field_ID@>0' WHERE AD_Field_ID=5808 /* Window, Tab & Field > Field */
;

UPDATE AD_Field SET ReadOnlyLogic='@7|EntityType@=D & @AD_ToolBarButton_ID@>0' WHERE AD_Field_ID=206040 /* Window, Tab & Field > Toolbar Button */
;

UPDATE AD_Field SET ReadOnlyLogic='@1|EntityType@=D & @AD_WF_Node_ID@>0' WHERE AD_Field_ID=5821 /* Workflow > Node */
;

UPDATE AD_Field SET ReadOnlyLogic='@2|EntityType@=D & @AD_WF_Node_Para_ID@>0' WHERE AD_Field_ID=8858 /* Workflow > Parameter */
;

UPDATE AD_Field SET ReadOnlyLogic='@4|EntityType@=D & @AD_WF_NodeNext_ID@>0' WHERE AD_Field_ID=8860 /* Workflow > Transition */
;

UPDATE AD_Field SET ReadOnlyLogic='@5|EntityType@=D & @AD_WF_NextCondition_ID@>0' WHERE AD_Field_ID=10100 /* Workflow > Condition */
;

