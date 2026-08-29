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

/**
 * Post-processes generated report content.
 * <p>
 * Applicable services are called in descending OSGi service ranking order.
 * Implementations may return {@code input} after modifying it or return a new
 * file. Typical uses include ZUGFeRD/Factur-X, PDF attachments, PDF/A,
 * signatures and encryption.
 */
public interface IReportContentProcessor {

	/**
	 * Tests whether this processor applies to the generated content.
	 *
	 * @param request report content request
	 * @param contentType requested MIME type
	 * @param fileExtension requested file extension
	 * @return {@code true} to invoke {@link #process}
	 */
	boolean isApplicable(ReportContentRequest request, String contentType, String fileExtension);

	/**
	 * Processes generated report content.
	 *
	 * @param request report content request
	 * @param contentType requested MIME type
	 * @param fileExtension requested file extension
	 * @param input generated content
	 * @return processed content; never {@code null}
	 */
	File process(ReportContentRequest request, String contentType, String fileExtension, File input);
}
