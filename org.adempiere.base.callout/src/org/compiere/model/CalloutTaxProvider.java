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
 * Tax provider callout
 * @author Elaine
 *
 */
public class CalloutTaxProvider extends CalloutEngine
{
	public String taxProvider(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer C_TaxProviderCfg_ID = (Integer)value;
		if (C_TaxProviderCfg_ID == null || C_TaxProviderCfg_ID.intValue() == 0)
			return "";
		
		X_C_TaxProviderCfg tp = new X_C_TaxProviderCfg(ctx, C_TaxProviderCfg_ID, null);
		mTab.setValue(MTaxProvider.COLUMNNAME_Name, tp.getName());
		
		return null;
	}
}