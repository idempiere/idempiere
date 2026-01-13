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
package org.idempiere.db.util;

import java.sql.Timestamp;
import java.util.List;
import java.util.Objects;
import java.util.regex.Matcher;

import org.compiere.util.DB;

/**
 * SQL fragment with SQL clause and parameters
 * 
 * @author hengsin
 */
public record SQLFragment(String sqlClause, List<Object> parameters) {
	
	public SQLFragment {
		parameters = parameters != null ? List.copyOf(parameters) : List.of();
		sqlClause = sqlClause != null ? sqlClause : "";
	}
	
	/**
	 * @param sqlClause
	 */
	public SQLFragment(String sqlClause) {
		this(sqlClause, List.of());
	}

	@Override
	public int hashCode() {
		return Objects.hash(parameters, sqlClause);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SQLFragment other = (SQLFragment) obj;
		return Objects.equals(parameters, other.parameters) && Objects.equals(sqlClause, other.sqlClause);
	}
	
	/**
	 * Convert to SQL clause with embedded parameters from {@link #parameters} (replacing ? with parameter value). <br/>
	 * Warning: This is subject to SQL injection attack, use with care.
	 * @return SQL clause with embedded parameters
	 */
	public String toSQLWithParameters() {
		if (parameters.isEmpty()) {
			return sqlClause;
		}
		String whereClause = sqlClause;
		for(Object param : parameters) {
			String paramStr = "";
			if (param instanceof String s) {
				paramStr = DB.TO_STRING(s);
			} else if (param instanceof Timestamp ts) {
				paramStr = DB.TO_DATE(ts);
			} else {
				paramStr = param != null ? param.toString() : "";
			}
			whereClause = whereClause.replaceFirst("\\?", Matcher.quoteReplacement(paramStr));
		}
		return whereClause;
	}
}