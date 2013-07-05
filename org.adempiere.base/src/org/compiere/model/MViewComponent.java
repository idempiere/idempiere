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
import java.util.List;
import java.util.Properties;


public class MViewComponent extends X_AD_ViewComponent {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8915166706061086737L;

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
		query.setOrderBy(MViewColumn.COLUMNNAME_AD_ViewColumn_ID);
		List<MViewColumn> list = query.<MViewColumn>list();
		
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
					else if (dt.equals(MViewColumn.DBDATATYPE_Decimal) || 
							dt.equals(MViewColumn.DBDATATYPE_Integer) ||
							dt.equals(MViewColumn.DBDATATYPE_Number))
						colSQL = "NULLIF(1,1)";
					else if (dt.equals(MViewColumn.DBDATATYPE_Timestamp))
						colSQL = "NULL";
				}
				else
					colSQL = "NULL";
			}
			
			sb.append(colSQL);
			if (!colName.equals("*"))
				sb.append(" AS ").append(colName);
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
	
	/**
     * 	String representation
     *	@return info
     */
    @Override
	public String toString()
    {
	    StringBuffer sb = new StringBuffer("MViewComponent[")
	    	.append(get_ID())
	        .append("-").append(getName());
	    sb.append("]");
	    return sb.toString();
    }
}