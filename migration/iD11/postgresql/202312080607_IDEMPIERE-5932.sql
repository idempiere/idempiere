-- IDEMPIERE-5932 - better menu and window names
SELECT register_migration_script('202312080607_IDEMPIERE-5932.sql') FROM dual;

-- Dec 8, 2023, 6:07:00 AM CST
UPDATE AD_Menu SET Name='Quote-to-Invoice (Sales) ',Updated=TO_TIMESTAMP('2023-12-08 06:07:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=166
;

-- Dec 8, 2023, 6:07:22 AM CST
UPDATE AD_Menu SET Name='Requisition-to-Invoice (Purchasing)',Updated=TO_TIMESTAMP('2023-12-08 06:07:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=203
;

-- Dec 8, 2023, 6:08:15 AM CST
UPDATE AD_Menu SET Name='Open Items (Financial Movements and Aging)',Updated=TO_TIMESTAMP('2023-12-08 06:08:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=236
;

-- Dec 8, 2023, 6:08:21 AM CST
UPDATE AD_Process SET Name='Open Items (Aging)', Description='Open Items (Invoice and Aging) List', Help='Displays all unpaid invoices for a given Business Partner and date range.', Updated=TO_TIMESTAMP('2023-12-08 06:08:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=145
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

-- Dec 8, 2023, 6:11:46 AM CST
UPDATE AD_Window SET Name='Report and Process',Updated=TO_TIMESTAMP('2023-12-08 06:11:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=165
;

-- Dec 8, 2023, 6:11:52 AM CST
UPDATE AD_Window SET Name='Warehouse and Locators',Updated=TO_TIMESTAMP('2023-12-08 06:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=139
;

-- Dec 8, 2023, 6:11:57 AM CST
UPDATE AD_Window SET Name='Window, Tab and Field',Updated=TO_TIMESTAMP('2023-12-08 06:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=102
;

-- Dec 8, 2023, 6:12:46 AM CST
UPDATE AD_Window SET Name='Inventory Decrease/Increase', Description='Enter Inventory Decrease/Increase (for example Internal Use of Inventory)', Updated=TO_TIMESTAMP('2023-12-08 06:12:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=341
;

-- Dec 8, 2023, 6:13:01 AM CST
UPDATE AD_Window SET Name='Payment and Receipt',Updated=TO_TIMESTAMP('2023-12-08 06:13:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=195
;

-- Dec 8, 2023, 6:15:33 AM CST
UPDATE AD_Window SET Name='Sales Invoice and Credit/Debit Note', Description='Customer Sales Invoice and Credit/Debit Note', Updated=TO_TIMESTAMP('2023-12-08 06:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=167
;

-- Dec 8, 2023, 6:15:56 AM CST
UPDATE AD_Window SET Name='Purchase Invoice and Credit/Debit Note', Description='Vendor Purchase Invoice and Credit/Debit Note', Updated=TO_TIMESTAMP('2023-12-08 06:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=183
;

-- Dec 8, 2023, 6:16:25 AM CST
UPDATE AD_Window SET Name='Account Element (Chart of Accounts)',Updated=TO_TIMESTAMP('2023-12-08 06:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=118
;

-- Dec 8, 2023, 6:17:30 AM CST
UPDATE AD_Process SET Name='Bill of Material and Formula Cost Roll-Up',Updated=TO_TIMESTAMP('2023-12-08 06:17:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53062
;

-- Dec 8, 2023, 6:17:36 AM CST
UPDATE AD_Menu SET Name='Bill of Material and Formulas', Description='Bill of Material and Formulas',Updated=TO_TIMESTAMP('2023-12-08 06:17:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53022
;

-- Dec 8, 2023, 6:17:41 AM CST
UPDATE AD_Workflow SET Name='Bill of Material and Formula Setup',Updated=TO_TIMESTAMP('2023-12-08 06:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50002
;

-- Dec 8, 2023, 6:17:46 AM CST
UPDATE AD_Form SET Name='BOM and Formula Info',Updated=TO_TIMESTAMP('2023-12-08 06:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=53001
;

-- Dec 8, 2023, 6:17:54 AM CST
UPDATE AD_Process SET Name='Cost Workflow and Process Details',Updated=TO_TIMESTAMP('2023-12-08 06:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53060
;

-- Dec 8, 2023, 6:17:59 AM CST
UPDATE AD_Form SET Name='Generate Shipments and Invoices (manual)',Updated=TO_TIMESTAMP('2023-12-08 06:17:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=53010
;

-- Dec 8, 2023, 6:18:09 AM CST
UPDATE AD_Menu SET Name='Human Resource and Payroll', Description='Human Resource and Payroll',Updated=TO_TIMESTAMP('2023-12-08 06:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53108
;

-- Dec 8, 2023, 6:18:26 AM CST
UPDATE AD_Process SET Name='Invoice Detail and Margin',Updated=TO_TIMESTAMP('2023-12-08 06:18:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=152
;

-- Dec 8, 2023, 6:18:50 AM CST
UPDATE AD_Process SET Name='Multi Level BOM and Formula Detail',Updated=TO_TIMESTAMP('2023-12-08 06:18:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53006
;

-- Dec 8, 2023, 6:21:16 AM CST
UPDATE AD_Form SET Name='Order Receipt and Issue', Description='Order Receipt and Issue',Updated=TO_TIMESTAMP('2023-12-08 06:21:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=53007
;

-- Dec 8, 2023, 6:21:22 AM CST
UPDATE AD_Process SET Name='Print and Release Order',Updated=TO_TIMESTAMP('2023-12-08 06:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53034
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

