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
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	GL Category
 *	
 *  @author Jorg Janke
 *  @version $Id: MGLCategory.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MGLCategory extends X_GL_Category implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7294511214194057235L;

	/**
	 * 	Get MGLCategory from Cache (immutable)
	 *	@param GL_Category_ID id
	 *	@return MGLCategory
	 */
	public static MGLCategory get (int GL_Category_ID)
	{
		return get(Env.getCtx(), GL_Category_ID);
	}
	
	/**
	 * 	Get MGLCategory from Cache (immutable)
	 *  @param ctx context
	 *	@param GL_Category_ID id
	 *	@return immutable instance of MGLCategory
	 */
	public static MGLCategory get (Properties ctx, int GL_Category_ID)
	{
		Integer key = Integer.valueOf(GL_Category_ID);
		MGLCategory retValue = s_cache.get (ctx, key, e -> new MGLCategory(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MGLCategory (ctx, GL_Category_ID, (String)null);
		if (retValue.get_ID () == GL_Category_ID)
		{
			s_cache.put (key, retValue, e -> new MGLCategory(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * 	Get Default Category
	 *	@param ctx context
	 *	@param CategoryType optional CategoryType (ignored, if not exists)
	 *	@return GL Category or null
	 */
	public static MGLCategory getDefault (Properties ctx, String CategoryType)
	{
		MGLCategory retValue = null;
		String sql = "SELECT * FROM GL_Category "
			+ "WHERE AD_Client_ID=? AND IsDefault='Y'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, Env.getAD_Client_ID(ctx));
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MGLCategory temp = new MGLCategory (ctx, rs, null);
				if (CategoryType != null && CategoryType.equals(temp.getCategoryType()))
				{
					retValue = temp;
					break;
				}
				if (retValue == null)
					retValue = temp;
			}
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		return retValue;
	}	//	getDefault

	/**
	 * 	Get Default System Category
	 *	@param ctx context
	 *	@return GL Category
	 */
	public static MGLCategory getDefaultSystem (Properties ctx)
	{
		MGLCategory retValue = getDefault(ctx, CATEGORYTYPE_SystemGenerated);
		if (retValue == null 
			|| !retValue.getCategoryType().equals(CATEGORYTYPE_SystemGenerated))
		{
			retValue = new MGLCategory(ctx, 0, null);
			retValue.setName("Default System");
			retValue.setCategoryType(CATEGORYTYPE_SystemGenerated);
			retValue.setIsDefault(true);
			if (!retValue.save())
				throw new IllegalStateException("Could not save default system GL Category");
		}
		return retValue;
	}	//	getDefaultSystem

	
	/**	Logger						*/
	private static CLogger s_log = CLogger.getCLogger (MGLCategory.class);
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer, MGLCategory> s_cache 
		= new ImmutableIntPOCache<Integer, MGLCategory> (Table_Name, 5);
	

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param GL_Category_ID id
	 *	@param trxName transaction
	 */
	public MGLCategory (Properties ctx, int GL_Category_ID, String trxName)
	{
		super (ctx, GL_Category_ID, trxName);
		if (GL_Category_ID == 0)
		{
			setCategoryType (CATEGORYTYPE_Manual);
			setIsDefault (false);
		}
	}	//	MGLCategory

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MGLCategory (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MGLCategory

	/**
	 * 
	 * @param copy
	 */
	public MGLCategory(MGLCategory copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MGLCategory(Properties ctx, MGLCategory copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MGLCategory(Properties ctx, MGLCategory copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public String toString()
	{
		StringBuilder msgreturn = new StringBuilder().append(getClass().getSimpleName()).append("[").append(get_ID())
				.append(", Name=").append(getName())
				.append(", IsDefault=").append(isDefault())
				.append(", IsActive=").append(isActive())
				.append(", CategoryType=").append(getCategoryType())
				.append("]");
		return msgreturn.toString();
	}
	
	@Override
	public MGLCategory markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MGLCategory
