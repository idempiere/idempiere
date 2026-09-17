-- AD_Reference descriptions
-- References: 543

SELECT register_migration_script('202511301205_IDEMPIERE-6779-Reference-Descriptions.sql') FROM dual;

-- =============================================
-- AD_Reference (543 records)
-- =============================================

UPDATE AD_Reference SET Description='Selection list for cost element type values', Help='The CostElement Type reference provides a dropdown selection with 5 predefined values. Available options: Burden (M.Overhead), Outside Processing, Resource, Material, Overhead.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ffdf2052-a310-4317-a3bf-784d7a1048e1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Business Partner Sales Representative (Table)
UPDATE AD_Reference SET Help='The Business Partner Sales Representative reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4072c588-57bd-439d-aa1e-e7a4e78b68e2' AND (Help IS NULL) AND EntityType='D';

-- C_Greeting (Table)
UPDATE AD_Reference SET Description='Table lookup for greeting records', Help='The Greeting reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='93dd94e9-589d-4eec-99c1-bfd7f42528c5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_BP_Group PriorityBase (List)
UPDATE AD_Reference SET Description='Selection list for bp group priority base values', Help='The Business Partner Group PriorityBase reference provides a dropdown selection with 3 predefined values. Available options: Lower, Higher, Same.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='10abe72b-ce7c-4b9b-a3d9-f2658cdceb3b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Element Value (trx) (Table)
UPDATE AD_Reference SET Help='The Element Value (trx) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='15d74807-f597-46e5-a029-30381994d727' AND (Help IS NULL) AND EntityType='D';

-- C_Project InvoiceRule (List)
UPDATE AD_Reference SET Description='Selection list for project invoice rule values', Help='The Project InvoiceRule reference provides a dropdown selection with 5 predefined values. Available options: None, Time&Material, Product  Quantity, Committed Amount, Time&Material max Committed.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='aa541156-c0f5-48fd-b866-7bf37e692626' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Project LineLevel (List)
UPDATE AD_Reference SET Description='Selection list for project line level values', Help='The Project LineLevel reference provides a dropdown selection with 3 predefined values. Available options: Phase, Task, Project.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4d25ef13-7296-410e-90d2-ac66dc339e41' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_BOMProduct Type (List)
UPDATE AD_Reference SET Description='Selection list for bom product type values', Help='The BOMProduct Type reference provides a dropdown selection with 5 predefined values. Available options: Standard Product, Optional Product, Alternative (Default), Outside Processing, Alternative.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fccec951-2ca5-4b5c-be8f-389a8dff846b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Measure DataType (List)
UPDATE AD_Reference SET Description='Selection list for measure data type values', Help='The Performance Measure DataType reference provides a dropdown selection with 2 predefined values. Available options: Status Qty/Amount, Qty/Amount in Time.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='290168f2-de86-4985-a4d2-5e72e0aa32d7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Benschmark Accumulation Type (List)
UPDATE AD_Reference SET Description='Selection list for benschmark accumulation type values', Help='The Performance Benschmark Accumulation Type reference provides a dropdown selection with 2 predefined values. Available options: Average, Sum.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b32d335b-0d58-4ac5-85a4-3610daca4cf1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Ratio (Table)
UPDATE AD_Reference SET Description='Table lookup for ratio records', Help='The Performance Ratio reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='58e0e70d-2c18-4fb6-b382-37bf00cd7758' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RowID (DataType)
UPDATE AD_Reference SET Help='The RowID reference row ID Data Type.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='210dabbf-1af4-40a6-856d-1b888cad94cf' AND (Help IS NULL) AND EntityType='D';

-- Color (DataType)
UPDATE AD_Reference SET Help='The Color reference color element.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='69f3386b-08dd-4a81-9aba-d31947693adc' AND (Help IS NULL) AND EntityType='D';

-- CM_ChatEntry (Table)
UPDATE AD_Reference SET Description='Table lookup for cm chat entry records', Help='The Content ChatEntry reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fce2cdd9-af69-48ef-94da-c6d0f0cff9ba' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- CM_Chat ModerationType (List)
UPDATE AD_Reference SET Description='Selection list for cm chat moderation type values', Help='The Content Chat ModerationType reference provides a dropdown selection with 3 predefined values. Available options: Not moderated, Before Publishing, After Publishing.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='57b71428-a001-4b2f-97e7-6b3b88c30940' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- CM_ChatEntry ModeratorStatus (List)
UPDATE AD_Reference SET Description='Selection list for cm chat entry moderator status values', Help='The Content ChatEntry ModeratorStatus reference provides a dropdown selection with 4 predefined values. Available options: Not Displayed, Published, To be reviewed, Suspicious.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6400b9b8-22d2-456f-9283-301b58f52bf7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- CM_Chat EntryType (List)
UPDATE AD_Reference SET Description='Selection list for cm chat entry type values', Help='The Content Chat EntryType reference provides a dropdown selection with 3 predefined values. Available options: Wiki, Note (flat), Forum (threaded).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3f67bac0-89b6-4273-bd89-b93d49bac36a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Package_Type (List)
UPDATE AD_Reference SET Help='The Package_Type reference provides a dropdown selection with 3 predefined values. Available options: Remote Transfer, XML File, Local Transfer.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='181e13df-e022-4f6c-ba7a-206019dc65f2' AND (Help IS NULL) AND EntityType='D';

-- AD_Package_Build_Type (List)
UPDATE AD_Reference SET Description='Selection list for package build type values', Help='The Package_Build_Type reference provides a dropdown selection with 25 predefined values. Available options: Data, Application or Module, Process/Report, Report View, Role and 20 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f26a9c79-8198-4893-831c-920aa5aca408' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Package_Source_Type (List)
UPDATE AD_Reference SET Help='The Package_Source_Type reference provides a dropdown selection with 2 predefined values. Available options: WebService, File.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9b4e2d4b-808c-4c4b-902c-ee2410612434' AND (Help IS NULL) AND EntityType='D';

-- PA_Ratio Operand (List)
UPDATE AD_Reference SET Description='Selection list for ratio operand values', Help='The Performance Ratio Operand reference provides a dropdown selection with 4 predefined values. Available options: Plus, Multiply, Divide, Minus.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2ee0315f-d586-4efa-98de-c8d7713082f4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Invoice MatchRequirement (List)
UPDATE AD_Reference SET Description='Selection list for invoice match requirement values', Help='The Invoice MatchRequirement reference provides a dropdown selection with 4 predefined values. Available options: None, Receipt, Purchase Order, Purchase Order and Receipt.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f4bdad94-7383-454a-8a08-23ae680d3537' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Table Posting (Table)
UPDATE AD_Reference SET Help='The Table Posting reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a8c19a50-2b6f-4f3f-a135-f7921f801bb9' AND (Help IS NULL) AND EntityType='D';

-- AD_ImpFormat FormatType (List)
UPDATE AD_Reference SET Description='Selection list for imp format format type values', Help='The ImpFormat FormatType reference provides a dropdown selection with 5 predefined values. Available options: Fixed Position, Tab Separated, XML, Custom Separator Char, Comma Separated.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e8a04616-a629-43cd-b0e1-51f18fa65860' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_ImpFormat_Row Type (List)
UPDATE AD_Reference SET Description='Selection list for imp format row type values', Help='The ImpFormat_Row Type reference provides a dropdown selection with 4 predefined values. Available options: Number, Date, Constant, String.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='324793dc-7463-4e32-a3d4-d5b5d1b7a117' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_InventoryCount QtyRange (List)
UPDATE AD_Reference SET Description='Selection list for inventory count qty range values', Help='The InventoryCount QtyRange reference provides a dropdown selection with 4 predefined values. Available options: = 0, < 0, > 0, not 0.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9aa3a392-378f-435a-8897-e1fd8f32de9f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Payment Trx Type (List)
UPDATE AD_Reference SET Help='The Payment Trx Type reference provides a dropdown selection with 6 predefined values. Available options: Sales, Credit (Payment), Voice Authorization, Void, Delayed Capture and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4dffe794-5e11-46bb-b939-cd03e9f4cebb' AND (Help IS NULL) AND EntityType='D';

-- C_Cash Trx Type (List)
UPDATE AD_Reference SET Description='Selection list for cash trx type values', Help='The Cash Trx Type reference provides a dropdown selection with 6 predefined values. Available options: Bank Account Transfer, Invoice, General Receipts, Charge, Difference and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='59227119-0eb5-4c49-90bd-7ac62f2281a9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- R_Request Request Type (List)
UPDATE AD_Reference SET Description='Selection list for request request type values', Help='The Request Request Type reference provides a dropdown selection with 8 predefined values. Available options: Information, Service, Charge, Alert, Warranty and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='71b28f82-b878-4232-a9d2-03fddcda9806' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Commission DocBasis (List)
UPDATE AD_Reference SET Description='Selection list for commission doc basis values', Help='The Commission DocBasis reference provides a dropdown selection with 3 predefined values. Available options: Order, Invoice, Receipt.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bdb060b3-c556-4003-a5d4-12e61daea7f6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Commission Frequency (List)
UPDATE AD_Reference SET Description='Selection list for commission frequency values', Help='The Commission Frequency reference provides a dropdown selection with 4 predefined values. Available options: Yearly, Weekly, Monthly, Quarterly.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='30ecf056-efd8-451b-bcc2-fbed82313f2c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Role User Level (List)
UPDATE AD_Reference SET Description='Selection list for role user level values', Help='The Role User Level reference provides a dropdown selection with 4 predefined values. Available options: Client, Organization, System, Client+Organization.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c8dd8125-d2a4-4f22-a7a7-d64290d11cca' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Goal (Table)
UPDATE AD_Reference SET Description='Table lookup for goal records', Help='The Performance Goal reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='493cc901-ac9e-4f92-99d7-dcb36500ae43' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Goal Parent (Table)
UPDATE AD_Reference SET Description='Table lookup for goal parent records', Help='The Performance Goal Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='59578cec-450b-46b3-a436-658dc5f2afa8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Measure Type (List)
UPDATE AD_Reference SET Description='Selection list for measure type values', Help='The Performance Measure Type reference provides a dropdown selection with 7 predefined values. Available options: Request, Project, User defined, Ratio, Manual and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b21aa68f-9d50-454d-a236-e1cb2a137075' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Report CalculationType (List)
UPDATE AD_Reference SET Description='Selection list for report calculation type values', Help='The Performance Report CalculationType reference provides a dropdown selection with 4 predefined values. Available options: Add (Op1+Op2), Percentage (Op1 of Op2), Add Range (Op1 to Op2), Subtract (Op1-Op2).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b645fb79-df27-4b4a-9b76-1fa958343c1c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Report ColumnType (List)
UPDATE AD_Reference SET Description='Selection list for report column type values', Help='The Performance Report ColumnType reference provides a dropdown selection with 3 predefined values. Available options: Relative Period, Segment Value, Calculation.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4aef07da-13ab-4f39-8947-53880343a131' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Report CurrencyType (List)
UPDATE AD_Reference SET Description='Selection list for report currency type values', Help='The Performance Report CurrencyType reference provides a dropdown selection with 2 predefined values. Available options: Accounting Currency, Source Currency.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f970390e-849a-441f-bf77-779ae03db605' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_ReportColumn (Table)
UPDATE AD_Reference SET Description='Table lookup for report column records', Help='The Performance ReportColumn reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1d4b5b26-f29f-4e5c-8e70-88e7d93d2314' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_ReportLine (Table)
UPDATE AD_Reference SET Description='Table lookup for report line records', Help='The Performance ReportLine reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='209539e8-1e00-4fab-9f15-cca112fd5d09' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_ReportLine Parent (Table)
UPDATE AD_Reference SET Description='Table lookup for report line parent records', Help='The Performance ReportLine Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c210e071-b86a-463e-8f21-603acb2221d1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Color Type (List)
UPDATE AD_Reference SET Description='Selection list for color type values', Help='The Color Type reference provides a dropdown selection with 4 predefined values. Available options: Normal (Flat), Gradient, Line, Texture (Picture).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b80b99be-cb81-442c-ad33-11420f683f37' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Process_JasperReports (Table)
UPDATE AD_Reference SET Description='Table lookup for process jasper reports records', Help='The Process_JasperReports reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d8d4991c-9bf3-4e8c-aa96-a4def85c23ad' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Weekdays (List)
UPDATE AD_Reference SET Help='The Weekdays reference provides a dropdown selection with 7 predefined values. Available options: Sunday, Monday, Tuesday, Thursday, Saturday and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bb2734fd-23b0-4d4d-a626-d5dfa1dc60d1' AND (Help IS NULL) AND EntityType='D';

-- C_InvoiceSchedule InvoiceFrequency (List)
UPDATE AD_Reference SET Description='Selection list for invoice schedule invoice frequency values', Help='The InvoiceSchedule InvoiceFrequency reference provides a dropdown selection with 4 predefined values. Available options: Daily, Monthly, Twice Monthly, Weekly.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a5eb32ad-e37e-41bf-b6d3-b20c22a5d857' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Document Type SO (Table)
UPDATE AD_Reference SET Description='Table lookup for document type so records', Help='The Document Type SO reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='34025ffc-9ffc-4cc1-89b4-78afb665f0f8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_ValidCombination (Table)
UPDATE AD_Reference SET Help='The ValidCombination reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2bc4b39f-0338-4da0-b774-49f1dcd278cf' AND (Help IS NULL) AND EntityType='D';

-- GL Category Type (List)
UPDATE AD_Reference SET Description='Selection list for gl category type values', Help='The GL Category Type reference provides a dropdown selection with 4 predefined values. Available options: Manual, Document, Import, System generated.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3a702ee0-6643-4305-9777-86a94b8537df' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Payment (Table)
UPDATE AD_Reference SET Description='Table lookup for payment records', Help='The Payment reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='aa5cbd9e-57e6-409a-89e3-97bde7c32a6a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_PeriodControl Action (List)
UPDATE AD_Reference SET Description='Selection list for period control action values', Help='The PeriodControl Action reference provides a dropdown selection with 5 predefined values. Available options: Close Period, <No Action>, Permanently Close Period, Open Period, Document Close Period.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ff731e77-b230-4aab-9db1-4f987653b93b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- GL_Budget Status (List)
UPDATE AD_Reference SET Description='Selection list for budget status values', Help='The General Ledger Budget Status reference provides a dropdown selection with 2 predefined values. Available options: Approved, Draft.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7f3187ba-eab5-4770-adec-233dcabf7644' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_SalesRegion Parent (Table)
UPDATE AD_Reference SET Description='Table lookup for sales region parent records', Help='The Sales Region Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2df41f08-fff1-4610-9663-520021565551' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Element Value (all) (Table)
UPDATE AD_Reference SET Help='The Element Value (all) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='cf83a2d7-a447-45bb-ba5e-328d940910b2' AND (Help IS NULL) AND EntityType='D';

-- AD_Tree (Table)
UPDATE AD_Reference SET Help='The Tree reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0459391c-f942-4d9c-866f-0c8c3d48215c' AND (Help IS NULL) AND EntityType='D';

-- M_Price List Version (Table)
UPDATE AD_Reference SET Description='Table lookup for price list version records', Help='The Price List Version reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d4116686-c81c-4544-8d02-9441a0b39288' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Bank Account for Credit Card (Table)
UPDATE AD_Reference SET Description='Table lookup for bank account for credit card records', Help='The Bank Account for Credit Card reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3e9a7643-f87e-406f-bd77-403fd2fa67d6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_DiscountPrice List Base (List)
UPDATE AD_Reference SET Description='Selection list for discount price list base values', Help='The DiscountPrice List Base reference provides a dropdown selection with 5 predefined values. Available options: Standard Price, Limit (PO) Price, List Price, Fixed Price, Product Cost.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='12a51662-fc71-4acc-9d77-6184ce7ea72c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Inventory ReportType (List)
UPDATE AD_Reference SET Description='Selection list for inventory report type values', Help='The Inventory ReportType reference provides a dropdown selection with 3 predefined values. Available options: Blind list (w/o book quantity), Control list, Count list (with book quantity).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='23022035-04ec-4b18-bc50-7f430f3438a2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Assignment (DataType)
UPDATE AD_Reference SET Help='The Assignment reference resource Assignment.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6e36a201-6ef7-473a-a71e-e2fe2baaebb8' AND (Help IS NULL) AND EntityType='D';

-- C_Allocation (Table)
UPDATE AD_Reference SET Description='Table lookup for allocation records', Help='The Allocation reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='eca98340-7cc7-469c-98c5-edc414fbe031' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Business Partner Employee (Table)
UPDATE AD_Reference SET Help='The Business Partner Employee reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='19d0b9e0-fc8e-4060-a35d-278961357708' AND (Help IS NULL) AND EntityType='D';

-- AD_Print Field Alignment (List)
UPDATE AD_Reference SET Description='Selection list for print field alignment values', Help='The Print Field Alignment reference provides a dropdown selection with 5 predefined values. Available options: Default, Leading (left), Block, Center, Trailing (right).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f51b7a38-1943-4e02-904d-f1bc15ab37b2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print Format Type (List)
UPDATE AD_Reference SET Description='Selection list for print format type values', Help='The Print Format Type reference provides a dropdown selection with 7 predefined values. Available options: Field, Text, Rectangle, Line, Print Format and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b1a90392-f401-4309-95f5-671a1dfda66e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print Area (List)
UPDATE AD_Reference SET Description='Selection list for print area values', Help='The Print Area reference provides a dropdown selection with 3 predefined values. Available options: Content, Header, Footer.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a8d6d90a-84bc-488e-98a3-8a4b7c989de5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Column Integer (Table)
UPDATE AD_Reference SET Help='The Column Integer reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5438f597-e1b1-43c5-90d2-538b009095d8' AND (Help IS NULL) AND EntityType='D';

-- AD_Print Format (Table)
UPDATE AD_Reference SET Description='Table lookup for print format records', Help='The Print Format reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='106ca36f-03ba-4f2e-a7c5-9b174f2a38c3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print Format Order (Table)
UPDATE AD_Reference SET Description='Table lookup for print format order records', Help='The Print Format Order reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c2e0c396-7ef7-4e61-8df5-965ec2de95fd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print Format Shipment (Table)
UPDATE AD_Reference SET Description='Table lookup for print format shipment records', Help='The Print Format Shipment reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5f0c96ee-9a87-482a-98c1-95f15cab7f60' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_BP_EDI EDI Type (List)
UPDATE AD_Reference SET Description='Selection list for bp edi edi type values', Help='The Business Partner EDI EDI Type reference provides a dropdown selection with 3 predefined values. Available options: ASC X12 , EDIFACT, Email EDI.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='83f8c97c-05b2-4bf6-9d16-fb2eae5df583' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_EDI Status (List)
UPDATE AD_Reference SET Description='Selection list for edi status values', Help='The EDI Status reference provides a dropdown selection with 4 predefined values. Available options: Draft, Sent, Answered (complete), Acknowledged.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='dda98816-1e97-4284-b58f-ead3089af34e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_EDI Trx Type (List)
UPDATE AD_Reference SET Description='Selection list for edi trx type values', Help='The EDI Trx Type reference provides a dropdown selection with 2 predefined values. Available options: Inquiry, Purchase Order.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ac39b6ee-2c06-4a87-8226-5f87014e0106' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_Transition Type (List)
UPDATE AD_Reference SET Description='Selection list for wf transition type values', Help='The Workflow Transition Type reference provides a dropdown selection with 3 predefined values. Available options: Regular, Loop Begin, Loop End.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='11cb4384-8165-4cc8-9ecc-9699cce2c1c6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_Instance State (List)
UPDATE AD_Reference SET Description='Selection list for wf instance state values', Help='The Workflow Instance State reference provides a dropdown selection with 6 predefined values. Available options: Not Started, Running, Suspended, Aborted, Terminated and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b97bcb3c-f4e6-4d7a-b5b4-b6203376ed59' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_EventType (List)
UPDATE AD_Reference SET Description='Selection list for wf event type values', Help='The Workflow EventType reference provides a dropdown selection with 3 predefined values. Available options: State Changed, Process Completed, Process Created.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4f6621f6-0899-460d-89d7-5f5c0dd08f7b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Language Maintenance (List)
UPDATE AD_Reference SET Description='Selection list for language maintenance values', Help='The Language Maintenance reference provides a dropdown selection with 3 predefined values. Available options: Add Missing Translations, Re-Create Translation, Delete Translation.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='856bad3e-b8e5-4d46-b443-2d2bfce387f4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_PrintTableFormat Stroke (List)
UPDATE AD_Reference SET Help='The PrintTableFormat Stroke reference provides a dropdown selection with 4 predefined values. Available options: Solid Line, Dashed Line, Dash-Dotted Line, Dotted Line.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b0220d45-dda6-44bb-a235-10ee49ee4bda' AND (Help IS NULL) AND EntityType='D';

-- M_RelatedProduct Type (List)
UPDATE AD_Reference SET Description='Selection list for related product type values', Help='The RelatedProduct Type reference provides a dropdown selection with 3 predefined values. Available options: Web Promotion, Alternative, Supplemental.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='88c39f6b-028a-4f83-87c6-d23744ec0a14' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- B_TopicType AuctionType (List)
UPDATE AD_Reference SET Description='Selection list for b topic type auction type values', Help='The Bank TopicType AuctionType reference provides a dropdown selection with 2 predefined values. Available options: Funding - All Bidders help funding a Topic, Auction - The highest Bidder wins the Topic.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='cd265c89-11a9-46b1-bdc0-7f5da80dbc37' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_User - Supervisor (Table)
UPDATE AD_Reference SET Help='The User - Supervisor reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='426f8b08-3a7f-4002-943e-bb6e433ca724' AND (Help IS NULL) AND EntityType='D';

-- AD_Scheduler Type (List)
UPDATE AD_Reference SET Description='Selection list for scheduler type values', Help='The Scheduler Type reference provides a dropdown selection with 4 predefined values. Available options: Frequency, Week Day, Month Day, Cron Scheduling Pattern.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9852394b-dfea-4959-b6a9-2defda41f5cf' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Attribute Set MandatoryType (List)
UPDATE AD_Reference SET Description='Selection list for attribute set mandatory type values', Help='The Attribute Set MandatoryType reference provides a dropdown selection with 3 predefined values. Available options: When Shipping, Not Mandatory, Always Mandatory.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='543b0241-afb9-4722-8f5e-4d3c633fba0e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Attribute Value Type (List)
UPDATE AD_Reference SET Description='Selection list for attribute value type values', Help='The Attribute Value Type reference provides a dropdown selection with 6 predefined values. Available options: String (max 40), Number, List, Date, Reference and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7a218b0e-f4e3-4309-9e48-75eeaa03c4bf' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Role PreferenceType (List)
UPDATE AD_Reference SET Help='The Role PreferenceType reference provides a dropdown selection with 4 predefined values. Available options: Client, Organization, None, User.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b11c5259-828a-4d13-a6e9-88da5b2e06b6' AND (Help IS NULL) AND EntityType='D';

-- APAR (List)
UPDATE AD_Reference SET Help='The APAR reference provides a dropdown selection with 3 predefined values. Available options: Receivables & Payables, Payables only, Receivables only.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bae88b2b-80bf-4f4f-90c5-cbed7ac9be57' AND (Help IS NULL) AND EntityType='D';

-- _Entity Type (List)
UPDATE AD_Reference SET Help='The _Entity Type reference provides a dropdown selection with 5 predefined values. Available options: Dictionary, User maintained, Applications, Customization, iDempiere.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='18762169-d3ba-445c-bfe3-b24bfd2013b1' AND (Help IS NULL) AND EntityType='D';

-- ShowHelp List (List)
UPDATE AD_Reference SET Description='Selection list for show help list values', Help='The ShowHelp List reference provides a dropdown selection with 4 predefined values. Available options: Ask user (for future use), Don''t show help, Show Help, Run silently - Take Defaults.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='885cb495-6d27-477c-b879-e85b39478ea7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Discount Type (List)
UPDATE AD_Reference SET Description='Selection list for discount type values', Help='The Discount Type reference provides a dropdown selection with 4 predefined values. Available options: Flat Percent, Breaks, Pricelist, Formula.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='136cc0fd-7c62-4818-953b-10be7a1d8bfb' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Color StartPoint (List)
UPDATE AD_Reference SET Help='The Color StartPoint reference provides a dropdown selection with 8 predefined values. Available options: North, East, South East, South West, West and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b558b637-9de3-433b-afa4-62d7f0a00850' AND (Help IS NULL) AND EntityType='D';

-- CostUpdate Source (List)
UPDATE AD_Reference SET Description='Selection list for cost update source values', Help='The CostUpdate Source reference provides a dropdown selection with 12 predefined values. Available options: FiFo, LiFo, Old Standard Cost, Future Standard Cost, Average PO and 7 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fd95e771-69b1-4833-be23-1c94fdb344aa' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Order (Table)
UPDATE AD_Reference SET Help='The Order reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7f3cf3a7-e312-4191-b319-470f2f0a44c2' AND (Help IS NULL) AND EntityType='D';

-- AD_Field ObscureType (List)
UPDATE AD_Reference SET Description='Selection list for field obscure type values', Help='The Field ObscureType reference provides a dropdown selection with 4 predefined values. Available options: Obscure Digits but first/last 4, Obscure AlphaNumeric but first/last 4, Obscure AlphaNumeric but last 4, Obscure Digits but last 4.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6c5061bf-ad0b-4fd2-8fbd-90b8bed4d51e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_TransactionAllocation Type (List)
UPDATE AD_Reference SET Description='Selection list for transaction allocation type values', Help='The TransactionAllocation Type reference provides a dropdown selection with 2 predefined values. Available options: LiFo, FiFo.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='41cd0b08-53bb-48a3-afe5-8f2e76804827' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Shipment ReceiptLine (Table)
UPDATE AD_Reference SET Description='Table lookup for shipment receipt line records', Help='The Shipment ReceiptLine reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fd693997-9df2-43b6-9c89-bda283928387' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Transaction (Table)
UPDATE AD_Reference SET Description='Table lookup for transaction records', Help='The Transaction reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b103d77d-10bb-48e0-a4bd-c3e714359e3c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Inventory Type (List)
UPDATE AD_Reference SET Help='The Inventory Type reference provides a dropdown selection with 2 predefined values. Available options: Inventory Difference, Charge Account.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d78dc144-cd5d-481f-87b8-5d98e2dcb796' AND (Help IS NULL) AND EntityType='D';

-- C_ProjectType Category (List)
UPDATE AD_Reference SET Description='Selection list for project type category values', Help='The ProjectType Category reference provides a dropdown selection with 4 predefined values. Available options: General, Service (Charge) Project, Asset Project, Work Order (Job).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e8e5080d-648e-4a79-ba0f-d513a8c471b5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Column ColumName (Table)
UPDATE AD_Reference SET Help='The Column ColumName reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a121fc9f-54dc-4990-b9eb-a1399a324e36' AND (Help IS NULL) AND EntityType='D';

-- C_Document Type RMA (Table)
UPDATE AD_Reference SET Description='Table lookup for document type RMA records', Help='The Document Type RMA reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1dd35ff3-a915-4980-b8fd-700e77de816c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Validation Rules Parent (Table)
UPDATE AD_Reference SET Help='The Validation Rules Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='cf3a963a-3ff2-4fcc-b1b3-e48758664ef4' AND (Help IS NULL) AND EntityType='D';

-- AD_Message Type (List)
UPDATE AD_Reference SET Help='The Message Type reference provides a dropdown selection with 3 predefined values. Available options: Error, Information, Menu.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9e6fb9b4-6d62-4018-b41d-07f7ccd5103a' AND (Help IS NULL) AND EntityType='D';

-- AD_Print Label Line Type (List)
UPDATE AD_Reference SET Description='Selection list for print label line type values', Help='The Print Label Line Type reference provides a dropdown selection with 2 predefined values. Available options: Text, Field.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ab4548f5-8c9e-4e6b-9b94-d2b01dc93128' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Recurring Frequency (List)
UPDATE AD_Reference SET Description='Selection list for recurring frequency values', Help='The Recurring Frequency reference provides a dropdown selection with 4 predefined values. Available options: Daily, Monthly, Quarterly, Weekly.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ad5d8db2-187f-4473-b8f7-b9d758ae49b0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Window (Table)
UPDATE AD_Reference SET Description='Table lookup for window records', Help='The Window reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a96595a2-b14e-4626-95f0-d9a742a22b22' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- K_Entry Related (Table)
UPDATE AD_Reference SET Description='Table lookup for k entry related records', Help='The Knowledge Entry Related reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='01ef6a51-4c67-4d14-9f5f-fe1aa11fad10' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Menu Action (List)
UPDATE AD_Reference SET Help='The Menu Action reference provides a dropdown selection with 9 predefined values. Available options: Form, Report, Window, Task, Process and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c4b63f2f-51da-49fe-9a10-83b9d8cb332f' AND (Help IS NULL) AND EntityType='D';

-- CM_Container Type (List)
UPDATE AD_Reference SET Description='Selection list for cm container type values', Help='The Content Container Type reference provides a dropdown selection with 3 predefined values. Available options: Document, Internal Link, External URL.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6b7c84ad-529a-47ba-ac53-3638081f66e4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- CM_Container (Table)
UPDATE AD_Reference SET Description='Table lookup for cm container records', Help='The Content Container reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='51ab7400-1cd0-4aa2-8dd8-c42afeb9d570' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- CM_CStage (Table)
UPDATE AD_Reference SET Description='Table lookup for cm c stage records', Help='The Content CStage reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='17a452ad-f238-46d3-a213-a3308422f1e6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- K_IndexLog QuerySource (List)
UPDATE AD_Reference SET Description='Selection list for k index log query source values', Help='The Knowledge IndexLog QuerySource reference provides a dropdown selection with 4 predefined values. Available options: Java Client, HTML Client, Self Service, Collaboration Management.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5528323d-c32e-421c-920a-9bf072e19255' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Accounting Schema TaxCorrectionType (List)
UPDATE AD_Reference SET Description='Selection list for accounting schema tax correction type values', Help='The Accounting Schema TaxCorrectionType reference provides a dropdown selection with 4 predefined values. Available options: None, Write-off only, Discount only, Write-off and Discount.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e5a44c8c-5a33-458a-80f9-39412bb9f8d4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- CM_Media Media Type (List)
UPDATE AD_Reference SET Description='Selection list for cm media media type values', Help='The Content Media Media Type reference provides a dropdown selection with 6 predefined values. Available options: image/gif, text/js, image/png, application/pdf, text/css and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a9ff6b0e-1fd7-4765-b710-14bb99636807' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Conversion_Rate Types (List)
UPDATE AD_Reference SET Help='The Conversion_Rate Types reference provides a dropdown selection with 8 predefined values. Available options: Spot, Period End, Average, Company, User Type and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ff8075c3-08b0-4972-ac22-c5e51dae116e' AND (Help IS NULL) AND EntityType='D';

-- C_Currencies (Table)
UPDATE AD_Reference SET Help='The Currencies reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b671e117-1e66-45e4-b315-5a91648b13be' AND (Help IS NULL) AND EntityType='D';

-- AD_Org Parent (Table)
UPDATE AD_Reference SET Help='The Organization Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='679abe7b-76e5-49dc-995c-90e13ca81eb7' AND (Help IS NULL) AND EntityType='D';

-- C_UOM (Table)
UPDATE AD_Reference SET Help='The UOM reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='39a31dc2-7c5e-44df-bb29-055fff18954d' AND (Help IS NULL) AND EntityType='D';

-- C_Element Type (List)
UPDATE AD_Reference SET Help='The Element Type reference provides a dropdown selection with 2 predefined values. Available options: Account, User defined.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='143e7ef0-cca2-4819-91f2-3539e84fb501' AND (Help IS NULL) AND EntityType='D';

-- C_Element Value AccountType (List)
UPDATE AD_Reference SET Help='The Element Value AccountType reference provides a dropdown selection with 6 predefined values. Available options: Asset, Revenue, Expense, Owner''s Equity, Liability and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='211f479c-672b-4e5e-8bd7-c21718c0fec1' AND (Help IS NULL) AND EntityType='D';

-- C_Accounting Schema GAAP (List)
UPDATE AD_Reference SET Help='The Accounting Schema GAAP reference provides a dropdown selection with 5 predefined values. Available options: US GAAP, German HGB, Custom Accounting Rules, International GAAP, French Accounting Standard.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4e9a9866-1cfa-4716-889e-f1d6e39e1d57' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner Parent (Table)
UPDATE AD_Reference SET Help='The Business Partner Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a61ffd05-10b7-4cf7-be63-88e5d249bb84' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner Employee w Address (Table)
UPDATE AD_Reference SET Help='The Business Partner Employee w Address reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c73dad1a-400c-47b1-bc08-03e526c10973' AND (Help IS NULL) AND EntityType='D';

-- AD_Tab (Table)
UPDATE AD_Reference SET Description='Table lookup for tab records', Help='The Tab reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='76eeff4b-a285-47c9-8d39-32806e31dc83' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Sequence for Documents (Table)
UPDATE AD_Reference SET Help='The Sequence for Documents reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='18963177-bda8-439a-b238-3407459b952e' AND (Help IS NULL) AND EntityType='D';

-- AD_Org (all but 0) (Table)
UPDATE AD_Reference SET Help='The Organization (all but 0) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b8326f41-e9c9-4e8d-b687-6c49e4035ab9' AND (Help IS NULL) AND EntityType='D';

-- C_Activity (No summary) (Table)
UPDATE AD_Reference SET Help='The Activity (No summary) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='acb181d8-b2d9-4ac0-b783-96ed59eaf57f' AND (Help IS NULL) AND EntityType='D';

-- C_Campaign (No summary) (Table)
UPDATE AD_Reference SET Help='The Campaign (No summary) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a7838e47-3494-43c3-b47b-02d1b9880451' AND (Help IS NULL) AND EntityType='D';

-- C_Sales Region (No summary) (Table)
UPDATE AD_Reference SET Help='The Sales Region (No summary) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e53e937d-8bbc-41b7-a4e8-97e0b94daf2b' AND (Help IS NULL) AND EntityType='D';

-- C_Element (Table)
UPDATE AD_Reference SET Help='The Element reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bc6a82c8-283a-4059-a973-46c4a8e69149' AND (Help IS NULL) AND EntityType='D';

-- AD_Print FormatItem (Table)
UPDATE AD_Reference SET Description='Table lookup for print format item records', Help='The Print FormatItem reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='056ff2ac-a256-4c03-8b30-eb356b0fae53' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print Graph Type (List)
UPDATE AD_Reference SET Description='Selection list for print graph type values', Help='The Print Graph Type reference provides a dropdown selection with 3 predefined values. Available options: Pie Chart, Line Chart, Bar Chart.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='da184b6f-aea4-493b-a310-91ff3b88de44' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print Format Not TableBased (Table)
UPDATE AD_Reference SET Description='Table lookup for print format not table based records', Help='The Print Format Not TableBased reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='00c1789f-c18f-46d6-8437-468a5c329022' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- I_Element Value Column (Table)
UPDATE AD_Reference SET Description='Table lookup for element value column records', Help='The Import Element Value Column reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='453c8148-ef29-4bbb-8d08-40453e68a428' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- R_MailText (Table)
UPDATE AD_Reference SET Help='The Mail Text reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bd93f1a0-ed08-44a3-902e-b0d639fd1108' AND (Help IS NULL) AND EntityType='D';

-- C_OrderLine (Table)
UPDATE AD_Reference SET Help='The OrderLine reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ddc8feed-a382-44f0-831a-57d40dcebccf' AND (Help IS NULL) AND EntityType='D';

-- AD_Print Format Check (Table)
UPDATE AD_Reference SET Description='Table lookup for print format check records', Help='The Print Format Check reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f988904c-cf3f-40d2-b3b3-c31bc728345e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Product_ProductType (List)
UPDATE AD_Reference SET Description='Selection list for product product type values', Help='The Product_ProductType reference provides a dropdown selection with 6 predefined values. Available options: Item, Service, Resource, Expense type, Online and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='668f05be-1e2e-498c-a016-cc5b623ed0cd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Memo (DataType)
UPDATE AD_Reference SET Help='The Memo reference large Text Editor - Character String up to 2000 characters.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2cf64ebe-8f05-48fe-80af-640e51d8f145' AND (Help IS NULL) AND EntityType='D';

-- C_Accounting Schema (Table)
UPDATE AD_Reference SET Help='The Accounting Schema reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='014524e7-c008-41b8-9019-81f0fdd1cb7f' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner (Trx) (Table)
UPDATE AD_Reference SET Help='The Business Partner (Trx) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b4af3f46-7083-4a1c-a3c1-bf514e85ddb1' AND (Help IS NULL) AND EntityType='D';

-- M_Product Parent (Table)
UPDATE AD_Reference SET Description='Table lookup for product parent records', Help='The Product Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fe5dd169-9409-42f0-9b34-86474f6bec83' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print FormatItem ShapeType (List)
UPDATE AD_Reference SET Description='Selection list for print format item shape type values', Help='The Print FormatItem ShapeType reference provides a dropdown selection with 4 predefined values. Available options: Normal Rectangle, Oval, Round Rectangle, 3D Rectangle.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ffab2ae7-c7e0-47a9-8935-53d05b1cf320' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Client AutoArchive (List)
UPDATE AD_Reference SET Description='Selection list for client auto archive values', Help='The Client AutoArchive reference provides a dropdown selection with 4 predefined values. Available options: All (Reports, Documents), Documents, None, External Documents.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='04617b98-c2ba-4030-8373-a7e9a2d80456' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- W_MailMsg Type (List)
UPDATE AD_Reference SET Description='Selection list for mail msg type values', Help='The Web MailMsg Type reference provides a dropdown selection with 9 predefined values. Available options: Payment Acknowledgement, Payment Error, User Verification, Subscribe, UnSubscribe and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5c46bc99-4da0-43f9-9de8-609428d338ac' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- R_Status (Table)
UPDATE AD_Reference SET Description='Table lookup for status records', Help='The Request Status reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c983514a-01c6-4f1a-9d2e-e06ff6db14ae' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Column Encrypted (List)
UPDATE AD_Reference SET Description='Selection list for column encrypted values', Help='The Column Encrypted reference provides a dropdown selection with 2 predefined values. Available options: Encrypted, Not Encrypted.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='65619601-e06e-4401-a79c-359ea2315e5d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Accounting Schema CostingLevel (List)
UPDATE AD_Reference SET Description='Selection list for accounting schema costing level values', Help='The Accounting Schema CostingLevel reference provides a dropdown selection with 3 predefined values. Available options: Client, Batch/Lot, Organization.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a94f171c-68c9-4099-b593-826f7c851eb2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Accounting Schema CommitmentType (List)
UPDATE AD_Reference SET Description='Selection list for accounting schema commitment type values', Help='The Accounting Schema CommitmentType reference provides a dropdown selection with 6 predefined values. Available options: None, PO Commitment only, SO Commitment only, PO/SO Commitment, PO Commitment & Reservation and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ed80bfce-4f78-4649-b93b-18dcdb2071e6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Client ShareType (List)
UPDATE AD_Reference SET Description='Selection list for client share type values', Help='The Client ShareType reference provides a dropdown selection with 3 predefined values. Available options: Client (all shared), Client or Org, Org (not shared).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f5bddff3-89fd-4bbc-9cbc-8e96552075ac' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Goal Scope (List)
UPDATE AD_Reference SET Description='Selection list for goal scope values', Help='The Performance Goal Scope reference provides a dropdown selection with 6 predefined values. Available options: Year, Quarter, Total, Week, Month and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d0df7b42-5b82-492c-86f7-48a7084260c3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Goal Restriction Type (List)
UPDATE AD_Reference SET Description='Selection list for goal restriction type values', Help='The Performance Goal Restriction Type reference provides a dropdown selection with 5 predefined values. Available options: Organization, Business Partner, Product, Bus.Partner Group, Product Category.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2d4dae8e-1de0-456a-b961-805a106ca42d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_PrintPaper Units (List)
UPDATE AD_Reference SET Description='Selection list for print paper units values', Help='The PrintPaper Units reference provides a dropdown selection with 2 predefined values. Available options: MM, Inch.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7c66aabc-95f6-4fe3-a254-9cfc384dac24' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Inventory CountSet (List)
UPDATE AD_Reference SET Description='Selection list for inventory count set values', Help='The Inventory CountSet reference provides a dropdown selection with 2 predefined values. Available options: On Hand Qty, Zero.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fedfcf8d-8d9b-4c70-825f-165891cf905f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Print FormatItem BarcodeType (List)
UPDATE AD_Reference SET Description='Selection list for print format item barcode type values', Help='The Print FormatItem BarcodeType reference provides a dropdown selection with 28 predefined values. Available options: Code 39 USD3 w/o Checksum, Code 39 linear w/o Checksum, Code 39  3 of 9 linear w/o Checksum, Codeabar linear, Code 128 A character set and 23 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='07bf79d3-974e-4c26-8b3a-032090c2cfa0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- FileName (DataType)
UPDATE AD_Reference SET Help='The FileName reference local File.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6be9c89f-a42f-466d-bddd-7b47de11d83a' AND (Help IS NULL) AND EntityType='D';

-- Printer Name (DataType)
UPDATE AD_Reference SET Description='Data type definition for printer name', Help='The Printer Name reference data type definition for printer name.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d33b56e2-90b4-4395-bbc0-5e6608556c8e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Invoice InvoiceCollectionType (List)
UPDATE AD_Reference SET Description='Selection list for invoice invoice collection type values', Help='The Invoice InvoiceCollectionType reference provides a dropdown selection with 4 predefined values. Available options: Dunning, Collection Agency, Legal Procedure, Uncollectable.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8729d453-3c6d-437f-b055-e0b320bdce3e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- U_WebMenu_ID (Table)
UPDATE AD_Reference SET Description='Table lookup for u web menu id records', Help='The User WebMenu_ID reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5ff7f05b-32b6-4f39-b953-6a0c9eec6041' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- ASP_Status (List)
UPDATE AD_Reference SET Description='Selection list for asp status values', Help='The ASP_Status reference provides a dropdown selection with 3 predefined values. Available options: Undefined, Hide, Show.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='46a4187a-9549-40e0-b9cf-f7f63e7f1073' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Rule_RuleType (List)
UPDATE AD_Reference SET Description='Selection list for rule rule type values', Help='The Rule_RuleType reference provides a dropdown selection with 4 predefined values. Available options: Aspect Orient Program, JSR 94 Rule Engine API, SQL, JSR 223 Scripting APIs.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='16ad15e0-6071-41e8-acb9-486fbf60a4ea' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Rule_EventType (List)
UPDATE AD_Reference SET Description='Selection list for rule event type values', Help='The Rule_EventType reference provides a dropdown selection with 8 predefined values. Available options: Callout, Model Validator Table Event, Model Validator Login Event, Human Resource & Payroll, Measure for Performance Analysis and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d4ed84a9-5b80-49a9-8a5f-b10c4554bf9d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- EventChangeLog (List)
UPDATE AD_Reference SET Description='Selection list for event change log values', Help='The EventChangeLog reference provides a dropdown selection with 3 predefined values. Available options: Insert, Delete, Update.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f49ce831-9547-40d7-8bb7-82f7259222a3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MigrationScriptStatus (List)
UPDATE AD_Reference SET Help='The MigrationScriptStatus reference provides a dropdown selection with 3 predefined values. Available options: In Progress, Completed, Error.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6d509ef8-5102-4885-a7fe-ae39db1cf3e0' AND (Help IS NULL) AND EntityType='D';

-- Text Long (DataType)
UPDATE AD_Reference SET Help='The Text Long reference text (Long) - Text > 2000 characters.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='678761e9-b461-4afe-a343-6216de60c6c4' AND (Help IS NULL) AND EntityType='D';

-- M_ChangeNotice (Table)
UPDATE AD_Reference SET Description='Table lookup for change notice records', Help='The ChangeNotice reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1cd5e474-3deb-4385-bb6e-34e77ce6b0fb' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- R_Request Confidential (List)
UPDATE AD_Reference SET Description='Selection list for request confidential values', Help='The Request Confidential reference provides a dropdown selection with 4 predefined values. Available options: Internal, Partner Confidential, Private Information, Public Information.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='979808e3-b297-43ab-81cf-4b7f46b34b8a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- R_Request Due Type (List)
UPDATE AD_Reference SET Description='Selection list for request due type values', Help='The Request Due Type reference provides a dropdown selection with 3 predefined values. Available options: Overdue, Scheduled, Due.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='98c2d1cb-fbdb-42c9-8280-d1ae9953a701' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- _PriorityRule (List)
UPDATE AD_Reference SET Help='The _PriorityRule reference provides a dropdown selection with 5 predefined values. Available options: High, Medium, Low, Minor, Urgent.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8f65db98-4307-4298-8468-dab10f0a81f0' AND (Help IS NULL) AND EntityType='D';

-- R_Request (Table)
UPDATE AD_Reference SET Description='Table lookup for request records', Help='The Request reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='602d8645-dc0c-4908-a71f-6f5c07b5e661' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- R_Request TaskStatus (List)
UPDATE AD_Reference SET Description='Selection list for request task status values', Help='The Request TaskStatus reference provides a dropdown selection with 9 predefined values. Available options:  0% Not Started,  20% Started,  80% Nearly Done,  40% Busy,  90% Finishing and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8ebe721c-5fd6-4a0d-92b8-ae59dab6efc0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_BOM Type (List)
UPDATE AD_Reference SET Description='Selection list for bom type values', Help='The BOM Type reference provides a dropdown selection with 9 predefined values. Available options: Product Configure, Future, Previous, Maintenance, Current Active and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5f12f890-56cd-40f0-8dda-0bdf479c724f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_BOM Use (List)
UPDATE AD_Reference SET Description='Selection list for bom use values', Help='The BOM Use reference provides a dropdown selection with 5 predefined values. Available options: Master, Manufacturing, Planning, Quality, Engineering.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='98948692-d3c8-41fe-a25d-73681a790be1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Time (DataType)
UPDATE AD_Reference SET Help='The Time reference time.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7450ca2c-8ddd-4f10-988d-7ae5b9a3f7f3' AND (Help IS NULL) AND EntityType='D';

-- AD_SysConfig ConfigurationLevel (List)
UPDATE AD_Reference SET Help='The SysConfig ConfigurationLevel reference provides a dropdown selection with 3 predefined values. Available options: System, Organization, Client.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5713af6a-aa8b-481a-8fcc-629f2429f45e' AND (Help IS NULL) AND EntityType='D';

-- AD_Find AndOr (List)
UPDATE AD_Reference SET Description='Selection list for find and or values', Help='The Find AndOr reference provides a dropdown selection with 2 predefined values. Available options: And, Or.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='12d8ebfe-46bc-444a-b57c-42bf4ffff4f4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Find Operation (List)
UPDATE AD_Reference SET Description='Selection list for find operation values', Help='The Find Operation reference provides a dropdown selection with 9 predefined values. Available options:  =, >=, <,  ~, |<x>| and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='11042667-4229-460d-9a61-a14f5b6d222e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_Join_Split (List)
UPDATE AD_Reference SET Description='Selection list for wf join split values', Help='The Workflow Join_Split reference provides a dropdown selection with 2 predefined values. Available options: AND, XOR.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='49039971-d23d-4b19-b5e2-f638d12132e6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_SubFlow Execution (List)
UPDATE AD_Reference SET Description='Selection list for wf sub flow execution values', Help='The Workflow SubFlow Execution reference provides a dropdown selection with 2 predefined values. Available options: Asynchronously, Synchronously.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5920cae5-3079-49ec-a33f-b3125303dd56' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Workflow (Table)
UPDATE AD_Reference SET Help='The Workflow reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7eefa55c-5623-4d04-89af-315d58c36d39' AND (Help IS NULL) AND EntityType='D';

-- AD_WF_Node EMailRecipient (List)
UPDATE AD_Reference SET Description='Selection list for wf node e mail recipient values', Help='The Workflow Node EMailRecipient reference provides a dropdown selection with 3 predefined values. Available options: Document Owner, WF Responsible, Document Business Partner.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5f2861a8-dece-4001-9274-f267bd02efa9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_WF_Next Nodes (Table)
UPDATE AD_Reference SET Help='The Workflow Next Nodes reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d9277618-7847-44b2-baf9-f30a740a417f' AND (Help IS NULL) AND EntityType='D';

-- AD_User ConnectionProfile (List)
UPDATE AD_Reference SET Description='Selection list for user connection profile values', Help='The User ConnectionProfile reference provides a dropdown selection with 4 predefined values. Available options: Terminal Server, VPN, WAN, LAN.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='317ddc73-9278-446e-ae10-b3d4cb55f0f8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_DurationUnit (List)
UPDATE AD_Reference SET Description='Selection list for wf duration unit values', Help='The Workflow DurationUnit reference provides a dropdown selection with 6 predefined values. Available options: Month, Day, minute, second, Year and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='70643e5c-6a70-495f-8f7b-8003b6c0cd6b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Workflow Type (List)
UPDATE AD_Reference SET Help='The Workflow Type reference provides a dropdown selection with 6 predefined values. Available options: General, Quality, Document Process, Document Value, Manufacturing and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e6913918-0029-4739-b78b-c59fb28f99c5' AND (Help IS NULL) AND EntityType='D';

-- M_Product Category  (Table)
UPDATE AD_Reference SET Description='Table lookup for product category records', Help='The Product Category  reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b63c9407-6e16-4004-b34a-dd5082b07726' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Replenish Type (List)
UPDATE AD_Reference SET Description='Selection list for replenish type values', Help='The Replenish Type reference provides a dropdown selection with 4 predefined values. Available options: Manual, Reorder below Minimum Level, Custom, Maintain Maximum Level.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e015484b-1aa1-48fc-b50a-5a7a2b0487f1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Message (Table)
UPDATE AD_Reference SET Help='The Message reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e4ca5380-eb37-4f5b-98cc-6af9efcaf743' AND (Help IS NULL) AND EntityType='D';

-- CRM Schedule (List)
UPDATE AD_Reference SET Description='Selection list for crm schedule values', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e49b4230-c2ca-4eba-aeb7-fe1d813f916a' AND (Description IS NULL) AND EntityType='D';

-- C_Accounting Schema Costing Method (List)
UPDATE AD_Reference SET Help='The Accounting Schema Costing Method reference provides a dropdown selection with 9 predefined values. Available options: Average PO, Lifo, Fifo, Last PO Price, Last Invoice and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c5169b1d-7a65-43a4-8a5f-f4b48d817653' AND (Help IS NULL) AND EntityType='D';

-- C_Document Type MFG (Table)
UPDATE AD_Reference SET Description='Table lookup for document type MFG records', Help='The Document Type MFG reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='caff5c0e-ad99-4216-973b-58d71007a82d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Charge (Table)
UPDATE AD_Reference SET Description='Table lookup for charge records', Help='The Charge reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5dd4d0f1-1331-4593-93aa-6e244592322c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Shipment ReceiptConfirm Type (List)
UPDATE AD_Reference SET Description='Selection list for shipment receipt confirm type values', Help='The Shipment ReceiptConfirm Type reference provides a dropdown selection with 5 predefined values. Available options: Customer Confirmation, Ship/Receipt Confirm, Pick/QA Confirm, Vendor Confirmation, Drop Ship Confirm.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4fcd74bd-48cd-42d4-b326-c2660b308de2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Product (stocked) (Table)
UPDATE AD_Reference SET Description='Table lookup for product (stocked) records', Help='The Product (stocked) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='84d235b1-51f2-46e6-b33a-944330be7c3a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Locator (Table)
UPDATE AD_Reference SET Help='The Locator reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='aa78c089-2e1c-44b7-8a02-4f312001dcdd' AND (Help IS NULL) AND EntityType='D';

-- AD_Language (Table)
UPDATE AD_Reference SET Help='The Language reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='19388d53-07c3-488c-9639-a136159c4c8d' AND (Help IS NULL) AND EntityType='D';

-- C_Tax SPPOType (List)
UPDATE AD_Reference SET Description='Selection list for tax sppo type values', Help='The Tax SPPOType reference provides a dropdown selection with 3 predefined values. Available options: Both, Sales Tax, Purchase Tax.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7cadeb17-0c93-477a-bbec-8ee2ed9b4818' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Country (Table)
UPDATE AD_Reference SET Help='The Country reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b25783a0-76b9-4d88-b632-9b61d815a29b' AND (Help IS NULL) AND EntityType='D';

-- C_Region (Table)
UPDATE AD_Reference SET Help='The Region reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='52c5622a-c67b-4922-bc50-661fab662155' AND (Help IS NULL) AND EntityType='D';

-- AD_Table Replication Type (List)
UPDATE AD_Reference SET Help='The Table Replication Type reference provides a dropdown selection with 4 predefined values. Available options: Local, Merge, Reference, Broadcast.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='127678cd-2064-47fc-b5fe-ea10f55ae631' AND (Help IS NULL) AND EntityType='D';

-- _EntityTypeNew (Table)
UPDATE AD_Reference SET Description='Table lookup for entity type new records', Help='The _EntityTypeNew reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='99f0e1d4-2218-40cb-bb5d-05e0b7370338' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Reference Data Types (Table)
UPDATE AD_Reference SET Help='The Reference Data Types reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9752c3de-2bb4-46ee-bc2c-4c48f641980c' AND (Help IS NULL) AND EntityType='D';

-- Binary (DataType)
UPDATE AD_Reference SET Help='The Binary reference binary Data.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b000bcfd-27f1-40b2-88f1-a15f1f5f602e' AND (Help IS NULL) AND EntityType='D';

-- AD_Print Format Invoice (Table)
UPDATE AD_Reference SET Description='Table lookup for print format invoice records', Help='The Print Format Invoice reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ef178659-6643-4018-a27f-4b007be2da20' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_DiscountSchema not PL (Table)
UPDATE AD_Reference SET Help='The DiscountSchema not PL reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='01406213-e2bf-4f92-a82f-e7dc22678887' AND (Help IS NULL) AND EntityType='D';

-- C_Payment Term (Table)
UPDATE AD_Reference SET Description='Table lookup for payment term records', Help='The Payment Term reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1380661f-3d06-49ec-9ed3-99e023e8638d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Price List (Table)
UPDATE AD_Reference SET Description='Table lookup for price list records', Help='The Price List reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='704c2688-5945-4c8f-be8e-a0a5e72db528' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Costs+Prices (DataType)
UPDATE AD_Reference SET Help='The Costs+Prices reference costs + Prices (minimum currency precision but if exists more).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1d9eac18-2bad-45e3-b8f0-9cd313fa2e27' AND (Help IS NULL) AND EntityType='D';

-- _Payment Rule (List)
UPDATE AD_Reference SET Help='The _Payment Rule reference provides a dropdown selection with 7 predefined values. Available options: Direct Deposit, Credit Card, Check, Cash, On Credit and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='af0136e2-1ec4-4b60-a8a1-dc6c252e4878' AND (Help IS NULL) AND EntityType='D';

-- C_Order DeliveryRule (List)
UPDATE AD_Reference SET Help='The Order DeliveryRule reference provides a dropdown selection with 6 predefined values. Available options: Availability, Complete Line, Complete Order, Manual, Force and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3da0090a-448b-40a1-abc4-0fd7642bfb76' AND (Help IS NULL) AND EntityType='D';

-- AD_Language System (Table)
UPDATE AD_Reference SET Help='The Language System reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4e168963-fbb1-4910-a102-69e5f6fd1a9b' AND (Help IS NULL) AND EntityType='D';

-- C_Order InvoiceRule (List)
UPDATE AD_Reference SET Help='The Order InvoiceRule reference provides a dropdown selection with 4 predefined values. Available options: After Delivery, Customer Schedule after Delivery, Immediate, After Order delivered.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9650d309-537c-4464-acfe-a65393795c4f' AND (Help IS NULL) AND EntityType='D';

-- C_Bank Account Type (List)
UPDATE AD_Reference SET Description='Selection list for bank account type values', Help='The Bank Account Type reference provides a dropdown selection with 4 predefined values. Available options: Savings, Checking, Cash, Card.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c1ba91c6-b25b-4d60-9dd4-3eba530a32a0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Payment CreditCard Type (List)
UPDATE AD_Reference SET Help='The Payment CreditCard Type reference provides a dropdown selection with 7 predefined values. Available options: Purchase Card, Amex, MasterCard, ATM, Diners and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0899cbf5-9d37-4d71-88b1-0a9219ffa760' AND (Help IS NULL) AND EntityType='D';

-- C_Payment AVS (List)
UPDATE AD_Reference SET Description='Selection list for payment avs values', Help='The Payment AVS reference provides a dropdown selection with 3 predefined values. Available options: No Match, Unavailable, Match.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='46afbde8-ce5b-4c6c-9e9c-d5ff947cef9a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Document Type (Table)
UPDATE AD_Reference SET Description='Table lookup for document type records', Help='The Document Type reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b37891dd-c61d-44ac-817b-58bce19e7721' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_User - Sales Representative (Table)
UPDATE AD_Reference SET Help='The User - Sales Representative reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='48cbfbe5-eca9-44e4-9103-7d71bcf2442b' AND (Help IS NULL) AND EntityType='D';

-- M_Inventory (Table)
UPDATE AD_Reference SET Description='Table lookup for inventory records', Help='The Inventory reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3f0dcf61-a1bd-44c1-9fd0-38b657e102b8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- GL_Journal (Table)
UPDATE AD_Reference SET Description='Table lookup for journal records', Help='The Journal reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e58de195-e57d-4a74-91a7-1e99003eefbe' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- GL_JournalBatch (Table)
UPDATE AD_Reference SET Description='Table lookup for journal batch records', Help='The General Ledger JournalBatch reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6c3eefb0-e47d-4744-be8b-3140d1e0f040' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Org (all) (Table)
UPDATE AD_Reference SET Help='The Organization (all) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4a86c23a-23bd-47f6-9f46-181f1374c99e' AND (Help IS NULL) AND EntityType='D';

-- Account (DataType)
UPDATE AD_Reference SET Help='The Account reference account Element.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f9521952-b4a9-464a-abe2-189c277db425' AND (Help IS NULL) AND EntityType='D';

-- _Posted Status (List)
UPDATE AD_Reference SET Description='Selection list for posted status values', Help='The _Posted Status reference provides a dropdown selection with 9 predefined values. Available options: Posting Error, Not Posted, Not Balanced, Not Convertible (no rate), Invalid Account and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f9ee1b55-e369-41e5-83d2-a5a018a4a148' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Org (Trx) (Table)
UPDATE AD_Reference SET Help='The Organization (Trx) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='588e8e7e-ed95-4003-b78e-3e98a1fb1fd9' AND (Help IS NULL) AND EntityType='D';

-- URL (DataType)
UPDATE AD_Reference SET Help='The URL reference uRL.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6b72e0df-2f48-4a7d-8aef-1630faec9e53' AND (Help IS NULL) AND EntityType='D';

-- AD_User - Internal (Table)
UPDATE AD_Reference SET Help='The User - Internal reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='19649487-d0a9-4c95-a74a-960f77ef1830' AND (Help IS NULL) AND EntityType='D';

-- Amount (DataType)
UPDATE AD_Reference SET Help='The Amount reference number with 4 decimals.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='75558709-04db-4ea0-8a21-ee4dc1dff574' AND (Help IS NULL) AND EntityType='D';

-- A_Table_Rate_Type (List)
UPDATE AD_Reference SET Help='The Table_Rate_Type reference provides a dropdown selection with 2 predefined values. Available options: Rate, Amount.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7d216d53-fe0a-460e-8f59-4da5a6a60773' AND (Help IS NULL) AND EntityType='D';

-- A_Reval_Multiplier (List)
UPDATE AD_Reference SET Help='The Reval_Multiplier reference provides a dropdown selection with 2 predefined values. Available options: Factor, Index.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6fccfd38-a59f-4744-a632-837a337511bd' AND (Help IS NULL) AND EntityType='D';

-- A_Reval_Code (List)
UPDATE AD_Reference SET Help='The Reval_Code reference provides a dropdown selection with 3 predefined values. Available options: Revaluation Code #1, Revaluation Code #3, Revaluation Code #2.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='357e2690-4c0e-4bc3-bbb0-e4aaedc1298e' AND (Help IS NULL) AND EntityType='D';

-- A_Split_Type (List)
UPDATE AD_Reference SET Help='The Split_Type reference provides a dropdown selection with 3 predefined values. Available options: Amount, Percentage, Quantity.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0ceeacfc-6fbb-4451-9db0-77c05067dac6' AND (Help IS NULL) AND EntityType='D';

-- A_Depreciation_Calc_Type (Table)
UPDATE AD_Reference SET Help='The Depreciation_Calc_Type reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='971ea4a9-9ad4-46e3-a31d-622da87b772f' AND (Help IS NULL) AND EntityType='D';

-- C_Invoice (Vendor) (Table)
UPDATE AD_Reference SET Help='The Invoice (Vendor) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='60961fcb-c0bc-4f84-8c8c-4488aae7bfae' AND (Help IS NULL) AND EntityType='D';

-- C_ValidCombination (Assets) (Table)
UPDATE AD_Reference SET Help='The ValidCombination (Assets) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1ef773cf-d212-445a-bcd0-28293f1d75cb' AND (Help IS NULL) AND EntityType='D';

-- _MRP Order Type (List)
UPDATE AD_Reference SET Description='Selection list for mrp order type values', Help='The _MRP Order Type reference provides a dropdown selection with 7 predefined values. Available options: Manufacturing Order, Purchase Order, Sales Order, Forecast, Safety Stock and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='91930879-9ea2-42e4-b1d2-40cfb71e2612' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Bank Account (Table)
UPDATE AD_Reference SET Description='Table lookup for bank account records', Help='The Bank Account reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d53fe4c6-cb43-4fcd-84e4-9f6b1654256c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_MovementLine (Table)
UPDATE AD_Reference SET Description='Table lookup for movement line records', Help='The MovementLine reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b6f71266-6cf2-4df4-b125-a493f22b1b4d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Bank (Table)
UPDATE AD_Reference SET Description='Table lookup for bank records', Help='The Bank reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ed76140c-6099-4226-a1eb-78b161d0fe5f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Movement (Table)
UPDATE AD_Reference SET Description='Table lookup for movement records', Help='The Movement reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6d43559e-a323-4ce7-8ce5-47f4b14711dd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- _MMPolicy (List)
UPDATE AD_Reference SET Help='The _MMPolicy reference provides a dropdown selection with 2 predefined values. Available options: LiFo, FiFo.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4ff16fed-394b-4c6d-b987-466fd03f9c77' AND (Help IS NULL) AND EntityType='D';

-- C_LandedCost Distribution (List)
UPDATE AD_Reference SET Description='Selection list for landed cost distribution values', Help='The LandedCost Distribution reference provides a dropdown selection with 5 predefined values. Available options: Quantity, Volume, Weight, Line, Costs.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='abdb6bff-b20d-40a8-ad59-1aa9c03e10a9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_User BP AccessType (List)
UPDATE AD_Reference SET Description='Selection list for user bp access type values', Help='The User BP AccessType reference provides a dropdown selection with 3 predefined values. Available options: Assets, Download, Business Documents, Requests.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ba7f298b-f7bc-4a0a-9d10-d31e48a84907' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Table TableName (Table)
UPDATE AD_Reference SET Description='Table lookup for table table name records', Help='The Table TableName reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1b3ffaac-bb83-4d6e-b844-c92114762e0b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- SearchType (List)
UPDATE AD_Reference SET Description='Selection list for search type values', Help='The SearchType reference provides a dropdown selection with 2 predefined values. Available options: Query, Table.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9f4c3e22-b798-47e5-bc26-d4f55b02fd8a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_RMA (Table)
UPDATE AD_Reference SET Help='The RMA reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c26ceb07-1168-4e0d-ae9a-042e66289145' AND (Help IS NULL) AND EntityType='D';

-- M_RMALine (Table)
UPDATE AD_Reference SET Help='The RMALine reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4958d6f1-96de-49f6-a4ae-1d790aefc159' AND (Help IS NULL) AND EntityType='D';

-- M_PromotionDistribution Operation (List)
UPDATE AD_Reference SET Description='Selection list for promotion distribution operation values', Help='The PromotionDistribution Operation reference provides a dropdown selection with 2 predefined values. Available options: >=, <=.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2062105c-0fbb-49db-9485-5ed486a62413' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_PromotionDistribution Sorting (List)
UPDATE AD_Reference SET Help='The PromotionDistribution Sorting reference provides a dropdown selection with 2 predefined values. Available options: Ascending, Descending.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c221ea87-ab94-4fc4-97ab-321ab6d7afe7' AND (Help IS NULL) AND EntityType='D';

-- M_PromotionDistribution (Table)
UPDATE AD_Reference SET Description='Table lookup for promotion distribution records', Help='The PromotionDistribution reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f48613ef-e31a-4287-936f-b053231db0dd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_PromotionReward Type (List)
UPDATE AD_Reference SET Description='Selection list for promotion reward type values', Help='The PromotionReward Type reference provides a dropdown selection with 3 predefined values. Available options: Flat Discount, Percentage, Absolute Amount.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a32947f0-38c5-4f75-b34e-ae2cb95e8dc0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Goal ChartType (List)
UPDATE AD_Reference SET Help='The Performance Goal ChartType reference provides a dropdown selection with 6 predefined values. Available options: Bar Chart, Pie Chart, Ring Chart, Area Chart, Waterfall Chart and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8648db06-f75e-4db2-aede-6ebf3524f3b7' AND (Help IS NULL) AND EntityType='D';

-- Text (DataType)
UPDATE AD_Reference SET Help='The Text reference character String up to 2000 characters.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a52011ae-3d88-4a9b-8179-a42330a26f5b' AND (Help IS NULL) AND EntityType='D';

-- Quantity (DataType)
UPDATE AD_Reference SET Help='The Quantity reference quantity data type.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='784b385c-a9d8-4f54-8627-1139b41e1b22' AND (Help IS NULL) AND EntityType='D';

-- A_Asset_ID (Table)
UPDATE AD_Reference SET Help='The Asset_ID reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='30e6b8d1-b875-4135-ba96-397d8ba134f5' AND (Help IS NULL) AND EntityType='D';

-- A_Depreciation_Type (Table)
UPDATE AD_Reference SET Help='The Depreciation_Type reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6c39726a-6165-4020-86f5-6d87f9478ab0' AND (Help IS NULL) AND EntityType='D';

-- A_Depreciation_Table_Codes (Table)
UPDATE AD_Reference SET Help='The Depreciation_Table_Codes reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='83783dda-3f00-4b8d-af7a-2cfcd94588a4' AND (Help IS NULL) AND EntityType='D';

-- A_Reval_Method_Type (List)
UPDATE AD_Reference SET Help='The Reval_Method_Type reference provides a dropdown selection with 3 predefined values. Available options: Default, Year Balances, Inception to date.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8c0c71ba-8655-4422-b787-f85f2335282f' AND (Help IS NULL) AND EntityType='D';

-- A_Asset_Spread (Table)
UPDATE AD_Reference SET Help='The Asset_Spread reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f2d72977-139a-4303-a940-f63b75a71837' AND (Help IS NULL) AND EntityType='D';

-- DocumentNo Invoice Vendor (Table)
UPDATE AD_Reference SET Description='Table lookup for document no invoice vendor records', Help='The DocumentNo Invoice Vendor reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8473a3cf-05b4-48aa-8a0c-47357b18fbd8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- _Document Status (List)
UPDATE AD_Reference SET Help='The _Document Status reference provides a dropdown selection with 12 predefined values. Available options: Waiting Confirmation, Approved, Completed, Drafted, Invalid and 7 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d3f99f22-0b84-48bc-a157-38a3adf89435' AND (Help IS NULL) AND EntityType='D';

-- A_Disposed_Reason (List)
UPDATE AD_Reference SET Help='The Disposed_Reason reference provides a dropdown selection with 6 predefined values. Available options: Charity, Destroyed, Scraped, Sold, Theft and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='be914982-ef22-4858-aced-cc1516b3fabf' AND (Help IS NULL) AND EntityType='D';

-- A_Disposal_Method (List)
UPDATE AD_Reference SET Help='The Disposal_Method reference provides a dropdown selection with 8 predefined values. Available options: Trade w/cash, Simple, Cash, Trade, Simple_ and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0f5ae796-6292-4f64-b863-9045d5263ef5' AND (Help IS NULL) AND EntityType='D';

-- A_Update_Type (List)
UPDATE AD_Reference SET Help='The Update_Type reference provides a dropdown selection with 14 predefined values. Available options: Addition, Balance, Depreciation, Disposal, Forecast and 9 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='369f43ee-0cfb-4e87-a427-57a675a66f39' AND (Help IS NULL) AND EntityType='D';

-- A_Payment_Due (List)
UPDATE AD_Reference SET Help='The Payment_Due reference provides a dropdown selection with 4 predefined values. Available options: 15th of every month, 1st of every month, Yearly on or before contract date, Beginning of every month.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0f86dac9-3a3b-4ab3-8189-4816b635fc96' AND (Help IS NULL) AND EntityType='D';

-- A_Entry_Type (List)
UPDATE AD_Reference SET Help='The Entry_Type reference provides a dropdown selection with 6 predefined values. Available options: Depreciation, Forecasts, New, Splits, Transfers and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2ee32e65-e764-4778-8eba-2524298815ce' AND (Help IS NULL) AND EntityType='D';

-- Search (DataType)
UPDATE AD_Reference SET Help='The Search reference search Field.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='199e084e-6ad2-4bcd-8f5e-fdd08f4c0748' AND (Help IS NULL) AND EntityType='D';

-- PA_ReportCube (Table)
UPDATE AD_Reference SET Description='Table lookup for report cube records', Help='The Performance ReportCube reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4d49a7c1-87e7-415a-9f36-e2535745e97b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- UOM Type (List)
UPDATE AD_Reference SET Description='Selection list for uom type values', Help='The UOM Type reference provides a dropdown selection with 21 predefined values. Available options: Angle, Data Storage, Density, Energy, Kitchen Measures and 16 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='278ae63d-f284-469a-9aed-253c29d4355f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Report Period Type (List)
UPDATE AD_Reference SET Description='Selection list for report period type values', Help='The Performance Report Period Type reference provides a dropdown selection with 4 predefined values. Available options: Total, Year, Natural, Period.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c4bd4986-8264-47d7-8f6a-c4bc1ce48e66' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Report AmountType (deprecated) (List)
UPDATE AD_Reference SET Description='Selection list for report amount type (deprecated) values', Help='The Performance Report AmountType (deprecated) reference provides a dropdown selection with 13 predefined values. Available options: Period Credit Only, Period Debit Only, Period Quantity, Year Balance, Year Credit Only and 8 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='80d05d76-a442-4424-8946-69bd7f739eae' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Report Amount Type (List)
UPDATE AD_Reference SET Description='Selection list for report amount type values', Help='The Performance Report Amount Type reference provides a dropdown selection with 6 predefined values. Available options: Balance (expected sign), Credit Only, Balance (accounted sign), Quantity (accounted sign), Debit Only and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a9ded446-8166-448a-b537-f63d461439fc' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- _YesNo (List)
UPDATE AD_Reference SET Description='Selection list for yes no values', Help='The _YesNo reference provides a dropdown selection with 2 predefined values. Available options: Yes, No.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='de0c3f82-e8fa-4118-939a-9876ec70f1a8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_DiscountSchema PL (Table)
UPDATE AD_Reference SET Help='The DiscountSchema PL reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1e7c9344-8832-4c04-81c1-988b6341717c' AND (Help IS NULL) AND EntityType='D';

-- AD_Reference Table (Table)
UPDATE AD_Reference SET Description='Table lookup for reference table records', Help='The Reference Table reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e4447423-bfb8-43a6-8013-abd85803b221' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType M_Shipment Receipt (Shipment) <=  C_Order_ID (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type m shipment receipt (shipment) <= c order id records', Help='The RelType M_Shipment Receipt (Shipment) <=  C_Order_ID reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='165e8094-969b-480c-b480-e651f69385d0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType Vendor Return <= C_Business Partner_ID (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type vendor return <= c business partner id records', Help='The RelType Vendor Return <= C_Business Partner_ID reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='74671b05-20df-43a1-93a0-3da1b77fef1a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType C_Business Partner <= Vendor/Customer Return (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type c business partner <= vendor/customer return records', Help='The RelType C_Business Partner <= Vendor/Customer Return reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2b8ca30f-35b1-4eb6-a481-71a7798b9fb5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType Customer Return <= C_Business Partner_ID (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type customer return <= c business partner id records', Help='The RelType Customer Return <= C_Business Partner_ID reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f273af0d-e84b-4fa7-ab85-9c1a3aebf18f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Role (Table)
UPDATE AD_Reference SET Description='Table lookup for role records', Help='The Role reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7c19b2cf-eb54-47f2-9b61-0e3b5cd3a133' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType C_Order (Sales) <=  M_Shipment Receipt_ID (Shipment) (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type c order (sales) <= m shipment receipt id (shipment) records', Help='The RelType C_Order (Sales) <=  M_Shipment Receipt_ID (Shipment) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='22b7b062-434f-4306-919a-290db49b48a3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType C_Order (Sales) <= C_Invoice_ID (Customer) (Table)
UPDATE AD_Reference SET Help='The RelType C_Order (Sales) <= C_Invoice_ID (Customer) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a817a199-4b24-431a-b274-116cadf8a9b6' AND (Help IS NULL) AND EntityType='D';

-- RelType C_Invoice (Customer) <= C_Order_ID (Sales) (Table)
UPDATE AD_Reference SET Help='The RelType C_Invoice (Customer) <= C_Order_ID (Sales) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='976596e4-21e2-48d5-861c-7bca94a7b386' AND (Help IS NULL) AND EntityType='D';

-- RelType C_Invoice (Customer) <= M_Shipment Receipt_ID (Shipment) (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type c invoice (customer) <= m shipment receipt id (shipment) records', Help='The RelType C_Invoice (Customer) <= M_Shipment Receipt_ID (Shipment) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='220ba26d-1931-4ecb-93ca-13dab06f6bcf' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType M_Shipment Receipt (Shipment) <= C_Invoice_ID (Customer) (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type m shipment receipt (shipment) <= c invoice id (customer) records', Help='The RelType M_Shipment Receipt (Shipment) <= C_Invoice_ID (Customer) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5cc0a966-b353-42aa-876e-84ed0dff341f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Payment Term Payment TermUsage (List)
UPDATE AD_Reference SET Description='Selection list for payment term payment term usage values', Help='The Payment Term Payment TermUsage reference provides a dropdown selection with 3 predefined values. Available options: Both, Purchases, Sales.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ba292f99-7098-4aca-9a47-6fb8959909f1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Payment Term Sales (Table)
UPDATE AD_Reference SET Description='Table lookup for payment term sales records', Help='The Payment Term Sales reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2ada4b3a-06b0-4096-a848-3862afe974c8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Payment Term Purchases (Table)
UPDATE AD_Reference SET Description='Table lookup for payment term purchases records', Help='The Payment Term Purchases reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='72f96c3d-c1b3-423b-a08a-185f277525ad' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_CashPlan Cash FlowType (List)
UPDATE AD_Reference SET Description='Selection list for cash plan cash flow type values', Help='The CashPlan Cash FlowType reference provides a dropdown selection with 3 predefined values. Available options: Financing, Operational, Investment.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3b08a06d-5821-4e7e-afbe-99894e8bc106' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- T_Cash Flow Cash FlowSource (List)
UPDATE AD_Reference SET Description='Selection list for t cash flow cash flow source values', Help='The Temporary Cash Flow Cash FlowSource reference provides a dropdown selection with 4 predefined values. Available options: 1_Initial Balance, 3_Commitments (Orders), 4_Actual Debt (Invoices), 2_Plan.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f2cb24a3-2d43-48e3-9ab2-8e1687130aea' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Remuneration Type (List)
UPDATE AD_Reference SET Description='Selection list for remuneration type values', Help='The Remuneration Type reference provides a dropdown selection with 6 predefined values. Available options: Hourly, Weekly, Monthly, Bi-Weekly, Daily and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fd9a58be-de1c-40a2-8d55-5750014c0b0c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Ratio ElementType (List)
UPDATE AD_Reference SET Description='Selection list for ratio element type values', Help='The Performance Ratio ElementType reference provides a dropdown selection with 4 predefined values. Available options: Ratio, Constant, Calculation, Account Value.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='84c5d263-2865-4555-a3d6-bcaa8c9ade48' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Image (DataType)
UPDATE AD_Reference SET Help='The Image reference binary Image Data.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='23efa169-7f2d-4557-8f24-12db6442e985' AND (Help IS NULL) AND EntityType='D';

-- CM_WikiToken Type (List)
UPDATE AD_Reference SET Description='Selection list for cm wiki token type values', Help='The Content WikiToken Type reference provides a dropdown selection with 4 predefined values. Available options: SQL Command, Internal Link, Style, External Link.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='28e768c7-0065-4f07-af50-0cf45298e47a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_ImpFormat Type (List)
UPDATE AD_Reference SET Description='Selection list for imp format type values', Help='The ImpFormat Type reference provides a dropdown selection with 6 predefined values. Available options: Product, Business Partner, Accounts, Exchange Rates, Inventory Count and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='421473df-acea-4487-ad44-ac23c94a3aa1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Product BOM (stocked) (Table)
UPDATE AD_Reference SET Help='The Product BOM (stocked) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0670b1e1-4ca4-428a-9a89-b3348f0a58f5' AND (Help IS NULL) AND EntityType='D';

-- PA_Achievement Parent (Table)
UPDATE AD_Reference SET Description='Table lookup for achievement parent records', Help='The Performance Achievement Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='74c97589-9a1c-4fe0-bf3e-27ca1191909d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_Report LineType (List)
UPDATE AD_Reference SET Description='Selection list for report line type values', Help='The Performance Report LineType reference provides a dropdown selection with 3 predefined values. Available options: Segment Value, Calculation, Blank line.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='14d87e50-da89-46e5-a5f2-96cf88467824' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Column Key ColumnNames (Table)
UPDATE AD_Reference SET Description='Table lookup for column key column names records', Help='The Column Key ColumnNames reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8eb6dba5-fffd-444e-9483-c70b985a6786' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Project Parent (Table)
UPDATE AD_Reference SET Description='Table lookup for project parent records', Help='The Project Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8952a39d-38f3-4df9-99db-f71926f7dc94' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Business Partner Customers (Table)
UPDATE AD_Reference SET Help='The Business Partner Customers reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='aab97e5b-6d66-4caa-8eeb-e4b1faedb27c' AND (Help IS NULL) AND EntityType='D';

-- C_PeriodControl Status (List)
UPDATE AD_Reference SET Description='Selection list for period control status values', Help='The PeriodControl Status reference provides a dropdown selection with 5 predefined values. Available options: Open, Closed, Permanently closed, Never opened, Document closed.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='39f1baa3-923f-4506-aaac-432130a03451' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Date (DataType)
UPDATE AD_Reference SET Help='The Date reference date mm/dd/yyyy.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fea92a20-5ea7-445c-b010-101d74f5e124' AND (Help IS NULL) AND EntityType='D';

-- Yes-No (DataType)
UPDATE AD_Reference SET Help='The Yes-No reference checkBox.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1dab6dbd-8d84-4ba5-87df-e2ca93d2c976' AND (Help IS NULL) AND EntityType='D';

-- Date+Time (DataType)
UPDATE AD_Reference SET Help='The Date+Time reference date with time.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9e410fd2-9e6c-4b19-842a-ef4634405244' AND (Help IS NULL) AND EntityType='D';

-- Locator (WH) (DataType)
UPDATE AD_Reference SET Help='The Locator (WH) reference warehouse Locator Data type.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f5af5e4a-246e-4fbe-9024-1c745ec5bbbb' AND (Help IS NULL) AND EntityType='D';

-- List (DataType)
UPDATE AD_Reference SET Help='The List reference reference List.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='70bc89e7-5848-4ff5-a1f0-e1b1aed3796f' AND (Help IS NULL) AND EntityType='D';

-- String (DataType)
UPDATE AD_Reference SET Help='The String reference character String.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3f9a0323-219e-4b97-af37-58a2486a50e3' AND (Help IS NULL) AND EntityType='D';

-- AD_User (Table)
UPDATE AD_Reference SET Help='The User reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3f317876-0b22-44c2-95bb-4201bf9ca37b' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner Vendor or Sales Representative (Table)
UPDATE AD_Reference SET Help='The Business Partner Vendor or Sales Representative reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0ecd6938-67b6-4bf3-91bf-ce98f475f594' AND (Help IS NULL) AND EntityType='D';

-- Table Direct (DataType)
UPDATE AD_Reference SET Help='The Table Direct reference direct Table Access.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='85767149-7019-4224-a8d0-41f0d9d77d47' AND (Help IS NULL) AND EntityType='D';

-- _ErrorType (List)
UPDATE AD_Reference SET Help='The _ErrorType reference provides a dropdown selection with 3 predefined values. Available options: Error, Warning, Information.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d0891bc0-6481-4a83-bcc7-6672c40ad3f8' AND (Help IS NULL) AND EntityType='D';

-- C_RevenueRecognition Frequency (List)
UPDATE AD_Reference SET Help='The RevenueRecognition Frequency reference provides a dropdown selection with 3 predefined values. Available options: Month, Quarter, Year.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='92675e47-88e3-4199-8383-8759e3df51f8' AND (Help IS NULL) AND EntityType='D';

-- AD_Print Line Alignment (List)
UPDATE AD_Reference SET Description='Selection list for print line alignment values', Help='The Print Line Alignment reference provides a dropdown selection with 4 predefined values. Available options: Leading (left), Center, None, Trailing (right).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='df243e56-5e2a-4b17-8867-82d65c89e47c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Column YesNo (Table)
UPDATE AD_Reference SET Help='The Column YesNo reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='86368db1-e422-480d-afc6-a9185fd93746' AND (Help IS NULL) AND EntityType='D';

-- WF_Participant Type (List)
UPDATE AD_Reference SET Description='Selection list for wf participant type values', Help='The Workflow Participant Type reference provides a dropdown selection with 5 predefined values. Available options: Organization, Human, Role, System Resource, Manual.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='de0a3032-6378-49fa-b1d9-6b4ff844f41b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_LoopType (List)
UPDATE AD_Reference SET Description='Selection list for wf loop type values', Help='The Workflow LoopType reference provides a dropdown selection with 2 predefined values. Available options: While Loop, Repeat Until Loop.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c94bf277-532a-407d-be7a-d3e4ac18a398' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_RfQ QuoteType (List)
UPDATE AD_Reference SET Description='Selection list for rfq quote type values', Help='The RfQ QuoteType reference provides a dropdown selection with 3 predefined values. Available options: Quote Total only, Quote All Lines, Quote Selected Lines.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='31fb71ed-4f2d-4098-b0c1-9070ed1c8d07' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Replenishment Create (List)
UPDATE AD_Reference SET Description='Selection list for replenishment create values', Help='The Replenishment Create reference provides a dropdown selection with 4 predefined values. Available options: Inventory Move, Requisition, Distribution Order, Purchase Order.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3d08996e-7b24-4793-ac92-ea12707278f3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Discount CumulativeLevel (List)
UPDATE AD_Reference SET Description='Selection list for discount cumulative level values', Help='The Discount CumulativeLevel reference provides a dropdown selection with 1 predefined values. Available options: Line.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2ae5871a-cb2f-4b2b-84b8-df0dcb4659ea' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_DiscountSchema (Table)
UPDATE AD_Reference SET Description='Table lookup for discount schema records', Help='The DiscountSchema reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3b1c8078-eeee-4f69-9ea4-3007228579a4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Table_Access RuleType (List)
UPDATE AD_Reference SET Help='The Table_Access RuleType reference provides a dropdown selection with 3 predefined values. Available options: Accessing, Reporting, Exporting.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3be5cbca-3df3-45b4-ac50-58a32817c5b2' AND (Help IS NULL) AND EntityType='D';

-- M_InventoryLine (Table)
UPDATE AD_Reference SET Description='Table lookup for inventory line records', Help='The InventoryLine reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4ad9dc9a-dbe1-41b7-8bb9-204fd9cc3231' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_ProductionLine (Table)
UPDATE AD_Reference SET Description='Table lookup for production line records', Help='The ProductionLine reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='330a6662-954f-4945-83e5-1529413fa0b3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Column Name (Table)
UPDATE AD_Reference SET Help='The Column Name reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5c3939e4-857f-4fc2-94a3-6dbb911fb113' AND (Help IS NULL) AND EntityType='D';

-- C_Recurring Type (List)
UPDATE AD_Reference SET Description='Selection list for recurring type values', Help='The Recurring Type reference provides a dropdown selection with 5 predefined values. Available options: Invoice, GL Journal, Project, Order, Payment.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='350589d9-2930-4c67-a245-ad16d091682c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Menu Parent (Table)
UPDATE AD_Reference SET Help='The Menu Parent reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b07b1d3e-f7a0-4595-9ff3-91a1ca06132d' AND (Help IS NULL) AND EntityType='D';

-- CM_WebAccessLog Type (List)
UPDATE AD_Reference SET Description='Selection list for cm web access log type values', Help='The Content WebAccessLog Type reference provides a dropdown selection with 3 predefined values. Available options: Web Access, Ad display, Redirect.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e8139fda-96ee-4d65-b1d0-b652b671080f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Period Type (List)
UPDATE AD_Reference SET Help='The Period Type reference provides a dropdown selection with 2 predefined values. Available options: Adjustment Period, Standard Calendar Period.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f2f7bfd0-1b50-45d4-ba79-515ab7b9b48b' AND (Help IS NULL) AND EntityType='D';

-- C_Location (Table)
UPDATE AD_Reference SET Help='The Location reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ed5987a2-94ae-40f6-b656-810533b6787b' AND (Help IS NULL) AND EntityType='D';

-- C_Project (No summary) (Table)
UPDATE AD_Reference SET Help='The Project (No summary) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8d6bd88a-4fb8-4d1e-b45b-1915b0bb1a47' AND (Help IS NULL) AND EntityType='D';

-- C_Document Type SubTypeSO (List)
UPDATE AD_Reference SET Help='The Document Type SubTypeSO reference provides a dropdown selection with 8 predefined values. Available options: Prepay Order, On Credit Order, POS Order, Warehouse Order, Standard Order and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='cc202193-5b64-4c10-8676-a5f9330277b4' AND (Help IS NULL) AND EntityType='D';

-- AD_PrintColor (Table)
UPDATE AD_Reference SET Description='Table lookup for print color records', Help='The PrintColor reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='450387e7-3f87-433c-a401-e83d3cc7fdda' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_PrintFont (Table)
UPDATE AD_Reference SET Description='Table lookup for print font records', Help='The PrintFont reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7c07360f-300a-4aa1-99ec-648a1107fef5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_DiscountPrice List RoundingRule (List)
UPDATE AD_Reference SET Help='The DiscountPrice List RoundingRule reference provides a dropdown selection with 10 predefined values. Available options: Currency Precision, No Rounding, Quarter .25 .50 .75, Dime .10, .20, .30, ..., Nickel .05, .10, .15, ... and 5 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b9a19782-8aa4-4055-ad7d-cd2b7d5deae8' AND (Help IS NULL) AND EntityType='D';

-- M_Shipment Receipt (Table)
UPDATE AD_Reference SET Description='Table lookup for shipment receipt records', Help='The Shipment Receipt reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d35fca74-e65f-442f-ac3e-89b4b1a5c25a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_ConversionType (Table)
UPDATE AD_Reference SET Description='Table lookup for conversion type records', Help='The ConversionType reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='eef1b583-d347-4a33-9b16-137adf2fa3c8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- GL_BudgetControl Scope (List)
UPDATE AD_Reference SET Description='Selection list for budget control scope values', Help='The General Ledger BudgetControl Scope reference provides a dropdown selection with 3 predefined values. Available options: Period only, Total, Year To Date.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e79f2500-7c12-4f8a-b0d6-90d57c7abf34' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- FilePath (DataType)
UPDATE AD_Reference SET Help='The FilePath reference local File Path.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='01c98c9e-c1a0-4a71-b1ad-c87e80c7017e' AND (Help IS NULL) AND EntityType='D';

-- EventModelValidator (List)
UPDATE AD_Reference SET Description='Selection list for event model validator values', Help='The EventModelValidator reference provides a dropdown selection with 25 predefined values. Available options: Table Before New, Table Before Change, Table After New, Table After Change, Table After Delete and 20 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5169fb06-bba4-4811-babd-89aab2299244' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Document Type DocBaseType (List)
UPDATE AD_Reference SET Help='The Document Type DocBaseType reference provides a dropdown selection with 32 predefined values. Available options: Material Production, AP Credit Memo, AR Credit Memo, GL Journal, AP Invoice and 27 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7843f536-1796-4dfb-ac60-f30c1ae1dfba' AND (Help IS NULL) AND EntityType='D';

-- R_Request Next Action (List)
UPDATE AD_Reference SET Description='Selection list for request next action values', Help='The Request Next Action reference provides a dropdown selection with 2 predefined values. Available options: None, Follow up.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bac7ba24-a436-4f53-a9c2-601fd47ffad3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Invoice (Table)
UPDATE AD_Reference SET Description='Table lookup for invoice records', Help='The Invoice reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2fe8fe83-1db6-4353-ad6a-75b02065a3af' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_Start-Finish Mode (List)
UPDATE AD_Reference SET Description='Selection list for wf start-finish mode values', Help='The Workflow Start-Finish Mode reference provides a dropdown selection with 2 predefined values. Available options: Manual, Automatic.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0443d801-b530-449d-bb42-e590bfd98fc7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- WF_Action (List)
UPDATE AD_Reference SET Help='The Workflow Action reference provides a dropdown selection with 13 predefined values. Available options: Document Action, EMail, User Form, Apps Report, Apps Process and 8 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='400a70d2-2946-4a55-b8ee-7a0886e892cf' AND (Help IS NULL) AND EntityType='D';

-- AD_Table Access Levels (List)
UPDATE AD_Reference SET Help='The Table Access Levels reference provides a dropdown selection with 6 predefined values. Available options: System+Client, Client only, Client+Organization, System only, All and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b6b47bab-c7ce-400e-b21a-ba99df801308' AND (Help IS NULL) AND EntityType='D';

-- _PublishStatus (List)
UPDATE AD_Reference SET Help='The _PublishStatus reference provides a dropdown selection with 4 predefined values. Available options: Released, Under Revision, Void, Test.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='20cbac18-bb34-4d5b-9f44-3327044779bc' AND (Help IS NULL) AND EntityType='D';

-- AD_System Status (List)
UPDATE AD_Reference SET Description='Selection list for system status values', Help='The System Status reference provides a dropdown selection with 3 predefined values. Available options: Production, Evaluation, Implementation.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ca89a118-f300-4735-9e19-14b38ca74439' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Period (all) (Table)
UPDATE AD_Reference SET Help='The Period (all) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1731599a-0bf2-45b0-a93d-482955adc3f0' AND (Help IS NULL) AND EntityType='D';

-- C_Tax (Table)
UPDATE AD_Reference SET Help='The Tax reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='53a30a25-970c-4413-99cb-bde694803770' AND (Help IS NULL) AND EntityType='D';

-- _Frequency Type (List)
UPDATE AD_Reference SET Help='The _Frequency Type reference provides a dropdown selection with 3 predefined values. Available options: Minute, Hour, Day.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a1d72d6d-7481-464f-9051-3e4492e6a325' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner SOCreditStatus (List)
UPDATE AD_Reference SET Help='The Business Partner SOCreditStatus reference provides a dropdown selection with 5 predefined values. Available options: Credit Hold, Credit Watch, No Credit Check, Credit Stop, Credit OK.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5073dd40-252a-4318-b7a3-ecf789c4eeaa' AND (Help IS NULL) AND EntityType='D';

-- C_Order FreightCostRule (List)
UPDATE AD_Reference SET Help='The Order FreightCostRule reference provides a dropdown selection with 5 predefined values. Available options: Freight included, Fix price, Line, Calculated, Customer Account.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='73a1f8dd-6bfb-42c8-ac12-a3301145f4f9' AND (Help IS NULL) AND EntityType='D';

-- C_Order DeliveryViaRule (List)
UPDATE AD_Reference SET Help='The Order DeliveryViaRule reference provides a dropdown selection with 3 predefined values. Available options: Pickup, Delivery, Shipper.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='42522223-92ae-4405-92dc-e02e2dea61a7' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner BPBank AccountUse (List)
UPDATE AD_Reference SET Description='Selection list for business partner bp bank acct use values', Help='The Business Partner BPBank AccountUse reference provides a dropdown selection with 4 predefined values. Available options: None, Both, Direct Debit, Direct Deposit.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='65ee0fad-0d3d-4183-bc33-17a65043ec8f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_User NotificationType (List)
UPDATE AD_Reference SET Description='Selection list for user notification type values', Help='The User NotificationType reference provides a dropdown selection with 4 predefined values. Available options: EMail+Notice, EMail, None, Notice.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6abff1f7-f160-4cee-9f30-e7f22d90cb81' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Element Value Account Sign (List)
UPDATE AD_Reference SET Help='The Element Value Account Sign reference provides a dropdown selection with 3 predefined values. Available options: Natural, Debit, Credit.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='96b867e6-436f-423a-a29d-8306d15fffe5' AND (Help IS NULL) AND EntityType='D';

-- C_Payment Tender Type (List)
UPDATE AD_Reference SET Help='The Payment Tender Type reference provides a dropdown selection with 6 predefined values. Available options: Direct Deposit, Credit Card, Check, Account, Cash and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9d124599-d720-436b-a609-011bcf2eff8e' AND (Help IS NULL) AND EntityType='D';

-- A_Reval_Effectivity (List)
UPDATE AD_Reference SET Help='The Reval_Effectivity reference provides a dropdown selection with 3 predefined values. Available options: Revaluation Date, Date Depreciation Started, Date Acquired.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e3ce3a73-0761-4ce9-8fe9-755da8ffc808' AND (Help IS NULL) AND EntityType='D';

-- C_Cash Book (Table)
UPDATE AD_Reference SET Description='Table lookup for cash book records', Help='The Cash Book reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3c1e8d2d-8ca7-481a-b6b2-d7e8909f5828' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_SearchDefinition_DataType (List)
UPDATE AD_Reference SET Description='Selection list for search definition data type values', Help='The SearchDefinition_DataType reference provides a dropdown selection with 2 predefined values. Available options: Integer, String.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='78bac60f-234b-4c3c-ac86-8c4f567755e0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_PromotionDistrition Type (List)
UPDATE AD_Reference SET Help='The PromotionDistrition Type reference provides a dropdown selection with 3 predefined values. Available options: Min, Minus, Max.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='37d1423d-2d9a-41ef-88e5-6254c0effe96' AND (Help IS NULL) AND EntityType='D';

-- PA_DashboardContent GoalDisplay (List)
UPDATE AD_Reference SET Help='The Performance DashboardContent GoalDisplay reference provides a dropdown selection with 3 predefined values. Available options: HTML Table, Chart, Gauge Indicator.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='82ea11ae-ee3b-4e64-9b79-4610cc20f224' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner -Active,Manufacturer, Non summary (Table)
UPDATE AD_Reference SET Description='Table lookup for business partner -active,manufacturer, non summary records', Help='The Business Partner -Active,Manufacturer, Non summary reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='90cdce3e-d75a-4ae1-a78d-3dd7af996952' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_RelationType Role (List)
UPDATE AD_Reference SET Help='The RelationType Role reference provides a dropdown selection with 2 predefined values. Available options: Order, Invoice.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e1247fbc-8c1e-45a4-8e75-bd849dd6df0b' AND (Help IS NULL) AND EntityType='D';

-- Generate Cash Plan Periodicity (List)
UPDATE AD_Reference SET Description='Selection list for generate cash plan periodicity values', Help='The Generate Cash Plan Periodicity reference provides a dropdown selection with 9 predefined values. Available options: Daily, Weekly, Biweekly, Monthly, Bimonthly and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c798e9af-f2d8-4f9c-b20a-5d0566cc6654' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_POSKeyLayout (Table)
UPDATE AD_Reference SET Description='Table lookup for pos key layout records', Help='The POSKeyLayout reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='93b1bd76-7978-44ca-95e8-7d9128199b2d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- POSKeyLayoutType (List)
UPDATE AD_Reference SET Help='The POSKeyLayoutType reference provides a dropdown selection with 3 predefined values. Available options: Keyboard, Numberpad, Product.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4fbf5a5e-95f5-45d9-91af-000626e8da53' AND (Help IS NULL) AND EntityType='D';

-- M_Warehouse of Tenant (Table)
UPDATE AD_Reference SET Description='Table lookup for warehouse of tenant records', Help='The Warehouse of Tenant reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4d05b955-9f90-4fbb-b7aa-e5543190ddd9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Reconciliation Type (List)
UPDATE AD_Reference SET Description='Selection list for reconciliation type values', Help='The Reconciliation Type reference provides a dropdown selection with 3 predefined values. Available options: Bank In Transit, Payment Clearing (Unalloc Cash/Payment Selection), AR/AP Trade (Receivables/Vendor Liabilities).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ab19e58d-aa2c-4700-868a-4c5e1cc546f6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Reconciliation Rules (Table)
UPDATE AD_Reference SET Description='Table lookup for reconciliation rules records', Help='The Reconciliation Rules reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e12f19c3-12c7-432b-955c-a22acc324be7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_FieldGroup (List)
UPDATE AD_Reference SET Help='The FieldGroup reference provides a dropdown selection with 4 predefined values. Available options: Tab, Label, Collapse, Do Nothing.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='922ae0fe-1419-4a3d-8671-6569b2f36e1e' AND (Help IS NULL) AND EntityType='D';

-- Product Attribute (DataType)
UPDATE AD_Reference SET Help='The Product Attribute reference product Attribute.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='715e6a13-a1ea-48a3-822a-f6752262663c' AND (Help IS NULL) AND EntityType='D';

-- Number (DataType)
UPDATE AD_Reference SET Help='The Number reference float Number.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2ad0cb02-a3a6-4f10-9036-680a142806d6' AND (Help IS NULL) AND EntityType='D';

-- _Document Action (List)
UPDATE AD_Reference SET Help='The _Document Action reference provides a dropdown selection with 14 predefined values. Available options: Approve, Reject, Post, Close, Reverse - Correct and 9 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='79951e35-0d36-459f-b165-8108d297946b' AND (Help IS NULL) AND EntityType='D';

-- A_Depreciation_Manual_Period (List)
UPDATE AD_Reference SET Help='The Depreciation_Manual_Period reference provides a dropdown selection with 2 predefined values. Available options: Yearly, Period.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b35e50ab-d06e-4482-9a3e-1947e3f93dd2' AND (Help IS NULL) AND EntityType='D';

-- A_ConventionType (Table)
UPDATE AD_Reference SET Help='The ConventionType reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='31ec3453-f979-4e90-b0eb-e87a07ddfb3d' AND (Help IS NULL) AND EntityType='D';

-- Button (DataType)
UPDATE AD_Reference SET Help='The Button reference command Button - starts a process.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='27b0ba03-0c18-4657-8981-00d12909751a' AND (Help IS NULL) AND EntityType='D';

-- M_Replenishment Production Create  (List)
UPDATE AD_Reference SET Description='Selection list for replenishment production create values', Help='The Replenishment Production Create  reference provides a dropdown selection with 5 predefined values. Available options: Inventory Movement, Purchase Order, Production, Requisition, Distribution Order.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='eca497f3-bfd7-4b8b-b861-1e510877f605' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Element Value (trx) Not Doc Controlled (Table)
UPDATE AD_Reference SET Help='The Element Value (trx) Not Doc Controlled reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3eee54d5-de41-43e7-8458-2b0edf17f4d8' AND (Help IS NULL) AND EntityType='D';

-- C_ValidCombination (with Alias defined) (Table)
UPDATE AD_Reference SET Help='The ValidCombination (with Alias defined) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a6e3090e-02ee-40d4-ac22-3437eafde75c' AND (Help IS NULL) AND EntityType='D';

-- AD_WizardProcess Status (List)
UPDATE AD_Reference SET Description='Selection list for wizard process status values', Help='The WizardProcess Status reference provides a dropdown selection with 6 predefined values. Available options: New, Pending, Finished, In-Progress, Skipped and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2ecdcec7-e361-4926-a8f7-a2f72bfd12e5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Check Status (List)
UPDATE AD_Reference SET Description='Selection list for check status values', Help='The Check Status reference provides a dropdown selection with 5 predefined values. Available options: Delayed, Replaced, Charged, Received, Returned.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d6785790-d25c-4952-b9ec-598abb69ed76' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Location (Address) (DataType)
UPDATE AD_Reference SET Help='The Location (Address) reference location/Address.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1c644695-0172-4f02-9643-aa07e93523bb' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner Vendors (Table)
UPDATE AD_Reference SET Help='The Business Partner Vendors reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='31350934-20b7-40e3-8cd1-2cf7d7cc1cae' AND (Help IS NULL) AND EntityType='D';

-- M_Product (no summary) (Table)
UPDATE AD_Reference SET Help='The Product (no summary) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='41478cd2-516c-4d25-bb51-dbfa6cb0440a' AND (Help IS NULL) AND EntityType='D';

-- _Posting Type (List)
UPDATE AD_Reference SET Help='The _Posting Type reference provides a dropdown selection with 5 predefined values. Available options: Actual, Budget, Statistical, Reservation, Commitment.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='13c9b5f6-2ef7-4054-9942-7d6720010b68' AND (Help IS NULL) AND EntityType='D';

-- C_Period (Open) (Table)
UPDATE AD_Reference SET Help='The Period (Open) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='38fe8cc7-e915-4d3c-868e-31c0e9816e45' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner Location (Table)
UPDATE AD_Reference SET Help='The Business Partner Location reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='68166de3-765e-44a8-bee6-fc57170b70d8' AND (Help IS NULL) AND EntityType='D';

-- ID (DataType)
UPDATE AD_Reference SET Help='The ID reference 10 Digit Identifier.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='caf89cca-530b-42c2-9b19-1749b16679de' AND (Help IS NULL) AND EntityType='D';

-- Table (DataType)
UPDATE AD_Reference SET Help='The Table reference table List.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d79e151d-6401-4e9f-8549-15357111a1ed' AND (Help IS NULL) AND EntityType='D';

-- Integer (DataType)
UPDATE AD_Reference SET Help='The Integer reference 10 Digit numeric.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='04246702-9e19-4942-89d8-643ca98535ef' AND (Help IS NULL) AND EntityType='D';

-- GL_JournalGeneratorLine BPDimensionType (List)
UPDATE AD_Reference SET Description='Selection list for journal generator line bp dimension type values', Help='The General Ledger JournalGeneratorLine BPDimensionType reference provides a dropdown selection with 3 predefined values. Available options: Column, Fixed, Same.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fecfd227-3c55-4ca7-bec7-bd66a7406005' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- A_Asset_Group (Table)
UPDATE AD_Reference SET Description='Table lookup for asset group records', Help='The Asset_Group reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7b48dd14-d089-400c-b16d-50031f6727b8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- A_Asset_Class (all) (Table)
UPDATE AD_Reference SET Description='Table lookup for asset class (all) records', Help='The Asset_Class (all) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='21572c14-4801-499a-a2cd-0c1c9c1230ba' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- A_Asset Status (List)
UPDATE AD_Reference SET Help='The Asset Status reference provides a dropdown selection with 7 predefined values. Available options: Activated, Disposed, Depreciated, New, Preservation and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f973985f-3064-40de-b097-baed00bb8d5d' AND (Help IS NULL) AND EntityType='D';

-- A_Asset Actions (List)
UPDATE AD_Reference SET Description='Selection list for asset actions values', Help='The Asset Actions reference provides a dropdown selection with 7 predefined values. Available options: Dispose, Inbound, Modify, Outbound, Reevaluate and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4d85e435-2f2b-4b11-b080-6b71c7fc2acd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- A_Tip_Finantare (List)
UPDATE AD_Reference SET Help='The Tip_Finantare reference provides a dropdown selection with 3 predefined values. Available options: Cofinantare, Proprie, Terti.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4fa96274-d213-4780-85dd-8c5109c7e1bf' AND (Help IS NULL) AND EntityType='D';

-- A_Depreciation_Method (Table)
UPDATE AD_Reference SET Help='The Depreciation_Method reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b09cf99b-4e59-4062-916a-fdb5a3bbb49e' AND (Help IS NULL) AND EntityType='D';

-- M_MatchInv for Asset Addition (Table)
UPDATE AD_Reference SET Description='Table lookup for match inv for asset addition records', Help='The MatchInv for Asset Addition reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e4da3901-4a0f-409b-a84a-ec00d064d287' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- A_Activation_Method (List)
UPDATE AD_Reference SET Help='The Activation_Method reference provides a dropdown selection with 1 predefined values. Available options: Activation.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e792608b-74cb-456f-9fcd-4735b1860a59' AND (Help IS NULL) AND EntityType='D';

-- Yes-No-Unknown (List)
UPDATE AD_Reference SET Description='Selection list for yes-no-unknown values', Help='The Yes-No-Unknown reference provides a dropdown selection with 5 predefined values. Available options: No, - / Default No, -, - / Default Yes, Yes.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='559c5ec8-a55d-4145-ac12-8058aa9dfd93' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Period - all, acct, sysdate, desc (Table)
UPDATE AD_Reference SET Description='Table lookup for period - all, acct, sysdate, desc records', Help='The Period - all, acct, sysdate, desc reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a3ea7a5e-3270-48c7-8d62-fcbd8a6a0b74' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Payment (DataType)
UPDATE AD_Reference SET Help='The Payment reference payment Rule list and Process Payment button.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8959c366-e7f0-4893-8d23-edb1abe2db3f' AND (Help IS NULL) AND EntityType='D';

-- C_PaymentTransaction (Table)
UPDATE AD_Reference SET Description='Table lookup for payment transaction records', Help='The PaymentTransaction reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7fa2e8b3-8ba7-44fa-a532-3355610b28d4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_MatchPO (Table)
UPDATE AD_Reference SET Description='Table lookup for match po records', Help='The MatchPO reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9a238b56-6113-430b-969d-c72f023d059d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_MatchInv (Table)
UPDATE AD_Reference SET Description='Table lookup for match inv records', Help='The MatchInv reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a8cf3824-9f18-4d6b-802e-3412a8954a00' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_BroadcastMessage_Frequency (List)
UPDATE AD_Reference SET Help='The BroadcastMessage_Frequency reference provides a dropdown selection with 4 predefined values. Available options: Just Once, Until Expiration, Until Acknowledge, Until Expiration or Acknowledge.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d36f1fde-2e1f-43c9-b0cb-cd0f949831e3' AND (Help IS NULL) AND EntityType='D';

-- AD_BroadcastMessage_Type (List)
UPDATE AD_Reference SET Help='The BroadcastMessage_Type reference provides a dropdown selection with 3 predefined values. Available options: Immediate, Immediate + Login, Login.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='63a15ff5-2048-4fa3-a8ec-93e4d55d9078' AND (Help IS NULL) AND EntityType='D';

-- StorageProvider (List)
UPDATE AD_Reference SET Help='The StorageProvider reference provides a dropdown selection with 2 predefined values. Available options: File System, Database.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b4cb87d1-d08f-4987-8f66-9f923d68ec2f' AND (Help IS NULL) AND EntityType='D';

-- AD_StorageProvider_ID (Table)
UPDATE AD_Reference SET Help='The StorageProvider_ID reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2dc5386f-d9db-4758-a03e-e8695a286ff2' AND (Help IS NULL) AND EntityType='D';

-- DotHazardClassOrDivision (List)
UPDATE AD_Reference SET Description='Selection list for dot hazard class or division values', Help='The DotHazardClassOrDivision reference provides a dropdown selection with 18 predefined values. Available options: Class 1 - Explosives, Class 2 - Gases, 2.1 - Flammable Gas, 2.2 - Nonflammable Gas, Class 3 - Flammable Liquids and 13 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6e158773-206e-496e-be5b-8e29301b279b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- HomeDeliveryPremiumType (List)
UPDATE AD_Reference SET Description='Selection list for home delivery premium type values', Help='The HomeDeliveryPremiumType reference provides a dropdown selection with 3 predefined values. Available options: Appointment, Date Certain, Evening.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='84bb179a-3363-4bea-a48f-edad43fda37b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Package Notification Type (List)
UPDATE AD_Reference SET Description='Selection list for package notification type values', Help='The Package Notification Type reference provides a dropdown selection with 3 predefined values. Available options: Recipient, Recipient / Sender, Sender.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e68bb6db-ea5b-4276-a4ab-59f5d608c48d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Freight Charges (List)
UPDATE AD_Reference SET Description='Selection list for freight charges values', Help='The Freight Charges reference provides a dropdown selection with 5 predefined values. Available options: Collect, 3rd Party, Consignee, Prepaid, Prepaid and Bill.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5d9ef1b5-f817-44d8-a82f-aa49528d68c7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Insurance (List)
UPDATE AD_Reference SET Description='Selection list for insurance values', Help='The Insurance reference provides a dropdown selection with 2 predefined values. Available options: Insure, Do Not Insure.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1bfbd328-744b-4665-981f-b22d587608ef' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Freight Terms (List)
UPDATE AD_Reference SET Description='Selection list for freight terms values', Help='The Freight Terms reference provides a dropdown selection with 16 predefined values. Available options: FOB Origin, Ex Works, CFR - Cost and Freight, CPT - Carriage Paid To, DAF - Delivered at Frontier and 11 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9e3fbbfb-007c-4288-9b58-b7f90961c858' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- DeliveryConfirmationType (List)
UPDATE AD_Reference SET Description='Selection list for delivery confirmation type values', Help='The DeliveryConfirmationType reference provides a dropdown selection with 4 predefined values. Available options: Adult, Direct, Indirect, Service Default.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e24cd8a4-1136-49f8-92f7-d191ff8ea022' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Shipper (Table)
UPDATE AD_Reference SET Description='Table lookup for shipper records', Help='The Shipper reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f97d2731-e24a-49fe-b9fb-2ab31685b30d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_ShippingProcessor (Table)
UPDATE AD_Reference SET Description='Table lookup for shipping processor records', Help='The ShippingProcessor reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5efccbf1-5527-4d25-955f-7f39fb5df02b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_ShipperPackaging (Table)
UPDATE AD_Reference SET Description='Table lookup for shipper packaging records', Help='The ShipperPackaging reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='67f7b147-a794-4d46-9e61-775a863d9571' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_ShipperLabels (Table)
UPDATE AD_Reference SET Description='Table lookup for shipper labels records', Help='The ShipperLabels reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d5250e64-203c-47c7-a0d1-683807203228' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_ShipperPickupTypes (Table)
UPDATE AD_Reference SET Description='Table lookup for shipper pickup types records', Help='The ShipperPickupTypes reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='65e1b573-b255-4595-af65-ee936b2f284d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_ShippingTransaction Action (List)
UPDATE AD_Reference SET Description='Selection list for shipping transaction action values', Help='The ShippingTransaction Action reference provides a dropdown selection with 3 predefined values. Available options: Process Shipment, Void Shipment, Rate Inquiry.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b6d2bf98-0ad8-45f9-8566-af2fd6c289e1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- InfoQueryOperators (List)
UPDATE AD_Reference SET Help='The InfoQueryOperators reference provides a dropdown selection with 8 predefined values. Available options: Like, =, >, >=, < and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='70b95984-eab9-42f1-a9f1-24fd94265597' AND (Help IS NULL) AND EntityType='D';

-- AD_CtxHelp CtxType (List)
UPDATE AD_Reference SET Description='Selection list for ctx help ctx type values', Help='The CtxHelp CtxType reference provides a dropdown selection with 9 predefined values. Available options: Tab, Process, Form, Info, Workflow and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='67d6ad25-ce88-4a4a-a94a-ab8a4615ce2b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- ASU_1099Box (Table)
UPDATE AD_Reference SET Description='Table lookup for asu 1099box records', Help='The ASU_1099Box reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d2516191-26bf-4536-9a32-0a63bd08e44a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_DunningLevel (Table)
UPDATE AD_Reference SET Help='The DunningLevel reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d772aaa1-1037-4484-9ffe-d673c8e2aeab' AND (Help IS NULL) AND EntityType='D';

-- C_Dunning (Table)
UPDATE AD_Reference SET Help='The Dunning reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3f90eab3-5d21-4c29-a5f9-9e2dc93a418f' AND (Help IS NULL) AND EntityType='D';

-- C_BP_Group (Table)
UPDATE AD_Reference SET Help='The Business Partner Group reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7f53b2a2-bb9c-4ddf-8556-5d30b1a103ab' AND (Help IS NULL) AND EntityType='D';

-- C_InvoiceSchedule (Table)
UPDATE AD_Reference SET Help='The InvoiceSchedule reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='85abcdb6-e72e-45c7-97fe-c4770be528c3' AND (Help IS NULL) AND EntityType='D';

-- C_TaxGroup (Table)
UPDATE AD_Reference SET Help='The TaxGroup reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ac96c87b-b1fb-4c73-9512-a9d172e8a116' AND (Help IS NULL) AND EntityType='D';

-- M_Promotion (Table)
UPDATE AD_Reference SET Help='The Promotion reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d31122f7-de8b-4688-aaca-102ba0f8ebc6' AND (Help IS NULL) AND EntityType='D';

-- M_FreightCategory (Table)
UPDATE AD_Reference SET Help='The FreightCategory reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='cacc4255-d9e7-450d-97cc-dceb0108f689' AND (Help IS NULL) AND EntityType='D';

-- C_Tax Category (Table)
UPDATE AD_Reference SET Help='The Tax Category reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b5340b7c-ea56-47cd-99c5-423f638947af' AND (Help IS NULL) AND EntityType='D';

-- M_Attribute Set (Table)
UPDATE AD_Reference SET Help='The Attribute Set reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4844a94b-0a89-4551-9459-fea08f646521' AND (Help IS NULL) AND EntityType='D';

-- C_ProjectPhase (Table)
UPDATE AD_Reference SET Help='The ProjectPhase reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8a5911c5-df32-4f47-ab9b-4807ae5532aa' AND (Help IS NULL) AND EntityType='D';

-- C_ProjectTask (Table)
UPDATE AD_Reference SET Help='The ProjectTask reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d9f6273f-fcb3-4de1-ae1c-d3c24d2b2e8a' AND (Help IS NULL) AND EntityType='D';

-- C_Phase (Table)
UPDATE AD_Reference SET Help='The Phase reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='489e144e-8373-4cc4-a1b7-bd800c26d22d' AND (Help IS NULL) AND EntityType='D';

-- C_ProjectType (Table)
UPDATE AD_Reference SET Help='The ProjectType reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='56c619c5-42d0-4972-8e04-b2feb68de8ee' AND (Help IS NULL) AND EntityType='D';

-- C_ProjectIssue (Table)
UPDATE AD_Reference SET Help='The ProjectIssue reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='47557321-5968-4dc6-a5ef-3ec18d7891fc' AND (Help IS NULL) AND EntityType='D';

-- AD_Language NOT System/Base (Table)
UPDATE AD_Reference SET Help='The Language NOT System/Base reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ad7b3ed9-6c90-430e-937f-b42ecd6fe1b0' AND (Help IS NULL) AND EntityType='D';

-- C_Document Type SubTypeInv (List)
UPDATE AD_Reference SET Help='The Document Type SubTypeInv reference provides a dropdown selection with 3 predefined values. Available options: Physical Inventory, Internal Use Inventory, Cost Adjustment.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ec3ef1fd-81f7-4bf9-8cf8-1769edaf24dc' AND (Help IS NULL) AND EntityType='D';

-- WS Parameter Type (List)
UPDATE AD_Reference SET Description='Selection list for ws parameter type values', Help='The WS Parameter Type reference provides a dropdown selection with 2 predefined values. Available options: Free, Constant.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1b6497fd-bd10-4974-9877-09874cbe4885' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Database Data Type (List)
UPDATE AD_Reference SET Description='Selection list for database data type values', Help='The Database Data Type reference provides a dropdown selection with 8 predefined values. Available options: Binary LOB, Character Fixed, Decimal, Integer, Character LOB and 3 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='838bdb4e-d888-46f6-a611-cd4f5cedb31c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_ContactActivity Type (List)
UPDATE AD_Reference SET Help='The ContactActivity Type reference provides a dropdown selection with 4 predefined values. Available options: Email, Meeting, Phone call, Task.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f173d9b2-ea95-43cc-a13c-e715d49a0773' AND (Help IS NULL) AND EntityType='D';

-- C_SalesStage (Table)
UPDATE AD_Reference SET Description='Table lookup for sales stage records', Help='The SalesStage reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='05ba8075-6da6-4dee-8257-76be36e0bc8f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Lead Status (List)
UPDATE AD_Reference SET Description='Selection list for lead status values', Help='The Lead Status reference provides a dropdown selection with 5 predefined values. Available options: Converted, Expired, New, Recycled, Working.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2fe6e4ca-e2e0-4ed8-a314-39f6b333b01a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Foreign Key Constraint Type (List)
UPDATE AD_Reference SET Description='Selection list for foreign key constraint type values', Help='The Foreign Key Constraint Type reference provides a dropdown selection with 7 predefined values. Available options: Cascade, Set Null, Model Cascade, Do Not Create - Ignore, Model Set Null and 2 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f5f359ae-d6a9-43fa-a1c6-119ed6c1f201' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- ChartType (List)
UPDATE AD_Reference SET Help='The ChartType reference provides a dropdown selection with 12 predefined values. Available options: Ring Chart, 3D Pie Chart, Pie Chart, Waterfall Chart, 3D Line Chart and 7 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='33852dad-acf3-4b71-a5bc-a69da40ecaea' AND (Help IS NULL) AND EntityType='D';

-- TimeUnit (List)
UPDATE AD_Reference SET Help='The TimeUnit reference provides a dropdown selection with 5 predefined values. Available options: Year, Quarter, Month, Week, Day.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='012b34b7-f76e-451b-aabd-864ec16222cd' AND (Help IS NULL) AND EntityType='D';

-- TreeDisplayedOn (List)
UPDATE AD_Reference SET Description='Selection list for tree displayed on values', Help='The TreeDisplayedOn reference provides a dropdown selection with 3 predefined values. Available options: Both, Detail Tab, Master Tab.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='859b6bbe-8381-44d4-b3f6-374c17be1b53' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_RelatedInfo Window (Table)
UPDATE AD_Reference SET Description='Table lookup for related info window records', Help='The RelatedInfo Window reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='84852b3d-373d-4d0c-9147-7be7923e93e4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_LinkInfowindow (Table)
UPDATE AD_Reference SET Description='Table lookup for link infowindow records', Help='The LinkInfowindow reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='584ab9bd-2a90-4d98-bc6b-fdff8c346a3e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Product BOM Product TypeX (List)
UPDATE AD_Reference SET Help='The Product BOM Product TypeX reference provides a dropdown selection with 11 predefined values. Available options: In alternative Group 5, In alternative Group 6, In alternative Group 8, In alternative Group 9, Standard Part and 6 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='17e35fb6-a6c3-4073-89ae-b50cc9f7c619' AND (Help IS NULL) AND EntityType='D';

-- M_Production (Table)
UPDATE AD_Reference SET Description='Table lookup for production records', Help='The Production reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='25b245ad-6b82-42c5-a1dd-bea8fb43556b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_InfoProcess LayoutType (List)
UPDATE AD_Reference SET Help='The InfoProcess LayoutType reference provides a dropdown selection with 3 predefined values. Available options: Button, Menu, List.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2171ebd2-e11a-4612-9885-128f155d65e8' AND (Help IS NULL) AND EntityType='D';

-- ParentPreferenceType (List)
UPDATE AD_Reference SET Help='The ParentPreferenceType reference provides a dropdown selection with 4 predefined values. Available options: Window, Process, Info Window, Form.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8412d243-d7da-4064-8784-db1cca37c95e' AND (Help IS NULL) AND EntityType='D';

-- Country Group (Table)
UPDATE AD_Reference SET Description='Table lookup for country group records', Help='The Country Group reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='735c864d-d595-4a2c-8b66-48ae13b42fb5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Mode (List)
UPDATE AD_Reference SET Description='Selection list for import mode values', Help='The Import Mode reference provides a dropdown selection with 3 predefined values. Available options: Insert, Update, Merge.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3892e140-7f08-4f89-a510-493e0f7cb775' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Element Value Account Business Partner Type (List)
UPDATE AD_Reference SET Description='Selection list for element value account business partner type values', Help='The Element Value Account Business Partner Type reference provides a dropdown selection with 3 predefined values. Available options: Customer, Vendor, Employee.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7688770d-a2dd-428b-ac28-efcd8fe24785' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- IsToolbarButton (List)
UPDATE AD_Reference SET Description='Selection list for is toolbar button values', Help='The IsToolbarButton reference provides a dropdown selection with 3 predefined values. Available options: Toolbar, Window, Both.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d90d1cd0-4cf1-41e0-84cb-53600a366a22' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Style (Table)
UPDATE AD_Reference SET Help='The Style reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b305070d-fe5b-4f1f-be86-e247b03b5723' AND (Help IS NULL) AND EntityType='D';

-- Dashboard Content (DataType)
UPDATE AD_Reference SET Help='The Dashboard Content reference dashboard Content.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='eddd31af-5ab7-4b88-967f-4fe7b7e091ea' AND (Help IS NULL) AND EntityType='D';

-- Single Selection Grid (DataType)
UPDATE AD_Reference SET Description='Data type definition for single selection grid', Help='The Single Selection Grid reference data type definition for single selection grid.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ce2bb5f1-efab-44ba-b5b7-7308a509c39c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Multiple Selection Grid (DataType)
UPDATE AD_Reference SET Description='Data type definition for multiple selection grid', Help='The Multiple Selection Grid reference data type definition for multiple selection grid.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ca6d9bef-47eb-4278-a11f-20a8a99257cd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- FieldSuggestionTargetList (List)
UPDATE AD_Reference SET Description='Selection list for field suggestion target list values', Help='The FieldSuggestionTargetList reference provides a dropdown selection with 2 predefined values. Available options: Element, Field.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5038c525-51b5-465e-8464-839bf9ef50fe' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Process Execution Type (List)
UPDATE AD_Reference SET Help='The Process Execution Type reference provides a dropdown selection with 2 predefined values. Available options: Force Background, Force Foreground.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1acef8a3-44b6-49c1-9309-d848829e3898' AND (Help IS NULL) AND EntityType='D';

-- AD_Process Multiple Execution (List)
UPDATE AD_Reference SET Help='The Process Multiple Execution reference provides a dropdown selection with 5 predefined values. Available options: Not from same user, Not from any user, Not from same user and parameters, Not from any user and same parameters, Yes.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='e08cde11-cfd5-45e8-9813-0e3005269c97' AND (Help IS NULL) AND EntityType='D';

-- AD_Table with ID Column (Table)
UPDATE AD_Reference SET Description='Table lookup for table with id column records', Help='The Table with ID Column reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5fc414bf-781e-4171-a543-6aa057de1a58' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Role RoleType (List)
UPDATE AD_Reference SET Description='Selection list for role role type values', Help='The Role RoleType reference provides a dropdown selection with 10 predefined values. Available options: WebUI, WebService, System Support, Mobile, Swing and 5 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='88b0c074-0f6f-4a8b-b76e-e230e340f670' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Activate/Deactivate/Delete (List)
UPDATE AD_Reference SET Description='Selection list for activate/deactivate/delete values', Help='The Activate/Deactivate/Delete reference provides a dropdown selection with 3 predefined values. Available options: Delete, Deactivate, Activate.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='4fa8918c-0b18-40b6-a133-f7847d5d3404' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- ReportOutputType (List)
UPDATE AD_Reference SET Description='Selection list for report output type values', Help='The ReportOutputType reference provides a dropdown selection with 5 predefined values. Available options: PDF, HTML, CSV, XLS, XLSX.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b6fc4bb2-ce72-4de3-b753-302da5fd1173' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- RelType C_Invoice -> C_Invoice (CM) (Table)
UPDATE AD_Reference SET Description='Table lookup for rel type c invoice -> c invoice (cm) records', Help='The RelType C_Invoice -> C_Invoice (CM) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0c256942-4836-4cef-9fb1-e5bb4554aa00' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Chosen Multiple Selection List (DataType)
UPDATE AD_Reference SET Help='The Chosen Multiple Selection List reference chosen multiple selection box for reference list.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fa2c2787-e93f-42be-a5d1-7a12f6b30b72' AND (Help IS NULL) AND EntityType='D';

-- Chosen Multiple Selection Table (DataType)
UPDATE AD_Reference SET Help='The Chosen Multiple Selection Table reference chosen multiple selection box for table list.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='07d7bf33-8998-4538-920d-5c0e0b2d46d2' AND (Help IS NULL) AND EntityType='D';

-- Chosen Multiple Selection Search (DataType)
UPDATE AD_Reference SET Help='The Chosen Multiple Selection Search reference chosen multiple selection box for search.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='563a482c-4f06-448d-bb7f-e109d33cead9' AND (Help IS NULL) AND EntityType='D';

-- ViewFindResult (List)
UPDATE AD_Reference SET Description='Selection list for view find result values', Help='The ViewFindResult reference provides a dropdown selection with 3 predefined values. Available options: Default, Always in Grid View, According to threshold.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='718b69d3-4b62-4d7d-a137-470e4e272052' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Scheduler State (DataType)
UPDATE AD_Reference SET Help='The Scheduler State reference view and change the state of a scheduler.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6b31c7a3-12ee-40d6-ae12-e5d16dc854b4' AND (Help IS NULL) AND EntityType='D';

-- Attribute Set Type (List)
UPDATE AD_Reference SET Description='Selection list for attribute set type values', Help='The Attribute Set Type reference provides a dropdown selection with 1 predefined values. Available options: Material Management System.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='dc52c0cb-adec-4c9e-a176-29ca09f0072e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Radio Group List (DataType)
UPDATE AD_Reference SET Description='Data type definition for radio group list', Help='The Radio Group List reference data type definition for radio group list.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bde88a42-3601-499e-a2ee-2185eb6fc785' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- PA_ReportLine Line Stroke Type (List)
UPDATE AD_Reference SET Description='Selection list for report line line stroke type values', Help='The Performance ReportLine Line Stroke Type reference provides a dropdown selection with 6 predefined values. Available options: Dotted, Dashed, Double Dotted, Double Dashed, Double Solid and 1 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a66f38f4-feeb-472f-a561-0f2134214e66' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Business Partner (all) (Table)
UPDATE AD_Reference SET Description='Table lookup for business partner (all) records', Help='The Business Partner (all) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9464f6b3-d548-48c9-aaad-0c4ea9b5afd7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_Product (all) (Table)
UPDATE AD_Reference SET Description='Table lookup for product (all) records', Help='The Product (all) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='79ad8bb4-64c7-42d7-993e-853a2c99ea76' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- ImportOrExport (List)
UPDATE AD_Reference SET Description='Selection list for import or export values', Help='The ImportOrExport reference provides a dropdown selection with 2 predefined values. Available options: Import, Export.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2d291969-c2a8-401d-b9ed-1d6f23539f04' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Table Trl (Table)
UPDATE AD_Reference SET Help='The Table Trl reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='78da012b-514b-45e0-b253-84510b08cd32' AND (Help IS NULL) AND EntityType='D';

-- M_Attribute SetInstance (Table)
UPDATE AD_Reference SET Help='The Attribute SetInstance reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b5bbd62d-3952-41a0-a24a-552917766c57' AND (Help IS NULL) AND EntityType='D';

-- S_ResourceAssignment (Table)
UPDATE AD_Reference SET Help='The Service ResourceAssignment reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0fbb9b88-bec0-437e-baff-b5fc8d98f5e0' AND (Help IS NULL) AND EntityType='D';

-- AD_Image (Table)
UPDATE AD_Reference SET Help='The Image reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3c7cb70b-e7e0-47e6-a21b-da42a725e5d5' AND (Help IS NULL) AND EntityType='D';

-- AD_Chart (Table)
UPDATE AD_Reference SET Help='The Chart reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='19401d65-0125-41ab-a79d-6a149aa4d670' AND (Help IS NULL) AND EntityType='D';

-- AD_AuthorizationType (List)
UPDATE AD_Reference SET Description='Selection list for authorization type values', Help='The AuthorizationType reference provides a dropdown selection with 2 predefined values. Available options: OAuth2, SAML (not implemented yet).', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='841014f1-0242-4556-8506-3cd0678846e6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_AuthorizationScope (List)
UPDATE AD_Reference SET Description='Selection list for authorization scope values', Help='The AuthorizationScope reference provides a dropdown selection with 5 predefined values. Available options: Calendar, EMail, Document, Profile, Storage.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f91205eb-6b17-4e76-bbdd-0114f7492f44' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MFA_Method (List)
UPDATE AD_Reference SET Description='Selection list for mfa method values', Help='The MFA_Method reference provides a dropdown selection with 2 predefined values. Available options: Time-Based One-Time Password, EMail.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6d3d1f40-0e38-4adf-93d6-b1bb2c44e93c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MFAType (List)
UPDATE AD_Reference SET Description='Selection list for mfa type values', Help='The MFAType reference provides a dropdown selection with 4 predefined values. Available options: Something you Know, Something you Have, Something you Are (Biometrics), Location.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c1fc1d9c-6b42-45e9-a9d1-67aa9a8e77f1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MFATimeProvider (List)
UPDATE AD_Reference SET Description='Selection list for mfa time provider values', Help='The MFATimeProvider reference provides a dropdown selection with 2 predefined values. Available options: System, Ntp.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='0c6758f4-b113-4ebc-91e9-0de6c565c139' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Element (Table)
UPDATE AD_Reference SET Description='Table lookup for element records', Help='The Element reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3a119c73-263b-4f8b-b45c-33d25562a1d2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- FinReport ExcludeAdjustmentPeriods (List)
UPDATE AD_Reference SET Description='Selection list for fin report exclude adjustment periods values', Help='The FinReport ExcludeAdjustmentPeriods reference provides a dropdown selection with 3 predefined values. Available options: No, Only Report Period, All Adjustment Periods.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9a34172f-5f27-4819-84cc-7de43853e8c8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- TabTypeList (List)
UPDATE AD_Reference SET Help='The TabTypeList reference provides a dropdown selection with 2 predefined values. Available options: Form, Sort.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='5cc837cc-e950-4a01-8044-4aa6a69d9515' AND (Help IS NULL) AND EntityType='D';

-- AD_Tree_Favorite_Node list (Table)
UPDATE AD_Reference SET Description='Table lookup for tree favorite node list records', Help='The Tree_Favorite_Node list reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='47f185a4-37d5-426e-b386-8fabc0f0f49d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- HTML Attachment Type List (List)
UPDATE AD_Reference SET Description='Selection list for html attachment type list values', Help='The HTML Attachment Type List reference provides a dropdown selection with 2 predefined values. Available options: HTML as Attachment, Parse Images to Attachments.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d907e9e1-f51c-4d32-ac85-287be286962e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Role RoleType - WebService (Table)
UPDATE AD_Reference SET Help='The Role RoleType - WebService reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='aa03ad0d-015b-4c27-a83e-044aa156dbb1' AND (Help IS NULL) AND EntityType='D';

-- Account_ID (Trx) (Table)
UPDATE AD_Reference SET Help='The Account_ID (Trx) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='1613e828-76e5-4e34-b75f-b70572998ab8' AND (Help IS NULL) AND EntityType='D';

-- Account_ID (Table)
UPDATE AD_Reference SET Help='The Account_ID reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c93629b6-9b0c-4c2d-9406-f84c98f17882' AND (Help IS NULL) AND EntityType='D';

-- Account_ID - User1 (Table)
UPDATE AD_Reference SET Help='The Account_ID - User1 reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7824f4a7-e4f3-442e-bd61-ae22bf3dd6cd' AND (Help IS NULL) AND EntityType='D';

-- Account_ID - User2 (Table)
UPDATE AD_Reference SET Help='The Account_ID - User2 reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2d83bba0-2de0-4c94-bde1-a9921f1cd8fa' AND (Help IS NULL) AND EntityType='D';

-- AD_Client (Table)
UPDATE AD_Reference SET Help='The Client reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='13cf40c3-6430-44dd-b63a-39c2c7d5849a' AND (Help IS NULL) AND EntityType='D';

-- MFA_Method - on tenant rule (Table)
UPDATE AD_Reference SET Description='Table lookup for mfa method - on tenant rule records', Help='The MFA_Method - on tenant rule reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='ab76ace8-d950-46d5-a262-d2de59f39d6e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- M_WarehouseTo of Tenant (Table)
UPDATE AD_Reference SET Description='Table lookup for warehouse to of tenant records', Help='The WarehouseTo of Tenant reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='aaf2b0dd-b8a8-4888-a808-2238c280c1aa' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_User Users from all Tenants (Table)
UPDATE AD_Reference SET Help='The User Users from all Tenants reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='cabfba5a-23ab-450c-bacf-ebcda08039ae' AND (Help IS NULL) AND EntityType='D';

-- AD_BroadcastMessage_Target (List)
UPDATE AD_Reference SET Help='The BroadcastMessage_Target reference provides a dropdown selection with 4 predefined values. Available options: Everybody, Role, User, Client.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='301456b6-04c6-410d-acd1-e03203e25339' AND (Help IS NULL) AND EntityType='D';

-- M_Price List_Version for Tenant (Table)
UPDATE AD_Reference SET Description='Table lookup for price list version for tenant records', Help='The Price List_Version for Tenant reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='d6b12b69-1e17-422f-929b-336d141e5cb6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Client All Tenants (Table)
UPDATE AD_Reference SET Help='The Client All Tenants reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='af992906-5d2e-4e4f-8cf4-01689ffa190f' AND (Help IS NULL) AND EntityType='D';

-- Timestamp With Time Zone (DataType)
UPDATE AD_Reference SET Help='The Timestamp With Time Zone reference date and time with time zone.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a4c9a3f1-ecbb-4beb-ac16-d1b66279f698' AND (Help IS NULL) AND EntityType='D';

-- Time Zone (DataType)
UPDATE AD_Reference SET Help='The Time Zone reference time Zone.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9420d498-a217-4c35-a638-b6fcf462538e' AND (Help IS NULL) AND EntityType='D';

-- C_Tax Posting Indicator (List)
UPDATE AD_Reference SET Description='Selection list for tax posting indicator values', Help='The Tax Posting Indicator reference provides a dropdown selection with 2 predefined values. Available options: Separate Tax Posting, Distribute Tax with Relevant Expense.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='429065e5-80c4-458e-a7ae-d20761dcb5a8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_Document Type S.Order + RMA (Table)
UPDATE AD_Reference SET Description='Table lookup for document type s.order + rma records', Help='The Document Type S.Order + RMA reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='fddc29fc-46cf-4b27-935c-7909f05501b7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- DocSource Generate Shipments/Invoices (manual) (List)
UPDATE AD_Reference SET Description='Selection list for doc source generate shipments/invoices (manual) values', Help='The DocSource Generate Shipments/Invoices (manual) reference provides a dropdown selection with 2 predefined values. Available options: Order, RMA.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3be7b948-8b9e-490c-849c-df25ea642a23' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- DateSelectionMode (List)
UPDATE AD_Reference SET Help='The DateSelectionMode reference provides a dropdown selection with 9 predefined values. Available options: Previous, Next, Current, Between, On and 4 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c7a6eae8-e3af-4072-aced-cdd10a18f8da' AND (Help IS NULL) AND EntityType='D';

-- Months (List)
UPDATE AD_Reference SET Description='Selection list for months values', Help='The Months reference provides a dropdown selection with 12 predefined values. Available options: January, February, March, April, May and 7 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='bbabc9d6-241d-4cb9-b5b5-2b02e37abdf1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Quarters (List)
UPDATE AD_Reference SET Description='Selection list for quarters values', Help='The Quarters reference provides a dropdown selection with 4 predefined values. Available options: First Quarter, Second Quarter, Third Quarter, Fourth Quarter.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c045f9d5-379c-490f-b96d-920c5ac59d50' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- S_ResourceType (Table)
UPDATE AD_Reference SET Help='The Service ResourceType reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f7d402bd-d4e2-404e-ac59-30ee64057f7a' AND (Help IS NULL) AND EntityType='D';

-- Record ID (DataType)
UPDATE AD_Reference SET Description='Data type definition for record id', Help='The Record ID reference data type definition for record id.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='55330dab-f2b6-499d-af8b-187848c47a40' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Print FormatItemSync Source (List)
UPDATE AD_Reference SET Description='Selection list for print format item sync source values', Help='The Print FormatItemSync Source reference provides a dropdown selection with 2 predefined values. Available options: Table, Report View Column.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='85f03455-8e85-4a2c-bfd8-34e71ff29458' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Date Range Option (List)
UPDATE AD_Reference SET Help='The Date Range Option reference provides a dropdown selection with 2 predefined values. Available options: Date Editor and Range Picker, Text and Range Picker.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='299b9200-3e9e-4923-8c32-5273dd17e7b4' AND (Help IS NULL) AND EntityType='D';

-- AD_Reference Show Inactive (List)
UPDATE AD_Reference SET Description='Selection list for reference show inactive values', Help='The Reference Show Inactive reference provides a dropdown selection with 2 predefined values. Available options: No, Yes.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='998ea62f-47e7-433e-9293-d49324d16c10' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_Table Name (Table)
UPDATE AD_Reference SET Description='Table lookup for table name records', Help='The Table Name reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c8dfa020-36ce-47c8-b273-6c9ad5053def' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- SSO Provider List (List)
UPDATE AD_Reference SET Description='Selection list for sso provider list values', Help='The SSO Provider List reference provides a dropdown selection with 1 predefined values. Available options: OpenID Connect.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f12db9ec-7c5c-46a7-a2ba-d01b4043dae2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- UUID (DataType)
UPDATE AD_Reference SET Help='The UUID reference universally unique identifier.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2dbf9d9e-3e83-4927-b737-c1124918402c' AND (Help IS NULL) AND EntityType='D';

-- Table (UU) (DataType)
UPDATE AD_Reference SET Help='The Table (UU) reference table List based on UUID.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7a610848-25e3-4f38-ad47-5e79daf132fd' AND (Help IS NULL) AND EntityType='D';

-- Table Direct (UU) (DataType)
UPDATE AD_Reference SET Help='The Table Direct (UU) reference direct Table Access based on UUID.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='52a4c2d4-3afb-47ef-b57c-8c9fc88bedff' AND (Help IS NULL) AND EntityType='D';

-- AD_Table with ID or UU Column (Table)
UPDATE AD_Reference SET Description='Table lookup for table with id or uu column records', Help='The Table with ID or UU Column reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='23255e3a-0bf4-43f9-afdf-419ab47e21ff' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Test UU (Table)
UPDATE AD_Reference SET Description='Table lookup for test uu records', Help='The Test UU reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='3eaddbd9-67d0-4e16-ae0b-4a6acee3a1e6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Authentication Type List (List)
UPDATE AD_Reference SET Description='Selection list for authentication type list values', Help='The Authentication Type List reference provides a dropdown selection with 3 predefined values. Available options: SSO Only, Application Only, Application and SSO.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='8bf2b11e-71f7-4b40-b4fb-4b6dfd7d767e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Search (UU) (DataType)
UPDATE AD_Reference SET Help='The Search (UU) reference search Field based on UUID.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='f741f1a8-bc99-48cc-80a8-0c5d3bf85dbb' AND (Help IS NULL) AND EntityType='D';

-- Record UUID (DataType)
UPDATE AD_Reference SET Description='Data type definition for record uuid', Help='The Record UUID reference data type definition for record uuid.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='9bab064f-725d-4fc2-bdab-3ea690905549' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- GL_Category (all) (Table)
UPDATE AD_Reference SET Description='Table lookup for category (all) records', Help='The General Ledger Category (all) reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='2f47a672-6fc4-4298-8026-ab34ee5e37e3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_PInstance_Log PInstanceLogType (List)
UPDATE AD_Reference SET Description='Selection list for p instance log p instance log type values', Help='The PInstance_Log PInstanceLogType reference provides a dropdown selection with 3 predefined values. Available options: Status, Result, Progress.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='6a5f9e08-d4c5-4724-a9dc-8e981e734eaa' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- C_UOM Weight Type (Table)
UPDATE AD_Reference SET Help='The UOM Weight Type reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='c78a88bb-cb9a-4846-8f61-3eb790f08b51' AND (Help IS NULL) AND EntityType='D';

-- C_UOM Length Type (Table)
UPDATE AD_Reference SET Help='The UOM Length Type reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='a9996de5-c232-4304-b081-3c4620350bb2' AND (Help IS NULL) AND EntityType='D';

-- AD_Column PartitioningMethod (List)
UPDATE AD_Reference SET Description='Selection list for column partitioning method values', Help='The Column PartitioningMethod reference provides a dropdown selection with 2 predefined values. Available options: Range, List.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='81b6431b-0afa-49bc-b5fe-be9a7b2481cf' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- AD_TablePartition (Table)
UPDATE AD_Reference SET Help='The TablePartition reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='71d7e81f-de03-4329-86d4-41c0f07fa488' AND (Help IS NULL) AND EntityType='D';

-- JSON (DataType)
UPDATE AD_Reference SET Help='The JSON reference jSON format values.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='b6fcc751-edd8-4421-acd0-3cde02a9576d' AND (Help IS NULL) AND EntityType='D';

-- ImportTemplateType (List)
UPDATE AD_Reference SET Description='Selection list for import template type values', Help='The ImportTemplateType reference provides a dropdown selection with 3 predefined values. Available options: Comma-separated values (CSV), Excel (XLS/XLSX), XLS.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='7926c8b4-2e48-4dd3-9054-8e26245c8128' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- _TransferType (List)
UPDATE AD_Reference SET Help='The _TransferType reference provides a dropdown selection with 2 predefined values. Available options: Bank Account, Cash Book.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='62a3c71c-33ff-4e70-9cf5-a523a6bfad23' AND (Help IS NULL) AND EntityType='D';

-- C_Business Partner Vendors Active (Table)
UPDATE AD_Reference SET Help='The Business Partner Vendors Active reference retrieves values from a database table for dynamic selection.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='49f42a73-ee49-4a7e-9fad-88bbf8c6ae87' AND (Help IS NULL) AND EntityType='D';

-- Image URL (DataType)
UPDATE AD_Reference SET Help='The Image URL reference web URL of an image.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='27a6d876-b451-4fdb-ae4b-584ef6022838' AND (Help IS NULL) AND EntityType='D';

-- M_Transaction Movement Type (List)
UPDATE AD_Reference SET Description='Selection list for transaction movement type values', Help='The Transaction Movement Type reference provides a dropdown selection with 12 predefined values. Available options: Production -, Customer Shipment, Customer Returns, Vendor Returns, Inventory Out and 7 more.', Updated=NOW(), UpdatedBy=100 WHERE AD_Reference_UU='195f0059-6433-4e52-8b24-6c1232a8b3f9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

