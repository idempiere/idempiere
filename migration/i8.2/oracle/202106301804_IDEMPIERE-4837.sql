SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 30, 2021, 4:57:03 PM IST
--All window having following table should hae priceList defaulted
--C_Order = 259
--I_Order = 591
--I_Invoice = 598
--C_Project = 203
--C_Invoice = 318
--M_Requisition = 702
UPDATE AD_Window SET PredefinedContextVariables='UsePriceListInProductInfo=Y',Updated=TO_DATE('2021-06-30 16:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 
WHERE AD_Window_ID in  (Select w.ad_window_ID from AD_Window w inner join AD_Tab tb on (w.AD_Window_ID=tb.AD_Window_ID) 
WHERE tb.AD_Table_ID in (259,591,598,203,318,702))
;


SELECT register_migration_script('202106301804_IDEMPIERE-4837.sql') FROM dual
;