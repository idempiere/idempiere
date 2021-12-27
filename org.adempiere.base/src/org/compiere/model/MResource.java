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

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;


/**
 *	Resource Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MResource.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 * 
 * @author Teo Sarca, www.arhipac.ro
 * 				<li>FR [ 2051056 ] MResource[Type] should be cached
 * 				<li>BF [ 2227901 ] MRP (Calculate Material Plan) fails if resource is empty
 * 				<li>BF [ 2824795 ] Deleting Resource product should be forbidden
 * 					https://sourceforge.net/p/adempiere/bugs/1988/
 */
public class MResource extends X_S_Resource implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6893347336885257619L;
	/** Cache */
	private static ImmutableIntPOCache<Integer, MResource> s_cache = new ImmutableIntPOCache<Integer, MResource>(Table_Name, 20);
	
	/**
	 * Get from Cache (immutable)
	 * @param S_Resource_ID
	 * @return MResource
	 */
	public static MResource get(int S_Resource_ID)
	{
		return get(Env.getCtx(), S_Resource_ID);
	}
	
	/**
	 * Get from Cache (immutable)
	 * @param ctx
	 * @param S_Resource_ID
	 * @return MResource
	 */
	public static MResource get(Properties ctx, int S_Resource_ID)
	{
		if (S_Resource_ID <= 0)
			return null;
		MResource r = s_cache.get(ctx, S_Resource_ID, e -> new MResource(ctx, e));
		if (r == null) {
			r = new MResource(ctx, S_Resource_ID, (String)null);
			if (r.get_ID() == S_Resource_ID) {
				s_cache.put(S_Resource_ID, r, e -> new MResource(Env.getCtx(), e));
				return r;
			}
			return null;
		}
		return r;
	}

	/**
	 * Get updateable copy of MResource from cache
	 * @param ctx
	 * @param S_Resource_ID
	 * @param trxName
	 * @return MResource 
	 */
	public static MResource getCopy(Properties ctx, int S_Resource_ID, String trxName) 
	{
		MResource rs = get(S_Resource_ID);
		if (rs != null)
			rs = new MResource(ctx, rs, trxName);
		return rs;
	}
	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param S_Resource_ID id
	 */
	public MResource (Properties ctx, int S_Resource_ID, String trxName)
	{
		super (ctx, S_Resource_ID, trxName);
	}	//	MResource

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MResource (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MResource
	
	/**
	 * 
	 * @param copy
	 */
	public MResource(MResource copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MResource(Properties ctx, MResource copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MResource(Properties ctx, MResource copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_resourceType = copy.m_resourceType != null ? new MResourceType(ctx, copy.m_resourceType, trxName) : null;
		this.m_product = copy.m_product != null ? new MProduct(ctx, copy.m_product, trxName) : null;
	}
	
	/** Cached Resource Type	*/
	private MResourceType	m_resourceType = null;
	/** Cached Product			*/
	private MProduct		m_product = null;
	
	
	/**
	 * 	Get cached Resource Type
	 *	@return Resource Type
	 */
	public MResourceType getResourceType()
	{
		if (m_resourceType == null && getS_ResourceType_ID() != 0) {
			if (is_Immutable())
				m_resourceType = MResourceType.get(getCtx(), getS_ResourceType_ID());
			else
				m_resourceType = MResourceType.getCopy(getCtx(), getS_ResourceType_ID(), get_TrxName());
		}
		return m_resourceType;
	}	//	getResourceType
	
	/**
	 * 	Get Product (use cache)
	 *	@return product
	 */
	public MProduct getProduct()
	{
		if (m_product == null)
		{
			m_product = MProduct.forS_Resource_ID(getCtx(), getS_Resource_ID(), get_TrxName());
			if (!is_Immutable() && m_product != null)
				m_product = new MProduct(getCtx(), m_product, get_TrxName());
		}
		else if (!is_Immutable())
		{
			m_product.set_TrxName(get_TrxName());
		}
		return m_product;
	}	//	getProduct
	
	public int getC_UOM_ID()
	{
		return getProduct().getC_UOM_ID();
	}
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (newRecord)
		{
			if (getValue() == null || getValue().length() == 0)
				setValue(getName());
			m_product = new MProduct(this, getResourceType());
			m_product.saveEx(get_TrxName());
		}
		//
		// Validate Manufacturing Resource
		if (isManufacturingResource()
				&& MANUFACTURINGRESOURCETYPE_Plant.equals(getManufacturingResourceType())
				&& getPlanningHorizon() <= 0)
		{
			throw new AdempiereException("@"+COLUMNNAME_PlanningHorizon+"@ <= @0@ !");
		}
		return true;
	}	//	beforeSave

	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
			
		MProduct prod = getProduct();
		if (prod.setResource(this))
			prod.saveEx(get_TrxName());
		
		return success;
	}	//	afterSave
	
	@Override
	protected boolean beforeDelete()
	{
		// Delete product
		MProduct product = getProduct();
		if (product != null && product.getM_Product_ID() > 0)
		{
			product.setS_Resource_ID(0); // unlink resource
			product.deleteEx(true);
		}
		return true;
	}

	@Override
	public MResource markImmutable() 
	{
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_product != null)
			m_product.markImmutable();
		if (m_resourceType != null)
			m_resourceType.markImmutable();
		return this;
	}

	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MResource[")
	        .append(get_ID())
	        .append(", Value=").append(getValue())
	        .append(", Name=").append(getName())
	        .append("]");
	      return sb.toString();
	}
	
}	//	MResource
