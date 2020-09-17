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

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 	Client Share Info
 *	
 *  @author Jorg Janke
 *  @version $Id: MClientShare.java,v 1.3 2006/07/30 00:58:37 jjanke Exp $
 */
public class MClientShare extends X_AD_ClientShare
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8104352403537353753L;

	/**
	 * 	Is Table Client Level Only
	 *	@param AD_Client_ID client
	 *	@param AD_Table_ID table
	 *	@return true if client level only (default false)
	 */
	public static boolean isClientLevelOnly (int AD_Client_ID, int AD_Table_ID)
	{
		Boolean share = isShared(AD_Client_ID, AD_Table_ID);
		if (share != null)
			return share.booleanValue();
		return false;
	}	//	isClientLevel
	
	/**
	 * 	Is Table Org Level Only
	 *	@param AD_Client_ID client
	 *	@param AD_Table_ID table
	 *	@return true if Org level only (default false)
	 */
	public static boolean isOrgLevelOnly (int AD_Client_ID, int AD_Table_ID)
	{
		Boolean share = isShared(AD_Client_ID, AD_Table_ID);
		if (share != null)
			return !share.booleanValue();
		return false;
	}	//	isOrgLevel

	/**
	 * 	Is Table Shared for Client
	 *	@param AD_Client_ID client
	 *	@param AD_Table_ID table
	 *	@return info or null
	 */
	private static Boolean isShared (int AD_Client_ID, int AD_Table_ID)
	{
		//	Load
		if (s_shares.isEmpty())
		{
			String sql = "SELECT AD_Client_ID, AD_Table_ID, ShareType "
				+ "FROM AD_ClientShare WHERE ShareType<>'x' AND IsActive='Y'";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement (sql, null);
				rs = pstmt.executeQuery ();
				while (rs.next ())
				{
					int Client_ID = rs.getInt(1);
					int table_ID = rs.getInt(2);
					StringBuilder key = new StringBuilder().append(Client_ID).append("_").append(table_ID);
					String ShareType = rs.getString(3);
					if (ShareType.equals(SHARETYPE_ClientAllShared))
						s_shares.put(key.toString(), Boolean.TRUE);
					else if (ShareType.equals(SHARETYPE_OrgNotShared))
						s_shares.put(key.toString(), Boolean.FALSE);
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
			if (s_shares.isEmpty())		//	put in something
				s_shares.put("0_0", Boolean.TRUE);
		}	//	load
		StringBuilder key = new StringBuilder().append(AD_Client_ID).append("_").append(AD_Table_ID);
		return s_shares.get(key.toString());
	}	//	load
	
	/**	Shared Info								*/
	private static CCache<String,Boolean>	s_shares 
		= new CCache<String,Boolean>(Table_Name, 10, 120);	//	2h
	/**	Logger	*/
	private static CLogger s_log = CLogger.getCLogger (MClientShare.class);
	
	/**************************************************************************
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param AD_ClientShare_ID id
	 *	@param trxName trx
	 */
	public MClientShare (Properties ctx, int AD_ClientShare_ID, String trxName)
	{
		super (ctx, AD_ClientShare_ID, trxName);
	}	//	MClientShare

	/**
	 * 	Load Constructor
	 *	@param ctx context 
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MClientShare (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MClientShare
	
	/**
	 * 
	 * @param copy
	 */
	public MClientShare(MClientShare copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MClientShare(Properties ctx, MClientShare copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MClientShare(Properties ctx, MClientShare copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_table = copy.m_table != null ? new MTable(ctx, copy.m_table, trxName) : null;
	}
	
	/**	The Table				*/
	private MTable		m_table = null;
	
	/**
	 * 	Is Client Level Only
	 *	@return true if client level only (shared)
	 */
	public boolean isClientLevelOnly()
	{
		return getShareType().equals(SHARETYPE_ClientAllShared);
	}	//	isClientLevelOnly
	
	/**
	 * 	Is Org Level Only
	 *	@return true if org level only (not shared)
	 */
	public boolean isOrgLevelOnly()
	{
		return getShareType().equals(SHARETYPE_OrgNotShared);
	}	//	isOrgLevelOnly

	/**
	 * 	Get Table model
	 *	@return table
	 */
	public MTable getTable()
	{
		if (m_table == null)
			m_table = MTable.getCopy(getCtx(), getAD_Table_ID(), get_TrxName());
		return m_table;
	}	//	getTable
	
	/**
	 * 	Get Table Name
	 *	@return table name
	 */
	public String getTableName()
	{
		return getTable().getTableName();
	}	//	getTableName
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return true
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (isActive())
		{
			setDataToLevel();
			listChildRecords();
		}
		return success;
	}	//	afterSave
	
	/**
	 * 	Set Data To Level
	 * 	@return info
	 */
	public String setDataToLevel()
	{
		StringBuilder info = new StringBuilder("-");
		if (isClientLevelOnly())
		{
			StringBuilder sql = new StringBuilder("UPDATE ")
				.append(getTableName())
				.append(" SET AD_Org_ID=0 WHERE AD_Org_ID<>0 AND AD_Client_ID=?");
			int no = DB.executeUpdate(sql.toString(), getAD_Client_ID(), get_TrxName());
			info = new StringBuilder().append(getTableName()).append(" set to Shared #").append(no);
			if (log.isLoggable(Level.INFO)) log.info(info.toString());
		}
		else if (isOrgLevelOnly())
		{
			StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM ")
				.append(getTableName())
				.append(" WHERE AD_Org_ID=0 AND AD_Client_ID=?");
			int no = DB.getSQLValue(get_TrxName(), sql.toString(), getAD_Client_ID());
			info = new StringBuilder().append(getTableName()).append(" Shared records #").append(no);
			if (log.isLoggable(Level.INFO)) log.info(info.toString());
		}
		return info.toString();
	}	//	setDataToLevel

	/**
	 * 	List Child Tables
	 *	@return child tables
	 */
	public String listChildRecords()
	{
		StringBuilder info = new StringBuilder();
		String sql = "SELECT AD_Table_ID, TableName "
			+ "FROM AD_Table t "
			+ "WHERE AccessLevel='3' AND IsView='N'"
			+ " AND EXISTS (SELECT * FROM AD_Column c "
				+ "WHERE t.AD_Table_ID=c.AD_Table_ID"
				+ " AND c.IsParent='Y'"
				+ " AND c.ColumnName IN (SELECT ColumnName FROM AD_Column cc "
					+ "WHERE cc.IsKey='Y' AND cc.AD_Table_ID=?))";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, getAD_Table_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				//int AD_Table_ID = rs.getInt(1);
				String TableName = rs.getString(2);
				if (info.length() != 0)
					info.append(", ");
				info.append(TableName);
			}
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
		if (log.isLoggable(Level.INFO)) log.info(info.toString());
		return info.toString();
	}	//	listChildRecords
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		return true;
	}	//	beforeSave

}	//	MClientShare
