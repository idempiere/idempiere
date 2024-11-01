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
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.logging.Level;

import org.adempiere.base.IModelFactory;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.model.GenericPO;
import org.compiere.db.AdempiereDatabase;
import org.compiere.db.Database;
import org.compiere.db.partition.ITablePartitionService;
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
	private static final long serialVersionUID = 6774131577483620665L;

	public final static int MAX_OFFICIAL_ID = 999999;

	/**
	 * 	Get MTable from Cache (immutable)
	 *	@param AD_Table_ID id
	 *	@return MTable
	 */
	public static MTable get (int AD_Table_ID)
	{
		return get(Env.getCtx(), AD_Table_ID);
	}
	
	/** 
	 * 	Get MTable from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Table_ID id
	 *	@return MTable
	 */
	public static MTable get (Properties ctx, int AD_Table_ID)
	{
		return get(ctx, AD_Table_ID, null);
	}	//	get

	/**
	 * 	Get MTable from Cache (immutable)
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
	 * 	Get MTable from Cache
	 *	@param ctx context
	 *	@param tableName case insensitive table name
	 *	@return MTable
	 */
	public static synchronized MTable get (Properties ctx, String tableName)
	{
		return get(ctx, tableName, null);
	}	//	get
	
	/**
	 * 	Get MTable from Cache
	 *	@param ctx context
	 *	@param tableName case insensitive table name
	 *  @param trxName
	 *	@return MTable
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
	 *	@return table name
	 */
	public static String getTableName (Properties ctx, int AD_Table_ID)
	{
		return MTable.get(ctx, AD_Table_ID).getTableName();
	}	//	getTableName

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MTable> s_cache = new ImmutableIntPOCache<Integer,MTable>(Table_Name, Table_Name, 20, 0, false, 0);

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MTable.class);

	private static final CCache<String, IServiceReferenceHolder<IModelFactory>> s_modelFactoryCache = new CCache<>(null, "IModelFactory", 100, 120, false, 2000);

	/**
	 * 	Get Java Model Class for Table
	 *	@param tableName table name
	 *	@return Java model class or null
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

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Table_UU  UUID key
     * @param trxName Transaction
     */
    public MTable(Properties ctx, String AD_Table_UU, String trxName) {
        super(ctx, AD_Table_UU, trxName);
		if (Util.isEmpty(AD_Table_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Table_ID id
	 *	@param trxName transaction
	 */
	public MTable (Properties ctx, int AD_Table_ID, String trxName)
	{
		super (ctx, AD_Table_ID, trxName);
		if (AD_Table_ID == 0)
			setInitialDefaults();
	}	//	MTable

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setAccessLevel (ACCESSLEVEL_SystemOnly);	// 4
		setEntityType (ENTITYTYPE_UserMaintained);	// U
		setIsChangeLog (false);
		setIsDeleteable (false);
		setIsHighVolume (false);
		setIsSecurityEnabled (false);
		setIsView (false);	// N
		setReplicationType (REPLICATIONTYPE_Local);
	}

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
	 * Copy constructor
	 * @param copy
	 */
	public MTable(MTable copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MTable(Properties ctx, MTable copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
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
		this.m_columnNameMap = copy.m_columnNameMap != null ? new ConcurrentHashMap<String, Integer>(copy.m_columnNameMap) : null;
		this.m_columnIdMap = copy.m_columnIdMap != null ? new ConcurrentHashMap<Integer, Integer>(copy.m_columnIdMap) : null;
		this.m_viewComponents = copy.m_viewComponents != null ? Arrays.stream(copy.m_viewComponents).map(e -> {return new MViewComponent(ctx, e, trxName);}).toArray(MViewComponent[]::new) : null;
	}

	/**	Columns				*/
	private MColumn[]	m_columns = null;
	/** Key Columns					*/
	private String[]	m_KeyColumns = null;
	/** column name to column index map **/
	private ConcurrentMap<String, Integer> m_columnNameMap;
	/** ad_column_id to column index map **/
	private ConcurrentMap<Integer, Integer> m_columnIdMap;
	/** View Components		*/
	private MViewComponent[]	m_viewComponents = null;

	/**
	 * 	Get Columns
	 *	@param requery true to re-query from DB
	 *	@return array of column
	 */
	public synchronized MColumn[] getColumns (boolean requery)
	{
		if (m_columns != null && !requery)
			return m_columns;
		m_columnNameMap = new ConcurrentHashMap<String, Integer>();
		m_columnIdMap = new ConcurrentHashMap<Integer, Integer>();
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
	 * 	Get Column via column name
	 *	@param columnName (case insensitive)
	 *	@return MColumn if found, null otherwise
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
	 *  Get Column Index via column name
	 *  @param ColumnName column name (case insensitive)
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
	 *  Is column exists and is not virtual ?
	 *  @param ColumnName column name (case insensitive)
	 *  @return true if column exists and is not virtual
	 */
	public synchronized boolean columnExistsInDB (String ColumnName)
	{
		MColumn column = getColumn(ColumnName);
		return column != null && ! column.isVirtualColumn();
	}   //  columnExistsInDB

	/**
	 *  Column exists?
	 *  @param ColumnName column name (case insensitive)
	 *  @return true if column exists in dictionary
	 */
	public synchronized boolean columnExistsInDictionary (String ColumnName)
	{
		return getColumnIndex(ColumnName) >= 0;
	}   //  columnExistsInDictionary

	/**
	 *  Get Column Index
	 *  @param AD_Column_ID column id
	 *  @return index of column with AD_Column_ID or -1 if not found
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
	 * 	Table is with single primary key
	 *	@return true if table has single primary key column
	 */
	public boolean isSingleKey()
	{
		String[] keys = getKeyColumns();
		return keys.length == 1;
	}	//	isSingleKey

	/**
	 * 	Get Key Columns of Table
	 *	@return array of key column name
	 */
	public String[] getKeyColumns()
	{
		if (m_KeyColumns != null)
			return m_KeyColumns;
		getColumns(false);
		ArrayList<String> list = new ArrayList<String>();
		//
		for (int i = 0; i < m_columns.length; i++)
		{
			MColumn column = m_columns[i];
			if (column.isKey()) {
				m_KeyColumns = new String[]{column.getColumnName()};
				return m_KeyColumns;
			}
			if (column.isParent())
				list.add(column.getColumnName());
		}
		//check uuid key
		if (list.isEmpty()) {
			MColumn uuColumn = getColumn(PO.getUUIDColumnName(getTableName()));
			if (uuColumn != null) {
				m_KeyColumns = new String[]{uuColumn.getColumnName()};
				return m_KeyColumns;
			}
		}
		String[] retValue = new String[list.size()];
		retValue = list.toArray(retValue);
		m_KeyColumns = retValue;
		return m_KeyColumns;
	}	//	getKeyColumns
	
	/**
	 * @return true if table has single key column and the key column name is the same as the table name plus _ID.
	 */
	public boolean isIDKeyTable()
	{
		String idColName = getTableName() + "_ID";
		return (getKeyColumns() != null && getKeyColumns().length == 1 && getKeyColumns()[0].equals(idColName));
	}

	/**
	 * @return true if table has single key column and the key column name ends with _UU.
	 */
	public boolean isUUIDKeyTable()
	{
		String uuColName = PO.getUUIDColumnName(getTableName());
		return (getKeyColumns() != null && getKeyColumns().length == 1 && getKeyColumns()[0].equals(uuColName));
	}
	
	/**
	 * @return true if table has a UUID column (column name ends with _UU)
	 */
	public boolean hasUUIDKey()
	{
		String uuColName = PO.getUUIDColumnName(getTableName());
		if (m_columns == null)
			getColumns(false);
		return m_columnNameMap.get(uuColName.toUpperCase()) != null;
	}

	/**
	 * 	Get Identifier Columns of Table (IsIdentifier=Y)
	 *	@return array of identifier column name
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

	/**
	 * 	Get PO Instance for this table
	 *	@param Record_ID record id. 0 to create new record instance, > 0 to load existing record instance.
	 *	@param trxName
	 *	@return PO for Record_ID or null
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
						s_modelFactoryCache.put(tableName, factory);
						break;
					}
				}
			}
		}

		if (po == null && s_modelFactoryCache.get(tableName) == null)
		{
			po = new GenericPO(tableName, getCtx(), Record_ID, trxName);
			if (po.get_ID() != Record_ID && Record_ID > 0)
				po = null;
			// TODO: how to add GenericPO to the s_modelFactoryCache ??
		}

		return po;
	}	//	getPO

	private static final ThreadLocal<Map<Integer, String[]>> partialPOResultSetColumns = new ThreadLocal<>();
	
	/**
	 * Get columns included in result set of {@link #getPO(int, String)} call.<br/>
	 * Use by {@link #getPartialPO(ResultSet, String[], String)}.
	 * @param rs result set
	 * @return columns included in result set of {@link #getPO(int, String)} call
	 */
	protected static final String[] getPartialPOResultSetColumns(ResultSet rs) {
		Map<Integer, String[]> map = partialPOResultSetColumns.get();
		return map != null ? map.get(rs.hashCode()) : null;
	}
	
	/**
	 * 	Get PO Instance from result set that only include some of the columns of the PO model.
	 *	@param rs result set
	 *  @param selectColumns 
	 *	@param trxName transaction
	 *	@return immutable PO instance
	 */
	public final PO getPartialPO (ResultSet rs, String[] selectColumns, String trxName)
	{
		try {
			HashMap<Integer, String[]> map = new HashMap<Integer, String[]>();
			map.put(rs.hashCode(), selectColumns);
			partialPOResultSetColumns.set(map);
			PO po = getPO(rs, trxName);
			po.makeImmutable();
			return po;
		} finally {
			partialPOResultSetColumns.remove();
		}
	}
	
	/**
	 * 	Get PO Instance from result set
	 *	@param rs result set
	 *	@param trxName transaction
	 *	@return PO instance
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
	 * Get PO Instance
	 * 
	 * @param  uuID  UUID. Throw IllegalArgumentException if this is null or empty string.
	 * @param  trxName transaction
	 * @return PO for uuID
	 */
	public PO getPOByUU (String uuID, String trxName)
	{
		PO po = getPO(0, trxName);
		po.loadByUU(uuID, trxName);

		return po;
	} // getPOByUU

	/**
	 * 	Get PO Instance
	 *	@param whereClause SQL where clause
	 *	@param trxName transaction
	 *	@return PO for whereClause or null
	 */
	public PO getPO (String whereClause, String trxName)
	{
		return getPO(whereClause, null, trxName);
	}	//	getPO

	/**
	 * Get PO instance
	 * @param whereClause SQL where clause
	 * @param params parameters for whereClause
	 * @param trxName
	 * @return PO instance or null
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

	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (isView() && isDeleteable())
			setIsDeleteable(false);
		// Validate table name is valid DB identifier
		String error = Database.isValidIdentifier(getTableName());
		if (!Util.isEmpty(error)) {
			log.saveError("Error", Msg.getMsg(getCtx(), error) + " [TableName]");
			return false;
		}
				
		// Validate table partition configuration
		if (is_ValueChanged(COLUMNNAME_IsPartition)) {
			ITablePartitionService service = DB.getDatabase().getTablePartitionService();
			if (service == null) {
				log.saveError("Error", Msg.getMsg(getCtx(), "DBAdapterNoTablePartitionSupport"));
				return false;
			}
			error = service.isValidConfiguration(this);
			if (!Util.isEmpty(error)) {
				log.saveError("Error", Msg.getMsg(getCtx(), error));
				return false;				
			}
		}
		
		return true;
	}	//	beforeSave

	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if(!isView()) {
			// Create or update table sequence
			MSequence seq = MSequence.get(getCtx(), getTableName(), get_TrxName());
			if (seq == null || seq.get_ID() == 0)
				MSequence.createTableSequence(getCtx(), getTableName(), get_TrxName());
			else if (!seq.getName().equals(getTableName()))
			{
				seq.setName(getTableName());
				seq.saveEx();
			}
		}
		// Reset logged table list
		if (newRecord || is_ValueChanged(COLUMNNAME_IsChangeLog)) {
			MChangeLog.resetLoggedList();
		}
		
		return success;
	}	//	afterSave

	/**
	 * 	Get Create table DDL
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

	/**
	 * Get AD_Table_ID via table name
	 * @param tableName
	 * @return AD_Table_ID
	 */
	public static int getTable_ID(String tableName) {
		return getTable_ID(tableName, null);
	}
	
	/**
	 * 	Get AD_Table_ID via table name
	 *	@param tableName String
	 *  @param trxName
	 *	@return AD_Table_ID
	 */
	public static int getTable_ID(String tableName, String trxName) {
		MTable table = get(Env.getCtx(), tableName, trxName);
		return table != null ? table.getAD_Table_ID() : 0;
	}

	/**
	 * Create new query for whereClause
	 * @param whereClause SQL whereClause
	 * @param trxName
	 * @return new Query instance
	 */
	public Query createQuery(String whereClause, String trxName)
	{
		return new Query(this.getCtx(), this, whereClause, trxName);
	}
	
	/**
	 * 	Get active view components
	 *  @param reload true to reload from DB
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
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MTable[");
		sb.append (get_ID()).append ("-").append (getTableName()).append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Verify if the table has record with ID=0
	 *	@return true if table has record with ID=0
	 */
	public static boolean isZeroIDTable(String tablename) {
		return (tablename.equals("AD_Org") ||
				tablename.equals("AD_OrgInfo") ||
				tablename.equals("AD_Client") || // IDEMPIERE-668
				tablename.equals("AD_ClientInfo") ||
				tablename.equals("AD_AllClients_V") ||
				tablename.equals("AD_ReportView") ||
				tablename.equals("AD_Role") ||
				tablename.equals("AD_AllRoles_V") ||
				tablename.equals("AD_System") ||
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

	/**
	 * Get first AD_Window that's using this table from AD_Menu.
	 * @return AD_Window_ID or -1 if not found
	 */
	public int getWindowIDFromMenu() {
		return DB.getSQLValueEx(null, "SELECT a.AD_Window_ID FROM AD_Window a "
				+ "INNER JOIN AD_Tab b ON (a.AD_Window_ID=b.AD_Window_ID) "
				+ "INNER JOIN AD_Menu m ON (a.AD_Window_ID=m.AD_Window_ID AND m.IsActive='Y' AND m.Action='W') "
				+ "WHERE a.IsActive='Y' AND b.IsActive='Y' AND b.AD_Table_ID=? ORDER BY b.TabLevel, a.AD_Window_ID", getAD_Table_ID());
	}

	/**
	 * Get the UUID of Zero ID record
	 * @return UUID or null
	 */
	public String getUUIDFromZeroID() {
		if (! MTable.isZeroIDTable(getTableName()))
			return null;
		StringBuilder sqluu = new StringBuilder()
				.append("SELECT ")
				.append(PO.getUUIDColumnName(getTableName()))
				.append(" FROM ")
				.append(getTableName())
				.append(" WHERE ")
				.append(getKeyColumns()[0])
				.append("=0");
		String uuidFromZeroID = DB.getSQLValueStringEx(get_TrxName(), sqluu.toString());
		return uuidFromZeroID;
	}

	private List<MColumn> partitionKeyColumns;
	private List<String> partitionKeyColumnNames;
	
	/**
	 * @param requery true to reload from DB
	 * @return partition key columns
	 */
	public List<MColumn> getPartitionKeyColumns(boolean requery)
	{
		if (partitionKeyColumns != null && !requery)
			return partitionKeyColumns;
		
		partitionKeyColumnNames = null;
		
		String whereClause = MColumn.COLUMNNAME_AD_Table_ID + "=? AND " + MColumn.COLUMNNAME_IsPartitionKey + "='Y'";
		partitionKeyColumns = new Query(getCtx(), MColumn.Table_Name, whereClause, null)
				.setParameters(getAD_Table_ID())
				.setOnlyActiveRecords(true)
				.setOrderBy(MColumn.COLUMNNAME_SeqNoPartition)
				.list();
		return partitionKeyColumns;
	}
	
	/**
	 * Update {@link #partitionKeyColumnNames} and {@link #partitionKeyColumnNamesAsString}
	 */
	private void populatePartitionKeyColumnNames()
	{
		List<MColumn> keyColumns = getPartitionKeyColumns(false);
		partitionKeyColumnNames = new ArrayList<String>();
		StringBuilder keyColumnsString = new StringBuilder();
		int columnCount = 0;
		for (MColumn keyColumn : keyColumns) 
		{
			if (columnCount > 0)
				keyColumnsString.append(",");
			keyColumnsString.append(keyColumn.getColumnName());			
			partitionKeyColumnNames.add(keyColumn.getColumnName());
			++columnCount;
		}
	}
	
	/**
	 * @return partition key column names
	 */
	public List<String> getPartitionKeyColumnNames()
	{
		if (partitionKeyColumnNames != null)
			return partitionKeyColumnNames;
		
		populatePartitionKeyColumnNames();
		return partitionKeyColumnNames;
	}
	
	/**
	 * Create and save new X_AD_TablePartition record.
	 * @param name
	 * @param expression
	 * @param trxName
	 * @param column
	 * @return new X_AD_TablePartition record
	 */
	public X_AD_TablePartition createTablePartition(String name, String expression, String trxName, MColumn column)
	{
		return createTablePartition(name, expression, trxName, column, null);
	}
	
	/**
	 * Create and save new X_AD_TablePartition record.
	 * @param name
	 * @param expression
	 * @param trxName
	 * @param column
	 * @param parentPartition
	 * @return new X_AD_TablePartition record
	 */
	public X_AD_TablePartition createTablePartition(String name, String expression, String trxName, MColumn column, X_AD_TablePartition parentPartition)
	{
		X_AD_TablePartition partition = new X_AD_TablePartition(Env.getCtx(), 0, trxName);
		partition.setAD_Table_ID(getAD_Table_ID());
		partition.setName(name);
		partition.setExpressionPartition(expression);
		partition.setAD_Column_ID(column.getAD_Column_ID());
		if (parentPartition != null)
			partition.setParent_TablePartition_ID(parentPartition.getAD_TablePartition_ID());
		partition.saveEx();
		return partition;
	}
	
	private List<X_AD_TablePartition> tablePartitions;
	private List<String> tablePartitionNames;
	
	/**
	 * @param requery true to reload from DB
	 * @param trxName
	 * @return X_AD_TablePartition records of this table
	 */
	public List<X_AD_TablePartition> getTablePartitions(boolean requery, String trxName)
	{
		if (tablePartitions != null && !requery)
			return tablePartitions;
		
		tablePartitionNames = null;
		
		String whereClause = X_AD_TablePartition.COLUMNNAME_AD_Table_ID + "=?";
		tablePartitions = new Query(getCtx(), X_AD_TablePartition.Table_Name, whereClause, trxName)
				.setParameters(getAD_Table_ID())
				.setOnlyActiveRecords(true)
				.setOrderBy(X_AD_TablePartition.COLUMNNAME_Name)
				.list();
		return tablePartitions;
	}
	
	/**
	 * @param trxName
	 * @return list of table partition name
	 */
	public List<String> getTablePartitionNames(String trxName)
	{
		if (tablePartitionNames != null)
			return tablePartitionNames;
		
		List<X_AD_TablePartition> partitions = getTablePartitions(false, trxName);
		tablePartitionNames = new ArrayList<String>();
		for (X_AD_TablePartition partition : partitions)
			tablePartitionNames.add(partition.getName());
		return tablePartitionNames;
	}

	/**
	 * Get the Unique UU Index name
	 * @return indexName
	 */
	public static String getUUIDIndexName(String tableName) {

		StringBuilder indexName = new StringBuilder().append(PO.getUUIDColumnName(tableName)).append("_idx");
		if (indexName.length() > AdempiereDatabase.MAX_OBJECT_NAME_LENGTH)
			indexName = new StringBuilder().append(PO.getUUIDColumnName(tableName).substring(0, AdempiereDatabase.MAX_OBJECT_NAME_LENGTH - 5)).append("uuidx");

		return indexName.toString();
	}

	private Boolean hasCustomTree = null;

	/**
	 * If the table has a custom tree defined
	 * @return
	 */
	public boolean hasCustomTree() {
		if (hasCustomTree == null) {
			int exists = DB.getSQLValueEx(get_TrxName(), "SELECT 1 FROM AD_Tree WHERE TreeType=? AND AD_Table_ID=? AND IsActive='Y'", MTree_Base.TREETYPE_CustomTable, getAD_Table_ID());
			hasCustomTree = Boolean.valueOf(exists == 1);
		}
		return hasCustomTree.booleanValue();
	}

	/**
	 * Get Partition Name of the table of the given level
	 * @param tableName
	 * @param primaryLevelOnly - if true, ignore the sub-partition, if exists
	 * @return table partition name, or empty
	 */
	public static String getPartitionName(Properties ctx, String tableName, boolean primaryLevelOnly, String trxName) {
		if(Util.isEmpty(tableName))
			return "";
		
		String[] partitionColsAll = MTablePartition.getPartitionKeyColumns(ctx, tableName, trxName);
		
		if(partitionColsAll.length == 0)
			return tableName;
		
		int level = primaryLevelOnly ? 1 : partitionColsAll.length;
		StringBuilder partitionName = new StringBuilder();
		partitionName.append(tableName);
		for(int i = 0; i < level; i++) {
			partitionName.append("_").append(partitionColsAll[i]);
		}
		return partitionName.toString();
	}
}	//	MTable
