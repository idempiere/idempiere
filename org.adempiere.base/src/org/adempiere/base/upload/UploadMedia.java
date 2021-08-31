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
package org.adempiere.base.upload;

import java.io.InputStream;

/**
 * 
 * representation of media
 * @author hengsin
 *
 */
public class UploadMedia {

	private String contentType;
	private String name;
	private InputStream inputStream;
	private long contentLength;
	
	/**
	 * 
	 * @param name
	 * @param contentType
	 * @param inputStream
	 * @param contentLength
	 */
	public UploadMedia(String name, String contentType, InputStream inputStream, long contentLength) {
		super();
		this.name = name;
		this.contentType = contentType;
		this.inputStream = inputStream;
		this.contentLength = contentLength;
	}

	/**
	 * 
	 * @return content type of media
	 */
	public String getContentType() {
		return contentType;
	}

	/**
	 * 
	 * @return name/label of media
	 */
	public String getName() {
		return name;
	}

	/**
	 * 
	 * @return {@link InputStream} for media content
	 */
	public InputStream getInputStream() {
		return inputStream;
	}

	/**
	 * 
	 * @return length of media content
	 */
	public long getContentLength() {
		return contentLength;
	}
	
}
