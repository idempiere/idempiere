/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2007 Low Heng Sin hengsin@avantz.com
 * _____________________________________________
 *****************************************************************************/
package org.adempiere.util;

import java.util.Properties;

import org.compiere.util.ContextProvider;

/**
 * Default {@link ContextProvider} for core.
 * @author Low Heng Sin
 */
public class ServerContextProvider implements ContextProvider {

	private final static Properties context = new ServerContextPropertiesWrapper();

	public final static ServerContextProvider INSTANCE = new ServerContextProvider();

	private ServerContextProvider() {}

	/**
	 * Get server context
	 */
	public Properties getContext() {
		return context;
	}

	/**
	 * Show url at zk desktop
	 */
	public void showURL(String url) {
		ServerContextURLHandler handler = (ServerContextURLHandler) getContext().get(ServerContextURLHandler.SERVER_CONTEXT_URL_HANDLER);
		if (handler != null)
			handler.showURL(url);
	}
}
