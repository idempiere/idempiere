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
 * Contributors:                                                       *
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/
package org.compiere.process;

import java.util.logging.Level;

import org.compiere.model.MPackageExp;

/**
 * Copy Package Details from another Pack Out
 */
public class CopyFromPackOut extends SvrProcess {

	/* Package Exp. */
	private int p_AD_Package_Exp_ID = 0;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "AD_Package_Exp_ID":
				p_AD_Package_Exp_ID = para.getParameterAsInt();
				break;
			default:
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, "Custom Parameter: " + name + "=" + para.getInfo());
				break;
			}
		}
	}

	/**
	 * Perform process.
	 * 
	 * @return Message (clear text)
	 * @throws Exception if not successful
	 */
	protected String doIt() throws Exception {
		int to_AD_Package_Exp_ID = getRecord_ID();
		if (log.isLoggable(Level.INFO))
			log.info("From AD_Package_Exp_ID=" + p_AD_Package_Exp_ID + " to " + to_AD_Package_Exp_ID);
		if (to_AD_Package_Exp_ID == 0)
			throw new IllegalArgumentException("Target AD_Package_Exp_ID == 0");
		if (p_AD_Package_Exp_ID == 0)
			throw new IllegalArgumentException("Source AD_Package_Exp_ID == 0");
		MPackageExp from = new MPackageExp(getCtx(), p_AD_Package_Exp_ID, get_TrxName());
		MPackageExp to = new MPackageExp(getCtx(), to_AD_Package_Exp_ID, get_TrxName());
		//
		int no = to.copyDetailsFrom(from);
		//
		return "@Copied@=" + no;
	} // doIt

} // CopyFromOrder
