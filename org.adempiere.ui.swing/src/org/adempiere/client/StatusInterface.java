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

import java.net.URI;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.db.CConnection;
import org.compiere.db.SecurityPrincipal;
import org.compiere.interfaces.Status;
import org.restlet.Context;
import org.restlet.data.ChallengeResponse;
import org.restlet.data.ChallengeScheme;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;

/**
 * Status interface using restlet. Use ssl and http basic authentication.
 * @author hengsin
 *
 */
public class StatusInterface implements Status {

	private ClientResource createClientResource(URI uri) {
		Context context = getContext();
		ClientResource resource = new ClientResource(context, uri);
		resource.setChallengeResponse(createChallengeResponse());
		return resource;
	}
	
	private ChallengeResponse createChallengeResponse()
	{
		SecurityPrincipal principal = CConnection.get().getAppServerCredential();
		if (principal != null)
		{
			ChallengeResponse cr = new ChallengeResponse(ChallengeScheme.HTTP_BASIC, principal.identity, principal.secret);
			return cr;
		}
		else
		{
			return null;
		}
	}
	
	private Context getContext() {
		return Application.context;
	}
	
	@Override
	public String getDateVersion() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/version/date", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			e.printStackTrace();
			throw new AdempiereException(e);
		}
	}
	
	@Override
	public String getMainVersion() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/version/main", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getDbType() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/type", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getDbHost() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/host", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public int getDbPort() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/port", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return Integer.parseInt(response.getText());
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getDbName() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/name", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getConnectionURL() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/url", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getDbUid() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/uid", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getDbPwd() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/password", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getFwHost() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/fwhost", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return response != null ? response.getText() : "";
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public int getFwPort() {
		try {
			URI uri = new URI("https", null, CConnection.get().getAppsHost(), CConnection.get().getSSLPort(), "/server/status/database/fwport", null, null);
			ClientResource resource = createClientResource(uri);
			Representation response = resource.get();
			return Integer.parseInt(response.getText());
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}
}
