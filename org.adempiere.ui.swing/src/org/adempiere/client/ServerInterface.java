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
package org.adempiere.client;

import java.io.Serializable;
import java.net.URI;
import java.util.HashMap;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.RestletUtil;
import org.compiere.db.CConnection;
import org.compiere.db.SecurityPrincipal;
import org.compiere.interfaces.Server;
import org.compiere.process.ProcessInfo;
import org.compiere.util.EMail;
import org.restlet.Context;
import org.restlet.data.ChallengeResponse;
import org.restlet.data.ChallengeScheme;
import org.restlet.resource.ClientResource;
import org.restlet.representation.ObjectRepresentation;
import org.restlet.representation.Representation;

/**
 * Server interface using restlet. Use ssl and http basic authentication.
 * @author hengsin
 */
public class ServerInterface implements Server {

	private ClientResource createClientResource(URI uri) {
		Context context = getContext();
		ClientResource resource = new ClientResource(context, uri);
		resource.setChallengeResponse(createChallengeResponse());
		return resource;
	}

	private ChallengeResponse createChallengeResponse()
	{
		SecurityPrincipal principal = CConnection.get().getAppServerCredential();
		ChallengeResponse cr = new ChallengeResponse(ChallengeScheme.HTTP_BASIC, principal.identity, principal.secret);
		return cr;
	}

	private Context getContext() {
		return Application.context;
	}

	/* (non-Javadoc)
	 * @see org.compiere.interfaces.Server#postImmediate(java.util.Properties, int, int, int, boolean)
	 */
	@Override
	public String postImmediate(Properties ctx, int AD_Client_ID,
			int AD_Table_ID, int Record_ID, boolean force) {
		HashMap<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("context", ctx);
		map.put("AD_Table_ID", AD_Table_ID);
		map.put("Record_ID", Record_ID);
		map.put("force", force);

		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/command/postDocument", null, null);
			ClientResource resource = createClientResource(uri);
			ObjectRepresentation<HashMap<String, Serializable>> entity = new ObjectRepresentation<HashMap<String,Serializable>>(map);
			Representation response = resource.post(entity);
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	/* (non-Javadoc)
	 * @see org.compiere.interfaces.Server#process(java.util.Properties, org.compiere.process.ProcessInfo)
	 */
	@Override
	public ProcessInfo process(Properties ctx, ProcessInfo pi) {
		HashMap<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("context", ctx);
		map.put("processInfo", pi);

		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/command/executeProcess", null, null);
			ClientResource resource = createClientResource(uri);
			ObjectRepresentation<Serializable> entity = new ObjectRepresentation<Serializable>(map);
			Representation response = resource.post(entity);
			ProcessInfo responseInfo = RestletUtil.toObject(response);
			return responseInfo;
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	/* (non-Javadoc)
	 * @see org.compiere.interfaces.Server#workflow(java.util.Properties, org.compiere.process.ProcessInfo, int)
	 */
	@Override
	public ProcessInfo workflow(Properties ctx, ProcessInfo pi,
			int AD_Workflow_ID) {
		HashMap<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("context", ctx);
		map.put("AD_Workflow_ID", AD_Workflow_ID);

		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/command/executeWorkflow", null, null);
			ClientResource resource = createClientResource(uri);
			ObjectRepresentation<HashMap<String, Serializable>> entity = new ObjectRepresentation<HashMap<String,Serializable>>(map);
			Representation response = resource.post(entity);
			ProcessInfo responseInfo = RestletUtil.toObject(response);
			return responseInfo;
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	/* (non-Javadoc)
	 * @see org.compiere.interfaces.Server#sendEMail(java.util.Properties, org.compiere.util.EMail)
	 */
	@Override
	public String sendEMail(Properties ctx, EMail email) {
		HashMap<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("context", ctx);
		map.put("email", email);

		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/command/sendEmail", null, null);
			ClientResource resource = createClientResource(uri);
			ObjectRepresentation<HashMap<String, Serializable>> entity = new ObjectRepresentation<HashMap<String,Serializable>>(map);
			Representation response = resource.post(entity);
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	/* (non-Javadoc)
	 * @see org.compiere.interfaces.Server#executeTask(java.util.Properties, int)
	 */
	@Override
	public String executeTask(Properties ctx, int AD_Task_ID) {
		HashMap<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("context", ctx);
		map.put("AD_Task_ID", AD_Task_ID);

		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/command/executeTask", null, null);
			ClientResource resource = createClientResource(uri);
			ObjectRepresentation<HashMap<String, Serializable>> entity = new ObjectRepresentation<HashMap<String,Serializable>>(map);
			Representation response = resource.post(entity);
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	/* (non-Javadoc)
	 * @see org.compiere.interfaces.Server#cacheReset(java.util.Properties, java.lang.String, int)
	 */
	@Override
	public int cacheReset(Properties ctx, String tableName, int Record_ID) {
		HashMap<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("context", ctx);
		map.put("tableName", tableName);
		map.put("Record_ID", Record_ID);

		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/command/resetCache", null, null);
			ClientResource resource = createClientResource(uri);
			ObjectRepresentation<HashMap<String, Serializable>> entity = new ObjectRepresentation<HashMap<String,Serializable>>(map);
			Representation response = resource.post(entity);
			return response != null ? Integer.parseInt(response.getText()) : 0;
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	/* (non-Javadoc)
	 * @see org.compiere.interfaces.Server#dbProcess(java.util.Properties, org.compiere.process.ProcessInfo, java.lang.String)
	 */
	@Override
	public ProcessInfo dbProcess(Properties ctx, ProcessInfo processInfo,
			String procedureName) {
		HashMap<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("context", ctx);
		map.put("processInfo", processInfo);
		map.put("procedureName", procedureName);

		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/command/executeProcess", null, null);
			ClientResource resource = createClientResource(uri);
			ObjectRepresentation<HashMap<String, Serializable>> entity = new ObjectRepresentation<HashMap<String,Serializable>>(map);
			Representation response = resource.post(entity);
			ProcessInfo responseInfo = RestletUtil.toObject(response);
			return responseInfo;
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

}
