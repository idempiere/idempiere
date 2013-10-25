/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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
package org.adempiere.base.event;

import java.util.StringTokenizer;

import org.compiere.model.I_C_Location;
import org.compiere.model.MAddressValidation;
import org.compiere.model.MLocation;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.osgi.service.event.Event;

/**
 * Address validation event handler
 * @author Elaine
 *
 */
public class AddressValidationEventHandler extends AbstractEventHandler {

	@Override
	protected void doHandleEvent(Event event) {
		String topic = event.getTopic();
		if (topic.equals(IEventTopics.PO_BEFORE_NEW) || topic.equals(IEventTopics.PO_BEFORE_CHANGE)) 
		{
			PO po = getPO(event);
			if (po.get_TableName().equals(I_C_Location.Table_Name))
			{
				MLocation location = (MLocation) po;
				
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
	}

	@Override
	protected void initialize() {
		registerTableEvent(IEventTopics.PO_BEFORE_NEW, I_C_Location.Table_Name);
		registerTableEvent(IEventTopics.PO_BEFORE_CHANGE, I_C_Location.Table_Name);
	}

}