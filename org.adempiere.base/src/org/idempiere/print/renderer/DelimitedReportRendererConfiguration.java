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

import org.compiere.util.Language;

/**
 * Abstract base class for delimited content renderer configuration
 */
public abstract class DelimitedReportRendererConfiguration implements IReportRendererConfiguration {

	private File file;
	private Writer writer;
	private Language language;
	
	public DelimitedReportRendererConfiguration() {
	}

	@Override	
	public File getOutputFile() {
		return file;
	}

	public DelimitedReportRendererConfiguration setOutputFile(File file) {
		this.file = file;
		return this;
	}

	@Override
	public Writer getOutputWriter() {
		return writer;
	}

	public DelimitedReportRendererConfiguration setOutputWriter(Writer writer) {
		this.writer = writer;
		return this;
	}

	public DelimitedReportRendererConfiguration setLanguage(Language language) {
		this.language = language;
		return this;
	}
	
	public Language getLanguage() {
		return language;
	}
	
	public abstract char getDelimiter();	
}
