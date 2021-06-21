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
import org.adempiere.webui.apps.form.MFARegisterForm;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.IServerPushCallback;
import org.adempiere.webui.util.ServerPushTemplate;
import org.compiere.model.SystemIDs;
import org.zkoss.zk.ui.Desktop;

/**
 *	IDEMPIERE-4782
 * 	@author Carlos Ruiz - globalqss - BX Service
 */
public class MFARegister extends org.compiere.process.MFARegister implements IServerPushCallback {

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
	 * Open the complete registration form when updating the UI on server push callback
	 */
	@Override
	public void updateUI() {
		ADForm form = SessionManager.getAppDesktop().openForm(SystemIDs.FORM_MFA_REGISTER);
		if (form instanceof MFARegisterForm) {
			((MFARegisterForm)form).completeRegistration(retArray, getAD_PInstance_ID());
		}
	}

}	//	MFARegister
