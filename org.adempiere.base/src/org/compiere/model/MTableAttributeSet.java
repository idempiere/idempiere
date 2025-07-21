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
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

public class MTableAttributeSet extends X_AD_TableAttributeSet
{
	/**
	 * 
	 */
	private static final long									serialVersionUID				= -5802958666081579235L;

	private static final CCache<String, ArrayList<MAttribute>>	s_TableAttributeListCache		= new CCache<>(Table_Name, 5, 0, false, 0);

	private static final String									SQL_GET_DUPLICATE_ATTRIB_COUNT	= """
					SELECT COUNT(1) FROM M_AttributeUse u
					INNER JOIN M_Attribute a 	ON a.M_Attribute_ID = u.M_Attribute_ID
					WHERE u.M_AttributeSet_ID = ?  AND u.IsActive = 'Y'  AND a.IsActive = 'Y'
						AND EXISTS (
							SELECT 1	FROM M_AttributeUse u2
							INNER JOIN	M_Attribute a2			ON a2.M_Attribute_ID = u2.M_Attribute_ID
							INNER JOIN	AD_TableAttributeSet s	ON s.M_AttributeSet_ID = u2.M_AttributeSet_ID
							WHERE s.AD_Table_ID = ? AND u2.IsActive = 'Y' AND (a2.Name = a.Name OR u2.M_Attribute_ID = u.M_Attribute_ID)
						) """;

	public MTableAttributeSet(Properties ctx, int AD_TableAttributeSet_ID, String trxName)
	{
		super(ctx, AD_TableAttributeSet_ID, trxName);
	}

	public MTableAttributeSet(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	/**
	 * Retrieves active attributes for a given table.
	 *
	 * @param  tableID  the ID of the table.
	 * @param  trx_Name the database transaction name.
	 * @return          a list of MAttribute objects.
	 */
	public static ArrayList<MAttribute> getMAttributes(int tableID, String trx_Name)
	{
		if (s_TableAttributeListCache.containsKey(String.valueOf(tableID)))
			return s_TableAttributeListCache.get(String.valueOf(tableID));

		String sql = """
						SELECT DISTINCT mau.M_Attribute_ID
						FROM M_AttributeUse mau
						INNER JOIN M_Attribute ma 			ON (mau.M_Attribute_ID = ma.M_Attribute_ID)
						INNER JOIN AD_TableAttributeSet tas ON (mau.M_AttributeSet_ID = tas.M_AttributeSet_ID)
						WHERE mau.IsActive = 'Y' AND ma.IsActive = 'Y' AND tas.IsActive = 'Y' AND tas.AD_Table_ID = ?
						""";

		ArrayList<MAttribute> list = new ArrayList<MAttribute>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trx_Name);
			pstmt.setInt(1, tableID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MAttribute ma = new MAttribute(Env.getCtx(), rs.getInt(1), trx_Name);
				list.add(ma);
			}

			if (!list.isEmpty())
				s_TableAttributeListCache.put(String.valueOf(tableID), list);
		}
		catch (SQLException ex)
		{
			throw new DBException(ex, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return list;
	} // getMAttributes

	/**
	 * Checks if the specified table has an associated attribute set.
	 *
	 * @param  ad_Table_ID the ID of the table.
	 * @return             true if the table has an attribute set, false otherwise.
	 */
	public static boolean hasTableAttributeSet(int ad_Table_ID)
	{
		return DB.getSQLValue(null, "SELECT COUNT(1) FROM AD_TableAttributeSet WHERE AD_Table_ID = ? AND IsActive = 'Y' ", ad_Table_ID) > 0;
	}

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		int count = DB.getSQLValue(get_TrxName(), SQL_GET_DUPLICATE_ATTRIB_COUNT, getM_AttributeSet_ID(), getAD_Table_ID());
		if (count > 0)
			throw new AdempiereException(Msg.getCleanMsg(getCtx(), "DuplicateAttribute"));

		return true;
	} // beforeSave
}
