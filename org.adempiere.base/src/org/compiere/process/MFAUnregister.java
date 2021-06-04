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

import org.compiere.model.MMFARegistration;

/**
 *	IDEMPIERE-4782
 * 	@author Carlos Ruiz - globalqss - BX Service
 */
public class MFAUnregister extends SvrProcess {

	/* MFA Registration */
	private int p_MFA_Registration_ID = 0;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "MFA_Registration_ID": p_MFA_Registration_ID = para.getParameterAsInt(); break;
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
			log.info("MFA_Registration_ID=" + p_MFA_Registration_ID);

		MMFARegistration reg = new MMFARegistration(getCtx(), p_MFA_Registration_ID, get_TrxName());
		reg.setIsActive(false);
		reg.setMFAUnregisteredAt(new Timestamp(System.currentTimeMillis()));
		reg.saveEx();

		return "@OK@";
	}

}	//	MFAUnregister
