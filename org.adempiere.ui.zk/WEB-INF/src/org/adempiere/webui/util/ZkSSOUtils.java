/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.adempiere.webui.util;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.lang.Strings;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.util.Clients;

/**
 * Static methods for SSO
 */
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
