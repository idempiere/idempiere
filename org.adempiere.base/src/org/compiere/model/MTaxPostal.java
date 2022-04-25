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
 *	Tax Postal Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MTaxPostal.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 */
public class MTaxPostal extends X_C_TaxPostal implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2517717028191578304L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_TaxPostal_ID id
	 *	@param trxName transaction
	 */
	public MTaxPostal (Properties ctx, int C_TaxPostal_ID, String trxName)
	{
		super (ctx, C_TaxPostal_ID, trxName);
	}	//	MTaxPostal

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTaxPostal (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MTaxPostal

	/**
	 * 
	 * @param copy
	 */
	public MTaxPostal(MTaxPostal copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MTaxPostal(Properties ctx, MTaxPostal copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MTaxPostal(Properties ctx, MTaxPostal copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MTaxPostal markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MTaxPostal
