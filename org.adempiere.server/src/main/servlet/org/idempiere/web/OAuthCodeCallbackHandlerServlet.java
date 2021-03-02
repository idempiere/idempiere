package org.idempiere.web;

import java.io.IOException;
import java.security.GeneralSecurityException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.compiere.model.MAuthorizationCredential;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.Env;

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
		String msg = null;

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
				errmsg = "The \"code\" URL parameter is missing";
			}
		}

		String[] state = null;
		if (errmsg == null) {
			// Getting the "state" URL parameter
			state = req.getParameterValues(STATE_URL_PARAM_NAME);
			// Checking conditions on the "state" URL parameter
			if (state == null || state.length == 0) {
				errmsg = "The \"state\" URL parameter is missing";
			}
		}

		MPInstance pinstance = null;
		if (errmsg == null) {
			MTable pinstanceTable = MTable.get(MPInstance.Table_ID);
			String uuidcol = PO.getUUIDColumnName(MPInstance.Table_Name);
			pinstance = (MPInstance) pinstanceTable.getPO(uuidcol+"=?", new Object[] {state[0]}, null);
			if (pinstance == null) {
				errmsg = "Invalid \"state\" URL parameter";
			}
		}

		MAuthorizationCredential credential = null;
		if (errmsg == null) {
			for (MPInstancePara param : pinstance.getParameters()) {
				if (MAuthorizationCredential.COLUMNNAME_AD_AuthorizationCredential_ID.equals(param.getParameterName())) {
					credential = new MAuthorizationCredential(Env.getCtx(), param.getP_Number().intValue(), null);
					break;
				}
			}
			if (credential == null || credential.get_ID() <= 0) {
				errmsg = "Invalid \"state\" URL parameter, not found";
			}
		}

		if (errmsg == null) {
			Env.getCtx().setProperty(Env.AD_CLIENT_ID, String.valueOf(pinstance.getAD_Client_ID())); // To avoid Context Lost exception
			Env.getCtx().setProperty(Env.AD_USER_ID, String.valueOf(pinstance.getCreatedBy())); // To set as CreatedBy of the account
			try {
				msg = credential.processToken(code[0]);
			} catch (IOException | GeneralSecurityException e) {
				errmsg = e.getLocalizedMessage();
			}
		}

		String url = null;
		if (errmsg == null) {
			url = resp.encodeRedirectURL("callback.jsp?msg=" + msg);
		} else {
			url = resp.encodeRedirectURL("callback.jsp?error=" + errmsg);
		}

		resp.sendRedirect(url);

	}

}
