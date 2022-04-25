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
package org.adempiere.webui.process;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.form.AddAuthorizationForm;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.IServerPushCallback;
import org.adempiere.webui.util.ServerPushTemplate;
import org.compiere.model.SystemIDs;
import org.zkoss.zk.ui.Desktop;

/**
 *	IDEMPIERE-3101
 * 	@author Carlos Ruiz - globalqss
 */
@org.adempiere.base.annotation.Process
public class AddAuthorizationProcess extends org.compiere.process.AddAuthorizationProcess implements IServerPushCallback {

	/**
	 * Post process to register the server push callback
	 */
	@Override
	protected void postProcess(boolean success) {
		if (success) {
			Desktop desktop = AEnv.getDesktop();
			ServerPushTemplate template = new ServerPushTemplate(desktop);
			template.executeAsync(this);
		}
	}

	/**
	 * Open the authorization form when updating the UI on server push callback
	 */
	@Override
	public void updateUI() {
		if (p_Auth_OpenPopup) {
			ADForm form = SessionManager.getAppDesktop().openForm(SystemIDs.FORM_ADD_AUTHORIZATION);
			if (form instanceof AddAuthorizationForm) {
				((AddAuthorizationForm)form).buildClientPopupAndListener(f_authURL, getAD_PInstance_ID());
			}
		}
	}

}	//	AddAuthorizationProcess
