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

/** UI-independent description of a supported report output type. */
public record ReportContentType(String name, String fileExtension, String contentType) {

	/**
	 * Internal content type for an HTML report with viewer interaction such as
	 * drill-down links. Content delivered to a browser still uses {@code text/html}.
	 * Only renderers that actually produce viewer-interactive HTML
	 * (e.g. with drill-down links) should advertise this type.
	 */
	public static final String HTML_INTERACTIVE_CONTENT_TYPE = "text/html; mode=interactive";

	/**
	 * @param contentType content type to test
	 * @return {@code true} for the internal interactive HTML content type
	 */
	public static boolean isInteractiveHTML(String contentType) {
		return HTML_INTERACTIVE_CONTENT_TYPE.equalsIgnoreCase(contentType);
	}
}
