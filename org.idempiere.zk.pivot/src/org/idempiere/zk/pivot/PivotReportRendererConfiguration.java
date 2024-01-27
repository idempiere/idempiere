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
package org.idempiere.zk.pivot;

import java.io.File;
import java.io.Writer;

import org.compiere.util.Language;
import org.idempiere.print.renderer.IReportRendererConfiguration;

public class PivotReportRendererConfiguration implements IReportRendererConfiguration {

	public static final String ID = "Pivot";
	public static final String FILE_EXTENSION = "pivot.html";
	
	private boolean isExport;
	private File file;
	private Writer writer;
	private Language language;
	
	public PivotReportRendererConfiguration() {
	}

	/**
	 * Is for export or preview
	 * @return true if it is for export
	 */
	public boolean isExport() {
		return isExport;
	}

	/**
	 * Set is for export or preview
	 * @param isExport
	 */
	public PivotReportRendererConfiguration setExport(boolean isExport) {
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
	public PivotReportRendererConfiguration setOutputFile(File file) {
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
	public PivotReportRendererConfiguration setOutputWriter(Writer writer) {
		this.writer = writer;
		return this;
	}

	/**
	 * Set content language
	 * @param language
	 */
	public PivotReportRendererConfiguration setLanguage(Language language) {
		this.language = language;
		return this;
	}

	/**
	 * Get content language
	 * @return language
	 */
	public Language getLanguage() {
		return language;
	}
	
}
