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
 * - Carlos Ruiz - globalqss                                           *
 * Sponsored by FH                                                     *
 **********************************************************************/

package org.idempiere.process;

import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MRole;
import org.compiere.model.MUserRoles;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;

/**
 * @author Carlos Ruiz - globalqss
 */
@org.adempiere.base.annotation.Process
public class MaintainSupportRoles extends SvrProcess {

	private String p_IsActive;
	private static final String ACTION_ACTIVATE = "Y";
	private static final String ACTION_DEACTIVATE = "N";
	private static final String ACTION_DELETE = "D";

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("IsActive".equals(name)) {
				p_IsActive = para.getParameterAsString();
			} else {
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			}
		}
	} // prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("IsActive=" + p_IsActive);

		List<List<Object>> rows = DB.getSQLArrayObjectsEx(get_TrxName(), "SELECT ViewID FROM T_Selection WHERE AD_PInstance_ID=?", getAD_PInstance_ID());
		int cnt = 0;
		if (rows != null) {
			for (List<Object> row : rows) {
				Object viewID = row.get(0);
				if (viewID != null && viewID instanceof String) {
					String[] ids = ((String)viewID).split("\\|");
					int userID = Integer.valueOf(ids[0]);
					int roleID = Integer.valueOf(ids[1]);
					MUserRoles ur = new Query(getCtx(), MUserRoles.Table_Name, "AD_User_ID=? AND AD_Role_ID=?", get_TrxName())
							.setParameters(userID, roleID)
							.first();
					if (ACTION_ACTIVATE.equals(p_IsActive)) {
						if (ur != null) {
							if (!ur.isActive()) {
								ur.setIsActive(true);
								ur.saveEx();
								cnt++;
							}
						} else {
							ur = new MUserRoles(getCtx(), userID, roleID, get_TrxName());
							MRole role = MRole.get(getCtx(), roleID);
							ur.set_ValueNoCheck ("AD_Client_ID", role.getAD_Client_ID());
							ur.set_ValueNoCheck ("AD_Org_ID", 0);
							ur.saveEx();
							cnt++;
						}
					} else if (ACTION_DEACTIVATE.equals(p_IsActive)) {
						if (ur != null && ur.isActive()) {
							ur.setIsActive(false);
							ur.saveEx();
							cnt++;
						}
					} else if (ACTION_DELETE.equals(p_IsActive)) {
						if (ur != null) {
							ur.deleteEx(true);
							cnt++;
						}
					}
				}
			}
		}

		return cnt+" @Processed@";
	} // doIt

} // MaintainSupportRoles
