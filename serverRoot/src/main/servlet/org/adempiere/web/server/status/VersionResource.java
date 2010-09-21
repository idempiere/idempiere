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
 * Implement remote version property query support.
 * @author hengsin
 *
 */
public class VersionResource extends ServerResource {

	@Get
	public String represent() {
		String type = (String) getRequestAttributes().get("type");
		if ("date".equalsIgnoreCase(type))
			return new StatusBean().getDateVersion();
		else if ("main".equalsIgnoreCase(type))
			return new StatusBean().getMainVersion();
		else
			return "";
	}
}
