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
 *  - Antonio Cañaveral, e-Evolution
 *                                                                    *
 * Sponsors:                                                          *
 *  - e-Evolution (http://www.e-evolution.com/)                       *
 *********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.POCopyCache;

/**
 * @author Trifon N. Trifonov
 * @author Antonio Cañaveral, e-Evolution
 * 				<li>[ 2195090 ] Implementing ExportFormat cache
 * 				<li>https://sourceforge.net/p/adempiere/feature-requests/554/
 * @author victor.perez@e-evolution.com, e-Evolution
 * 				<li>[ 2195090 ] Stabilization of replication
 * 				<li>https://sourceforge.net/p/adempiere/bugs/2294/
 *
 */
public class MEXPFormat extends X_EXP_Format implements ImmutablePOSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2749091471654364602L;

	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MEXPFormat.class);
	
	private static POCopyCache<String,MEXPFormat> s_cache = new POCopyCache<String,MEXPFormat>(MEXPFormat.Table_Name, 50 );
	private static ImmutableIntPOCache<Integer,MEXPFormat> exp_format_by_id_cache 	= new ImmutableIntPOCache<Integer,MEXPFormat>(MEXPFormat.Table_Name, 50);

	private List<MEXPFormatLine> m_lines = null;
	private List<MEXPFormatLine> m_lines_unique = null;
	
	public MEXPFormat(Properties ctx, int EXP_Format_ID, String trxName) 
	{	
		super(ctx, EXP_Format_ID, trxName);
	}
	
	public MEXPFormat(Properties ctx, ResultSet rs, String trxName) {
		super (ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param copy
	 */
	public MEXPFormat(MEXPFormat copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MEXPFormat(Properties ctx, MEXPFormat copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MEXPFormat(Properties ctx, MEXPFormat copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_lines = copy.m_lines != null ? copy.m_lines.stream().map(e -> {return new MEXPFormatLine(ctx, e, trxName);}).collect(Collectors.toCollection(ArrayList::new)) : null;
		this.m_lines_unique = copy.m_lines_unique != null ? copy.m_lines_unique.stream().map(e -> {return new MEXPFormatLine(ctx, e, trxName);}).collect(Collectors.toCollection(ArrayList::new)) : null;
	}
	
	public List<MEXPFormatLine> getFormatLines() {
		return getFormatLinesOrderedBy(X_EXP_FormatLine.COLUMNNAME_Position);
	}
	
	public List<MEXPFormatLine> getFormatLinesOrderedBy(String orderBy) 
	{
		if(m_lines != null)
		{
			return m_lines;
		}
		
		final String clauseWhere = X_EXP_FormatLine.COLUMNNAME_EXP_Format_ID + "=?";	
		m_lines = new Query(getCtx() , I_EXP_FormatLine.Table_Name, clauseWhere , get_TrxName())
						.setOnlyActiveRecords(true)
						.setParameters(getEXP_Format_ID())
						.setOrderBy(orderBy)
						.list();
		if (is_Immutable() && m_lines.size() > 0)
			m_lines.stream().forEach(e -> e.markImmutable());
		return m_lines;
	}

	public Collection<MEXPFormatLine> getUniqueColumns() throws SQLException {	
		
		if (m_lines_unique != null)
			return m_lines_unique;
		
		final String clauseWhere = X_EXP_FormatLine.COLUMNNAME_EXP_Format_ID+"= ?"
								 + " AND " + X_EXP_FormatLine.COLUMNNAME_IsPartUniqueIndex +"= ?";
		m_lines_unique = new Query(getCtx(), I_EXP_FormatLine.Table_Name, clauseWhere, get_TrxName())
													 .setOnlyActiveRecords(true)
													 .setParameters(getEXP_Format_ID(), "Y")
													 .setOrderBy(X_EXP_FormatLine.COLUMNNAME_Position)
													 .list();
		if (is_Immutable() && m_lines_unique.size() > 0)
			m_lines_unique.stream().forEach(e -> e.markImmutable());
		return m_lines_unique;
	}
	
	/**
	 * Get MEXPFormat from cache (immutable)
	 * @param EXP_Format_ID
	 * @return MEXPFormat
	 */
	public static MEXPFormat get(int EXP_Format_ID)
	{
		return get(EXP_Format_ID, (String)null);
	}
	
	/**
	 * Get MEXPFormat from cache (immutable)
	 * @param EXP_Format_ID
	 * @param trxName
	 * @return MEXPFormat
	 */
	public static MEXPFormat get(int EXP_Format_ID, String trxName)
	{
		return get(Env.getCtx(), EXP_Format_ID, trxName);
	}
	
	/**
	 * Get MEXPFormat from cache (immutable)
	 * @param ctx
	 * @param EXP_Format_ID
	 * @param trxName
	 * @return MEXPFormat
	 */
	public static MEXPFormat get(Properties ctx, int EXP_Format_ID, String trxName) 
	{
		MEXPFormat exp_format = exp_format_by_id_cache.get(ctx, EXP_Format_ID, e -> new MEXPFormat(ctx, e));
		if(exp_format != null)
			return exp_format;
		
		exp_format = new MEXPFormat(ctx, EXP_Format_ID , trxName);
		if(exp_format.getEXP_Format_ID() == EXP_Format_ID)
		{	
			exp_format.getFormatLines();
			exp_format_by_id_cache.put(EXP_Format_ID, exp_format, e -> new MEXPFormat(Env.getCtx(), e));
			return exp_format;
		}
		return null;
	}
	
	public static MEXPFormat getFormatByValueAD_Client_IDAndVersion(Properties ctx, String value, int AD_Client_ID, String version, String trxName) 
			throws SQLException 
	{
		String key = new String(value+version);
		MEXPFormat retValue=s_cache.get(key, e -> new MEXPFormat(ctx, e, trxName));
		if (retValue != null)
			return retValue;
		
		StringBuilder whereClause = new StringBuilder(X_EXP_Format.COLUMNNAME_Value).append("=?")
		.append(" AND AD_Client_ID = ?")
		.append(" AND ").append(X_EXP_Format.COLUMNNAME_Version).append(" = ?");

		retValue = (MEXPFormat) new Query(ctx,X_EXP_Format.Table_Name,whereClause.toString(),trxName)
					.setParameters(value,AD_Client_ID,version).first();
		
		if (retValue != null)
		{	
			retValue.getFormatLines();
			s_cache.put (key, retValue, e -> new MEXPFormat(Env.getCtx(), e));
			exp_format_by_id_cache.put(retValue.getEXP_Format_ID(), new MEXPFormat(Env.getCtx(), retValue));
			return retValue;
		}
		
		return null;
	}

	public static MEXPFormat getFormatByAD_Client_IDAD_Table_IDAndVersion(Properties ctx, int AD_Client_ID, int AD_Table_ID, String version, String trxName) throws SQLException 
	{
		String key = new String(MTable.getTableName(ctx, AD_Table_ID)+version);
		MEXPFormat retValue = s_cache.get(key, e -> new MEXPFormat(ctx, e, trxName));
		if(retValue!=null)
			return retValue;
		
		StringBuilder whereClause = new StringBuilder(" AD_Client_ID = ? ")
			.append("  AND ").append(X_EXP_Format.COLUMNNAME_AD_Table_ID).append(" = ? ")
			.append("  AND ").append(X_EXP_Format.COLUMNNAME_Version).append(" = ?");

		retValue = (MEXPFormat) new Query(ctx,X_EXP_Format.Table_Name,whereClause.toString(),trxName)
						.setParameters(AD_Client_ID,AD_Table_ID,version)
						.first();
		if(retValue!=null)
		{	
			retValue.getFormatLines();
			s_cache.put (key, retValue, e -> new MEXPFormat(Env.getCtx(), e));
			exp_format_by_id_cache.put(retValue.getEXP_Format_ID(), new MEXPFormat(Env.getCtx(), retValue));
			return retValue.markImmutable();
		}
		
		return null;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder ("X_EXP_Format[ID=").append(get_ID()).append("; Value = ").append(getValue()).append("]");
		return sb.toString();

	}
	
	/**
	 * 	Before Delete
	 *	@return true of it can be deleted
	 */
	protected boolean beforeDelete ()
	{
		int[] ids =MEXPFormatLine.getAllIDs(MEXPFormatLine.Table_Name, "EXP_Format_ID="+getEXP_Format_ID(), get_TrxName());
		for (int id : ids)
		{
			MEXPFormatLine line = new MEXPFormatLine(getCtx(), id, get_TrxName());
			line.delete(true);
		}
		return true;
	}	//	beforeDelete

	@Override
	public MEXPFormat markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_lines != null && m_lines.size() > 0)
			m_lines.stream().forEach(e -> e.markImmutable());
		if (m_lines_unique != null && m_lines_unique.size() > 0)
			m_lines_unique.stream().forEach(e -> e.markImmutable());
		return this;
	}
	
	
}
