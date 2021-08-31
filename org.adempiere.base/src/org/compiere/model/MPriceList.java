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
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Price List Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MPriceList.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 * 
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>BF [ 2073484 ] MPriceList.getDefault is not working correctly
 */
public class MPriceList extends X_M_PriceList implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7128840936482927934L;


	/**
	 * 	Get Price List (cached) (immutable)
	 *	@param M_PriceList_ID id
	 *	@return PriceList
	 */
	public static MPriceList get (int M_PriceList_ID)
	{
		return get(M_PriceList_ID, (String)null);
	}
	
	/**
	 * 	Get Price List (cached) (immutable)
	 *	@param M_PriceList_ID id
	 *	@param trxName transaction
	 *	@return PriceList
	 */
	public static MPriceList get (int M_PriceList_ID, String trxName)
	{
		return get(Env.getCtx(), M_PriceList_ID, trxName);
	}
	
	/**
	 * 	Get Price List (cached) (immutable)
	 *	@param ctx context
	 *	@param M_PriceList_ID id
	 *	@param trxName transaction
	 *	@return PriceList
	 */
	public static MPriceList get (Properties ctx, int M_PriceList_ID, String trxName)
	{
		Integer key = Integer.valueOf(M_PriceList_ID);
		MPriceList retValue = s_cache.get(ctx, key, e -> new MPriceList(ctx, e));
		if (retValue == null)
		{
			retValue = new MPriceList (ctx, M_PriceList_ID, trxName);
			if (retValue.get_ID() == M_PriceList_ID)
			{
				s_cache.put(key, retValue, e -> new MPriceList(Env.getCtx(), e));
				return retValue;
			}
			return null;
		}
		return retValue;		
	}	//	get
	
	/**
	 * Get updateable copy of MPriceList from cache
	 * @param ctx
	 * @param M_PriceList_ID
	 * @param trxName
	 * @return MPriceList 
	 */
	public static MPriceList getCopy(Properties ctx, int M_PriceList_ID, String trxName)
	{
		MPriceList pl = get(ctx, M_PriceList_ID, trxName);
		if (pl != null)
			pl = new MPriceList(ctx, pl, trxName);
		return pl;
	}
	
	/**
	 * 	Get Default Price List for Client (cached)
	 *	@param ctx context
	 *	@param IsSOPriceList SO or PO
	 *	@return PriceList or null
	 */
	public static MPriceList getDefault (Properties ctx, boolean IsSOPriceList)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		//	Search for it in cache
		MPriceList[] it = s_cache.values().toArray(new MPriceList[0]);
		for(MPriceList retValue : it)
		{
			if (retValue.isDefault()
					&& retValue.getAD_Client_ID() == AD_Client_ID
					&& retValue.isSOPriceList() == IsSOPriceList)
			{
				return retValue;
			}
		}
		
		//	Get from DB
		final String whereClause = "AD_Client_ID=? AND IsDefault=? AND IsSOPriceList=?";
		MPriceList retValue = new Query(ctx, Table_Name, whereClause, null)
						.setParameters(AD_Client_ID, "Y", IsSOPriceList ? "Y" : "N")
						.setOnlyActiveRecords(true)
						.setOrderBy("M_PriceList_ID")
						.first();
		
		//	Return value
		if (retValue != null)
		{
			s_cache.put(retValue.get_ID(), retValue, e -> new MPriceList(Env.getCtx(), e));
		}
		return retValue;
	}	//	getDefault
	
	/**
	 * Get Default Price List for Client (cached) with given currency
	 * @param	ctx	context
	 * @param	IsSOPriceList SO or PO
	 * @param	ISOCurrency
	 * @return	PriceList or null
	 */
	public static MPriceList getDefault(Properties ctx, boolean IsSOPriceList, String ISOCurrency)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		MCurrency currency = MCurrency.get(ctx, ISOCurrency);
		// If currency is null, return the default without looking at currency
		if (currency==null) return(getDefault(ctx, IsSOPriceList));

		int M_Currency_ID = currency.get_ID();
		
		//	Search for it in cache
		MPriceList[] it = s_cache.values().toArray(new MPriceList[0]);
		for (MPriceList retValue : it)
		{
			if (retValue.isDefault()
					&& retValue.getAD_Client_ID() == AD_Client_ID
					&& retValue.isSOPriceList() == IsSOPriceList
					&& retValue.getC_Currency_ID()==M_Currency_ID 
					)
			{
				return retValue;
			}
		}
		
		//	Get from DB
		final String whereClause = "AD_Client_ID=? AND IsDefault=? AND IsSOPriceList=? AND C_Currency_ID=?";
		MPriceList retValue = new Query(ctx, Table_Name, whereClause, null)
						.setParameters(AD_Client_ID, "Y", IsSOPriceList ? "Y" : "N", M_Currency_ID)
						.setOnlyActiveRecords(true)
						.setOrderBy("M_PriceList_ID")
						.first();
		
		//	Return value
		if (retValue != null)
		{
			s_cache.put(retValue.get_ID(), retValue, e -> new MPriceList(Env.getCtx(), e));
		}
		return retValue;
	}
	
	/**
	 * 	Get Standard Currency Precision
	 *	@param ctx context 
	 *	@param M_PriceList_ID price list
	 *	@return precision
	 */
	public static int getStandardPrecision (Properties ctx, int M_PriceList_ID)
	{
		MPriceList pl = MPriceList.get(ctx, M_PriceList_ID, null);
		return pl.getStandardPrecision();
	}	//	getStandardPrecision
	
	/**
	 * 	Get Price Precision
	 *	@param ctx context 
	 *	@param M_PriceList_ID price list
	 *	@return precision
	 */
	public static int getPricePrecision (Properties ctx, int M_PriceList_ID)
	{
		MPriceList pl = MPriceList.get(ctx, M_PriceList_ID, null);
		return pl.getPricePrecision();
	}	//	getPricePrecision
	
	/** Cache of Price Lists			*/
	private static ImmutableIntPOCache<Integer,MPriceList> s_cache = new ImmutableIntPOCache<Integer,MPriceList>(Table_Name, 5, 5);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_PriceList_ID id
	 *	@param trxName transaction
	 */
	public MPriceList(Properties ctx, int M_PriceList_ID, String trxName)
	{
		super(ctx, M_PriceList_ID, trxName);
		if (M_PriceList_ID == 0)
		{
			setEnforcePriceLimit (false);
			setIsDefault (false);
			setIsSOPriceList (false);
			setIsTaxIncluded (false);
			setPricePrecision (2);	// 2
		}
	}	//	MPriceList

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPriceList (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPriceList

	/**
	 * 	Import Constructor
	 *	@param impPL import
	 */
	public MPriceList (X_I_PriceList impPL)
	{
		this (impPL.getCtx(), 0, impPL.get_TrxName());
		setClientOrg(impPL);
		setUpdatedBy(impPL.getUpdatedBy());
		//
		setName(impPL.getName());
		setDescription(impPL.getDescription());
		setC_Currency_ID(impPL.getC_Currency_ID());
		setPricePrecision(impPL.getPricePrecision());
		setIsSOPriceList(impPL.isSOPriceList());
		setIsTaxIncluded(impPL.isTaxIncluded());
		setEnforcePriceLimit(impPL.isEnforcePriceLimit());
	}	//	MPriceList

	/**
	 * 
	 * @param copy
	 */
	public MPriceList(MPriceList copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPriceList(Properties ctx, MPriceList copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPriceList(Properties ctx, MPriceList copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		if (copy.m_plv != null)
		{
			this.m_plv = new MPriceListVersion(ctx, copy.m_plv, trxName);
			this.m_plv.m_pl = this;
		}
		else
		{
			this.m_plv = null;
		}
		this.m_precision = copy.m_precision;
	}
	
	/**	Cached PLV					*/
	private MPriceListVersion	m_plv = null;
	/** Cached Precision			*/
	private Integer				m_precision = null;

	/**
	 * 	Get Price List Version
	 *	@param valid date where PLV must be valid or today if null
	 *	@return PLV
	 */
	public MPriceListVersion getPriceListVersion (Timestamp valid)
	{
		if (valid == null)
			valid = new Timestamp (System.currentTimeMillis());

		final String whereClause = "M_PriceList_ID=? AND TRUNC(ValidFrom)<=?";
		m_plv = new Query(getCtx(), I_M_PriceList_Version.Table_Name, whereClause, get_TrxName())
					.setParameters(getM_PriceList_ID(), valid)
					.setOnlyActiveRecords(true)
					.setOrderBy("ValidFrom DESC")
					.first();
		if (m_plv == null)
			if (log.isLoggable(Level.INFO)) log.info("None found M_PriceList_ID=" + getM_PriceList_ID() + " - " + valid);
		else
			if (log.isLoggable(Level.FINE)) log.fine(m_plv.toString());
		if (m_plv != null && is_Immutable())
			m_plv.markImmutable();
		return m_plv;
	}	//	getPriceListVersion

	/**
	 * 	Get Standard Currency Precision
	 *	@return precision
	 */
	public int getStandardPrecision()
	{
		if (m_precision == null)
		{
			MCurrency c = MCurrency.get(getCtx(), getC_Currency_ID());
			m_precision = Integer.valueOf(c.getStdPrecision());
		}
		return m_precision.intValue();
	}	//	getStandardPrecision
	
	@Override
	public MPriceList markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_plv != null)
			m_plv.markImmutable();
		return this;
	}

}	//	MPriceList
