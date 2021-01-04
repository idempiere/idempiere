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
 *  Client Info Model
 *
 *  @author Jorg Janke
 *  @version $Id: MClientInfo.java,v 1.2 2006/07/30 00:58:37 jjanke Exp $
 */
public class MClientInfo extends X_AD_ClientInfo implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4707948832203223893L;

	/**
	 * 	Get Client Info from cache (immutable)
	 * 	@param AD_Client_ID id
	 * 	@return Client Info
	 */
	public static MClientInfo get (int AD_Client_ID)
	{
		return get(Env.getCtx(), AD_Client_ID);
	}
	
	/**
	 * 	Get Client Info from cache (immutable)
	 * 	@param ctx context
	 * 	@param AD_Client_ID id
	 * 	@return Client Info
	 */
	public static MClientInfo get (Properties ctx, int AD_Client_ID)
	{
		return get(ctx, AD_Client_ID, null);
	}	//	get
	
	/**
	 * 	Get Client Info from cache (immutable)
	 * 	@param ctx context
	 * 	@param AD_Client_ID id
	 * 	@param trxName optional trx
	 * 	@return Client Info
	 */
	public static MClientInfo get (Properties ctx, int AD_Client_ID, String trxName)
	{
		Integer key = Integer.valueOf(AD_Client_ID);
		MClientInfo info = s_cache.get(ctx, key, e -> new MClientInfo(ctx, e));
		if (info != null)
			return info;
		//
		String sql = "SELECT * FROM AD_ClientInfo WHERE AD_Client_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, AD_Client_ID);
			rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				info = new MClientInfo (ctx, rs, trxName);
				s_cache.put (key, info, e -> new MClientInfo(Env.getCtx(), e));
			}
		}
		catch (SQLException ex)
		{
			s_log.log(Level.SEVERE, sql, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		return info;
	}	//	get
	
	/**
	 * 	Get optionally cached client
	 *	@return client
	 */
	public static MClientInfo get ()
	{
		return get(Env.getCtx());
	}
	
	/**
	 * 	Get optionally cached client
	 *	@param ctx context
	 *	@return client
	 */
	public static MClientInfo get (Properties ctx)
	{
		return get (ctx, Env.getAD_Client_ID(ctx), null);
	}	//	get

	/**
	 * Get updateable copy of MClientInfo from cache
	 * @param ctx
	 * @param AD_Client_ID
	 * @param trxName
	 * @return MClientInfo
	 */
	public static MClientInfo getCopy(Properties ctx, int AD_Client_ID, String trxName)
	{
		MClientInfo ci = get(ctx, AD_Client_ID, trxName);
		if (ci != null)
			ci = new MClientInfo(ctx, ci, trxName);
		return ci;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MClientInfo> s_cache = new ImmutableIntPOCache<Integer,MClientInfo>(Table_Name, 2);
	/**	Logger						*/
	private static CLogger		s_log = CLogger.getCLogger (MClientInfo.class);

	
	/**************************************************************************
	 *	Standard Constructor
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MClientInfo (Properties ctx, int ignored, String trxName)
	{
		super (ctx, ignored, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MClientInfo
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MClientInfo (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MClientInfo

	/**
	 * 	Parent Constructor
	 *	@param client client
	 *	@param AD_Tree_Org_ID org tree
	 *	@param AD_Tree_BPartner_ID bp tree
	 *	@param AD_Tree_Project_ID project tree
	 *	@param AD_Tree_SalesRegion_ID sr tree
	 *	@param AD_Tree_Product_ID product tree
	 *	@param AD_Tree_Campaign_ID campaign tree
	 *	@param AD_Tree_Activity_ID activity tree
	 *	@param trxName transaction
	 */
	public MClientInfo (MClient client, int AD_Tree_Org_ID, int AD_Tree_BPartner_ID,
		int AD_Tree_Project_ID, int AD_Tree_SalesRegion_ID, int AD_Tree_Product_ID,
		int AD_Tree_Campaign_ID, int AD_Tree_Activity_ID, String trxName)
	{
		super (client.getCtx(), 0, trxName);
		setAD_Client_ID(client.getAD_Client_ID());	//	to make sure
		setAD_Org_ID(0);
		setIsDiscountLineAmt (false);
		//
		setAD_Tree_Menu_ID(10);		//	HARDCODED
		//
		setAD_Tree_Org_ID(AD_Tree_Org_ID);
		setAD_Tree_BPartner_ID(AD_Tree_BPartner_ID); 
		setAD_Tree_Project_ID(AD_Tree_Project_ID);		
		setAD_Tree_SalesRegion_ID(AD_Tree_SalesRegion_ID);  
		setAD_Tree_Product_ID(AD_Tree_Product_ID);
		setAD_Tree_Campaign_ID(AD_Tree_Campaign_ID);
		setAD_Tree_Activity_ID(AD_Tree_Activity_ID);
		//
		m_createNew = true;
	}	//	MClientInfo

	/**
	 * 
	 * @param copy
	 */
	public MClientInfo(MClientInfo copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MClientInfo(Properties ctx, MClientInfo copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MClientInfo(Properties ctx, MClientInfo copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_acctSchema = copy.m_acctSchema != null ? new MAcctSchema(ctx, copy.m_acctSchema, trxName) : null;
	}

	/**	Account Schema				*/
	private MAcctSchema 		m_acctSchema = null;
	/** New Record					*/
	private boolean				m_createNew = false;

	/**
	 * 	Get primary Acct Schema
	 *	@return acct schema
	 */
	public MAcctSchema getMAcctSchema1()
	{
		if (m_acctSchema == null && getC_AcctSchema1_ID() != 0)
		{
			m_acctSchema = new MAcctSchema (getCtx(), getC_AcctSchema1_ID(), get_TrxName());
			if (is_Immutable())
				m_acctSchema.markImmutable();
		}
		return m_acctSchema;
	}	//	getMAcctSchema1

	/**
	 *	Get Default Accounting Currency
	 *	@return currency or 0
	 */
	public int getC_Currency_ID()
	{
		if (m_acctSchema == null)
			getMAcctSchema1();
		if (m_acctSchema != null)
			return m_acctSchema.getC_Currency_ID();
		return 0;
	}	//	getC_Currency_ID

	
	/**
	 * 	Overwrite Save
	 * 	@overwrite
	 *	@return true if saved
	 */
	public boolean save ()
	{
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		if (m_createNew)
			return super.save ();
		return saveUpdate();
	}	//	save
	
	@Override
	public MClientInfo markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		if (m_acctSchema != null)
			m_acctSchema.markImmutable();
		return this;
	}

}	//	MClientInfo
