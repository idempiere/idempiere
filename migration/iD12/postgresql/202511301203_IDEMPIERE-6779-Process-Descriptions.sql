-- AD_Process descriptions
-- Processes: 218

SELECT register_migration_script('202511301203_IDEMPIERE-6779-Process-Descriptions.sql') FROM dual;

-- =============================================
-- AD_Process (218 records)
-- =============================================

UPDATE AD_Process SET Description='Printable document format for invoice', Help='Run this report to obtain invoice print  analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='96fb3396-713e-489f-afc4-efe4cb984e12' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt M_InOut (Delivery Note / Shipment Print )
UPDATE AD_Process SET Description='Printable document format for delivery note / shipment', Help='Run this report to obtain delivery note / shipment print  analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='2a39f2e2-c312-4d2a-8034-f0179f0456ef' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt C_RFQResponse (RFQ Response Print )
UPDATE AD_Process SET Description='Printable document format for rfq response', Help='Run this report to obtain rfq response print  analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='00b10b23-3d84-43fa-a14f-384845472347' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt C_Dunning (Dunning Letter)
UPDATE AD_Process SET Description='Printable document format for dunning letter', Help='Run this report to obtain dunning letter analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='8d6eac69-d046-4dbf-b7ff-7a813e2e63ba' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_M_Requisition Open (Open Requisitions)
UPDATE AD_Process SET Help='Run this report to obtain open requisitions analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='2a9f007b-8cca-4e79-a8bc-fa7e8b6b22d3' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- R_Order_DrillDown (Order Drilldown)
UPDATE AD_Process SET Description='Analytical view of order drilldown data', Help='Run this report to obtain order drilldown analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='4747ce3e-c092-4051-82b6-ba8eee537d9d' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- R_ProjectStatus (Project Status Summary)
UPDATE AD_Process SET Help='Run this report to obtain project status summary analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='348136e3-f843-42be-8e75-c5c40db76e35' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt C_Order (Order Print)
UPDATE AD_Process SET Description='Printable document format for order', Help='Run this report to obtain order print analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c10c4e97-17b2-48f3-a92c-fb612d5bd949' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt C_Project (Project Print)
UPDATE AD_Process SET Description='Printable document format for project', Help='Run this report to obtain project print analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6190bbb7-3586-43d3-a1cc-0f55b61bdb92' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Project Accounting (Project Detail Accounting Report)
UPDATE AD_Process SET Help='Run this report to obtain project detail accounting report analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='7773db56-197a-417f-9729-a7987b37f3d3' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_ProjectLine Not Issued (Project Lines not Issued)
UPDATE AD_Process SET Help='Run this report to obtain project lines not issued analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e55dce96-5b6b-4546-94b8-af791f04dd31' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_ProjectLine Not Received POs (Project POs not Issued)
UPDATE AD_Process SET Help='Run this report to obtain project pos not issued analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6b5eff9f-6cd4-4771-b166-9ae71ed6c79f' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Setup Web POS (Setup Web POS)
UPDATE AD_Process SET Description='Executes setup web pos operations', Help='Execute this function to perform automated setup web pos operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9689f6ea-2b29-4ae7-a1e4-2aa67bd89a12' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Split_Entry (Asset Split Entry)
UPDATE AD_Process SET Help='Run this report to obtain asset split entry analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='8be21d9c-9880-4b40-8c21-e7fc7d85ed49' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt C_Payment (Payment Print )
UPDATE AD_Process SET Description='Printable document format for payment', Help='Run this report to obtain payment print  analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c282b8be-90ef-4b0d-ad2a-d5efb20cd814' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt M_InOutConfirm (Shipment Confirmation)
UPDATE AD_Process SET Description='Printable document format for shipment confirmation', Help='Run this report to obtain shipment confirmation analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='95bbb75b-648c-41aa-96dd-d135328a5856' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Rpt PP_Order (Manufacturing Order)
UPDATE AD_Process SET Description='Printable document format for manufacturing order', Help='Run this report to obtain manufacturing order analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e6397fb3-3e27-4fa1-a689-0d9a2ee031f4' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Depreciation_Forecast (Asset Depreciation Forecast)
UPDATE AD_Process SET Help='Run this report to obtain asset depreciation forecast analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='bd2d0439-8c9a-4ecc-809e-cc003ef24250' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Fact_Reconciliation (Unreconciled accounting facts)
UPDATE AD_Process SET Description='Analytical view of unreconciled accounting facts data', Help='Run this report to obtain unreconciled accounting facts analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='4b30febc-2599-4eac-96c7-cc6328b24cd8' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Storage_Per_Product (Storage per Product)
UPDATE AD_Process SET Description='Analytical view of storage per product data', Help='Run this report to obtain storage per product analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0f5b4a55-4cbf-45d6-b9eb-7bf729f9f3b7' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Spread_Rpt (Spread Report)
UPDATE AD_Process SET Description='Analytical view of spread report data', Help='Run this report to obtain spread report analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='956095b0-6b21-4af7-85e6-f365cf32567c' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Build_Depr_Forefile (Build Depreciation Forecast File)
UPDATE AD_Process SET Description='Analytical view of build depreciation forecast file data', Help='Run this report to obtain build depreciation forecast file analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='76d5385b-bd73-43a3-a35f-54f64a4cce35' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Depreciation_Exp_Entry (Depreciation Expense Entry)
UPDATE AD_Process SET Help='Run this report to obtain depreciation expense entry analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='91ffcb73-897c-4898-9d9f-e498ccef2a77' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Disposal_Entry_Rpt (Asset Disposal Expense Entry Rpt)
UPDATE AD_Process SET Help='Run this report to obtain asset disposal expense entry rpt analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='95d7be90-3cbc-4edf-a913-3027da33ace0' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CashFlow Report (Cash Flow Report)
UPDATE AD_Process SET Description='Analytical view of cash flow report data', Help='Run this report to obtain cash flow report analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='62352892-bab8-414d-826a-3e8fb9bb498e' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Order_Trx (Order Transactions)
UPDATE AD_Process SET Help='Run this report to obtain order transactions analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='7e142bee-73aa-4309-b835-9ff0a5ba0f71' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Depreciation_Method (Asset Depreciation Method)
UPDATE AD_Process SET Help='Run this report to obtain asset depreciation method analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='12520027-dae1-46e3-826a-5d1c41777cf1' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Convention_Rpt (Asset Convention Report)
UPDATE AD_Process SET Help='Run this report to obtain asset convention report analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='943a4433-3b12-4784-9b68-caf69a059600' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_ProductBOM_Indented (Indented Bill of Material)
UPDATE AD_Process SET Help='Run this report to obtain indented bill of material analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='55d410ae-0308-4d6a-8a0c-b91b184f097c' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_Production Plan (Production Plan)
UPDATE AD_Process SET Description='Analytical view of production plan data', Help='Run this report to obtain production plan analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='191be2cc-9bb9-4ca0-b280-36edaf51c610' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Cash_Detail (Cash Journal Detail)
UPDATE AD_Process SET Help='Run this report to obtain cash journal detail analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='eed9fe0e-6e89-4288-8063-f50b224392d0' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Depreciation_Table (Depreciation Table)
UPDATE AD_Process SET Description='Analytical view of depreciation table data', Help='Run this report to obtain depreciation table analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e476b9b4-3c11-48a8-a9f3-739c3bba1370' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Parent_Report (Asset Parent Report)
UPDATE AD_Process SET Description='Analytical view of asset parent report data', Help='Run this report to obtain asset parent report analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6bc076c8-ef96-4bba-9770-9a36d30099a2' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Group_Defaults (Asset Group Defaults)
UPDATE AD_Process SET Help='Run this report to obtain asset group defaults analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='997b6710-2797-4c89-8d92-8da5e922e8c8' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Depreciation_Calculation_Methods (Depreciation Calculation Methods)
UPDATE AD_Process SET Help='Run this report to obtain depreciation calculation methods analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0a532060-7f05-44ab-9cfa-ea177db84ab3' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- BankRegister (Bank Register Report)
UPDATE AD_Process SET Description='Analytical view of bank register report data', Help='Run this report to obtain bank register report analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='860657cd-af9b-4c98-9f96-3909deba4f54' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Fact_Reconciliation_Auto (Automatic account reconciliation)
UPDATE AD_Process SET Help='Execute this function to perform automated automatic account reconciliation operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0fba261a-be3f-4852-9354-55f14d80d55f' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Fact_Simple (Simple Fact View)
UPDATE AD_Process SET Description='Analytical view of simple fact view data', Help='Run this report to obtain simple fact view analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e6d33f36-e200-4ab2-95f8-884959210b7e' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- 1099 Extract (1099 Extract)
UPDATE AD_Process SET Description='Analytical view of 1099 extract data', Help='Run this report to obtain 1099 extract analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='5577f73c-ca99-43b6-8ad6-272739305b60' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RV_Fact_Adaxa (Complex Fact View)
UPDATE AD_Process SET Description='Analytical view of complex fact view data', Help='Run this report to obtain complex fact view analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='fab3d440-ee73-4aef-a2ba-c7d96b2c5934' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GL_JournalBatch_Process (Process Batch)
UPDATE AD_Process SET Description='Finalizes batch workflow', Help='Execute this function to perform automated process batch operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='fbcb87b0-a719-495f-bef7-b7491e118eea' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Invoice_Generate (manual) (Generate Invoices (manual) )
UPDATE AD_Process SET Help='Execute this function to perform automated generate invoices (manual)  operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='ecb97b23-686b-4ce3-8904-2940f5a95f94' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_BankStatement Payment (Create Payment)
UPDATE AD_Process SET Help='Execute this function to perform automated create payment operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='bb554f95-b2cc-444d-b7b6-f6882b60901e' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RecreateStorageReservation (Recreate Storage Reservation)
UPDATE AD_Process SET Description='Executes recreate storage reservation operations', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c4409eac-e5a8-4eac-b34a-1ac73319aa03' AND ((Description IS NULL OR Description LIKE '** Special%')) AND EntityType='D';

-- MigrateID (Migrate ID)
UPDATE AD_Process SET Help='Execute this function to perform automated migrate id operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='81e52777-5d7b-4a5b-b5e2-c7a4a15c38d8' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ActivateSupportRole (Activate)
UPDATE AD_Process SET Description='Executes activate operations', Help='Execute this function to perform automated activate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='ef977b06-1d1b-4030-b3a7-f404c540767d' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- DeactivateSupportRole (Deactivate)
UPDATE AD_Process SET Description='Executes deactivate operations', Help='Execute this function to perform automated deactivate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='7587be02-733c-4c7e-a40c-becbef1cc1d7' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- DeleteSupportRole (Delete)
UPDATE AD_Process SET Description='Removes obsolete records from the system', Help='Execute this function to perform automated delete operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='dd2a56da-3f62-4bec-b186-6c2b0aead59b' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- MFAUnregister (Unregister MFA Mechanism)
UPDATE AD_Process SET Help='Execute this function to perform automated unregister mfa mechanism operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='69f1a324-48dd-46be-ba96-0a6a7606dd4d' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- DatabaseConstraintDrop (Drop Database Constraint)
UPDATE AD_Process SET Help='Execute this function to perform automated drop database constraint operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6a3ee613-efb9-456b-b713-c95e3f99ffe6' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- WebServiceTypeCreateParameters (Create Default Parameters)
UPDATE AD_Process SET Help='Execute this function to perform automated create default parameters operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='2b94e537-3bb4-4e25-8277-13c16061e3a6' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AddAuthorizationProcess (Add Authorization Account)
UPDATE AD_Process SET Description='Executes add authorization account operations', Help='Execute this function to perform automated add authorization account operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c6ba87ce-aa65-4895-b156-5385dfcc6164' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- MFACompleteRegistration (Complete MFA Registration)
UPDATE AD_Process SET Help='Execute this function to perform automated complete mfa registration operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='8f788304-5bcb-4a5d-af28-11b56923995b' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- MFARegister (Register MFA)
UPDATE AD_Process SET Help='Execute this function to perform automated register mfa operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='f8bf7446-35c7-4cea-913f-c41930f7c6fc' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- MFARevokeDevice (Revoke MFA Trusted Device)
UPDATE AD_Process SET Help='Execute this function to perform automated revoke mfa trusted device operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b009ee88-78dd-4adf-97ff-8847464d0bf7' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CopyFromPackOut (Copy from Pack Out)
UPDATE AD_Process SET Help='Execute this function to perform automated copy from pack out operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='65392ae4-8a3e-4a6e-a4ca-e665102df00a' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CreateTable (Create/Complete Table)
UPDATE AD_Process SET Description='Produces new /complete table entries', Help='Execute this function to perform automated create/complete table operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='7920ec21-56c0-4d97-9047-fc97e0f2f562' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_ProjectIssue Process (Process Project Issue)
UPDATE AD_Process SET Description='Finalizes project issue workflow', Help='Execute this function to perform automated process project issue operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='10c5f71a-c84d-43df-87bd-29a4778351ef' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Order_CreateProduction (Create Production from Order)
UPDATE AD_Process SET Help='Execute this function to perform automated create production from order operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='4d1322d4-df18-4cab-a280-82b1c14f35fd' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Invoice_CreateFromProcess (Create lines from Invoice)
UPDATE AD_Process SET Help='Execute this function to perform automated create lines from invoice operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='93b52473-ea26-4bb2-b74e-bb0951dc8e06' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_InOut_CreateFromProcess (Create lines from Shipment/Receipt)
UPDATE AD_Process SET Help='Execute this function to perform automated create lines from shipment/receipt operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='a937803f-8f37-4a08-90b8-f653f48dd421' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_RMA_CreateFromProcess (Create lines from RMA)
UPDATE AD_Process SET Help='Execute this function to perform automated create lines from rma operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9ee08695-597c-44c2-9763-3bfb9356c1d0' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Replication Run (Start Replication Run)
UPDATE AD_Process SET Help='Execute this function to perform automated start replication run operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='69b24840-6d4a-49ac-9e36-66ce942429c6' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_BankTransfer_Process (Process Bank Transfer)
UPDATE AD_Process SET Description='Finalizes bank transfer workflow', Help='Execute this function to perform automated process bank transfer operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='a583c20e-f2df-4edd-af04-d8ab3ce689b7' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- PrintFormatItemSync (Synchronize Print Format based on Report View)
UPDATE AD_Process SET Description='Aligns print format based on report view with external systems', Help='Execute this function to perform automated synchronize print format based on report view operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='30fc78bd-0748-45f5-b74c-72230b9ec89d' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- TestUU Form Report (TestUU Form Report)
UPDATE AD_Process SET Description='Analytical view of testuu form report data', Help='Run this report to obtain testuu form report analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='75f5cbfa-5ac5-4438-98bf-82115d2d5981' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GenerateModel (Generate Model)
UPDATE AD_Process SET Description='Automatically creates model records', Help='Execute this function to perform automated generate model operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='5d3ccc79-089d-485c-af7e-b1d7e79a088a' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Order Process (Process Order)
UPDATE AD_Process SET Description='Finalizes order workflow', Help='Execute this function to perform automated process order operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='27238b60-d1b2-4af8-8536-55a36e228bfa' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- PackRoll (PackRoll)
UPDATE AD_Process SET Description='Executes packroll operations', Help='Execute this function to perform automated packroll operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='05fba72c-0b6e-47fa-a23d-432532731f67' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Asset_Reval_Process (Asset Reval Process)
UPDATE AD_Process SET Description='Finalizes asset reval workflow', Help='Execute this function to perform automated asset reval process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='8d1334c7-213b-4ec2-b532-cfc1fa9300db' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Asset_Disposal (A_Asset_Disposal)
UPDATE AD_Process SET Description='Executes a_asset_disposal operations', Help='Execute this function to perform automated a_asset_disposal operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='bcc77628-6b81-4254-b037-8dab50a11862' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Sequence_No_Update (Update Sequence No)
UPDATE AD_Process SET Description='Refreshes sequence no with current values', Help='Execute this function to perform automated update sequence no operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='578584df-10d6-4be1-9138-b8ed18ccab36' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- S_ExpenseSOrder (Create Sales Orders from Expense)
UPDATE AD_Process SET Help='Execute this function to perform automated create sales orders from expense operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='f0015aa8-7d58-4629-9749-c8bcdb416749' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- S_ExpenseAPInvoice (Create AP Expense Invoices)
UPDATE AD_Process SET Help='Execute this function to perform automated create ap expense invoices operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='ac162096-d8aa-4617-88ef-f9c147ba4700' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Window_Copy (Copy Window Tabs)
UPDATE AD_Process SET Help='Execute this function to perform automated copy window tabs operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='37adc6c3-f6f7-4ae8-831b-0e9136a6b4bc' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Tab_Copy (Copy Tab Fields)
UPDATE AD_Process SET Help='Execute this function to perform automated copy tab fields operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0b73e3f5-bd37-4719-9419-d5b703d782a2' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_Requisition_Process (Process Requisition)
UPDATE AD_Process SET Description='Finalizes requisition workflow', Help='Execute this function to perform automated process requisition operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='f72c1e43-5fe1-479c-b81a-987792215531' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- TabEditor (Tab Editor)
UPDATE AD_Process SET Description='Executes tab editor operations', Help='Execute this function to perform automated tab editor operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0649c86f-a16d-427b-99d3-ee13408ff5c2' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_InvoceBatch_Process (Create Invoices)
UPDATE AD_Process SET Description='Produces new invoices entries', Help='Execute this function to perform automated create invoices operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0781756a-ce55-4ce2-83c8-dc3f482b7322' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- PrepareMigrationScripts (Prepare Migration Scripts)
UPDATE AD_Process SET Description='Executes prepare migration scripts operations', Help='Execute this function to perform automated prepare migration scripts operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='478b0aa9-f0c2-4596-9002-ba8f7563e0b6' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Invoice CopyFrom (Copy Lines)
UPDATE AD_Process SET Help='Execute this function to perform automated copy lines operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='5f984e00-e4e4-4d56-b48b-25fca2069d28' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Order CopyFrom (Copy Lines)
UPDATE AD_Process SET Help='Execute this function to perform automated copy lines operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='37363902-d483-4058-ab7f-8b7d77bad467' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Project CopyFrom (Copy Details)
UPDATE AD_Process SET Help='Execute this function to perform automated copy details operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c46daafe-ece1-4008-960e-57418e3cecba' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_DiscountSchema_ReSeq (Renumber)
UPDATE AD_Process SET Help='Execute this function to perform automated renumber operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='65fde6b5-4931-44c7-b0d0-4392be641c63' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GL_Distribution_Verify (Verify)
UPDATE AD_Process SET Help='Execute this function to perform automated verify operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0f93504f-2e81-4c7c-a8a2-848a0971eb8a' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_MatchInv_Delete (Delete)
UPDATE AD_Process SET Help='Execute this function to perform automated delete operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6d881638-d7d4-41a5-86a6-ffb537654d8e' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_MatchPO_Delete (Delete)
UPDATE AD_Process SET Help='Execute this function to perform automated delete operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b85b665d-8968-4ca7-a7bb-d9d9188df744' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Workflow DocValue (Document Value based Workflows)
UPDATE AD_Process SET Description='Executes document value based workflows operations', Help='Execute this function to perform automated document value based workflows operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e73459e7-f78c-473d-bca4-f2b667fca566' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_ImpFormat Copy (Copy Lines)
UPDATE AD_Process SET Help='Execute this function to perform automated copy lines operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='ff8ad8ab-638c-4c9a-8bae-12bcc8fb2b18' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_NoteDelete (Delete Notices)
UPDATE AD_Process SET Help='Execute this function to perform automated delete notices operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='376258e1-5828-472a-8127-79c6a105d981' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_BankStatement_Process (Process Statement)
UPDATE AD_Process SET Description='Finalizes statement workflow', Help='Execute this function to perform automated process statement operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='d3362175-8f29-449b-8fac-c08518b883cd' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Tree Verify (Verify Tree)
UPDATE AD_Process SET Help='Execute this function to perform automated verify tree operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='5c30580d-2f2b-4f8b-9897-43855ea5deca' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_InvoicePaySchedule Validate (Validate)
UPDATE AD_Process SET Help='Execute this function to perform automated validate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='168be74c-1904-4675-93e3-da5c3d0ee4e5' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_PaymentTerm Validate (Validate)
UPDATE AD_Process SET Help='Execute this function to perform automated validate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='7c924135-8e06-4efa-b0d9-e564e15ebf21' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Import_ConversionRate (Import Conversion Rate)
UPDATE AD_Process SET Help='Execute this function to perform automated import conversion rate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='a601824c-f715-4b43-8e01-0a66ac1f4fdb' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Commission_Process (Generate Commission)
UPDATE AD_Process SET Help='Execute this function to perform automated generate commission operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='65fbd12a-003e-45b3-9ea4-3f36a8e3f5cf' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Cash Process (Process Cash)
UPDATE AD_Process SET Description='Finalizes cash workflow', Help='Execute this function to perform automated process cash operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='2f5d838f-2f67-40af-8c67-db5898c5ff87' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Payment_Process (Process Payment)
UPDATE AD_Process SET Description='Finalizes payment workflow', Help='Execute this function to perform automated process payment operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='aa0eb0f0-7aa2-4c0d-a16d-e343d51fd5fb' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Allocation_Process (Process Allocation)
UPDATE AD_Process SET Description='Finalizes allocation workflow', Help='Execute this function to perform automated process allocation operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='61f95332-8d2e-4884-aa37-99f8b44adf2b' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Payment Online (Online Process)
UPDATE AD_Process SET Description='Finalizes online workflow', Help='Execute this function to perform automated online process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='21598ae6-38b3-4770-a899-adb39a41b7b1' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_PaySelection_CreateFrom (Create From ...)
UPDATE AD_Process SET Description='Produces new from ... entries', Help='Execute this function to perform automated create from ... operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='a2b00c36-b4ff-4064-918e-c7171d9c6615' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- S_TimeExpense_Process (Process Expenses)
UPDATE AD_Process SET Description='Finalizes expenses workflow', Help='Execute this function to perform automated process expenses operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='4cf82299-8ec0-41a7-a197-6b9f4953f01c' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_Inventory Process (Process Inventory Count )
UPDATE AD_Process SET Help='Execute this function to perform automated process inventory count  operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='1b744757-64ad-4b7e-8788-124e44174a3e' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Invoice Process (Process Invoice)
UPDATE AD_Process SET Description='Finalizes invoice workflow', Help='Execute this function to perform automated process invoice operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='a7d363bc-7ee5-4be2-b049-56a2e4021133' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Asset_Transfer_Process (Asset Transfer Process)
UPDATE AD_Process SET Description='Finalizes asset transfer workflow', Help='Execute this function to perform automated asset transfer process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='bcd08a2b-4699-4f40-aa41-fa95eede237b' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Project Close (Close Project)
UPDATE AD_Process SET Description='Executes close project operations', Help='Execute this function to perform automated close project operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c5837ef3-fa01-4585-b413-60156afa99d2' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_ProjectLine Pricing (Get Price)
UPDATE AD_Process SET Help='Execute this function to perform automated get price operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b4b449a1-bfb9-4e6a-8366-d41449cb2882' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Depreciation_Exp_Process (Process Depreciation Expense)
UPDATE AD_Process SET Description='Finalizes depreciation expense workflow', Help='Execute this function to perform automated process depreciation expense operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='3719aed9-c68b-46b3-b313-9d57cdb77805' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CompareCtxHelpSuggestion (Compare Context Help Suggestion)
UPDATE AD_Process SET Description='Executes compare context help suggestion operations', Help='Execute this function to perform automated compare context help suggestion operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='830ac0f4-128c-4e61-9cb7-f2bb6bdcb7d0' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- U_RoleMenu_Update (Update Role Menu)
UPDATE AD_Process SET Description='Refreshes role menu with current values', Help='Execute this function to perform automated update role menu operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='706fddac-6779-4038-a90e-f060879ddf54' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Order RePrice (RePrice Order/Invoice)
UPDATE AD_Process SET Help='Execute this function to perform automated reprice order/invoice operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='1da1a36d-a902-4c0e-b7e5-99906eed4336' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_Product CopyFrom (Copy from product)
UPDATE AD_Process SET Help='Execute this function to perform automated copy from product operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e10ea747-ef48-41d7-9986-cd08fa196ebb' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_RFQ_CopyLines (Copy Lines)
UPDATE AD_Process SET Help='Execute this function to perform automated copy lines operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='34f0ef39-b89e-4969-8daa-3466474a5c87' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Recurring Run (Start Process)
UPDATE AD_Process SET Help='Execute this function to perform automated start process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='d7dbb4b8-f706-4816-bc6b-1091b149ec9a' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Commission_Copy (Copy Lines)
UPDATE AD_Process SET Help='Execute this function to perform automated copy lines operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='83d03305-0213-431f-8aff-3f45ff3f85ad' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_CommissionRun_Process (Create Invoice)
UPDATE AD_Process SET Help='Execute this function to perform automated create invoice operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9a989b12-be2e-4013-889f-0fef48ecf495' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CapturedProcessParameter (Captured Process Parameter)
UPDATE AD_Process SET Description='Finalizes captured  parameter workflow', Help='Execute this function to perform automated captured process parameter operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='cef75223-9f82-4eb3-a2e9-9702eb2f7d69' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GeneratePeriodic (Generate Periodic Plan)
UPDATE AD_Process SET Description='Automatically creates periodic plan records', Help='Execute this function to perform automated generate periodic plan operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b6f89812-9e3d-4527-8f56-c55b26ab214a' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- R_Request_ReOpen (Reopen Request)
UPDATE AD_Process SET Help='Execute this function to perform automated reopen request operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6f0b4763-8497-4b58-842e-bef3b75a937a' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_DunningRun_Create (Create Dunning Run)
UPDATE AD_Process SET Help='Execute this function to perform automated create dunning run operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='4fd85d10-e0a1-4cb7-a828-b24e294b87d2' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Order Open (Reopen Order)
UPDATE AD_Process SET Help='Execute this function to perform automated reopen order operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='cb9c7c2d-28fa-45e0-80f7-8c1af0b9579e' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_BankStatement Match (Match Bank Statement)
UPDATE AD_Process SET Help='Execute this function to perform automated match bank statement operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e37b19f7-aec4-44f6-88ca-9a77d1025187' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_RMA_Process (Process RMA)
UPDATE AD_Process SET Description='Finalizes rma workflow', Help='Execute this function to perform automated process rma operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='000080e9-d8a9-4944-a767-98e57d2ed5e3' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_MovementConfirm_Process (Process Confirmation)
UPDATE AD_Process SET Help='Execute this function to perform automated process confirmation operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b6a41c73-1c94-4139-895b-90d9ccc9b3e1' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_RFQResponse_CComplete (Check Complete)
UPDATE AD_Process SET Help='Execute this function to perform automated check complete operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b5b5606c-d86e-4243-b94d-aa02ea8bbd97' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_InOutConfirm_Process (Process Confirmation)
UPDATE AD_Process SET Description='Finalizes confirmation workflow', Help='Execute this function to perform automated process confirmation operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='dc649052-24df-42ac-8c13-598931fe5db5' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Period_Process (Open/Close All)
UPDATE AD_Process SET Help='Execute this function to perform automated open/close all operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='07d4c383-6ec3-4434-85f4-ea5cdda82c61' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_PeriodControl_Process (Open/Close)
UPDATE AD_Process SET Help='Execute this function to perform automated open/close operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='55a15dd4-443f-4b23-843e-9add4008efc9' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GL_Journal_Process (Process Journal)
UPDATE AD_Process SET Description='Finalizes journal workflow', Help='Execute this function to perform automated process journal operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='91376691-d9f3-452b-9bb3-b0d5bb3f46af' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- PackOut (PackOut)
UPDATE AD_Process SET Help='Execute this function to perform automated packout operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='f50337ec-3fb6-44f0-8bca-a7738430c104' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- File_Select (File_Select)
UPDATE AD_Process SET Help='Execute this function to perform automated file_select operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c3c90df5-2fb5-49fe-a8a9-9625e52747aa' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GL_JournalBatch CopyFrom (Copy Details)
UPDATE AD_Process SET Help='Execute this function to perform automated copy details operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='62d684ab-cc2e-4920-8f82-9b8ae6cd7e31' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CM_CStage_Validate (Validate)
UPDATE AD_Process SET Help='Execute this function to perform automated validate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='31d4eef1-60ad-4fd5-aba6-1100824fe7b7' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CM_Template_Validate (Validate)
UPDATE AD_Process SET Help='Execute this function to perform automated validate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='36a1dce4-9fb6-4c2b-872b-37792eded9c0' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CM_Media_DirectDeploy (Media Direct Deploy)
UPDATE AD_Process SET Description='Executes media direct deploy operations', Help='Execute this function to perform automated media direct deploy operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='7c4a4226-1229-4909-806c-c6f4129a86fb' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_DocTypeCounter Validate (Validate Document Type)
UPDATE AD_Process SET Description='Checks integrity of document type', Help='Execute this function to perform automated validate document type operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='d221db45-eb1f-4c77-ad47-376d2558ab2d' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_CashPlan CopyFrom (Copy from Cash Plan)
UPDATE AD_Process SET Help='Execute this function to perform automated copy from cash plan operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9178c519-2276-4804-8d1e-efc58024ed8c' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Table_CopyColumnsFromTable (Copy Columns from Table)
UPDATE AD_Process SET Help='Execute this function to perform automated copy columns from table operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='db9d938e-4adb-4f1d-9bed-8d1030b4f6db' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Request EMail Processor (Request EMail Processor)
UPDATE AD_Process SET Description='Finalizes request email or workflow', Help='Execute this function to perform automated request email processor operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='f7185c17-ef26-4931-9d5c-9647649ddf04' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_PrintPaper_Default (Set Print Format)
UPDATE AD_Process SET Help='Execute this function to perform automated set print format operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='29462734-8585-4ff9-9b78-68fe6825b07d' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_InOut_GenerateRMA (Manual) (Generate Shipments for Vendor RMA)
UPDATE AD_Process SET Help='Execute this function to perform automated generate shipments for vendor rma operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='57f2b6af-d376-41b6-8b6f-a947283cb2d6' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Depreciation_Entry_Process (Process Depreciation Entry)
UPDATE AD_Process SET Description='Finalizes depreciation entry workflow', Help='Execute this function to perform automated process depreciation entry operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='fc7ef5a4-dca3-4f2a-a542-ca5473990d3f' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ASP Generate Fields (ASP Generate Fields)
UPDATE AD_Process SET Description='Automatically creates asp  fields records', Help='Execute this function to perform automated asp generate fields operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='1827684d-1b7e-473e-aaf4-71be5b98997c' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ASP Generate Level (ASP Generate Level)
UPDATE AD_Process SET Description='Automatically creates asp  level records', Help='Execute this function to perform automated asp generate level operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b6059bd3-d8eb-4574-a67a-8f9fb45e37ab' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ApplyMigrationScripts (Apply Migration Scripts)
UPDATE AD_Process SET Description='Executes apply migration scripts operations', Help='Execute this function to perform automated apply migration scripts operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='d8436335-4b9f-4cd5-a99c-028d730c8730' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Invoice_GenerateRMA (Manual) (Generate Invoices for RMA)
UPDATE AD_Process SET Help='Execute this function to perform automated generate invoices for rma operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='12b21258-b13a-446a-92a0-9ee4c1e12de7' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- FactAcctSummary (Recalculate Cube)
UPDATE AD_Process SET Help='Execute this function to perform automated recalculate cube operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='d6794edd-6197-4257-9325-9553d7e59911' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_OrderPaySchedule Validate (Validate)
UPDATE AD_Process SET Help='Execute this function to perform automated validate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='2efcbf26-2593-4a01-8e79-d1edf0533cc1' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_TaxDeclaration Create (Create Tax Declaration)
UPDATE AD_Process SET Help='Execute this function to perform automated create tax declaration operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9cf3ae9d-4ffc-488f-a3c4-468dad59ff48' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AcceptFieldSuggestion (Accept Field Suggestion)
UPDATE AD_Process SET Help='Execute this function to perform automated accept field suggestion operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='1227719d-e257-4780-b5dd-56eade790ac3' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- X_DepositBatch Close (Deposit Batch Close)
UPDATE AD_Process SET Description='Executes deposit batch close operations', Help='Execute this function to perform automated deposit batch close operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='204960ea-1515-48ad-be88-93bdd8100f01' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- HouseKeeping (House Keeping)
UPDATE AD_Process SET Description='Executes house keeping operations', Help='Execute this function to perform automated house keeping operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9fac01d6-52bb-4c97-ae86-c9e14d2bc2c9' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Asset_Process_Entry (Process Entry)
UPDATE AD_Process SET Description='Finalizes entry workflow', Help='Execute this function to perform automated process entry operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='49c4709d-75a2-43ac-9d4e-662225163da4' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ImmediateBankTransfer (Immediate Bank Transfer)
UPDATE AD_Process SET Description='Executes immediate bank transfer operations', Help='Execute this function to perform automated immediate bank transfer operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b71f69a6-0a28-478e-ac2c-09c720f3e428' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Depreciation_Transfer (A_Depreciation_Transfer)
UPDATE AD_Process SET Description='Executes a_depreciation_transfer operations', Help='Execute this function to perform automated a_depreciation_transfer operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e877354f-6bd7-459d-a520-22026719367a' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Build_Depr_Workfile (Build Depreciation Workfile)
UPDATE AD_Process SET Description='Executes build depreciation workfile operations', Help='Execute this function to perform automated build depreciation workfile operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0be5b699-8842-4982-a175-89b8bac461e9' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- HouseKeepingPara (HouseKeeping)
UPDATE AD_Process SET Description='Executes housekeeping operations', Help='Execute this function to perform automated housekeeping operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='68deb537-19a6-4363-b0fa-3cd7154c3cd6' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- UUIDGenerator (UUID Generator)
UPDATE AD_Process SET Description='Executes uuid generator operations', Help='Execute this function to perform automated uuid generator operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='990fe023-a524-4381-ae27-30cf948882f4' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Create_Function (Create Depreciation Function)
UPDATE AD_Process SET Description='Produces new depreciation function entries', Help='Execute this function to perform automated create depreciation function operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='39f1d664-feff-4561-8578-9dec6e08a631' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Depreciation_Entry_Cleanup (A_Depreciation_Entry_Cleanup)
UPDATE AD_Process SET Description='Executes a_depreciation_entry_cleanup operations', Help='Execute this function to perform automated a_depreciation_entry_cleanup operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='60b5e230-9b80-4c81-9d5d-a4aaf92eb536' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Import_Price_List (Import Price Lists)
UPDATE AD_Process SET Help='Execute this function to perform automated import price lists operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='cf475e01-6aae-4953-ac84-2b09d0ebb4be' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Asset_Adition_Process (Asset Addition Process)
UPDATE AD_Process SET Description='Finalizes asset addition workflow', Help='Execute this function to perform automated asset addition process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='38ad0704-5ba9-4a6a-83e2-a65054b4c080' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_InOut_Generate (manual) (Generate Shipments (manual))
UPDATE AD_Process SET Help='Execute this function to perform automated generate shipments (manual) operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='51a4f97b-eb48-4f4f-8057-14bbdcb6509a' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GLJournalGenerate (Generate GL Journal)
UPDATE AD_Process SET Description='Automatically creates gl journal records', Help='Execute this function to perform automated generate gl journal operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='8498cbf2-63fe-4ebf-b3c7-e2146c7d5b0e' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Depreciation_Workfile_Build (Update depreciation)
UPDATE AD_Process SET Description='Refreshes depreciation with current values', Help='Execute this function to perform automated update depreciation operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='1c33a3db-41e3-427d-b001-10b00a70575b' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CompareFieldSuggestion (Compare Field Suggestion)
UPDATE AD_Process SET Description='Executes compare field suggestion operations', Help='Execute this function to perform automated compare field suggestion operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='3862a0d5-263d-479b-8c5e-f0db5c26cd6a' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Issue Report (Report or Update Issue)
UPDATE AD_Process SET Help='Execute this function to perform automated report or update issue operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c0a42835-98c7-471b-bab4-b834ad4c83ae' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- GL_Journal CopyFrom (Copy Details)
UPDATE AD_Process SET Help='Execute this function to perform automated copy details operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='62334744-2579-4453-a990-4e030c603e9f' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_POSKeyGenerate (POS Key Generate)
UPDATE AD_Process SET Help='Execute this function to perform automated pos key generate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='d948cffa-5a5c-4dda-86fc-2e09382123fc' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Kill Current Session (Kill Current Session)
UPDATE AD_Process SET Description='Executes kill current session operations', Help='Execute this function to perform automated kill current session operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='1b4a0890-2e4b-4e20-be55-d0248ec4e4c6' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Kill All Session (Kill All Session)
UPDATE AD_Process SET Description='Executes kill all session operations', Help='Execute this function to perform automated kill all session operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='06a44cb0-5782-475b-aeab-63429829c708' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Asset_Split (A_Asset_Split)
UPDATE AD_Process SET Description='Executes a_asset_split operations', Help='Execute this function to perform automated a_asset_split operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6d4511de-6de8-4d62-aca3-e869b7422edf' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Import_FixedAsset (Import Fixed Assets)
UPDATE AD_Process SET Description='Loads fixed assets records from external sources', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='b48a9168-4ed0-4f4b-b291-a0c50fd93ecf' AND ((Description IS NULL OR Description LIKE '** Special%')) AND EntityType='D';

-- M_Product_BOM Substitute (Universal substitution)
UPDATE AD_Process SET Help='Execute this function to perform automated universal substitution operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='08bf9a66-cd12-431c-b8eb-6ffb8f9be39a' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_OrderLine_CreateProduction (Create Production from Order Line)
UPDATE AD_Process SET Help='Execute this function to perform automated create production from order line operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='bdd3b2a7-26a0-426b-bd08-632c31635d1f' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_OrderLine_CreateShipment (Create Shipment from Order Line)
UPDATE AD_Process SET Help='Execute this function to perform automated create shipment from order line operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='780bfd00-d0d0-4bff-a34d-69939ab05269' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_PaymentTransaction VoidIt (Void Online Authorization Payment Transaction Process)
UPDATE AD_Process SET Description='Finalizes void online authorization payment transaction workflow', Help='Execute this function to perform automated void online authorization payment transaction process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='3b09d6d9-a658-4f51-899e-109faca70c03' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_MatchInv_Reversal (Reverse Invoice Matching)
UPDATE AD_Process SET Description='Pairs related reverse invoice ing records', Help='Execute this function to perform automated reverse invoice matching operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='bbb372e3-138e-4425-9f8c-bfbd1e73a666' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_MatchPO_Reversal (Reverse PO Matching)
UPDATE AD_Process SET Description='Pairs related reverse po ing records', Help='Execute this function to perform automated reverse po matching operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='c3c3698b-82ca-4686-9d92-0ffc83c10bf6' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Shipping_Rate_Inquiry (Online Shipping Rate Inquiry)
UPDATE AD_Process SET Description='Executes online shipping rate inquiry operations', Help='Execute this function to perform automated online shipping rate inquiry operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9a9693e8-bb49-4547-ba07-21c5c611c413' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Void_Shipment_Process (Void Shipment Online)
UPDATE AD_Process SET Help='Execute this function to perform automated void shipment online operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='83b70c37-65cc-4cbc-8b3f-f5af81244c85' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Online_Shipment_Process (Process Shipment Online)
UPDATE AD_Process SET Help='Execute this function to perform automated process shipment online operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='8e10c966-d69a-41cb-9ee9-8cb9ad22300c' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_Shipper_CreateFrom (Shipper Create From ...)
UPDATE AD_Process SET Description='Produces new shipper  from ... entries', Help='Execute this function to perform automated shipper create from ... operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='29b13884-19ad-4e9a-b6c4-0746dbf3bfaa' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- X_Shipper_CopyFrom (Shipper Copy From ...)
UPDATE AD_Process SET Description='Duplicates shipper  from ... with new identifiers', Help='Execute this function to perform automated shipper copy from ... operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='0005674b-9c5e-4523-ac73-4739b2bb8256' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- Shipping_Sales_Order_Rate_Inquiry (Online Shipping Sales Order Rate Inquiry)
UPDATE AD_Process SET Description='Executes online shipping sales order rate inquiry operations', Help='Execute this function to perform automated online shipping sales order rate inquiry operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='755ce796-85af-4ac3-b789-4a40fc3c533c' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_Package_Create (Create Package)
UPDATE AD_Process SET Help='Execute this function to perform automated create package operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6ed6353d-b0e3-4ea0-815c-823cd1173425' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_TestBroadcastMessage (Test Broadcast Message)
UPDATE AD_Process SET Help='Execute this function to perform automated test broadcast message operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='43c7fcd3-d271-45c2-a348-55caef5f8f06' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- VerifyLanguageConfiguration (Verify Language Configuration)
UPDATE AD_Process SET Description='Checks integrity of language configuration', Help='Execute this function to perform automated verify language configuration operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='448fa1f7-ca47-400e-b535-4827974e705d' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RecurringRun (Recurring Run)
UPDATE AD_Process SET Help='Execute this function to perform automated recurring run operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='ba956f25-b184-4087-a016-089b44efd3bc' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_BankStatement CreateFromBatch (Bank Statement Create From Batch)
UPDATE AD_Process SET Description='Produces new bank statement  from batch entries', Help='Execute this function to perform automated bank statement create from batch operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='986e4432-909a-4ca4-a838-0868f7d022a7' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_BankStatement CopyFrom (Copy Lines)
UPDATE AD_Process SET Help='Execute this function to perform automated copy lines operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='7f5402d4-9b91-4ac8-9bcd-a5b6b995d918' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- A_Asset_Disposed_Process (Asset Disposed Process)
UPDATE AD_Process SET Description='Finalizes asset disposed workflow', Help='Execute this function to perform automated asset disposed process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='10d75dce-5b1c-427f-bc1d-d6884dc679ad' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CostAdjustmentLine_RefreshCurrentCost (Refresh Current Cost)
UPDATE AD_Process SET Help='Execute this function to perform automated refresh current cost operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='69348301-fc79-40b9-9df4-3bf90b9b317a' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_TableIndex Validate (Index Validate)
UPDATE AD_Process SET Description='Checks integrity of index', Help='Execute this function to perform automated index validate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='29b63e30-e25b-49af-8d37-25dddf8ce4ac' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_ViewComponent Validate (View Validate)
UPDATE AD_Process SET Description='Checks integrity of view', Help='Execute this function to perform automated view validate operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='67e62e7b-2f5e-49b2-ae7d-234e42d4074f' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CreateTableIndex (Create Table Index)
UPDATE AD_Process SET Description='Produces new table index entries', Help='Execute this function to perform automated create table index operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='11d63490-997c-423d-b332-893132874f78' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CreateForeignKey (Create Foreign Key)
UPDATE AD_Process SET Description='Produces new foreign key entries', Help='Execute this function to perform automated create foreign key operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='a3b56b92-5704-48f7-b05a-c82adc965c1e' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ValidateTaxProviderConnection (Validate Connection)
UPDATE AD_Process SET Description='Checks integrity of connection', Help='Execute this function to perform automated validate connection operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='3bfaa349-780c-4fdd-96c1-0e7fa276abc0' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ValidateAddressProcess (Validate Address)
UPDATE AD_Process SET Description='Checks integrity of address', Help='Execute this function to perform automated validate address operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='229ecec4-5f94-4df1-9670-b8b8a64c257f' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- TableIndexDrop (Drop Table Index)
UPDATE AD_Process SET Description='Executes drop table index operations', Help='Execute this function to perform automated drop table index operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e93b81bb-e3a1-4fb4-b825-39ebfbbe212f' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_ViewComponent Drop (Drop view)
UPDATE AD_Process SET Description='Executes drop view operations', Help='Execute this function to perform automated drop view operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='8d781c31-93a6-435d-a9c3-eb393d1cf2f3' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CopyInfoWindowColumns (Copy Info Window Columns)
UPDATE AD_Process SET Description='Duplicates info window columns with new identifiers', Help='Execute this function to perform automated copy info window columns operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='32fe7794-53ce-442d-bb40-a132ebcdff7e' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- M_Production Process (Process Production)
UPDATE AD_Process SET Description='Finalizes production workflow', Help='Execute this function to perform automated process production operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='6ce10946-4f1c-4781-b03a-9da4c7a35faf' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- ImportCSVProcess (Import CSV Process)
UPDATE AD_Process SET Description='Loads csv process records from external sources', Help='Execute this function to perform automated import csv process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='95ee94ea-d050-4f20-b4f3-1b6776df6d62' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_Project_GenerateProduction (Generate Production from Project)
UPDATE AD_Process SET Help='Execute this function to perform automated generate production from project operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='542a66f7-afe0-493e-90d4-a91e10f17ac8' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AD_Table_CopyComponentsFromView (Copy Components From View)
UPDATE AD_Process SET Help='Execute this function to perform automated copy components from view operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='ebc55ee4-a02a-4505-9063-ae687e37ed6c' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RejectFieldSuggestion (Reject Field Suggestion)
UPDATE AD_Process SET Help='Execute this function to perform automated reject field suggestion operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='a539ee7a-4729-4f44-be34-0a5dc25d374d' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- AcceptCtxHelpSuggestion (Accept Context Help Suggestion)
UPDATE AD_Process SET Help='Execute this function to perform automated accept context help suggestion operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='dbabdf46-c3bc-4e02-ab0a-f61f6ae60b4b' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- RejectCtxHelpSuggestion (Reject Context Help Suggestion)
UPDATE AD_Process SET Help='Execute this function to perform automated reject context help suggestion operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='9e375e8d-dfff-446d-be92-8a6104c76717' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_BankStatement BankTransfer (Bank/Cash Transfer Process)
UPDATE AD_Process SET Help='Execute this function to perform automated bank/cash transfer process operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='cfeb1183-014b-404e-897e-15c045cdae49' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CleanOrphanCascade (Clean Orphan Cascade Records)
UPDATE AD_Process SET Description='Executes clean orphan cascade records operations', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='d3826a84-1467-4d6e-931b-e395f349f60c' AND ((Description IS NULL OR Description LIKE '** Special%')) AND EntityType='D';

-- InitialClientSetup (Initial Tenant Setup)
UPDATE AD_Process SET Description='Executes initial tenant setup operations', Help='Execute this function to perform automated initial tenant setup operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='1dc3b01b-1ff1-4fd3-b6ff-d0af0a41bee6' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- TestUUChangeActive (Switch Active Flag on this Test UU and its Details)
UPDATE AD_Process SET Description='Executes switch active flag on this test uu and its details operations', Help='Execute this function to perform automated switch active flag on this test uu and its details operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='eb8d0521-c103-433d-9cad-071968a4d923' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- DeleteTraceLogs (Delete Trace Logs)
UPDATE AD_Process SET Help='Execute this function to perform automated delete trace logs operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='5a390947-e117-4616-a4da-64ada7c19211' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- K_Index_ReRun (Rebuild Index)
UPDATE AD_Process SET Description='Executes rebuild index operations', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='63a97a84-9932-4163-afa5-e0ab81128107' AND ((Description IS NULL OR Description LIKE '** Special%')) AND EntityType='D';

-- RV_Asset_Transfer_Entry (Asset Transfer Entry)
UPDATE AD_Process SET Help='Run this report to obtain asset transfer entry analysis for review and decision-making.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='09a3ace1-c2a2-4914-9de8-cf138d401020' AND ((Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- CustomizeGridViewWindowCustomization (Customize Grid View)
UPDATE AD_Process SET Description='Executes customize grid view operations', Help='Execute this function to perform automated customize grid view operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='2f37ad7c-9077-4e58-8fbc-52726be2a85a' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

-- C_DepositBatch_Process (Process Deposit Batch)
UPDATE AD_Process SET Description='Finalizes deposit batch workflow', Help='Execute this function to perform automated process deposit batch operations in bulk.', Updated=NOW(), UpdatedBy=100 WHERE AD_Process_UU='e0b1e41b-3df9-4ad2-8651-19831e5a8c88' AND ((Description IS NULL OR Description LIKE '** Special%') OR (Help IS NULL OR Help LIKE '** Special%')) AND EntityType='D';

