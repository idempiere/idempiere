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

import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;

/**
 * Context for creating a report viewer format selector.
 * @param reportEngine report engine shown in the viewer
 * @param windowId AD_Window_ID the report was started from, 0 if none
 * @param compact true if the selector is shown in the narrow-screen toolbar popup
 */
public record ReportFormatRequest(ReportEngine reportEngine, int windowId, boolean compact) {

	/**
	 * @return print format shown in the viewer when the selector is created
	 */
	public MPrintFormat printFormat() {
		return reportEngine != null ? reportEngine.getPrintFormat() : null;
	}

	/**
	 * @return AD_Table_ID of the print format, 0 if there is none
	 */
	public int tableId() {
		MPrintFormat printFormat = printFormat();
		return printFormat != null ? printFormat.getAD_Table_ID() : 0;
	}
}
