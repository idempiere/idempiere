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

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Request Status Category Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MStatusCategory.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class MStatusCategory extends X_R_StatusCategory implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5527646898927619293L;

	/**
	 * 	Get Default Status Categpru for Client
	 *	@param ctx context
	 *	@return status category or null
	 */
	public static MStatusCategory getDefault (Properties ctx)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		String sql = "SELECT * FROM R_StatusCategory "
			+ "WHERE AD_Client_ID in (0,?) AND IsDefault='Y' "
			+ "ORDER BY AD_Client_ID DESC";
		MStatusCategory retValue = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Client_ID);
			rs = pstmt.executeQuery ();
			if (rs.next ())
				retValue = new MStatusCategory (ctx, rs, null);
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
	 * 	Get Default Status Categpru for Client
	 *	@param ctx context
	 *	@return status category or null
	 */
	public static MStatusCategory createDefault (Properties ctx)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		MStatusCategory retValue = new MStatusCategory(ctx, 0, null);
		retValue.setClientOrg(AD_Client_ID, 0);
		retValue.setName(Msg.getMsg(ctx, "Standard"));
		retValue.setIsDefault(true);
		if (!retValue.save())
			return null;
		String sql = "UPDATE R_Status SET R_StatusCategory_ID=" + retValue.getR_StatusCategory_ID()
			+ " WHERE R_StatusCategory_ID IS NULL AND AD_Client_ID=" + AD_Client_ID;
		int no = DB.executeUpdate(sql, null);
		if (s_log.isLoggable(Level.INFO)) s_log.info("Default for AD_Client_ID=" + AD_Client_ID + " - Status #" + no);
		return retValue;
	}	//	createDefault

	/**
	 * 	Get Request Status Category from Cache (immutable)
	 *	@param R_StatusCategory_ID id
	 *	@return RStatusCategory
	 */
	public static MStatusCategory get (int R_StatusCategory_ID)
	{
		return get(Env.getCtx(), R_StatusCategory_ID);
	}
	
	/**
	 * 	Get Request Status Category from Cache (immutable)
	 *	@param ctx context
	 *	@param R_StatusCategory_ID id
	 *	@return RStatusCategory
	 */
	public static MStatusCategory get (Properties ctx, int R_StatusCategory_ID)
	{
		Integer key = Integer.valueOf(R_StatusCategory_ID);
		MStatusCategory retValue = s_cache.get (ctx, key, e -> new MStatusCategory(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MStatusCategory (ctx, R_StatusCategory_ID, (String)null);
		if (retValue.get_ID() == R_StatusCategory_ID)
		{
			s_cache.put (key, retValue, e -> new MStatusCategory(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer, MStatusCategory> s_cache 
		= new ImmutableIntPOCache<Integer, MStatusCategory> (Table_Name, 20);
	/**	Logger	*/
	private static CLogger s_log = CLogger.getCLogger (MStatusCategory.class);
	
	
	/**************************************************************************
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param R_StatusCategory_ID id
	 *	@param trxName trx
	 */
	public MStatusCategory (Properties ctx, int R_StatusCategory_ID, String trxName)
	{
		super (ctx, R_StatusCategory_ID, trxName);
		if (R_StatusCategory_ID == 0)
		{
			setIsDefault (false);
		}
	}	//	RStatusCategory

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MStatusCategory (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	RStatusCategory

	/**
	 * 
	 * @param copy
	 */
	public MStatusCategory(MStatusCategory copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MStatusCategory(Properties ctx, MStatusCategory copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MStatusCategory(Properties ctx, MStatusCategory copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_status = copy.m_status != null ? Arrays.stream(copy.m_status).map(e ->{return new MStatus(ctx, e, trxName);}).toArray(MStatus[]::new) : null;
	}
	
	/**	The Status						*/
	private MStatus[] m_status = null;
	
	/**
	 * 	Get all Status
	 *	@param reload reload
	 *	@return Status array 
	 */
	public MStatus[] getStatus(boolean reload)
	{
		if (m_status != null && !reload)
			return m_status;
		String sql = "SELECT * FROM R_Status "
			+ "WHERE R_StatusCategory_ID=? "
			+ "ORDER BY SeqNo";
		ArrayList<MStatus> list = new ArrayList<MStatus>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, getR_StatusCategory_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MStatus (getCtx(), rs, null));
		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		m_status = new MStatus[list.size ()];
		list.toArray (m_status);
		return m_status;
	}	//	getStatus
	
	/**
	 * 	Get Default R_Status_ID
	 *	@return id or 0
	 */
	public int getDefaultR_Status_ID()
	{
		if (m_status == null)
			getStatus(false);
		for (int i = 0; i < m_status.length; i++)
		{
			if (m_status[i].isDefault() && m_status[i].isActive())
				return m_status[i].getR_Status_ID();
		}
		if (m_status.length > 0 
			&& m_status[0].isActive())
				return m_status[0].getR_Status_ID();
		return 0;
	}	//	getDefaultR_Status_ID

	@Override
	public MStatusCategory markImmutable() 
	{
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_status != null && m_status.length > 0)
			Arrays.stream(m_status).forEach(e -> e.markImmutable());
		return this;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("RStatusCategory[");
		sb.append (get_ID()).append ("-").append(getName()).append ("]");
		return sb.toString ();
	}	//	toString
	
}	//	RStatusCategory
