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
public class MCtxHelpSuggestion extends X_AD_CtxHelpSuggestion {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1940407803562658708L;

	/**
	 * @param ctx
	 * @param AD_CtxHelpSuggestion_ID
	 * @param trxName
	 */
	public MCtxHelpSuggestion(Properties ctx, int AD_CtxHelpSuggestion_ID,
			String trxName) {
		super(ctx, AD_CtxHelpSuggestion_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MCtxHelpSuggestion(Properties ctx, ResultSet rs, String trxName) {
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
