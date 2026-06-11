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

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

import org.apache.hc.client5.http.cookie.BasicCookieStore;
import org.apache.hc.client5.http.impl.cookie.BasicClientCookie;

public class EndpointConfigurator extends ServerEndpointConfig.Configurator {

	@Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        // Store the ServletContext, HttpSession and remote address in user properties for the ServerPushEndPoint to access
        HttpSession httpSession = (HttpSession) request.getHttpSession();
        if (httpSession != null) {
        	Object ipAttr = httpSession.getAttribute(WebSocketServerPush.WS_CLIENT_IP);
        	if (ipAttr != null) {
        		String clientIp = ipAttr.toString();
        		httpSession.removeAttribute(WebSocketServerPush.WS_CLIENT_IP);
        		sec.getUserProperties().put(WebSocketServerPush.WS_CLIENT_IP, clientIp);
        	}
            sec.getUserProperties().put(HttpSession.class.getName(), httpSession);
            sec.getUserProperties().put(ServletContext.class.getName(), httpSession.getServletContext());
            sec.getUserProperties().put(HandshakeRequest.class.getName(), request);

            //create BasicCookieStore from request
            Map<String, List<String>> headers = request.getHeaders();
            List<String> cookieHeaders = headers.get("Cookie");
            if (cookieHeaders == null)
            	cookieHeaders = headers.get("cookie");
            if (cookieHeaders != null && !cookieHeaders.isEmpty()) {
            	BasicCookieStore cookieStore = new BasicCookieStore();
            	for(String cookieHeader : cookieHeaders) {
            		String[] cookies = cookieHeader.split(";");
                    for (String cookie : cookies) {
                        String[] pair = cookie.split("=", 2);
                        if (pair.length == 2) {
                        	String name = pair[0].trim();
                        	String value = pair[1].trim();
                        	BasicClientCookie c = new BasicClientCookie(name, value);
                            // localhost domain for internal request cookies
                            c.setDomain("localhost");
                        	cookieStore.addCookie(c);
                        }
                    }
            	}
            	sec.getUserProperties().put(BasicCookieStore.class.getName(), cookieStore);
            }
        }
    }
}
