/**********************************************************************
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
* - Carlos Ruiz                                                       *
**********************************************************************/
package org.idempiere.process;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MProcessPara;
import org.compiere.model.MTestUU;
import org.compiere.model.Query;
import org.compiere.model.X_TestUUDet;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

/**
 * @author Carlos Ruiz - globalqss - bx-service
 */
@org.adempiere.base.annotation.Process
public class TestUUChangeActive extends SvrProcess {

	List<String> m_UUIDs;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
		}
		m_UUIDs = getRecord_UUs();
		if (m_UUIDs == null || m_UUIDs.size() == 0) {
			m_UUIDs = new ArrayList<String>();
			m_UUIDs.add(getRecord_UU());
		}

	} // prepare

	/**
	 * Perform process.
	 * 
	 * @return Message
	 * @throws Exception
	 */
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO))
			log.info("");

		for (String l_UUID : m_UUIDs) {
			MTestUU testuu = new MTestUU(getCtx(), l_UUID, get_TrxName());
			boolean setActive = ! testuu.isActive();
			testuu.setIsActive(setActive);
			testuu.saveEx();
			List<X_TestUUDet> dets = new Query(getCtx(), X_TestUUDet.Table_Name, X_TestUUDet.COLUMNNAME_TestUU_UU+"=?", get_TrxName())
				.setParameters(l_UUID)
				.list();
			for (X_TestUUDet det : dets) {
				det.setIsActive(setActive);
				det.saveEx();
			}
		}

		return "@OK@";
	} // doIt

} // TestUUChangeActive
