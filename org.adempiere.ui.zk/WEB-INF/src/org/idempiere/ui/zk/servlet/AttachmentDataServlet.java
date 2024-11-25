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

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.util.ServerContext;
import org.adempiere.webui.session.SessionContextListener;
import org.compiere.model.AttachmentData;
import org.compiere.model.MAttachment;
import org.compiere.model.MRole;

/**
 * Abstract servlet to served data from attachment
 */
public abstract class AttachmentDataServlet extends HttpServlet {

	private static final long serialVersionUID = -6538946463842542593L;

	public AttachmentDataServlet() {
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
			writeAttachmentData(resp, imageData);
		} finally {
			ServerContext.dispose();
		}
	}
	
	/**
	 * Write attachment data to response
	 * @param resp
	 * @param attachmentData
	 * @throws IOException
	 */
	protected abstract void writeAttachmentData(HttpServletResponse resp, AttachmentData attachmentData) throws IOException;
}
