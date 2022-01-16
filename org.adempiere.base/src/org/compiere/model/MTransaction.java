/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * 	Material Transaction Model
 *
 *	@author Jorg Janke
 *	@version $Id: MTransaction.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MTransaction extends X_M_Transaction
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3411351000865493212L;


	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_Transaction_ID id
	 *	@param trxName transaction
	 */
	public MTransaction (Properties ctx, int M_Transaction_ID, String trxName)
	{
		this (ctx, M_Transaction_ID, trxName, (String[]) null);
	}	//	MTransaction

	public MTransaction(Properties ctx, int M_Transaction_ID, String trxName, String... virtualColumns) {
		super(ctx, M_Transaction_ID, trxName, virtualColumns);
		if (M_Transaction_ID == 0)
		{
			setMovementDate (new Timestamp(System.currentTimeMillis()));
			setMovementQty (Env.ZERO);
		}
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTransaction (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MTransaction

	/**
	 * 	Detail Constructor
	 *	@param ctx context
	 *	@param AD_Org_ID org
	 * 	@param MovementType movement type
	 * 	@param M_Locator_ID locator
	 * 	@param M_Product_ID product
	 * 	@param M_AttributeSetInstance_ID attribute
	 * 	@param MovementQty qty
	 * 	@param MovementDate optional date
	 *	@param trxName transaction
	 */
	public MTransaction (Properties ctx, int AD_Org_ID, 
		String MovementType, 
		int M_Locator_ID, int M_Product_ID, int M_AttributeSetInstance_ID, 
		BigDecimal MovementQty, Timestamp MovementDate, String trxName)
	{
		super(ctx, 0, trxName);
		setAD_Org_ID(AD_Org_ID);
		setMovementType (MovementType);
		if (M_Locator_ID == 0)
			throw new IllegalArgumentException("No Locator");
		setM_Locator_ID (M_Locator_ID);
		if (M_Product_ID == 0)
			throw new IllegalArgumentException("No Product");
		setM_Product_ID (M_Product_ID);
		setM_AttributeSetInstance_ID (M_AttributeSetInstance_ID);
		//
		if (MovementQty != null)		//	Can be 0
			setMovementQty (MovementQty);
		if (MovementDate == null)
			setMovementDate (new Timestamp(System.currentTimeMillis()));
		else
			setMovementDate(MovementDate);
	}	//	MTransaction

	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MTransaction[");
		sb.append(get_ID()).append(",").append(getMovementType())
			.append(",Qty=").append(getMovementQty())
			.append(",M_Product_ID=").append(getM_Product_ID())
			.append(",ASI=").append(getM_AttributeSetInstance_ID())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
}	//	MTransaction
