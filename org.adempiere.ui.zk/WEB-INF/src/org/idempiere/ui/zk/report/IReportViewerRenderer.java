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

import org.adempiere.webui.window.ZkReportViewer;
import org.zkoss.util.media.AMedia;

/**
 * Service interface for rendering of report viewer content.<br/>
 * Implementation must be thread safe.
 */
public interface IReportViewerRenderer {

	/**
	 * Get id of renderer
	 * @return renderer id (PDF, HTML, etc)
	 */
	String getId();
	
	/**
	 * Renderer label for export output type selection
	 * @return label for export output type selection
	 */
	String getExportLabel();
	
	/**
	 * Renderer label for preview output type selection
	 * @return label for preview output type selection
	 */
	default String getPreviewLabel() {
		return getId();
	}
	
	/**
	 * Get MIME content type (text/html, etc)
	 * @return MIME content type
	 */
	String getContentType();
	
	/**
	 * Output file extension (without dot)
	 * @return output file extension (html, csv, xls, etc)
	 */
	String getFileExtension();
	
	/**
	 * Is renderer support export
	 * @return true if renderer support export
	 */
	boolean isExport();
	
	/**
	 * Is renderer support preview
	 * @param roleCanExport true if role can export
	 * @return true if renderer support preview
	 */
	boolean isPreview(boolean roleCanExport);
	
	/**
	 * Render output media for report
	 * @param viewer
	 * @param export
	 * @return media
	 */
	AMedia renderMedia(ZkReportViewer viewer, boolean export);	
	
	/**
	 * Is export and preview generate the exact same output
	 * @return true if export and preview generate the exact same output
	 */
	default boolean isSameContentForExportAndPreview() {
		return true;
	}
	
	/**
	 * Create file name prefix from name
	 * @param name
	 * @return file name prefix from name
	 */
	default String makePrefix(String name) {
		StringBuilder prefix = new StringBuilder();
		char[] nameArray = name.toCharArray();
		for (char ch : nameArray) {
			if (Character.isLetterOrDigit(ch)) {
				prefix.append(ch);
			} else {
				prefix.append("_");
			}
		}
		return prefix.toString();
	}
}
