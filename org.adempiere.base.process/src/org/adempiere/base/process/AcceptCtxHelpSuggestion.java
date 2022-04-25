/**
 * 
 */
package org.adempiere.base.process;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.I_AD_CtxHelpMsg;
import org.compiere.model.MCtxHelpMsg;
import org.compiere.model.Query;
import org.compiere.model.X_AD_CtxHelpSuggestion;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
@org.adempiere.base.annotation.Process
public class AcceptCtxHelpSuggestion extends SvrProcess {

	private boolean p_isSaveAsTenantCustomization;

	/**
	 * 
	 */
	public AcceptCtxHelpSuggestion() {
	}

	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#prepare()
	 */
	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter())
		{
			String name = para.getParameterName();
			if (para.getParameter() == null)
				;
			else if (name.equals("IsSaveAsTenantCustomization"))
				p_isSaveAsTenantCustomization = para.getParameterAsBoolean();
			else
				log.log(Level.WARNING, "Unknown Parameter: " + name);
		}

	}

	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#doIt()
	 */
	@Override
	protected String doIt() throws Exception {
		X_AD_CtxHelpSuggestion suggestion = new X_AD_CtxHelpSuggestion(Env.getCtx(), getRecord_ID(), get_TrxName());
		if (p_isSaveAsTenantCustomization)
		{
			int AD_Client_ID = suggestion.getAD_UserClient_ID();
			int AD_User_ID = suggestion.getAD_User_ID();
			return updateOrInsert(suggestion, AD_Client_ID, AD_User_ID);
		}
		else 
			return updateOrInsert(suggestion, 0, Env.getAD_User_ID(getCtx()));
	}

	private String updateOrInsert(X_AD_CtxHelpSuggestion suggestion, int AD_Client_ID, int AD_User_ID) {
		boolean changed = false;
		String AD_Language = suggestion.getAD_Language();
		
		int AD_CtxHelpMsg_ID = suggestion.getAD_CtxHelpMsg_ID();
		if (Env.isBaseLanguage(AD_Language, I_AD_CtxHelpMsg.Table_Name)) {
			Query query = new Query(Env.getCtx(), I_AD_CtxHelpMsg.Table_Name, "AD_CtxHelp_ID=? AND IsActive='Y' AND AD_Client_ID=?", get_TrxName());
			MCtxHelpMsg msg = query.setParameters(suggestion.getAD_CtxHelp_ID(), AD_Client_ID).first();
			if (msg != null) {
				msg.setMsgText(suggestion.getMsgText());
				if (msg.is_Changed()) {
					msg.saveEx();
					changed = true;
				}
				if (msg.getAD_CtxHelpMsg_ID() != AD_CtxHelpMsg_ID) {
					AD_CtxHelpMsg_ID = msg.getAD_CtxHelpMsg_ID();
				}
			} else {
				msg = new MCtxHelpMsg(Env.getCtx(), 0, get_TrxName());
				msg.setAD_CtxHelp_ID(suggestion.getAD_CtxHelp_ID());
				msg.setMsgText(suggestion.getMsgText());
				msg.setClientOrg(AD_Client_ID, 0);
				msg.saveEx();
				AD_CtxHelpMsg_ID = msg.getAD_CtxHelpMsg_ID();
				changed = true;
			}
		} else {
			MCtxHelpMsg ctxHelpMsg = new MCtxHelpMsg(Env.getCtx(), AD_CtxHelpMsg_ID, get_TrxName());
			if (ctxHelpMsg.getAD_Client_ID() != AD_Client_ID) {
				MCtxHelpMsg newMsg = new MCtxHelpMsg(Env.getCtx(), 0, get_TrxName());
				newMsg.setClientOrg(AD_Client_ID, 0);
				newMsg.setAD_CtxHelp_ID(ctxHelpMsg.getAD_CtxHelp_ID());
				newMsg.setMsgText(ctxHelpMsg.getMsgText());
				newMsg.setIsActive(true);
				newMsg.saveEx();
				AD_CtxHelpMsg_ID = newMsg.getAD_CtxHelpMsg_ID();
			}
		}
		
		String original = DB.getSQLValueStringEx(get_TrxName(), "SELECT MsgText FROM AD_CtxHelpMsg_Trl WHERE AD_CtxHelpMsg_ID=? AND AD_Client_ID=? " +
				"AND IsActive='Y' AND AD_Language=?", AD_CtxHelpMsg_ID, AD_Client_ID, suggestion.getAD_Language());
		if (original != null) {
			if (!original.equals(suggestion.getMsgText())) {
				List<Object> params = new ArrayList<Object>();
				StringBuilder update = new StringBuilder("UPDATE AD_CtxHelpMsg_Trl SET ");
				if (!Util.isEmpty(suggestion.getMsgText())) {
					update.append("MsgText=? ");
					params.add(suggestion.getMsgText());
				}
				
				if (!params.isEmpty()) {
					update.append("WHERE AD_CtxHelpMsg_ID=? AND AD_Language=? AND AD_Client_ID=?");
					params.add(AD_CtxHelpMsg_ID);
					params.add(suggestion.getAD_Language());
					params.add(AD_Client_ID);
					DB.executeUpdateEx(update.toString(), params.toArray(), get_TrxName());
					changed = true;
				}			
			}
		} else {			
			StringBuilder insert = new StringBuilder("Insert Into AD_CtxHelpMsg_Trl (AD_Client_ID, AD_Org_ID, AD_CtxHelpMsg_ID, IsActive, IsTranslated, AD_Language, MsgText,");
			insert.append("Created, CreatedBy, Updated, UpdatedBy, AD_CtxHelpMsg_Trl_UU)")
				.append(" Values (?, ?, ?, 'Y', 'N', ?, ?, getDate(), ?, getDate(), ?, generate_uuid()) ");
			List<Object> params = new ArrayList<Object>();
			params.add(AD_Client_ID);
			params.add(0);
			params.add(AD_CtxHelpMsg_ID);
			params.add(AD_Language);
			params.add(suggestion.getMsgText());
			params.add(AD_User_ID);
			params.add(AD_User_ID);
			DB.executeUpdateEx(insert.toString(), params.toArray(), get_TrxName());
			changed = true;
		}
		
		suggestion.setIsApproved(true);
		suggestion.setIsSaveAsTenantCustomization(AD_Client_ID > 0);
		suggestion.setProcessed(true);
		suggestion.saveEx();
		
		if (changed) {
			return "Suggestion accepted and applied to context help";
		} else {
			return "No changes found";
		}
	}
}
