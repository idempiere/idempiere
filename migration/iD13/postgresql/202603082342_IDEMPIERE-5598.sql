-- IDEMPIERE-5598 IDEMPIERE-4224 - Use Search instead of Table for performance
SELECT register_migration_script('202603082342_IDEMPIERE-5598.sql') FROM dual;

UPDATE AD_Column
SET AD_Reference_ID=30 WHERE AD_Column_ID IN (
215936,  /* AD_TableAttribute.CreatedBy */
215939,  /* AD_TableAttribute.UpdatedBy */
216320,  /* C_AcctSchema_Element.C_Employee_ID */
217112,  /* C_Invoice.C_Employee_ID */
217113,  /* C_InvoiceLine.C_Employee_ID */
217114,  /* C_Payment.C_Employee_ID */
216336,  /* Fact_Acct.C_Employee_ID */
216338,  /* Fact_Acct_Summary.C_Employee_ID */
216991,  /* GL_Distribution.C_Employee_ID */
217003,  /* GL_DistributionLine.C_Employee_ID */
217009,  /* GL_JournalLine.C_Employee_ID */
217182,  /* RV_Fact_Acct.C_Employee_ID */
217336,  /* RV_Fact_Acct_Day.C_Employee_ID */
217346,  /* RV_Fact_Acct_Period.C_Employee_ID */
217039,  /* T_Fact_Acct_History.C_Employee_ID */
217326   /* T_RV_Reconciliation.C_Employee_ID */
)
;

