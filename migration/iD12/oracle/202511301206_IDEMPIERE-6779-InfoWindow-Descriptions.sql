-- AD_InfoWindow descriptions
-- Info Windows: 17

SELECT register_migration_script('202511301206_IDEMPIERE-6779-InfoWindow-Descriptions.sql') FROM dual;

-- =============================================
-- AD_InfoWindow (17 records)
-- =============================================

-- Product Info
UPDATE AD_InfoWindow SET Description='Search and select product records', Help='The Product Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='30a3f498-24bf-48fb-b441-27a121494091' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Business Partner Info
UPDATE AD_InfoWindow SET Description='Search and select business partner records', Help='The Business Partner Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='bdb6ccb3-1aed-4b9e-92f4-9db792480cb4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Order Info
UPDATE AD_InfoWindow SET Description='Search and select order records', Help='The Order Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='9a8cdbc5-2563-47ac-9f64-971723128db5' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Invoice Info
UPDATE AD_InfoWindow SET Description='Search and select invoice records', Help='The Invoice Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='2fa03895-f3d2-441f-bcba-5e7854260e53' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Shipment Info
UPDATE AD_InfoWindow SET Description='Search and select shipment records', Help='The Shipment Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='65ce8228-dafb-4597-a74c-e2315d5882c2' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Payment Info
UPDATE AD_InfoWindow SET Description='Search and select payment records', Help='The Payment Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='87b9dee7-f07c-46b7-acb2-f8ac48928f4b' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Resource Info
UPDATE AD_InfoWindow SET Description='Search and select resource records', Help='The Resource Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='a79f55fb-97b0-4fb1-b666-43148ad82a08' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Asset Info
UPDATE AD_InfoWindow SET Description='Search and select asset records', Help='The Asset Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='ee3c56b0-7ce6-4a87-8e2d-8f3949b44cfe' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Role (All)
UPDATE AD_InfoWindow SET Description='Information lookup for role (all)', Help='The Role (All) window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='927cfb7d-e612-4a3b-a2dd-7799cfc08f80' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Support Users vs Roles
UPDATE AD_InfoWindow SET Description='Information lookup for support users vs roles', Help='The Support Users vs Roles window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='ede4d13f-fefc-4de6-843b-3236c1941ce4' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Generate Invoices (manual)
UPDATE AD_InfoWindow SET Help='The Generate Invoices (manual) window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='8c19258d-2180-44e4-bbb3-2808f18319bc' AND (Help IS NULL) AND EntityType='D';

-- Generate Shipments (manual)
UPDATE AD_InfoWindow SET Help='The Generate Shipments (manual) window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='240e290d-77ce-40bb-8f27-a9cfd46746d3' AND (Help IS NULL) AND EntityType='D';

-- Create lines from Invoice
UPDATE AD_InfoWindow SET Description='Information lookup for create lines from invoice', Help='The Create lines from Invoice window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='f63ba82b-c657-4038-bf4c-94c47e9a1bed' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Create lines from RMA
UPDATE AD_InfoWindow SET Description='Information lookup for create lines from RMA', Help='The Create lines from RMA window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='ddab41b3-89e7-4c64-80e7-12903e39730d' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Create lines from Shipment/Receipt
UPDATE AD_InfoWindow SET Description='Information lookup for create lines from shipment/receipt', Help='The Create lines from Shipment/Receipt window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='59c1afd6-d5c4-4afd-9e20-88bb78048923' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

-- Period Control Management
UPDATE AD_InfoWindow SET Help='The Period Control Management window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='7c79d781-b8d6-484d-b15a-896e1b08087b' AND (Help IS NULL) AND EntityType='D';

-- Payment Into Batch Info
UPDATE AD_InfoWindow SET Description='Search and select payment into batch records', Help='The Payment Into Batch Info window provides search functionality for locating and selecting records. Use the search criteria to filter results and double-click to select.', Updated=SYSDATE, UpdatedBy=100 WHERE AD_InfoWindow_UU='7f250d6a-7f8d-4d49-86cd-25a6fb822568' AND (Description IS NULL OR Help IS NULL) AND EntityType='D';

