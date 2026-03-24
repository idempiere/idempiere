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
package org.compiere.model;

import java.util.Properties;

/**
 * Product's callout
 * @author Deepak Pansheriya
 * @author Logilite Technologies
 */
public class CalloutProduct extends CalloutEngine
{

	/**
	 * Set Stocked=N when  Product type set to Expense Type
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return
	 */
	public String productType (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) {
		String productType = (String)value;
		
		if(MProduct.PRODUCTTYPE_ExpenseType.equalsIgnoreCase(productType)) {
			mTab.setValue(MProduct.COLUMNNAME_IsStocked, "N");
		}
		
		return "";
	}
}
