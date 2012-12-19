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
import org.restlet.representation.ObjectRepresentation;
import org.restlet.representation.Representation;
import org.restlet.resource.ResourceException;
import org.restlet.resource.ServerResource;

/**
 * Command to execute workflow ( AD_Workflow )
 * @author hengsin
 */
public class ExecuteWorkflowCommand extends ServerResource {

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
		
		int AD_Workflow_ID = (Integer) entity.get("AD_Workflow_ID");
		MRole role = MRole.get(context, Env.getAD_Role_ID(context), Env.getAD_User_ID(context), false);
		if (!role.getWorkflowAccess(AD_Workflow_ID)) {
			throw new AdempiereException("Access denied.");
		}
		
		ServerBean bean = new ServerBean();
		try
		{
			ServerContext.setCurrentInstance(context);
			return bean.workflow(context, pi, AD_Workflow_ID);
		}
		finally
		{
			ServerContext.dispose();
		}
	}
}
