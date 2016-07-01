/**
 * 
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * @author hengsin
 *
 */
public class MFieldSuggestion extends X_AD_FieldSuggestion {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3304495084929321451L;

	/**
	 * @param ctx
	 * @param AD_FieldSuggestion_ID
	 * @param trxName
	 */
	public MFieldSuggestion(Properties ctx, int AD_FieldSuggestion_ID,
			String trxName) {
		super(ctx, AD_FieldSuggestion_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MFieldSuggestion(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.PO#setClientOrg(int, int)
	 */
	@Override
	public void setClientOrg(int AD_Client_ID, int AD_Org_ID) {
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}

	
}
