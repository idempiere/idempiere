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

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Tax provider model
 * @author Elaine
 *
 */
public class MTaxProvider extends X_C_TaxProvider 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6621828279540899973L;

	public MTaxProvider(Properties ctx, int C_TaxProvider_ID, String trxName) 
	{
		super(ctx, C_TaxProvider_ID, trxName);
	}
	
	public MTaxProvider(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public String getTaxProviderClass()
	{
		return getC_TaxProviderCfg().getTaxProviderClass();
	}
	
	public String getURL()
	{
		return getC_TaxProviderCfg().getURL();
	}
}
