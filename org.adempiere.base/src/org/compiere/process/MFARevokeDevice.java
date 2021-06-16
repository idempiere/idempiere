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

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MMFARegisteredDevice;
import org.compiere.model.Query;
import org.compiere.util.Env;

/**
 *	IDEMPIERE-4782
 * 	@author Carlos Ruiz - globalqss - BX Service
 */
public class MFARevokeDevice extends SvrProcess {

	/* Revoke All */
	private Boolean p_MFARevokeAll = null;
	/* MFA Registered Device */
	private int p_MFA_RegisteredDevice_ID = 0;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "MFARevokeAll": p_MFARevokeAll = para.getParameterAsBoolean(); break;
			case "MFA_RegisteredDevice_ID": p_MFA_RegisteredDevice_ID = para.getParameterAsInt(); break;
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
			log.info("MFARevokeAll=" + p_MFARevokeAll
					+ ", MFA_RegisteredDevice_ID=" + p_MFA_RegisteredDevice_ID);

		String where;
		List<Object> params = new ArrayList<Object>();
		params.add(Env.getAD_User_ID(getCtx()));
		if (p_MFARevokeAll) {
			where = "AD_User_ID=?";
		} else {
			where = "AD_User_ID=? AND (MFA_RegisteredDevice_ID=? OR Expiration<=SYSDATE)";
			params.add(p_MFA_RegisteredDevice_ID);
		}
		List<MMFARegisteredDevice> rds = new Query(getCtx(), MMFARegisteredDevice.Table_Name, where, get_TrxName())
				.setOnlyActiveRecords(true)
				.setClient_ID()
				.setParameters(params)
				.list();
		for (MMFARegisteredDevice rd : rds) {
			rd.setIsActive(false);
			rd.saveEx();
		}

		return "@OK@";
	}

}	//	MFARevokeDevice
