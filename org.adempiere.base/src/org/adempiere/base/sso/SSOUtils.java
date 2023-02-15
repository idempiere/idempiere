/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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

package org.adempiere.base.sso;

import java.util.List;

import org.adempiere.base.Service;
import org.compiere.model.I_SSO_PrincipleConfig;
import org.compiere.model.MSSOPrincipleConfig;

/**
 * @author Logilite Technologies
 */
public class SSOUtils
{
	public static final String	ERROR_API				= "/error.html";

	public static final String	ERROR_VALIDATION		= "/error.zul";

	public static final String	SSO_MODE_OSGI			= "SSO_MODE_OSGI";
	public static final String	SSO_MODE_WEBUI			= "SSO_MODE_WEBUI";
	public static final String	SSO_MODE_MONITOR		= "SSO_MODE_MONITOR";

	public static final String	ISCHANGEROLE_REQUEST	= "ISCHANGEROLE_REQUEST";

	public static final String	EVENT_ON_AFTER_SSOLOGIN	= "onAfterSSOLogin";

	public static ISSOPrinciple getSSOPrinciple()
	{
		ISSOPrinciple principle = null;
		MSSOPrincipleConfig config = MSSOPrincipleConfig.getDefaultSSOPrinciple();
		if (config == null)
			return null;
		List<ISSOPrincipleFactory> factories = Service.locator().list(ISSOPrincipleFactory.class).getServices();
		for (ISSOPrincipleFactory factory : factories)
		{
			principle = factory.getSSOPrincipleService(config);
			if (principle != null)
				break;
		}
		return principle;
	}
	

	public static String getRedirectedURL(String redirectMode, I_SSO_PrincipleConfig config)
	{
		if (SSO_MODE_OSGI.equalsIgnoreCase(redirectMode))
			return config.getSSO_OSGIRedirectURIs();
		else if (SSO_MODE_MONITOR.equalsIgnoreCase(redirectMode))
			return config.getSSO_IDempMonitorRedirectURIs();
		return config.getSSO_ApplicationRedirectURIs();
	}
}
