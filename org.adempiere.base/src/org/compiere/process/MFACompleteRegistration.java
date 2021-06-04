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

import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.IMFAMechanism;
import org.compiere.model.MMFAMethod;
import org.compiere.model.MMFARegistration;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	IDEMPIERE-4782
 * 	@author Carlos Ruiz - globalqss - BX Service
 */
public class MFACompleteRegistration extends SvrProcess {
	/* MFA Registration */
	private int p_MFA_Registration_ID = 0;
	/* Validation Code */
	private String p_MFAValidationCode = null;
	/* Name */
	private String p_Name = null;
	/* Preferred */
	private boolean p_IsUserMFAPreferred = false;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "MFA_Registration_ID": p_MFA_Registration_ID = para.getParameterAsInt(); break;
			case "MFAValidationCode": p_MFAValidationCode = para.getParameterAsString(); break;
			case "Name": p_Name = para.getParameterAsString(); break;
			case "IsUserMFAPreferred": p_IsUserMFAPreferred = para.getParameterAsBoolean(); break;
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
			log.info("MFA_Registration_ID=" + p_MFA_Registration_ID
					+ ", MFAValidationCode=" + p_MFAValidationCode
					+ ", Name=" + p_Name
					+ ", IsUserMFAPreferred=" + p_IsUserMFAPreferred);

		MMFARegistration reg = new MMFARegistration(getCtx(), p_MFA_Registration_ID, get_TrxName());
		if (reg.isValid())
			throw new AdempiereException(Msg.getMsg(getCtx(), "MFARegistrationAlreadyValid"));

		if (Util.isEmpty(p_MFAValidationCode))
			throw new AdempiereException(Msg.getMsg(getCtx(), "MFACodeRequired"));

		Timestamp now = new Timestamp(System.currentTimeMillis());
		if (reg.getExpiration() != null && now.after(reg.getExpiration())) {
			reg.setIsActive(false);
			reg.saveEx(null);
			throw new AdempiereException(Msg.getMsg(getCtx(), "MFARegistrationExpired"));
		}
		
		MMFAMethod method = new MMFAMethod(getCtx(), reg.getMFA_Method_ID(), get_TrxName());
		IMFAMechanism mechanism = method.getMFAMechanism();

		String msg = mechanism.complete(getCtx(), reg, p_MFAValidationCode, p_Name, p_IsUserMFAPreferred, get_TrxName());
		return msg;
	}

}	//	RegisterMFA
