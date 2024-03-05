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

import org.compiere.model.MAuthorizationAccount;

/**
 * Handler interface for upload of media
 * @author hengsin
 */
public interface IUploadHandler {
	/**
	 * Get label/name for this handler.
	 * @return label for handler
	 */
	public String getLabel();
	
	/**
	 * Upload media to external authorized account
	 * @param media
	 * @param account external account to upload to (for e.g, Google drive account)
	 * @return {@link UploadResponse}
	 */
	public UploadResponse uploadMedia(UploadMedia media, MAuthorizationAccount account);
}
