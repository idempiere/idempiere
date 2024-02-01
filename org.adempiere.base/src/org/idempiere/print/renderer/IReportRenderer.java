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
package org.idempiere.print.renderer;

import org.compiere.print.ReportEngine;

/**
 * Content rendering service for report engine.<br/>
 * Implementation must be thread safe.
 * @param <T> Renderer configuration type
 */
public interface IReportRenderer<T extends IReportRendererConfiguration> {
	/**
	 * Get id of renderer
	 * @return renderer id (HTML, XLS, etc)
	 */
	String getId();
	
	/**
	 * Get renderer name
	 * @return renderer name
	 */
	String getName();
	
	/**
	 * Get MIME content type (text/html, etc)
	 * @return MIME content type
	 */
	String getContentType();
	
	/**
	 * Get file extension (without dot)
	 * @return file extension
	 */
	String getFileExtension();
	
	/**
	 * Render content for report engine
	 * @param reportEngine
	 * @param configuration
	 */
	void renderReport(ReportEngine reportEngine, T configuration);
	
	/**
	 * Is binary content
	 * @return true if content is binary
	 */
	boolean isBinary();
	
	/**
	 * Get configuration type
	 * @return configuration type
	 */
	Class<T> getConfigurationType ();
}
