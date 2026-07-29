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
package org.idempiere.ui.zk.report;

import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;

/** Immutable input for an {@link IReportViewerContentRendererFactory}. */
public final class ReportViewerRequest {
	private final ReportEngine reportEngine;
	private final MPrintFormat printFormat;
	private final PrintInfo printInfo;
	private final String title;

	public ReportViewerRequest(ReportEngine reportEngine, MPrintFormat printFormat, PrintInfo printInfo, String title) {
		this.reportEngine = reportEngine;
		this.printFormat = printFormat;
		this.printInfo = printInfo;
		this.title = title;
	}

	public ReportEngine getReportEngine() { return reportEngine; }
	public MPrintFormat getPrintFormat() { return printFormat; }
	public PrintInfo getPrintInfo() { return printInfo; }
	public String getTitle() { return title; }
}
