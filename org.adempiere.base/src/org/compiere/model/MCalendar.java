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
import java.util.Locale;
import java.util.Properties;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Calendar Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MCalendar.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MCalendar extends X_C_Calendar implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6036302512252100576L;

	/**
	 * 	Get MCalendar from Cache (immutable)
	 *	@param C_Calendar_ID id
	 *	@return MCalendar
	 */
	public static MCalendar get (int C_Calendar_ID)
	{
		return get(Env.getCtx(), C_Calendar_ID);
	}
	
	/**
	 * 	Get MCalendar from Cache (immutable)
	 *	@param ctx context
	 *	@param C_Calendar_ID id
	 *	@return MCalendar
	 */
	public static MCalendar get (Properties ctx, int C_Calendar_ID)
	{
		Integer key = Integer.valueOf(C_Calendar_ID);
		MCalendar retValue = s_cache.get (ctx, key, e -> new MCalendar(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MCalendar (ctx, C_Calendar_ID, (String)null);
		if (retValue.get_ID () == C_Calendar_ID) 
		{
			s_cache.put (key, retValue, e -> new MCalendar(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get
	
	/**
	 * Get updateable copy of MCalendar from cache
	 * @param ctx
	 * @param C_Calendar_ID
	 * @param trxName
	 * @return MCalendar 
	 */
	public static MCalendar getCopy(Properties ctx, int C_Calendar_ID, String trxName)
	{
		MCalendar calendar = get(C_Calendar_ID);
		if (calendar != null)
			calendar = new MCalendar(ctx, calendar, trxName);
		return calendar;
	}
	
	/**
	 * 	Get Default Calendar for Client
	 *	@param ctx context
	 *	@param AD_Client_ID id
	 *	@return MCalendar
	 */
	public static MCalendar getDefault (Properties ctx, int AD_Client_ID)
	{
		MClientInfo info = MClientInfo.get(ctx, AD_Client_ID);
		return getCopy(ctx, info.getC_Calendar_ID(), (String)null);
	}	//	getDefault
	
	/**
	 * 	Get Default Calendar for Client
	 *	@param ctx context
	 *	@return MCalendar
	 */
	public static MCalendar getDefault (Properties ctx)
	{
		return getDefault(ctx, Env.getAD_Client_ID(ctx));
	}	//	getDefault
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MCalendar> s_cache
		= new ImmutableIntPOCache<Integer,MCalendar>(Table_Name, 20);
	
	
	/*************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_Calendar_ID id
	 *	@param trxName transaction
	 */
	public MCalendar (Properties ctx, int C_Calendar_ID, String trxName)
	{
		super(ctx, C_Calendar_ID, trxName);
	}	//	MCalendar

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCalendar (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCalendar

	/**
	 * 	Parent Constructor
	 *	@param client parent
	 */
	public MCalendar (MClient client)
	{
		super(client.getCtx(), 0, client.get_TrxName());
		setClientOrg(client);
		StringBuilder msgset = new StringBuilder().append(client.getName()).append(" ").append(Msg.translate(client.getCtx(), "C_Calendar_ID"));
		setName(msgset.toString());
	}	//	MCalendar
	
	/**
	 * 
	 * @param copy
	 */
	public MCalendar(MCalendar copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MCalendar(Properties ctx, MCalendar copy) 
	{
		this(ctx, copy, (String) null);
	}

	public MCalendar(Properties ctx, MCalendar copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Create (current) Calendar Year
	 * 	@param locale locale
	 *	@return The Year
	 */
	public MYear createYear(Locale locale)
	{
		if (get_ID() == 0)
			return null;
		MYear year = new MYear (this);
		year.saveEx();
		year.createStdPeriods(locale);
		//
		return year;
	}	//	createYear
	
	@Override
	public MCalendar markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MCalendar
