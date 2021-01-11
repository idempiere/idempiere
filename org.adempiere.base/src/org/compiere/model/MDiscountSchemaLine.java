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

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;


/**
 *	Discount Schema Line (Price List) Model 
 *	
 *  @author Jorg Janke
 *  @version $Id: MDiscountSchemaLine.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MDiscountSchemaLine extends X_M_DiscountSchemaLine implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5145958821951855437L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_DiscountSchemaLine_ID id
	 *	@param trxName transaction
	 */
	public MDiscountSchemaLine (Properties ctx, int M_DiscountSchemaLine_ID, String trxName)
	{
		super (ctx, M_DiscountSchemaLine_ID, trxName);
	}	//	MDiscountSchemaLine

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDiscountSchemaLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDiscountSchemaLine

	/**
	 * 
	 * @param copy
	 */
	public MDiscountSchemaLine(MDiscountSchemaLine copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MDiscountSchemaLine(Properties ctx, MDiscountSchemaLine copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MDiscountSchemaLine(Properties ctx, MDiscountSchemaLine copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	@Override
	public MDiscountSchemaLine markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

  /**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (getC_BPartner_ID() == 0)
			setIsIgnoreIsCurrentVendor(false);

		return true;
	}	//	beforeSave
	
}	//	MDiscountSchemaLine
