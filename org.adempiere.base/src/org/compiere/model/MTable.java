/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 * Contributor(s): Carlos Ruiz - globalqss                                    *
 *****************************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.IModelFactory;
import org.adempiere.base.Service;
import org.adempiere.model.GenericPO;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 *	Persistent Table Model
 * <p>
 * Change log:
 * <ul>
 * <li>2007-02-01 - teo_sarca - [ 1648850 ] MTable.getClass works incorrect for table "Fact_Acct"
 * </ul>
 * <ul>
 * <li>2007-08-30 - vpj-cd - [ 1784588 ] Use ModelPackage of EntityType to Find Model Class
 * </ul>
 *  @author Jorg Janke
 *  @author Teo Sarca, teo.sarca@gmail.com
 *  		<li>BF [ 3017117 ] MTable.getClass returns bad class
 *  			https://sourceforge.net/tracker/?func=detail&aid=3017117&group_id=176962&atid=879332
 *  @version $Id: MTable.java,v 1.3 2006/07/30 00:58:04 jjanke Exp $
 */
public class MTable extends X_AD_Table
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3743087295968040894L;

	public final static int MAX_OFFICIAL_ID = 999999;

	/**
	 * 	Get Table from Cache
	 *	@param ctx context
	 *	@param AD_Table_ID id
	 *	@return MTable
	 */
	public static MTable get (Properties ctx, int AD_Table_ID)
	{
		Integer key = Integer.valueOf(AD_Table_ID);
		MTable retValue = s_cache.get (key);
		if (retValue != null && retValue.getCtx() == ctx) {
			return retValue;
		}
		retValue = new MTable (ctx, AD_Table_ID, null);
		if (retValue.get_ID () != 0) {
			s_cache.put (key, retValue);
		}
		return retValue;
	}	//	get

	/**
	 * 	Get Table from Cache
	 *	@param ctx context
	 *	@param tableName case insensitive table name
	 *	@return Table
	 */
	public static MTable get (Properties ctx, String tableName)
	{
		if (tableName == null)
			return null;
		Iterator<MTable> it = s_cache.values().iterator();
		while (it.hasNext())
		{
			MTable retValue = it.next();
			if (tableName.equalsIgnoreCase(retValue.getTableName())
					&& retValue.getCtx() == ctx
				)
			{
				return retValue;
		}
		}
		//
		MTable retValue = null;
		String sql = "SELECT * FROM AD_Table WHERE UPPER(TableName)=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setString(1, tableName.toUpperCase());
			rs = pstmt.executeQuery ();
			if (rs.next())
				retValue = new MTable (ctx, rs, null);
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		if (retValue != null)
		{
			Integer key = Integer.valueOf(retValue.getAD_Table_ID());
			s_cache.put (key, retValue);
		}
		return retValue;
	}	//	get

	/**
	 * 	Get Table Name
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@return tavle name
	 */
	public static String getTableName (Properties ctx, int AD_Table_ID)
	{
		return MTable.get(ctx, AD_Table_ID).getTableName();
	}	//	getTableName


	/**	Cache						*/
	private static CCache<Integer,MTable> s_cache = new CCache<Integer,MTable>(Table_Name, 20);

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MTable.class);



	/**
	 * 	Get Persistence Class for Table
	 *	@param tableName table name
	 *	@return class or null
	 */
	public static Class<?> getClass (String tableName)
	{
		List<IModelFactory> factoryList = Service.locator().list(IModelFactory.class).getServices();
		if (factoryList == null)
			return null;
		for(IModelFactory factory : factoryList) {
			Class<?> clazz = factory.getClass(tableName);
			if (clazz != null)
				return clazz;
		}
		return null;
	}	//	getClass

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Table_ID id
	 *	@param trxName transaction
	 */
	public MTable (Properties ctx, int AD_Table_ID, String trxName)
	{
		super (ctx, AD_Table_ID, trxName);
		if (AD_Table_ID == 0)
		{
		//	setName (null);
		//	setTableName (null);
			setAccessLevel (ACCESSLEVEL_SystemOnly);	// 4
			setEntityType (ENTITYTYPE_UserMaintained);	// U
			setIsChangeLog (false);
			setIsDeleteable (false);
			setIsHighVolume (false);
			setIsSecurityEnabled (false);
			setIsView (false);	// N
			setReplicationType (REPLICATIONTYPE_Local);
		}
	}	//	MTable

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTable (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MTable

	/**	Columns				*/
	private MColumn[]	m_columns = null;
	/** column name to index map **/
	private Map<String, Integer> m_columnNameMap;
	/** ad_column_id to index map **/
	private Map<Integer, Integer> m_columnIdMap;

	/**
	 * 	Get Columns
	 *	@param requery requery
	 *	@return array of columns
	 */
	public synchronized MColumn[] getColumns (boolean requery)
	{
		if (m_columns != null && !requery)
			return m_columns;
		m_columnNameMap = new HashMap<String, Integer>();
		m_columnIdMap = new HashMap<Integer, Integer>();
		String sql = "SELECT * FROM AD_Column WHERE AD_Table_ID=? AND IsActive='Y' ORDER BY ColumnName";
		ArrayList<MColumn> list = new ArrayList<MColumn>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, getAD_Table_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ()) {
				MColumn column = new MColumn (getCtx(), rs, get_TrxName());
				list.add (column);
				m_columnNameMap.put(column.getColumnName().toUpperCase(), list.size() - 1);
				m_columnIdMap.put(column.getAD_Column_ID(), list.size() - 1);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		m_columns = new MColumn[list.size ()];
		list.toArray (m_columns);
		return m_columns;
	}	//	getColumns

	/**
	 * 	Get Column
	 *	@param columnName (case insensitive)
	 *	@return column if found
	 */
	public MColumn getColumn (String columnName)
	{
		if (columnName == null || columnName.length() == 0)
			return null;
		getColumns(false);
		//
		for (int i = 0; i < m_columns.length; i++)
		{
			if (columnName.equalsIgnoreCase(m_columns[i].getColumnName()))
				return m_columns[i];
		}
		return null;
	}	//	getColumn

	/**
	 *  Get Column Index
	 *  @param ColumnName column name
	 *  @return index of column with ColumnName or -1 if not found
	 */
	public synchronized int getColumnIndex (String ColumnName)
	{
		if (m_columns == null)
			getColumns(false);
		Integer i = m_columnNameMap.get(ColumnName.toUpperCase());
		if (i != null)
			return i.intValue();
		
		return -1;
	}   //  getColumnIndex

	/**
	 *  Get Column Index
	 *  @param AD_Column_ID column
	 *  @return index of column with ColumnName or -1 if not found
	 */
	public synchronized int getColumnIndex (int AD_Column_ID)
	{
		if (m_columns == null)
			getColumns(false);
		Integer i = m_columnIdMap.get(AD_Column_ID);
		if (i != null)
			return i.intValue();
		
		return -1;
	}   //  getColumnIndex
	
	/**
	 * 	Table has a single Key
	 *	@return true if table has single key column
	 */
	public boolean isSingleKey()
	{
		String[] keys = getKeyColumns();
		return keys.length == 1;
	}	//	isSingleKey

	/**
	 * 	Get Key Columns of Table
	 *	@return key columns
	 */
	public String[] getKeyColumns()
	{
		getColumns(false);
		ArrayList<String> list = new ArrayList<String>();
		//
		for (int i = 0; i < m_columns.length; i++)
		{
			MColumn column = m_columns[i];
			if (column.isKey())
				return new String[]{column.getColumnName()};
			if (column.isParent())
				list.add(column.getColumnName());
		}
		String[] retValue = new String[list.size()];
		retValue = list.toArray(retValue);
		return retValue;
	}	//	getKeyColumns
	
	/**
	 * 	Get Identifier Columns of Table
	 *	@return Identifier columns
	 */
	public String[] getIdentifierColumns()
	{
		getColumns(false);
		ArrayList<String> list = new ArrayList<String>();
		//
		for (int i = 0; i < m_columns.length; i++)
		{
			MColumn column = m_columns[i];
			if (column.isIdentifier())
				list.add(column.getColumnName());
		}
		String[] retValue = new String[list.size()];
		retValue = list.toArray(retValue);
		return retValue;
	}	//	getIdentifierColumns


	/**************************************************************************
	 * 	Get PO Class Instance
	 *	@param Record_ID record
	 *	@param trxName
	 *	@return PO for Record or null
	 */
	public PO getPO (int Record_ID, String trxName)
	{
		String tableName = getTableName();
		if (Record_ID != 0 && !isSingleKey())
		{
			log.log(Level.WARNING, "(id) - Multi-Key " + tableName);
			return null;
		}

		PO po = null;
		List<IModelFactory> factoryList = Service.locator().list(IModelFactory.class).getServices();
		if (factoryList != null)
		{
			for(IModelFactory factory : factoryList)
			{
				po = factory.getPO(tableName, Record_ID, trxName);
				if (po != null)
				{
					if (po.get_ID() != Record_ID && Record_ID > 0)
						po = null;
					else
						break;
				}
			}
		}

		if (po == null)
		{
			po = new GenericPO(tableName, getCtx(), Record_ID, trxName);
			if (po.get_ID() != Record_ID && Record_ID > 0)
				po = null;
		}

		return po;
	}	//	getPO

	/**
	 * 	Get PO Class Instance
	 *	@param rs result set
	 *	@param trxName transaction
	 *	@return PO for Record or null
	 */
	public PO getPO (ResultSet rs, String trxName)
	{
		String tableName = getTableName();

		PO po = null;
		List<IModelFactory> factoryList = Service.locator().list(IModelFactory.class).getServices();
		if (factoryList != null)
		{
			for(IModelFactory factory : factoryList) {
				po = factory.getPO(tableName, rs, trxName);
				if (po != null)
					break;
			}
		}

		if (po == null)
		{
			po = new GenericPO(tableName, getCtx(), rs, trxName);
		}

		return po;
	}	//	getPO

	/**
	 * 	Get PO Class Instance
	 *	@param whereClause where clause
	 *	@param trxName transaction
	 *	@return PO for Record or null
	 */
	public PO getPO (String whereClause, String trxName)
	{
		return getPO(whereClause, null, trxName);
	}	//	getPO

	/**
	 * Get PO class instance
	 * @param whereClause
	 * @param params
	 * @param trxName
	 * @return
	 */
	public PO getPO(String whereClause, Object[] params, String trxName)
	{
		if (whereClause == null || whereClause.length() == 0)
			return null;
		//
		PO po = null;
		POInfo info = POInfo.getPOInfo(getCtx(), getAD_Table_ID(), trxName);
		if (info == null) return null;
		StringBuilder sqlBuffer = info.buildSelect();
		sqlBuffer.append(" WHERE ").append(whereClause);
		String sql = sqlBuffer.toString();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			if (params != null && params.length > 0)
			{
				for (int i = 0; i < params.length; i++)
				{
					pstmt.setObject(i+1, params[i]);
				}
			}
			rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				po = getPO(rs, trxName);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
			log.saveError("Error", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		return po;
	}

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (isView() && isDeleteable())
			setIsDeleteable(false);
		//
		return true;
	}	//	beforeSave

	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		//	Sync Table ID
		MSequence seq = MSequence.get(getCtx(), getTableName(), get_TrxName());
		if (seq == null || seq.get_ID() == 0)
			MSequence.createTableSequence(getCtx(), getTableName(), get_TrxName());
		else if (!seq.getName().equals(getTableName()))
		{
			seq.setName(getTableName());
			seq.saveEx();
		}
		
		return success;
	}	//	afterSave

	/**
	 * 	Get SQL Create
	 *	@return create table DDL
	 */
	public String getSQLCreate()
	{
		StringBuffer sb = new StringBuffer("CREATE TABLE ")
			.append(getTableName()).append(" (");
		//
		boolean hasPK = false;
		boolean hasParents = false;
		StringBuffer constraints = new StringBuffer();
		getColumns(true);
		for (int i = 0; i < m_columns.length; i++)
		{
			MColumn column = m_columns[i];
			String colSQL = column.getSQLDDL();
			if ( colSQL != null )
			{
				if (i > 0)
					sb.append(", ");
					sb.append(column.getSQLDDL());
			}
			else // virtual column
				continue;
			//
			if (column.isKey())
				hasPK = true;
			if (column.isParent())
				hasParents = true;
			String constraint = column.getConstraint(getTableName());
			if (constraint != null && constraint.length() > 0)
				constraints.append(", ").append(constraint);
		}
		//	Multi Column PK
		if (!hasPK && hasParents)
		{
			StringBuffer cols = new StringBuffer();
			for (int i = 0; i < m_columns.length; i++)
			{
				MColumn column = m_columns[i];
				if (!column.isParent())
					continue;
				if (cols.length() > 0)
					cols.append(", ");
				cols.append(column.getColumnName());
			}
			sb.append(", CONSTRAINT ")
				.append(getTableName()).append("_Key PRIMARY KEY (")
				.append(cols).append(")");
		}

		sb.append(constraints)
			.append(")");
		return sb.toString();
	}	//	getSQLCreate

	// globalqss
	/**
	 * 	Grant independence to GenerateModel from AD_Table_ID
	 *	@param String tableName
	 *	@return int retValue
	 */
	public static int getTable_ID(String tableName) {
		int retValue = 0;
		String SQL = "SELECT AD_Table_ID FROM AD_Table WHERE tablename = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			pstmt.setString(1, tableName);
			rs = pstmt.executeQuery();
			if (rs.next())
				retValue = rs.getInt(1);
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, SQL, e);
			retValue = -1;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return retValue;
	}

	/**
	 * Create query to retrieve one or more PO.
	 * @param whereClause
	 * @param trxName
	 * @return Query
	 */
	public Query createQuery(String whereClause, String trxName)
	{
		return new Query(this.getCtx(), this, whereClause, trxName);
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MTable[");
		sb.append (get_ID()).append ("-").append (getTableName()).append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Verify if the table contains ID=0
	 *	@return true if table has zero ID
	 */
	public static boolean isZeroIDTable(String tablename) {
		return (tablename.equals("AD_Org") ||
				tablename.equals("AD_OrgInfo") ||
				tablename.equals("AD_Client") || // IDEMPIERE-668
				tablename.equals("AD_ReportView") ||
				tablename.equals("AD_Role") ||
				tablename.equals("AD_System") ||
				tablename.equals("AD_User") ||
				tablename.equals("C_DocType") ||
				tablename.equals("GL_Category") ||
				tablename.equals("M_AttributeSet") ||
				tablename.equals("M_AttributeSetInstance"));
	}

}	//	MTable