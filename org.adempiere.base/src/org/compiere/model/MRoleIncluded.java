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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.Adempiere;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;

/**
 * Included Role Model
 * @author teo.sarca@gmail.com
 */
public class MRoleIncluded extends X_AD_Role_Included
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 4101136698198494931L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Role_Included_UU  UUID key
     * @param trxName Transaction
     */
    public MRoleIncluded(Properties ctx, String AD_Role_Included_UU, String trxName) {
        super(ctx, AD_Role_Included_UU, trxName);
    }

    /**
     * @param ctx
     * @param AD_Role_Included_ID
     * @param trxName
     */
	public MRoleIncluded(Properties ctx, int AD_Role_Included_ID, String trxName)
	{
		super(ctx, AD_Role_Included_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MRoleIncluded(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		if (getAD_Role_ID() == getIncluded_Role_ID())
		{
			throw new AdempiereException("@AD_Role_ID@ == @Included_Role_ID@");
		}
		return true;
	}
	
	@Override
	protected boolean afterSave(boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		//
		if (newRecord || is_ValueChanged(COLUMNNAME_Included_Role_ID))
		{
			// Raise exception if there are loop
			List<Integer> trace = new ArrayList<Integer>();
			if (hasLoop(Table_Name, COLUMNNAME_Included_Role_ID, COLUMNNAME_AD_Role_ID, getIncluded_Role_ID(), trace, get_TrxName()))
			{
				StringBuilder roles = new StringBuilder();
				for (int role_id : trace)
				{
					MRole role = MRole.get(getCtx(), role_id);
					if (roles.length() > 0)
						roles.append(" - ");
					roles.append(role.getName());
				}
				throw new AdempiereException("Loop has detected "+roles);
			}
		}
		// Reset role cache
		Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(MRole.Table_Name, getAD_Role_ID()));
		//
		return true;
	}

	/**
	 * Check if there is a loop in the tree defined in given table
	 * @param tableName
	 * @param idColumnName Node_ID column name
	 * @param parentIdColumnName Parent_ID column name
	 * @param nodeId current Node_ID
	 * @param trace current tree path (optional)
	 * @param trxName transaction name
	 * @return true if loop detected. If you specified not null trace, you will have in that list the IDs from the loop
	 */
	// TODO: refactor this method and move into org.compiere.util.DB class because it's general and useful of others too
	private static boolean hasLoop(String tableName, String idColumnName, String parentIdColumnName,
			int nodeId, List<Integer> trace,
			String trxName)
	{
		final List<Integer> trace2;
		if (trace == null)
		{
			trace2 = new ArrayList<Integer>(10);
		}
		else
		{
			trace2 = new ArrayList<Integer>(trace);
		}
		trace2.add(nodeId);
		//
		final String sql = "SELECT "+idColumnName+","+parentIdColumnName+" FROM "+tableName+" WHERE "+parentIdColumnName+"=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			pstmt.setInt(1, nodeId);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				final int childId = rs.getInt(1);
				if (trace2.contains(childId))
				{
					trace.clear();
					trace.addAll(trace2);
					trace.add(childId);
					return true;
				}
				if (hasLoop(tableName, idColumnName, parentIdColumnName, childId, trace2, trxName))
				{
					trace.clear();
					trace.addAll(trace2);
					return true;
				}
			}
		}
		catch(SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		return false;
	}

	@Override
	protected boolean afterDelete(boolean success) {
		// Reset role cache
		if (success)
			Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(MRole.Table_Name, getAD_Role_ID()));
		return success;
	}

}
