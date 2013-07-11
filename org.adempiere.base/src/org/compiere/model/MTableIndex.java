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

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Msg;

public class MTableIndex extends X_AD_TableIndex {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2672452678101398999L;

	/**
	 * Get active indexes from table
	 * @param table table
	 * @return array of table index
	 */
	public static MTableIndex[] get(MTable table)
	{
		Query query = new Query(table.getCtx(), MTableIndex.Table_Name, MTableIndex.COLUMNNAME_AD_Table_ID + "=?", table.get_TrxName());
		query.setParameters(table.getAD_Table_ID());
		query.setOnlyActiveRecords(true);
		List<MTableIndex> list = query.<MTableIndex>list();
		
		MTableIndex[] retValue = new MTableIndex[list.size()];
		list.toArray(retValue);
		return retValue;
	}
	
	/**
	 * Get table indexes with where clause
	 * @param ctx context
	 * @param whereClause where clause
	 * @return array of table index
	 */
	public static List<MTableIndex> getTableIndexesByQuery(Properties ctx, String whereClause)
	{
		Query query = new Query(ctx, MTableIndex.Table_Name, whereClause, null);
		List<MTableIndex> list = query.<MTableIndex>list();
		return list;
	}
	
	/**
	 * Standard constructor
	 * @param ctx context
	 * @param AD_TableIndex_ID table index
	 * @param trxName trx name
	 */
	public MTableIndex(Properties ctx, int AD_TableIndex_ID, String trxName)
	{
		super(ctx, AD_TableIndex_ID, trxName);
		if (AD_TableIndex_ID == 0)
		{
			setEntityType(ENTITYTYPE_UserMaintained);
			setIsUnique(false);
			setIsCreateConstraint(false);
		}
	}
	
	/**
	 * Load constructor
	 * @param ctx context
	 * @param rs result set
	 * @param trxName trx name
	 */
	public MTableIndex(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		m_ddl = createDDL();
	}
	
	/**
	 * Parent constructor
	 * @param parent parent
	 * @param name name
	 */
	public MTableIndex(MTable parent, String name)
	{
		this(parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setAD_Table_ID(parent.getAD_Table_ID());
		setEntityType(parent.getEntityType());
		setName(name);
	}
	
	/** Lines				*/
	private MIndexColumn[] 	m_columns = null;
	
	/** Index Create DDL	*/
	private String			m_ddl = null;
	
	/**
	 * Get index columns
	 * @param reload reload data
	 * @return array of index column
	 */
	public MIndexColumn[] getColumns(boolean reload)
	{
		if (m_columns != null && !reload)
			return m_columns;
		
		Query query = new Query(getCtx(), MIndexColumn.Table_Name, MIndexColumn.COLUMNNAME_AD_TableIndex_ID + "=?", get_TrxName());
		query.setParameters(getAD_TableIndex_ID());
		query.setOrderBy(MIndexColumn.COLUMNNAME_SeqNo);
		List<MIndexColumn> list = query.<MIndexColumn>list();
		
		m_columns = new MIndexColumn[list.size()];
		list.toArray(m_columns);
		return m_columns;
	}
	
	/**
	 * Get table name
	 * @return table name
	 */
	public String getTableName()
	{
		int AD_Table_ID = getAD_Table_ID();
		return MTable.getTableName(getCtx(), AD_Table_ID);
	}
	
	/**
	 * Get SQL DDL
	 * @return DDL
	 */
	private String createDDL()
	{
		StringBuilder sql = null;
		if (!isCreateConstraint())
		{
			sql = new StringBuilder("CREATE ");
			if (isUnique())
				sql.append ("UNIQUE ");
			sql.append("INDEX ").append (getName())
				.append(" ON ").append(getTableName())
				.append(" (");
			//
			getColumns(false);
			for (int i = 0; i < m_columns.length; i++)
			{
				MIndexColumn ic = m_columns[i];
				if (i > 0)
					sql.append(",");
				sql.append (ic.getColumnName());
			}
			
			sql.append(")");
		}
		else if (isUnique())
		{
			sql = new StringBuilder("ALTER TABLE " + getTableName() + " ADD CONSTRAINT " + getName() + " UNIQUE (");
			getColumns(false);
			for (int i = 0; i < m_columns.length; i++)
			{
				MIndexColumn ic = m_columns[i];
				if (i > 0)
					sql.append(",");
				sql.append(ic.getColumnName());
			}
			
			sql.append(")");
		}
		else
		{
			String errMsg = Msg.getMsg(getCtx(), "NeitherTableIndexNorUniqueConstraint", new Object[] { getTableName() });
			log.severe(errMsg);
			throw new AdempiereException(errMsg);
		}
			
		return sql.toString();
	}
	
	/**
	 * Get SQL index create DDL
	 * @return SQL DDL
	 */
	public String getDDL()
	{
		if (m_ddl == null)
			m_ddl = createDDL();
		return m_ddl;
	}
	
	/**
	 * String representation
	 * @return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MTableIndex[");
		sb.append(get_ID()).append("-")
			.append(getName())
			.append(",AD_Table_ID=").append(getAD_Table_ID())
			.append("]");
		return sb.toString();
	}
}
