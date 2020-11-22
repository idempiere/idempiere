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
* - Adaxa                                                             *
* - Ashley Ramdass                                                    *
* - Deepak Pansheriya                                                 *
* - Murilo Ht                                                         *
* - Carlos Ruiz                                                       *
**********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;

public class MDocumentStatus extends X_PA_DocumentStatus {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5908220133480463782L;

	public MDocumentStatus(Properties ctx, int PA_DocumentStatus_ID, String trxName) {
		super(ctx, PA_DocumentStatus_ID, trxName);
	}
	
	public MDocumentStatus(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * 	Get Document Status Indicators
	 *	@param ctx context
	 *	@param AD_User_ID user
	 * @param AD_Role_ID 
	 *	@return array of document status
	 */
	public static MDocumentStatus[] getDocumentStatusIndicators(Properties ctx, int AD_User_ID, int AD_Role_ID)
	{
		if (AD_User_ID < 0)
			return new MDocumentStatus[0];

		String whereClause = "AD_Client_ID IN (0,?) AND ((AD_User_ID IS NULL OR AD_User_ID=?) AND ( AD_Role_ID IS NULL OR AD_Role_ID=?))";

		List<MDocumentStatus> list = new Query(ctx, MDocumentStatus.Table_Name, whereClause, null)
				.setOnlyActiveRecords(true)
				.setOrderBy(MDocumentStatus.COLUMNNAME_SeqNo)
				.setParameters(Env.getAD_Client_ID(ctx), AD_User_ID, AD_Role_ID)
				.list();

		/* Verify access for user/role */
		List<MDocumentStatus> listWithAccess = new ArrayList<MDocumentStatus>();
		for (MDocumentStatus ds : list) {
			if (ds.getAD_Window_ID() > 0) {
				Boolean access = MRole.getDefault().getWindowAccess(ds.getAD_Window_ID());
				if (access != null)
					listWithAccess.add(ds);
			} else if (ds.getAD_Form_ID() > 0) {
				Boolean access = MRole.getDefault().getFormAccess(ds.getAD_Form_ID());
				if (access != null)
					listWithAccess.add(ds);
			}
		}

		MDocumentStatus[] retValue = new MDocumentStatus[listWithAccess.size ()];
		listWithAccess.toArray (retValue);
		return retValue;
	}	//	getDocumentStatusIndicators

	public static int evaluate(MDocumentStatus documentStatus) {
		StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM ");
		String tableName = MTable.getTableName(Env.getCtx(), documentStatus.getAD_Table_ID());
		sql.append(tableName);
		String where = getWhereClause(documentStatus);
		if (where != null && where.trim().length() > 0)
			sql.append(" WHERE " ).append(where);
		String sqlS = MRole.getDefault().addAccessSQL(sql.toString(), tableName, false, true);
		return DB.getSQLValue(null, sqlS);
	}

	public static String getWhereClause(MDocumentStatus documentStatus) {
		String tableName = MTable.getTableName(Env.getCtx(), documentStatus.getAD_Table_ID());
		StringBuilder where = new StringBuilder(" ").append(tableName).append(".AD_Client_ID=" + Env.getAD_Client_ID(Env.getCtx()) );
		if (documentStatus.getC_Project_ID() > 0) 
		{
			where.append(" AND ").append(tableName).append(".C_Project_ID=").append(documentStatus.getC_Project_ID());
		}
		if (documentStatus.getAD_Org_ID() > 0) 
		{
			where.append(" AND ").append(tableName).append(".AD_Org_ID=").append(documentStatus.getAD_Org_ID());
		}
		String extra = documentStatus.getWhereClause();
		if (extra != null && extra.trim().length() > 0)
		{
			where.append(" AND ( ").append(extra).append(" ) ");
		}
		return Env.parseContext(Env.getCtx(), 0, where.toString(), false);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("MDocumentStatus[");
		sb.append(get_ID()).append("-").append(getName())
			.append("]");
		return sb.toString();
	}

}
