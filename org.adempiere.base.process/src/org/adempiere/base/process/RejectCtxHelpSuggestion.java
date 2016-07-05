/**
 * 
 */
package org.adempiere.base.process;

import org.compiere.model.X_AD_CtxHelpSuggestion;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class RejectCtxHelpSuggestion extends SvrProcess {

	/**
	 * 
	 */
	public RejectCtxHelpSuggestion() {
	}

	@Override
	protected void prepare() {
	}

	@Override
	protected String doIt() throws Exception {
		X_AD_CtxHelpSuggestion  suggestion = new X_AD_CtxHelpSuggestion(Env.getCtx(), getRecord_ID(),get_TrxName());
		suggestion.setIsApproved(false);
		suggestion.setProcessed(true);
		suggestion.saveEx();
		
		return "Suggestion rejected";
	}

}
