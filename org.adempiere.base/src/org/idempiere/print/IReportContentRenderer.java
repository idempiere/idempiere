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

import java.io.File;

/** Generates report content without depending on a user interface toolkit. */
public interface IReportContentRenderer {
	File getContent(String contentType, String fileExtension);

	ReportContentType[] getSupportedContentTypes();

	default int getRowCount() {
		return -1;
	}
}
