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
import java.util.List;
import java.util.Properties;

import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.util.Env;

/**
 * 	Info Window Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MInfoWindow.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MInfoWindow extends X_AD_InfoWindow
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4040291733093824436L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_InfoWindow_ID id
	 *	@param trxName transaction
	 */
	public MInfoWindow (Properties ctx, int AD_InfoWindow_ID, String trxName)
	{
		super (ctx, AD_InfoWindow_ID, trxName);
	}	//	MInfoWindow

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MInfoWindow (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MInfoWindow

	public static MInfoWindow get(String tableName, String trxName) {
		Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), I_AD_InfoWindow.Table_ID), I_AD_InfoWindow.COLUMNNAME_AD_Table_ID+"=? AND IsValid='Y' ", null);
		MTable table = MTable.get(Env.getCtx(), tableName);
		if (table != null) {
			return query.setParameters(table.getAD_Table_ID())
					.setOrderBy("AD_Client_ID Desc, AD_Org_ID Desc, IsDefault Desc, AD_InfoWindow_ID Desc")
					.setOnlyActiveRecords(true)
					.setApplyAccessFilter(true)
					.first();
		}
		return null;
	}

	public MInfoColumn[] getInfoColumns(TableInfo[] tableInfos) {
		Query query = new Query(getCtx(), MTable.get(getCtx(), I_AD_InfoColumn.Table_ID), I_AD_InfoColumn.COLUMNNAME_AD_InfoWindow_ID+"=?", get_TrxName());
		List<MInfoColumn> list = query.setParameters(getAD_InfoWindow_ID())
				.setOnlyActiveRecords(true)
				.setOrderBy(I_AD_InfoColumn.COLUMNNAME_SeqNo)
				.list();
		for(int i = list.size() - 1; i >= 0; i--) {
			MInfoColumn infoColumn = list.get(i);
			if (!infoColumn.isColumnAccess(tableInfos))
				list.remove(i);
		}
		return list.toArray(new MInfoColumn[0]);
	}
	
	public MInfoColumn[] getInfoColumns() {
		Query query = new Query(getCtx(), MTable.get(getCtx(), I_AD_InfoColumn.Table_ID), I_AD_InfoColumn.COLUMNNAME_AD_InfoWindow_ID+"=?", get_TrxName());
		List<MInfoColumn> list = query.setParameters(getAD_InfoWindow_ID())
				.setOnlyActiveRecords(true)
				.setOrderBy(I_AD_InfoColumn.COLUMNNAME_SeqNo)
				.list();
		return list.toArray(new MInfoColumn[0]);
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		AccessSqlParser parser = new AccessSqlParser("SELECT * FROM " + getFromClause());
		TableInfo[] tableInfos = parser.getTableInfo(0);
		if (tableInfos == null || tableInfos.length == 0) {
			log.saveError("ParseFromClauseError", "Failed to parse from clause");
			return false;
		}
		
		//only one default per table
		if (newRecord || is_ValueChanged("IsDefault")) {
			if (isDefault()) {				
				if (newRecord) {
					Query query = new Query(getCtx(), MTable.get(getCtx(), Table_ID), 
							"AD_Table_ID=? AND IsDefault='Y' AND AD_Client_ID=?", get_TrxName());
					List<MInfoWindow> list = query.setParameters(getAD_Table_ID(),getAD_Client_ID()).list();
					for(MInfoWindow iw : list) {
						iw.setIsDefault(false);
						iw.saveEx();
					}
				} else {
					Query query = new Query(getCtx(), MTable.get(getCtx(), Table_ID), 
							"AD_InfoWindow_ID<>? AND AD_Table_ID=? AND IsDefault='Y' AND AD_Client_ID=?", get_TrxName());
					List<MInfoWindow> list = query.setParameters(getAD_InfoWindow_ID(), getAD_Table_ID(), getAD_Client_ID()).list();
					for(MInfoWindow iw : list) {
						iw.setIsDefault(false);
						iw.saveEx();
					}
				}
			}
		}
		return true;
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (newRecord && success)	//	Add to all automatic roles
		{
			MRole[] roles = MRole.getOf(getCtx(), "IsManual='N'");
			for (int i = 0; i < roles.length; i++)
			{
				MInfoWindowAccess wa = new MInfoWindowAccess(this, roles[i].getAD_Role_ID());
				wa.saveEx();
			}
		}
		return super.afterSave(newRecord, success);
	}
	
	
}	//	MInfoWindow
