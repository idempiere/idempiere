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
import java.util.Arrays;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	POS Function Key Layout
 *	
 *  @author Jorg Janke
 *  @version $Id: MPOSKeyLayout.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MPOSKeyLayout extends X_C_POSKeyLayout implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8100247902607470888L;

	/**
	 * 	Get POS Key Layout from Cache (immutable)
	 *	@param C_POSKeyLayout_ID id
	 *	@return MPOSKeyLayout
	 */
	public static MPOSKeyLayout get (int C_POSKeyLayout_ID)
	{
		return get(Env.getCtx(), C_POSKeyLayout_ID);
	}
	
	/**
	 * 	Get POS Key Layout from Cache (immutable)
	 *	@param ctx context
	 *	@param C_POSKeyLayout_ID id
	 *	@return MPOSKeyLayout
	 */
	public static MPOSKeyLayout get (Properties ctx, int C_POSKeyLayout_ID)
	{
		Integer key = Integer.valueOf(C_POSKeyLayout_ID);
		MPOSKeyLayout retValue = s_cache.get (ctx, key, e -> new MPOSKeyLayout(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MPOSKeyLayout (ctx, C_POSKeyLayout_ID, (String)null);
		if (retValue.get_ID () == C_POSKeyLayout_ID)
		{
			s_cache.put (key, retValue, e -> new MPOSKeyLayout(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MPOSKeyLayout> s_cache = new ImmutableIntPOCache<Integer,MPOSKeyLayout>(Table_Name, 3);

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_POSKeyLayout_ID id
	 *	@param trxName transaction
	 */
	public MPOSKeyLayout (Properties ctx, int C_POSKeyLayout_ID, String trxName)
	{
		super (ctx, C_POSKeyLayout_ID, trxName);
	}	//	MPOSKeyLayout

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPOSKeyLayout (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPOSKeyLayout

	/**
	 * 
	 * @param copy
	 */
	public MPOSKeyLayout(MPOSKeyLayout copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPOSKeyLayout(Properties ctx, MPOSKeyLayout copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPOSKeyLayout(Properties ctx, MPOSKeyLayout copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_keys = copy.m_keys != null ? Arrays.stream(copy.m_keys).map(e -> {return new MPOSKey(ctx, e, trxName);}).toArray(MPOSKey[]::new) : null;
	}
	
	/**	Keys				*/
	private MPOSKey[]	m_keys = null;
	
	/**
	 * 	Get Keys
	 *	@param requery requery
	 *	@return keys
	 */
	public MPOSKey[] getKeys (boolean requery)
	{
		if (m_keys != null && !requery)
			return m_keys;
		
		ArrayList<MPOSKey> list = new ArrayList<MPOSKey>();
		String sql = "SELECT * FROM C_POSKey WHERE C_POSKeyLayout_ID=? AND IsActive = 'Y' ORDER BY SeqNo";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, getC_POSKeyLayout_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add(new MPOSKey(getCtx(), rs, get_TrxName()));
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		m_keys = new MPOSKey[list.size ()];
		list.toArray (m_keys);
		return m_keys;
	}	//	getKeys
	
	/**
	 * 	Get Number of Keys
	 *	@return keys
	 */
	public int getNoOfKeys()
	{
		return getKeys(false).length;
	}	//	getNoOfKeys
	
	@Override
	public MPOSKeyLayout markImmutable() 
	{
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_keys != null && m_keys.length > 0)
			Arrays.stream(m_keys).forEach(e -> e.markImmutable());
		return this;
	}

}	//	MPOSKeyLayout

