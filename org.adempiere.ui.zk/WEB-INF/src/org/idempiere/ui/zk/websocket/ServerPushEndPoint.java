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
package org.idempiere.ui.zk.websocket;

import java.io.IOException;
import java.util.logging.Level;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.compiere.util.CLogger;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
@ServerEndpoint(value="/serverpush/{dtid}")
public class ServerPushEndPoint {

	private Session session;
	private String dtid;

	/**
	 * 
	 */
	public ServerPushEndPoint() {
	}

	
	@OnClose
	public void onClose(Session sess) throws IOException {
		if (this.session != null) {
			this.session = null;
			WebSocketServerPush.unregisterEndPoint(dtid);
		}
	}


	@OnOpen
	public void onOpen(Session sess, @PathParam("dtid") String dtid) throws IOException {
		if (!Util.isEmpty(dtid, true) && WebSocketServerPush.isValidDesktopId(dtid)) {			
			session = sess;
			this.dtid = dtid;
			WebSocketServerPush.registerEndPoint(dtid, this);
		}
	}


	@OnError
	public void onError(Session sess, Throwable throwable) {
		CLogger.getCLogger(getClass()).log(Level.WARNING, throwable.getMessage(), throwable);	
	}


	@OnMessage
	public void onMessage(Session session, String message) { 
		if (session == this.session && !Util.isEmpty(message)) {
			if (message.equals("__ping__")) {
				try {
					session.getBasicRemote().sendText("__pong__");
				} catch (IllegalArgumentException | IOException e) {
					CLogger.getCLogger(getClass()).log(Level.WARNING, e.getMessage(), e);
				}
			}
		}
	}

	/**
	 * Message client to send echo event to server
	 */
	public void echo() {
		if (session != null) {
			try {
				session.getBasicRemote().sendText("echo");
			} catch (IOException e) {
				CLogger.getCLogger(getClass()).log(Level.WARNING, e.getMessage(), e);
			}
		}
	}
}
