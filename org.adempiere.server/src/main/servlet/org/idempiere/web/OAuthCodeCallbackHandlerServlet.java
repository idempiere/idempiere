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
 *                                                                     *
 * Sponsor:                                                            *
 * - FH                                                                *
 * Contributors:                                                       *
 * - Carlos Ruiz                                                       *
 **********************************************************************/

package org.idempiere.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Properties;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.adempiere.util.ServerContext;
import org.compiere.model.MAuthorizationCredential;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Msg;

public class OAuthCodeCallbackHandlerServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8071951954959980796L;

	/** The name of the Oauth code URL parameter */
	public static final String CODE_URL_PARAM_NAME = "code";

	/** The name of the OAuth error URL parameter */
	public static final String ERROR_URL_PARAM_NAME = "error";

	/** The name of the Oauth state URL parameter */
	public static final String STATE_URL_PARAM_NAME = "state";

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		String errmsg = null;
		String msg = "";

		// Getting the "error" URL parameter
		String[] error = req.getParameterValues(ERROR_URL_PARAM_NAME);
		// Checking if there was an error such as the user denied access
		if (error != null && error.length > 0) {
			errmsg = error[0];
		}

		String[] code = null;
		if (errmsg == null) {
			// Getting the "code" URL parameter
			code = req.getParameterValues(CODE_URL_PARAM_NAME);
			// Checking conditions on the "code" URL parameter
			if (code == null || code.length == 0) {
				errmsg = Msg.getMsg(Env.getCtx(), "OAuthCallback_MissingParameter", new Object[] {CODE_URL_PARAM_NAME});
			}
		}

		String[] state = null;
		if (errmsg == null) {
			// Getting the "state" URL parameter
			state = req.getParameterValues(STATE_URL_PARAM_NAME);
			// Checking conditions on the "state" URL parameter
			if (state == null || state.length == 0) {
				errmsg = Msg.getMsg(Env.getCtx(), "OAuthCallback_MissingParameter", new Object[] {STATE_URL_PARAM_NAME});
			}
		}

		String msgClose = "";
		try {
			Properties localctx = new Properties();
			ServerContext.setCurrentInstance(localctx);
			MPInstance pinstance = null;
			if (errmsg == null) {
				MTable pinstanceTable = MTable.get(MPInstance.Table_ID);
				String uuidcol = PO.getUUIDColumnName(MPInstance.Table_Name);
				pinstance = (MPInstance) pinstanceTable.getPO(uuidcol+"=?", new Object[] {state[0]}, null);
				if (pinstance == null) {
					errmsg = Msg.getMsg(Env.getCtx(), "OAuthCallback_InvalidState");
				}
			}

			MAuthorizationCredential credential = null;
			MPInstancePara paramAnswer = null;
			if (errmsg == null) {
				Env.getCtx().setProperty(Env.AD_CLIENT_ID, String.valueOf(pinstance.getAD_Client_ID())); // To avoid Context Lost exception
				Env.getCtx().setProperty(Env.AD_USER_ID, String.valueOf(pinstance.getCreatedBy())); // To set as CreatedBy of the account
				for (MPInstancePara param : pinstance.getParameters()) {
					if (MAuthorizationCredential.COLUMNNAME_AD_AuthorizationCredential_ID.equals(param.getParameterName()))
						credential = new MAuthorizationCredential(Env.getCtx(), param.getP_Number().intValue(), null);
					else if ("AD_Language".equals(param.getParameterName()))
						Env.getCtx().setProperty("#AD_Language", param.getP_String());
					else if ("Auth_CallbackAnswer".equals(param.getParameterName()))
						paramAnswer = param;
				}
				if (credential == null || credential.get_ID() <= 0) {
					errmsg = Msg.getMsg(Env.getCtx(), "OAuthCallback_NotFoundState");
				}
				if (paramAnswer == null) {
					paramAnswer = pinstance.createParameter(50, "Auth_CallbackAnswer", null);
				} else {
					if (paramAnswer.getP_String() != null) {
						errmsg = Msg.getMsg(Env.getCtx(), "OAuthCallback_AlreadyUsedLink");
					}
				}
			}

			if (errmsg == null) {
				msg = credential.processToken(code[0], pinstance);
				paramAnswer.setP_String(msg);
				paramAnswer.saveEx();
			}

			msgClose = URLEncoder.encode(Msg.getMsg(Env.getCtx(), "OAuthPopup_Close"), "UTF-8");
		} finally {
			ServerContext.dispose();
		}

		String url = null;
		msg = URLEncoder.encode(msg, "UTF-8");
		if (errmsg == null) {
			url = resp.encodeRedirectURL("callback.jsp?msg=" + msg + "&closemsg=" + msgClose);
		} else {
			String msgError = URLEncoder.encode(Msg.getMsg(Env.getCtx(), "Error"), "UTF-8");
			errmsg = URLEncoder.encode(errmsg, "UTF-8");
			url = resp.encodeRedirectURL("callback.jsp?error=" + errmsg + "&errmsg=" + msgError + "&closemsg=" + msgClose);
		}

		resp.sendRedirect(url);

	}

}
