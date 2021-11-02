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
package org.adempiere.util;

/**
 * 
 * @author hengsin
 *
 */
public interface IReservationTracerFactory {

	/**
	 * 
	 * @param C_DocType_ID
	 * @param documentNo
	 * @param lineNo
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param M_Warehouse_ID
	 * @param M_Product_ID
	 * @param M_AttributeSetInstance_ID
	 * @param IsSOTrx
	 * @param trxName
	 * @return {@link IReservationTracer}
	 */
	public IReservationTracer newTracer(int C_DocType_ID, String documentNo, int lineNo, 
			int AD_Table_ID, int Record_ID, int M_Warehouse_ID,  int M_Product_ID, int M_AttributeSetInstance_ID, 
			boolean IsSOTrx, String trxName);
}
