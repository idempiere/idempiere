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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MRole;
import org.compiere.print.MPrintFormat;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Builds the list of print formats the report viewer offers to a role.
 * The role checks live here so that they apply to every {@link IReportFormatSelector}.
 */
public final class ReportFormatLoader {

	private static final CLogger logger = CLogger.getCLogger(ReportFormatLoader.class);

	private ReportFormatLoader() {
	}

	/**
	 * Load the print formats of the current table that the role may read, followed by the create actions
	 * if the role may create print formats.
	 * @param role role to check access for
	 * @param current print format shown in the viewer
	 * @param windowId AD_Window_ID the report was started from, 0 if none
	 * @param selectedFormatId AD_PrintFormat_ID that will be selected, used for the window access check of the create actions
	 * @param limitToReportView true to offer only the print formats of the report view of the current print format.
	 * The role checks apply either way
	 * @return immutable list, formats ordered by name
	 */
	public static List<ReportFormatEntry> load(MRole role, MPrintFormat current, int windowId, int selectedFormatId,
			boolean limitToReportView) {
		List<ReportFormatEntry> entries = new ArrayList<>();
		int reportViewID = limitToReportView ? current.getAD_ReportView_ID() : 0;
		String sql = role.addAccessSQL(
			"SELECT * "
				+ "FROM AD_PrintFormat "
				+ "WHERE AD_Table_ID=? "
				+ "AND IsActive='Y' "
				+ (windowId > 0 ? "AND (AD_Window_ID=? OR AD_Window_ID IS NULL) " : "")
				+ (reportViewID > 0 ? "AND AD_ReportView_ID=? " : "")
				+ "ORDER BY Name",
			"AD_PrintFormat", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			int idx = 1;
			pstmt.setInt(idx++, current.getAD_Table_ID());
			if (windowId > 0)
				pstmt.setInt(idx++, windowId);
			if (reportViewID > 0)
				pstmt.setInt(idx++, reportViewID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MPrintFormat printFormat = new MPrintFormat(Env.getCtx(), rs, null);
				entries.add(new ReportFormatEntry(printFormat.get_ID(),
						printFormat.get_Translation(MPrintFormat.COLUMNNAME_Name, Env.getAD_Language(Env.getCtx()), true),
						printFormat.getAD_Client_ID(), ReportFormatEntry.Kind.FORMAT));
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, sql, e);
		} finally {
			DB.close(rs, pstmt);
		}
		// IDEMPIERE-297 - Check for Table Access and Window Access for New Report
		int pfAD_Window_ID = MPrintFormat.getZoomWindowID(selectedFormatId);
		if (role.isTableAccess(MPrintFormat.Table_ID, false)
			&& Boolean.TRUE.equals(role.getWindowAccess(pfAD_Window_ID))) {
			entries.add(new ReportFormatEntry(ReportFormatEntry.KEY_NEW,
					"** " + Msg.getMsg(Env.getCtx(), "NewReport") + " **", 0, ReportFormatEntry.Kind.NEW));
			entries.add(new ReportFormatEntry(ReportFormatEntry.KEY_COPY,
					"** " + Msg.getMsg(Env.getCtx(), "CopyReport") + " **", 0, ReportFormatEntry.Kind.COPY));
		}
		return Collections.unmodifiableList(entries);
	}
}
