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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.ui.zk.media;

import com.google.common.net.MediaType;

/**
 * 
 * @author hengsin
 *
 */
public final class Medias {

	public static final String CSV_MIME_TYPE = MediaType.CSV_UTF_8.toString();
	public static final String EXCEL_MIME_TYPE = MediaType.MICROSOFT_EXCEL.toString();	
	public static final String EXCEL_XML_MIME_TYPE = MediaType.OOXML_SHEET.toString();
	public static final String HTML_MIME_TYPE = MediaType.HTML_UTF_8.toString();
	public static final String PDF_MIME_TYPE = MediaType.PDF.toString();
	public static final String POSTSCRIPT_MIME_TYPE = MediaType.POSTSCRIPT.toString();	
	public static final String TEXT_MIME_TYPE = MediaType.PLAIN_TEXT_UTF_8.toString();
	public static final String XML_MIME_TYPE = MediaType.XML_UTF_8.toString();
	
	public static final String CSV_FILE_EXT = "csv";
	public static final String SSV_FILE_EXT = "ssv";
	public static final String EXCEL_FILE_EXT = "xls";	
	public static final String EXCEL_XML_FILE_EXT = "xlsx";
	public static final String HTML_FILE_EXT = "html";
	public static final String PDF_FILE_EXT = "pdf";
	public static final String POSTSCRIPT_FILE_EXT = "ps";	
	public static final String TEXT_FILE_EXT = "txt";
	public static final String XML_FILE_EXT = "xml";
	
	private Medias() {
	}

}
