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
 * - Carlos Ruiz                                                       *
 **********************************************************************/

package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

public class MFreight extends X_M_Freight {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1280041173155194185L;

	/**
     * Default constructor 
     * 
     * @param ctx           Context
     * @param M_Freight_ID  If set to 0 a new category is created.
     * @param trxName       Name of database transaction 
     */
	public MFreight(Properties ctx, int M_Freight_ID, String trxName) {
		super(ctx, M_Freight_ID, trxName);
	}

    /**
     * Constructor using a resultset.
     * 
     * @param ctx           Context
     * @param rs            ResultSet
     * @param trxName       Name of database transaction 
     */
	public MFreight(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Get a freight record based on the parameters
	 * Shipper, Freight Category are used as filters
	 * DateOrdered is used to get the most recent record that is valid for that date
	 * MaxDimension is used to get records that are valid for such dimensions
	 * Country/Region From/To are used to get the records, first valid is the more detailed defined
	 *
	 * @param ctx                 Context
	 * @param shipperId           Shipper
	 * @param freightCategoryId   Freight Category
	 * @param dateOrdered         Date from the Order
	 * @param weight              Weight of the order
	 * @param maxProductDimension Max Product Dimension from all products in the order
	 * @param countryFrom         Country of origin
	 * @param countryTo           Destination country
	 * @param regionFrom          Region of origin
	 * @param regionTo            Destination region
	 * @param trxName             Transaction Name
	 * @return                    a freight record or null if not found
	 */
	public static MFreight get(Properties ctx, int shipperId, int freightCategoryId, Timestamp dateOrdered, BigDecimal weight,
			BigDecimal maxProductDimension, int countryFrom, int countryTo, int regionFrom, int regionTo, String trxName) {
		String whereClause = "M_Shipper_ID = ?" +
			    " AND M_FreightCategory_ID = ?" + 
				" AND ValidFrom <= ?" + 
				" AND (MaxDimension IS NULL OR MaxDimension = 0 OR MaxDimension >= ?)" + 
				" AND (C_Country_ID IS NULL OR C_Country_ID = ?)" + 
				" AND (To_Country_ID IS NULL OR To_Country_ID = ?)" + 
				" AND (C_Region_ID IS NULL OR C_Region_ID = ?)" + 
				" AND (To_Region_ID IS NULL OR To_Region_ID = ?)" + 
				" AND (MaxWeight IS NULL OR MaxWeight = 0 OR MaxWeight >= ?)";
		String orderBy = "ValidFrom DESC, MaxWeight, C_Country_ID, To_Country_ID, C_Region_ID, To_Region_ID";
		MFreight freight = new Query(ctx, Table_Name, whereClause, trxName)
				.setOnlyActiveRecords(true)
				.setOrderBy(orderBy)
				.setParameters(shipperId, freightCategoryId, dateOrdered, maxProductDimension, countryFrom, countryTo, regionFrom, regionTo, weight)
				.first();
		return freight;
	}

}
