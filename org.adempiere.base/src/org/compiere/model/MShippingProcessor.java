/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
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
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Online shipping processor model
 */
public class MShippingProcessor extends X_M_ShippingProcessor 
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -7635817773750467895L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_ShippingProcessor_UU  UUID key
     * @param trxName Transaction
     */
    public MShippingProcessor(Properties ctx, String M_ShippingProcessor_UU, String trxName) {
        super(ctx, M_ShippingProcessor_UU, trxName);
    }

    /**
     * @param ctx
     * @param M_ShippingProcessor_ID
     * @param trxName
     */
	public MShippingProcessor(Properties ctx, int M_ShippingProcessor_ID, String trxName) 
	{
		super(ctx, M_ShippingProcessor_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MShippingProcessor(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * @return shipping process Java class name
	 */
	public String getShippingProcessorClass()
	{
		return getM_ShippingProcessorCfg().getShippingProcessorClass();
	}
	
	/**
	 * @return host address of shipping processor
	 */
	public String getHostAddress()
	{
		return getM_ShippingProcessorCfg().getHostAddress();
	}
	
	/**
	 * @return host port of shipping processor
	 */
	public int getHostPort()
	{
		return getM_ShippingProcessorCfg().getHostPort();
	}
	
	/**
	 * @return proxy address of shipping processor
	 */
	public String getProxyAddress()
	{
		return getM_ShippingProcessorCfg().getProxyAddress();
	}
	
	/**
	 * @return proxy port of shipping processor
	 */
	public int getProxyPort()
	{
		return getM_ShippingProcessorCfg().getProxyPort();
	}
	
	/**
	 * @return proxy login of shipping processor
	 */
	public String getProxyLogon()
	{
		return getM_ShippingProcessorCfg().getProxyLogon();
	}
	
	/**
	 * @return proxy password of shipping processor
	 */
	public String getProxyPassword()
	{
		return getM_ShippingProcessorCfg().getProxyPassword();
	}
	
	/**
	 * @return path to access service provided by this shipping processor
	 */
	public String getServicePath()
	{
		return getM_ShippingProcessorCfg().getServicePath();
	}
	
}
