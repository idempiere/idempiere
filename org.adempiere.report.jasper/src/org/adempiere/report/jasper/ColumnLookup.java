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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.report.jasper;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.function.BiFunction;
import java.util.logging.Level;

import org.compiere.model.MColumn;
import org.compiere.model.MLocation;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.NamePair;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
public class ColumnLookup implements BiFunction<String, Object, String> {

	private Language language;

	/**
	 * @param language
	 */
	public ColumnLookup(Language language) {
		this.language = language;
	}

	@Override
	public String apply(String t, Object key) {
		if (!Util.isEmpty(t, true) && key != null) {
			String[] parts = t.split("[.]");
			if (parts.length == 2) {
				String tableName = parts[0];
				String columnName = parts[1];
				MTable table = MTable.get(Env.getCtx(), tableName);
				if (table != null) {
					MColumn column = table.getColumn(columnName);
					if (column != null) {
						if (DisplayType.isList(column.getAD_Reference_ID())) {
							MLookupInfo linfo = MLookupFactory.getLookup_List(language, column.getAD_Reference_Value_ID());
							MLookup lookup = new MLookup(linfo, -1);
							NamePair np = lookup.getDirect(key, false, false);
							return np != null ? np.toString() : "";
						} else if (DisplayType.isLookup(column.getAD_Reference_ID()) && (key instanceof Number)) {
							return getLookupDisplay(column, (Number) key);
						} else if (DisplayType.Location == column.getAD_Reference_ID() && (key instanceof Number)) {
							MLocation loc = MLocation.get(((Number)key).intValue());
							return loc.toStringCR();									
						}
					}
				}
			}
		}
		return "";
	}

	private String getLookupDisplay(MColumn column, Number key) {
		MLookupInfo mli = MLookupFactory.getLookupInfo(Env.getCtx(), -1, column.getAD_Column_ID(), column.getAD_Reference_ID(), language, column.getColumnName(), 
				column.getAD_Reference_Value_ID(), false, "");

		StringBuilder name = new StringBuilder("");
		try (PreparedStatement pstmt = DB.prepareStatement(mli.QueryDirect, null);) {			
			pstmt.setInt(1, key.intValue());

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				name.append(rs.getString(3));
				boolean isActive = rs.getString(4).equals("Y");
				if (!isActive)
					name.insert(0, MLookup.INACTIVE_S).append(MLookup.INACTIVE_E);
			}
		} catch (Exception e) {
			CLogger.getCLogger(getClass()).log(Level.SEVERE, e.getMessage(), e);
		}

		return name.toString();
	}

}
