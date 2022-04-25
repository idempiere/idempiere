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
package org.adempiere.base.event.delegate;

import java.util.StringTokenizer;
import java.util.concurrent.atomic.AtomicInteger;

import org.adempiere.base.annotation.EventTopicDelegate;
import org.adempiere.base.annotation.ModelEventTopic;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.po.BeforeChange;
import org.adempiere.base.event.annotations.po.BeforeNew;
import org.compiere.model.MAddressValidation;
import org.compiere.model.MLocation;
import org.compiere.model.MSysConfig;
import org.osgi.service.event.Event;

/**
 * 
 * @author hengsin
 *
 */
@EventTopicDelegate
@ModelEventTopic(modelClass = MLocation.class)
public class AddressValidationEventDelegate extends ModelEventDelegate<MLocation> {

	/**
	 * 
	 * @param po
	 * @param event
	 */
	public AddressValidationEventDelegate(MLocation po, Event event) {
		super(po, event);
	}

	@BeforeNew
	@BeforeChange
	public void beforeCreateOrUpdate() {
		MLocation location = getModel();
		
		//for unit test checking (see org.idempiere.test.event.EventHandlerTest#testAddressValidationDelegate)
		if (getEvent().containsProperty(getClass().getName())) {
			Object value = getEvent().getProperty(getClass().getName());
			if (value instanceof AtomicInteger) {
				((AtomicInteger) value).set(1);
			}
		}
		
		String addressValidation = MSysConfig.getValue(MSysConfig.ADDRESS_VALIDATION, null, location.getAD_Client_ID());
		boolean isEnabled = false;
		if (addressValidation != null && addressValidation.trim().length() > 0 && location.getCountry() != null)
		{
			StringTokenizer st = new StringTokenizer(addressValidation, ";");
			while (st.hasMoreTokens())
			{
				String token = st.nextToken().trim();
				if (token.equals(location.getCountry().getCountryCode().trim()))
				{
					isEnabled = true;
					break;
				}
			}
		}
		
		if (!isEnabled)
			return;
		
		MAddressValidation validation = null;
		if (location.getC_AddressValidation_ID() > 0)
			validation = new MAddressValidation(location.getCtx(), location.getC_AddressValidation_ID(), location.get_TrxName());
		if (validation == null)
			validation = MAddressValidation.getDefaultAddressValidation(location.getCtx(), location.getAD_Client_ID(), location.get_TrxName());
		if (validation != null)
			location.processOnline(validation.getC_AddressValidation_ID());
	}
}
