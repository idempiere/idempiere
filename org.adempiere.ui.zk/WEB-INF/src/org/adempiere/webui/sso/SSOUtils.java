/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.adempiere.webui.sso;

import java.util.List;

import org.adempiere.base.Service;
import org.compiere.model.MSSOPrincipleConfig;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.lang.Strings;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.util.Clients;

/**
 * @author Logilite Technologies
 */
public class SSOUtils
{
	public static final String	ERROR_API			= "/error.html?error=";

	public static final String	ERROR_VALIDATION	= "/error.zul";

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

	public static ISSOPrinciple getSSOPrinciple()
	{
		ISSOPrinciple principle = null;
		MSSOPrincipleConfig config = MSSOPrincipleConfig.getDefaultSSOPrinciple();
		if (config == null)
			return null;
		List<ISSOPrincipleFactory> factories = Service.locator().list(ISSOPrincipleFactory.class).getServices();
		for (ISSOPrincipleFactory factory : factories)
		{
			principle = factory.getSSOPrincipleService(config);
			if (principle != null)
				break;
		}
		return principle;
	}
}
