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
 * - Carlos Ruiz - globalqss - bxservice                               *
 * Sponsored by FH                                                     *
 **********************************************************************/

package org.idempiere.process;

import java.util.logging.Level;

import org.compiere.model.MProcessPara;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;

@org.adempiere.base.annotation.Process
public class DiscardThisVerifyMigration extends SvrProcess {

	// Process to discard a verify migration process
	// inactivate the ad_pinstance
	// delete the related records from ad_verifymigration

	/* Process Instance */
	private int p_AD_PInstance_ID = 0;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			default:
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
				break;
			}
		}
		p_AD_PInstance_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO))
			log.info("Process Instance " + p_AD_PInstance_ID);

		int cnt = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM AD_VerifyMigration WHERE AD_PInstance_ID=? AND IsActive='Y' AND IsIgnore='Y'", p_AD_PInstance_ID);
		if (cnt > 0)
			return "@Error@ @VM_HasIgnoredRecords@";

		cnt = DB.executeUpdateEx("DELETE FROM AD_VerifyMigration WHERE AD_PInstance_ID=?", new Object[] {p_AD_PInstance_ID}, get_TrxName());
		DB.executeUpdateEx("UPDATE AD_PInstance SET IsActive='N' WHERE AD_PInstance_ID=?", new Object[] {p_AD_PInstance_ID}, get_TrxName());

		return "@Deleted@ = " + cnt;
	}

}
