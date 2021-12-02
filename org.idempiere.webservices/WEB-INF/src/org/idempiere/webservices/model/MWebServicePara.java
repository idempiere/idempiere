/***********************************************************************
 * This file is part of iDempiere ERP Bazaar                           *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Carlos Ruiz - globalqss                               *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz  (globalqss@users.sourceforge.net)                    *
 *                                                                     *
 * Sponsors:                                                           *
 * - GlobalQSS (http://www.globalqss.com)                              *
 ***********************************************************************/

package org.idempiere.webservices.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;

/**
 *	Web Services Parameters Model
 *	
 *  @author Carlos Ruiz
 */
@org.adempiere.base.Model(table = X_WS_WebService_Para.Table_Name)
public class MWebServicePara extends X_WS_WebService_Para
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3561409141850981248L;

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param WS_WebService_Para_ID
	 *	@param trxName transaction
	 */
	public MWebServicePara (Properties ctx, int WS_WebService_Para_ID, String trxName)
	{
		super (ctx, WS_WebService_Para_ID, trxName);
		/** if (WS_WebService_Para_ID == 0)
        {
			setName (null);
			setValue (null);
			WS_WebService_Para_ID (0);
        } */
	}	//	MWebServicePara

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MWebServicePara (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MWebServicePara

	/**
	 * 
	 * @param copy
	 */
	public MWebServicePara(MWebServicePara copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MWebServicePara(Properties ctx, MWebServicePara copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWebServicePara(Properties ctx, MWebServicePara copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (   "Filter".equalsIgnoreCase(getParameterName())
			&& PARAMETERTYPE_Free.equals(getParameterType())) {
			log.saveError("Error", "Type Free not allowed for parameter Filter (security issue)"); // IDEMPIERE-1784
			return false;
		}
		return true;
	}

}	//	MWebServicePara
