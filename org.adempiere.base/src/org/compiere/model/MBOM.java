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
import java.util.List;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	BOM Model
 *  @author Jorg Janke
 *  @version $Id: MBOM.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MBOM extends X_M_BOM implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6311001492891936078L;

	/**
	 * 	Get BOM from Cache (immutable)
	 *	@param M_BOM_ID id
	 *	@return MBOM
	 */
	public static MBOM get (int M_BOM_ID)
	{
		return get(Env.getCtx(), M_BOM_ID);
	}
	
	/**
	 * 	Get BOM from Cache (immutable)
	 *	@param ctx context
	 *	@param M_BOM_ID id
	 *	@return MBOM
	 */
	public static MBOM get (Properties ctx, int M_BOM_ID)
	{
		Integer key = Integer.valueOf(M_BOM_ID);
		MBOM retValue = (MBOM) s_cache.get (ctx, key, e -> new MBOM(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MBOM (ctx, M_BOM_ID, (String)null);
		if (retValue.get_ID () == M_BOM_ID)
		{
			s_cache.put (key, retValue, e -> new MBOM(Env.getCtx(), e));
			return retValue.markImmutable();
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MBOM from cache
	 * @param ctx
	 * @param M_BOM_ID
	 * @param trxName
	 * @return MBOM
	 */
	public static MBOM getCopy(Properties ctx, int M_BOM_ID, String trxName)
	{
		MBOM bom = get(M_BOM_ID);
		if (bom != null)
			bom = new MBOM(ctx, bom, trxName);
		return bom;
	}
	
	/**
	 * 	Get BOMs Of Product
	 *	@param ctx context
	 *	@param M_Product_ID product
	 *	@param trxName trx
	 *	@param whereClause optional WHERE clause w/o AND
	 *	@return array of BOMs
	 */
	public static MBOM[] getOfProduct (Properties ctx, int M_Product_ID, 
		String trxName, String whereClause)
	{
		//FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
		StringBuilder where = new StringBuilder("M_Product_ID=?");
		if (whereClause != null && whereClause.length() > 0)
			where.append(" AND ").append(whereClause);
		List <MBOM> list = new Query(ctx, I_M_BOM.Table_Name, where.toString(), trxName)
		.setParameters(M_Product_ID)
		.list();
		
		MBOM[] retValue = new MBOM[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getOfProduct

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MBOM>	s_cache	
		= new ImmutableIntPOCache<Integer,MBOM>(Table_Name, 20);
	/**	Logger						*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MBOM.class);

	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_BOM_ID id
	 *	@param trxName trx
	 */
	public MBOM (Properties ctx, int M_BOM_ID, String trxName)
	{
		super (ctx, M_BOM_ID, trxName);
		if (M_BOM_ID == 0)
		{
		//	setM_Product_ID (0);
		//	setName (null);
			setBOMType (BOMTYPE_CurrentActive);	// A
			setBOMUse (BOMUSE_Master);	// A
		}
	}	//	MBOM

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MBOM (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MBOM

	/**
	 * 
	 * @param copy
	 */
	public MBOM(MBOM copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MBOM(Properties ctx, MBOM copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MBOM(Properties ctx, MBOM copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true/false
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		//	BOM Type
		if (newRecord || is_ValueChanged("BOMType"))
		{
			//	Only one Current Active
			if (getBOMType().equals(BOMTYPE_CurrentActive))
			{
				StringBuilder msgofp = new StringBuilder("BOMType='A' AND BOMUse='").append(getBOMUse()).append("' AND IsActive='Y'");
				MBOM[] boms = getOfProduct(getCtx(), getM_Product_ID(), get_TrxName(),msgofp.toString());
				if (boms.length == 0	//	only one = this 
					|| (boms.length == 1 && boms[0].getM_BOM_ID() == getM_BOM_ID()))
					;
				else
				{
					log.saveError("Error", Msg.parseTranslation(getCtx(), 
						"Can only have one Current Active BOM for Product BOM Use (" + getBOMType() + ")"));
					return false;
				}
			}
			//	Only one MTO
			else if (getBOMType().equals(BOMTYPE_Make_To_Order))
			{
				MBOM[] boms = getOfProduct(getCtx(), getM_Product_ID(), get_TrxName(), 
					"IsActive='Y'");
				if (boms.length == 0	//	only one = this 
					|| (boms.length == 1 && boms[0].getM_BOM_ID() == getM_BOM_ID()))
					;
				else
				{
					log.saveError("Error", Msg.parseTranslation(getCtx(), 
						"Can only have single Make-to-Order BOM for Product"));
					return false;
				}
			}
		}	//	BOM Type
		
		return true;
	}	//	beforeSave
	
	@Override
	public MBOM markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
}	//	MBOM
