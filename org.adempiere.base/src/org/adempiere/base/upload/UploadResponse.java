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

/**
 * 
 * Response from upload service
 * @author hengsin
 *
 */
public class UploadResponse {
	
	private String link;
	private String linkLabel;
	
	/**
	 * 
	 * @param link
	 * @param linkLabel
	 */
	public UploadResponse(String link, String linkLabel) {
		super();
		this.link = link;
		this.linkLabel = linkLabel;
	}

	/**
	 * 
	 * @return link url to the uploaded file
	 */
	public String getLink() {
		return link;
	}

	/**
	 * 
	 * @return label for the uploaded file
	 */
	public String getLinkLabel() {
		return linkLabel;
	}
}
