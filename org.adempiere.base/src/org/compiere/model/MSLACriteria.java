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

import org.compiere.sla.SLACriteria;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Service Level Agreement Criteria Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MSLACriteria.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MSLACriteria extends X_PA_SLA_Criteria implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6772238818871223076L;

	/**
	 * 	Get MSLACriteria from Cache
	 *	@param PA_SLA_Criteria_ID id
	 *	@return MSLACriteria
	 */
	public static MSLACriteria get (int PA_SLA_Criteria_ID)
	{
		return get(PA_SLA_Criteria_ID, (String)null);
	}
	
	/**
	 * 	Get MSLACriteria from Cache
	 *	@param PA_SLA_Criteria_ID id
	 *	@param trxName transaction
	 *	@return MSLACriteria
	 */
	public static MSLACriteria get (int PA_SLA_Criteria_ID, String trxName)
	{
		return get(Env.getCtx(), PA_SLA_Criteria_ID, trxName);
	}
	
	/**
	 * 	Get MSLACriteria from Cache
	 *	@param ctx context
	 *	@param PA_SLA_Criteria_ID id
	 *	@param trxName transaction
	 *	@return MSLACriteria
	 */
	public static MSLACriteria get (Properties ctx, int PA_SLA_Criteria_ID, String trxName)
	{
		Integer key = Integer.valueOf(PA_SLA_Criteria_ID);
		MSLACriteria retValue = s_cache.get (ctx, key, e -> new MSLACriteria(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MSLACriteria (ctx, PA_SLA_Criteria_ID, trxName);
		if (retValue.get_ID () == PA_SLA_Criteria_ID)
		{
			s_cache.put (key, retValue, e -> new MSLACriteria(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MSLACriteria>	s_cache	= new ImmutableIntPOCache<Integer,MSLACriteria>(Table_Name, 20);
	
	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param PA_SLA_Criteria_ID id
	 *	@param trxName transaction
	 */
	public MSLACriteria (Properties ctx, int PA_SLA_Criteria_ID, String trxName)
	{
		super (ctx, PA_SLA_Criteria_ID, trxName);
	}	//	MSLACriteria

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MSLACriteria (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MSLACriteria

	/**
	 * 
	 * @param copy
	 */
	public MSLACriteria(MSLACriteria copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MSLACriteria(Properties ctx, MSLACriteria copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MSLACriteria(Properties ctx, MSLACriteria copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Get Goals of Criteria
	 *	@return array of Goals
	 */
	public MSLAGoal[] getGoals()
	{
		String sql = "SELECT * FROM PA_SLA_Goal "
			+ "WHERE PA_SLA_Criteria_ID=?";
		ArrayList<MSLAGoal> list = new ArrayList<MSLAGoal>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, getPA_SLA_Criteria_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add(new MSLAGoal(getCtx(), rs, get_TrxName()));
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
		MSLAGoal[] retValue = new MSLAGoal[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getGoals
	
	
	/**
	 * 	Create New Instance of SLA Criteria
	 *	@return instanciated class
	 *	@throws Exception
	 */
	public SLACriteria newInstance() throws Exception
	{
		if (getClassname() == null || getClassname().length() == 0)
			throw new AdempiereSystemError("No SLA Criteria Classname");
		
		try
		{
			Class<?> clazz = Class.forName(getClassname());
			SLACriteria retValue = (SLACriteria)clazz.getDeclaredConstructor().newInstance();
			return retValue;
		}
		catch (Exception e)
		{
			throw new AdempiereSystemError("Could not intsnciate SLA Criteria", e);
		}
	}	//	newInstance
	
	@Override
	public MSLACriteria markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MSLACriteria
