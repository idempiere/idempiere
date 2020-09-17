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
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Reporting Hierarchy Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MHierarchy.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MHierarchy extends X_PA_Hierarchy implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7862096742442159952L;

	/**
	 * 	Get MHierarchy from Cache (immutable)
	 *	@param PA_Hierarchy_ID id
	 *	@return MHierarchy
	 */
	public static MHierarchy get (int PA_Hierarchy_ID)
	{
		return get(Env.getCtx(), PA_Hierarchy_ID);
	}
	
	/**
	 * 	Get MHierarchy (Immutable) from Cache
	 *  @param ctx context
	 *	@param PA_Hierarchy_ID id
	 *	@return MHierarchy
	 */
	public static MHierarchy get (Properties ctx, int PA_Hierarchy_ID)
	{
		Integer key = Integer.valueOf(PA_Hierarchy_ID);
		MHierarchy retValue = (MHierarchy)s_cache.get (ctx, key, e -> new MHierarchy(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MHierarchy (ctx, PA_Hierarchy_ID, (String)null);
		if (retValue.get_ID () == PA_Hierarchy_ID)
		{
			s_cache.put (key, retValue, e -> new MHierarchy(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer, MHierarchy> s_cache 
		= new ImmutableIntPOCache<Integer, MHierarchy> (Table_Name, 20);
	
	/**
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param PA_Hierarchy_ID id
	 *	@param trxName trx
	 */
	public MHierarchy (Properties ctx, int PA_Hierarchy_ID, String trxName)
	{
		super (ctx, PA_Hierarchy_ID, trxName);
	}	//	MHierarchy

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MHierarchy (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MHierarchy
	
	/**
	 * 
	 * @param copy
	 */
	public MHierarchy(MHierarchy copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MHierarchy(Properties ctx, MHierarchy copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MHierarchy(Properties ctx, MHierarchy copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Get AD_Tree_ID based on tree type
	 *	@param TreeType Tree Type
	 *	@return id or 0
	 */
	public int getAD_Tree_ID (String TreeType)
	{
		if (MTree.TREETYPE_Activity.equals(TreeType))
			return getAD_Tree_Activity_ID();
		if (MTree.TREETYPE_BPartner.equals(TreeType))
			return getAD_Tree_BPartner_ID();
		if (MTree.TREETYPE_Campaign.equals(TreeType))
			return getAD_Tree_Campaign_ID();
		if (MTree.TREETYPE_ElementValue.equals(TreeType))
			return getAD_Tree_Account_ID();
		if (MTree.TREETYPE_Organization.equals(TreeType))
			return getAD_Tree_Org_ID();
		if (MTree.TREETYPE_Product.equals(TreeType))
			return getAD_Tree_Product_ID();
		if (MTree.TREETYPE_Project.equals(TreeType))
			return getAD_Tree_Project_ID();
		if (MTree.TREETYPE_SalesRegion.equals(TreeType))
			return getAD_Tree_SalesRegion_ID();
		//
		log.warning("Not supported: " + TreeType);
		return 0;
	}	//	getAD_Tree_ID
	
	@Override
	public MHierarchy markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MHierarchy
