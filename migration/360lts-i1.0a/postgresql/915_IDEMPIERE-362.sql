-- IDEMPIERE-362 Hide things that don't work on iDempiere

-- Sep 19, 2012 4:36:27 PM COT
UPDATE AD_Column SET IsActive='N' WHERE AD_Column_ID IN ( 
4862, -- C_AcctSchema_Default.B_Expense_Acct
4868, -- C_AcctSchema_Default.B_RevaluationGain_Acct
4869, -- C_AcctSchema_Default.B_RevaluationLoss_Acct
4866, -- C_AcctSchema_Default.B_SettlementGain_Acct
4867, -- C_AcctSchema_Default.B_SettlementLoss_Acct
4865, -- C_AcctSchema_Default.B_Unidentified_Acct
3449, -- C_AcctSchema_Default.E_Expense_Acct
3450, -- C_AcctSchema_Default.E_Prepayment_Acct
4873, -- C_AcctSchema_Default.NotInvoicedReceivables_Acct
4840, -- C_AcctSchema_Default.NotInvoicedRevenue_Acct
56545, -- C_AcctSchema_Default.P_Burden_Acct
56543, -- C_AcctSchema_Default.P_CostOfProduction_Acct
56542, -- C_AcctSchema_Default.P_FloorStock_Acct
56544, -- C_AcctSchema_Default.P_Labor_Acct
56538, -- C_AcctSchema_Default.P_MethodChangeVariance_Acct
56541, -- C_AcctSchema_Default.P_MixVariance_Acct
56546, -- C_AcctSchema_Default.P_OutsideProcessing_Acct
56567, -- C_AcctSchema_Default.P_Overhead_Acct
56568, -- C_AcctSchema_Default.P_Scrap_Acct
56539, -- C_AcctSchema_Default.P_UsageVariance_Acct
56537, -- C_AcctSchema_Default.P_WIP_Acct
4856, -- C_AcctSchema_Default.T_Liability_Acct
4857, -- C_AcctSchema_Default.T_Receivables_Acct
6114, -- C_AcctSchema_Default.W_InvActualAdjust_Acct
3443, -- C_AcctSchema_Default.W_Inventory_Acct
4853, -- C_AcctSchema_Default.Withholding_Acct
4843, -- C_AcctSchema_Default.W_Revaluation_Acct
2501, -- C_AcctSchema_GL.IncomeSummary_Acct
2500, -- C_AcctSchema_GL.RetainedEarning_Acct
2493, -- C_AcctSchema_GL.SuspenseError_Acct
4901, -- C_BankAccount_Acct.B_Expense_Acct
4907, -- C_BankAccount_Acct.B_RevaluationGain_Acct
4908, -- C_BankAccount_Acct.B_RevaluationLoss_Acct
4905, -- C_BankAccount_Acct.B_SettlementGain_Acct
4906, -- C_BankAccount_Acct.B_SettlementLoss_Acct
4904, -- C_BankAccount_Acct.B_Unidentified_Acct
3381, -- C_BP_Employee_Acct.E_Expense_Acct
3382, -- C_BP_Employee_Acct.E_Prepayment_Acct
4999, -- C_BP_Group_Acct.NotInvoicedReceivables_Acct
4998, -- C_BP_Group_Acct.NotInvoicedRevenue_Acct
10287, -- C_Currency_Acct.RealizedGain_Acct
10289, -- C_Currency_Acct.RealizedLoss_Acct
10279, -- C_Currency_Acct.UnrealizedGain_Acct
10290, -- C_Currency_Acct.UnrealizedLoss_Acct
5085, -- C_Tax_Acct.T_Liability_Acct
5087, -- C_Tax_Acct.T_Receivables_Acct
56565, -- M_Product_Acct.P_Burden_Acct
56563, -- M_Product_Acct.P_CostOfProduction_Acct
56562, -- M_Product_Acct.P_FloorStock_Acct
56564, -- M_Product_Acct.P_Labor_Acct
56558, -- M_Product_Acct.P_MethodChangeVariance_Acct
56561, -- M_Product_Acct.P_MixVariance_Acct
56566, -- M_Product_Acct.P_OutsideProcessing_Acct
56571, -- M_Product_Acct.P_Overhead_Acct
56572, -- M_Product_Acct.P_Scrap_Acct
56559, -- M_Product_Acct.P_UsageVariance_Acct
56557, -- M_Product_Acct.P_WIP_Acct
56555, -- M_Product_Category_Acct.P_Burden_Acct
56553, -- M_Product_Category_Acct.P_CostOfProduction_Acct
56547, -- M_Product_Category_Acct.P_FloorStock_Acct
56554, -- M_Product_Category_Acct.P_Labor_Acct
56549, -- M_Product_Category_Acct.P_MethodChangeVariance_Acct
56552, -- M_Product_Category_Acct.P_MixVariance_Acct
56556, -- M_Product_Category_Acct.P_OutsideProcessing_Acct
56569, -- M_Product_Category_Acct.P_Overhead_Acct
56570, -- M_Product_Category_Acct.P_Scrap_Acct
56550, -- M_Product_Category_Acct.P_UsageVariance_Acct
56548, -- M_Product_Category_Acct.P_WIP_Acct
6124, -- M_Warehouse_Acct.W_InvActualAdjust_Acct
3386, -- M_Warehouse_Acct.W_Inventory_Acct
5133  -- M_Warehouse_Acct.W_Revaluation_Acct
)
;



--

UPDATE AD_Field SET IsActive='N' WHERE AD_Column_ID IN ( 
4862, -- C_AcctSchema_Default.B_Expense_Acct
4868, -- C_AcctSchema_Default.B_RevaluationGain_Acct
4869, -- C_AcctSchema_Default.B_RevaluationLoss_Acct
4866, -- C_AcctSchema_Default.B_SettlementGain_Acct
4867, -- C_AcctSchema_Default.B_SettlementLoss_Acct
4865, -- C_AcctSchema_Default.B_Unidentified_Acct
3449, -- C_AcctSchema_Default.E_Expense_Acct
3450, -- C_AcctSchema_Default.E_Prepayment_Acct
4873, -- C_AcctSchema_Default.NotInvoicedReceivables_Acct
4840, -- C_AcctSchema_Default.NotInvoicedRevenue_Acct
56545, -- C_AcctSchema_Default.P_Burden_Acct
56543, -- C_AcctSchema_Default.P_CostOfProduction_Acct
56542, -- C_AcctSchema_Default.P_FloorStock_Acct
56544, -- C_AcctSchema_Default.P_Labor_Acct
56538, -- C_AcctSchema_Default.P_MethodChangeVariance_Acct
56541, -- C_AcctSchema_Default.P_MixVariance_Acct
56546, -- C_AcctSchema_Default.P_OutsideProcessing_Acct
56567, -- C_AcctSchema_Default.P_Overhead_Acct
56568, -- C_AcctSchema_Default.P_Scrap_Acct
56539, -- C_AcctSchema_Default.P_UsageVariance_Acct
56537, -- C_AcctSchema_Default.P_WIP_Acct
4856, -- C_AcctSchema_Default.T_Liability_Acct
4857, -- C_AcctSchema_Default.T_Receivables_Acct
6114, -- C_AcctSchema_Default.W_InvActualAdjust_Acct
3443, -- C_AcctSchema_Default.W_Inventory_Acct
4853, -- C_AcctSchema_Default.Withholding_Acct
4843, -- C_AcctSchema_Default.W_Revaluation_Acct
2501, -- C_AcctSchema_GL.IncomeSummary_Acct
2500, -- C_AcctSchema_GL.RetainedEarning_Acct
2493, -- C_AcctSchema_GL.SuspenseError_Acct
4901, -- C_BankAccount_Acct.B_Expense_Acct
4907, -- C_BankAccount_Acct.B_RevaluationGain_Acct
4908, -- C_BankAccount_Acct.B_RevaluationLoss_Acct
4905, -- C_BankAccount_Acct.B_SettlementGain_Acct
4906, -- C_BankAccount_Acct.B_SettlementLoss_Acct
4904, -- C_BankAccount_Acct.B_Unidentified_Acct
3381, -- C_BP_Employee_Acct.E_Expense_Acct
3382, -- C_BP_Employee_Acct.E_Prepayment_Acct
4999, -- C_BP_Group_Acct.NotInvoicedReceivables_Acct
4998, -- C_BP_Group_Acct.NotInvoicedRevenue_Acct
10287, -- C_Currency_Acct.RealizedGain_Acct
10289, -- C_Currency_Acct.RealizedLoss_Acct
10279, -- C_Currency_Acct.UnrealizedGain_Acct
10290, -- C_Currency_Acct.UnrealizedLoss_Acct
5085, -- C_Tax_Acct.T_Liability_Acct
5087, -- C_Tax_Acct.T_Receivables_Acct
56565, -- M_Product_Acct.P_Burden_Acct
56563, -- M_Product_Acct.P_CostOfProduction_Acct
56562, -- M_Product_Acct.P_FloorStock_Acct
56564, -- M_Product_Acct.P_Labor_Acct
56558, -- M_Product_Acct.P_MethodChangeVariance_Acct
56561, -- M_Product_Acct.P_MixVariance_Acct
56566, -- M_Product_Acct.P_OutsideProcessing_Acct
56571, -- M_Product_Acct.P_Overhead_Acct
56572, -- M_Product_Acct.P_Scrap_Acct
56559, -- M_Product_Acct.P_UsageVariance_Acct
56557, -- M_Product_Acct.P_WIP_Acct
56555, -- M_Product_Category_Acct.P_Burden_Acct
56553, -- M_Product_Category_Acct.P_CostOfProduction_Acct
56547, -- M_Product_Category_Acct.P_FloorStock_Acct
56554, -- M_Product_Category_Acct.P_Labor_Acct
56549, -- M_Product_Category_Acct.P_MethodChangeVariance_Acct
56552, -- M_Product_Category_Acct.P_MixVariance_Acct
56556, -- M_Product_Category_Acct.P_OutsideProcessing_Acct
56569, -- M_Product_Category_Acct.P_Overhead_Acct
56570, -- M_Product_Category_Acct.P_Scrap_Acct
56550, -- M_Product_Category_Acct.P_UsageVariance_Acct
56548, -- M_Product_Category_Acct.P_WIP_Acct
6124, -- M_Warehouse_Acct.W_InvActualAdjust_Acct
3386, -- M_Warehouse_Acct.W_Inventory_Acct
5133  -- M_Warehouse_Acct.W_Revaluation_Acct
)
;

---
UPDATE AD_PrintFormatItem SET IsActive='N' WHERE AD_Column_ID IN ( 
4862, -- C_AcctSchema_Default.B_Expense_Acct
4868, -- C_AcctSchema_Default.B_RevaluationGain_Acct
4869, -- C_AcctSchema_Default.B_RevaluationLoss_Acct
4866, -- C_AcctSchema_Default.B_SettlementGain_Acct
4867, -- C_AcctSchema_Default.B_SettlementLoss_Acct
4865, -- C_AcctSchema_Default.B_Unidentified_Acct
3449, -- C_AcctSchema_Default.E_Expense_Acct
3450, -- C_AcctSchema_Default.E_Prepayment_Acct
4873, -- C_AcctSchema_Default.NotInvoicedReceivables_Acct
4840, -- C_AcctSchema_Default.NotInvoicedRevenue_Acct
56545, -- C_AcctSchema_Default.P_Burden_Acct
56543, -- C_AcctSchema_Default.P_CostOfProduction_Acct
56542, -- C_AcctSchema_Default.P_FloorStock_Acct
56544, -- C_AcctSchema_Default.P_Labor_Acct
56538, -- C_AcctSchema_Default.P_MethodChangeVariance_Acct
56541, -- C_AcctSchema_Default.P_MixVariance_Acct
56546, -- C_AcctSchema_Default.P_OutsideProcessing_Acct
56567, -- C_AcctSchema_Default.P_Overhead_Acct
56568, -- C_AcctSchema_Default.P_Scrap_Acct
56539, -- C_AcctSchema_Default.P_UsageVariance_Acct
56537, -- C_AcctSchema_Default.P_WIP_Acct
4856, -- C_AcctSchema_Default.T_Liability_Acct
4857, -- C_AcctSchema_Default.T_Receivables_Acct
6114, -- C_AcctSchema_Default.W_InvActualAdjust_Acct
3443, -- C_AcctSchema_Default.W_Inventory_Acct
4853, -- C_AcctSchema_Default.Withholding_Acct
4843, -- C_AcctSchema_Default.W_Revaluation_Acct
2501, -- C_AcctSchema_GL.IncomeSummary_Acct
2500, -- C_AcctSchema_GL.RetainedEarning_Acct
2493, -- C_AcctSchema_GL.SuspenseError_Acct
4901, -- C_BankAccount_Acct.B_Expense_Acct
4907, -- C_BankAccount_Acct.B_RevaluationGain_Acct
4908, -- C_BankAccount_Acct.B_RevaluationLoss_Acct
4905, -- C_BankAccount_Acct.B_SettlementGain_Acct
4906, -- C_BankAccount_Acct.B_SettlementLoss_Acct
4904, -- C_BankAccount_Acct.B_Unidentified_Acct
3381, -- C_BP_Employee_Acct.E_Expense_Acct
3382, -- C_BP_Employee_Acct.E_Prepayment_Acct
4999, -- C_BP_Group_Acct.NotInvoicedReceivables_Acct
4998, -- C_BP_Group_Acct.NotInvoicedRevenue_Acct
10287, -- C_Currency_Acct.RealizedGain_Acct
10289, -- C_Currency_Acct.RealizedLoss_Acct
10279, -- C_Currency_Acct.UnrealizedGain_Acct
10290, -- C_Currency_Acct.UnrealizedLoss_Acct
5085, -- C_Tax_Acct.T_Liability_Acct
5087, -- C_Tax_Acct.T_Receivables_Acct
56565, -- M_Product_Acct.P_Burden_Acct
56563, -- M_Product_Acct.P_CostOfProduction_Acct
56562, -- M_Product_Acct.P_FloorStock_Acct
56564, -- M_Product_Acct.P_Labor_Acct
56558, -- M_Product_Acct.P_MethodChangeVariance_Acct
56561, -- M_Product_Acct.P_MixVariance_Acct
56566, -- M_Product_Acct.P_OutsideProcessing_Acct
56571, -- M_Product_Acct.P_Overhead_Acct
56572, -- M_Product_Acct.P_Scrap_Acct
56559, -- M_Product_Acct.P_UsageVariance_Acct
56557, -- M_Product_Acct.P_WIP_Acct
56555, -- M_Product_Category_Acct.P_Burden_Acct
56553, -- M_Product_Category_Acct.P_CostOfProduction_Acct
56547, -- M_Product_Category_Acct.P_FloorStock_Acct
56554, -- M_Product_Category_Acct.P_Labor_Acct
56549, -- M_Product_Category_Acct.P_MethodChangeVariance_Acct
56552, -- M_Product_Category_Acct.P_MixVariance_Acct
56556, -- M_Product_Category_Acct.P_OutsideProcessing_Acct
56569, -- M_Product_Category_Acct.P_Overhead_Acct
56570, -- M_Product_Category_Acct.P_Scrap_Acct
56550, -- M_Product_Category_Acct.P_UsageVariance_Acct
56548, -- M_Product_Category_Acct.P_WIP_Acct
6124, -- M_Warehouse_Acct.W_InvActualAdjust_Acct
3386, -- M_Warehouse_Acct.W_Inventory_Acct
5133  -- M_Warehouse_Acct.W_Revaluation_Acct
)
;


-- Sep 27, 2012 11:08:01 AM COT
UPDATE AD_Tab SET IsActive='N',Updated=TO_TIMESTAMP('2012-09-27 11:08:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=214
;

-- Sep 28, 2012 1:14:51 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2012-09-28 13:14:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1370
;

-- Sep 28, 2012 1:15:22 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Tab SET IsActive='N',Updated=TO_TIMESTAMP('2012-09-28 13:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=569
;

-- Sep 28, 2012 1:20:15 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2012-09-28 13:20:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56547
;

-- Sep 28, 2012 1:20:51 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2012-09-28 13:20:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56537
;

SELECT register_migration_script('915_IDEMPIERE-362.sql') FROM dual
;

