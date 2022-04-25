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
 * - trekglobal														   *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.window;

import java.util.Map;

import org.adempiere.base.upload.IUploadService;
import org.compiere.model.MAuthorizationAccount;
import org.idempiere.ui.zk.media.Medias;
import org.zkoss.util.media.AMedia;

/**
 * 
 * @author hengsin
 *
 */
public interface IReportViewerExportSource {
	
	public static final String CSV_MIME_TYPE = Medias.CSV_MIME_TYPE;
	public static final String EXCEL_MIME_TYPE = Medias.EXCEL_MIME_TYPE;	
	public static final String EXCEL_XML_MIME_TYPE = Medias.EXCEL_XML_MIME_TYPE;
	public static final String HTML_MIME_TYPE = Medias.HTML_MIME_TYPE;
	public static final String PDF_MIME_TYPE = Medias.PDF_MIME_TYPE;
	public static final String POSTSCRIPT_MIME_TYPE = Medias.POSTSCRIPT_MIME_TYPE;	
	public static final String TEXT_MIME_TYPE = Medias.TEXT_MIME_TYPE;
	public static final String XML_MIME_TYPE = Medias.XML_MIME_TYPE;
	
	public static final String CSV_FILE_EXT = Medias.CSV_FILE_EXT;
	public static final String SSV_FILE_EXT = Medias.SSV_FILE_EXT;
	public static final String EXCEL_FILE_EXT = Medias.EXCEL_FILE_EXT;	
	public static final String EXCEL_XML_FILE_EXT = Medias.EXCEL_XML_FILE_EXT;
	public static final String HTML_FILE_EXT = Medias.HTML_FILE_EXT;
	public static final String PDF_FILE_EXT = Medias.PDF_FILE_EXT;
	public static final String POSTSCRIPT_FILE_EXT = Medias.POSTSCRIPT_FILE_EXT;	
	public static final String TEXT_FILE_EXT = Medias.TEXT_FILE_EXT;
	public static final String XML_FILE_EXT = Medias.XML_FILE_EXT;
	
	/**
	 * Get media/content by content type and file extension
	 * @param contentType
	 * @param fileExtension
	 * @return {@link AMedia}
	 */
	public AMedia getMedia(String contentType, String fileExtension);
	
	/**
	 * 
	 * @return list of supported export formats
	 */
	public ExportFormat[] getExportFormats();
	
	/**
	 * 
	 * @return current mime/content type
	 */
	public String getContentType();
	
	/**
	 * 
	 * @return current file extension/format
	 */
	public String getFileExtension();
	
	/**
	 * 
	 * @return list of available authorized upload services
	 */
	public Map<MAuthorizationAccount, IUploadService> getUploadServiceMap();
	
	/**
	 * 
	 * @return name of report
	 */
	public String getReportName();
	
	/**
	 * 
	 * Model to hold export format properties
	 * @author hengsin
	 *
	 */
	public static final class ExportFormat {
		public String label;
		public String extension;
		public String contentType;
		
		public ExportFormat(String label, String extension, String contentType) {
			this.label = label;
			this.extension = extension;
			this.contentType = contentType;
		}
	}
}
