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
package org.compiere.process;

import java.util.logging.Level;

import org.compiere.model.MAuthorizationCredential;
import org.compiere.model.MPInstance;

/**
 *	IDEMPIERE-3101
 * 	@author Carlos Ruiz - globalqss
 */
@org.adempiere.base.annotation.Process
public class AddAuthorizationProcess extends SvrProcess {

	/* Authorization Scopes */
	protected String p_AD_AuthorizationScopes = null;
	/* Authorization Credential */
	protected int p_AD_AuthorizationCredential_ID = 0;
	/* Open Browser */
	protected Boolean p_Auth_OpenPopup = Boolean.FALSE;

	/* Auth URL */
	protected String f_authURL = null;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "AD_AuthorizationScopes": p_AD_AuthorizationScopes = para.getParameterAsString(); break;
			case "AD_AuthorizationCredential_ID": p_AD_AuthorizationCredential_ID = para.getParameterAsInt(); break;
			case "Auth_OpenPopup": p_Auth_OpenPopup = para.getParameterAsBoolean(); break;
			case "AD_Language": break;  // ignored, is just to save it in AD_Process_Para
			case "Auth_CallbackAnswer": break;  // ignored, is just to save it in AD_Process_Para
			default:
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, "Custom Parameter: " + name + "=" + para.getInfo());
				break;
			}
		}
	}

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO))
			log.info("AD_AuthorizationScopes" + p_AD_AuthorizationScopes
					+ ", AD_AuthorizationCredential_ID=" + p_AD_AuthorizationCredential_ID
					+ ", Auth_OpenBrowser=" + p_Auth_OpenPopup);
		MPInstance pinstance = new MPInstance(getCtx(), getAD_PInstance_ID(), get_TrxName());
		MAuthorizationCredential credential = new MAuthorizationCredential(getCtx(), p_AD_AuthorizationCredential_ID, get_TrxName());
		f_authURL = credential.getFullAuthorizationEndpoint(p_AD_AuthorizationScopes, pinstance.getAD_PInstance_UU());
		if (! p_Auth_OpenPopup || processUI == null) {
			addLog(f_authURL);
			return "@Add_Auth_Copy_Link@";
		}

		return "@Add_Auth_In_Popup@";
	}

}	//	AddAuthorizationProcess
