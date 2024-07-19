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
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.model.IProcessParameter;

/**
 * 	Scheduler Parameter Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MSchedulerPara.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MSchedulerPara extends X_AD_Scheduler_Para implements ImmutablePOSupport, IProcessParameter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -9178948165437974600L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Scheduler_Para_ID id
	 *	@param trxName transaction
	 */
	public MSchedulerPara (Properties ctx, int AD_Scheduler_Para_ID,
		String trxName)
	{
		super (ctx, AD_Scheduler_Para_ID, trxName);
	}	//	MSchedulerPara

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MSchedulerPara (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MSchedulerPara
	
	/**
	 * 
	 * @param copy
	 */
	public MSchedulerPara(MSchedulerPara copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MSchedulerPara(Properties ctx, MSchedulerPara copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MSchedulerPara(Properties ctx, MSchedulerPara copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_parameter = copy.m_parameter != null ? new MProcessPara(ctx, copy.m_parameter, trxName) : null;
	}
	
	/** Parameter Column Name		*/
	private MProcessPara	m_parameter = null;
	
	/**
	 * 	Get Parameter Column Name 
	 *	@return column name
	 */
	public String getColumnName()
	{
		if (m_parameter == null)
			m_parameter = MProcessPara.get(getCtx(), getAD_Process_Para_ID());
		return m_parameter.getColumnName();
	}	//	getColumnName
	
	/**
	 * 	Get Display Type
	 *	@return display type
	 */
	public int getDisplayType()
	{
		if (m_parameter == null)
			m_parameter = MProcessPara.get(getCtx(), getAD_Process_Para_ID());
		return m_parameter.getAD_Reference_ID();
	}	//	getDisplayType

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString() 
	{
		StringBuilder sb = new StringBuilder("MSchedulerPara[");
		sb.append(get_ID()).append("-")
			.append(getColumnName()).append("=").append(getParameterDefault())
			.append("]");
		return sb.toString();
	} //	toString

	@Override
	public MSchedulerPara markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	@Override
	public void setParentID(int id) {
		setAD_Scheduler_ID(id);
	}

}	//	MSchedulerPara
