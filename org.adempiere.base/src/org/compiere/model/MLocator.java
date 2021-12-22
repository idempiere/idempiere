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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Warehouse Locator Object
 *
 *  @author 	Jorg Janke
 *  @author victor.perez@e-evolution.com
 *  @see [ 1966333 ] New Method to get the Default Locator based in Warehouse https://sourceforge.net/p/adempiere/feature-requests/429/
 *  @version 	$Id: MLocator.java,v 1.3 2006/07/30 00:58:37 jjanke Exp $
 */
public class MLocator extends X_M_Locator implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 539879105479299988L;

	/**
	 * 	Get oldest Default Locator of warehouse with locator
	 *	@param ctx context
	 *	@param M_Locator_ID locator
	 *	@return locator or null
	 */
	public static MLocator getDefault (Properties ctx, int M_Locator_ID)
	{
		String trxName = null;
		MLocator retValue = null;
		String sql = "SELECT * FROM M_Locator l "
			+ "WHERE IsActive = 'Y' AND  IsDefault='Y'"
			+ " AND EXISTS (SELECT * FROM M_Locator lx "
				+ "WHERE l.M_Warehouse_ID=lx.M_Warehouse_ID AND lx.M_Locator_ID=?) "
			+ "ORDER BY Created";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, M_Locator_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				retValue = new MLocator (ctx, rs, trxName);
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		return retValue;
	}	//	getDefault
	
	/**
	 *  FR  [ 1966333 ]
	 * 	Get oldest Default Locator of warehouse with locator
	 *  @param warehouse
	 *	@return locator or null
	 */
	public static MLocator getDefault (MWarehouse warehouse)
	{
		String trxName = null;
		MLocator retValue = null;
		String sql = "SELECT * FROM M_Locator l "
			+ "WHERE IsActive = 'Y' AND IsDefault='Y' AND l.M_Warehouse_ID=? "
			+ "ORDER BY PriorityNo";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, warehouse.getM_Warehouse_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
				retValue = new MLocator (warehouse.getCtx(), rs, trxName);
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		return retValue;
	}	//	getDefault
	
	
	 public static MLocator get (Properties ctx, int M_Warehouse_ID, String Value,
			 String X, String Y, String Z) {
		 return get (ctx, M_Warehouse_ID, Value, X, Y, Z, 0);
	 }

	 /**
	 * 	Get the Locator with the combination or create new one (when user has permission)
	 *	@param ctx Context
	 *	@param M_Warehouse_ID warehouse
	 *	@param Value value
	 *	@param X x
	 *	@param Y y
	 *	@param Z z
	 * 	@return locator (or null when no insert permission on MLocator)
	 */
	 public static MLocator get (Properties ctx, int M_Warehouse_ID, String Value,
		 String X, String Y, String Z, int M_LocatorType_ID)
	 {
		MLocator retValue = null;
		String sql = "SELECT * FROM M_Locator WHERE IsActive = 'Y' AND M_Warehouse_ID=? AND X=? AND Y=? AND Z=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, M_Warehouse_ID);
			pstmt.setString(2, X);
			pstmt.setString(3, Y);
			pstmt.setString(4, Z);
			rs = pstmt.executeQuery();
			if (rs.next())
				retValue = new MLocator (ctx, rs, null);
		}
		catch (SQLException ex)
		{
			s_log.log(Level.SEVERE, "get", ex);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		if (retValue == null)
		{
			if (MRole.getDefault().isTableAccess(MLocator.Table_ID, false)) {
				MWarehouse wh = MWarehouse.get (ctx, M_Warehouse_ID);
				retValue = new MLocator (wh, Value);
				retValue.setXYZ(X, Y, Z);
				retValue.setM_LocatorType_ID(M_LocatorType_ID);
				retValue.saveEx();
			}
		}
		return retValue;
	}	//	get

	/**
	 * 	Get Locator from Cache (immutable)
	 *	@param M_Locator_ID id
	 *	@return MLocator
	 */
	public static MLocator get (int M_Locator_ID)
	{
		return get(Env.getCtx(), M_Locator_ID);
	}
	
	/**
	 * 	Get Locator from Cache (immutable)
	 *  @param ctx context
	 *	@param M_Locator_ID id
	 *	@return MLocator
	 */
	public static MLocator get (Properties ctx, int M_Locator_ID)
	{
		return get(ctx, M_Locator_ID, (String)null);
	}
	
	/**
	 * 	Get Locator from Cache (immutable)
	 *  @param ctx context
	 *	@param M_Locator_ID id
	 *  @param trxName
	 *	@return MLocator
	 */
	public static MLocator get (Properties ctx, int M_Locator_ID, String trxName)
	{
		Integer key = Integer.valueOf(M_Locator_ID);
		MLocator retValue = s_cache.get (ctx, key, e -> new MLocator(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MLocator (ctx, M_Locator_ID, trxName);
		if (retValue.get_ID () == M_Locator_ID)
		{
			s_cache.put (key, retValue, e -> new MLocator(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**
	 * Get updateable copy of MLocator from cache
	 * @param ctx
	 * @param M_Locator_ID
	 * @param trxName
	 * @return MLocator
	 */
	public static MLocator getCopy(Properties ctx, int M_Locator_ID, String trxName)
	{
		MLocator locator = get(M_Locator_ID);
		if (locator != null)
			locator = new MLocator(ctx, locator, trxName);
		return locator;
	}
	
	/**	Cache						*/
	private final static ImmutableIntPOCache<Integer,MLocator> s_cache = new ImmutableIntPOCache<Integer,MLocator>(Table_Name, 20); 
	 
	/**	Logger						*/
	private static CLogger		s_log = CLogger.getCLogger (MLocator.class);
	
	
	/**************************************************************************
	 * 	Standard Locator Constructor
	 *	@param ctx Context
	 *	@param M_Locator_ID id
	 *	@param trxName transaction
	 */
	public MLocator (Properties ctx, int M_Locator_ID, String trxName)
	{
		super (ctx, M_Locator_ID, trxName);
		if (M_Locator_ID == 0)
		{
			setIsDefault (false);
			setPriorityNo (50);
		}
	}	//	MLocator

	/**
	 * 	New Locator Constructor with XYZ=000
	 *	@param warehouse parent
	 *	@param Value value
	 */
	public MLocator (MWarehouse warehouse, String Value)
	{
		this (warehouse.getCtx(), 0, warehouse.get_TrxName());
		setClientOrg(warehouse);
		setM_Warehouse_ID (warehouse.getM_Warehouse_ID());		//	Parent
		setValue (Value);
		setXYZ("0","0","0");
	}	//	MLocator

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLocator (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MLocator

	/**
	 * 
	 * @param copy
	 */
	public MLocator(MLocator copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MLocator(Properties ctx, MLocator copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MLocator(Properties ctx, MLocator copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 *	Get String Representation
	 * 	@return Value
	 */
	public String toString()
	{
		return getValue();
	}	//	getValue

	/**
	 * 	Set Location
	 *	@param X x
	 *	@param Y y
	 *	@param Z z
	 */
	public void setXYZ (String X, String Y, String Z)
	{
		setX (X);
		setY (Y);
		setZ (Z);
	}	//	setXYZ
	
	
	/**
	 * 	Get Warehouse Name
	 * 	@return name
	 */
	public String getWarehouseName()
	{
		MWarehouse wh = MWarehouse.get(getCtx(), getM_Warehouse_ID());
		if (wh.get_ID() == 0){
			StringBuilder msgreturn = new StringBuilder("<").append(getM_Warehouse_ID()).append(">");
			return msgreturn.toString();
		}	
		return wh.getName();
	}	//	getWarehouseName

	/**
	 * 	Can Locator Store Product
	 *	@param M_Product_ID id
	 *	@return true if can be stored
	 */
	public boolean isCanStoreProduct (int M_Product_ID)
	{
		// BF [ 1759245 ] Locator field cleared in Physical Inventory
		// CarlosRuiz - globalqss comments:
		// The algorithm to search if a product can be stored is wrong, it looks for:
		// * M_Storage to see if the product is already in the locator
		// * If the product has this locator defined as default
		// This implies that every time you create a new product you must create initial inventory zero for all locators where the product can be stored.
		// A good enhancement could be a new table to indicate when a locator is exclusive for some products, but I consider current approach not working.
		return true;
	}	//	isCanStoreProduct
	
	@Override
	public MLocator markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MLocator
