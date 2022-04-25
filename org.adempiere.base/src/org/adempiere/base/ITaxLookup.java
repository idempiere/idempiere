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

/**
 * Interface to lookup C_Tax record id
 * @author hengsin
 *
 */
public interface ITaxLookup {
	
	/**
	 * Find C_Tax_ID by Product/Charge + Warehouse Location + BPartner Location + DeliveryViaRule
	 * @param ctx
	 * @param M_Product_ID
	 * @param C_Charge_ID
	 * @param billDate Billing Date
	 * @param shipDate Shipment Date
	 * @param AD_Org_ID
	 * @param M_Warehouse_ID
	 * @param billC_BPartner_Location_ID Bill to location
	 * @param shipC_BPartner_Location_ID Ship to location
	 * @param IsSOTrx
	 * @param deliveryViaRule Order/Invoice's Delivery Via Rule
	 * @param trxName
	 * @return C_Tax_ID
	 */
	public int get (Properties ctx, int M_Product_ID, int C_Charge_ID,
			Timestamp billDate, Timestamp shipDate,
			int AD_Org_ID, int M_Warehouse_ID,
			int billC_BPartner_Location_ID, int shipC_BPartner_Location_ID,
			boolean IsSOTrx, String deliveryViaRule, String trxName);
	
	/**
	 * Find C_Tax_ID
	 * @param ctx
	 * @param C_TaxCategory_ID
	 * @param IsSOTrx
	 * @param shipDate Shipment Date
	 * @param shipFromC_Location_ID Shipping from (not use in default lookup implementation)
	 * @param shipToC_Location_ID Shipping to (not use in default lookup implementation)
	 * @param billDate Billing Date
	 * @param billFromC_Location_ID Billing from (Tax Location from)
	 * @param billToC_Location_ID Billing to (Tax Location to)
	 * @param deliveryRule Order/Invoice's Delivery Via Rule
	 * @param trxName
	 * @return C_Tax_ID
	 */
	public int get (Properties ctx,
			int C_TaxCategory_ID, boolean IsSOTrx,
			Timestamp shipDate, int shipFromC_Location_ID, int shipToC_Location_ID,
			Timestamp billDate, int billFromC_Location_ID, int billToC_Location_ID, String trxName);
}
