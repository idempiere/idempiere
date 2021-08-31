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
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CCache;

/**
 * Multi-factor Authentication Method
 */
public class MMFAMethod extends X_MFA_Method {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7954271872310037840L;

	/**
	 * Read/Create empty MFA Method
	 *
	 * @param ctx              context
	 * @param MFA_Method_ID ID
	 * @param trxName          transaction
	 */
	public MMFAMethod(Properties ctx, int MFA_Method_ID, String trxName) {
		super(ctx, MFA_Method_ID, trxName);
	} // MMFAMethod

	/**
	 * Read MFA Method from current row in ResultSet
	 *
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MMFAMethod(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MMFAMethod

	/**
	 * 
	 * @return {@link IMFAMechanism}
	 */
	public IMFAMechanism getMFAMechanism() {
		ServiceQuery query = new ServiceQuery();
		String method = getMethod();
		if (method == null)
			throw new AdempiereException("No method");
		query.put("method", method);
		IMFAMechanism mechanism = getMFAMechanismService(query);			
		if (mechanism == null)
			throw new AdempiereException("No MFA mechanism provider found");
		return mechanism;
	}

	private static CCache<ServiceQuery, IServiceReferenceHolder<IMFAMechanism>> s_MFAMechanismReference = new CCache<>(null, "IMFAMechanism", 3, false);
	
	/**
	 * 
	 * @param query
	 * @return {@link IMFAMechanism}
	 */
	public static IMFAMechanism getMFAMechanismService(ServiceQuery query) {
		IMFAMechanism mechanism = null;
		IServiceReferenceHolder<IMFAMechanism> cache = s_MFAMechanismReference.get(query);
		if (cache != null) {
			mechanism = cache.getService();
			if (mechanism != null)
				return mechanism;
			else
				s_MFAMechanismReference.remove(query);
		}
		IServiceReferenceHolder<IMFAMechanism> serviceReference = Service.locator().locate(IMFAMechanism.class, query).getServiceReference();
		if (serviceReference != null) {
			mechanism = serviceReference.getService();
			if (mechanism != null)
				s_MFAMechanismReference.put(query, serviceReference);
		}
		return mechanism;
	}
	
} // MMFAMethod
