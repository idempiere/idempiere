-- Apr 11, 2013 3:33:35 PM COT
UPDATE AD_ReportView SET WhereClause='(QtyToDeliver<>0 OR QtyToInvoice<>0) AND RV_OrderDetail.DocStatus NOT IN (''VO'',''CL'')',Updated=TO_DATE('2013-04-11 15:33:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=104
;

-- Apr 12, 2013 8:20:50 PM COT
-- IDEMPIERE-794 Ticket #1001025 - Expand the views to provide more information
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-12 20:20:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208053
;

-- Apr 12, 2013 8:21:42 PM COT
-- IDEMPIERE-794 Ticket #1001025 - Expand the views to provide more information
UPDATE AD_Column SET AD_Reference_Value_ID=134, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-12 20:21:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210206
;

-- Apr 12, 2013 8:22:05 PM COT
-- IDEMPIERE-794 Ticket #1001025 - Expand the views to provide more information
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-12 20:22:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208087
;

SELECT register_migration_script('201304111530_IDEMPIERE-794.sql') FROM dual
;


