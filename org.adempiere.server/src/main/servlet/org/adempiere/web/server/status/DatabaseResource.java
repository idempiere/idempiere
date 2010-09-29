/******************************************************************************
 * Copyright (C) 2010 Low Heng Sin  All Rights Reserved.                      *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.web.server.status;

import org.compiere.interfaces.impl.StatusBean;
import org.restlet.resource.Get;
import org.restlet.resource.ServerResource;

/**
 * Implement support for remote database connection property query.
 * @author hengsin
 *
 */
public class DatabaseResource extends ServerResource {

	@Get
	public String represent() {
		StatusBean status = new StatusBean(); 
		String property = (String) getRequestAttributes().get("property");
		String value = ""; 
		if ("type".equalsIgnoreCase(property))
			value = status.getDbType();
		else if ("host".equals(property))
			value = status.getDbHost();
		else if ("port".equals(property))
			value = Integer.toString(status.getDbPort());
		else if ("name".equals(property))
			value = status.getDbName();
		else if ("url".equals(property))
			value = status.getConnectionURL();
		else if ("uid".equals(property))
			value = status.getDbUid();
		else if ("password".equals(property))
			value = status.getDbPwd();
		else if ("fwhost".equals(property))
			value = status.getFwHost();
		else if ("fwport".equals(property))
			value = Integer.toString(status.getFwPort());
		
		return value != null ? value : "";
	}
	
}
