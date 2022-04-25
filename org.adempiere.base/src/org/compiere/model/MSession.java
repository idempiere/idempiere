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

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.WebUtil;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Session Model.
 *	Maintained in AMenu.
 *	
 *  @author Jorg Janke
 *  @version $Id: MSession.java,v 1.3 2006/07/30 00:58:05 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1810182 ] Session lost after cache reset 
 * 			<li>BF [ 1892156 ] MSession is not really cached 
 */
public class MSession extends X_AD_Session implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 480745219310430126L;


	/**
	 * 	Get existing or create local session
	 *	@param ctx context
	 *	@param createNew create if not found
	 *	@return session session
	 *	@deprecated use Get and Create functions.
	 */
	public static MSession get (Properties ctx, boolean createNew)
	{
		MSession session = get(ctx);
		if(session == null && createNew)
			return MSession.create(ctx);
		return session;
	}	//	get
	
	/**
	 * 	Get existing local session
	 *	@param ctx context
	 *	@return session session
	 */
	public static MSession get (Properties ctx)
	{
		int AD_Session_ID = Env.getContextAsInt(ctx, Env.AD_SESSION_ID);
		MSession session = s_sessions.get(ctx, AD_Session_ID, e -> new MSession(ctx, e));
		// Try to load
		if (session == null && AD_Session_ID > 0)
		{
			session = new MSession(ctx, AD_Session_ID, null);
			if (session.get_ID () == AD_Session_ID)
			{
				s_sessions.put (AD_Session_ID, session, e -> new MSession(Env.getCtx(), e));
			} else 
			{
				session = null;
			}
		}
		return session;
	}	//	get
	
	/**
	 * 	Get existing or create local session
	 *	@param ctx context
	 *	@param createNew create if not found
	 *	@param isImmutable return Immutable Session Object (from Cache)
	 *	@return session session
	 */
	public static MSession create (Properties ctx)
	{
		MSession session = new MSession (ctx, (String)null);	//	local session
		session.saveEx();
		int AD_Session_ID = session.getAD_Session_ID();
		Env.setContext (ctx, Env.AD_SESSION_ID, AD_Session_ID);
		return session;
	}	//	get
	
	/**
	 * 	Get existing or create remote session
	 *	@param ctx context
	 *	@param Remote_Addr remote address
	 *	@param Remote_Host remote host
	 *	@param WebSession web session
	 *	@return session
	 */
	public static MSession get (Properties ctx, String Remote_Addr, String Remote_Host, String WebSession)
	{
		int AD_Session_ID = Env.getContextAsInt(ctx, Env.AD_SESSION_ID);
		MSession session = get(ctx);

		if (session == null)
		{
			session = new MSession (ctx, Remote_Addr, Remote_Host, WebSession, null);	//	remote session
			session.saveEx();
			AD_Session_ID = session.getAD_Session_ID();
			Env.setContext(ctx, Env.AD_SESSION_ID, AD_Session_ID);
		} else {
			session = new MSession(ctx, session.getAD_Session_ID(), null);
		}
		
		return session;
	}	//	get

	/**	Session Cache				*/
	private static ImmutableIntPOCache<Integer,MSession>	s_sessions = new ImmutableIntPOCache<Integer,MSession>(Table_Name, 20);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Session_ID id
	 *	@param trxName transaction
	 */
	public MSession (Properties ctx, int AD_Session_ID, String trxName)
	{
		super(ctx, AD_Session_ID, trxName);
		if (AD_Session_ID == 0)
		{
			setProcessed (false);
		}
	}	//	MSession

	/**
	 * 	Load Costructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MSession(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MSession

	/**
	 * 	New (remote) Constructor
	 *	@param ctx context
	 *	@param Remote_Addr remote address
	 *	@param Remote_Host remote host
	 *	@param WebSession web session
	 *	@param trxName transaction
	 */
	public MSession (Properties ctx, String Remote_Addr, String Remote_Host, String WebSession, String trxName)
	{
		this (ctx, 0, trxName);
		
		setServerName(WebUtil.getServerName());
		if (Remote_Addr != null)
			setRemote_Addr(Remote_Addr);
		if (Remote_Host != null)
			setRemote_Host(Remote_Host);
		if (WebSession != null)
			setWebSession(WebSession);
		setDescription(Adempiere.MAIN_VERSION + "_"
				+ Adempiere.DATE_VERSION + " "
				+ Adempiere.getImplementationVersion());
		setAD_Role_ID(Env.getContextAsInt(ctx, Env.AD_ROLE_ID));
		setLoginDate(Env.getContextAsDate(ctx, Env.DATE));
	}	//	MSession

	/**
	 * 	New (local) Constructor
	 *	@param ctx context
	 *	@param trxName transaction
	 */
	public MSession (Properties ctx, String trxName)
	{
		this (ctx, 0, trxName);
		try
		{
			InetAddress lh = InetAddress.getLocalHost();
			setServerName(WebUtil.getServerName());
			setRemote_Addr(lh.getHostAddress());
			setRemote_Host(lh.getHostName());
			setDescription(Adempiere.MAIN_VERSION + "_"
					+ Adempiere.DATE_VERSION + " "
					+ Adempiere.getImplementationVersion());
			setAD_Role_ID(Env.getContextAsInt(ctx, Env.AD_ROLE_ID));
			setLoginDate(Env.getContextAsDate(ctx, Env.DATE));
		}
		catch (UnknownHostException e)
		{
			log.log(Level.SEVERE, "No Local Host", e);
		}
	}	//	MSession
	
	/**
	 * 
	 * @param copy
	 */
	public MSession(MSession copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MSession(Properties ctx, MSession copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MSession(Properties ctx, MSession copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	/**	Web Store Session		*/
	private boolean		m_webStoreSession = false;
	
	/**
	 * 	Is it a Web Store Session
	 *	@return Returns true if Web Store Session.
	 */
	public boolean isWebStoreSession ()
	{
		return m_webStoreSession;
	}	//	isWebStoreSession
	
	/**
	 * 	Set Web Store Session
	 *	@param webStoreSession The webStoreSession to set.
	 */
	public void setWebStoreSession (boolean webStoreSession)
	{
		m_webStoreSession = webStoreSession;
	}	//	setWebStoreSession
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MSession[")
			.append(getAD_Session_ID())
			.append(",AD_User_ID=").append(getCreatedBy())
			.append(",").append(getCreated())
			.append(",Remote=").append(getRemote_Addr());
		String s = getRemote_Host();
		if (s != null && s.length() > 0)
			sb.append(",").append(s);
		if (m_webStoreSession)
			sb.append(",WebStoreSession");
		sb.append("]");
		return sb.toString();
	}	//	toString

	/**
	 * 	Session Logout
	 */
	public void logout()
	{
		setProcessed(true);
		saveEx();
		s_sessions.remove(Integer.valueOf(getAD_Session_ID()));
		if (log.isLoggable(Level.INFO)) log.info(TimeUtil.formatElapsed(getCreated(), getUpdated()));
	}	//	logout

	/**
	 * 	Preserved for backward compatibility
	 *@deprecated
	 */
	public MChangeLog changeLog (
		String TrxName, int AD_ChangeLog_ID,
		int AD_Table_ID, int AD_Column_ID, int Record_ID,
		int AD_Client_ID, int AD_Org_ID,
		Object OldValue, Object NewValue)
	{
		return changeLog(TrxName, AD_ChangeLog_ID, AD_Table_ID, AD_Column_ID,
				Record_ID, AD_Client_ID, AD_Org_ID, OldValue, NewValue,
				(String) null);
	}	// changeLog

	/**
	 * 	Create Change Log only if table is logged
	 * 	@param TrxName transaction name
	 *	@param AD_ChangeLog_ID 0 for new change log
	 *	@param AD_Table_ID table
	 *	@param AD_Column_ID column
	 *	@param Record_ID record
	 *	@param AD_Client_ID client
	 *	@param AD_Org_ID org
	 *	@param OldValue old
	 *	@param NewValue new
	 *	@return saved change log or null
	 */
	public MChangeLog changeLog (
		String TrxName, int AD_ChangeLog_ID,
		int AD_Table_ID, int AD_Column_ID, int Record_ID,
		int AD_Client_ID, int AD_Org_ID,
		Object OldValue, Object NewValue, String event)
	{
		//	Null handling
		if (OldValue == null && NewValue == null)
			return null;
		//	Equal Value
		if (OldValue != null && NewValue != null && OldValue.equals(NewValue))
			return null;

		//	Role Logging
		MRole role = MRole.getDefault(getCtx(), false);
		//	Do we need to log
		if (m_webStoreSession						//	log if WebStore
			|| MChangeLog.isLogged(AD_Table_ID)		//	im/explicit log
			|| (role != null && role.isChangeLog()))//	Role Logging
			;
		else
			return null;
		//
		if (log.isLoggable(Level.FINEST)) log.finest("AD_ChangeLog_ID=" + AD_ChangeLog_ID
				+ ", AD_Session_ID=" + getAD_Session_ID()
				+ ", AD_Table_ID=" + AD_Table_ID + ", AD_Column_ID=" + AD_Column_ID
				+ ": " + OldValue + " -> " + NewValue);
		try
		{
			MChangeLog cl = new MChangeLog(getCtx(), 
				AD_ChangeLog_ID, TrxName, getAD_Session_ID(),
				AD_Table_ID, AD_Column_ID, Record_ID, AD_Client_ID, AD_Org_ID,
				OldValue, NewValue, event);
			if (cl.save())
				return cl;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "AD_ChangeLog_ID=" + AD_ChangeLog_ID
				+ ", AD_Session_ID=" + getAD_Session_ID()
				+ ", AD_Table_ID=" + AD_Table_ID + ", AD_Column_ID=" + AD_Column_ID, e);
			return null;
		}
		log.log(Level.SEVERE, "AD_ChangeLog_ID=" + AD_ChangeLog_ID
			+ ", AD_Session_ID=" + getAD_Session_ID()
			+ ", AD_Table_ID=" + AD_Table_ID + ", AD_Column_ID=" + AD_Column_ID);
		return null;
	}	//	changeLog

	/**
	 * 
	 * @return number of cached sessions
	 */
	public static int getCachedSessionCount() {
		return s_sessions.size()-1;
	}
	
	@Override
	public MSession markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
}	//	MSession

