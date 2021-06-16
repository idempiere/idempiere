SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4808 Payment Allocation should be IsSOTrx neutral
-- Jun 3, 2021, 1:38:39 PM CEST
UPDATE AD_InfoColumn SET DisplayLogic='@IsSOTrx:Y@=Y | @+IgnoreIsSOTrxInBPInfo:N@=Y', SeqNoSelection=10, DefaultValue='@SQL=SELECT CASE WHEN ''@IsSOTrx:X@''=''X'' OR ''@+IgnoreIsSOTrxInBPInfo:N@''=''Y'' THEN '''' ELSE ''@IsSOTrx@'' END AS DefaultValue FROM DUAL',Updated=TO_DATE('2021-06-03 13:38:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200036
;

-- Jun 3, 2021, 1:38:52 PM CEST
UPDATE AD_InfoColumn SET DisplayLogic='@IsSOTrx:N@=N | @+IgnoreIsSOTrxInBPInfo:N@=Y', SeqNoSelection=20, DefaultValue='@SQL=SELECT CASE WHEN ''@IsSOTrx:X@''=''X'' OR ''@+IgnoreIsSOTrxInBPInfo:N@''=''Y'' THEN '''' WHEN ''@IsSOTrx:X@''=''N'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL',Updated=TO_DATE('2021-06-03 13:38:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200037
;

-- Jun 3, 2021, 1:31:20 PM CEST
UPDATE AD_Menu SET PredefinedContextVariables='IgnoreIsSOTrxInBPInfo=Y',Updated=TO_DATE('2021-06-03 13:31:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID IN (
53289, /* Form - Accounting Fact Reconcilation (manual) */
245, /* Form - Payment Allocation */
434, /* Report - Accounting Fact Daily*/
433, /* Report - Accounting Fact Details*/
435, /* Report - Accounting Fact Period*/
246, /* Report - Allocation*/
400, /* Report - Asset Delivery Details*/
474, /* Report - Asset Delivery Month*/
200043, /* Report - Bank Register Report*/
512, /* Report - Business Partner Open*/
399, /* Report - Customer Assets*/
53185, /* Report - Distribution Order Detail*/
481, /* Report - Open Confirmation Details*/
482, /* Report - Open Confirmations*/
543, /* Report - Order Detail*/
511, /* Report - Payment Details*/
256, /* Report - Product Transaction Value*/
260, /* Report - Project Status Summary*/
231, /* Report - Quarterly Invoice Customer by Vendor*/
196, /* Report - Replenish Report*/
53354, /* Report - Replenish Report incl. Production*/
350, /* Report - Statement of Accounts*/
502, /* Report - Trial Balance*/
509, /* Report - UnAllocated Invoices*/
510, /* Report - UnAllocated Payments*/
497, /* Process - Auto Allocation*/
53190, /* Process - Bank/Cash Transfer*/
420, /* Process - Business Partner Organization*/
348, /* Process - Deliver Assets*/
535, /* Process - Invoice Requests*/
507, /* Process - Order Batch Process*/
304, /* Process - Receivables Write-Off*/
50009, /* Process - Request EMail Processor*/
496, /* Process - Reset Allocation*/
473, /* Process - UnLink Business Partner Org*/
506 /* Process - Validate Business Partner*/
)
;

-- Jun 3, 2021, 1:42:58 PM CEST
UPDATE AD_Window SET PredefinedContextVariables='IgnoreIsSOTrxInBPInfo=Y',Updated=TO_DATE('2021-06-03 13:42:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID IN (
200005, /* GL Journal*/
132, /* GL Journal Batch*/
277, /* Import Bank Statement*/
278, /* Import GL Journal*/
53121, /* Import Inventory Move*/
280, /* Import Payment*/
53071, /* Import Price List*/
170, /* Inventory Move*/
146, /* Price List*/
337, /* Price List Schema*/
130, /* Project*/
108, /* User*/
/* Buttons running processes with BP parameter in these windows: */
53134, /* Cash Plan*/
321, /* Dunning Run*/
216, /* Financial Report*/
200013, /* GL Journal Generator*/
206 /* Payment Selection*/
)
;

SELECT register_migration_script('202106031358_IDEMPIERE-4808.sql') FROM dual
;

