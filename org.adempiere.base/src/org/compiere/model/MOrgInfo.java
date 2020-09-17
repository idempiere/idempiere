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
 *	Organization Info Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MOrgInfo.java,v 1.3 2006/07/30 00:58:37 jjanke Exp $
 *  
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>BF [ 2107083 ] Caching of MOrgInfo issue
 */
public class MOrgInfo extends X_AD_OrgInfo implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6257741576762100779L;

	/**
	 *  Get MOrgInfo from cache (immutable)
	 *	@param AD_Org_ID id
	 *	@return Org Info
	 */
	public static MOrgInfo get (Properties ctx, int AD_Org_ID)
	{
		return get(ctx, AD_Org_ID, (String)null);
	}	//	get

	/**
	 * 	Get MOrgInfo from cache (immutable)
	 *	@param AD_Org_ID id
	 *  @param trxName
	 *	@return Org Info
	 */
	public static MOrgInfo get (int AD_Org_ID, String trxName)
	{
		return get(Env.getCtx(), AD_Org_ID, trxName);
	}
	
	/**
	 * 	Get MOrgInfo from cache (immutable)
	 *	@param AD_Org_ID id
	 *	@return Org Info
	 */
	public static MOrgInfo get (int AD_Org_ID)
	{
		return get(AD_Org_ID, (String)null);
	}
	
	/**
	 * 	Get MOrgInfo from cache (immutable)
	 *  @param ctx context
	 *	@param AD_Org_ID id
	 *  @param trxName
	 *	@return Org Info
	 */
	public static MOrgInfo get (Properties ctx, int AD_Org_ID, String trxName)
	{
		MOrgInfo retValue = s_cache.get(ctx, AD_Org_ID, e -> new MOrgInfo(ctx, e));
		if (retValue != null)
			return retValue;
		
		retValue = new Query(Env.getCtx(), Table_Name, "AD_Org_ID=?", trxName)
						.setParameters(AD_Org_ID)
						.firstOnly();
		if (retValue != null)
		{
			s_cache.put(AD_Org_ID, retValue, e -> new MOrgInfo(Env.getCtx(), e));
			return retValue;

		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MOrgInfo from cache
	 * @param ctx
	 * @param AD_Org_ID
	 * @param trxName
	 * @return MOrgInfo
	 */
	public static MOrgInfo getCopy(Properties ctx, int AD_Org_ID, String trxName)
	{
		MOrgInfo oi = get(ctx, AD_Org_ID, trxName);
		if (oi != null)
			oi = new MOrgInfo(ctx, oi, trxName);
		return oi;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MOrgInfo>	s_cache	= new ImmutableIntPOCache<Integer, MOrgInfo>(Table_Name, 50);

	
	/**************************************************************************
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MOrgInfo (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MOrgInfo

	/**
	 * 	Organization constructor
	 *	@param org org
	 */
	public MOrgInfo (MOrg org)
	{
		super(org.getCtx(), 0, org.get_TrxName());
		setClientOrg(org);
		setDUNS ("?");
		setTaxID ("?");
	}	//	MOrgInfo
	
	/**
	 * 
	 * @param copy
	 */
	public MOrgInfo(MOrgInfo copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MOrgInfo(Properties ctx, MOrgInfo copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MOrgInfo(Properties ctx, MOrgInfo copy, String trxName) 
	{
		super(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MOrgInfo markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
