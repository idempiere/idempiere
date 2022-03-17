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
package org.adempiere.base;

import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.Tax;
import org.osgi.service.component.annotations.Component;

/**
 * @author hengsin
 *
 */
@Component(immediate = true, service = {ITaxLookup.class})
public class DefaultTaxLookup implements ITaxLookup {

	/**
	 * default constructor
	 */
	public DefaultTaxLookup() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.ITaxLookup#get(java.util.Properties, int, int, java.sql.Timestamp, java.sql.Timestamp, int, int, int, int, boolean, java.lang.String)
	 */
	@Override
	public int get(Properties ctx, int M_Product_ID, int C_Charge_ID, Timestamp billDate, Timestamp shipDate,
			int AD_Org_ID, int M_Warehouse_ID, int billC_BPartner_Location_ID, int shipC_BPartner_Location_ID,
			boolean IsSOTrx, String deliveryViaRule, String trxName) {
		return Tax.get(ctx, M_Product_ID, C_Charge_ID, billDate, shipDate, AD_Org_ID, M_Warehouse_ID, billC_BPartner_Location_ID, shipC_BPartner_Location_ID, 
				IsSOTrx, deliveryViaRule, trxName);
	}

	@Override
	public int get(Properties ctx, int C_TaxCategory_ID, boolean IsSOTrx, Timestamp shipDate, int shipFromC_Location_ID,
			int shipToC_Location_ID, Timestamp billDate, int billFromC_Location_ID, int billToC_Location_ID,
			String trxName) {
		return Tax.get(ctx, C_TaxCategory_ID, IsSOTrx, shipDate, shipFromC_Location_ID, shipToC_Location_ID, billDate, billFromC_Location_ID, billToC_Location_ID, trxName);
	}

}
