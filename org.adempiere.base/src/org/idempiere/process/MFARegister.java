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

package org.idempiere.process;

import java.util.logging.Level;

import org.compiere.model.IMFAMechanism;
import org.compiere.model.MMFAMethod;
import org.compiere.model.MMFARegistration;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.Msg;

/**
 *	IDEMPIERE-4782
 * 	@author Carlos Ruiz - globalqss - BX Service
 */
public class MFARegister extends SvrProcess {

	/* MFA Method */
	private int p_MFA_Method_ID = 0;
	/* Parameter Value */
	private String p_ParameterValue = null;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "MFA_Method_ID": p_MFA_Method_ID = para.getParameterAsInt(); break;
			case "ParameterValue": p_ParameterValue = para.getParameterAsString(); break;
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
			log.info("MFA_Method_ID=" + p_MFA_Method_ID
					+ ", ParameterValue=" + p_ParameterValue);

		MMFAMethod method = new MMFAMethod(getCtx(), p_MFA_Method_ID, get_TrxName());
		IMFAMechanism mechanism = method.getMFAMechanism();

		Object[] ret = mechanism.register(getCtx(), method, p_ParameterValue, get_TrxName());
		if (ret == null || ret.length == 0 || ! (ret[0] instanceof String) )
			throw new AdempiereSystemError("Wrong return from mechanism.validate");

		MMFARegistration reg = null;
		if (ret.length > 1) {
			for (int i = 1; i < ret.length; i++) {
				if (ret[i] instanceof String) {
					String reti = (String) ret[i];
					if (reti.startsWith("data:image/png;base64,"))
						addLog("<img src=\"" + reti + "\"/>"); // show QR code
					else
						addLog((String) reti); 
				} else if (ret[i] instanceof MMFARegistration) {
					reg = (MMFARegistration) ret[i];
				}
			}
		}
		if (reg != null)
			addLog(0, null, null, Msg.parseTranslation(getCtx(), "@Created@: @MFA_Registration_ID@"), MMFARegistration.Table_ID, reg.getMFA_Registration_ID());

		return (String) ret[0];
	}

}	//	MFARegister
