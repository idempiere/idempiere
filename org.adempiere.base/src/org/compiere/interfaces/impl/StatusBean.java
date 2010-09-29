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
package org.compiere.interfaces.impl;

import org.compiere.Adempiere;
import org.compiere.db.CConnection;
import org.compiere.interfaces.Status;
import org.compiere.util.CLogger;


/**
 * 	Adempiere Status Bean
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: StatusBean.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 */
public class StatusBean implements Status
{
	private static final String ALLOW_CLIENT_QUERY_DB_PWD = "adempiere.client.getDBPwd";
	
	/**	Logging				*/
	@SuppressWarnings("unused")
	private static CLogger	log = CLogger.getCLogger(StatusBean.class);

	/**
	 * 	Get Version (Date)
	 *  @return version e.g. 2002-09-02
	 */
	public String getDateVersion()
	{
		return Adempiere.DATE_VERSION;
	}	//	getDateVersion

	/**
	 * 	Get Main Version
	 *  @return main version - e.g. Version 2.4.3b
	 */
	public String getMainVersion()
	{
		return Adempiere.MAIN_VERSION;
	}	//	getMainVersion

	/**
	 *  Get Database Type
	 *  @return Database Type
	 */
	public String getDbType()
	{
		return CConnection.get().getType();
	}   //  getDbType

	/**
	 *  Get Database Host
	 *  @return Database Host Name
	 */
	public String getDbHost()
	{
		return CConnection.get().getDbHost();
	}   //  getDbHost

	/**
	 *  Get Database Port
	 *  @return Database Port
	 */
	public int getDbPort()
	{
		return CConnection.get().getDbPort();
	}   //  getDbPort

	/**
	 *  Get Database SID
	 *  @return Database SID
	 */
	public String getDbName()
	{
		return CConnection.get().getDbName();
	}   //  getDbSID

	/**
	 *  Get Database URL
	 *  @return Database URL
	 */
	public String getConnectionURL()
	{
		return CConnection.get().getConnectionURL();
	}   //  getConnectionURL
	
	/**
	 *  Get Database UID
	 *  @return Database User Name
	 */
	public String getDbUid()
	{
		return CConnection.get().getDbUid();
	}   //  getDbUID

	/**
	 *  Get Database PWD
	 *  @return Database User Password
	 */
	public String getDbPwd()
	{
		String f = System.getProperty(ALLOW_CLIENT_QUERY_DB_PWD);
		if ("false".equalsIgnoreCase(f)) 
			return "";
		
		return CConnection.get().getDbPwd();
	}   //  getDbPWD

	/**
	 *  Get Connection Manager Host
	 *  @return Connection Manager Host
	 */
	public String getFwHost()
	{
		return CConnection.get().getFwHost();
	}   //  getCMHost

	/**
	 *  Get Connection Manager Port
	 *  @return Connection Manager Port
	 */
	public int getFwPort()
	{
		return CConnection.get().getFwPort();
	}   //  getCMPort

}	//	StatusBean
