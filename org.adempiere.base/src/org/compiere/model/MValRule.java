/**********************************************************************
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
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Persistent Validation Rule Model
 *  @author Carlos Ruiz
 *  @version $Id: MValRule.java
 */
public class MValRule extends X_AD_Val_Rule implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2475798196422214666L;

	/**
	 * 	Get Rule from Cache (immutable)
	 *	@param AD_Val_Rule_ID id
	 *	@return MValRule
	 */
	public static MValRule get (int AD_Val_Rule_ID)
	{
		return get(Env.getCtx(), AD_Val_Rule_ID);
	}
	
	/**
	 * 	Get Rule from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Val_Rule_ID id
	 *	@return MValRule
	 */
	public static MValRule get (Properties ctx, int AD_Val_Rule_ID)
	{
		return get(ctx, AD_Val_Rule_ID, (String)null);
	}
	
	/**
	 * 	Get Rule from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Val_Rule_ID id
	 *  @param trxName
	 *	@return MValRule
	 */
	public static MValRule get (Properties ctx, int AD_Val_Rule_ID, String trxName)
	{
		Integer key = Integer.valueOf(AD_Val_Rule_ID);
		MValRule retValue = s_cache.get (ctx, key, e -> new MValRule(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MValRule (ctx, AD_Val_Rule_ID, trxName);
		if (retValue.get_ID () == AD_Val_Rule_ID)
		{
			s_cache.put (key, retValue, e -> new MValRule(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MValRule from cache
	 * @param ctx
	 * @param AD_Val_Rule_ID
	 * @param trxName
	 * @return MValRule
	 */
	public static MValRule getCopy(Properties ctx, int AD_Val_Rule_ID, String trxName)
	{
		MValRule vr = get(ctx, AD_Val_Rule_ID, trxName);
		if (vr != null)
			vr = new MValRule(ctx, vr, trxName);
		return vr;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MValRule> s_cache = new ImmutableIntPOCache<Integer,MValRule>(Table_Name, 20);

	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MValRule.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Val_Rule_ID id
	 *	@param trxName transaction
	 */
	public MValRule (Properties ctx, int AD_Val_Rule_ID, String trxName)
	{
		super (ctx, AD_Val_Rule_ID, trxName);
	}	//	MValRule

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MValRule (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MValRule

	/**
	 * 
	 * @param copy
	 */
	public MValRule(MValRule copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MValRule(Properties ctx, MValRule copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MValRule(Properties ctx, MValRule copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MValRule markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MValRule[");
		sb.append (get_ID()).append ("-").append (getName()).append ("]");
		return sb.toString ();
	}	//	toString

}	//	MValRule