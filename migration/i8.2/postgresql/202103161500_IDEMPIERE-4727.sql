-- IDEMPIERE-4727 Movement Window: a new line can be created for a movement that is completed.
-- Mar 16, 2021, 2:59:48 PM CET
UPDATE AD_Tab SET ReadOnlyLogic='@Processed@=Y',Updated=TO_TIMESTAMP('2021-03-16 14:59:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID IN (
329 /* Bank/Cash Statement > Statement Line*/ ,
200103 /* Cost Adjustment > Cost Adjustment Line*/ ,
200138 /* Customer Return > Attributes*/ ,
629 /* Customer RMA > RMA Line*/ ,
200008 /* GL Journal > Line*/ ,
160 /* GL Journal Batch > Journal*/ ,
161 /* GL Journal Batch > Line*/ ,
683 /* Internal Use Inventory > Internal Use Line*/ ,
53134 /* Internal Use Inventory > Attributes*/ ,
260 /* Inventory Move > Move Line*/ ,
750 /* Inventory Move > Attributes*/ ,
200137 /* Material Receipt > Attributes*/ ,
667 /* Move Confirmation > Line*/ ,
353 /* Payment Selection > Payment Selection Line*/ ,
256 /* Physical Inventory > Inventory Count Line*/ ,
749 /* Physical Inventory > Attributes*/ ,
320 /* Production > Production Plan*/ ,
321 /* Production > Production Line*/ ,
53345 /* Production (Single Product) > Production Line*/ ,
200224 /* Production (Single Product) > Attributes*/ ,
200016 /* Sales Order > POS Payment*/ ,
751 /* Shipment (Customer) > Attributes*/ ,
659 /* Ship/Receipt Confirm > Line*/ ,
53281 /* Vendor RMA > RMA Line*/ ,
200068 /* Payments into Batch > Lines*/
)
;

SELECT register_migration_script('202103161500_IDEMPIERE-4727.sql') FROM dual
;

