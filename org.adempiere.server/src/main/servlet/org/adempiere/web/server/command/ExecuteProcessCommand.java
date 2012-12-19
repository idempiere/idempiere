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
package org.adempiere.web.server.command;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.RestletUtil;
import org.adempiere.util.ServerContext;
import org.compiere.interfaces.impl.ServerBean;
import org.compiere.model.MRole;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.restlet.resource.ResourceException;
import org.restlet.resource.ServerResource;
import org.restlet.representation.ObjectRepresentation;
import org.restlet.representation.Representation;

/**
 * Command to execute java or db process ( AD_Process )
 * @author hengsin
 *
 */
public class ExecuteProcessCommand extends ServerResource {

	@Override
	protected Representation post(Representation entity)
			throws ResourceException {
		try {
			HashMap<String, Serializable> map = RestletUtil.toObject(entity);
			return new ObjectRepresentation<Serializable>(accept(map));
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public boolean isNegotiated() {
		return false;
	}

	private ProcessInfo accept(HashMap<String, Serializable> entity) {
		Properties context = (Properties) entity.get("context");
		ProcessInfo pi = (ProcessInfo) entity.get("processInfo");
		String procedureName = (String) entity.get("procedureName");
		
		MRole role = MRole.get(context, Env.getAD_Role_ID(context), Env.getAD_User_ID(context), false);
		if (!role.getProcessAccess(pi.getAD_Process_ID())) {
			throw new AdempiereException("Access denied.");
		}
		
		ServerBean bean = new ServerBean();
		try
		{
			ServerContext.setCurrentInstance(context);
			if (procedureName != null && procedureName.trim().length() > 0)
				return bean.dbProcess(context, pi, procedureName);
			else
				return bean.process(context, pi);
		}
		finally
		{
			ServerContext.dispose();
		}		
	}

}
