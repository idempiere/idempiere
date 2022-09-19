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
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.IModelFactory;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.model.GenericPO;
import org.compiere.db.AdempiereDatabase;
import org.compiere.db.Database;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

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
 *  			https://sourceforge.net/p/adempiere/bugs/2433/
 *  @version $Id: MTable.java,v 1.3 2006/07/30 00:58:04 jjanke Exp $
 */
public class MTable extends X_AD_Table implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7981455044208282721L;

	public final static int MAX_OFFICIAL_ID = 999999;

	/**
	 * 	Get Table from Cache (immutable)
	 *	@param AD_Table_ID id
	 *	@return MTable
	 */
	public static MTable get (int AD_Table_ID)
	{
		return get(Env.getCtx(), AD_Table_ID);
	}
	
	/** 
	 * 	Get Table from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Table_ID id
	 *	@return MTable
	 */
	public static MTable get (Properties ctx, int AD_Table_ID)
	{
		return get(ctx, AD_Table_ID, null);
	}	//	get

	/**
	 * 	Get Table from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Table_ID id
	 *	@param trxName transaction
	 *	@return MTable
	 */
	public static synchronized MTable get (Properties ctx, int AD_Table_ID, String trxName)
	{
		Integer key = Integer.valueOf(AD_Table_ID);
		MTable retValue = s_cache.get (ctx, key, e -> new MTable(ctx, e));
		if (retValue != null) 
			return retValue;
		
		retValue = new MTable (ctx, AD_Table_ID, trxName);
		if (retValue.get_ID () == AD_Table_ID) 
		{
			s_cache.put (key, retValue, e -> new MTable(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MTable from cache
	 * @param ctx
	 * @param AD_Table_ID
	 * @param trxName
	 * @return MTable
	 */
	public static MTable getCopy(Properties ctx, int AD_Table_ID, String trxName)
	{
		MTable table = get(ctx, AD_Table_ID, trxName);
		if (table != null)
			table = new MTable(ctx, table, trxName);
		return table;
	}
	
	/**
	 * 	Get Table from Cache
	 *	@param ctx context
	 *	@param tableName case insensitive table name
	 *	@return Table
	 */
	public static synchronized MTable get (Properties ctx, String tableName)
	{
		return get(ctx, tableName, null);
	}	//	get
	
	/**
	 * 	Get Table from Cache
	 *	@param ctx context
	 *	@param tableName case insensitive table name
	 *	@return Table
	 */
	public static synchronized MTable get (Properties ctx, String tableName, String trxName)
	{
		if (tableName == null)
			return null;
		MTable[] tables = s_cache.values().toArray(new MTable[0]);
		for (MTable retValue : tables)
		{
			if (tableName.equalsIgnoreCase(retValue.getTableName()))
			{
				return s_cache.get (ctx, retValue.get_ID(), e -> new MTable(ctx, e));
			}
		}
		//
		MTable retValue = null;
		String sql = "SELECT * FROM AD_Table WHERE UPPER(TableName)=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setString(1, tableName.toUpperCase());
			rs = pstmt.executeQuery ();
			if (rs.next())
				retValue = new MTable (ctx, rs, trxName);
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
			s_cache.put (key, retValue, e -> new MTable(Env.getCtx(), e));
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
	private static ImmutableIntPOCache<Integer,MTable> s_cache = new ImmutableIntPOCache<Integer,MTable>(Table_Name, 20);

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MTable.class);

	private static final CCache<String, IServiceReferenceHolder<IModelFactory>> s_modelFactoryCache = new CCache<>(null, "IModelFactory", 100, 120, false, 2000);

	/**
	 * 	Get Persistence Class for Table
	 *	@param tableName table name
	 *	@return class or null
	 */
	public static Class<?> getClass (String tableName)
	{
		IServiceReferenceHolder<IModelFactory> cache = s_modelFactoryCache.get(tableName);
		if (cache != null)
		{
			IModelFactory service = cache.getService();
			if (service != null)
			{
				Class<?> clazz = service.getClass(tableName);
				if (clazz != null)
					return clazz;
			}
			s_modelFactoryCache.remove(tableName);
		}
		
		List<IServiceReferenceHolder<IModelFactory>> factoryList = Service.locator().list(IModelFactory.class).getServiceReferences();
		if (factoryList == null)
			return null;
		for(IServiceReferenceHolder<IModelFactory> factory : factoryList) {
			IModelFactory service = factory.getService();
			if (service != null) {
				Class<?> clazz = service.getClass(tableName);
				if (clazz != null)
				{
					s_modelFactoryCache.put(tableName, factory);
					return clazz;
				}
			}
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

	/**
	 * 
	 * @param copy
	 */
	public MTable(MTable copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MTable(Properties ctx, MTable copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MTable(Properties ctx, MTable copy, String trxName) 
	{
		//-1 to avoid infinite loop
		this(ctx, -1, trxName);
		copyPO(copy);
		this.m_columns = copy.m_columns != null ? Arrays.stream(copy.m_columns).map(e -> {return new MColumn(ctx, e, trxName);}).toArray(MColumn[]::new): null;
		this.m_columnNameMap = copy.m_columnNameMap != null ? new HashMap<String, Integer>(copy.m_columnNameMap) : null;
		this.m_columnIdMap = copy.m_columnIdMap != null ? new HashMap<Integer, Integer>(copy.m_columnIdMap) : null;
		this.m_viewComponents = copy.m_viewComponents != null ? Arrays.stream(copy.m_viewComponents).map(e -> {return new MViewComponent(ctx, e, trxName);}).toArray(MViewComponent[]::new) : null;
	}


	/**	Columns				*/
	private MColumn[]	m_columns = null;
	/** column name to index map **/
	private Map<String, Integer> m_columnNameMap;
	/** ad_column_id to index map **/
	private Map<Integer, Integer> m_columnIdMap;
	/** View Components		*/
	private MViewComponent[]	m_viewComponents = null;

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
				if (is_Immutable())
					column.markImmutable();
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
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
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
		int idx = getColumnIndex(columnName);
		if (idx < 0)
			return null;
		return m_columns[idx];
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
	 *  Column exists and is not virtual?
	 *  @param ColumnName column name
	 *  @return boolean - true indicating that the column exists in the table and is not virtual
	 */
	public synchronized boolean columnExistsInDB (String ColumnName)
	{
		MColumn column = getColumn(ColumnName);
		return column != null && ! column.isVirtualColumn();
	}   //  columnExistsInDB

	/**
	 *  Column exists?
	 *  @param ColumnName column name
	 *  @return boolean - true indicating that the column exists in dictionary
	 */
	public synchronized boolean columnExistsInDictionary (String ColumnName)
	{
		return getColumnIndex(ColumnName) >= 0;
	}   //  columnExistsInDictionary

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
	public String[] getIdentifierColumns() {
		ArrayList<KeyNamePair> listkn = new ArrayList<KeyNamePair>();
		for (MColumn column : getColumns(false)) {
			if (column.isIdentifier())
				listkn.add(new KeyNamePair(column.getSeqNo(), column.getColumnName()));
		}
		// Order by SeqNo
		Collections.sort(listkn, new Comparator<KeyNamePair>(){
			public int compare(KeyNamePair s1,KeyNamePair s2){
				if (s1.getKey() < s2.getKey())
					return -1;
				else if (s1.getKey() > s2.getKey())
					return 1;
				else
					return 0;
			}});
		String[] retValue = new String[listkn.size()];
		for (int i = 0; i < listkn.size(); i++) {
			retValue[i] = listkn.get(i).getName();
		}
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
		IServiceReferenceHolder<IModelFactory> cache = s_modelFactoryCache.get(tableName);
		if (cache != null)
		{
			IModelFactory service = cache.getService();
			if (service != null)
			{
				po = service.getPO(tableName, Record_ID, trxName);
				if (po != null)
				{
					if (po.get_ID() != Record_ID && Record_ID > 0)
						po = null;
					else
						return po;
				}
			}
			s_modelFactoryCache.remove(tableName);
		}
		
		List<IServiceReferenceHolder<IModelFactory>> factoryList = Service.locator().list(IModelFactory.class).getServiceReferences();
		if (factoryList != null)
		{
			for(IServiceReferenceHolder<IModelFactory> factory : factoryList)
			{
				IModelFactory service = factory.getService();
				if (service != null)
				{
					po = service.getPO(tableName, Record_ID, trxName);
					if (po != null)
					{
						if (po.get_ID() != Record_ID && Record_ID > 0)
							po = null;
						else
						{
							s_modelFactoryCache.put(tableName, factory);
							break;
						}
					}
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
		IServiceReferenceHolder<IModelFactory> cache = s_modelFactoryCache.get(tableName);
		if (cache != null)
		{
			IModelFactory service = cache.getService();
			if (service != null)
			{
				po = service.getPO(tableName, rs, trxName);
				if (po != null)
					return po;
			}
			s_modelFactoryCache.remove(tableName);
		}
		List<IServiceReferenceHolder<IModelFactory>> factoryList = Service.locator().list(IModelFactory.class).getServiceReferences();
		if (factoryList != null)
		{
			for(IServiceReferenceHolder<IModelFactory> factory : factoryList) {
				IModelFactory service = factory.getService();
				if (service != null)
				{
					po = service.getPO(tableName, rs, trxName);
					if (po != null)
					{
						s_modelFactoryCache.put(tableName, factory);
						break;
					}
				}
			}
		}

		if (po == null)
		{
			po = new GenericPO(tableName, getCtx(), rs, trxName);
		}

		return po;
	}	//	getPO

	/**
	 * Get PO Class Instance
	 * 
	 * @param  uuID    UUID
	 * @param  trxName transaction
	 * @return         PO for Record
	 */
	public PO getPOByUU (String uuID, String trxName)
	{
		PO po = getPO(0, trxName);
		po.loadByUU(uuID, trxName);

		return po;
	} // getPOByUU

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
		String error = Database.isValidIdentifier(getTableName());
		if (!Util.isEmpty(error)) {
			log.saveError("Error", Msg.getMsg(getCtx(), error) + " [TableName]");
			return false;
		}
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
		if (!success)
			return success;
		//	Sync Table ID
		if(!isView()) {
			MSequence seq = MSequence.get(getCtx(), getTableName(), get_TrxName());
			if (seq == null || seq.get_ID() == 0)
				MSequence.createTableSequence(getCtx(), getTableName(), get_TrxName());
			else if (!seq.getName().equals(getTableName()))
			{
				seq.setName(getTableName());
				seq.saveEx();
			}
		}
		if (newRecord || is_ValueChanged(COLUMNNAME_IsChangeLog)) {
			MChangeLog.resetLoggedList();
		}
		
		return success;
	}	//	afterSave

	/**
	 * 	Get SQL Create
	 *	@return create table DDL
	 */
	public String getSQLCreate()
	{
		AdempiereDatabase db = DB.getDatabase();
		if (db.isNativeMode())
			return db.getSQLCreate(this);
		else
			return Database.getDatabase(Database.DB_ORACLE).getSQLCreate(this);
	}	//	getSQLCreate

	// globalqss
	public static int getTable_ID(String tableName) {
		return getTable_ID(tableName, null);
	}
	/**
	 * 	Grant independence to GenerateModel from AD_Table_ID
	 *	@param tableName String
	 *  @param trxName
	 *	@return int retValue
	 */
	public static int getTable_ID(String tableName, String trxName) {
		MTable table = get(Env.getCtx(), tableName, trxName);
		return table != null ? table.getAD_Table_ID() : 0;
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
	 * 	Get view components
	 *  @param reload reload data
	 *	@return array of view component
	 */
	public MViewComponent[] getViewComponent(boolean reload)
	{
		if (!isView() || !isActive())
			return null;
		
		if (m_viewComponents != null && !reload)
			return m_viewComponents;
		
		Query query = new Query(getCtx(), MViewComponent.Table_Name, MViewComponent.COLUMNNAME_AD_Table_ID + "=?", get_TrxName());
		query.setParameters(getAD_Table_ID());
		query.setOrderBy(MViewComponent.COLUMNNAME_SeqNo);
		query.setOnlyActiveRecords(true);
		List<MViewComponent> list = query.list();
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		
		m_viewComponents = new MViewComponent[list.size()];
		list.toArray(m_viewComponents);
		return m_viewComponents;
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
				tablename.equals("AD_AllClients_V") ||
				tablename.equals("AD_ReportView") ||
				tablename.equals("AD_Role") ||
				tablename.equals("AD_AllRoles_V") ||
				tablename.equals("AD_System") ||
				tablename.equals("AD_User") ||
				tablename.equals("AD_AllUsers_V") ||
				tablename.equals("C_DocType") ||
				tablename.equals("GL_Category") ||
				tablename.equals("M_AttributeSet") ||
				tablename.equals("M_AttributeSetInstance"));
	}

	@Override
	public MTable markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_columns != null && m_columns.length > 0)
			Arrays.stream(m_columns).forEach(e -> e.markImmutable());
		if (m_viewComponents != null && m_viewComponents.length > 0)
			Arrays.stream(m_viewComponents).forEach(e -> e.markImmutable());
		return this;
	}

	
}	//	MTable
