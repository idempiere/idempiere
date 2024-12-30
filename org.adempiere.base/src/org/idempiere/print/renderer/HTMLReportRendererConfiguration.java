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

import java.io.File;
import java.io.Writer;

import org.compiere.print.IHTMLExtension;
import org.compiere.util.Language;

/**
 * Configuration for HTML content renderer
 */
public class HTMLReportRendererConfiguration implements IReportRendererConfiguration {

	private boolean onlyTable;
	private IHTMLExtension extension;
	private boolean isExport;
	private File file;
	private Writer writer;
	private Language language;
	private String contextPath;
	
	public static final String ID = "HTML";
	public static final String FILE_EXTENSION = "html";
	
	public HTMLReportRendererConfiguration() {
	}
	
	/**
	 * Is only generate html table instead of html document
	 * @return true if only generate html table instead of html document
	 */
	public boolean isOnlyTable() {
		return onlyTable;
	}

	/**
	 * Set only generate html table or html document
	 * @param onlyTable
	 */
	public HTMLReportRendererConfiguration setOnlyTable(boolean onlyTable) {
		this.onlyTable = onlyTable;
		return this;
	}

	/**
	 * Get HTML content extension
	 * @return HTML content extension
	 */
	public IHTMLExtension getExtension() {
		return extension;
	}

	/**
	 * Set HTML content extension
	 * @param extension
	 */
	public HTMLReportRendererConfiguration setExtension(IHTMLExtension extension) {
		this.extension = extension;
		return this;
	}

	/**
	 * Is renderer support export
	 * @return true if renderer support export
	 */
	public boolean isExport() {
		return isExport;
	}

	/**
	 * Set is renderer support export
	 * @param isExport
	 */
	public HTMLReportRendererConfiguration setExport(boolean isExport) {
		this.isExport = isExport;
		return this;
	}

	@Override	
	public File getOutputFile() {
		return file;
	}

	/**
	 * Set output file
	 * @param file
	 */
	public HTMLReportRendererConfiguration setOutputFile(File file) {
		this.file = file;
		return this;
	}

	@Override
	public Writer getOutputWriter() {
		return writer;
	}

	/**
	 * Set output writer
	 * @param writer
	 */
	public HTMLReportRendererConfiguration setOutputWriter(Writer writer) {
		this.writer = writer;
		return this;
	}

	/**
	 * Set content language
	 * @param language
	 */
	public HTMLReportRendererConfiguration setLanguage(Language language) {
		this.language = language;
		return this;
	}

	/**
	 * Get content language
	 * @return content language
	 */
	public Language getLanguage() {
		return language;
	}
	
	/**
	 * Set web context path
	 * @param contextPath
	 */
	public HTMLReportRendererConfiguration setContextPath(String contextPath) {
		this.contextPath = contextPath;
		return this;
	}

	/**
	 * Get web context path
	 * @return web context path
	 */
	public String getContextPath() {
		return contextPath;
	}
}
