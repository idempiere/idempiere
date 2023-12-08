-- IDEMPIERE-5932 - better menu and window names
SELECT register_migration_script('202312080607_IDEMPIERE-5932.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 8, 2023, 6:07:00 AM CST
UPDATE AD_Menu SET Name='Quote-to-Invoice (Sales) ',Updated=TO_TIMESTAMP('2023-12-08 06:07:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=166
;

-- Dec 8, 2023, 6:07:22 AM CST
UPDATE AD_Menu SET Name='Requisition-to-Invoice (Purchasing)',Updated=TO_TIMESTAMP('2023-12-08 06:07:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=203
;

-- Dec 8, 2023, 6:08:15 AM CST
UPDATE AD_Menu SET Name='Open Items (Financial movements and Aging)',Updated=TO_TIMESTAMP('2023-12-08 06:08:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=236
;

-- Dec 8, 2023, 6:08:21 AM CST
UPDATE AD_Menu SET Name='Open Items (Aging)',Updated=TO_TIMESTAMP('2023-12-08 06:08:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=243
;

-- Dec 8, 2023, 6:08:39 AM CST
UPDATE AD_Menu SET Name='Material Management and Pricing',Updated=TO_TIMESTAMP('2023-12-08 06:08:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=183
;

-- Dec 8, 2023, 6:10:46 AM CST
UPDATE AD_Menu SET Name='Performance Analysis and Accounting',Updated=TO_TIMESTAMP('2023-12-08 06:10:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=278
;

-- Dec 8, 2023, 6:11:40 AM CST
UPDATE AD_Window SET Name='Bill of Materials and Formula',Updated=TO_TIMESTAMP('2023-12-08 06:11:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53006
;

-- Dec 8, 2023, 6:11:40 AM CST
UPDATE AD_Menu SET Name='Bill of Materials and Formula', Description='Maintain Product Bill of Materials & Formula', Updated=TO_TIMESTAMP('2023-12-08 06:11:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53024
;

-- Dec 8, 2023, 6:11:40 AM CST
UPDATE AD_Menu SET Name='Bill of Materials and Formula', Description='Maintain Product Bill of Materials & Formula', Updated=TO_TIMESTAMP('2023-12-08 06:11:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53129
;

-- Dec 8, 2023, 6:11:40 AM CST
UPDATE AD_Menu SET Name='Bill of Materials and Formula', Description='Maintain Product Bill of Materials & Formula', Updated=TO_TIMESTAMP('2023-12-08 06:11:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53298
;

-- Dec 8, 2023, 6:11:46 AM CST
UPDATE AD_Window SET Name='Report and Process',Updated=TO_TIMESTAMP('2023-12-08 06:11:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=165
;

-- Dec 8, 2023, 6:11:46 AM CST
UPDATE AD_Menu SET Name='Report and Process', Description='Maintain Reports & Processes', Updated=TO_TIMESTAMP('2023-12-08 06:11:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=176
;

-- Dec 8, 2023, 6:11:52 AM CST
UPDATE AD_Window SET Name='Warehouse and Locators',Updated=TO_TIMESTAMP('2023-12-08 06:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=139
;

-- Dec 8, 2023, 6:11:52 AM CST
UPDATE AD_Menu SET Name='Warehouse and Locators', Description='Maintain Warehouses and Locators', Updated=TO_TIMESTAMP('2023-12-08 06:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=125
;

-- Dec 8, 2023, 6:11:52 AM CST
UPDATE AD_WF_Node SET Name='Warehouse and Locators', Description='Maintain Warehouses and Locators', Help='The Warehouse and Locators Window defines each Warehouse, any Locators for that Warehouse and the Accounting parameters to be used for inventory in that Warehouse.',Updated=TO_TIMESTAMP('2023-12-08 06:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Node_ID=158
;

-- Dec 8, 2023, 6:11:57 AM CST
UPDATE AD_Window SET Name='Window, Tab and Field',Updated=TO_TIMESTAMP('2023-12-08 06:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=102
;

-- Dec 8, 2023, 6:11:57 AM CST
UPDATE AD_Menu SET Name='Window, Tab and Field', Description='Maintain Windows, Tabs & Fields', Updated=TO_TIMESTAMP('2023-12-08 06:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=141
;

-- Dec 8, 2023, 6:12:46 AM CST
UPDATE AD_Window SET Name='Inventory Decrease/Increase',Updated=TO_TIMESTAMP('2023-12-08 06:12:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=341
;

-- Dec 8, 2023, 6:12:46 AM CST
UPDATE AD_Menu SET Name='Inventory Decrease/Increase', Description='Enter Internal Use of Inventory', Updated=TO_TIMESTAMP('2023-12-08 06:12:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=503
;

-- Dec 8, 2023, 6:13:01 AM CST
UPDATE AD_Window SET Name='Payment and Reciept',Updated=TO_TIMESTAMP('2023-12-08 06:13:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=195
;

-- Dec 8, 2023, 6:13:01 AM CST
UPDATE AD_Menu SET Name='Payment and Reciept', Description='Process Payments and Receipts', Updated=TO_TIMESTAMP('2023-12-08 06:13:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=235
;

-- Dec 8, 2023, 6:15:33 AM CST
UPDATE AD_Window SET Name='Sales Invoice and Note',Updated=TO_TIMESTAMP('2023-12-08 06:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=167
;

-- Dec 8, 2023, 6:15:33 AM CST
UPDATE AD_Menu SET Name='Sales Invoice and Note', Description='Customer Invoice Entry', Updated=TO_TIMESTAMP('2023-12-08 06:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=178
;

-- Dec 8, 2023, 6:15:56 AM CST
UPDATE AD_Window SET Name='Purchase Invoice and Note',Updated=TO_TIMESTAMP('2023-12-08 06:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=183
;

-- Dec 8, 2023, 6:15:56 AM CST
UPDATE AD_Menu SET Name='Purchase Invoice and Note', Description='Vendor Invoice Entry', Updated=TO_TIMESTAMP('2023-12-08 06:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=206
;

-- Dec 8, 2023, 6:16:25 AM CST
UPDATE AD_Window SET Name='Account Element (Chart of Accounts)',Updated=TO_TIMESTAMP('2023-12-08 06:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=118
;

-- Dec 8, 2023, 6:16:25 AM CST
UPDATE AD_Menu SET Name='Account Element (Chart of Accounts)', Description='Maintain Account Elements', Updated=TO_TIMESTAMP('2023-12-08 06:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=105
;

-- Dec 8, 2023, 6:16:25 AM CST
UPDATE AD_WF_Node SET Name='Account Element (Chart of Accounts)', Description='Maintain Account Elements', Help='The Account Element Window is used to define and maintain the Accounting Element and User Defined Elements. 
One of the account segments is your natural account segment (Chart of Account). You may add a new account element for parallel reporting or for user defined accounting segments.',Updated=TO_TIMESTAMP('2023-12-08 06:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Node_ID=126
;

-- Dec 8, 2023, 6:17:30 AM CST
UPDATE AD_Menu SET Name='Bill of Material and Formula Cost Roll-UP',Updated=TO_TIMESTAMP('2023-12-08 06:17:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53081
;

-- Dec 8, 2023, 6:17:36 AM CST
UPDATE AD_Menu SET Name='Bill of Material and Formulas', Description='Bill of Material and Formulas',Updated=TO_TIMESTAMP('2023-12-08 06:17:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53022
;

-- Dec 8, 2023, 6:17:41 AM CST
UPDATE AD_Menu SET Name='Bill of Material and Formula Setup',Updated=TO_TIMESTAMP('2023-12-08 06:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53023
;

-- Dec 8, 2023, 6:17:46 AM CST
UPDATE AD_Menu SET Name='BOM and Formula Info',Updated=TO_TIMESTAMP('2023-12-08 06:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53025
;

-- Dec 8, 2023, 6:17:54 AM CST
UPDATE AD_Menu SET Name='Cost Workflow and Process Details',Updated=TO_TIMESTAMP('2023-12-08 06:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53080
;

-- Dec 8, 2023, 6:17:59 AM CST
UPDATE AD_Menu SET Name='Generate Shipments and Invoices (manual)',Updated=TO_TIMESTAMP('2023-12-08 06:17:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53132
;

-- Dec 8, 2023, 6:18:09 AM CST
UPDATE AD_Menu SET Name='Human Resource and Payroll', Description='Human Resource and Payroll',Updated=TO_TIMESTAMP('2023-12-08 06:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53108
;

-- Dec 8, 2023, 6:18:26 AM CST
UPDATE AD_Process SET Name='Invoice Detail and Margin',Updated=TO_TIMESTAMP('2023-12-08 06:18:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=152
;

-- Dec 8, 2023, 6:18:26 AM CST
UPDATE AD_Menu SET Name='Invoice Detail and Margin', Description='Invoice (Line) Detail and Margin Report', Updated=TO_TIMESTAMP('2023-12-08 06:18:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=253
;

-- Dec 8, 2023, 6:18:50 AM CST
UPDATE AD_Menu SET Name='Multi Level BOM and Formula Detail',Updated=TO_TIMESTAMP('2023-12-08 06:18:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53026
;

-- Dec 8, 2023, 6:21:16 AM CST
UPDATE AD_Menu SET Name='Order Receipt and Issue', Description='Order Receipt and Issue',Updated=TO_TIMESTAMP('2023-12-08 06:21:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53059
;

-- Dec 8, 2023, 6:21:22 AM CST
UPDATE AD_Menu SET Name='Print and Release Order',Updated=TO_TIMESTAMP('2023-12-08 06:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53058
;

-- Dec 8, 2023, 6:23:10 AM CST
UPDATE AD_Process SET Name='Create Window, Tab and Field from Table', Description='Create Window, Tab and Field record of the Table',Updated=TO_TIMESTAMP('2023-12-08 06:23:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200118
;

-- Dec 8, 2023, 6:23:15 AM CST
UPDATE AD_Process SET Name='Create and Invite',Updated=TO_TIMESTAMP('2023-12-08 06:23:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=261
;

-- Dec 8, 2023, 6:23:18 AM CST
UPDATE AD_Process SET Name='Invite and Remind',Updated=TO_TIMESTAMP('2023-12-08 06:23:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=262
;

-- Dec 8, 2023, 6:23:25 AM CST
UPDATE AD_Process SET Name='Bill of Material and Formula Cost Roll-UP',Updated=TO_TIMESTAMP('2023-12-08 06:23:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53062
;

-- Dec 8, 2023, 6:23:25 AM CST
UPDATE AD_Menu SET Name='Bill of Material and Formula Cost Roll-UP', Description='This Process allow integrate Bill of Material & Formula Cost', Updated=TO_TIMESTAMP('2023-12-08 06:23:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53081
;

-- Dec 8, 2023, 6:23:31 AM CST
UPDATE AD_Process SET Name='Cost Workflow and Process Details',Updated=TO_TIMESTAMP('2023-12-08 06:23:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53060
;

-- Dec 8, 2023, 6:23:38 AM CST
UPDATE AD_Process SET Name='Multi Level BOM and Formula Detail',Updated=TO_TIMESTAMP('2023-12-08 06:23:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53006
;

-- Dec 8, 2023, 6:23:38 AM CST
UPDATE AD_Menu SET Name='Multi Level BOM and Formula Detail', Description='Shows in two different panels the parent-component relationship for the product entered in the Product field.', Updated=TO_TIMESTAMP('2023-12-08 06:23:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53026
;

-- Dec 8, 2023, 6:23:42 AM CST
UPDATE AD_Process SET Name='Print and Release Order',Updated=TO_TIMESTAMP('2023-12-08 06:23:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53034
;

-- Dec 8, 2023, 6:23:42 AM CST
UPDATE AD_Menu SET Name='Print and Release Order', Description='Once the planned orders of manufacture generated by MRP, have been aprobed, has been reached the date of liberation and has been verified that the required components are in existence, the orders are emitted to the plant for its manufacture.', Updated=TO_TIMESTAMP('2023-12-08 06:23:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53058
;
