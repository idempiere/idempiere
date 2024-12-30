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
package org.idempiere.ui.zk.servlet;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import org.compiere.model.AttachmentData;
import org.compiere.util.Util;

@WebServlet(urlPatterns = "/aimages")
public class AttachmentImageServlet extends AttachmentDataServlet {

	private static final long serialVersionUID = 4371449567871658562L;

	public AttachmentImageServlet() {
	}

	@Override
	protected void writeAttachmentData(HttpServletResponse resp, AttachmentData imageData) throws IOException {
		String contentType = null;
		Iterator<ImageReader> readers = null;
		try {
			readers = ImageIO.getImageReaders(ImageIO.createImageInputStream(new ByteArrayInputStream(imageData.data())));
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
		while(readers.hasNext()) {
			ImageReader reader = readers.next();
			try {
				contentType = reader.getFormatName();
				if (!Util.isEmpty(contentType))
					break;
			} catch (IOException e) {
			}
		}
		//imageio not workings for svg
		if (contentType == null) {
			if (imageData.name() != null && imageData.name().toLowerCase().endsWith(".svg")) {
				contentType = "image/svg+xml";
			}
		}
		if (contentType != null) {
			resp.setContentType(contentType);
			BufferedOutputStream bos = new BufferedOutputStream(resp.getOutputStream());
			try {
				bos.write(imageData.data());
				bos.flush();
			} finally {
				bos.close();
			}
		}
	}
}
