/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * Tax provider model
 * @author Elaine
 *
 */
public class MTaxProvider extends X_C_TaxProvider implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 6621828279540899973L;

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MTaxProvider> s_cache
		= new ImmutableIntPOCache<Integer,MTaxProvider>(Table_Name, 5);

	/**
	 * 	Get MTaxProvider from Cache (immutable)
	 *	@param C_TaxProvider_ID id
	 *	@return MTaxProvider
	 */
	public static MTaxProvider get (int C_TaxProvider_ID)
	{
		return get(Env.getCtx(), C_TaxProvider_ID);
	}

	/**
	 * 	Get MTaxProvider from Cache (immutable)
	 *	@param ctx context
	 *	@param C_TaxProvider_ID id
	 *	@return MTaxProvider
	 */
	public static MTaxProvider get (Properties ctx, int C_TaxProvider_ID)
	{
		Integer key = Integer.valueOf(C_TaxProvider_ID);
		MTaxProvider retValue = s_cache.get(ctx, key, e -> new MTaxProvider(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MTaxProvider(ctx, C_TaxProvider_ID, (String)null);
		if (retValue.get_ID() == C_TaxProvider_ID)
		{
			s_cache.put(key, retValue, e -> new MTaxProvider(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MTaxProvider from cache
	 * @param ctx
	 * @param C_TaxProvider_ID
	 * @param trxName
	 * @return MTaxProvider
	 */
	public static MTaxProvider getCopy(Properties ctx, int C_TaxProvider_ID, String trxName)
	{
		MTaxProvider provider = get(C_TaxProvider_ID);
		if (provider != null)
			provider = new MTaxProvider(ctx, provider, trxName);
		return provider;
	}

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_TaxProvider_UU  UUID key
     * @param trxName Transaction
     */
    public MTaxProvider(Properties ctx, String C_TaxProvider_UU, String trxName) {
        super(ctx, C_TaxProvider_UU, trxName);
    }

    /**
     * @param ctx
     * @param C_TaxProvider_ID
     * @param trxName
     */
	public MTaxProvider(Properties ctx, int C_TaxProvider_ID, String trxName) 
	{
		super(ctx, C_TaxProvider_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MTaxProvider(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MTaxProvider(MTaxProvider copy)
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MTaxProvider(Properties ctx, MTaxProvider copy)
	{
		this(ctx, copy, (String)null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MTaxProvider(Properties ctx, MTaxProvider copy, String trxName)
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	@Override
	public MTaxProvider markImmutable()
	{
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * @return Tax provider Java class name
	 */
	public String getTaxProviderClass()
	{
		MTaxProviderCfg cfg = new MTaxProviderCfg(getCtx(), getC_TaxProviderCfg_ID(), get_TrxName());
		return cfg.getTaxProviderClass();
	}
	
	/**
	 * @return URL for online tax provider service
	 */
	public String getURL()
	{
		MTaxProviderCfg cfg = new MTaxProviderCfg(getCtx(), getC_TaxProviderCfg_ID(), get_TrxName());
		return cfg.getURL();
	}
}
