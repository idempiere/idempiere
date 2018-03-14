-- IDEMPIERE-234 Move some buttons back to window - DocAction/RecordID/Posted/CreateFrom + Buttons that are mandatory or very used on each window
-- Move to toolbar
update ad_column set istoolbarbutton='Y' where ad_column_id=55415 -- Asset / Asset Balances / Update depreciation
;

update ad_column set istoolbarbutton='Y' where ad_column_id=200846 -- Online Transaction History / Online Transaction History / Record ID
;

update ad_column set istoolbarbutton='Y' where ad_column_id=200807 -- Payment Transaction / Payment Transaction / Void It
;

update ad_column set istoolbarbutton='Y' where ad_column_id=12113 -- Return to Vendor / Return to Vendor / Create Package
;

update ad_column set istoolbarbutton='Y' where ad_column_id=206766 -- Sales Order / Order / Online Shipping Sales Order Rate Inquiry
;

update ad_column set istoolbarbutton='Y' where ad_column_id=201197 -- Shipment (Customer) / MPS Lines / Create lines from
;

update ad_column set istoolbarbutton='Y' where ad_column_id=12113 -- Shipment (Customer) / Shipment / Create Package
;

update ad_column set istoolbarbutton='Y' where ad_column_id=201197 -- Shipment Package / MPS Lines / Create lines from
;

update ad_column set istoolbarbutton='Y' where ad_column_id=202145 -- Shipper / Shipper / Shipper Create From ...
;

update ad_column set istoolbarbutton='Y' where ad_column_id=205538 -- Shipper Configuration / Shipper / Shipper Copy From ...
;

update ad_column set istoolbarbutton='Y' where ad_column_id=205538 -- Shipping Processor Configuration / Shipper / Shipper Copy From ...
;

-- Move to window
update ad_column set istoolbarbutton='N' where ad_column_id=11873 -- Access Audit / Access Audit / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=5103 -- Accounting Fact Details / Accounting / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=53833 -- Activity Control Report / Activity Control / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=53817 -- Activity Control Report / Activity Control / Process Cost Collector
;

update ad_column set istoolbarbutton='N' where ad_column_id=54193 -- ASP Modules / Level / ASP Generate Level
;

update ad_column set istoolbarbutton='N' where ad_column_id=54116 -- ASP Modules / Tab / ASP Generate Fields
;

update ad_column set istoolbarbutton='N' where ad_column_id=59452 -- Asset / Activation/Addition / Asset Addition Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=59480 -- Asset Activation/Disposal / Asset Disposal/Activation / Asset Disposed Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=59492 -- Asset Activation/Disposal / Asset Disposal/Activation / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=59452 -- Asset Addition / Addition / Asset Addition Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=59477 -- Asset Addition / Addition / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=59346 -- Asset Change Account / Asset Change account / Asset Transfer Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=59348 -- Asset Change Account / Asset Change account / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=2097 -- Attachment / Attachment / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=5515 -- Bank Statement / Bank Statement / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=4925 -- Bank Statement / Bank Statement / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=12461 -- Bank Statement / Bank Statement / Process Statement
;

update ad_column set istoolbarbutton='N' where ad_column_id=200993 -- Broadcast Message / Broadcast Message / Publish Broadcast message
;

update ad_column set istoolbarbutton='N' where ad_column_id=200992 -- Broadcast Message / Broadcast Message / Test Brodcast Message
;

update ad_column set istoolbarbutton='N' where ad_column_id=5958 -- Broadcast Message / Message Log / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=5000 -- Business Partner Group / Accounting / Copy Accounts
;

update ad_column set istoolbarbutton='N' where ad_column_id=5944 -- Calendar Year and Period / Period / Open/Close All
;

update ad_column set istoolbarbutton='N' where ad_column_id=2355 -- Calendar Year and Period / Period Control / Open/Close
;

update ad_column set istoolbarbutton='N' where ad_column_id=2410 -- Calendar Year and Period / Year / Create Periods 
;

update ad_column set istoolbarbutton='N' where ad_column_id=8817 -- Change Audit / Change Audit / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=14083 -- Client / Client / Test EMail
;

update ad_column set istoolbarbutton='N' where ad_column_id=5683 -- Commission / Commission / Generate Commission
;

update ad_column set istoolbarbutton='N' where ad_column_id=5814 -- Commission Run / Commission Run / Create Invoice
;

update ad_column set istoolbarbutton='N' where ad_column_id=53833 -- Cost Collector / Collector Cost / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=53817 -- Cost Collector / Collector Cost / Process Cost Collector
;

update ad_column set istoolbarbutton='N' where ad_column_id=5352 -- Customer Return / Customer Return / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=6534 -- Customer Return / Customer Return / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=4324 -- Customer Return / Customer Return / Process Shipment 
;

update ad_column set istoolbarbutton='N' where ad_column_id=208381 -- Customer RMA / Customer RMA / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=52006 -- Customer RMA / Customer RMA / Create Order From RMA
;

update ad_column set istoolbarbutton='N' where ad_column_id=12120 -- Customer RMA / Customer RMA / Process RMA
;

update ad_column set istoolbarbutton='N' where ad_column_id=53891 -- Distribution Order / Distribution Order / Process Distribution Order
;

update ad_column set istoolbarbutton='N' where ad_column_id=12567 -- Dunning Run / Dunning Run / Create Dunning Run
;

update ad_column set istoolbarbutton='N' where ad_column_id=12282 -- Expense Report / Expense Report / Process Expenses
;

update ad_column set istoolbarbutton='N' where ad_column_id=5998 -- Financial Report / Financial Report / Create Report
;

update ad_column set istoolbarbutton='N' where ad_column_id=54092 -- Financial Report / Financial Report / Create Report (Jasper)
;

update ad_column set istoolbarbutton='N' where ad_column_id=11653 -- GL Distribution / Distribution / Verify
;

update ad_column set istoolbarbutton='N' where ad_column_id=1629 -- GL Journal / Journal / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=1789 -- GL Journal / Journal / Process Journal
;

update ad_column set istoolbarbutton='N' where ad_column_id=12076 -- GL Journal Batch / Batch / Process Batch
;

update ad_column set istoolbarbutton='N' where ad_column_id=1629 -- GL Journal Batch / Journal / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=200509 -- GL Journal Generator / GL Journal Generator / Generate GL Journal
;

update ad_column set istoolbarbutton='N' where ad_column_id=56344 -- House Keeping / House Keeping / House Keeping
;

update ad_column set istoolbarbutton='N' where ad_column_id=6535 -- Internal Use Inventory / Internal Use / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=12412 -- Internal Use Inventory / Internal Use / Process Inventory Count 
;

update ad_column set istoolbarbutton='N' where ad_column_id=6536 -- Inventory Move / Move / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=10797 -- Inventory Move / Move / Process Movements
;

update ad_column set istoolbarbutton='N' where ad_column_id=4649 -- Invoice (Customer) / Invoice / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=3495 -- Invoice (Customer) / Invoice / Process Invoice
;

update ad_column set istoolbarbutton='N' where ad_column_id=10324 -- Invoice (Customer) / Payment Schedule / Validate
;

update ad_column set istoolbarbutton='N' where ad_column_id=5351 -- Invoice (Vendor) / Invoice / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=4649 -- Invoice (Vendor) / Invoice / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=3495 -- Invoice (Vendor) / Invoice / Process Invoice
;

update ad_column set istoolbarbutton='N' where ad_column_id=14191 -- Invoice (Vendor) / Landed Costs / Distribute Costs
;

update ad_column set istoolbarbutton='N' where ad_column_id=6512 -- Invoice (Vendor) / Matched Receipts / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=10324 -- Invoice (Vendor) / Payment Schedule / Validate
;

update ad_column set istoolbarbutton='N' where ad_column_id=10324 -- Invoice Payment Schedule / Payment Schedule / Validate
;

update ad_column set istoolbarbutton='N' where ad_column_id=6574 -- Language / Language / Language Maintenance
;

update ad_column set istoolbarbutton='N' where ad_column_id=53645 -- Manufacturing Order / Manufacturing Order / Process Manufacturing Order
;

update ad_column set istoolbarbutton='N' where ad_column_id=6512 -- Matched Invoices / Match Invoice / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=6528 -- Matched Purchase Orders / Match PO / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=5352 -- Material Receipt / Material Receipt / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=6534 -- Material Receipt / Material Receipt / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=4324 -- Material Receipt / Material Receipt / Process Shipment 
;

update ad_column set istoolbarbutton='N' where ad_column_id=12449 -- Move Confirmation / Confirmation / Process Confirmation
;

update ad_column set istoolbarbutton='N' where ad_column_id=5958 -- MRP Notice (all) / Notice / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=5958 -- MRP Notice / Notice / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=57937 -- My Unprocessed Documents / Unprocessed Documents / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=5958 -- Notice / Notice / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=50177 -- Pack In / PackIn / PackIn
;

update ad_column set istoolbarbutton='N' where ad_column_id=50093 -- Pack Out / Export Package / Export Package
;

update ad_column set istoolbarbutton='N' where ad_column_id=4712 -- Parts and BOMs / Part / Verify BOM Structure
;

update ad_column set istoolbarbutton='N' where ad_column_id=5356 -- Payment / Payment / Online Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=5042 -- Payment / Payment / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=5497 -- Payment / Payment / Process Payment
;

update ad_column set istoolbarbutton='N' where ad_column_id=5042 -- Payment Batch / Payment / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=5650 -- Payment Selection / Payment Selection / Create From ...
;

update ad_column set istoolbarbutton='N' where ad_column_id=5624 -- Payment Selection / Payment Selection / Prepare Payment
;

update ad_column set istoolbarbutton='N' where ad_column_id=10332 -- Payment Term / Payment Term / Validate
;

update ad_column set istoolbarbutton='N' where ad_column_id=3817 -- Physical Inventory / Inventory Count / Create Inventory Count List 
;

update ad_column set istoolbarbutton='N' where ad_column_id=6535 -- Physical Inventory / Inventory Count / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=12412 -- Physical Inventory / Inventory Count / Process Inventory Count 
;

update ad_column set istoolbarbutton='N' where ad_column_id=59449 -- Post Depreciation Entry / Create Depreciation Entry / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=59447 -- Post Depreciation Entry / Create Depreciation Entry / Process Depreciation Entry
;

update ad_column set istoolbarbutton='N' where ad_column_id=3744 -- Price List / Version / Create Price List 
;

update ad_column set istoolbarbutton='N' where ad_column_id=200321 -- Process Audit / Log / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=4712 -- Product / Product / Verify BOM Structure
;

update ad_column set istoolbarbutton='N' where ad_column_id=5124 -- Product Category / Accounting / Copy Accounts
;

update ad_column set istoolbarbutton='N' where ad_column_id=61940 -- Production (Single Product) / Production / Complete Production
;

update ad_column set istoolbarbutton='N' where ad_column_id=61943 -- Production (Single Product) / Production / Create/Update Production lines
;

update ad_column set istoolbarbutton='N' where ad_column_id=6537 -- Production (Single Product) / Production / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=9847 -- Project (Lines/Issues) / Issues / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=8757 -- Project / Project / Set Project Type
;

update ad_column set istoolbarbutton='N' where ad_column_id=6528 -- Purchase Order / Matching / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=60149 -- Purchase Order / Payment Schedule / Validate
;

update ad_column set istoolbarbutton='N' where ad_column_id=4650 -- Purchase Order / Purchase Order / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=2171 -- Purchase Order / Purchase Order / Process Order
;

update ad_column set istoolbarbutton='N' where ad_column_id=8689 -- Recurring / Recurring / Start Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=13079 -- Request (all) / Request / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=13079 -- Request / Request / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=11482 -- Requisition / Requisition / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=11480 -- Requisition / Requisition / Process Requisition
;

update ad_column set istoolbarbutton='N' where ad_column_id=5352 -- Return to Vendor / Return to Vendor / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=6534 -- Return to Vendor / Return to Vendor / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=4324 -- Return to Vendor / Return to Vendor / Process Shipment 
;

update ad_column set istoolbarbutton='N' where ad_column_id=59431 -- Revaluation Asset / Revaluation Asset / Asset Reval Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=59421 -- Revaluation Asset / Revaluation Asset / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=8589 -- Role Data Access / Record Access / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=4650 -- Sales Order / Order / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=2171 -- Sales Order / Order / Process Order
;

update ad_column set istoolbarbutton='N' where ad_column_id=60149 -- Sales Order / Payment Schedule / Validate
;

update ad_column set istoolbarbutton='N' where ad_column_id=8817 -- Session Audit / Change Audit / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=12330 -- Ship/Receipt Confirm / Confirmation / Process Confirmation
;

update ad_column set istoolbarbutton='N' where ad_column_id=201078 -- Shipment (Customer) / Packages / Online Shipping Rate Inquiry
;

update ad_column set istoolbarbutton='N' where ad_column_id=201070 -- Shipment (Customer) / Packages / Process Shipment Online
;

update ad_column set istoolbarbutton='N' where ad_column_id=5352 -- Shipment (Customer) / Shipment / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=6534 -- Shipment (Customer) / Shipment / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=4324 -- Shipment (Customer) / Shipment / Process Shipment 
;

update ad_column set istoolbarbutton='N' where ad_column_id=201078 -- Shipment Package / Packages / Online Shipping Rate Inquiry
;

update ad_column set istoolbarbutton='N' where ad_column_id=201070 -- Shipment Package / Packages / Process Shipment Online
;

update ad_column set istoolbarbutton='N' where ad_column_id=4712 -- Spare parts / Product / Verify BOM Structure
;

update ad_column set istoolbarbutton='N' where ad_column_id=128 -- Table and Column / Column / Column Encryption
;

update ad_column set istoolbarbutton='N' where ad_column_id=6483 -- Table and Column / Column / Synchronize Column
;

update ad_column set istoolbarbutton='N' where ad_column_id=3893 -- Test / Test / Process Now
;

update ad_column set istoolbarbutton='N' where ad_column_id=10031 -- Tree / Tree / Verify Tree
;

update ad_column set istoolbarbutton='N' where ad_column_id=56347 -- UnPosted Documents / Unposted Documents / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=12341 -- UnPosted Documents / Unposted Documents / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=57937 -- Unprocessed Documents (All) / Unprocessed Documents / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=208381 -- Vendor RMA / Vendor RMA / Create lines from
;

update ad_column set istoolbarbutton='N' where ad_column_id=52006 -- Vendor RMA / Vendor RMA / Create Order From RMA
;

update ad_column set istoolbarbutton='N' where ad_column_id=12120 -- Vendor RMA / Vendor RMA / Process RMA
;

update ad_column set istoolbarbutton='N' where ad_column_id=12313 -- View Allocation / Allocation / Posted
;

update ad_column set istoolbarbutton='N' where ad_column_id=12319 -- View Allocation / Allocation / Process Allocation
;

update ad_column set istoolbarbutton='N' where ad_column_id=15514 -- View Chat / Chat / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=6487 -- Window, Tab Field / Tab / Create Fields
;

update ad_column set istoolbarbutton='N' where ad_column_id=11555 -- Workflow / Workflow / Validate Workflow
;

update ad_column set istoolbarbutton='N' where ad_column_id=10448 -- Workflow Activities (all) / Activity / Manage Activity
;

update ad_column set istoolbarbutton='N' where ad_column_id=11545 -- Workflow Activities (all) / Activity / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=10448 -- Workflow Process / Activity / Manage Activity
;

update ad_column set istoolbarbutton='N' where ad_column_id=11545 -- Workflow Process / Activity / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=11683 -- Workflow Process / Event / Record ID
;

update ad_column set istoolbarbutton='N' where ad_column_id=10457 -- Workflow Process / Process / Manage Process
;

update ad_column set istoolbarbutton='N' where ad_column_id=11549 -- Workflow Process / Process / Record ID
;

SELECT register_migration_script('201301251443_IDEMPIERE-234.sql') FROM dual
;

