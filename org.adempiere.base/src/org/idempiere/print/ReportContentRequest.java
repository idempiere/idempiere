/**********************************************************************
 * This file is part of iDempiere ERP Open Source                     *
 * http://www.idempiere.org                                           *
 *                                                                    *
 * Copyright (C) Contributors                                         *
 *                                                                    *
 * This program is free software; you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2     *
 * of the License, or (at your option) any later version.              *
 **********************************************************************/
package org.idempiere.print;

import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;

/** Immutable input for report content rendering and post-processing. */
public record ReportContentRequest(ReportEngine reportEngine, ProcessInfo processInfo, String title,
		boolean applyPostProcessing) {

	public ReportContentRequest(ReportEngine reportEngine, ProcessInfo processInfo, String title) {
		this(reportEngine, processInfo, title, true);
	}

	public MPrintFormat printFormat() {
		return reportEngine != null ? reportEngine.getPrintFormat() : null;
	}

	public PrintInfo printInfo() {
		return reportEngine != null ? reportEngine.getPrintInfo() : null;
	}
}
