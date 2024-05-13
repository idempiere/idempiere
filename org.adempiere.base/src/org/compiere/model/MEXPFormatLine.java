/**********************************************************************
 * This file is part of Adempiere ERP Bazaar                          * 
 * http://www.adempiere.org                                           * 
 *                                                                    * 
 * Copyright (C) Trifon Trifonov.                                     * 
 * Copyright (C) Contributors                                         * 
 *                                                                    * 
 * This program is free software; you can redistribute it and/or      * 
 * modify it under the terms of the GNU General Public License        * 
 * as published by the Free Software Foundation; either version 2     * 
 * of the License, or (at your option) any later version.             * 
 *                                                                    * 
 * This program is distributed in the hope that it will be useful,    * 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of     * 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the       * 
 * GNU General Public License for more details.                       * 
 *                                                                    * 
 * You should have received a copy of the GNU General Public License  * 
 * along with this program; if not, write to the Free Software        * 
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,         * 
 * MA 02110-1301, USA.                                                * 
 *                                                                    * 
 * Contributors:                                                      * 
 *  - Trifon Trifonov (trifonnt@users.sourceforge.net)                *
 *                                                                    *
 * Sponsors:                                                          *
 *  - e-Evolution (http://www.e-evolution.com/)                       *
 *********************************************************************/

package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * @author Trifon N. Trifonov
 */
public class MEXPFormatLine extends X_EXP_FormatLine implements ImmutablePOSupport {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2125885766063286714L;
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (X_EXP_FormatLine.class);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param EXP_FormatLine_UU  UUID key
     * @param trxName Transaction
     */
    public MEXPFormatLine(Properties ctx, String EXP_FormatLine_UU, String trxName) {
        super(ctx, EXP_FormatLine_UU, trxName);
    }

    /**
     * @param ctx
     * @param EXP_FormatLine_ID
     * @param trxName
     */
	public MEXPFormatLine(Properties ctx, int EXP_FormatLine_ID, String trxName) {
		super(ctx, EXP_FormatLine_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MEXPFormatLine (Properties ctx, ResultSet rs, String trxName) {
		super (ctx, rs, trxName);
	}
	
	/**
	 * Copy constructor
	 * @param copy
	 */
	public MEXPFormatLine(MEXPFormatLine copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MEXPFormatLine(Properties ctx, MEXPFormatLine copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MEXPFormatLine(Properties ctx, MEXPFormatLine copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder ("X_EXP_FormatLine[ID=").append(get_ID()).append("; Value=").append(getValue()).append("; Type=").append(getType()).append("]");
		return sb.toString();
	}
	
	/**
	 * @param ctx
	 * @param value
	 * @param EXP_Format_ID
	 * @param trxName
	 * @return MEXPFormatLine
	 * @throws SQLException
	 */
	public static MEXPFormatLine getFormatLineByValue(Properties ctx, String value, int EXP_Format_ID, String trxName) 
	throws SQLException 
	{
		MEXPFormatLine result = null;
		                   
		StringBuilder sql = new StringBuilder("SELECT * ")
			.append(" FROM ").append(X_EXP_FormatLine.Table_Name)
			.append(" WHERE ").append(X_EXP_FormatLine.COLUMNNAME_Value).append("=?")
			.append(" AND ").append(X_EXP_FormatLine.COLUMNNAME_EXP_Format_ID).append(" = ?")
		;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement (sql.toString(), trxName);
			pstmt.setString(1, value);
			pstmt.setInt(2, EXP_Format_ID);
			rs = pstmt.executeQuery ();
			if ( rs.next() ) {
				result = new MEXPFormatLine (ctx, rs, trxName);
			}
		} catch (SQLException e) {
			s_log.log(Level.SEVERE, sql.toString(), e);
			throw e;
		} finally{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return result;
	}
	
	@Override
	public MEXPFormatLine markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
