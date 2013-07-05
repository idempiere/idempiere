/******************************************************************************
 * Product: Compiere ERP & CRM Smart Business Solution                        *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 3600 Bridge Parkway #102, Redwood City, CA 94065, USA      *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;


public class MIndexColumn extends X_AD_IndexColumn {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7588207529142215755L;

	/**
	 * Standard constructor
	 * @param ctx context
	 * @param AD_IndexColumn_ID index column
	 * @param trxName trx name
	 */
	public MIndexColumn(Properties ctx, int AD_IndexColumn_ID, String trxName)
	{
		super(ctx, AD_IndexColumn_ID, trxName);
	}
	
	/**
	 * Load constructor
	 * @param ctx context
	 * @param rs result set
	 * @param trxName trx name
	 */
	public MIndexColumn(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);		
	}
	
	/**
	 * Parent constructor
	 * @param parent parent
	 * @param column column
	 * @param seqNo sequence no
	 */
	public MIndexColumn(MTableIndex parent, MColumn column, int seqNo)
	{
		this(parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setAD_TableIndex_ID(parent.getAD_TableIndex_ID());
		setAD_Column_ID(column.getAD_Column_ID());
		setSeqNo(seqNo);
	}
	
	/**
	 * Get column name
	 * @return column name
	 */
	public String getColumnName()
	{
		String sql = getColumnSQL();		// Function Index
		if (sql != null && sql.length() > 0)
			return sql;
		int AD_Column_ID = getAD_Column_ID();
		return MColumn.getColumnName(getCtx(), AD_Column_ID);
	}
	
	/**
	 * String representation
	 * @return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MIndexColumn[");
		sb.append(get_ID()).append("-").append(getAD_Column_ID()).append("]");
		return sb.toString();
	}
}
