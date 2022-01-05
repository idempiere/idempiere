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
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Message Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MMessage.java,v 1.3 2006/07/30 00:54:54 jjanke Exp $
 */
public class MMessage extends X_AD_Message implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3305457539918386807L;

	/**
	 * 	Get Message (cached) (immutable)
	 *	@param Value message value
	 *	@return message
	 */
	public static MMessage get (String Value)
	{
		return get(Env.getCtx(), Value);
	}
	
	/**
	 * 	Get Message (cached) (immutable)
	 *  @param ctx context
	 *	@param Value message value
	 *	@return message
	 */
	public static MMessage get (Properties ctx, String Value)
	{
		if (Value == null || Value.length() == 0)
			return null;
		MMessage retValue = (MMessage)s_cache.get(ctx, Value, e -> new MMessage(ctx, e));
		//
		if (retValue == null)
		{
			String sql = "SELECT * FROM AD_Message WHERE Value=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setString(1, Value);
				rs = pstmt.executeQuery();
				if (rs.next())
					retValue = new MMessage (Env.getCtx(), rs, null);
			}
			catch (Exception e)
			{
				s_log.log(Level.SEVERE, "get", e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			if (retValue != null)
			{
				s_cache.put(Value, retValue, e -> new MMessage(Env.getCtx(), e));
			}
			return retValue;
		}
		else
		{
			return retValue;
		}
		
	}	//	get

	/**
	 * 	Get Message (cached) (immutable)
	 *	@param ctx context
	 *	@param AD_Message_ID id
	 *	@return message
	 */
	public static MMessage get (Properties ctx, int AD_Message_ID)
	{
		String key = String.valueOf(AD_Message_ID);
		MMessage retValue = s_cache.get(ctx, key, e -> new MMessage(ctx, e));
		if (retValue == null)
		{
			retValue = new MMessage (ctx, AD_Message_ID, null);
			s_cache.put(key, retValue, e -> new MMessage(Env.getCtx(), e));
		}
		return retValue;
	}	//	get
	
	/**
	 * 	Get Message ID (cached)
	 *	@param Value message value
	 *	@return AD_Message_ID
	 */
	public static int getAD_Message_ID (String Value)
	{
		return getAD_Message_ID(Env.getCtx(), Value);
	}
	
	/**
	 * 	Get Message ID (cached)
	 *  @param ctx context
	 *	@param Value message value
	 *	@return AD_Message_ID
	 */
	public static int getAD_Message_ID (Properties ctx, String Value)
	{
		MMessage msg = get(ctx, Value);
		if (msg == null)
			return 0;
		return msg.getAD_Message_ID();
	}	//	getAD_Message_ID
	
	/**	Cache					*/
	static private ImmutablePOCache<String,MMessage> s_cache = new ImmutablePOCache<String,MMessage>(Table_Name, 100);
	/** Static Logger					*/
	private static CLogger 	s_log = CLogger.getCLogger(MMessage.class);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Message_ID id
	 *	@param trxName transaction
	 */
	public MMessage (Properties ctx, int AD_Message_ID, String trxName)
	{
		super(ctx, AD_Message_ID, trxName);
	}	//	MMessage

	/**
	 * 	Load Cosntructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MMessage(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MMessage

	/**
	 * 
	 * @param copy
	 */
	public MMessage(MMessage copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MMessage(Properties ctx, MMessage copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MMessage(Properties ctx, MMessage copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MMessage markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/*
	 * 	Before Save
	 *	@param newRecord
	 *	@return true if save
	 */
	protected boolean beforeSave(boolean newRecord) {

		// To avoid conflicts with tenant level messages, the value cannot start with numeric and |
		if (getValue().contains("|")) {

			String prefix = getValue().substring(0, getValue().indexOf("|"));

			if (prefix.matches("[0-9]+")) {
				log.saveError("Error", "A message cannot have a value starting with numeric and |");
				return false;
			}
		}

		return true;
	}
}	//	MMessage
