-- AD_Tab descriptions
-- Tabs: 512

SELECT register_migration_script('202511301204_IDEMPIERE-6779-Tab-Descriptions.sql') FROM dual;

-- =============================================
-- AD_Tab (512 records)
-- =============================================

-- Address Validation (Address Validation Configuration)
UPDATE AD_Tab SET Description='Primary data entry for address validation records', Help='Use this tab to create and modify the core address validation attributes. This serves as the main entry point for this record type. Accessed through the Address Validation Configuration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ed765b32-b284-4052-9179-45246f613eea' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Address Validation (Address Validation)
UPDATE AD_Tab SET Description='Primary data entry for address validation records', Help='Use this tab to create and modify the core address validation attributes. This serves as the main entry point for this record type. Accessed through the Address Validation window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1014db9b-eb91-4776-b376-2db648f326d3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Address Transaction (Address Transaction)
UPDATE AD_Tab SET Description='Primary data entry for address transaction records', Help='Use this tab to create and modify the core address transaction attributes. This serves as the main entry point for this record type. Accessed through the Address Transaction window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='99d6131c-09f2-4c56-833f-c29433651b6c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Activity (Contact)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated activity details. Records on this tab are linked to the parent entry above. Accessed through the Contact window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6233b828-7d6b-4c8d-acc6-6d338cb5c731' AND (Help IS NULL) AND EntityType='D';

-- Opportunity (Sales Opportunity)
UPDATE AD_Tab SET Description='Primary data entry for opportunity records', Help='Use this tab to create and modify the core opportunity attributes. This serves as the main entry point for this record type. Accessed through the Sales Opportunity window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cca4f91d-a76d-4edb-990b-23a1e88d8f99' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Activity (Sales Opportunity)
UPDATE AD_Tab SET Description='Related activity entries for this sales opportunity', Help='Navigate here to view and edit associated activity details. Records on this tab are linked to the parent entry above. Accessed through the Sales Opportunity window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4103949a-8c89-40dd-bc5a-dcadd952486a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Field group (Field Group)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core field group attributes. This serves as the main entry point for this record type. Accessed through the Field Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6b92c375-8e88-44ac-9271-3bc23c24a542' AND (Help IS NULL) AND EntityType='D';

-- Opportunity (Marketing Campaign)
UPDATE AD_Tab SET Description='Related opportunity entries for this marketing campaign', Help='Navigate here to view and edit associated opportunity details. Records on this tab are linked to the parent entry above. Accessed through the Marketing Campaign window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ce3ffd9c-c74f-4342-8321-1eb6b6495336' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Cash Plan (Cash Plan)
UPDATE AD_Tab SET Description='Primary data entry for cash plan records', Help='Use this tab to create and modify the core cash plan attributes. This serves as the main entry point for this record type. Accessed through the Cash Plan window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3f592bb1-1040-4b02-833b-2ceab223d27d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Graph (Print Format)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated graph details. Records on this tab are linked to the parent entry above. Accessed through the Print Format window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9119d27f-7cfe-4b19-b360-3c5f49cf8f88' AND (Help IS NULL) AND EntityType='D';

-- Opportunities (Sales Rep Dashboard)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated opportunities details. Records on this tab are linked to the parent entry above. Accessed through the Sales Rep Dashboard window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c1dfa82b-3531-4853-a152-fd795e45b1fb' AND (Help IS NULL) AND EntityType='D';

-- Activity (Lead)
UPDATE AD_Tab SET Description='Related activity entries for this lead', Help='Navigate here to view and edit associated activity details. Records on this tab are linked to the parent entry above. Accessed through the Lead window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1ce83570-7885-42db-8343-1c3efafff63b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Sales Stage (Sales Stage)
UPDATE AD_Tab SET Description='Primary data entry for sales stage records', Help='Use this tab to create and modify the core sales stage attributes. This serves as the main entry point for this record type. Accessed through the Sales Stage window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a3f48ae8-9bba-4ec0-9123-60bcaf00d395' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Opportunity (Sales Stage)
UPDATE AD_Tab SET Description='Related opportunity entries for this sales stage', Help='Navigate here to view and edit associated opportunity details. Records on this tab are linked to the parent entry above. Accessed through the Sales Stage window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7fca7ebd-fc8d-45c3-9dde-b44f315bfc3c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Processor (Alert Processor)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core processor attributes. This serves as the main entry point for this record type. Accessed through the Alert Processor window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d4e8dd52-d8af-4f68-b47b-6563cf071d0e' AND (Help IS NULL) AND EntityType='D';

-- Window Translation (Info Window)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated window translation details. Records on this tab are linked to the parent entry above. Accessed through the Info Window window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='910282ac-7790-40f2-93ad-4a910175cf07' AND (Help IS NULL) AND EntityType='D';

-- Translation (Message)
UPDATE AD_Tab SET Description='Related translation entries for this message', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Message window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c65e0ea3-bdb6-4c01-bea0-2dd7393c773a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Parameter Translation (Report and Process)
UPDATE AD_Tab SET Description='Related parameter translation entries for this report and process', Help='Navigate here to view and edit associated parameter translation details. Records on this tab are linked to the parent entry above. Accessed through the Report and Process window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6e78530e-02db-4494-a792-597d512e4f41' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Opportunities (Customer)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated opportunities details. Records on this tab are linked to the parent entry above. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4b275ea9-ebca-4f6d-81aa-19a9b20b0cf9' AND (Help IS NULL) AND EntityType='D';

-- Contacts (Customer)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated contacts details. Records on this tab are linked to the parent entry above. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='721a1265-17c7-4ba1-9d7b-2c1510e1f4e5' AND (Help IS NULL) AND EntityType='D';

-- Customer (Customer)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core customer attributes. This serves as the main entry point for this record type. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='66038811-fcf7-4239-96cd-fa60b4b09fff' AND (Help IS NULL) AND EntityType='D';

-- Order Line (Sales Opportunity)
UPDATE AD_Tab SET Description='Related order line entries for this sales opportunity', Help='Navigate here to view and edit associated order line details. Records on this tab are linked to the parent entry above. Accessed through the Sales Opportunity window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='925aac7c-fede-4a7c-8034-e63c468376bf' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Activities (Customer)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated activities details. Records on this tab are linked to the parent entry above. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6d4c0f37-2ae3-4e85-8c1a-7881bec199fe' AND (Help IS NULL) AND EntityType='D';

-- Locations (Customer)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated locations details. Records on this tab are linked to the parent entry above. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ce0b7902-8634-4d33-84f7-e9e3be024bdd' AND (Help IS NULL) AND EntityType='D';

-- Contract Prices (Customer)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated contract prices details. Records on this tab are linked to the parent entry above. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='dbe1eb2c-570e-467b-abb8-df309579bb31' AND (Help IS NULL) AND EntityType='D';

-- Requests (Customer)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated requests details. Records on this tab are linked to the parent entry above. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7f472571-5688-4f30-bb42-5e36ed2e4c3a' AND (Help IS NULL) AND EntityType='D';

-- Orders (Customer)
UPDATE AD_Tab SET Description='Related orders entries for this customer', Help='Navigate here to view and edit associated orders details. Records on this tab are linked to the parent entry above. Accessed through the Customer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e5e2a83a-559c-40e3-9235-633f5ad09cc1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Perpetual Inventory (Perpetual Inventory)
UPDATE AD_Tab SET Description='Primary data entry for perpetual inventory records', Help='Use this tab to create and modify the core perpetual inventory attributes. This serves as the main entry point for this record type. Accessed through the Perpetual Inventory window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4383dc77-3b3a-4422-be70-0a24f2e9ebb7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Activities (Sales Rep Dashboard)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated activities details. Records on this tab are linked to the parent entry above. Accessed through the Sales Rep Dashboard window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='15928938-e346-4ce7-96fe-2aefa226c12b' AND (Help IS NULL) AND EntityType='D';

-- Quote/Order (Sales Opportunity)
UPDATE AD_Tab SET Description='Related quote/order entries for this sales opportunity', Help='Navigate here to view and edit associated quote/order details. Records on this tab are linked to the parent entry above. Accessed through the Sales Opportunity window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c5312bd1-bcf8-41c7-b1bf-270ae3e2aef0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Leads (Sales Rep Dashboard)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated leads details. Records on this tab are linked to the parent entry above. Accessed through the Sales Rep Dashboard window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='830292f3-0722-4a79-95ea-1d68cc9fc493' AND (Help IS NULL) AND EntityType='D';

-- Dashboard (Sales Rep Dashboard)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core dashboard attributes. This serves as the main entry point for this record type. Accessed through the Sales Rep Dashboard window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d56d2b8a-7482-4c34-8413-a1a99edcdeca' AND (Help IS NULL) AND EntityType='D';

-- Image (System Image)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core image attributes. This serves as the main entry point for this record type. Accessed through the System Image window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4cc24df5-daff-4ea0-a9d7-1c22a00c49a1' AND (Help IS NULL) AND EntityType='D';

-- Contact (Contact)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core contact attributes. This serves as the main entry point for this record type. Accessed through the Contact window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='953636c2-a80f-4a67-a698-eb4e0fbcd07e' AND (Help IS NULL) AND EntityType='D';

-- System Color (System Color)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core system color attributes. This serves as the main entry point for this record type. Accessed through the System Color window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='29abe0d5-793e-403a-9cbd-3da02cdebf3f' AND (Help IS NULL) AND EntityType='D';

-- Translation (Desktop)
UPDATE AD_Tab SET Description='Related translation entries for this desktop', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Desktop window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7bdc5cad-b0e7-4c82-a948-7fed5bfa5b14' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tab Translation (Window, Tab and Field)
UPDATE AD_Tab SET Description='Related tab translation entries for this window, tab and field', Help='Navigate here to view and edit associated tab translation details. Records on this tab are linked to the parent entry above. Accessed through the Window, Tab and Field window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='72cff5e1-1281-449b-843a-226d92e867d7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Expense Product (Expense Type)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated expense product details. Records on this tab are linked to the parent entry above. Accessed through the Expense Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6d56150c-0dee-438e-b9bf-e6d699a65113' AND (Help IS NULL) AND EntityType='D';

-- Test (Test)
UPDATE AD_Tab SET Description='Primary data entry for test records', Help='Use this tab to create and modify the core test attributes. This serves as the main entry point for this record type. Accessed through the Test window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='de1df35e-0e4a-47ab-8dca-dafa56c2fe8b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Product Transactions (Warehouse and Locators)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated product transactions details. Records on this tab are linked to the parent entry above. Accessed through the Warehouse and Locators window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bb99a661-f89e-482f-9133-58203714bcfc' AND (Help IS NULL) AND EntityType='D';

-- Translation (Payment Term)
UPDATE AD_Tab SET Description='Related translation entries for this payment term', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Payment Term window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0e9faa16-c9bd-4392-ab21-305ff2263add' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Product)
UPDATE AD_Tab SET Description='Related translation entries for this product', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Product window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f92d90a5-c6e2-41f9-840b-6f465a217047' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Unit of Measure)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Unit of Measure window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2f663c55-b1a5-456b-b696-336bf5d8b240' AND (Help IS NULL) AND EntityType='D';

-- Workflow Translation (Workflow)
UPDATE AD_Tab SET Description='Related workflow translation entries for this workflow', Help='Navigate here to view and edit associated workflow translation details. Records on this tab are linked to the parent entry above. Accessed through the Workflow window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2bd4bf06-efdd-4859-9eca-3668df2dadc4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Business Partner (Import Business Partner)
UPDATE AD_Tab SET Description='Primary data entry for import business partner records', Help='Use this tab to create and modify the core import business partner attributes. This serves as the main entry point for this record type. Accessed through the Import Business Partner window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c3a91397-9082-4039-a51d-9e48cafdd979' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- News Item (News Channel)
UPDATE AD_Tab SET Description='Related news item entries for this news channel', Help='Navigate here to view and edit associated news item details. Records on this tab are linked to the parent entry above. Accessed through the News Channel window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5a73d8e6-2d84-4534-a56e-95c74db023e3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Invoice (Expense Invoice (Alpha))
UPDATE AD_Tab SET Description='Primary data entry for invoice records', Help='Use this tab to create and modify the core invoice attributes. This serves as the main entry point for this record type. Accessed through the Expense Invoice (Alpha) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c180e77f-e631-43b3-a94a-fb3957e2c923' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- EDI Transaction (EDI Transaction)
UPDATE AD_Tab SET Description='Primary data entry for edi transaction records', Help='Use this tab to create and modify the core edi transaction attributes. This serves as the main entry point for this record type. Accessed through the EDI Transaction window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='49639381-6d8a-4a2c-bdc1-d1cff2b55655' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Account (Import Account)
UPDATE AD_Tab SET Description='Primary data entry for import account records', Help='Use this tab to create and modify the core import account attributes. This serves as the main entry point for this record type. Accessed through the Import Account window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='86485e4b-2b60-4827-a1e4-6be966661c22' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Report Line Set (Import Report Line Set)
UPDATE AD_Tab SET Description='Primary data entry for import report line set records', Help='Use this tab to create and modify the core import report line set attributes. This serves as the main entry point for this record type. Accessed through the Import Report Line Set window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9e34814f-394a-4de9-80a8-156e843c4ae9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Asset History (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated asset history details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='60b940eb-f62f-4b05-a17e-ffa092c3dd2d' AND (Help IS NULL) AND EntityType='D';

-- Translation (Dunning)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Dunning window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7f893564-c65e-402c-890c-dea0e800e708' AND (Help IS NULL) AND EntityType='D';

-- Task Translation (Task)
UPDATE AD_Tab SET Description='Related task translation entries for this task', Help='Navigate here to view and edit associated task translation details. Records on this tab are linked to the parent entry above. Accessed through the Task window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f0e9f0f2-2be3-4ecc-9fa0-8f0837a5fb2e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Node Translation (Workflow)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated node translation details. Records on this tab are linked to the parent entry above. Accessed through the Workflow window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4c1dc24e-8e5c-4b08-9f0f-2ce2ee63da87' AND (Help IS NULL) AND EntityType='D';

-- Payment Schedule (Sales Invoice and Credit/Debit Note)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated payment schedule details. Records on this tab are linked to the parent entry above. Accessed through the Sales Invoice and Credit/Debit Note window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ef43558a-4dff-427c-a321-e52c3b40f58d' AND (Help IS NULL) AND EntityType='D';

-- Previous Node (Workflow)
UPDATE AD_Tab SET Description='Related previous node entries for this workflow', Help='Navigate here to view and edit associated previous node details. Records on this tab are linked to the parent entry above. Accessed through the Workflow window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9d873152-ee4d-4567-b345-4629cdd0dc58' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Payment (Import Payment)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core payment attributes. This serves as the main entry point for this record type. Accessed through the Import Payment window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7ef16ddd-2626-435b-a198-9f6256025cdd' AND (Help IS NULL) AND EntityType='D';

-- Item Translation (Print Format)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated item translation details. Records on this tab are linked to the parent entry above. Accessed through the Print Format window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ac298e28-97f0-46a1-90d3-416ad794eeb5' AND (Help IS NULL) AND EntityType='D';

-- Translation (Workbench)
UPDATE AD_Tab SET Description='Related translation entries for this workbench', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Workbench window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9c843fbe-f141-445c-9bf3-0192cb48fb45' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- EDI Definition (EDI Definition)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core edi definition attributes. This serves as the main entry point for this record type. Accessed through the EDI Definition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='dcb5ffd1-815c-41b2-a273-3e0d21795fae' AND (Help IS NULL) AND EntityType='D';

-- EDI Log (EDI Transaction)
UPDATE AD_Tab SET Description='Related edi log entries for this edi transaction', Help='Navigate here to view and edit associated edi log details. Records on this tab are linked to the parent entry above. Accessed through the EDI Transaction window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='92ce1b46-1f49-475d-89e4-a3ef4c3eea09' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Printer (Label Printer)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core printer attributes. This serves as the main entry point for this record type. Accessed through the Label Printer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='036c05f2-4cba-468e-9411-637944fe8847' AND (Help IS NULL) AND EntityType='D';

-- Function (Label Printer)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated function details. Records on this tab are linked to the parent entry above. Accessed through the Label Printer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ffdb6d0e-15d7-41bf-8ee8-9a1bfc97b0e7' AND (Help IS NULL) AND EntityType='D';

-- Advertisement (Web Ad Management)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated advertisement details. Records on this tab are linked to the parent entry above. Accessed through the Web Ad Management window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c15ae9d2-bf49-43e8-b5fa-34e8f98d63f5' AND (Help IS NULL) AND EntityType='D';

-- News Channel (News Channel)
UPDATE AD_Tab SET Description='Primary data entry for news channel records', Help='Use this tab to create and modify the core news channel attributes. This serves as the main entry point for this record type. Accessed through the News Channel window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fd915313-6f4b-49df-ab0e-f90f315c1b2a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Product Costs (Product Costs)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated product costs details. Records on this tab are linked to the parent entry above. Accessed through the Product Costs window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='29a145fc-8fd8-45b3-b0d6-1bdcfc0c2a14' AND (Help IS NULL) AND EntityType='D';

-- Media (Web Project)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated media details. Records on this tab are linked to the parent entry above. Accessed through the Web Project window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ecf75fef-4614-446c-81a2-1388ecf5764a' AND (Help IS NULL) AND EntityType='D';

-- Template (Template)
UPDATE AD_Tab SET Description='Primary data entry for template records', Help='Use this tab to create and modify the core template attributes. This serves as the main entry point for this record type. Accessed through the Template window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='062caa3a-43ee-436f-a39d-e7692326b839' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Requisition Line (Requisition)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated requisition line details. Records on this tab are linked to the parent entry above. Accessed through the Requisition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2a2bf1c9-9a23-489a-8dca-89903b826d84' AND (Help IS NULL) AND EntityType='D';

-- Stage Element Translation (Web Project)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated stage element translation details. Records on this tab are linked to the parent entry above. Accessed through the Web Project window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7e2a3ce4-2885-4654-95b8-58071fe3570d' AND (Help IS NULL) AND EntityType='D';

-- Rule (Rule)
UPDATE AD_Tab SET Description='Primary data entry for rule records', Help='Use this tab to create and modify the core rule attributes. This serves as the main entry point for this record type. Accessed through the Rule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f65ecc3d-fbec-4c40-945e-c985a0242bae' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Module (ASP Modules)
UPDATE AD_Tab SET Description='Primary data entry for module records', Help='Use this tab to create and modify the core module attributes. This serves as the main entry point for this record type. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='22e53689-5899-4790-8346-d6948aac14d0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Ad Cat Template (Web Ad Management)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated ad cat template details. Records on this tab are linked to the parent entry above. Accessed through the Web Ad Management window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d9d42555-6e69-4b03-8435-48e7a9a9bc4c' AND (Help IS NULL) AND EntityType='D';

-- PackIn (Pack In)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core packin attributes. This serves as the main entry point for this record type. Accessed through the Pack In window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='368521bc-1b9b-4c1c-8f8b-594cc1357397' AND (Help IS NULL) AND EntityType='D';

-- Bank Statement (Import Bank Statement)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core bank statement attributes. This serves as the main entry point for this record type. Accessed through the Import Bank Statement window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5f8d144f-af16-4b03-a6cf-5595f77d1981' AND (Help IS NULL) AND EntityType='D';

-- Fixed Asset (Imported Fixed Asset)
UPDATE AD_Tab SET Description='Primary data entry for fixed asset records', Help='Use this tab to create and modify the core fixed asset attributes. This serves as the main entry point for this record type. Accessed through the Imported Fixed Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='11f10490-012f-41cf-8cdf-181714e4bbfa' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Assigned Partners (Business Partner Group)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated assigned partners details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0dfa6162-380d-4f15-ab74-70a9614e6824' AND (Help IS NULL) AND EntityType='D';

-- Searches (Search Definition)
UPDATE AD_Tab SET Description='Primary data entry for searches records', Help='Use this tab to create and modify the core searches attributes. This serves as the main entry point for this record type. Accessed through the Search Definition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='13c3a338-8098-4c67-8468-3459d4ed1c99' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Requisition (Requisition)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core requisition attributes. This serves as the main entry point for this record type. Accessed through the Requisition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='858fe20f-7d15-411b-a70c-c09b756ba4d2' AND (Help IS NULL) AND EntityType='D';

-- Stage Translation (Web Project)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated stage translation details. Records on this tab are linked to the parent entry above. Accessed through the Web Project window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='86883825-b7b0-4756-85b4-9a758b57813b' AND (Help IS NULL) AND EntityType='D';

-- Exceptions (ASP Subscribed Modules)
UPDATE AD_Tab SET Description='Primary data entry for exceptions records', Help='Use this tab to create and modify the core exceptions attributes. This serves as the main entry point for this record type. Accessed through the ASP Subscribed Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e6a0f9bb-9d7a-4615-9a38-578b02daf776' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Model Validator (Model Validator)
UPDATE AD_Tab SET Description='Primary data entry for model validator records', Help='Use this tab to create and modify the core model validator attributes. This serves as the main entry point for this record type. Accessed through the Model Validator window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cc4a6152-201f-4945-9583-77d800824ebd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Other Information (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated other information details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3fc69c36-bf2c-4fea-9a01-28f9bf42ab9f' AND (Help IS NULL) AND EntityType='D';

-- Tax Information (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated tax information details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f96ca51e-128f-4a41-a6fd-e7c5528860f4' AND (Help IS NULL) AND EntityType='D';

-- Replenish (Product Planning Data)
UPDATE AD_Tab SET Description='Related replenish entries for this product planning data', Help='Navigate here to view and edit associated replenish details. Records on this tab are linked to the parent entry above. Accessed through the Product Planning Data window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d362eed9-a322-47a2-9442-56854ba80855' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Finance Information (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated finance information details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c545c3e9-9797-4f0f-b8f0-30069a0c4cdc' AND (Help IS NULL) AND EntityType='D';

-- Translation (Tax Rate)
UPDATE AD_Tab SET Description='Related translation entries for this tax rate', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Tax Rate window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='105a4039-7caa-4c7a-9336-59763d5ae5c3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- BOM (BOM Change Notice)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated bom details. Records on this tab are linked to the parent entry above. Accessed through the BOM Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='797dea4a-f6b1-4a98-bd10-932f043abcbb' AND (Help IS NULL) AND EntityType='D';

-- Create Depreciation Entry (Post Depreciation Entry)
UPDATE AD_Tab SET Description='Primary data entry for create depreciation entry records', Help='Use this tab to create and modify the core create depreciation entry attributes. This serves as the main entry point for this record type. Accessed through the Post Depreciation Entry window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='17984993-4fc9-43fc-a6ce-69efde856982' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Step2 Asset Disposal (Asset Disposal2)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated step2 asset disposal details. Records on this tab are linked to the parent entry above. Accessed through the Asset Disposal2 window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b320a5ec-8d52-49ff-ac21-bb02f7c39595' AND (Help IS NULL) AND EntityType='D';

-- Revaluation Entry (Asset Revaluation Processing)
UPDATE AD_Tab SET Description='Primary data entry for revaluation entry records', Help='Use this tab to create and modify the core revaluation entry attributes. This serves as the main entry point for this record type. Accessed through the Asset Revaluation Processing window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3671e53e-1898-4ca1-aeae-4ebd20872dee' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Step4 Process Asset Split (Asset Split)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated step4 process asset split details. Records on this tab are linked to the parent entry above. Accessed through the Asset Split window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c4af87a4-00d7-441d-b816-7ee4ea6dd558' AND (Help IS NULL) AND EntityType='D';

-- Step3 Process Transfers (Asset Transfers)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated step3 process transfers details. Records on this tab are linked to the parent entry above. Accessed through the Asset Transfers window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='261e2ccf-7f2e-468b-84dc-230d40fc327a' AND (Help IS NULL) AND EntityType='D';

-- Build Workfile (Build Depreciation Workfile)
UPDATE AD_Tab SET Description='Primary data entry for build workfile records', Help='Use this tab to create and modify the core build workfile attributes. This serves as the main entry point for this record type. Accessed through the Build Depreciation Workfile window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e533ce13-e001-412e-9988-609cf9a35f67' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Create Asset Transfer Entry (Transfer Asset Entry)
UPDATE AD_Tab SET Description='Primary data entry for create asset transfer entry records', Help='Use this tab to create and modify the core create asset transfer entry attributes. This serves as the main entry point for this record type. Accessed through the Transfer Asset Entry window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b3938a3f-e7ca-4633-8586-690301c65a00' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- House Keeping (House Keeping)
UPDATE AD_Tab SET Description='Primary data entry for house keeping records', Help='Use this tab to create and modify the core house keeping attributes. This serves as the main entry point for this record type. Accessed through the House Keeping window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='470d59d7-04f1-4e84-b080-cd26a058e0dd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Terminal (Web POS Terminal)
UPDATE AD_Tab SET Description='Primary data entry for terminal records', Help='Use this tab to create and modify the core terminal attributes. This serves as the main entry point for this record type. Accessed through the Web POS Terminal window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9c1d5c8c-8954-4e57-ab11-1a2bc2f551c5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Level (ASP Modules)
UPDATE AD_Tab SET Description='Related level entries for this asp modules', Help='Navigate here to view and edit associated level details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ad27dcca-a4cb-4933-a680-2ca442f1c705' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Charge Type (Charge Type)
UPDATE AD_Tab SET Description='Primary data entry for charge type records', Help='Use this tab to create and modify the core charge type attributes. This serves as the main entry point for this record type. Accessed through the Charge Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f1a00ec5-de27-4e3f-b481-6717d1b1e923' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Price List (Import Price List)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core import price list attributes. This serves as the main entry point for this record type. Accessed through the Import Price List window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='102926f9-5ab6-455e-8567-5245c4793fd8' AND (Help IS NULL) AND EntityType='D';

-- GL Journal Generator (GL Journal Generator)
UPDATE AD_Tab SET Description='Primary data entry for gl journal generator records', Help='Use this tab to create and modify the core gl journal generator attributes. This serves as the main entry point for this record type. Accessed through the GL Journal Generator window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1344f3e1-f59e-43b3-bfd2-98241a142397' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Password Rule (Password Rule)
UPDATE AD_Tab SET Description='Primary data entry for password rule records', Help='Use this tab to create and modify the core password rule attributes. This serves as the main entry point for this record type. Accessed through the Password Rule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2dfa3f66-7b57-4f9d-b7dc-e3dde5670f20' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Cost Details (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated cost details details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='dc842a9b-d42b-46d5-8876-10fd49a29e7d' AND (Help IS NULL) AND EntityType='D';

-- Depreciation Forecast (Build Depreciation Forecast)
UPDATE AD_Tab SET Description='Primary data entry for depreciation forecast records', Help='Use this tab to create and modify the core depreciation forecast attributes. This serves as the main entry point for this record type. Accessed through the Build Depreciation Forecast window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cf673563-dbdc-434f-a778-1872c71e2bac' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Create Split Asset Entry (Split Asset Entry)
UPDATE AD_Tab SET Description='Primary data entry for create split asset entry records', Help='Use this tab to create and modify the core create split asset entry attributes. This serves as the main entry point for this record type. Accessed through the Split Asset Entry window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8b8b08fd-4ceb-4d3d-be15-f58bf33c3b75' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Insurance Information (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated insurance information details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='869b152c-40e2-49c1-8400-006945a16410' AND (Help IS NULL) AND EntityType='D';

-- Accounting Setup (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated accounting setup details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='eefefb40-3b06-4a46-836a-0331a35e300b' AND (Help IS NULL) AND EntityType='D';

-- Asset Usage (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated asset usage details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bd0df65c-00c6-427f-b66b-d36536ebcf23' AND (Help IS NULL) AND EntityType='D';

-- Report Cube (Report Cube)
UPDATE AD_Tab SET Description='Primary data entry for report cube records', Help='Use this tab to create and modify the core report cube attributes. This serves as the main entry point for this record type. Accessed through the Report Cube window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0e3fef28-42bf-4b86-bcc9-2db589fc9e64' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- UOM Conversion (Product)
UPDATE AD_Tab SET Description='Related uom conversion entries for this product', Help='Navigate here to view and edit associated uom conversion details. Records on this tab are linked to the parent entry above. Accessed through the Product window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9079fb0f-186f-440c-b03c-fd47450e87cb' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Export Package (Pack Out)
UPDATE AD_Tab SET Description='Primary data entry for export package records', Help='Use this tab to create and modify the core export package attributes. This serves as the main entry point for this record type. Accessed through the Pack Out window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='af0c2339-8405-4300-9342-920ef80b016e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Toolbar Button Access (Role Toolbar Button Access)
UPDATE AD_Tab SET Description='Primary data entry for toolbar button access records', Help='Use this tab to create and modify the core toolbar button access attributes. This serves as the main entry point for this record type. Accessed through the Role Toolbar Button Access window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e9e35172-128a-4de0-b92c-1b9b901d0a71' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Payment Schedule (Sales Order)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated payment schedule details. Records on this tab are linked to the parent entry above. Accessed through the Sales Order window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4f92f8a7-1695-4d82-9130-5d62c0e0a372' AND (Help IS NULL) AND EntityType='D';

-- Payment Schedule (Purchase Order)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated payment schedule details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Order window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f138277e-b06a-447e-9b6b-af01a30c0e6d' AND (Help IS NULL) AND EntityType='D';

-- Payment Schedule (Purchase Invoice and Credit/Debit Note)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated payment schedule details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Invoice and Credit/Debit Note window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='77ee0b18-8983-4113-9a9c-fe70563ec1ce' AND (Help IS NULL) AND EntityType='D';

-- Cash Plan Line (Cash Plan)
UPDATE AD_Tab SET Description='Related cash plan line entries for this cash plan', Help='Navigate here to view and edit associated cash plan line details. Records on this tab are linked to the parent entry above. Accessed through the Cash Plan window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d1f805cd-3227-4510-a8ef-e3fa96d4fa54' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Costs (Product)
UPDATE AD_Tab SET Description='Related costs entries for this product', Help='Navigate here to view and edit associated costs details. Records on this tab are linked to the parent entry above. Accessed through the Product window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='298b1b39-2d23-4b39-a6f7-89f9e026625e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Used in Process Parameter (Element)
UPDATE AD_Tab SET Description='Related used in process parameter entries for this element', Help='Navigate here to view and edit associated used in process parameter details. Records on this tab are linked to the parent entry above. Accessed through the Element window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2f4da0c7-626d-4f00-8e27-4fc5c369d4f4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Server (Web Broadcast Server)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core server attributes. This serves as the main entry point for this record type. Accessed through the Web Broadcast Server window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0a6271dd-3a19-4ce6-916e-c13fa8b81a4b' AND (Help IS NULL) AND EntityType='D';

-- Create Disposal Entry (Disposed Asset Entry)
UPDATE AD_Tab SET Description='Primary data entry for create disposal entry records', Help='Use this tab to create and modify the core create disposal entry attributes. This serves as the main entry point for this record type. Accessed through the Disposed Asset Entry window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='09161adc-a20a-48ff-b451-72147d2f085e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Revaluation Asset (Revaluation Asset)
UPDATE AD_Tab SET Description='Primary data entry for revaluation asset records', Help='Use this tab to create and modify the core revaluation asset attributes. This serves as the main entry point for this record type. Accessed through the Revaluation Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3ea88d92-a7fe-4273-8920-83ebc12bb6c9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Advertisement Category (Web Ad Management)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core advertisement category attributes. This serves as the main entry point for this record type. Accessed through the Web Ad Management window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='dcd283ba-3115-4f29-8093-3c565437bad6' AND (Help IS NULL) AND EntityType='D';

-- Translation (Dashboard Content)
UPDATE AD_Tab SET Description='Related translation entries for this dashboard content', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Dashboard Content window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='392a621a-0584-4840-aba7-3e9c8ba0afc8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Form)
UPDATE AD_Tab SET Description='Related translation entries for this form', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Form window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bbbb5ca4-5adf-4b0e-928e-c952169d0b4d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Journal (GL Journal)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core journal attributes. This serves as the main entry point for this record type. Accessed through the GL Journal window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='80ec1349-e04c-4c99-85ce-f070dbda9155' AND (Help IS NULL) AND EntityType='D';

-- Issue Project (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated issue project details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='493868a8-ac81-4919-a304-444c8ee22f42' AND (Help IS NULL) AND EntityType='D';

-- Material Transactions (Material Transactions (indirect use))
UPDATE AD_Tab SET Description='Primary data entry for material transactions records', Help='Use this tab to create and modify the core material transactions attributes. This serves as the main entry point for this record type. Accessed through the Material Transactions (indirect use) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9d3d5542-fe86-428b-b4d7-a2e6fc30548d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Packages Installed (Packages Installed)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core packages installed attributes. This serves as the main entry point for this record type. Accessed through the Packages Installed window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='46e13b93-81fb-404e-ac28-b286e7c8ec3c' AND (Help IS NULL) AND EntityType='D';

-- Test (Quality Test)
UPDATE AD_Tab SET Description='Primary data entry for test records', Help='Use this tab to create and modify the core test attributes. This serves as the main entry point for this record type. Accessed through the Quality Test window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='68fee7b9-f80d-48a6-8a9f-679dbbb3ac97' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Funding Mode (Asset Funding Mode)
UPDATE AD_Tab SET Description='Primary data entry for funding mode records', Help='Use this tab to create and modify the core funding mode attributes. This serves as the main entry point for this record type. Accessed through the Asset Funding Mode window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='eac71ce6-ecd4-4e6a-9a54-492c476de399' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Table Script Validator (Table and Column)
UPDATE AD_Tab SET Description='Related table script validator entries for this table and column', Help='Navigate here to view and edit associated table script validator details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d900d4a4-5c9e-49b7-965b-03eb69dba7bb' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Log (Alert Processor)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated log details. Records on this tab are linked to the parent entry above. Accessed through the Alert Processor window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bb147a97-88d7-468d-89b3-fd5135754d6e' AND (Help IS NULL) AND EntityType='D';

-- Migration Scripts (Migration Scripts)
UPDATE AD_Tab SET Description='Primary data entry for migration scripts records', Help='Use this tab to create and modify the core migration scripts attributes. This serves as the main entry point for this record type. Accessed through the Migration Scripts window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='40921478-f06c-46d9-8ce0-3bf2962bba39' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- ToolBar Button (Toolbar Button)
UPDATE AD_Tab SET Description='Primary data entry for toolbar button records', Help='Use this tab to create and modify the core toolbar button attributes. This serves as the main entry point for this record type. Accessed through the Toolbar Button window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1acc51c2-9f4e-4da8-abba-0862e9f51609' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- POS Tender Type (POS Tender Type)
UPDATE AD_Tab SET Description='Primary data entry for pos tender type records', Help='Use this tab to create and modify the core pos tender type attributes. This serves as the main entry point for this record type. Accessed through the POS Tender Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ed5a16d3-a040-4691-95ca-b8f8466901ea' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Asset Balances (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated asset balances details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c88484e2-36b6-4d64-b3f2-3069d1a72a1a' AND (Help IS NULL) AND EntityType='D';

-- License Information (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated license information details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0edd25bb-6192-4d4c-b158-c3f284539cc6' AND (Help IS NULL) AND EntityType='D';

-- Generator Line (GL Journal Generator)
UPDATE AD_Tab SET Description='Related generator line entries for this gl journal generator', Help='Navigate here to view and edit associated generator line details. Records on this tab are linked to the parent entry above. Accessed through the GL Journal Generator window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='736a5f16-ec33-406b-8b8d-917a1cd214ce' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- List Translation (Reference)
UPDATE AD_Tab SET Description='Related list translation entries for this reference', Help='Navigate here to view and edit associated list translation details. Records on this tab are linked to the parent entry above. Accessed through the Reference window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1327c02f-2f68-40f0-b249-7e4524ada4b4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Reference Translation (Reference)
UPDATE AD_Tab SET Description='Related reference translation entries for this reference', Help='Navigate here to view and edit associated reference translation details. Records on this tab are linked to the parent entry above. Accessed through the Reference window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3a96441f-788b-4820-90be-19d9656d7da5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Expense (Asset)
UPDATE AD_Tab SET Description='Related expense entries for this asset', Help='Navigate here to view and edit associated expense details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f640b449-8371-40e1-b7ac-9111a1f89f25' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Activation/Addition (Asset)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated activation/addition details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='65faeec2-d493-4df0-8b4f-2ac2623cc572' AND (Help IS NULL) AND EntityType='D';

-- Addition (Asset Addition)
UPDATE AD_Tab SET Description='Primary data entry for addition records', Help='Use this tab to create and modify the core addition attributes. This serves as the main entry point for this record type. Accessed through the Asset Addition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e20d585b-44e5-4faf-9353-cbe7fdf929ba' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Asset Change account (Asset Change Account)
UPDATE AD_Tab SET Description='Primary data entry for asset change account records', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2433e0ad-a36d-4d31-a4f2-e8d8cc29d3f9' AND (Description IS NULL) AND EntityType='D';

-- Class (Asset Class)
UPDATE AD_Tab SET Description='Primary data entry for class records', Help='Use this tab to create and modify the core class attributes. This serves as the main entry point for this record type. Accessed through the Asset Class window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='527a9f85-2887-4172-a21d-db9e6f573dc2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Accounting (Asset Funding Mode)
UPDATE AD_Tab SET Description='Related accounting entries for this asset funding mode', Help='Navigate here to view and edit associated accounting details. Records on this tab are linked to the parent entry above. Accessed through the Asset Funding Mode window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0871c486-143b-44a7-b0db-eb1eee42317b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Packages (Shipment (Customer))
UPDATE AD_Tab SET Description='Related packages entries for this shipment (customer)', Help='Navigate here to view and edit associated packages details. Records on this tab are linked to the parent entry above. Accessed through the Shipment (Customer) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a184a69b-1d19-4b90-b8df-e146178fe446' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Broadcast Message (Broadcast Message)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core broadcast message attributes. This serves as the main entry point for this record type. Accessed through the Broadcast Message window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5127b90a-d7a3-45aa-8000-bf81cc0dc49a' AND (Help IS NULL) AND EntityType='D';

-- Web Service Type (Web Service Security)
UPDATE AD_Tab SET Description='Primary data entry for web service type records', Help='Use this tab to create and modify the core web service type attributes. This serves as the main entry point for this record type. Accessed through the Web Service Security window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='280c3da6-7228-4db2-a74e-1e0e9538a2bb' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Asset Disposal (Asset Disposal)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core asset disposal attributes. This serves as the main entry point for this record type. Accessed through the Asset Disposal window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7375c1e1-a713-4769-8087-c9da6c47fd7b' AND (Help IS NULL) AND EntityType='D';

-- Used in Field (Table and Column)
UPDATE AD_Tab SET Description='Related used in field entries for this table and column', Help='Navigate here to view and edit associated used in field details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='90fc8aa0-24d2-4f9d-b415-085bd6f47a90' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Packages (Shipment Package)
UPDATE AD_Tab SET Description='Primary data entry for packages records', Help='Use this tab to create and modify the core packages attributes. This serves as the main entry point for this record type. Accessed through the Shipment Package window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a89b3b7e-8d00-4bf9-b899-ff9eec12d540' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Window Translation (Window, Tab and Field)
UPDATE AD_Tab SET Description='Related window translation entries for this window, tab and field', Help='Navigate here to view and edit associated window translation details. Records on this tab are linked to the parent entry above. Accessed through the Window, Tab and Field window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9c29b6da-1387-493a-afd8-565465ad572c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- 1099 Box (1099 Box)
UPDATE AD_Tab SET Description='Primary data entry for 1099 box records', Help='Use this tab to create and modify the core 1099 box attributes. This serves as the main entry point for this record type. Accessed through the 1099 Box window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='98596e65-a82f-4649-b4f2-abced2c16f62' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Internal Use (Inventory Decrease/Increase)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core internal use attributes. This serves as the main entry point for this record type. Accessed through the Inventory Decrease/Increase window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='521b232f-8102-4d7a-9e78-bcb1c5ba0eef' AND (Help IS NULL) AND EntityType='D';

-- Setup Wizard (Setup Wizard Maintenance)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core setup wizard attributes. This serves as the main entry point for this record type. Accessed through the Setup Wizard Maintenance window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b519bc95-9d3b-4623-a0db-df00df1f0a48' AND (Help IS NULL) AND EntityType='D';

-- Stage Element (Web Project)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated stage element details. Records on this tab are linked to the parent entry above. Accessed through the Web Project window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4ed9733b-5464-41f5-823e-18e84336d94b' AND (Help IS NULL) AND EntityType='D';

-- Task (ASP Modules)
UPDATE AD_Tab SET Description='Related task entries for this asp modules', Help='Navigate here to view and edit associated task details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='666b4a7a-ccbc-4a9a-80eb-0a1a70f3dc6f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Cost Adjustment (Cost Adjustment)
UPDATE AD_Tab SET Description='Primary data entry for cost adjustment records', Help='Use this tab to create and modify the core cost adjustment attributes. This serves as the main entry point for this record type. Accessed through the Cost Adjustment window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6334be0e-03c7-4e14-86e1-6c2c2e6c71f7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Purchase Orders (Requisition)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated purchase orders details. Records on this tab are linked to the parent entry above. Accessed through the Requisition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bac74a27-4ddc-45a8-81c8-76d0203184b6' AND (Help IS NULL) AND EntityType='D';

-- Log (Text Search Log)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core log attributes. This serves as the main entry point for this record type. Accessed through the Text Search Log window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='994279de-a572-44ec-8421-8540ff585a70' AND (Help IS NULL) AND EntityType='D';

-- Reference List Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related reference list translation entries for this system translation check', Help='Navigate here to view and edit associated reference list translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='86a2bb6a-da0d-48f7-850c-3b7d40f9218b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Activity (Activity (ABC))
UPDATE AD_Tab SET Help='Use this tab to create and modify the core activity attributes. This serves as the main entry point for this record type. Accessed through the Activity (ABC) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d9ecd665-b5b5-4bcc-be5c-14fa6a8fc197' AND (Help IS NULL) AND EntityType='D';

-- Update Notification (Request)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated update notification details. Records on this tab are linked to the parent entry above. Accessed through the Request window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='eb251a4b-ece0-4d5c-8bd9-a078f99020fd' AND (Help IS NULL) AND EntityType='D';

-- Unposted Documents (UnPosted Documents)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core unposted documents attributes. This serves as the main entry point for this record type. Accessed through the UnPosted Documents window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fabef23f-1f86-42bd-bf01-1f87380af9c6' AND (Help IS NULL) AND EntityType='D';

-- Disposal (Asset)
UPDATE AD_Tab SET Description='Related disposal entries for this asset', Help='Navigate here to view and edit associated disposal details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d072f6c0-cc39-4960-9de9-3c0c8effc804' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Currency Rate (Import Currency Rate)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core import currency rate attributes. This serves as the main entry point for this record type. Accessed through the Import Currency Rate window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ae266dff-ff17-452d-8c8f-c57b7da2b29a' AND (Help IS NULL) AND EntityType='D';

-- Workbench (Workbench)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core workbench attributes. This serves as the main entry point for this record type. Accessed through the Workbench window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='800d374c-071f-4358-bf49-d8a6236e7ba4' AND (Help IS NULL) AND EntityType='D';

-- Element Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related element translation entries for this system translation check', Help='Navigate here to view and edit associated element translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ab10f232-e9cb-4483-9d05-fd92deb448f0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Message Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related message translation entries for this system translation check', Help='Navigate here to view and edit associated message translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2e72d6e7-1cbb-48c9-b236-a41b2edc3c36' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Window Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related window translation entries for this system translation check', Help='Navigate here to view and edit associated window translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0fd82e03-31c8-4e0f-97bf-509b77704035' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Process Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related process translation entries for this system translation check', Help='Navigate here to view and edit associated process translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e3ddcd02-8934-4046-a4b6-5b4f34f09766' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Expense Type (Expense Type)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core expense type attributes. This serves as the main entry point for this record type. Accessed through the Expense Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7bfb0355-7e6e-4439-831c-08bebaa6eba4' AND (Help IS NULL) AND EntityType='D';

-- Subscription (Subscription)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core subscription attributes. This serves as the main entry point for this record type. Accessed through the Subscription window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='372e810a-1e1c-47bd-8d64-1b2e26aa4176' AND (Help IS NULL) AND EntityType='D';

-- Window (ASP Modules)
UPDATE AD_Tab SET Description='Related window entries for this asp modules', Help='Navigate here to view and edit associated window details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='168c5b3f-8c1a-48eb-8c0d-f00f5c24986d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Format (Import Loader Format)
UPDATE AD_Tab SET Description='Primary data entry for import format records', Help='Use this tab to create and modify the core import format attributes. This serves as the main entry point for this record type. Accessed through the Import Loader Format window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cf474878-2c5b-410f-afc0-987d6e82ebed' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Invoices (Sales Rep Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated invoices details. Records on this tab are linked to the parent entry above. Accessed through the Sales Rep Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='058dda72-6e8a-45a8-b542-bb65b7266a41' AND (Help IS NULL) AND EntityType='D';

-- Invoice Line (Sales Rep Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated invoice line details. Records on this tab are linked to the parent entry above. Accessed through the Sales Rep Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e7f954f6-3e2e-4810-bdb0-8b9f753bce85' AND (Help IS NULL) AND EntityType='D';

-- Workbench (Desktop)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated workbench details. Records on this tab are linked to the parent entry above. Accessed through the Desktop window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fe42ffa6-339b-4f30-8743-aadede02062f' AND (Help IS NULL) AND EntityType='D';

-- Display Order (Print Format)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated display order details. Records on this tab are linked to the parent entry above. Accessed through the Print Format window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e4b841ba-69ed-439b-b240-ff8518c06e23' AND (Help IS NULL) AND EntityType='D';

-- Assigned Products (Product Category)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated assigned products details. Records on this tab are linked to the parent entry above. Accessed through the Product Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='65430ade-9ae2-46d4-94ac-98a34c150876' AND (Help IS NULL) AND EntityType='D';

-- Assigned Attributes (Attribute Search)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated assigned attributes details. Records on this tab are linked to the parent entry above. Accessed through the Attribute Search window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ce2646dc-4c4a-4413-b87c-783575c9742c' AND (Help IS NULL) AND EntityType='D';

-- Find (Find (indirect use))
UPDATE AD_Tab SET Description='Primary data entry for find records', Help='Use this tab to create and modify the core find attributes. This serves as the main entry point for this record type. Accessed through the Find (indirect use) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='91b4951e-4175-4199-9f37-ee0f15019b4a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Report Line (Report Line Set)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated report line details. Records on this tab are linked to the parent entry above. Accessed through the Report Line Set window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b4e51eb5-24f6-4080-90e7-2c24b685cf85' AND (Help IS NULL) AND EntityType='D';

-- Type (Part Type)
UPDATE AD_Tab SET Description='Primary data entry for type records', Help='Use this tab to create and modify the core type attributes. This serves as the main entry point for this record type. Accessed through the Part Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b02502df-4de3-4249-9b5e-9c98ec4aabb7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tab Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related tab translation entries for this system translation check', Help='Navigate here to view and edit associated tab translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ec79b8bd-ee60-4bdf-9f32-6c6bc7414805' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Field Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related field translation entries for this system translation check', Help='Navigate here to view and edit associated field translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b844b5ad-4c1d-48df-9061-683063732c93' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Accounting (Accounting Fact Details)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core accounting attributes. This serves as the main entry point for this record type. Accessed through the Accounting Fact Details window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4b60e989-512f-4cc8-b27a-c8a4297b966d' AND (Help IS NULL) AND EntityType='D';

-- Payment (Payment Batch)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated payment details. Records on this tab are linked to the parent entry above. Accessed through the Payment Batch window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ff29a531-243d-4954-9aa6-4bb43921f150' AND (Help IS NULL) AND EntityType='D';

-- Orders (Sales Rep Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated orders details. Records on this tab are linked to the parent entry above. Accessed through the Sales Rep Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f0d7784c-253a-421d-b126-5463f8c8bb59' AND (Help IS NULL) AND EntityType='D';

-- Report Line Set (Report Line Set)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core report line set attributes. This serves as the main entry point for this record type. Accessed through the Report Line Set window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1ea423d9-ae63-479b-953d-1e88b919f069' AND (Help IS NULL) AND EntityType='D';

-- Report Source (Report Line Set)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated report source details. Records on this tab are linked to the parent entry above. Accessed through the Report Line Set window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='16b41aec-68a8-4e69-a255-b562e43df4cd' AND (Help IS NULL) AND EntityType='D';

-- Financial Report (Financial Report)
UPDATE AD_Tab SET Description='Primary data entry for financial report records', Help='Use this tab to create and modify the core financial report attributes. This serves as the main entry point for this record type. Accessed through the Financial Report window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ba0f63d3-b50a-47e9-b714-bc756113ee95' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Position Remuneration (Remuneration)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated position remuneration details. Records on this tab are linked to the parent entry above. Accessed through the Remuneration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cddeb653-d8c3-4506-84bb-fd0509e28212' AND (Help IS NULL) AND EntityType='D';

-- Employee Remuneration (Remuneration)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated employee remuneration details. Records on this tab are linked to the parent entry above. Accessed through the Remuneration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='942f2a68-c90f-4d85-a8be-a8f244ea7c2c' AND (Help IS NULL) AND EntityType='D';

-- Product (Product BOM)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core product attributes. This serves as the main entry point for this record type. Accessed through the Product BOM window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d519ee18-2bca-4e0b-a7d8-8ebf7a619c47' AND (Help IS NULL) AND EntityType='D';

-- Note (Attachment)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated note details. Records on this tab are linked to the parent entry above. Accessed through the Attachment window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='98383d17-f884-4783-8d59-858c45e8e89e' AND (Help IS NULL) AND EntityType='D';

-- BOM (Product BOM)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated bom details. Records on this tab are linked to the parent entry above. Accessed through the Product BOM window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a9bed7d8-fe30-4364-aee5-621d18f49a94' AND (Help IS NULL) AND EntityType='D';

-- Window (Workbench)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated window details. Records on this tab are linked to the parent entry above. Accessed through the Workbench window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3bd43eec-9565-4866-a593-35302f9d0500' AND (Help IS NULL) AND EntityType='D';

-- Select Product (Product Costs)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core select product attributes. This serves as the main entry point for this record type. Accessed through the Product Costs window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6b3a9c95-e879-4d1d-b8f0-682f8b52cdb9' AND (Help IS NULL) AND EntityType='D';

-- Resource (Resource)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core resource attributes. This serves as the main entry point for this record type. Accessed through the Resource window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='edeab878-3e3b-46c9-ab16-c41299831c46' AND (Help IS NULL) AND EntityType='D';

-- Process Audit (Process Audit)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core process audit attributes. This serves as the main entry point for this record type. Accessed through the Process Audit window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='58bba03d-cb5c-4230-aeb2-1a435ae41b93' AND (Help IS NULL) AND EntityType='D';

-- Package Details (Pack Out)
UPDATE AD_Tab SET Description='Related package details entries for this pack out', Help='Navigate here to view and edit associated package details details. Records on this tab are linked to the parent entry above. Accessed through the Pack Out window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0b19ff36-8bc0-48d0-9f97-cdbd2c5ba895' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Partner Selection (Business Partner Info)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core partner selection attributes. This serves as the main entry point for this record type. Accessed through the Business Partner Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='dc7a0b9e-af93-4034-9936-468dcd7a34bb' AND (Help IS NULL) AND EntityType='D';

-- Partner Orders (Business Partner Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated partner orders details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1908a804-022e-419f-ba0e-192a3eed50fb' AND (Help IS NULL) AND EntityType='D';

-- Partner Shipments (Business Partner Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated partner shipments details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='557f0df5-a005-4723-b9a9-bb09579c4dc7' AND (Help IS NULL) AND EntityType='D';

-- Partner Invoices (Business Partner Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated partner invoices details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8c93f531-0b0a-48f5-b488-fd6dc51f20e1' AND (Help IS NULL) AND EntityType='D';

-- Partner Payments (Business Partner Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated partner payments details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2fdba59c-8442-4567-bfcb-396fbab35278' AND (Help IS NULL) AND EntityType='D';

-- Partner Assets (Business Partner Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated partner assets details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d123a3cd-19b7-4803-b41d-fe6cd3a5dd11' AND (Help IS NULL) AND EntityType='D';

-- Partner Requests (Business Partner Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated partner requests details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0a494581-ac13-4804-8783-e5003b11e0d4' AND (Help IS NULL) AND EntityType='D';

-- LDAP Access (User)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated ldap access details. Records on this tab are linked to the parent entry above. Accessed through the User window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='007758e5-453f-4a48-afac-a4b968e1bb08' AND (Help IS NULL) AND EntityType='D';

-- Discount Break (Discount Schema)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated discount break details. Records on this tab are linked to the parent entry above. Accessed through the Discount Schema window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0399d402-4c5b-43f2-8507-2018e692c1dc' AND (Help IS NULL) AND EntityType='D';

-- Company Agent (Sales Rep Info)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core company agent attributes. This serves as the main entry point for this record type. Accessed through the Sales Rep Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='74c57c73-1f72-4375-a7ed-ae05ad1b34c3' AND (Help IS NULL) AND EntityType='D';

-- Shipment, Receipt (Attribute Set Instance)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated shipment, receipt details. Records on this tab are linked to the parent entry above. Accessed through the Attribute Set Instance window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4c9f9985-68fa-4f25-a989-a0cd83a89fdc' AND (Help IS NULL) AND EntityType='D';

-- LDAP Server Log (LDAP Server)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated ldap server log details. Records on this tab are linked to the parent entry above. Accessed through the LDAP Server window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='26c3911b-fc7c-426f-8410-020132dde896' AND (Help IS NULL) AND EntityType='D';

-- Common Details (Common Package Details)
UPDATE AD_Tab SET Description='Primary data entry for common details records', Help='Use this tab to create and modify the core common details attributes. This serves as the main entry point for this record type. Accessed through the Common Package Details window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='520b31e9-fd1f-4cee-bb24-4b8ffb6b3999' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Request Updates (Request Group)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated request updates details. Records on this tab are linked to the parent entry above. Accessed through the Request Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='25aa2ede-893f-487b-8414-9ec6c9360193' AND (Help IS NULL) AND EntityType='D';

-- Update Notification (Request (all))
UPDATE AD_Tab SET Help='Navigate here to view and edit associated update notification details. Records on this tab are linked to the parent entry above. Accessed through the Request (all) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c3f5e7ac-9a81-4191-b5e7-1da284a50dde' AND (Help IS NULL) AND EntityType='D';

-- Update Notification (Request Type)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated update notification details. Records on this tab are linked to the parent entry above. Accessed through the Request Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e2d014b8-2bb0-41a7-9a0c-b1e8473dac0c' AND (Help IS NULL) AND EntityType='D';

-- Used in Column (Validation Rules)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated used in column details. Records on this tab are linked to the parent entry above. Accessed through the Validation Rules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='11214a01-e54b-432c-aaeb-291b088ddf96' AND (Help IS NULL) AND EntityType='D';

-- POS Payment (POS Payment)
UPDATE AD_Tab SET Description='Primary data entry for pos payment records', Help='Use this tab to create and modify the core pos payment attributes. This serves as the main entry point for this record type. Accessed through the POS Payment window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2df978cb-2c56-43b2-8232-042adcb48fe4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Workflow Node Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related workflow node translation entries for this system translation check', Help='Navigate here to view and edit associated workflow node translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5160bfeb-6ba2-4b08-892a-92ebedb188b6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Web Project (Media Item)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core web project attributes. This serves as the main entry point for this record type. Accessed through the Media Item window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='75c58305-a62b-47b1-9bd9-68d860d6de71' AND (Help IS NULL) AND EntityType='D';

-- Instance (Attribute Set Instance)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core instance attributes. This serves as the main entry point for this record type. Accessed through the Attribute Set Instance window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ee19c769-4496-4fe3-bf8b-6fd42a064bef' AND (Help IS NULL) AND EntityType='D';

-- Movement (Attribute Set Instance)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated movement details. Records on this tab are linked to the parent entry above. Accessed through the Attribute Set Instance window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c1a0e22b-3454-4d62-93bb-f9dc1fabd170' AND (Help IS NULL) AND EntityType='D';

-- Invoice (Attribute Set Instance)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated invoice details. Records on this tab are linked to the parent entry above. Accessed through the Attribute Set Instance window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b33c8bee-1719-4295-8b03-ba3a41ee8b12' AND (Help IS NULL) AND EntityType='D';

-- Assignment (Position)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated assignment details. Records on this tab are linked to the parent entry above. Accessed through the Position window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='46250e05-a797-41f3-b446-c384f17fbafa' AND (Help IS NULL) AND EntityType='D';

-- Remuneration (Position)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated remuneration details. Records on this tab are linked to the parent entry above. Accessed through the Position window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6a44535f-f650-49c3-8bac-fc58c506e2e3' AND (Help IS NULL) AND EntityType='D';

-- Position Category (Position Category)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core position category attributes. This serves as the main entry point for this record type. Accessed through the Position Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ff9dd1ab-28ef-4545-9955-3726053861d6' AND (Help IS NULL) AND EntityType='D';

-- Remuneration (Remuneration)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core remuneration attributes. This serves as the main entry point for this record type. Accessed through the Remuneration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='329eabdb-a544-4d38-a076-514dbf2a343c' AND (Help IS NULL) AND EntityType='D';

-- Daily Balances (Accounting Fact Balances)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core daily balances attributes. This serves as the main entry point for this record type. Accessed through the Accounting Fact Balances window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1ddd74c8-cca7-4dd1-8145-20aaf8fc9c78' AND (Help IS NULL) AND EntityType='D';

-- Order Lines (Sales Rep Info)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated order lines details. Records on this tab are linked to the parent entry above. Accessed through the Sales Rep Info window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e7be56fc-6a35-4e44-a849-de0c1d481a15' AND (Help IS NULL) AND EntityType='D';

-- Known Issue (Known Issue)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core known issue attributes. This serves as the main entry point for this record type. Accessed through the Known Issue window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e8764eb2-0d56-45c2-94eb-e83c4daf226d' AND (Help IS NULL) AND EntityType='D';

-- User Mail (Mail Template)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated user mail details. Records on this tab are linked to the parent entry above. Accessed through the Mail Template window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e55ffd2d-3f3a-41cc-9927-a9b644e16e0a' AND (Help IS NULL) AND EntityType='D';

-- Form Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related form translation entries for this system translation check', Help='Navigate here to view and edit associated form translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d53d6806-558d-4176-8897-bf0ae8420cd1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Task Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related task translation entries for this system translation check', Help='Navigate here to view and edit associated task translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8557b505-7cf6-43e1-be4d-8e853dff8726' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Workflow Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related workflow translation entries for this system translation check', Help='Navigate here to view and edit associated workflow translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bbeba033-6a7d-4e78-89ef-5d5866ffcc66' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Payment Schedule (Invoice Payment Schedule)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated payment schedule details. Records on this tab are linked to the parent entry above. Accessed through the Invoice Payment Schedule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d28302f0-8bf6-4c21-9ca2-31ddd2eb0d84' AND (Help IS NULL) AND EntityType='D';

-- Tab (ASP Modules)
UPDATE AD_Tab SET Description='Related tab entries for this asp modules', Help='Navigate here to view and edit associated tab details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='38c183ce-d09b-46c2-9ea7-fbbd9bff6869' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Issue User (Issue User)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core issue user attributes. This serves as the main entry point for this record type. Accessed through the Issue User window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e84ce725-81a5-4a76-91f9-39df246cb872' AND (Help IS NULL) AND EntityType='D';

-- Issue Project (Issue Project)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core issue project attributes. This serves as the main entry point for this record type. Accessed through the Issue Project window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fbef7946-6d80-43c7-b5e4-56c672a1a262' AND (Help IS NULL) AND EntityType='D';

-- Issue System (Issue System)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core issue system attributes. This serves as the main entry point for this record type. Accessed through the Issue System window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e7f9097a-6416-4a21-aad9-f406a4b41231' AND (Help IS NULL) AND EntityType='D';

-- Update Notification (Request Category)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated update notification details. Records on this tab are linked to the parent entry above. Accessed through the Request Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6c5e83a9-32ef-4384-be68-a1314d6cce57' AND (Help IS NULL) AND EntityType='D';

-- Log (Request Processor)
UPDATE AD_Tab SET Description='Related log entries for this request processor', Help='Navigate here to view and edit associated log details. Records on this tab are linked to the parent entry above. Accessed through the Request Processor window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1899ab9c-f71b-40a8-aba8-d2094d075787' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Parameter Audit (Process Audit)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated parameter audit details. Records on this tab are linked to the parent entry above. Accessed through the Process Audit window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3e2298f0-8cfe-4520-8518-5bd176c8ec7f' AND (Help IS NULL) AND EntityType='D';

-- Log (Process Audit)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated log details. Records on this tab are linked to the parent entry above. Accessed through the Process Audit window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0fa84b5c-6d82-4915-8907-81b52d93bf0e' AND (Help IS NULL) AND EntityType='D';

-- Web Menu (Web POS Menu)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core web menu attributes. This serves as the main entry point for this record type. Accessed through the Web POS Menu window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2fd26f3d-b387-4368-b26e-5e4c9881a805' AND (Help IS NULL) AND EntityType='D';

-- Role Menu (Web POS Role Menu)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core role menu attributes. This serves as the main entry point for this record type. Accessed through the Web POS Role Menu window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='699af376-6966-48fd-aec0-70a6067999f6' AND (Help IS NULL) AND EntityType='D';

-- Web Properties (Web POS Properties)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core web properties attributes. This serves as the main entry point for this record type. Accessed through the Web POS Properties window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c729c257-337a-476a-b1de-4791e94c6259' AND (Help IS NULL) AND EntityType='D';

-- BlackListCheque (Web POS BlackListCheque)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core blacklistcheque attributes. This serves as the main entry point for this record type. Accessed through the Web POS BlackListCheque window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d676e244-7fab-4ed0-8208-505d220629ff' AND (Help IS NULL) AND EntityType='D';

-- Allocations (Payment and Receipt)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated allocations details. Records on this tab are linked to the parent entry above. Accessed through the Payment and Receipt window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='898517c9-dda3-4566-8220-62e8fbd9e95b' AND (Help IS NULL) AND EntityType='D';

-- Change Request (Change Notice)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated change request details. Records on this tab are linked to the parent entry above. Accessed through the Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cd689048-d46a-478f-8b12-f596ea6d1741' AND (Help IS NULL) AND EntityType='D';

-- Requests (source) (Change Notice)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated requests (source) details. Records on this tab are linked to the parent entry above. Accessed through the Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='294dcf7d-b9cb-4839-b1e4-b88ab6d4501b' AND (Help IS NULL) AND EntityType='D';

-- Fixed Change Requests (Change Notice)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated fixed change requests details. Records on this tab are linked to the parent entry above. Accessed through the Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='187aec41-07ee-47e4-bc90-5bdf8d868bfe' AND (Help IS NULL) AND EntityType='D';

-- Requests (source) (BOM Change Notice)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated requests (source) details. Records on this tab are linked to the parent entry above. Accessed through the BOM Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3225904d-39a7-412f-8660-8ee198c5e3fc' AND (Help IS NULL) AND EntityType='D';

-- Change Notice (BOM Change Notice)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core change notice attributes. This serves as the main entry point for this record type. Accessed through the BOM Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='607e5ffa-cfe7-4159-94d3-bc3e74be6094' AND (Help IS NULL) AND EntityType='D';

-- Process (ASP Modules)
UPDATE AD_Tab SET Description='Related process entries for this asp modules', Help='Navigate here to view and edit associated process details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='36dab179-023a-4720-89ad-4ba6a11db398' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Form (ASP Modules)
UPDATE AD_Tab SET Description='Related form entries for this asp modules', Help='Navigate here to view and edit associated form details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f9ea1e8e-b018-4ba2-a156-581790cd653b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Workflow (ASP Modules)
UPDATE AD_Tab SET Description='Related workflow entries for this asp modules', Help='Navigate here to view and edit associated workflow details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='db0c3241-6e66-451e-aac6-a41418b02cca' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Process Parameter (ASP Modules)
UPDATE AD_Tab SET Description='Related process parameter entries for this asp modules', Help='Navigate here to view and edit associated process parameter details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a37e2546-a716-4916-9ae9-9d84acc94da4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Product (Product Planning Data)
UPDATE AD_Tab SET Description='Primary data entry for product records', Help='Use this tab to create and modify the core product attributes. This serves as the main entry point for this record type. Accessed through the Product Planning Data window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='09ec1097-947e-4d0a-ad9a-2b6b21af32b8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Purchasing (Product Planning Data)
UPDATE AD_Tab SET Description='Related purchasing entries for this product planning data', Help='Navigate here to view and edit associated purchasing details. Records on this tab are linked to the parent entry above. Accessed through the Product Planning Data window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4674969c-8b0a-4fb7-8963-86f2e6537aa3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Unprocessed Documents (My Unprocessed Documents)
UPDATE AD_Tab SET Description='Primary data entry for unprocessed documents records', Help='Use this tab to create and modify the core unprocessed documents attributes. This serves as the main entry point for this record type. Accessed through the My Unprocessed Documents window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a82ef1b9-6835-496e-b7ab-445d4e5181ec' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Mail Template)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Mail Template window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='09689bac-c0e4-454a-b17a-aae93a044d0e' AND (Help IS NULL) AND EntityType='D';

-- Storage Provider (Storage Provider)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core storage provider attributes. This serves as the main entry point for this record type. Accessed through the Storage Provider window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fc14e1ae-e9b0-40ad-b9f0-d6b7c179762e' AND (Help IS NULL) AND EntityType='D';

-- Depreciation Schedules (Depreciation Tables)
UPDATE AD_Tab SET Description='Primary data entry for depreciation schedules records', Help='Use this tab to create and modify the core depreciation schedules attributes. This serves as the main entry point for this record type. Accessed through the Depreciation Tables window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c9832fd6-70bb-4ef2-a406-88ba4e266f53' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Depreciation Schedule Details (Depreciation Tables)
UPDATE AD_Tab SET Description='Related depreciation schedule details entries for this depreciation tables', Help='Navigate here to view and edit associated depreciation schedule details details. Records on this tab are linked to the parent entry above. Accessed through the Depreciation Tables window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4341f446-aef3-4464-bec1-58290ae691d6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Maintain Index (Asset Revaluation Index)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core maintain index attributes. This serves as the main entry point for this record type. Accessed through the Asset Revaluation Index window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cbba1be3-91bf-4cc9-89fa-67bab42da178' AND (Help IS NULL) AND EntityType='D';

-- Step1 Select an Asset (Asset Split)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core step1 select an asset attributes. This serves as the main entry point for this record type. Accessed through the Asset Split window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='39d442ad-185d-43b3-9a57-3425cf74b0ee' AND (Help IS NULL) AND EntityType='D';

-- Step2 Select the Balance (Asset Split)
UPDATE AD_Tab SET Description='Related step2 select the balance entries for this asset split', Help='Navigate here to view and edit associated step2 select the balance details. Records on this tab are linked to the parent entry above. Accessed through the Asset Split window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c5668460-0267-4f8d-bc55-79fc73865dc5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Step2 Select Accounting Setup (Asset Transfers)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated step2 select accounting setup details. Records on this tab are linked to the parent entry above. Accessed through the Asset Transfers window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a7c7159c-8f97-4db1-868a-c3a8a09f9e58' AND (Help IS NULL) AND EntityType='D';

-- Charge Type by Doc Type (Charge Type)
UPDATE AD_Tab SET Description='Related charge type by doc type entries for this charge type', Help='Navigate here to view and edit associated charge type by doc type details. Records on this tab are linked to the parent entry above. Accessed through the Charge Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7d07bb24-c775-4f17-a20f-b531152786ee' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Setup Conventions (Depreciation First Year Conventions )
UPDATE AD_Tab SET Help='Use this tab to create and modify the core setup conventions attributes. This serves as the main entry point for this record type. Accessed through the Depreciation First Year Conventions  window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='be3be71d-75b6-4c3d-8a7e-b62e3a499720' AND (Help IS NULL) AND EntityType='D';

-- Unprocessed Documents (Unprocessed Documents (All))
UPDATE AD_Tab SET Description='Primary data entry for unprocessed documents records', Help='Use this tab to create and modify the core unprocessed documents attributes. This serves as the main entry point for this record type. Accessed through the Unprocessed Documents (All) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3917b42a-d221-49b0-941f-62c006af5679' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tax Provider (Tax Provider)
UPDATE AD_Tab SET Description='Primary data entry for tax provider records', Help='Use this tab to create and modify the core tax provider attributes. This serves as the main entry point for this record type. Accessed through the Tax Provider window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d7c5527f-ef8f-4c2b-b7c2-e245285bba45' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Step1 Select Asset (Asset Transfers)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core step1 select asset attributes. This serves as the main entry point for this record type. Accessed through the Asset Transfers window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d7212eb6-8164-4646-b8ec-59770597b20e' AND (Help IS NULL) AND EntityType='D';

-- Translation (Price List)
UPDATE AD_Tab SET Description='Related translation entries for this price list', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Price List window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='93afc34d-b69d-4cdb-b9f0-a2761ed7437d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Change Notice (Change Notice)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core change notice attributes. This serves as the main entry point for this record type. Accessed through the Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fde2bd34-2f50-4e0f-ba9d-75ae61139daf' AND (Help IS NULL) AND EntityType='D';

-- Included Lines (Expense Invoice (Alpha))
UPDATE AD_Tab SET Description='Related included lines entries for this expense invoice (alpha)', Help='Navigate here to view and edit associated included lines details. Records on this tab are linked to the parent entry above. Accessed through the Expense Invoice (Alpha) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='69cd0851-7c57-486c-b4b7-4e6dfde97022' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Order Source (Order Source)
UPDATE AD_Tab SET Description='Primary data entry for order source records', Help='Use this tab to create and modify the core order source attributes. This serves as the main entry point for this record type. Accessed through the Order Source window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='09d3ab83-88e3-478f-b593-436800cdad60' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Relation Type (Relation Type)
UPDATE AD_Tab SET Description='Primary data entry for relation type records', Help='Use this tab to create and modify the core relation type attributes. This serves as the main entry point for this record type. Accessed through the Relation Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='42817ab8-6b7f-469a-97f4-97c76b9b5017' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Product Price Break (Price List)
UPDATE AD_Tab SET Description='Related product price break entries for this price list', Help='Navigate here to view and edit associated product price break details. Records on this tab are linked to the parent entry above. Accessed through the Price List window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0c682317-1b31-4c39-9189-6272c370cd46' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Period Spread Type (Depreciation Period Spread Type)
UPDATE AD_Tab SET Description='Primary data entry for period spread type records', Help='Use this tab to create and modify the core period spread type attributes. This serves as the main entry point for this record type. Accessed through the Depreciation Period Spread Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c63ff415-64fe-4148-8677-75662b917b76' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Included roles (Role)
UPDATE AD_Tab SET Description='Related included roles entries for this role', Help='Navigate here to view and edit associated included roles details. Records on this tab are linked to the parent entry above. Accessed through the Role window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='09e2e699-d2a4-4bee-a56d-e1dedb3a69a9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Product (Quality Test)
UPDATE AD_Tab SET Description='Related product entries for this quality test', Help='Navigate here to view and edit associated product details. Records on this tab are linked to the parent entry above. Accessed through the Quality Test window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='93387805-3a24-4c13-af43-72a7356e0930' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Packaging (Shipping Processor Configuration)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated packaging details. Records on this tab are linked to the parent entry above. Accessed through the Shipping Processor Configuration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1e006539-8026-4f5d-9355-8f2b6cae44e2' AND (Help IS NULL) AND EntityType='D';

-- Batch (Payments into Batch)
UPDATE AD_Tab SET Description='Primary data entry for batch records', Help='Use this tab to create and modify the core batch attributes. This serves as the main entry point for this record type. Accessed through the Payments into Batch window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b2b0e8f8-0bbb-47b5-8dce-1accf43ad27c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Pickup Types (Shipper)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated pickup types details. Records on this tab are linked to the parent entry above. Accessed through the Shipper window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='31008f0f-f2d8-4ac6-a5b6-ab41506b4f4c' AND (Help IS NULL) AND EntityType='D';

-- Type (Asset Type)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core type attributes. This serves as the main entry point for this record type. Accessed through the Asset Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='329793b0-2b48-44bd-9434-4f1da74b0ad8' AND (Help IS NULL) AND EntityType='D';

-- Country Group (Country Group)
UPDATE AD_Tab SET Description='Primary data entry for country group records', Help='Use this tab to create and modify the core country group attributes. This serves as the main entry point for this record type. Accessed through the Country Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c694c2c6-c442-4c9d-82f9-44859442620a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Reconciliation (Fact Reconciliation)
UPDATE AD_Tab SET Description='Primary data entry for reconciliation records', Help='Use this tab to create and modify the core reconciliation attributes. This serves as the main entry point for this record type. Accessed through the Fact Reconciliation window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='813f65d3-33e0-4996-8716-7b7f3c8ab9e3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Pickup Types (Shipping Processor Configuration)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated pickup types details. Records on this tab are linked to the parent entry above. Accessed through the Shipping Processor Configuration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3b19d6b5-8d3b-4b39-923c-ae26944a689c' AND (Help IS NULL) AND EntityType='D';

-- Schedule (Schedule)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core schedule attributes. This serves as the main entry point for this record type. Accessed through the Schedule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='06dc0531-48ba-42cf-8c50-d4fbb44928fc' AND (Help IS NULL) AND EntityType='D';

-- Payment Processor (Payment Processor)
UPDATE AD_Tab SET Description='Primary data entry for payment processor records', Help='Use this tab to create and modify the core payment processor attributes. This serves as the main entry point for this record type. Accessed through the Payment Processor window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2929b7ec-62c4-46d9-a7cc-59728070eb40' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Broadcast Message)
UPDATE AD_Tab SET Description='Related translation entries for this broadcast message', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Broadcast Message window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e767052e-480f-4c9d-b9a0-73395fcb8ce8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Fixed Change Requests (BOM Change Notice)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated fixed change requests details. Records on this tab are linked to the parent entry above. Accessed through the BOM Change Notice window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5ae610cd-fa94-4b99-85ac-f993a9101eff' AND (Help IS NULL) AND EntityType='D';

-- Part (Parts and BOMs)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core part attributes. This serves as the main entry point for this record type. Accessed through the Parts and BOMs window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f30d9e5b-a2f4-4259-a819-680ddcf2aa33' AND (Help IS NULL) AND EntityType='D';

-- Schedule (Payment Term)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated schedule details. Records on this tab are linked to the parent entry above. Accessed through the Payment Term window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b0e85991-018d-4618-8afe-93afcd233312' AND (Help IS NULL) AND EntityType='D';

-- Bank Account Processor (Bank/Cash)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated bank account processor details. Records on this tab are linked to the parent entry above. Accessed through the Bank/Cash window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f0709010-509c-4a1f-8773-68cbeefd0f04' AND (Help IS NULL) AND EntityType='D';

-- Generator Source (GL Journal Generator)
UPDATE AD_Tab SET Description='Related generator source entries for this gl journal generator', Help='Navigate here to view and edit associated generator source details. Records on this tab are linked to the parent entry above. Accessed through the GL Journal Generator window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='30d7b4da-8e61-4d22-9038-a26a27dab00e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Product (Asset)
UPDATE AD_Tab SET Description='Related product entries for this asset', Help='Navigate here to view and edit associated product details. Records on this tab are linked to the parent entry above. Accessed through the Asset window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9a599cee-85ca-45e5-a3d0-6c51a45bc83e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- QC Test (Production (Single Product))
UPDATE AD_Tab SET Description='Related qc test entries for this production (single product)', Help='Navigate here to view and edit associated qc test details. Records on this tab are linked to the parent entry above. Accessed through the Production (Single Product) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1b80c9c3-9773-4138-870c-96487f25bdc8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Records (Post Depreciation Entry)
UPDATE AD_Tab SET Description='Related records entries for this post depreciation entry', Help='Navigate here to view and edit associated records details. Records on this tab are linked to the parent entry above. Accessed through the Post Depreciation Entry window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d4623147-7c29-4e47-aa67-b83ed6a429dc' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Group Account (Asset Group)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated group account details. Records on this tab are linked to the parent entry above. Accessed through the Asset Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ded55933-8e1f-4c76-b9dc-7b38a63e4ead' AND (Help IS NULL) AND EntityType='D';

-- Cost Details (Product Costs)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated cost details details. Records on this tab are linked to the parent entry above. Accessed through the Product Costs window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3fe0f62b-0b69-41d5-adf0-3a9955026b22' AND (Help IS NULL) AND EntityType='D';

-- Sequence No (Document Sequence)
UPDATE AD_Tab SET Description='Related sequence no entries for this document sequence', Help='Navigate here to view and edit associated sequence no details. Records on this tab are linked to the parent entry above. Accessed through the Document Sequence window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9e96ed74-f655-4530-85a0-3e0098c1e0d7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Package Installation Log (Package Maintenance)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core package installation log attributes. This serves as the main entry point for this record type. Accessed through the Package Maintenance window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='97ae8d48-66ae-4925-a1e9-a62cb397956a' AND (Help IS NULL) AND EntityType='D';

-- Ref List (ASP Modules)
UPDATE AD_Tab SET Description='Related ref list entries for this asp modules', Help='Navigate here to view and edit associated ref list details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8a54e851-1731-4b8a-9e11-503f15f26aab' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Field (ASP Modules)
UPDATE AD_Tab SET Description='Related field entries for this asp modules', Help='Navigate here to view and edit associated field details. Records on this tab are linked to the parent entry above. Accessed through the ASP Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f44a86f2-791c-4f6c-9f85-9c3285a624d0' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Toolbar Button (Window, Tab and Field)
UPDATE AD_Tab SET Description='Related toolbar button entries for this window, tab and field', Help='Navigate here to view and edit associated toolbar button details. Records on this tab are linked to the parent entry above. Accessed through the Window, Tab and Field window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b67bbfa7-d919-431f-88e0-74bf410c321d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Package Lines (Shipment Package)
UPDATE AD_Tab SET Description='Related package lines entries for this shipment package', Help='Navigate here to view and edit associated package lines details. Records on this tab are linked to the parent entry above. Accessed through the Shipment Package window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='36a84c12-06b2-48fc-98c5-8264d7db0d01' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MPS Lines (Shipment Package)
UPDATE AD_Tab SET Description='Related mps lines entries for this shipment package', Help='Navigate here to view and edit associated mps lines details. Records on this tab are linked to the parent entry above. Accessed through the Shipment Package window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0675501f-ec04-4cdc-85c7-15d7c06ba1dc' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Online Transaction History (Online Transaction History)
UPDATE AD_Tab SET Description='Primary data entry for online transaction history records', Help='Use this tab to create and modify the core online transaction history attributes. This serves as the main entry point for this record type. Accessed through the Online Transaction History window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b7706902-4acf-42d0-a6f8-20e2c870d918' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Payment Transaction (Payment Transaction)
UPDATE AD_Tab SET Description='Primary data entry for payment transaction records', Help='Use this tab to create and modify the core payment transaction attributes. This serves as the main entry point for this record type. Accessed through the Payment Transaction window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e11fd05b-4ab2-43b8-8eae-790025de843e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Storage (Warehouse and Locators)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated storage details. Records on this tab are linked to the parent entry above. Accessed through the Warehouse and Locators window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8db18ef3-f00c-4508-b0e4-3e7819f99da5' AND (Help IS NULL) AND EntityType='D';

-- Located at (Product)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated located at details. Records on this tab are linked to the parent entry above. Accessed through the Product window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ea7b01c3-ed42-4487-9639-bb1b8b65b759' AND (Help IS NULL) AND EntityType='D';

-- Used in Column (Reference)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated used in column details. Records on this tab are linked to the parent entry above. Accessed through the Reference window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c6336721-cf48-4705-a2ab-527665ebc569' AND (Help IS NULL) AND EntityType='D';

-- MPS Lines (Shipment (Customer))
UPDATE AD_Tab SET Description='Related mps lines entries for this shipment (customer)', Help='Navigate here to view and edit associated mps lines details. Records on this tab are linked to the parent entry above. Accessed through the Shipment (Customer) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='03798730-8777-46ce-9003-6ca11765ffa4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Package Lines (Shipment (Customer))
UPDATE AD_Tab SET Description='Related package lines entries for this shipment (customer)', Help='Navigate here to view and edit associated package lines details. Records on this tab are linked to the parent entry above. Accessed through the Shipment (Customer) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='801eb320-77f3-4217-ad5f-7e80bc0d29d1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Commodity Shipment (Commodity Shipment)
UPDATE AD_Tab SET Description='Primary data entry for commodity shipment records', Help='Use this tab to create and modify the core commodity shipment attributes. This serves as the main entry point for this record type. Accessed through the Commodity Shipment window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a54db666-2b43-414f-95b0-d4cf5dcff554' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Packaging (Shipper)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated packaging details. Records on this tab are linked to the parent entry above. Accessed through the Shipper window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='aa542d87-95d4-4236-9206-5e087e2ea79b' AND (Help IS NULL) AND EntityType='D';

-- Message Log (Broadcast Message)
UPDATE AD_Tab SET Description='Related message log entries for this broadcast message', Help='Navigate here to view and edit associated message log details. Records on this tab are linked to the parent entry above. Accessed through the Broadcast Message window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='de8b3fac-7476-43df-964e-4ea4ad3f2947' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Shipping Accounts (Business Partner)
UPDATE AD_Tab SET Description='Related shipping accounts entries for this business partner', Help='Navigate here to view and edit associated shipping accounts details. Records on this tab are linked to the parent entry above. Accessed through the Business Partner window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ca286fea-b45a-43f6-b4c1-73d8b89657dd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Packaging (Shipper Configuration)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated packaging details. Records on this tab are linked to the parent entry above. Accessed through the Shipper Configuration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4533f2b2-6f52-406d-9566-8a31fac0a55c' AND (Help IS NULL) AND EntityType='D';

-- Pickup Types (Shipper Configuration)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated pickup types details. Records on this tab are linked to the parent entry above. Accessed through the Shipper Configuration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3e5759ed-59bf-49f0-9723-0adf87d71b35' AND (Help IS NULL) AND EntityType='D';

-- Shipping Transaction (Shipping Transaction)
UPDATE AD_Tab SET Description='Primary data entry for shipping transaction records', Help='Use this tab to create and modify the core shipping transaction attributes. This serves as the main entry point for this record type. Accessed through the Shipping Transaction window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a1bba238-7770-45e3-a53c-206b4c0806d2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Shipping Transaction Line (Shipping Transaction)
UPDATE AD_Tab SET Description='Related shipping transaction line entries for this shipping transaction', Help='Navigate here to view and edit associated shipping transaction line details. Records on this tab are linked to the parent entry above. Accessed through the Shipping Transaction window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='141f3fab-02bd-4768-8ad2-9c19efd61190' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Info Access (Role)
UPDATE AD_Tab SET Description='Related info access entries for this role', Help='Navigate here to view and edit associated info access details. Records on this tab are linked to the parent entry above. Accessed through the Role window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='56ad707e-3224-4705-93b6-e890862d6836' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Web Service Method (Web Service Definition)
UPDATE AD_Tab SET Description='Related web service method entries for this web service definition', Help='Navigate here to view and edit associated web service method details. Records on this tab are linked to the parent entry above. Accessed through the Web Service Definition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3785dc7a-d157-4d82-a52a-52d237d5567b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Country Region and City)
UPDATE AD_Tab SET Description='Related translation entries for this country region and city', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Country Region and City window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a45ba9d9-ecf6-40ce-873a-99e63a42bc34' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Currency)
UPDATE AD_Tab SET Description='Related translation entries for this currency', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Currency window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5d2ef13f-97ba-4e83-b6fc-0f91dd6c19d2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Used in Field (Field Group)
UPDATE AD_Tab SET Description='Related used in field entries for this field group', Help='Navigate here to view and edit associated used in field details. Records on this tab are linked to the parent entry above. Accessed through the Field Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ca67b2fa-1cd1-46f7-9996-4f92fcf9f6dc' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Step1 Select an Asset (Asset Disposal2)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core step1 select an asset attributes. This serves as the main entry point for this record type. Accessed through the Asset Disposal2 window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7f5e53e2-7c81-4d99-819e-5b832c8bd7cc' AND (Help IS NULL) AND EntityType='D';

-- Step3 Select Accounting (Asset Split)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated step3 select accounting details. Records on this tab are linked to the parent entry above. Accessed through the Asset Split window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='54fcd07d-c271-4a9a-af8d-f3bde44dc1a1' AND (Help IS NULL) AND EntityType='D';

-- Define Depreciation Method (Depreciation Calculation Method)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core define depreciation method attributes. This serves as the main entry point for this record type. Accessed through the Depreciation Calculation Method window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='abe61075-94ee-4585-a181-8c71a5c91d48' AND (Help IS NULL) AND EntityType='D';

-- Depreciation Functions (Depreciation Methods)
UPDATE AD_Tab SET Description='Primary data entry for depreciation functions records', Help='Use this tab to create and modify the core depreciation functions attributes. This serves as the main entry point for this record type. Accessed through the Depreciation Methods window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='46dadd9a-efed-40ab-8770-b96cf447630a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Customer (Expenses (to be invoiced))
UPDATE AD_Tab SET Help='Use this tab to create and modify the core customer attributes. This serves as the main entry point for this record type. Accessed through the Expenses (to be invoiced) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a43bb29a-400f-49bf-9b65-be622b5be487' AND (Help IS NULL) AND EntityType='D';

-- Web Service (Web Service Definition)
UPDATE AD_Tab SET Description='Primary data entry for web service records', Help='Use this tab to create and modify the core web service attributes. This serves as the main entry point for this record type. Accessed through the Web Service Definition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='06d30678-94b4-4957-bd4b-813e2f1f2e87' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Matching (Purchase Order)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated matching details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Order window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5a694045-e375-43d8-ba45-ab6e2bc4ea97' AND (Help IS NULL) AND EntityType='D';

-- Index Column (Table and Column)
UPDATE AD_Tab SET Description='Related index column entries for this table and column', Help='Navigate here to view and edit associated index column details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='43eb960b-f992-42b5-9463-8a658cc387ab' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Zoom Condition (Table and Column)
UPDATE AD_Tab SET Description='Related zoom condition entries for this table and column', Help='Navigate here to view and edit associated zoom condition details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a0a70dd0-c734-480f-8747-f214b664434f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Cost Movement (Product Costs)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated cost movement details. Records on this tab are linked to the parent entry above. Accessed through the Product Costs window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='834474e3-50d5-41d4-a707-ca6363f19427' AND (Help IS NULL) AND EntityType='D';

-- Preference (Dashboard Preference)
UPDATE AD_Tab SET Description='Primary data entry for preference records', Help='Use this tab to create and modify the core preference attributes. This serves as the main entry point for this record type. Accessed through the Dashboard Preference window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8913e23b-efab-4d76-8c16-cf020ad5f47b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Matched Receipts (Purchase Invoice and Credit/Debit Note)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated matched receipts details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Invoice and Credit/Debit Note window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4ff51a8c-a919-4925-97cc-9021821a92c8' AND (Help IS NULL) AND EntityType='D';

-- Matched POs (Purchase Invoice and Credit/Debit Note)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated matched pos details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Invoice and Credit/Debit Note window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='105e4f1a-7d25-40eb-b00b-30004cf8aac7' AND (Help IS NULL) AND EntityType='D';

-- Web Service Access (Web Service Security)
UPDATE AD_Tab SET Description='Related web service access entries for this web service security', Help='Navigate here to view and edit associated web service access details. Records on this tab are linked to the parent entry above. Accessed through the Web Service Security window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='21a4440d-067c-45cc-bfef-16ff2e272ce7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- LDAP Access (Interest Area)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated ldap access details. Records on this tab are linked to the parent entry above. Accessed through the Interest Area window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3bfe5404-c2ac-4e6c-93f2-b2befeb451a3' AND (Help IS NULL) AND EntityType='D';

-- Queries (User)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated queries details. Records on this tab are linked to the parent entry above. Accessed through the User window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e4e21dc4-c42d-45df-b81c-490d68631e31' AND (Help IS NULL) AND EntityType='D';

-- Requisition Lines (Purchase Order)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated requisition lines details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Order window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9e8f2dbe-b121-4a38-afd3-713d5f9fd352' AND (Help IS NULL) AND EntityType='D';

-- Allocation (Sales Invoice and Credit/Debit Note)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated allocation details. Records on this tab are linked to the parent entry above. Accessed through the Sales Invoice and Credit/Debit Note window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2f31706e-40a7-4747-9eea-2750a11d77c7' AND (Help IS NULL) AND EntityType='D';

-- Matched POs (Material Receipt)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated matched pos details. Records on this tab are linked to the parent entry above. Accessed through the Material Receipt window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='134ce53d-3daf-4abf-89d2-6a986e4c9fd6' AND (Help IS NULL) AND EntityType='D';

-- Matched Invoices (Material Receipt)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated matched invoices details. Records on this tab are linked to the parent entry above. Accessed through the Material Receipt window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='06222c96-eaca-41fc-91ee-62d7569d5697' AND (Help IS NULL) AND EntityType='D';

-- Matched POs (Customer Return)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated matched pos details. Records on this tab are linked to the parent entry above. Accessed through the Customer Return window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='32604ba8-b2e2-4843-92fd-a1f132b1fc74' AND (Help IS NULL) AND EntityType='D';

-- Allocation (Purchase Invoice and Credit/Debit Note)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated allocation details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Invoice and Credit/Debit Note window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='531ee977-135a-4624-bd6e-c932b454bb05' AND (Help IS NULL) AND EntityType='D';

-- Objects Installed (Package Maintenance)
UPDATE AD_Tab SET Description='Related objects installed entries for this package maintenance', Help='Navigate here to view and edit associated objects installed details. Records on this tab are linked to the parent entry above. Accessed through the Package Maintenance window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e68da3d7-f6ac-4a29-9f02-20d060189ee2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Country (Country Group)
UPDATE AD_Tab SET Description='Related country entries for this country group', Help='Navigate here to view and edit associated country details. Records on this tab are linked to the parent entry above. Accessed through the Country Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d987304b-12d1-484b-bcc2-49bb3bf8e94e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Template (Import Template)
UPDATE AD_Tab SET Description='Primary data entry for import template records', Help='Use this tab to create and modify the core import template attributes. This serves as the main entry point for this record type. Accessed through the Import Template window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3159d841-8fa1-4337-a546-a4d3bfafc4b4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Estimated Landed Cost (Purchase Order)
UPDATE AD_Tab SET Description='Related estimated landed cost entries for this purchase order', Help='Navigate here to view and edit associated estimated landed cost details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Order window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='92141899-a52e-4902-bf11-fae2907fd747' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Estimated Landed Cost Allocation (Purchase Order)
UPDATE AD_Tab SET Description='Related estimated landed cost allocation entries for this purchase order', Help='Navigate here to view and edit associated estimated landed cost allocation details. Records on this tab are linked to the parent entry above. Accessed through the Purchase Order window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d91b0ef9-ff2a-4836-b9d8-7ea8ccb7c40c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tax Provider Configuration (Tax Provider Configuration)
UPDATE AD_Tab SET Description='Primary data entry for tax provider configuration records', Help='Use this tab to create and modify the core tax provider configuration attributes. This serves as the main entry point for this record type. Accessed through the Tax Provider Configuration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='df2892cf-66eb-465e-91d8-c146c8a45ce5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Chart (Chart)
UPDATE AD_Tab SET Description='Primary data entry for chart records', Help='Use this tab to create and modify the core chart attributes. This serves as the main entry point for this record type. Accessed through the Chart window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='061d2441-a3ff-4c96-8458-2432d60bd2da' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- View Column (Table and Column)
UPDATE AD_Tab SET Description='Related view column entries for this table and column', Help='Navigate here to view and edit associated view column details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6266242f-3394-4b97-9366-f7215b259c74' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Used in Info Column (Element)
UPDATE AD_Tab SET Description='Related used in info column entries for this element', Help='Navigate here to view and edit associated used in info column details. Records on this tab are linked to the parent entry above. Accessed through the Element window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9bad0b5e-9dc9-421f-9156-c6ee736f6f46' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Status Line (Status Line)
UPDATE AD_Tab SET Description='Primary data entry for status line records', Help='Use this tab to create and modify the core status line attributes. This serves as the main entry point for this record type. Accessed through the Status Line window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0cd0bd95-f7c8-44a8-b8af-0a06c3c198d2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Used In (Status Line)
UPDATE AD_Tab SET Description='Related used in entries for this status line', Help='Navigate here to view and edit associated used in details. Records on this tab are linked to the parent entry above. Accessed through the Status Line window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c48e09b9-ca7a-4734-8385-da33d75f9b2b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Available Columns (Report View)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated available columns details. Records on this tab are linked to the parent entry above. Accessed through the Report View window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4776b336-7794-48c0-96ec-9a3eed2f8143' AND (Help IS NULL) AND EntityType='D';

-- Related Info Window (Info Window)
UPDATE AD_Tab SET Description='Related related info window entries for this info window', Help='Navigate here to view and edit associated related info window details. Records on this tab are linked to the parent entry above. Accessed through the Info Window window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='773e0bd5-8a1a-4697-9a6a-edb8c380d24d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Production (Production (Single Product))
UPDATE AD_Tab SET Description='Primary data entry for production records', Help='Use this tab to create and modify the core production attributes. This serves as the main entry point for this record type. Accessed through the Production (Single Product) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bae1dc79-bd36-4935-954d-9378114c3bdd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Country Group)
UPDATE AD_Tab SET Description='Related translation entries for this country group', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Country Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7dc48a85-da2d-4fad-b05f-2b5ba0fbee94' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (GL Category)
UPDATE AD_Tab SET Description='Related translation entries for this gl category', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the GL Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a3ed1762-3d79-484f-b74e-6324739ddb4f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Marketing Campaign)
UPDATE AD_Tab SET Description='Related translation entries for this marketing campaign', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Marketing Campaign window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6c2a0f70-81f5-41cf-8036-2b94e724f706' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Sales Region)
UPDATE AD_Tab SET Description='Related translation entries for this sales region', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Sales Region window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e54f0037-c27f-4197-9080-a0182ab0e6bb' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Country Region and City)
UPDATE AD_Tab SET Description='Related translation entries for this country region and city', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Country Region and City window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ea1090a1-7e04-49e8-b165-b93f1f32b323' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Price List)
UPDATE AD_Tab SET Description='Related translation entries for this price list', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Price List window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c735747e-6b24-401d-9c70-f3a23036391a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Print Color)
UPDATE AD_Tab SET Description='Related translation entries for this print color', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Print Color window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0e4d0c6c-c476-4652-a102-2ed60189470c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Country Group (Country Region and City)
UPDATE AD_Tab SET Description='Related country group entries for this country region and city', Help='Navigate here to view and edit associated country group details. Records on this tab are linked to the parent entry above. Accessed through the Country Region and City window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fcd8431f-3d9a-4097-a91a-55ef9c54ee2a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Process (Info Window)
UPDATE AD_Tab SET Description='Related process entries for this info window', Help='Navigate here to view and edit associated process details. Records on this tab are linked to the parent entry above. Accessed through the Info Window window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2a39f93a-2062-404a-8e28-19fc45982162' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Role Access (Info Window)
UPDATE AD_Tab SET Description='Related role access entries for this info window', Help='Navigate here to view and edit associated role access details. Records on this tab are linked to the parent entry above. Accessed through the Info Window window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d7868d02-46bc-4112-af34-35df9e13a79f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Matched Invoices (Customer Return)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated matched invoices details. Records on this tab are linked to the parent entry above. Accessed through the Customer Return window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c06484bf-2db8-4ff2-8a3a-48c3b630fc0d' AND (Help IS NULL) AND EntityType='D';

-- Attributes (Return to Vendor)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Return to Vendor window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6f5f0c25-0962-4341-876e-94d8814cfe30' AND (Help IS NULL) AND EntityType='D';

-- Recurring Group (Recurring Group)
UPDATE AD_Tab SET Description='Primary data entry for recurring group records', Help='Use this tab to create and modify the core recurring group attributes. This serves as the main entry point for this record type. Accessed through the Recurring Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0753afa4-468a-442e-823a-b3888c06e364' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Import Template Access (Import Template)
UPDATE AD_Tab SET Description='Related import template access entries for this import template', Help='Navigate here to view and edit associated import template access details. Records on this tab are linked to the parent entry above. Accessed through the Import Template window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fa6ec748-a733-4ab9-94a6-eb7c388fbb69' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Locator Type (Locator Type)
UPDATE AD_Tab SET Description='Primary data entry for locator type records', Help='Use this tab to create and modify the core locator type attributes. This serves as the main entry point for this record type. Accessed through the Locator Type window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='388b0f0c-ece2-4809-96d6-4d486d3e7b5d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- CSS Style (CSS Style)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core css style attributes. This serves as the main entry point for this record type. Accessed through the CSS Style window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6bab9a1b-d3d3-48ca-8fab-b1846bfe769b' AND (Help IS NULL) AND EntityType='D';

-- Style Line (CSS Style)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated style line details. Records on this tab are linked to the parent entry above. Accessed through the CSS Style window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f8aec122-5e12-4e5b-a03b-fff56904ee27' AND (Help IS NULL) AND EntityType='D';

-- Menu entries (Menu favourites)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core menu entries attributes. This serves as the main entry point for this record type. Accessed through the Menu favourites window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='aca32c5d-0142-42f5-809a-770e152efa85' AND (Help IS NULL) AND EntityType='D';

-- Document Status Indicator (Document Status)
UPDATE AD_Tab SET Description='Primary data entry for document status indicator records', Help='Use this tab to create and modify the core document status indicator attributes. This serves as the main entry point for this record type. Accessed through the Document Status window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f8bf9ee8-5766-4360-a841-a3f7e04385c9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Approver (Workflow Activities (all))
UPDATE AD_Tab SET Description='Related approver entries for this workflow activities (all)', Help='Navigate here to view and edit associated approver details. Records on this tab are linked to the parent entry above. Accessed through the Workflow Activities (all) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4c965421-0c87-4703-b433-243991bd1628' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Approver (Workflow Process)
UPDATE AD_Tab SET Description='Related approver entries for this workflow process', Help='Navigate here to view and edit associated approver details. Records on this tab are linked to the parent entry above. Accessed through the Workflow Process window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='805402e4-3226-4e52-9926-0217c1af2c4c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Suggestions (Field Suggestions)
UPDATE AD_Tab SET Description='Primary data entry for suggestions records', Help='Use this tab to create and modify the core suggestions attributes. This serves as the main entry point for this record type. Accessed through the Field Suggestions window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d5a42b15-e903-48cd-b3b5-09a2b4126134' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Post-it (Post-it)
UPDATE AD_Tab SET Description='Primary data entry for post-it records', Help='Use this tab to create and modify the core post-it attributes. This serves as the main entry point for this record type. Accessed through the Post-it window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='715973a5-5d22-4d36-8241-6ff369cac595' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- User (All Tenants)
UPDATE AD_Tab SET Description='Related user entries for this all tenants', Help='Navigate here to view and edit associated user details. Records on this tab are linked to the parent entry above. Accessed through the All Tenants window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6ad09983-2dd4-4c30-8314-c6a83c5bbaed' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- User (All Users)
UPDATE AD_Tab SET Description='Primary data entry for user records', Help='Use this tab to create and modify the core user attributes. This serves as the main entry point for this record type. Accessed through the All Users window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='27ce3e6e-7387-44db-89fc-605b989847ac' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- View Component (Table and Column)
UPDATE AD_Tab SET Description='Related view component entries for this table and column', Help='Navigate here to view and edit associated view component details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d7a184b5-75e6-416e-a20e-ed741b94d0ed' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Role (All Roles)
UPDATE AD_Tab SET Description='Primary data entry for role records', Help='Use this tab to create and modify the core role attributes. This serves as the main entry point for this record type. Accessed through the All Roles window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2db530bc-a013-4a84-b7b4-0ee2c9636720' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Role (All Tenants)
UPDATE AD_Tab SET Description='Related role entries for this all tenants', Help='Navigate here to view and edit associated role details. Records on this tab are linked to the parent entry above. Accessed through the All Tenants window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='32d8aefe-8404-49dc-b22a-e403b7a5d2e3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- User Roles (All Roles)
UPDATE AD_Tab SET Description='Related user roles entries for this all roles', Help='Navigate here to view and edit associated user roles details. Records on this tab are linked to the parent entry above. Accessed through the All Roles window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='13043fff-ebde-4ebd-bbb6-bc2af55528f2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Suggestion (Context Help Suggestion)
UPDATE AD_Tab SET Description='Primary data entry for suggestion records', Help='Use this tab to create and modify the core suggestion attributes. This serves as the main entry point for this record type. Accessed through the Context Help Suggestion window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='335fe0e0-5044-4262-9e4b-0fdfe35a38fd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translate (Print Format)
UPDATE AD_Tab SET Description='Related translate entries for this print format', Help='Navigate here to view and edit associated translate details. Records on this tab are linked to the parent entry above. Accessed through the Print Format window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3c39505a-e38d-495d-aa7e-ce50e02e4208' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (System Color)
UPDATE AD_Tab SET Description='Related translation entries for this system color', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the System Color window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='98b2feb1-0a37-43a6-942a-56f67b9df925' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tenant (All Tenants)
UPDATE AD_Tab SET Description='Primary data entry for tenant records', Help='Use this tab to create and modify the core tenant attributes. This serves as the main entry point for this record type. Accessed through the All Tenants window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4c54be9c-5edf-4df9-a759-1c60cd850987' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Service (Revenue Recognition)
UPDATE AD_Tab SET Description='Related service entries for this revenue recognition', Help='Navigate here to view and edit associated service details. Records on this tab are linked to the parent entry above. Accessed through the Revenue Recognition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1318769d-126e-4dff-845a-91986295d34f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Revenue Recognition Run (Revenue Recognition)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated revenue recognition run details. Records on this tab are linked to the parent entry above. Accessed through the Revenue Recognition window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='33d0044a-4c92-4a82-bb67-6cce65d5a337' AND (Help IS NULL) AND EntityType='D';

-- User Roles (All Users)
UPDATE AD_Tab SET Description='Related user roles entries for this all users', Help='Navigate here to view and edit associated user roles details. Records on this tab are linked to the parent entry above. Accessed through the All Users window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='64c6056d-6c46-46e1-8bfc-d217bd64da19' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- User Roles (All User Roles)
UPDATE AD_Tab SET Description='Primary data entry for user roles records', Help='Use this tab to create and modify the core user roles attributes. This serves as the main entry point for this record type. Accessed through the All User Roles window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='42b86626-4d51-4b18-989c-d15a8c92bf0a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Table Index (Table and Column)
UPDATE AD_Tab SET Description='Related table index entries for this table and column', Help='Navigate here to view and edit associated table index details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fba100de-536e-40cf-8c1b-72c2d063ee37' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Report Column Set)
UPDATE AD_Tab SET Description='Related translation entries for this report column set', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Report Column Set window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='efbf3721-2588-4b98-b836-4f0288a60710' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Report Line Set)
UPDATE AD_Tab SET Description='Related translation entries for this report line set', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Report Line Set window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3d76586d-4f9c-4b2d-8e39-b0aae583d74c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Sessions (Active Session)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core sessions attributes. This serves as the main entry point for this record type. Accessed through the Active Session window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6fb7071b-f94c-49fe-86db-a4a5560f119f' AND (Help IS NULL) AND EntityType='D';

-- Web Service Parameters (Web Service Security)
UPDATE AD_Tab SET Description='Related web service parameters entries for this web service security', Help='Navigate here to view and edit associated web service parameters details. Records on this tab are linked to the parent entry above. Accessed through the Web Service Security window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a1ea44a6-213a-4028-bc4f-16bb8ded6222' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Web Service Field Input (Web Service Security)
UPDATE AD_Tab SET Description='Related web service field input entries for this web service security', Help='Navigate here to view and edit associated web service field input details. Records on this tab are linked to the parent entry above. Accessed through the Web Service Security window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5fd0b27f-8cbe-4207-9cee-828215d55319' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Web Service Field Output (Web Service Security)
UPDATE AD_Tab SET Description='Related web service field output entries for this web service security', Help='Navigate here to view and edit associated web service field output details. Records on this tab are linked to the parent entry above. Accessed through the Web Service Security window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='21d967ed-2e82-4ddc-b13a-d8846406f253' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Related Customization (Info Window Customization)
UPDATE AD_Tab SET Description='Related related customization entries for this info window customization', Help='Navigate here to view and edit associated related customization details. Records on this tab are linked to the parent entry above. Accessed through the Info Window Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b592e5b9-2a8b-4f14-8639-f7b003539224' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Package Installation (Pack In)
UPDATE AD_Tab SET Description='Related package installation entries for this pack in', Help='Navigate here to view and edit associated package installation details. Records on this tab are linked to the parent entry above. Accessed through the Pack In window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9290ca4f-1650-4c88-9507-7a843f45384d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Authorization Provider (Authorization Provider)
UPDATE AD_Tab SET Description='Primary data entry for authorization provider records', Help='Use this tab to create and modify the core authorization provider attributes. This serves as the main entry point for this record type. Accessed through the Authorization Provider window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='799b9ac5-e4bb-4cc6-aa8b-e39867f9d939' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Authorization Scope Provider (Authorization Provider)
UPDATE AD_Tab SET Description='Related authorization scope provider entries for this authorization provider', Help='Navigate here to view and edit associated authorization scope provider details. Records on this tab are linked to the parent entry above. Accessed through the Authorization Provider window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c8a0af28-d20f-425d-a246-39ab83e77b01' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Authorization Credential (Authorization Credential)
UPDATE AD_Tab SET Description='Primary data entry for authorization credential records', Help='Use this tab to create and modify the core authorization credential attributes. This serves as the main entry point for this record type. Accessed through the Authorization Credential window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4be92250-50da-424d-979c-5acee0854f56' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Production Line (Production (Single Product))
UPDATE AD_Tab SET Description='Related production line entries for this production (single product)', Help='Navigate here to view and edit associated production line details. Records on this tab are linked to the parent entry above. Accessed through the Production (Single Product) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8cc500ac-bb02-48c1-a5dc-4c3ddc345979' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- POS Payment (Sales Order)
UPDATE AD_Tab SET Description='Related pos payment entries for this sales order', Help='Navigate here to view and edit associated pos payment details. Records on this tab are linked to the parent entry above. Accessed through the Sales Order window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b29acba2-af8e-4c28-a889-2a7131c5848c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Authorization Account (Authorization Credential)
UPDATE AD_Tab SET Description='Related authorization account entries for this authorization credential', Help='Navigate here to view and edit associated authorization account details. Records on this tab are linked to the parent entry above. Accessed through the Authorization Credential window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='52886d52-9c96-4aa4-ba57-ddb185e73a7b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Info Window Customization (Info Window Customization)
UPDATE AD_Tab SET Description='Primary data entry for info window customization records', Help='Use this tab to create and modify the core info window customization attributes. This serves as the main entry point for this record type. Accessed through the Info Window Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e939cff1-b690-4902-97f0-2443609cc00e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Document Status Translation (Document Status)
UPDATE AD_Tab SET Description='Related document status translation entries for this document status', Help='Navigate here to view and edit associated document status translation details. Records on this tab are linked to the parent entry above. Accessed through the Document Status window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='16c4fe42-d942-4297-bb65-2724fd7cb9c2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Attributes (Inventory Decrease/Increase)
UPDATE AD_Tab SET Description='Related attributes entries for this inventory decrease/increase', Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Inventory Decrease/Increase window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b3cfcd35-a172-4003-a853-6f89a4c0abee' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Lines (Payments into Batch)
UPDATE AD_Tab SET Description='Related lines entries for this payments into batch', Help='Navigate here to view and edit associated lines details. Records on this tab are linked to the parent entry above. Accessed through the Payments into Batch window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3adbb99b-98d8-450f-83a0-87ebc00d2950' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Cost Adjustment Line (Cost Adjustment)
UPDATE AD_Tab SET Description='Related cost adjustment line entries for this cost adjustment', Help='Navigate here to view and edit associated cost adjustment line details. Records on this tab are linked to the parent entry above. Accessed through the Cost Adjustment window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='eb716dc1-f0c8-4596-8b76-7ec4bca13fd4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Attributes (Inventory Move)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Inventory Move window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a3f24bc2-cab9-410e-88da-a0a522120613' AND (Help IS NULL) AND EntityType='D';

-- Attributes (Physical Inventory)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Physical Inventory window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e43cf83c-4fec-4b5f-8a38-15dcf4a6700d' AND (Help IS NULL) AND EntityType='D';

-- Attributes (Shipment (Customer))
UPDATE AD_Tab SET Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Shipment (Customer) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='73a2013e-697f-4916-8da2-2edfa8fd3800' AND (Help IS NULL) AND EntityType='D';

-- Attributes (Material Receipt)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Material Receipt window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d771d2e8-42a0-426e-ba58-c4f459bbbc1e' AND (Help IS NULL) AND EntityType='D';

-- Attributes (Customer Return)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Customer Return window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8cf5abeb-4146-4581-b353-24ee510bcaff' AND (Help IS NULL) AND EntityType='D';

-- Attributes (Production (Single Product))
UPDATE AD_Tab SET Description='Related attributes entries for this production (single product)', Help='Navigate here to view and edit associated attributes details. Records on this tab are linked to the parent entry above. Accessed through the Production (Single Product) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9eced926-7d62-4fb8-9820-75039a2e9856' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Dashboard Content (Dashboard Content)
UPDATE AD_Tab SET Description='Primary data entry for dashboard content records', Help='Use this tab to create and modify the core dashboard content attributes. This serves as the main entry point for this record type. Accessed through the Dashboard Content window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4e3abcd9-c5b5-4150-abdc-fde43364e49a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MFA Method (MFA Method)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core mfa method attributes. This serves as the main entry point for this record type. Accessed through the MFA Method window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9306f3ac-9af6-4e1e-aeff-a48e90e9301b' AND (Help IS NULL) AND EntityType='D';

-- MFA Registered Device (MFA Registered Device)
UPDATE AD_Tab SET Description='Primary data entry for mfa registered device records', Help='Use this tab to create and modify the core mfa registered device attributes. This serves as the main entry point for this record type. Accessed through the MFA Registered Device window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d4125e71-276c-4fba-b857-0c83ff610a87' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MFA Registration (MFA Registration)
UPDATE AD_Tab SET Description='Primary data entry for mfa registration records', Help='Use this tab to create and modify the core mfa registration attributes. This serves as the main entry point for this record type. Accessed through the MFA Registration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9831281f-f29f-41ef-9d8f-baf9e14e4d4f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- MFA Rule (MFA Rule)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core mfa rule attributes. This serves as the main entry point for this record type. Accessed through the MFA Rule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b870c13f-8ff8-462a-80fa-9e27ca0fb329' AND (Help IS NULL) AND EntityType='D';

-- System Configurator (System Configurator)
UPDATE AD_Tab SET Description='Primary data entry for system configurator records', Help='Use this tab to create and modify the core system configurator attributes. This serves as the main entry point for this record type. Accessed through the System Configurator window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='be2cc8e3-0058-4f4b-9114-4f47a51e435c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Dashboard Content Access (Dashboard Content)
UPDATE AD_Tab SET Description='Related dashboard content access entries for this dashboard content', Help='Navigate here to view and edit associated dashboard content access details. Records on this tab are linked to the parent entry above. Accessed through the Dashboard Content window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ba945c13-8246-4038-b67d-dc9305016713' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Lead (Lead)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core lead attributes. This serves as the main entry point for this record type. Accessed through the Lead window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='fd96a67a-28d1-42bd-bfed-1b29a45a6c60' AND (Help IS NULL) AND EntityType='D';

-- Sort Order (Print Format)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated sort order details. Records on this tab are linked to the parent entry above. Accessed through the Print Format window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1704f1bf-824a-4071-8507-020ad5f0c2b8' AND (Help IS NULL) AND EntityType='D';

-- Field Sequence (Window, Tab and Field)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated field sequence details. Records on this tab are linked to the parent entry above. Accessed through the Window, Tab and Field window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0086682a-2025-454a-b44a-9ad1c3ef43d4' AND (Help IS NULL) AND EntityType='D';

-- Key Sequence (POS Key Layout)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated key sequence details. Records on this tab are linked to the parent entry above. Accessed through the POS Key Layout window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='212aab4d-f6b9-4155-b257-b0f0aabf3df3' AND (Help IS NULL) AND EntityType='D';

-- Grid Sequence (Window, Tab and Field)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated grid sequence details. Records on this tab are linked to the parent entry above. Accessed through the Window, Tab and Field window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='27d1dcc7-2696-45e2-bbf8-6c1f51c3e48f' AND (Help IS NULL) AND EntityType='D';

-- Favorite tree node (Menu user favourites)
UPDATE AD_Tab SET Description='Related favorite tree node entries for this menu user favourites', Help='Navigate here to view and edit associated favorite tree node details. Records on this tab are linked to the parent entry above. Accessed through the Menu user favourites window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cbd7fc14-c206-4cb0-a827-168fb792f470' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Document Status Access (Document Status)
UPDATE AD_Tab SET Description='Related document status access entries for this document status', Help='Navigate here to view and edit associated document status access details. Records on this tab are linked to the parent entry above. Accessed through the Document Status window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='38656724-adc7-4b47-8269-ed9073707c20' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Document Status Access (Role)
UPDATE AD_Tab SET Description='Related document status access entries for this role', Help='Navigate here to view and edit associated document status access details. Records on this tab are linked to the parent entry above. Accessed through the Role window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='46432a91-ca35-4a60-8b75-4c4c00121f12' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Document Status Access (User)
UPDATE AD_Tab SET Description='Related document status access entries for this user', Help='Navigate here to view and edit associated document status access details. Records on this tab are linked to the parent entry above. Accessed through the User window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5dc2b3d5-02ef-4231-a9f3-3ebdfa35c445' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- SMTP Server (SMTP Server)
UPDATE AD_Tab SET Description='Primary data entry for smtp server records', Help='Use this tab to create and modify the core smtp server attributes. This serves as the main entry point for this record type. Accessed through the SMTP Server window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='bdf27ca5-26af-456d-a647-6bad3d5cad38' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Print Header/Footer (Print Header/Footer)
UPDATE AD_Tab SET Description='Primary data entry for print header/footer records', Help='Use this tab to create and modify the core print header/footer attributes. This serves as the main entry point for this record type. Accessed through the Print Header/Footer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b3beffb9-ab5f-4d40-9a6b-2f849306e9e6' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Bill of Materials (Parts and BOMs)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated bill of materials details. Records on this tab are linked to the parent entry above. Accessed through the Parts and BOMs window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='59b33b9c-85d2-48ee-a22b-a4b2c91d4cbb' AND (Help IS NULL) AND EntityType='D';

-- Customization of the Wlistbox (Customization of the Wlistbox)
UPDATE AD_Tab SET Description='Primary data entry for customization of the wlistbox records', Help='Use this tab to create and modify the core customization of the wlistbox attributes. This serves as the main entry point for this record type. Accessed through the Customization of the Wlistbox window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f4b5b7e6-43e2-4a25-b827-167e019cd18e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Ordered Quantity Log (Product)
UPDATE AD_Tab SET Description='Related ordered quantity log entries for this product', Help='Navigate here to view and edit associated ordered quantity log details. Records on this tab are linked to the parent entry above. Accessed through the Product window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='51998887-0e9e-437e-8477-0f9a8684191e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Reserved Quantity Log (Product)
UPDATE AD_Tab SET Description='Related reserved quantity log entries for this product', Help='Navigate here to view and edit associated reserved quantity log details. Records on this tab are linked to the parent entry above. Accessed through the Product window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='feec8372-59ab-43ec-9ad7-25c1f5a578a9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Used in Column (Lookup) (Validation Rules)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated used in column (lookup) details. Records on this tab are linked to the parent entry above. Accessed through the Validation Rules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cb281c2a-e9ae-4c1d-b2bc-2dcc651573b0' AND (Help IS NULL) AND EntityType='D';

-- User Preference (User Preference)
UPDATE AD_Tab SET Description='Primary data entry for user preference records', Help='Use this tab to create and modify the core user preference attributes. This serves as the main entry point for this record type. Accessed through the User Preference window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='29b168d0-ccf3-46eb-b036-d33de1660f8e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- City (Without Regions) (Country Region and City)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated city (without regions) details. Records on this tab are linked to the parent entry above. Accessed through the Country Region and City window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='27c212e2-6808-408a-91b8-7284e2b26c75' AND (Help IS NULL) AND EntityType='D';

-- User favourite tree (Menu user favourites)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core user favourite tree attributes. This serves as the main entry point for this record type. Accessed through the Menu user favourites window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='768d15d3-e60d-4074-ad47-8d632111ae4e' AND (Help IS NULL) AND EntityType='D';

-- Verify Migration Process (Verify Migration)
UPDATE AD_Tab SET Description='Primary data entry for verify migration process records', Help='Use this tab to create and modify the core verify migration process attributes. This serves as the main entry point for this record type. Accessed through the Verify Migration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='83130ef3-47f3-473e-812f-00248f5564ab' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tenant level messages (Tenant level messages)
UPDATE AD_Tab SET Description='Primary data entry for tenant level messages records', Help='Use this tab to create and modify the core tenant level messages attributes. This serves as the main entry point for this record type. Accessed through the Tenant level messages window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='64d37a62-cc02-4beb-b3e1-ab7bf6c6f2b7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tenant Level (ASP Subscribed Modules)
UPDATE AD_Tab SET Description='Primary data entry for tenant level records', Help='Use this tab to create and modify the core tenant level attributes. This serves as the main entry point for this record type. Accessed through the ASP Subscribed Modules window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e8593fc2-1d9d-4d7d-bb3e-50901cb36d2f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Bank Transfer (Bank/Cash Transfer)
UPDATE AD_Tab SET Description='Primary data entry for bank transfer records', Help='Use this tab to create and modify the core bank transfer attributes. This serves as the main entry point for this record type. Accessed through the Bank/Cash Transfer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9dd2bf7d-8e81-4936-ab6c-a362001c930e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Payments (Bank/Cash Transfer)
UPDATE AD_Tab SET Description='Related payments entries for this bank/cash transfer', Help='Navigate here to view and edit associated payments details. Records on this tab are linked to the parent entry above. Accessed through the Bank/Cash Transfer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='653ad893-32d4-4c8f-b7a8-d86b269922fe' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Allocations (Bank/Cash Transfer)
UPDATE AD_Tab SET Description='Related allocations entries for this bank/cash transfer', Help='Navigate here to view and edit associated allocations details. Records on this tab are linked to the parent entry above. Accessed through the Bank/Cash Transfer window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0a31d45f-3444-4272-a722-402008c7e8f2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Label Category (Label Category)
UPDATE AD_Tab SET Description='Primary data entry for label category records', Help='Use this tab to create and modify the core label category attributes. This serves as the main entry point for this record type. Accessed through the Label Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='92db7d06-609b-445b-818c-6a0175a4de1f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Table Access (Label Category)
UPDATE AD_Tab SET Description='Related table access entries for this label category', Help='Navigate here to view and edit associated table access details. Records on this tab are linked to the parent entry above. Accessed through the Label Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1b3a9732-0f05-4fbd-9c48-2664563cc582' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Label (Label)
UPDATE AD_Tab SET Description='Primary data entry for label records', Help='Use this tab to create and modify the core label attributes. This serves as the main entry point for this record type. Accessed through the Label window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='703d7d2d-03bf-41d6-aabb-ac8244243125' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Assignment (Label Assignment)
UPDATE AD_Tab SET Description='Primary data entry for assignment records', Help='Use this tab to create and modify the core assignment attributes. This serves as the main entry point for this record type. Accessed through the Label Assignment window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='379bc7ea-82fb-4be7-867e-17706d30d156' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Drill Rule (Drill Rule)
UPDATE AD_Tab SET Description='Primary data entry for drill rule records', Help='Use this tab to create and modify the core drill rule attributes. This serves as the main entry point for this record type. Accessed through the Drill Rule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1c99e0b5-4718-463a-a0e7-bf8432d1b70e' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Datasource (Chart)
UPDATE AD_Tab SET Description='Related datasource entries for this chart', Help='Navigate here to view and edit associated datasource details. Records on this tab are linked to the parent entry above. Accessed through the Chart window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='9ce33a08-0a24-443e-a775-37d6c8845a95' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Verify Migration (Verify Migration)
UPDATE AD_Tab SET Description='Related verify migration entries for this verify migration', Help='Navigate here to view and edit associated verify migration details. Records on this tab are linked to the parent entry above. Accessed through the Verify Migration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1e6012ab-2683-4b63-b712-e9085a36a54f' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Drill Rule Parameter (Drill Rule)
UPDATE AD_Tab SET Description='Related drill rule parameter entries for this drill rule', Help='Navigate here to view and edit associated drill rule parameter details. Records on this tab are linked to the parent entry above. Accessed through the Drill Rule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cf646be0-5bd7-4d8e-9ede-185fec8f6b64' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Drill Rule Translation (Drill Rule)
UPDATE AD_Tab SET Description='Related drill rule translation entries for this drill rule', Help='Navigate here to view and edit associated drill rule translation details. Records on this tab are linked to the parent entry above. Accessed through the Drill Rule window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='08a5d1fc-e264-48c6-84d3-dad1cbac8811' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Datasource Translation (Chart)
UPDATE AD_Tab SET Description='Related datasource translation entries for this chart', Help='Navigate here to view and edit associated datasource translation details. Records on this tab are linked to the parent entry above. Accessed through the Chart window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b83aeaa9-d0be-40d8-8c12-d87df5d184c9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Chart)
UPDATE AD_Tab SET Description='Related translation entries for this chart', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Chart window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a4808408-ab7d-43b8-aac5-87ccae3bdab3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Label)
UPDATE AD_Tab SET Description='Related translation entries for this label', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Label window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='71acff37-8644-417a-b91b-b62164ab196b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Label Category)
UPDATE AD_Tab SET Description='Related translation entries for this label category', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Label Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8d58160e-5e05-4895-9e3f-671bf61bf87d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Preference (Preference)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core preference attributes. This serves as the main entry point for this record type. Accessed through the Preference window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='d80dc2d0-6de8-487b-8180-7edceb3c8397' AND (Help IS NULL) AND EntityType='D';

-- SSO Configuration (SSO Configuration)
UPDATE AD_Tab SET Description='Primary data entry for sso configuration records', Help='Use this tab to create and modify the core sso configuration attributes. This serves as the main entry point for this record type. Accessed through the SSO Configuration window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='29ac2590-d681-4a3e-8b04-caf5269dda86' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Test UU Detail (Test UU Detail)
UPDATE AD_Tab SET Description='Primary data entry for test uu detail records', Help='Use this tab to create and modify the core test uu detail attributes. This serves as the main entry point for this record type. Accessed through the Test UU Detail window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='36b10541-db9c-4de4-b4de-2329979f4dff' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Document Base Type Group (Document Base Type Group)
UPDATE AD_Tab SET Description='Primary data entry for document base type group records', Help='Use this tab to create and modify the core document base type group attributes. This serves as the main entry point for this record type. Accessed through the Document Base Type Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='745e906f-4e34-43eb-84b8-bd2b484e3cb3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Document Base Type Group Line (Document Base Type Group)
UPDATE AD_Tab SET Description='Related document base type group line entries for this document base type group', Help='Navigate here to view and edit associated document base type group line details. Records on this tab are linked to the parent entry above. Accessed through the Document Base Type Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='cbbfe720-616d-4ef9-9137-72078a61f763' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Test UU Based Table (Test UU Based Table)
UPDATE AD_Tab SET Description='Primary data entry for test uu based table records', Help='Use this tab to create and modify the core test uu based table attributes. This serves as the main entry point for this record type. Accessed through the Test UU Based Table window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='c3f2631d-4c03-479a-b117-c3b63ce7d88a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Model Generator Template (Model Generator Template)
UPDATE AD_Tab SET Description='Primary data entry for model generator template records', Help='Use this tab to create and modify the core model generator template attributes. This serves as the main entry point for this record type. Accessed through the Model Generator Template window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='1134c289-64e4-4adf-8a04-34f875147bcd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tax Rate (Tax Category)
UPDATE AD_Tab SET Description='Related tax rate entries for this tax category', Help='Navigate here to view and edit associated tax rate details. Records on this tab are linked to the parent entry above. Accessed through the Tax Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0e084f60-bce3-45bc-a7c6-af8100415f59' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Test UU Detail (Test UU Based Table)
UPDATE AD_Tab SET Description='Related test uu detail entries for this test uu based table', Help='Navigate here to view and edit associated test uu detail details. Records on this tab are linked to the parent entry above. Accessed through the Test UU Based Table window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0c329e35-319d-401f-8be0-50bf1224e93b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Table Partition (Table and Column)
UPDATE AD_Tab SET Description='Related table partition entries for this table and column', Help='Navigate here to view and edit associated table partition details. Records on this tab are linked to the parent entry above. Accessed through the Table and Column window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6eecaed6-a84a-4d43-adbc-954917c76d2a' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Info Window Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related info window translation entries for this system translation check', Help='Navigate here to view and edit associated info window translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a77a01a7-d78d-4e61-845d-f764b1e167ce' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Info Column Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related info column translation entries for this system translation check', Help='Navigate here to view and edit associated info column translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='28dff2eb-73b0-46ba-af64-329cfab43eb1' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Table Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related table translation entries for this system translation check', Help='Navigate here to view and edit associated table translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='a2d622d5-b31e-4543-8c0e-705641c9b770' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Private Access (Private Access)
UPDATE AD_Tab SET Description='Primary data entry for private access records', Help='Use this tab to create and modify the core private access attributes. This serves as the main entry point for this record type. Accessed through the Private Access window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='70138aff-fa85-4b6a-bf87-819a0d9cef2c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Dynamic Validation per Table (Dynamic Validation per Table)
UPDATE AD_Tab SET Description='Primary data entry for dynamic validation per table records', Help='Use this tab to create and modify the core dynamic validation per table attributes. This serves as the main entry point for this record type. Accessed through the Dynamic Validation per Table window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='72743e37-0045-4f00-b049-0d00b10d845b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- User Queries (User Queries)
UPDATE AD_Tab SET Help='Use this tab to create and modify the core user queries attributes. This serves as the main entry point for this record type. Accessed through the User Queries window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='69116c36-1b86-42b5-85a2-6449c466d7c3' AND (Help IS NULL) AND EntityType='D';

-- Subscriptions (Interest Area)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated subscriptions details. Records on this tab are linked to the parent entry above. Accessed through the Interest Area window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ce0b9d42-1ed0-443f-ae31-550dad1e9c44' AND (Help IS NULL) AND EntityType='D';

-- Column Translation (System Translation Check)
UPDATE AD_Tab SET Description='Related column translation entries for this system translation check', Help='Navigate here to view and edit associated column translation details. Records on this tab are linked to the parent entry above. Accessed through the System Translation Check window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e4c00e2c-69a2-46ac-a675-b13f4dd0e719' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Test UU Based Table Trl (Test UU Based Table)
UPDATE AD_Tab SET Description='Related test uu based table trl entries for this test uu based table', Help='Navigate here to view and edit associated test uu based table trl details. Records on this tab are linked to the parent entry above. Accessed through the Test UU Based Table window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='6eb8bbc8-8eae-4eb3-8b6d-9822e23ee57c' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Window Customization (Window Customization)
UPDATE AD_Tab SET Description='Primary data entry for window customization records', Help='Use this tab to create and modify the core window customization attributes. This serves as the main entry point for this record type. Accessed through the Window Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='5b3fb85d-ba9b-42eb-8cd0-83e6258ca0a9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Tab Customization (Window Customization)
UPDATE AD_Tab SET Description='Related tab customization entries for this window customization', Help='Navigate here to view and edit associated tab customization details. Records on this tab are linked to the parent entry above. Accessed through the Window Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='e5667a82-41fc-42a6-8d25-061e8db227b8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Field Customization (Window Customization)
UPDATE AD_Tab SET Description='Related field customization entries for this window customization', Help='Navigate here to view and edit associated field customization details. Records on this tab are linked to the parent entry above. Accessed through the Window Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ef44f103-3107-497b-b7e2-76bdcac73dbe' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Column Customization (Info Window Customization)
UPDATE AD_Tab SET Description='Related column customization entries for this info window customization', Help='Navigate here to view and edit associated column customization details. Records on this tab are linked to the parent entry above. Accessed through the Info Window Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='50258ad1-c73b-4b4e-9a84-098d8a8ca2a7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Activity (ABC))
UPDATE AD_Tab SET Description='Related translation entries for this activity (abc)', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Activity (ABC) window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3412b725-151b-46aa-8086-9977e875be97' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Asset Group)
UPDATE AD_Tab SET Description='Related translation entries for this asset group', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Asset Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='7a331165-5e30-486c-a949-31daa9326d97' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Context Help)
UPDATE AD_Tab SET Description='Related translation entries for this context help', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Context Help window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2945b8e0-2d36-4b9f-999f-3833dd10b767' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Element)
UPDATE AD_Tab SET Description='Related translation entries for this element', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Element window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='69d68d48-276b-424a-8b89-ad7cc726eff9' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Field Group)
UPDATE AD_Tab SET Description='Related translation entries for this field group', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Field Group window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='b3c2b5d6-ddc9-44fe-b4db-b8da97040b24' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Greeting)
UPDATE AD_Tab SET Description='Related translation entries for this greeting', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Greeting window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='3fa6aef9-756e-410e-941e-fa4dcdf9c4bc' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Column Translation (Info Window)
UPDATE AD_Tab SET Help='Navigate here to view and edit associated column translation details. Records on this tab are linked to the parent entry above. Accessed through the Info Window window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='8ce3217a-81f0-4ae0-85f7-c9667312c6dc' AND (Help IS NULL) AND EntityType='D';

-- Translation (Product Category)
UPDATE AD_Tab SET Description='Related translation entries for this product category', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Product Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='ed52b38e-a01a-443b-8a50-88ddf46b259b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Report Translation (Report and Process)
UPDATE AD_Tab SET Description='Related report translation entries for this report and process', Help='Navigate here to view and edit associated report translation details. Records on this tab are linked to the parent entry above. Accessed through the Report and Process window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='0d2d1523-2880-455b-970d-dfe9d8662fe2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Sales Stage)
UPDATE AD_Tab SET Description='Related translation entries for this sales stage', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Sales Stage window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='4bfef99a-78a8-4b17-872d-ab7950d0c7a5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Translation (Tax Category)
UPDATE AD_Tab SET Description='Related translation entries for this tax category', Help='Navigate here to view and edit associated translation details. Records on this tab are linked to the parent entry above. Accessed through the Tax Category window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2fec2802-f36a-464b-af9e-eb40ab81aff4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Theme Customization Detail (Theme Customization)
UPDATE AD_Tab SET Description='Related theme customization detail entries for this theme customization', Help='Navigate here to view and edit associated theme customization detail details. Records on this tab are linked to the parent entry above. Accessed through the Theme Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='2a8f4233-9526-42fe-803b-a075373108e3' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Theme Customization (Theme Customization)
UPDATE AD_Tab SET Description='Primary data entry for theme customization records', Help='Use this tab to create and modify the core theme customization attributes. This serves as the main entry point for this record type. Accessed through the Theme Customization window.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Tab_UU='f6a03d64-e626-45fc-8a98-6bbabbb9f217' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

