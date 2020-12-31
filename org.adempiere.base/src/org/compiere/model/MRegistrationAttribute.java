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
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Asset Registration Attribute
 *	
 *  @author Jorg Janke
 *  @version $Id: MRegistrationAttribute.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MRegistrationAttribute extends X_A_RegistrationAttribute implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5410660542293211173L;

	/**
	 * 	Get All Asset Registration Attributes (not cached).
	 * 	Refreshes Cache for direct addess
	 *	@param ctx context
	 *	@return array of Registration Attributes
	 */
	public static MRegistrationAttribute[] getAll (Properties ctx)
	{
		//	Store/Refresh Cache and add to List
		ArrayList<MRegistrationAttribute> list = new ArrayList<MRegistrationAttribute>();
		String sql = "SELECT * FROM A_RegistrationAttribute "
			+ "WHERE AD_Client_ID=? "
			+ "ORDER BY SeqNo";
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Client_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MRegistrationAttribute value = new MRegistrationAttribute(ctx, rs, null);
				Integer key = Integer.valueOf(value.getA_RegistrationAttribute_ID());
				s_cache.put(key, value, e -> new MRegistrationAttribute(Env.getCtx(), e));
				list.add(value);
			}
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		MRegistrationAttribute[] retValue = new MRegistrationAttribute[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getAll

	/**
	 * 	Get Registration Attribute (cached)
	 *	@param A_RegistrationAttribute_ID id
	 *	@return Registration Attribute
	 */
	public static MRegistrationAttribute get (int A_RegistrationAttribute_ID)
	{
		return get(A_RegistrationAttribute_ID, (String)null);
	}
	
	/**
	 * 	Get Registration Attribute (cached) (immutable)
	 *	@param A_RegistrationAttribute_ID id
	 *  @param trxName
	 *	@return Registration Attribute
	 */
	public static MRegistrationAttribute get (int A_RegistrationAttribute_ID, String trxName)
	{
		return get(Env.getCtx(), A_RegistrationAttribute_ID, trxName);
	}
	
	/**
	 * 	Get Registration Attribute (cached) (immutable)
	 *	@param ctx context
	 *	@param A_RegistrationAttribute_ID id
	 *  @param trxName
	 *	@return Registration Attribute
	 */
	public static MRegistrationAttribute get (Properties ctx, int A_RegistrationAttribute_ID, String trxName)
	{
		Integer key = Integer.valueOf(A_RegistrationAttribute_ID);
		MRegistrationAttribute retValue = s_cache.get(ctx, key, e -> new MRegistrationAttribute(ctx, e, trxName));
		if (retValue == null)
		{
			retValue = new MRegistrationAttribute (ctx, A_RegistrationAttribute_ID, trxName);
			if (retValue.get_ID() == A_RegistrationAttribute_ID)
			{
				s_cache.put(key, retValue, e -> new MRegistrationAttribute(Env.getCtx(), e));
				return retValue;
			}
			return null;
		}
		return retValue;
	}	//	get

	/**
	 * Get updateable copy of MRegistrationAttribute from cache
	 * @param ctx
	 * @param A_RegistrationAttribute_ID
	 * @param trxName
	 * @return MRegistrationAttribute
	 */
	public static MRegistrationAttribute getCopy(Properties ctx, int A_RegistrationAttribute_ID, String trxName)
	{
		MRegistrationAttribute ra = get(ctx, A_RegistrationAttribute_ID, trxName);
		if (ra != null)
			ra = new MRegistrationAttribute(ctx, ra, trxName);
		return ra;
	}
	
	/** Static Logger					*/
	private static CLogger s_log = CLogger.getCLogger(MRegistrationAttribute.class);
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MRegistrationAttribute> s_cache 
		= new ImmutableIntPOCache<Integer,MRegistrationAttribute>(Table_Name, 20);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param A_RegistrationAttribute_ID id
	 */
	public MRegistrationAttribute (Properties ctx, int A_RegistrationAttribute_ID, String trxName)
	{
		super(ctx, A_RegistrationAttribute_ID, trxName);
	}	//	MRegistrationAttribute

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MRegistrationAttribute (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRegistrationAttribute

	/**
	 * 
	 * @param copy
	 */
	public MRegistrationAttribute(MRegistrationAttribute copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MRegistrationAttribute(Properties ctx, MRegistrationAttribute copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRegistrationAttribute(Properties ctx, MRegistrationAttribute copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MRegistrationAttribute markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MRegistrationAttribute
