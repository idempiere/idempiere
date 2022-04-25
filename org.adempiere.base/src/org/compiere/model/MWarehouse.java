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
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Warehouse Model
 *	
 *  @author Jorg Janke
 *  @author victor.perez@e-evolution.com
 *  see FR [ 1966337 ] New Method to get the Transit Warehouse based in ID Org https://sourceforge.net/p/adempiere/feature-requests/430/
 *  @author Teo Sarca, http://www.arhipac.ro
 *  			<li>BF [ 1874419 ] JDBC Statement not close in a finally block
 *  @version $Id: MWarehouse.java,v 1.3 2006/07/30 00:58:05 jjanke Exp $
 */
public class MWarehouse extends X_M_Warehouse implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5425515002759989733L;
	
	/**
	 * 	Get from Cache (immutable)
	 *	@param M_Warehouse_ID id
	 *	@return warehouse
	 */
	public static MWarehouse get (int M_Warehouse_ID)
	{
		return get(Env.getCtx(), M_Warehouse_ID);
	}
	
	/**
	 * 	Get from Cache (immutable)
	 *	@param ctx context
	 *	@param M_Warehouse_ID id
	 *	@return warehouse
	 */
	public static MWarehouse get (Properties ctx, int M_Warehouse_ID)
	{
		return get(ctx, M_Warehouse_ID, null);
	}
	
	/**
	 * Retrieves warehouse from cache (immutable)
	 * @param ctx				context
	 * @param M_Warehouse_ID	id of warehouse to load
	 * @param trxName			transaction name
	 * @return					warehouse
	 */
	public static MWarehouse get (Properties ctx, int M_Warehouse_ID, String trxName)
	{
		Integer key = Integer.valueOf(M_Warehouse_ID);
		MWarehouse retValue = s_cache.get(ctx, key, e -> new MWarehouse(ctx, e));
		if (retValue != null)
			return retValue;
		//
		retValue = new MWarehouse (ctx, M_Warehouse_ID, trxName);
		if (retValue.get_ID() == M_Warehouse_ID)
		{
			s_cache.put (key, retValue, e -> new MWarehouse(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * 	Get Warehouses for Org
	 *	@param ctx context
	 *	@param AD_Org_ID id
	 *	@return warehouse
	 */
	public static MWarehouse[] getForOrg (Properties ctx, int AD_Org_ID)
	{
		final String whereClause = "AD_Org_ID=?";
		List<MWarehouse> list = new Query(ctx, Table_Name, whereClause, null)
										.setParameters(AD_Org_ID)
										.setOnlyActiveRecords(true)
										.setOrderBy(COLUMNNAME_M_Warehouse_ID)
										.list();
		return list.toArray(new MWarehouse[list.size()]);
	}	//	get
	
	/**
	 *  FR [ 1966337 ] 
	 * 	Get Warehouses Transit for Org
	 *	@param ctx context
	 *	@param AD_Org_ID id
	 *	@return warehouse
	 */
	public static MWarehouse[] getInTransitForOrg (Properties ctx, int AD_Org_ID)
	{
		final String whereClause = "IsInTransit=? AND AD_Org_ID=?";
		List<MWarehouse> list = new Query(ctx, Table_Name, whereClause, null)
										.setParameters("Y", AD_Org_ID)
										.setOnlyActiveRecords(true)
										.setOrderBy(COLUMNNAME_M_Warehouse_ID)
										.list();
		return list.toArray(new MWarehouse[list.size()]);
	}	//	get
	
	/**	Cache					*/
	protected static ImmutableIntPOCache<Integer,MWarehouse> s_cache = new ImmutableIntPOCache<Integer,MWarehouse>(Table_Name, 50 );	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_Warehouse_ID id
	 *	@param trxName transaction
	 */
	public MWarehouse (Properties ctx, int M_Warehouse_ID, String trxName)
	{
		super(ctx, M_Warehouse_ID, trxName);
		if (M_Warehouse_ID == 0)
		{
			setSeparator ("*");	// *
		}
	}	//	MWarehouse

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MWarehouse (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MWarehouse

	/**
	 * 	Organization Constructor
	 *	@param org parent
	 */
	public MWarehouse (MOrg org)
	{
		this (org.getCtx(), 0, org.get_TrxName());
		setClientOrg(org);
		setValue (org.getValue());
		setName (org.getName());
		if (org.getInfo() != null)
			setC_Location_ID (org.getInfo().getC_Location_ID());
	}	//	MWarehouse

	/**
	 * 
	 * @param copy
	 */
	public MWarehouse(MWarehouse copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MWarehouse(Properties ctx, MWarehouse copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWarehouse(Properties ctx, MWarehouse copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_locators = copy.m_locators != null ? Arrays.stream(copy.m_locators).map(e -> {return new MLocator(ctx, e, trxName);}).toArray(MLocator[]::new) : null;
	}
	
	/**	Warehouse Locators				*/
	protected MLocator[]	m_locators = null;
	
	/**
	 * 	Get Locators
	 *	@param reload if true reload
	 *	@return array of locators
	 */
	public MLocator[] getLocators(boolean reload)
	{
		if (!reload && m_locators != null)
			return m_locators;
		//
		final String whereClause = "M_Warehouse_ID=?";
		List<MLocator> list = new Query(getCtx(), I_M_Locator.Table_Name, whereClause, null)
										.setParameters(getM_Warehouse_ID())
										.setOnlyActiveRecords(true)
										.setOrderBy("X,Y,Z")
										.list();
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		m_locators = list.toArray(new MLocator[list.size()]);
		return m_locators;
	}	//	getLocators
	
	/**
	 * 	Get Default Locator
	 *	@return (first) default locator
	 */
	public MLocator getDefaultLocator()
	{
		MLocator[] locators = getLocators(false);
		for (int i = 0; i < locators.length; i++)
		{
			if (locators[i].isDefault() && locators[i].isActive())
				return locators[i];
		}
		//	No Default - first one
		if (locators.length > 0)
		{
			log.warning("No default locator for " + getName());
			return locators[0];
		}
		else
		{
			String whereClause = "M_Warehouse_ID=?";
			List<MLocator> list = new Query(getCtx(), I_M_Locator.Table_Name, whereClause, null)
											.setParameters(getM_Warehouse_ID())
											.setOnlyActiveRecords(false).list();
			if (!list.isEmpty()) 
			{
				if (log.isLoggable(Level.INFO))
					log.info("All locator is inactive for " + getName());
				//Do not auto create if there are inactive locator since that could trigger unique key exception
				return null;
			}
		}	
		//	No Locator - create one
		MLocator loc = new MLocator (this, "Standard");
		loc.setIsDefault(true);
		loc.saveEx();
		if (log.isLoggable(Level.INFO)) log.info("Created default locator for " + getName());
		return loc;
	}	//	getLocators
	
	/**
	 * Before Save
	 * @param newRecord new
	 * @return success
	 */
	@Override
	protected boolean beforeSave(boolean newRecord) 
	{
		/* Disallow Negative Inventory cannot be checked if there are storage records 
		with negative onhand. */
		if (is_ValueChanged("IsDisallowNegativeInv") && isDisallowNegativeInv())
		{
			String sql = "SELECT M_Product_ID FROM M_StorageOnHand s "+
						 "WHERE s.M_Locator_ID IN (SELECT M_Locator_ID FROM M_Locator l " +
						 				"WHERE M_Warehouse_ID=? )" +
						 " GROUP BY M_Product_ID, M_Locator_ID, M_AttributeSetInstance_ID " +
						 " HAVING SUM(s.QtyOnHand) < 0 ";
			
			int prdid = DB.getSQLValueEx(get_TrxName(), sql, getM_Warehouse_ID());
			if (prdid > 0) {
				log.saveError("Error", Msg.translate(getCtx(), "NegativeOnhandExists"));
				return false;
			}
		}
		
		if (getAD_Org_ID() == 0)
		{
			int context_AD_Org_ID = Env.getAD_Org_ID(getCtx());
			if (context_AD_Org_ID != 0)
			{
				setAD_Org_ID(context_AD_Org_ID);
				log.warning("Changed Org to Context=" + context_AD_Org_ID);
			}
			else
			{
				log.saveError("Error", Msg.translate(getCtx(), "Org0NotAllowed"));
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (newRecord && success)
			insert_Accounting("M_Warehouse_Acct", "C_AcctSchema_Default", null);
		
		return success;
	}	//	afterSave

	@Override
	public MWarehouse markImmutable() 
	{
		if (this.is_Immutable())
			return this;
		
		makeImmutable();
		if (m_locators != null && m_locators.length > 0)
			Arrays.stream(m_locators).forEach(e -> e.markImmutable());
		
		return this;
	}


}	//	MWarehouse
