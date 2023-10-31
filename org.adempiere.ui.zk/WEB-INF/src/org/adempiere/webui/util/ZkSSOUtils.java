package org.adempiere.webui.util;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.lang.Strings;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.util.Clients;

public class ZkSSOUtils
{
	/**
	 * Update the error message in error.zul
	 * 
	 * @param errorMsg
	 */
	public static void setErrorMessageText(String errorMsg)
	{
		String continueMsg = Msg.getMsg(Env.getCtx(), "continue").trim();
		errorMsg =  Msg.getMsg(Env.getCtx(), errorMsg).trim();
		errorMsg = Strings.escape(errorMsg, "\"");
		String errorScript = "adempiere.set(\"zkErrorMsg\", \"" + errorMsg + "\");";
		errorScript += " adempiere.set(\"zkContinueText\", \"" + continueMsg + "\");";
		final String scr = errorScript;
		Clients.response("ssoErrorScript", new AuScript(null, scr));
	}
}
