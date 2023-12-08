package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Fact_Acct reconciliation model
 */
public class MFactReconciliation extends X_Fact_Reconciliation {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7569838866747051210L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param Fact_Reconciliation_UU  UUID key
     * @param trxName Transaction
     */
    public MFactReconciliation(Properties ctx, String Fact_Reconciliation_UU, String trxName) {
        super(ctx, Fact_Reconciliation_UU, trxName);
    }

    /**
     * @param ctx
     * @param Fact_Reconciliation_ID
     * @param trxName
     */
	public MFactReconciliation(Properties ctx, int Fact_Reconciliation_ID, String trxName) {
		super(ctx, Fact_Reconciliation_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MFactReconciliation(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

}
