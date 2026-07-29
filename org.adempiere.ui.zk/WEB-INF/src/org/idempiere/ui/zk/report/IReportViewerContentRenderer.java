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

import org.adempiere.webui.window.IReportViewerExportSource.ExportFormat;
import org.zkoss.util.media.AMedia;

/** Generates the media displayed or exported by the report viewer. */
public interface IReportViewerContentRenderer {
	AMedia getMedia(String contentType, String fileExtension);
	ExportFormat[] getExportFormats();
	default int getRowCount() {
		return -1;
	}
}
