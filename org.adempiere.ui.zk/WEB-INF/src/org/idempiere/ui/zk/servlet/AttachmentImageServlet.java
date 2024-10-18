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
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.util.ServerContext;
import org.adempiere.webui.session.SessionContextListener;
import org.compiere.model.AttachmentData;
import org.compiere.model.MAttachment;
import org.compiere.model.MRole;
import org.compiere.util.Util;

@WebServlet(urlPatterns = "/aimages")
public class AttachmentImageServlet extends HttpServlet {

	private static final long serialVersionUID = 4371449567871658562L;

	public AttachmentImageServlet() {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		Properties ctx = null;
		if (session != null) {			
			try {
				ctx = (Properties)session.getAttribute(SessionContextListener.SESSION_CTX);
			} catch (IllegalStateException e) {
			}
		}
		
		if (ctx == null || ctx.isEmpty())
			return;
		
		try {
			ServerContext.setCurrentInstance(ctx);
			if (MRole.getDefault() == null)
				return;
			
			//attachment/tableName/index or filename pattern
			String path = req.getParameter("path");
			//id or uuid
			String id = req.getParameter("recordid").trim();
			Object key = id.length() == 36 ? id : Integer.parseInt(id);
			AttachmentData imageData = MAttachment.getAttachmentData(path, key);
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
		} finally {
			ServerContext.dispose();
		}
	}
}
