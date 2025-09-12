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
 * - Elaine Tan                         							   *
 **********************************************************************/
package org.compiere.model;

import java.math.BigDecimal;

/**
 * Cost Info Interface
 */
public interface ICostInfo {
	/**
	 * Get Accumulated Amt.
	 * @return Total Amount
	 */
	public BigDecimal getCumulatedAmt();
	
	/**
	 * Get Accumulated Qty.
	 * @return Total Quantity
	 */
	public BigDecimal getCumulatedQty();
	
	/**
	 * Get Current Cost Price.
	 * @return The currently used cost price
	 */
	public BigDecimal getCurrentCostPrice();
	
	/**
	 * Get Current Quantity.
	 * @return Current Quantity
	 */
	public BigDecimal getCurrentQty();
}
