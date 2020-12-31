/**********************************************************************
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
*                                                                     *
* Contributors:                                                       *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;

import org.adempiere.base.IModelFactory;
import org.compiere.util.Env;

public class WS_ModelFactory implements IModelFactory {

	@Override
	public Class<?> getClass(String tableName) {
		if (X_WS_WebService_Para.Table_Name.equals(tableName))
			return MWebServicePara.class;
		if (X_WS_WebServiceType.Table_Name.equals(tableName))
			return MWebServiceType.class;
		if (X_WS_WebService.Table_Name.equals(tableName))
			return MWebService.class;
		if (MWebServiceMethod.Table_Name.equals(tableName))
			return MWebServiceMethod.class;
		return null;
	}

	@Override
	public PO getPO(String tableName, int Record_ID, String trxName) {
		if (X_WS_WebService_Para.Table_Name.equals(tableName))
			return new MWebServicePara(Env.getCtx(), Record_ID, trxName);
		if (X_WS_WebServiceType.Table_Name.equals(tableName))
			return new MWebServiceType(Env.getCtx(), Record_ID, trxName);
		if (X_WS_WebService.Table_Name.equals(tableName))
			return new MWebService(Env.getCtx(), Record_ID, trxName);
		if (MWebServiceMethod.Table_Name.equals(tableName))
			return new MWebServiceMethod(Env.getCtx(), Record_ID, trxName);
		return null;
	}

	@Override
	public PO getPO(String tableName, ResultSet rs, String trxName) {
		if (X_WS_WebService_Para.Table_Name.equals(tableName))
			return new MWebServicePara(Env.getCtx(), rs, trxName);
		if (X_WS_WebServiceType.Table_Name.equals(tableName))
			return new MWebServiceType(Env.getCtx(), rs, trxName);
		if (X_WS_WebService.Table_Name.equals(tableName))
			return new MWebService(Env.getCtx(), rs, trxName);
		if (MWebServiceMethod.Table_Name.equals(tableName))
			return new MWebServiceMethod(Env.getCtx(), rs, trxName);
		return null;
	}

}
