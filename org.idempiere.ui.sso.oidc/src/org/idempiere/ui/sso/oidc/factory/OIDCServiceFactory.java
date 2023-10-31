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
package org.idempiere.ui.sso.oidc.factory;

import org.adempiere.base.sso.ISSOPrincipalFactory;
import org.adempiere.base.sso.ISSOPrincipalService;
import org.compiere.model.I_SSO_PrincipalConfig;
import org.osgi.service.component.annotations.Component;

import org.idempiere.ui.sso.oidc.service.OIDCPrincipalService;

/**
 * Factory for OIDC principal service
 * @author hengsin
 */
@Component(immediate = true, service = org.adempiere.base.sso.ISSOPrincipalFactory.class, property = {"service.ranking:Integer=0"})
public class OIDCServiceFactory implements ISSOPrincipalFactory {

	/** SSO provider id for OIDC */
	public static final String OIDC_PROVIDER_ID = "OIDC";

	/**
	 * Default constructor
	 */
	public OIDCServiceFactory() {
	}

	@Override
	public ISSOPrincipalService getSSOPrincipalService(I_SSO_PrincipalConfig config) {
		if (config.getSSO_Provider().equals(OIDC_PROVIDER_ID))
			return new OIDCPrincipalService(config);
		
		return null;
	}

}
