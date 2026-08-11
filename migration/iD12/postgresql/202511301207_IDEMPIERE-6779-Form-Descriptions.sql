-- AD_Form descriptions (from Java analysis)
-- Forms: 17

SELECT register_migration_script('202511301207_IDEMPIERE-6779-Form-Descriptions.sql') FROM dual;

-- =============================================
-- AD_Form (17 records)
-- =============================================

-- Material Transactions
UPDATE AD_Form SET Help='The Material Transactions form material Transactions. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='8fe4ece8-422d-4c28-8488-cc1f08c241d2' AND (Help IS NULL) AND EntityType='D';

-- Payment Allocation
UPDATE AD_Form SET Help='The Payment Allocation form allocate invoices and payments. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='1dec8db2-4f74-45cd-aa5c-b3642f58ce5b' AND (Help IS NULL) AND EntityType='D';

-- Payment Print/Export
UPDATE AD_Form SET Help='The Payment Print/Export form print or export your payments. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='3fb47a22-e0b6-46f5-9d82-56dcaf320f5c' AND (Help IS NULL) AND EntityType='D';

-- 📌 Compare Context Help Suggestion
UPDATE AD_Form SET Help='The Compare Context Help Suggestion form review changes for context help. Key capabilities: generates documents, executes processes, organizes content in tabs. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='09e0322d-5eb9-4dc8-a332-7534fac86de0' AND (Help IS NULL) AND EntityType='D';

-- Setup Wizard
UPDATE AD_Form SET Description='Step-by-step setup configuration', Help='The Setup Wizard form step-by-step setup configuration. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='7df89045-cd20-46e3-94fb-e0b80e4084f8' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Reset Password
UPDATE AD_Form SET Help='The Reset Password form reset Password. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='e2db983d-c11a-46f7-a4f5-fca8167c8d6c' AND (Help IS NULL) AND EntityType='D';

-- 📌 Report Wizard
UPDATE AD_Form SET Help='The Report Wizard form report Wizard. Key capabilities: organizes content in tabs, manages orders, displays data in grid format. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='df3440d4-deb8-4e09-8426-4e16c426a6d4' AND (Help IS NULL) AND EntityType='D';

-- Tab Editor
UPDATE AD_Form SET Description='Visual editor for tab configuration', Help='The Tab Editor form visual editor for tab configuration. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='4f5be293-6016-4bb5-9a7f-114018d1f1b7' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Bank Statement Create From Batch
UPDATE AD_Form SET Description='Create records from existing bank statement  batch', Help='The Bank Statement Create From Batch form create records from existing bank statement  batch. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='f7ea6003-2e6b-4873-9e0b-a8c18ec2ee6d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- 📌 Compare Field Suggestion
UPDATE AD_Form SET Help='The Compare Field Suggestion form review field changes for label, descriptipn and help. Key capabilities: generates documents, executes processes, organizes content in tabs. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='8cabf09d-02c0-463f-b110-45dc831654ca' AND (Help IS NULL) AND EntityType='D';

-- 📌 Captured Process Parameter
UPDATE AD_Form SET Description='Interactive form that organizes content in tabs and imports data', Help='The Captured Process Parameter form interactive form that organizes content in tabs and imports data. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='0a47e803-4917-4e7f-af33-39135b8b2415' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Accounting Fact Reconciliation (manual)
UPDATE AD_Form SET Description='Interactive form for accounting fact reconciliation (manual) operations', Help='The Accounting Fact Reconciliation (manual) form interactive form for accounting fact reconciliation (manual) operations. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='3230279b-f05c-4beb-be42-a11c77d625bd' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- idempiereMonitor
UPDATE AD_Form SET Help='The idempiereMonitor form form to configure access to /idempiereMonitor - do not add to menu. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='3406efc3-aa1d-4212-bb5d-6d64ee39cc61' AND (Help IS NULL) AND EntityType='D';

-- Apache Felix Web Console
UPDATE AD_Form SET Help='The Apache Felix Web Console form form to configure access to /osgi/system/console - do not add to menu. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='bb212a96-e71d-4deb-98eb-799c74247c96' AND (Help IS NULL) AND EntityType='D';

-- 📌 Add Authorization Mail Account
UPDATE AD_Form SET Description='Interactive form that generates documents and executes processes', Help='The Add Authorization Mail Account form interactive form that generates documents and executes processes. Key capabilities: generates documents, executes processes, organizes content in tabs. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='0f52aecd-dc50-4ca6-b4db-4287d1c8c9e5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- 📌 Register MFA
UPDATE AD_Form SET Help='The Register MFA form register a multi-factor authentication mechanism. Key capabilities: executes processes, generates documents, displays data in grid format. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='225070fb-7912-4873-b9aa-785e377c9980' AND (Help IS NULL) AND EntityType='D';

-- 📌 Customize Grid View
UPDATE AD_Form SET Help='The Customize Grid View form form to customize the grid view of tabs in window customization. Key capabilities: generates documents, manages orders, organizes content in tabs. Access this form from the menu to perform the required operations.', Updated=NOW(), UpdatedBy=100 WHERE AD_Form_UU='b6038f33-8ec4-4513-b873-97465e4e2937' AND (Help IS NULL) AND EntityType='D';

