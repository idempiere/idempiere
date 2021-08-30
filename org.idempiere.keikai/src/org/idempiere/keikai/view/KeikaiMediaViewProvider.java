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
package org.idempiere.keikai.view;

import org.idempiere.ui.zk.media.IMediaView;
import org.idempiere.ui.zk.media.IMediaViewProvider;
import org.idempiere.ui.zk.media.Medias;
import org.osgi.service.component.annotations.Component;

/**
 * @author hengsin
 *
 */
@Component(name = "org.idempiere.keikai.view.KeikaiMediaViewProvider", immediate = true, service = IMediaViewProvider.class)
public class KeikaiMediaViewProvider implements IMediaViewProvider {

	/**
	 * default constructor
	 */
	public KeikaiMediaViewProvider() {
	}

	@Override
	public IMediaView getMediaView(String contentType, String extension, boolean mobile) {
		//keikai ose doesn't support mobile devices
		if (mobile)
			return null;
		
		if (Medias.CSV_MIME_TYPE.equals(contentType) && Medias.CSV_FILE_EXT.equals(extension)) {
			return CSVMediaView.INSTANCE;
		} else if (Medias.EXCEL_MIME_TYPE.equals(contentType) && Medias.EXCEL_FILE_EXT.equals(extension)) {
			return ExcelMediaView.INSTANCE;
		} else if (Medias.EXCEL_XML_MIME_TYPE.equals(contentType) && Medias.EXCEL_XML_FILE_EXT.equals(extension)) {
			return ExcelMediaView.INSTANCE;
		}
		
		return null;
	}

}
