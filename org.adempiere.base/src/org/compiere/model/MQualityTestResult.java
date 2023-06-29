package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MQualityTestResult extends X_M_QualityTestResult {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5529865718027582930L;

    /**
    * UUID based Constructor
    * @param ctx  Context
    * @param M_QualityTestResult_UU  UUID key
    * @param trxName Transaction
    */
    public MQualityTestResult(Properties ctx, String M_QualityTestResult_UU, String trxName) {
        super(ctx, M_QualityTestResult_UU, trxName);
    }

	public MQualityTestResult(Properties ctx, int M_QualityTestResult_ID, String trxName) {
		super(ctx, M_QualityTestResult_ID, trxName);
	}

	public MQualityTestResult(Properties ctx, ResultSet rs, 
			String trxName) {
		super (ctx, rs, trxName);
	}
	
}
