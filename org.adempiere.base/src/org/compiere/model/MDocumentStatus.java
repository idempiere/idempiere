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
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.db.util.SQLFragment;

/**
 * Named status of records in a table via SQL criteria
 */
public class MDocumentStatus extends X_PA_DocumentStatus implements ImmutablePOSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8979702484417132292L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param PA_DocumentStatus_UU  UUID key
     * @param trxName Transaction
     */
    public MDocumentStatus(Properties ctx, String PA_DocumentStatus_UU, String trxName) {
        super(ctx, PA_DocumentStatus_UU, trxName);
    }

    /**
     * @param ctx
     * @param PA_DocumentStatus_ID
     * @param trxName
     */
	public MDocumentStatus(Properties ctx, int PA_DocumentStatus_ID, String trxName) {
		super(ctx, PA_DocumentStatus_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDocumentStatus(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MDocumentStatus(MDocumentStatus copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MDocumentStatus(Properties ctx, MDocumentStatus copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MDocumentStatus(Properties ctx, MDocumentStatus copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**	MDocumentStatus Cache				*/
	private static ImmutableIntPOCache<Integer,MDocumentStatus>	s_cache = new ImmutableIntPOCache<Integer,MDocumentStatus>(Table_Name, 20);
	
	/**
	 * 	Get from Cache (immutable)
	 *	@param ctx context
	 *	@param PA_DocumentStatus_ID id
	 *	@return document status
	 */
	public static MDocumentStatus get (Properties ctx, int PA_DocumentStatus_ID)
	{
		Integer ii = Integer.valueOf(PA_DocumentStatus_ID);
		MDocumentStatus retValue = s_cache.get(ctx, ii, e -> new MDocumentStatus(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MDocumentStatus (ctx, PA_DocumentStatus_ID, (String)null);
		if (retValue.get_ID () == PA_DocumentStatus_ID)
		{
			s_cache.put (PA_DocumentStatus_ID, retValue, e -> new MDocumentStatus(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * 	Get Document Status Indicators
	 *	@param ctx context
	 *	@param AD_User_ID user
	 * @param AD_Role_ID 
	 *	@return array of document status
	 */
	public static MDocumentStatus[] getDocumentStatusIndicators(Properties ctx, int AD_User_ID, int AD_Role_ID)
	{
		return getDocumentStatusIndicators(ctx,AD_User_ID,AD_Role_ID,null);
	}
	
	/**
	 * Get Document Status Indicators
	 * @param ctx
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @param trxName
	 * @return array of document status
	 */
	public static MDocumentStatus[] getDocumentStatusIndicators(Properties ctx, int AD_User_ID, int AD_Role_ID, String trxName)
	{
		if (AD_User_ID < 0)
			return new MDocumentStatus[0];

		String whereClause = "AD_Client_ID IN (0,?)";

		List<MDocumentStatus> list = new Query(ctx, MDocumentStatus.Table_Name, whereClause, trxName)
				.setOnlyActiveRecords(true)
				.setOrderBy("COALESCE(AD_FieldGroup_ID,0), SeqNo")
				.setParameters(Env.getAD_Client_ID(ctx))
				.list();

		/* Verify access for user/role */
		List<MDocumentStatus> listWithAccess = new ArrayList<MDocumentStatus>();
		for (MDocumentStatus ds : list) {
			if (ds.canAccess(ctx, AD_User_ID, AD_Role_ID, trxName)) {
				if (ds.getAD_Window_ID() > 0) {
					Boolean access = MRole.getDefault().getWindowAccess(ds.getAD_Window_ID());
					if (access != null)
						listWithAccess.add(ds);
				} else if (ds.getAD_Form_ID() > 0) {
					Boolean access = MRole.getDefault().getFormAccess(ds.getAD_Form_ID());
					if (access != null)
						listWithAccess.add(ds);
				} else if (ds.getAD_Process_ID() > 0) {
					Boolean access = MRole.getDefault().getProcessAccess(ds.getAD_Process_ID());
					if (access != null)
						listWithAccess.add(ds);
				} else if (ds.getAD_InfoWindow_ID() > 0) {
					Boolean access = MRole.getDefault().getInfoAccess(ds.getAD_InfoWindow_ID());
					if (access != null)
						listWithAccess.add(ds);
				} else if (!Util.isEmpty(ds.getHelp())) {
					listWithAccess.add(ds);
				}
			}
		}

		MDocumentStatus[] retValue = new MDocumentStatus[listWithAccess.size ()];
		listWithAccess.toArray (retValue);
		return retValue;
	}	//	getDocumentStatusIndicators

	/**
	 * @param documentStatus
	 * @return number of matching records
	 */
	public static int evaluate(MDocumentStatus documentStatus) {
		StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM ");
		String tableName = MTable.getTableName(Env.getCtx(), documentStatus.getAD_Table_ID());
		sql.append(tableName);
		SQLFragment sqlf = getSQLFilter(documentStatus);
		String where = sqlf.sqlClause();
		if (where != null && where.trim().length() > 0)
			sql.append(" WHERE " ).append(where);
		String sqlS = MRole.getDefault().addAccessSQL(sql.toString(), tableName, false, false);
		return DB.getSQLValue(null, sqlS, sqlf.parameters());
	}

	/**
	 * @param documentStatus
	 * @return where clause to find matching records
	 * @deprecated use getSQLFilter
	 */
	@Deprecated (since="13", forRemoval=true)
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

	/**
	 * Get where clause for document status with parameters
	 * @param documentStatus
	 * @return where clause and parameters
	 */
	public static SQLFragment getSQLFilter(MDocumentStatus documentStatus) {
		List<Object> params = new ArrayList<>();
		String tableName = MTable.getTableName(Env.getCtx(), documentStatus.getAD_Table_ID());
		StringBuilder where = new StringBuilder(" ").append(tableName).append(".AD_Client_ID=?");
		params.add(Env.getAD_Client_ID(Env.getCtx()));
		if (documentStatus.getC_Project_ID() > 0) 
		{
			where.append(" AND ").append(tableName).append(".C_Project_ID=?");
			params.add(documentStatus.getC_Project_ID());
		}
		if (documentStatus.getAD_Org_ID() > 0) 
		{
			where.append(" AND ").append(tableName).append(".AD_Org_ID=?");
			params.add(documentStatus.getAD_Org_ID());
		}
		String extra = documentStatus.getWhereClause();
		if (extra != null && extra.trim().length() > 0)
		{
			where.append(" AND ( ").append(extra).append(" ) ");
		}
		String whereClause = Env.parseContextForSql(Env.getCtx(), 0, where.toString(), false, params);
		return new SQLFragment(whereClause, params);
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("MDocumentStatus[");
		sb.append(get_ID()).append("-").append(getName())
			.append("]");
		return sb.toString();
	}

	/**
	 * Verify access against the table PA_DocumentStatusAccess
	 * @param userId  AD_User_ID
	 * @param roleId  AD_Role_ID
	 * @return true if the user/role has access
	 */
	private boolean canAccess(Properties ctx, int userId, int roleId, String trxName) {
		List<MDocumentStatusAccess> accessList = new Query(ctx, MDocumentStatusAccess.Table_Name, "PA_DocumentStatus_ID=? AND AD_Client_ID IN (0,?)", trxName)
				.setOnlyActiveRecords(true)
				.setParameters(getPA_DocumentStatus_ID(), Env.getAD_Client_ID(ctx))
				.list();

		if (accessList.size() == 0)
			return true; // no permissions set on System or Tenant - allow access

		for (MDocumentStatusAccess access : accessList) {
			/* the only problem here is that is not easy to hide things from System role or System user
			 * but as they are the administrators is not a problem
			 */
			if (   (access.getAD_Role_ID() == roleId && access.getAD_User_ID() == userId)
				|| (access.getAD_Role_ID() == roleId && access.getAD_User_ID() == 0     )   // user not set
				|| (access.getAD_Role_ID() == 0      && access.getAD_User_ID() == userId) ) // role not set
				return true;
		}

		return false;
	}

	@Override
	public PO markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (newRecord) {
			if (getSeqNo() <= 0) {
				int seqNo = DB.getSQLValueEx(get_TrxName(), "SELECT COALESCE(MAX(SeqNo),0)+10 FROM PA_DocumentStatus WHERE AD_Client_ID IN (0,?)", getAD_Client_ID());
				setSeqNo(seqNo);
			}
		}
		if (getAD_Window_ID() > 0) {
			setAD_Form_ID(0);
			setAD_Process_ID(0);
			setAD_InfoWindow_ID(0);
		} else if (getAD_Form_ID() > 0) {
			setAD_Window_ID(0);
			setAD_Process_ID(0);
			setAD_InfoWindow_ID(0);
		} else if (getAD_Process_ID() > 0) {
			setAD_Window_ID(0);
			setAD_Form_ID(0);
			setAD_InfoWindow_ID(0);
		} else if (getAD_InfoWindow_ID() > 0) {
			setAD_Window_ID(0);
			setAD_Form_ID(0);
			setAD_Process_ID(0);
		}
		return true;
	}

}
