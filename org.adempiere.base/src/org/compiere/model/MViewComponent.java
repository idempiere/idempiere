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
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;


public class MViewComponent extends X_AD_ViewComponent implements ImmutablePOSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1580063310233871896L;

	/**
	 * Standard constructor
	 * @param ctx context
	 * @param AD_ViewComponent_ID view component
	 * @param trxName trx name
	 */
	public MViewComponent(Properties ctx, int AD_ViewComponent_ID, String trxName)
	{
		super(ctx, AD_ViewComponent_ID, trxName);
	}
	
	/**
	 * Load constructor
	 * @param ctx context
	 * @param rs result set
	 * @param trxName trx name
	 */
	public MViewComponent(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * Parent constructor
	 * @param parent parent
	 */
	public MViewComponent(MTable parent)
	{
		this(parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setAD_Table_ID(parent.getAD_Table_ID());
	}
	
	/**
	 * 
	 * @param copy
	 */
	public MViewComponent(MViewComponent copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MViewComponent(Properties ctx, MViewComponent copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MViewComponent(Properties ctx, MViewComponent copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_columns = copy.m_columns != null ? Arrays.stream(copy.m_columns).map(e -> {return new MViewColumn(ctx, e, trxName);}).toArray(MViewColumn[]::new) : null;
	}
	
	/** Columns				*/
	private MViewColumn[]	m_columns = null;
	
	/**
	 * Get columns
	 * @param reload reload data
	 * @return array of view column
	 */
	public MViewColumn[] getColumns(boolean reload)
	{
		if (m_columns != null && !reload)
			return m_columns;
		
		Query query = new Query(getCtx(), MViewColumn.Table_Name, MViewColumn.COLUMNNAME_AD_ViewComponent_ID + "=?", get_TrxName());
		query.setParameters(getAD_ViewComponent_ID());
		query.setOnlyActiveRecords(true);
		query.setOrderBy("SeqNo, AD_ViewColumn_ID");
		List<MViewColumn> list = query.<MViewColumn>list();
		if (list.size() > 0)
			list.stream().forEach(e -> e.markImmutable());
		
		m_columns = new MViewColumn[list.size()];
		list.toArray(m_columns);
		return m_columns;
	}
	
	/**
	 * Get SQL select
	 * @param requery requery data
	 * @param vCols array of view column
	 * @return select statement
	 */
	public String getSelect(boolean requery, MViewColumn[] vCols)
	{
		getColumns(requery);
		if (m_columns == null || m_columns.length == 0)
			return null;
		
		if (vCols == null)
			vCols = m_columns;
		
		StringBuilder sb = new StringBuilder("SELECT ");
		//

		if (isDistinct())
			sb.append("DISTINCT ");

		for (int i = 0; i < vCols.length; i++)
		{
			String colName = vCols[i].getColumnName();
			MViewColumn vc = null;
			for (MViewColumn element : m_columns) 
			{
				if (element.getColumnName().equals(colName))
				{
					vc = element;
					break;
				}
			}
			if (vc == null) {
				throw new AdempiereException("Cannot find element for " + colName + ".  Tip: all components must have the same number and names of columns");
			}
			if (i>0)
				sb.append(", ");
			String colSQL = vc.getColumnSQL();
			
			if (colSQL == null || colSQL.toUpperCase().equals("NULL"))
			{
				String dt = vc.getDBDataType();
				if (dt != null)
				{
					if (dt.equals(MViewColumn.DBDATATYPE_CharacterFixed) || 
							dt.equals(MViewColumn.DBDATATYPE_CharacterVariable))
						colSQL = "NULLIF('a','a')";
					else if (dt.equals(MViewColumn.DBDATATYPE_Integer))
						colSQL = "NULLIF(1,1)";
					else if (dt.equals(MViewColumn.DBDATATYPE_Decimal) || 
							dt.equals(MViewColumn.DBDATATYPE_Number))
						colSQL = "NULLIF(1.0,1.0)";
					else if (dt.equals(MViewColumn.DBDATATYPE_Timestamp))
						colSQL = "NULL";
				}
				else
					colSQL = "NULL";
			}
			
			sb.append(DB.getDatabase().quoteColumnName(colSQL));
			if (!colName.equals("*"))
				sb.append(" AS ").append(DB.getDatabase().quoteColumnName(colName));
		}
		
		sb.append(" ").append(getFromClause());
		String t = getWhereClause();
		if (t!=null && t.length()>0)
			sb.append(" ").append(t);
		t = getOtherClause();
		if (t!=null && t.length()>0)
			sb.append(" ").append(t);
		
		return sb.toString();
	}
	
	
	@Override
	public MViewComponent markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_columns != null && m_columns.length > 0)
			Arrays.stream(m_columns).forEach(e -> e.markImmutable());
		return this;
	}

	/**
     * 	String representation
     *	@return info
     */
    @Override
	public String toString()
    {
    	StringBuilder sb = new StringBuilder("MViewComponent[")
	    	.append(get_ID())
	        .append("-").append(getName());
	    sb.append("]");
	    return sb.toString();
    }
}