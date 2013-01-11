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
package org.compiere.model;

import java.util.Properties;

/**
 * 
 * @author Elaine
 *
 */
public class CalloutShippingProcessor extends CalloutEngine
{
	public String shippingProcessor(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer X_ShippingProcessor_ID = (Integer)value;
		if (X_ShippingProcessor_ID == null || X_ShippingProcessor_ID.intValue() == 0)
			return "";
		
		X_X_ShippingProcessor sp = new X_X_ShippingProcessor(ctx, X_ShippingProcessor_ID, null);
		mTab.setValue(MShippingProcessor.COLUMNNAME_Name, sp.getName());
		
		return null;
	}
}