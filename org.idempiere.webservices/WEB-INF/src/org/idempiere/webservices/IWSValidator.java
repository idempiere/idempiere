/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.webservices;

import java.util.Map;
import java.util.Properties;

import org.compiere.model.MWebServiceType;
import org.compiere.model.PO;
import org.idempiere.webservices.fault.IdempiereServiceFault;

import org.idempiere.adInterface.x10.ADLoginRequest;
import org.idempiere.adInterface.x10.DataField;

/**
 * 
 * @author deepak
 *
 */
public interface IWSValidator {
	public static final int TIMING_BEFORE_PARSE=1;
	public static final int TIMING_AFTER_PARSE=2;
	public static final int TIMING_BEFORE_SAVE=3;
	public static final int TIMING_AFTER_SAVE=4;
	
	public static final int TIMING_BEFORE_LOGIN=5;
	public static final int TIMING_AFTER_LOGIN=6;
	public static final int TIMING_ON_AUTHORIZATION=7;
	
	public static final int TIMING_BEFORE_PROCESS=8;
	public static final int TIMING_AFTER_PROCESS=9;
	
	/**
	 * 
	 * @param po
	 * @param m_webserviceType
	 * @param fields
	 * @param time
	 * @param trxName
	 * @param requestCtx
	 * @throws IdempiereServiceFault
	 */
	public void validate(PO po,MWebServiceType m_webserviceType,DataField[] fields,int time,String trxName,Map<String, Object> requestCtx) throws IdempiereServiceFault;
	
	/**
	 * 
	 * @param loginRequest
	 * @param ctx
	 * @param m_webserviceType
	 * @param time
	 * @throws IdempiereServiceFault
	 */
	public void  login(ADLoginRequest loginRequest,Properties ctx,MWebServiceType m_webserviceType,int time) throws IdempiereServiceFault; 
}
