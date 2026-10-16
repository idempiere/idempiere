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
 **********************************************************************/
package org.idempiere.ui.zk.report;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.compiere.model.MRole;
import org.compiere.model.Query;
import org.compiere.print.MPrintFormat;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Builds the list of print formats the report viewer offers to a role.
 * The role checks live here so that they apply to every {@link IReportFormatSelector}.
 */
public final class ReportFormatLoader {

	private ReportFormatLoader() {
	}

	/**
	 * Load the print formats of the current table that the current user's role may read, followed by the create actions
	 * if the given role may create print formats.
	 * The print formats are read with a {@link Query} that applies the access filter of the default role
	 * ({@link MRole#getDefault()}), the role the viewer passes in.
	 * @param role role to check the table and window access of the create actions for
	 * @param current print format shown in the viewer
	 * @param windowId AD_Window_ID the report was started from, 0 if none
	 * @param selectedFormatId AD_PrintFormat_ID that will be selected, used for the window access check of the create actions
	 * @return immutable list, formats ordered by name
	 */
	public static List<ReportFormatEntry> load(MRole role, MPrintFormat current, int windowId, int selectedFormatId) {
		List<ReportFormatEntry> entries = new ArrayList<>();
		int reportViewID = current.getAD_ReportView_ID();
		StringBuilder where = new StringBuilder(MPrintFormat.COLUMNNAME_AD_Table_ID).append("=?");
		List<Object> params = new ArrayList<>();
		params.add(current.getAD_Table_ID());
		if (windowId > 0) {
			where.append(" AND (").append(MPrintFormat.COLUMNNAME_AD_Window_ID).append("=? OR ")
					.append(MPrintFormat.COLUMNNAME_AD_Window_ID).append(" IS NULL)");
			params.add(windowId);
		}
		if (reportViewID > 0) {
			where.append(" AND ").append(MPrintFormat.COLUMNNAME_AD_ReportView_ID).append("=?");
			params.add(reportViewID);
		}
		List<MPrintFormat> printFormats = new Query(Env.getCtx(), MPrintFormat.Table_Name, where.toString(), null)
				.setParameters(params)
				.setOnlyActiveRecords(true)
				.setApplyAccessFilter(MRole.SQL_NOTQUALIFIED, MRole.SQL_RO)
				.setOrderBy(MPrintFormat.COLUMNNAME_Name)
				.list();
		String language = Env.getAD_Language(Env.getCtx());
		for (MPrintFormat printFormat : printFormats) {
			entries.add(new ReportFormatEntry(printFormat.get_ID(),
					printFormat.get_Translation(MPrintFormat.COLUMNNAME_Name, language, true),
					printFormat.get_Translation(MPrintFormat.COLUMNNAME_Description, language, true),
					printFormat.getAD_Client_ID(), ReportFormatEntry.Kind.FORMAT));
		}
		// IDEMPIERE-297 - Check for Table Access and Window Access for New Report
		int pfAD_Window_ID = MPrintFormat.getZoomWindowID(selectedFormatId);
		if (role.isTableAccess(MPrintFormat.Table_ID, false)
			&& Boolean.TRUE.equals(role.getWindowAccess(pfAD_Window_ID))) {
			entries.add(new ReportFormatEntry(ReportFormatEntry.KEY_NEW,
					"** " + Msg.getMsg(Env.getCtx(), "NewReport") + " **", null, 0, ReportFormatEntry.Kind.NEW));
			entries.add(new ReportFormatEntry(ReportFormatEntry.KEY_COPY,
					"** " + Msg.getMsg(Env.getCtx(), "CopyReport") + " **", null, 0, ReportFormatEntry.Kind.COPY));
		}
		return Collections.unmodifiableList(entries);
	}
}
