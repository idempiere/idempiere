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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.Msg;

/**
*
* @author Carlos Ruiz - globalqss - bxservice
*
*/
public class MPOSPayment extends X_C_POSPayment
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4889347016616915128L;

	/**	Logger	*/
	protected static CLogger s_log = CLogger.getCLogger (MPOSPayment.class);
	
	/**************************************************************************
	 *  Default Constructor
	 *  @param ctx context
	 *  @param  C_POSPayment_ID  order line to load
	 *  @param trxName trx name
	 */
	public MPOSPayment (Properties ctx, int C_POSPayment_ID, String trxName)
	{
		super (ctx, C_POSPayment_ID, trxName);
	}	//	MPOSPayment
	
	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 *  @param trxName transaction
	 */
	public MPOSPayment (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPOSPayment

	/**************************************************************************
	 * 	Before Save
	 *	@param newRecord
	 *	@return true if it can be saved
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		MOrder parent = new MOrder(getCtx(), getC_Order_ID(), get_TrxName());
		if (newRecord && parent.isProcessed()) {
			log.saveError("ParentComplete", Msg.translate(getCtx(), "C_Order_ID"));
			return false;
		}
		return true;
	}	//	beforeSave

}	//	MPOSPayment
