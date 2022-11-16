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
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Locale;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.db.AdempiereDatabase;
import org.compiere.db.Database;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.expression.logic.LogicEvaluator;

/**
 *	Persistent Column Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MColumn.java,v 1.6 2006/08/09 05:23:49 jjanke Exp $
 */
public class MColumn extends X_AD_Column implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4379933682905553553L;

	/**
	 * 	Get MColumn from Cache (immutable)
	 * 	@param AD_Column_ID id
	 *	@return MColumn
	 */
	public static MColumn get (int AD_Column_ID)
	{
		return get(Env.getCtx(), AD_Column_ID);
	}
	
	/**
	 * 	Get MColumn from Cache (immutable)
	 *	@param ctx context
	 * 	@param AD_Column_ID id
	 *	@return MColumn
	 */
	public static MColumn get (Properties ctx, int AD_Column_ID)
	{
		return get(ctx, AD_Column_ID, null);
	}

	/**
	 * 	Get MColumn from Cache (immutable)
	 *	@param ctx context
	 * 	@param AD_Column_ID id
	 * 	@param trxName trx
	 *	@return MColumn
	 */
	public static MColumn get(Properties ctx, int AD_Column_ID, String trxName)
	{
		Integer key = Integer.valueOf(AD_Column_ID);
		MColumn retValue = (MColumn) s_cache.get (ctx, key, e -> new MColumn(ctx, e));
		if (retValue != null) 
			return retValue;
		
		retValue = new MColumn (ctx, AD_Column_ID, trxName);
		if (retValue.get_ID () == AD_Column_ID)
		{
			s_cache.put (key, retValue, e -> new MColumn(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MColumn from cache
	 * @param ctx
	 * @param AD_Column_ID
	 * @param trxName
	 * @return MColumn
	 */
	public static MColumn getCopy(Properties ctx, int AD_Column_ID, String trxName)
	{
		MColumn column = get(ctx, AD_Column_ID, trxName);
		if (column != null)
			column = new MColumn(ctx, column, trxName);
		return column;
	}
	
	/**
	 * 	Get MColumn given TableName and ColumnName
	 *	@param ctx context
	 * 	@param tableName
	 * 	@param columnName
	 *	@return MColumn
	 */
	public static MColumn get (Properties ctx, String tableName, String columnName)
	{
		MTable table = MTable.get(ctx, tableName);
		return  table.getColumn(columnName);
	}	//	get

	/**
	 * 	Get MColumn given TableName and ColumnName
	 *	@param ctx context
	 *  @param tableName
	 *  @param columnName
	 *  @param trxName
	 *	@return MColumn
	 */
	public static MColumn get (Properties ctx, String tableName, String columnName, String trxName)
	{
		MTable table = MTable.get(ctx, tableName, trxName);
		return table.getColumn(columnName);
	}	//	get

	public static String getColumnName (Properties ctx, int AD_Column_ID)
	{
		return getColumnName (ctx, AD_Column_ID, null);
	}

	/**
	 * 	Get Column Name
	 *	@param ctx context
	 *	@param AD_Column_ID id
	 *	@param trxName transaction
	 *	@return Column Name or null
	 */
	public static String getColumnName (Properties ctx, int AD_Column_ID, String trxName)
	{
		MColumn col = MColumn.get(ctx, AD_Column_ID, trxName);
		if (col.get_ID() == 0)
			return null;
		return col.getColumnName();
	}	//	getColumnName
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MColumn>	s_cache	= new ImmutableIntPOCache<Integer,MColumn>(Table_Name, 20);
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MColumn.class);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Column_ID
	 *	@param trxName transaction
	 */
	public MColumn (Properties ctx, int AD_Column_ID, String trxName)
	{
		super (ctx, AD_Column_ID, trxName);
		if (AD_Column_ID == 0)
		{
			setIsAlwaysUpdateable (false);	// N
			setIsEncrypted (false);
			setIsIdentifier (false);
			setIsKey (false);
			setIsMandatory (false);
			setIsParent (false);
			setIsSelectionColumn (false);
			setIsTranslated (false);
			setIsUpdateable (true);	// Y
			setVersion (Env.ZERO);
		}
	}	//	MColumn

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MColumn (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MColumn
	
	/**
	 * 	Parent Constructor
	 *	@param parent table
	 */
	public MColumn (MTable parent)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setAD_Table_ID (parent.getAD_Table_ID());
		setEntityType(parent.getEntityType());
	}	//	MColumn
	
	/**
	 * 
	 * @param copy
	 */
	public MColumn(MColumn copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MColumn(Properties ctx, MColumn copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MColumn(Properties ctx, MColumn copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	/**
	 * 	Is Standard Column
	 *	@return true for AD_Client_ID, etc.
	 */
	public boolean isStandardColumn()
	{
		String columnName = getColumnName();
		if (columnName.equals("AD_Client_ID") 
			|| columnName.equals("AD_Org_ID")
			|| columnName.equals("IsActive")
			|| columnName.equals("Processing")
			|| columnName.equals("Created")
			|| columnName.equals("CreatedBy")
			|| columnName.equals("Updated")
			|| columnName.equals("UpdatedBy") )
			return true;
		
		return false;
	}	//	isStandardColumn
	
	/**
	 * 	Is UUID Column
	 *	@return true for UUID column
	 */
	public boolean isUUIDColumn() {
		return getColumnName().equals(PO.getUUIDColumnName(getAD_Table().getTableName()));
	}

	/**
	 * 	Is Virtual Column
	 *	@return true if virtual column
	 */
	public boolean isVirtualColumn()
	{
		String s = getColumnSQL();
		return s != null && s.length() > 0;
	}	//	isVirtualColumn

	/**
	 * 	Is Virtual DB Column
	 *	@return true if virtual DB column
	 */
	public boolean isVirtualDBColumn()
	{
		String s = getColumnSQL();
		return s != null && s.length() > 0 && !s.startsWith("@SQL=");
	}	//	isVirtualDBColumn

	/**
	 * 	Is Virtual UI Column
	 *	@return true if virtual UI column
	 */
	public boolean isVirtualUIColumn()
	{
		String s = getColumnSQL();
		return s != null && s.length() > 0 && s.startsWith("@SQL=");
	}	//	isVirtualUIColumn
	
	/**
	 * 	Is Virtual Search Column
	 *	@return true if virtual search column
	 */
	public boolean isVirtualSearchColumn()
	{
		String s = getColumnSQL();
		return s != null && s.length() > 0 && s.startsWith("@SQLFIND=");
	}	//	isVirtualSearchColumn

	/**
	 * 	Is the Column Encrypted?
	 *	@return true if encrypted
	 */
	public boolean isEncrypted()
	{
		String s = getIsEncrypted();
		return "Y".equals(s);
	}	//	isEncrypted
	
	/**
	 * 	Set Encrypted
	 *	@param IsEncrypted encrypted
	 */
	public void setIsEncrypted (boolean IsEncrypted)
	{
		setIsEncrypted (IsEncrypted ? "Y" : "N");
	}	//	setIsEncrypted
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		String error = Database.isValidIdentifier(getColumnName());
		if (!Util.isEmpty(error)) {
			log.saveError("Error", Msg.getMsg(getCtx(), error) + " [ColumnName]");
			return false;
		}

		if (! Util.isEmpty(getFKConstraintName())) {
			error = Database.isValidIdentifier(getFKConstraintName());
			if (!Util.isEmpty(error)) {
				log.saveError("Error", Msg.getMsg(getCtx(), error) + " [FKConstraintName]");
				return false;
			}
		}

		int displayType = getAD_Reference_ID();
		if (DisplayType.isLOB(displayType))	//	LOBs are 0
		{
			if (getFieldLength() != 0)
				setFieldLength(0);
		}
		else if (getFieldLength() == 0 && displayType != DisplayType.Text) 
		{
			if (DisplayType.isID(displayType))
				setFieldLength(10);
			else if (DisplayType.isNumeric (displayType))
				setFieldLength(14);
			else if (DisplayType.isDate (displayType))
				setFieldLength(7);
			else
			{
				log.saveError("FillMandatory", Msg.getElement(getCtx(), "FieldLength"));
				return false;
			}
		}

		if (displayType == DisplayType.Table && getAD_Reference_Value_ID() <= 0)
		{
			log.saveError("FillMandatory", Msg.getElement(getCtx(), "AD_Reference_Value_ID"));
			return false;
		}

		if (displayType != DisplayType.Button)
		{
			if (! ISTOOLBARBUTTON_Window.equals(getIsToolbarButton()))
			{
				setIsToolbarButton(ISTOOLBARBUTTON_Window);
			}
		}
		
		if (!isVirtualColumn() && getValueMax() != null && getValueMin() != null)
		{
			try {
				BigDecimal valueMax = new BigDecimal(getValueMax());
				BigDecimal valueMin = new BigDecimal(getValueMin());
				if (valueMax.compareTo(valueMin) < 0) 
				{
					log.saveError("MaxLessThanMin", Msg.getElement(getCtx(), COLUMNNAME_ValueMax));
					return false;
				}
			} catch (Exception e){}
		}
		
		if (isIdentifier())
		{
			int cnt = DB.getSQLValue(get_TrxName(),"SELECT COUNT(*) FROM AD_Column "+
					"WHERE AD_Table_ID=?"+
					" AND AD_Column_ID!=?"+
					" AND IsIdentifier='Y'"+
					" AND SeqNo=?",
					new Object[] {getAD_Table_ID(), getAD_Column_ID(), getSeqNo()});
			if (cnt>0)
			{
				log.saveError(DBException.SAVE_ERROR_NOT_UNIQUE_MSG, Msg.getElement(getCtx(), COLUMNNAME_SeqNo));
				return false;
			}
		}
		
		//	Virtual Column
		if (isVirtualColumn())
		{
			if (isMandatory())
				setIsMandatory(false);
			if (isUpdateable())
				setIsUpdateable(false);
			if ((isVirtualUIColumn() || isVirtualSearchColumn()) && isIdentifier())
				setIsIdentifier(false);
		}
		//	Updateable
		if (isParent() || isKey())
			setIsUpdateable(false);
		if (isAlwaysUpdateable() && !isUpdateable())
			setIsAlwaysUpdateable(false);
		//	Encrypted
		String colname = getColumnName();
		if (isEncrypted()) 
		{
			int dt = getAD_Reference_ID();
			if (isKey() || isParent() || isStandardColumn()
				|| isVirtualColumn() || isIdentifier() || isTranslated() || isUUIDColumn()
				|| DisplayType.isLookup(dt) || DisplayType.isLOB(dt)
				|| "DocumentNo".equalsIgnoreCase(colname)
				|| "Value".equalsIgnoreCase(colname)
				|| "Name".equalsIgnoreCase(colname))
			{
				log.warning("Encryption not sensible - " + colname);
				setIsEncrypted(false);
			}
		}	
		
		//	Sync Terminology
		if ((newRecord || is_ValueChanged ("AD_Element_ID")) 
			&& getAD_Element_ID() != 0)
		{
			M_Element element = new M_Element (getCtx(), getAD_Element_ID (), get_TrxName());
			setColumnName (element.getColumnName());
			setName (element.getName());
			setDescription (element.getDescription());
			setHelp (element.getHelp());
		}
		
		// Validations for IsAllowCopy - some columns must never be set as allowed copying
		if (isAllowCopy()) {
			if (   isKey()
				|| isVirtualColumn()
				|| isUUIDColumn()
				|| isStandardColumn()
			)
				setIsAllowCopy(false);
		}

		// validate FormatPattern
		String pattern = getFormatPattern();
		if (! Util.isEmpty(pattern, true)) {
			if (DisplayType.isNumeric(getAD_Reference_ID())) {
				DecimalFormat format = (DecimalFormat)NumberFormat.getNumberInstance(Locale.US);
				try {
					format.applyPattern(pattern);
				} catch (IllegalArgumentException e) {
					log.saveError("SaveError", "Invalid number format: " + pattern);
					return false;
				}
			} else if (DisplayType.isDate(getAD_Reference_ID())) {
				SimpleDateFormat format = (SimpleDateFormat)DateFormat.getInstance();
				try {
					format.applyPattern(pattern);
				} catch (IllegalArgumentException e) {
					log.saveError("SaveError", "Invalid date pattern: " + pattern);
					return false;
				}
			} else {
				setFormatPattern(null);
			}
		}

		// IDEMPIERE-4714
		if (isSecure() && isAllowLogging()) {
			setIsAllowLogging(false);
		}

		// IDEMPIERE-1615 Multiple key columns lead to data corruption or data loss
		if ((is_ValueChanged(COLUMNNAME_IsKey) || is_ValueChanged(COLUMNNAME_IsActive)) && isKey() && isActive()) {
			int cnt = DB.getSQLValueEx(get_TrxName(),
					"SELECT COUNT(*) FROM AD_Column WHERE AD_Table_ID=? AND IsActive='Y' AND AD_Column_ID!=? AND IsKey='Y'",
					getAD_Table_ID(), getAD_Column_ID());
			if (cnt > 0) {
				log.saveError("Error", Msg.getMsg(getCtx(), "KeyColumnAlreadyDefined"));
				return false;
			}
		}

		if (isSelectionColumn() && getSeqNoSelection() <= 0) {
			int next = DB.getSQLValueEx(get_TrxName(),
					"SELECT ROUND((COALESCE(MAX(SeqNoSelection),0)+10)/10,0)*10 FROM AD_Column WHERE AD_Table_ID=? AND IsSelectionColumn='Y' AND IsActive='Y'",
					getAD_Table_ID());
			setSeqNoSelection(next);
		}

		//validate readonly logic expression
		if (newRecord || is_ValueChanged(COLUMNNAME_ReadOnlyLogic)) {
			if (isActive() && !Util.isEmpty(getReadOnlyLogic(), true) && !getReadOnlyLogic().startsWith("@SQL=")) {
				LogicEvaluator.validate(getReadOnlyLogic());
			}
		}

		// IDEMPIERE-4911
		MTable table = MTable.get(getCtx(), getAD_Table_ID(), get_TrxName());
		String tableName = table.getTableName();
		if (tableName.toLowerCase().endsWith("_trl")) {
			String parentTable = tableName.substring(0, tableName.length()-4);
			MColumn column = MColumn.get(getCtx(), parentTable, colname, get_TrxName());
			if (column != null && column.isTranslated()) {
				if (getFieldLength() < column.getFieldLength()) {
					log.saveWarning("Warning", "Size increased to " + column.getFieldLength() + " in translated column " + tableName + "." + colname);
					setFieldLength(column.getFieldLength());
				}
			}
		}

		if (getAD_Reference_ID() != DisplayType.Button && get_Value(COLUMNNAME_AD_InfoWindow_ID) != null) {
			set_Value(COLUMNNAME_AD_InfoWindow_ID, null);
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

		if ((newRecord || is_ValueChanged(COLUMNNAME_ColumnName))
			&& (   "EntityType".equals(getColumnName())
				|| "EntityType".equals(get_ValueOld(COLUMNNAME_ColumnName).toString()))) {
			MChangeLog.resetLoggedList();
		}

		// IDEMPIERE-4911
		if (isTranslated()) {
			MTable table = MTable.get(getAD_Table_ID());
			String trlTableName = table.getTableName() + "_Trl";
			MTable trlTable = MTable.get(getCtx(), trlTableName);
			if (trlTable == null) {
				log.saveWarning("Warning", Msg.getMsg(getCtx(), "WarnCreateTrlTable", new Object[] {trlTableName, getColumnName()}));
			} else {
				MColumn trlColumn = MColumn.get(getCtx(), trlTableName, getColumnName());
				if (trlColumn == null) {
					log.saveWarning("Warning", Msg.getMsg(getCtx(), "WarnCreateTrlColumn", new Object[] {trlTableName, getColumnName()}));
				} else {
					if (trlColumn.getFieldLength() < getFieldLength()) {
						log.saveWarning("Warning", Msg.getMsg(getCtx(), "WarnUpdateSizeTrlTable", new Object[] {trlTableName, getColumnName(), getFieldLength()}));
					}
				}
			}
		}

		return success;
	}	//	afterSave
	
	/**
	 * 	Get SQL Add command
	 *	@param table table
	 *	@return sql
	 */
	public String getSQLAdd (MTable table)
	{
		AdempiereDatabase db = DB.getDatabase();	
		if (db.isNativeMode()) 
			return db.getSQLAdd(table, this);
		else
			return Database.getDatabase(Database.DB_ORACLE).getSQLAdd(table, this);
	}	//	getSQLAdd

	/**
	 * 	Get SQL DDL
	 *	@return columnName datataype ..
	 */
	public String getSQLDDL()
	{
		if (isVirtualColumn())
			return null;
		
		AdempiereDatabase db = DB.getDatabase();
		if (db.isNativeMode())
			return db.getSQLDDL(this);
		else
			return Database.getDatabase(Database.DB_ORACLE).getSQLDDL(this);
	}	//	getSQLDDL	
	
	/**
	 * 	Get SQL Modify command
	 *	@param table table
	 *	@param setNullOption generate null / not null statement
	 *	@return sql separated by ;
	 */
	public String getSQLModify (MTable table, boolean setNullOption)
	{
		AdempiereDatabase db = DB.getDatabase();
		if (db.isNativeMode())
			return db.getSQLModify(table, this, setNullOption);
		else
			return Database.getDatabase(Database.DB_ORACLE).getSQLModify(table, this, setNullOption);
	}	//	getSQLModify

	/**
	 * 	Get SQL Data Type
	 *	@return e.g. NVARCHAR2(60)
	 */
	public String getSQLDataType()
	{
		String columnName = getColumnName();
		int dt = getAD_Reference_ID();
		return DisplayType.getSQLDataType (dt, columnName, getFieldLength());
	}	//	getSQLDataType
	
	/**
	 * 	Get Table Constraint
	 *	@param tableName table name
	 *	@return table constraint
	 */
	public String getConstraint(String tableName)
	{
		if (isKey()) {
			StringBuilder constraintName;
			if (tableName.length() > 26)
				// Oracle restricts object names to 30 characters
				constraintName = new StringBuilder(tableName.substring(0, 26)).append("_Key");
			else
				constraintName = new StringBuilder(tableName).append("_Key");
			StringBuilder msgreturn = new StringBuilder("CONSTRAINT ").append(constraintName).append(" PRIMARY KEY (").append(getColumnName()).append(")");
			return msgreturn.toString();
		}
		/**
		if (getAD_Reference_ID() == DisplayType.TableDir 
			|| getAD_Reference_ID() == DisplayType.Search)
			return "CONSTRAINT " ADTable_ADTableTrl
				+ " FOREIGN KEY (" + getColumnName() + ") REFERENCES "
				+ AD_Table(AD_Table_ID) ON DELETE CASCADE
		**/
		// IDEMPIERE-965
		if (getColumnName().equals(PO.getUUIDColumnName(tableName))) {
			StringBuilder indexName = new StringBuilder().append(getColumnName()).append("_idx");
			if (indexName.length() > 30) {
				indexName = new StringBuilder().append(getColumnName().substring(0, 25));
				indexName.append("uuidx");
			}
			StringBuilder msgreturn = new StringBuilder("CONSTRAINT ").append(indexName).append(" UNIQUE (").append(getColumnName()).append(")");
			return msgreturn.toString();
		}
		return "";
	}	//	getConstraint
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MColumn[");
		sb.append (get_ID()).append ("-").append (getColumnName()).append ("]");
		return sb.toString ();
	}	//	toString
	
	//begin vpj-cd e-evolution
	/**
	 * 	get Column ID
	 *  @param TableName
	 *	@param columnName
	 *	@return int retValue
	 */
	public static int getColumn_ID(String TableName,String columnName) {
		int m_table_id = MTable.getTable_ID(TableName);
		if (m_table_id == 0)
			return 0;
			
		int retValue = 0;
		String SQL = "SELECT AD_Column_ID FROM AD_Column WHERE AD_Table_ID = ?  AND columnname = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			pstmt.setInt(1, m_table_id);
			pstmt.setString(2, columnName);
			rs = pstmt.executeQuery();
			if (rs.next())
				retValue = rs.getInt(1);
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, SQL, e);
			retValue = -1;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		return retValue;
	}
	//end vpj-cd e-evolution
	
	/**
	* Get Table Id for a column
	* @param ctx context
	* @param AD_Column_ID id
	* @param trxName transaction
	* @return MColumn
	*/
	public static int getTable_ID(Properties ctx, int AD_Column_ID, String trxName)
	{
		String sqlStmt = "SELECT AD_Table_ID FROM AD_Column WHERE AD_Column_ID=?";
		return DB.getSQLValue(trxName, sqlStmt, AD_Column_ID);
	}


	public static boolean isSuggestSelectionColumn(String columnName, boolean caseSensitive)
	{
		if (Util.isEmpty(columnName, true))
			return false;
		//
        if (columnName.equals("Value") || (!caseSensitive && columnName.equalsIgnoreCase("Value")))
            return true;
        else if (columnName.equals("Name") || (!caseSensitive && columnName.equalsIgnoreCase("Name")))
            return true;
        else if (columnName.equals("DocumentNo") || (!caseSensitive && columnName.equalsIgnoreCase("DocumentNo")))
            return true;
        else if (columnName.equals("Description") || (!caseSensitive && columnName.equalsIgnoreCase("Description")))
            return true;
        else if (columnName.indexOf("Name") != -1
        		|| (!caseSensitive && columnName.toUpperCase().indexOf("Name".toUpperCase()) != -1) )
            return true;
        else
        	return false;
	}

	public String getReferenceTableName() {
		String foreignTable = null;
		int refid = getAD_Reference_ID();
		if (DisplayType.TableDir == refid || (DisplayType.Search == refid && getAD_Reference_Value_ID() == 0)) {
			foreignTable = getColumnName().substring(0, getColumnName().length()-3);
		} else if (DisplayType.Table == refid || DisplayType.Search == refid) {
			MReference ref = MReference.get(getCtx(), getAD_Reference_Value_ID(), get_TrxName());
			if (MReference.VALIDATIONTYPE_TableValidation.equals(ref.getValidationType())) {
				int cnt = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM AD_Ref_Table WHERE AD_Reference_ID=?", getAD_Reference_Value_ID());
				if (cnt == 1) {
					MRefTable rt = MRefTable.get(getCtx(), getAD_Reference_Value_ID(), get_TrxName());
					if (rt != null) {
						MTable table = MTable.get(getCtx(), rt.getAD_Table_ID(), get_TrxName());
						if (table == null) {
							throw new AdempiereException("Table " + rt.getAD_Table_ID() + " not found");
						}
						foreignTable = table.getTableName();
					}
				}
			}
		} else if (DisplayType.Button == refid) {
			// C_BPartner.AD_OrgBP_ID and C_Project.C_ProjectType_ID are defined as buttons
			if ("AD_OrgBP_ID".equalsIgnoreCase(getColumnName()))
				foreignTable = "AD_Org";
			else if ("C_ProjectType_ID".equalsIgnoreCase(getColumnName()))
				foreignTable = "C_ProjectType";
		} else if (DisplayType.isList(refid)) {
			foreignTable = "AD_Ref_List";
		} else if (DisplayType.Location == refid) {
			foreignTable = "C_Location";
		} else if (DisplayType.Account == refid) {
			foreignTable = "C_ValidCombination";
		} else if (DisplayType.Locator == refid) {
			foreignTable = "M_Locator";
		} else if (DisplayType.PAttribute == refid) {
			foreignTable = "M_AttributeSetInstance";
		} else if (DisplayType.Assignment == refid) {
			foreignTable = "S_ResourceAssignment";
		} else if (DisplayType.Image == refid && !"BinaryData".equals(getColumnName())) {
			foreignTable = "AD_Image";
		} else if (DisplayType.Chart == refid) {
			foreignTable = "AD_Chart";
		}

		if (foreignTable != null) {
			if (foreignTable.equals("AD_AllClients_V")) {
				foreignTable = "AD_Client";
			} else if (foreignTable.equals("AD_AllUsers_V")) {
				foreignTable = "AD_User";
			} else if (foreignTable.equals("AD_AllRoles_V")) {
				foreignTable = "AD_Role";
			}
		}

		return foreignTable;
	}

	public void setSmartDefaults() { // IDEMPIERE-1649 - dup code on Callout_AD_Column.columnName
		if (MColumn.isSuggestSelectionColumn(getColumnName(), true))
			setIsSelectionColumn(true);

		// IDEMPIERE-1011
		if (PO.getUUIDColumnName(getAD_Table().getTableName()).equals(getColumnName())) {
			// UUID column
			setAD_Reference_ID(DisplayType.String);
			setAD_Val_Rule_ID(0);
			setAD_Reference_Value_ID(0);
			setFieldLength(36);
			setDefaultValue(null);
			setMandatoryLogic(null);
			setReadOnlyLogic(null);
			setIsIdentifier(false);
			setIsUpdateable(false);
			setIsAlwaysUpdateable(false);
			setIsKey(false);
		} else if (getAD_Table().getTableName().concat("_ID").equals(getColumnName())) {
			// ID key column
			setAD_Reference_ID(DisplayType.ID);
			setAD_Val_Rule_ID(0);
			setAD_Reference_Value_ID(0);
			setFieldLength(22);
			setDefaultValue(null);
			setMandatoryLogic(null);
			setReadOnlyLogic(null);
			setIsIdentifier(false);
			setIsUpdateable(false);
			setIsAlwaysUpdateable(false);
			setIsKey(true);
		} else {
			// get defaults from most used case
			String sql = ""
					+ "SELECT AD_Reference_ID, "
					+ "       AD_Val_Rule_ID, "
					+ "       AD_Reference_Value_ID, "
					+ "       FieldLength, "
					+ "       DefaultValue, "
					+ "       MandatoryLogic, "
					+ "       ReadOnlyLogic, "
					+ "       IsIdentifier, "
					+ "       IsUpdateable, "
					+ "       IsAlwaysUpdateable, "
					+ "       FKConstraintType,"	
					+ "       COUNT(*) "
					+ "FROM   AD_Column "
					+ "WHERE  ColumnName = ? "
					+ "GROUP  BY AD_Reference_ID, "
					+ "          AD_Val_Rule_ID, "
					+ "          AD_Reference_Value_ID, "
					+ "          FieldLength, "
					+ "          DefaultValue, "
					+ "          MandatoryLogic, "
					+ "          ReadOnlyLogic, "
					+ "          IsIdentifier, "
					+ "          IsUpdateable, "
					+ "          IsAlwaysUpdateable, "
					+ "          FKConstraintType "
					+ "ORDER  BY COUNT(*) DESC ";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setString(1, getColumnName());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					int ad_reference_id = rs.getInt(1);
					if (ad_reference_id == DisplayType.ID)
						ad_reference_id = DisplayType.TableDir;
					setAD_Reference_ID(ad_reference_id);
					setAD_Val_Rule_ID(rs.getInt(2));
					setAD_Reference_Value_ID(rs.getInt(3));
					setFieldLength(rs.getInt(4));
					setDefaultValue(rs.getString(5));
					setMandatoryLogic(rs.getString(6));
					setReadOnlyLogic(rs.getString(7));
					setIsIdentifier("Y".equals(rs.getString(8)));
					setIsUpdateable("Y".equals(rs.getString(9)));
					setIsAlwaysUpdateable("Y".equals(rs.getString(10)));
					setFKConstraintType(rs.getString(11));
				}
			}
			catch (SQLException e)
			{
				throw new DBException(e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
		}
	}

	@Override
	public I_AD_Table getAD_Table() throws RuntimeException {
		MTable table = MTable.getCopy(getCtx(), getAD_Table_ID(), get_TrxName());
		return table;
	}

	public static String getForeignKeyConstraintSql(DatabaseMetaData md, String catalog, String schema, String tableName, MTable table, MColumn column, boolean isNoTable) throws Exception
	{
		StringBuilder fkConstraintSql = new StringBuilder();

		if (!column.isKey() && !column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())) && !column.isVirtualColumn())
		{
			int refid = column.getAD_Reference_ID();
			if (!DisplayType.isList(refid))
			{
				String referenceTableName = column.getReferenceTableName();
				if (referenceTableName != null)
				{
					Hashtable<String, DatabaseKey> htForeignKeys = new Hashtable<String, DatabaseKey>();

					if (md.storesUpperCaseIdentifiers()) {
						referenceTableName = referenceTableName.toUpperCase();
						tableName = tableName.toUpperCase();
					} else if (md.storesLowerCaseIdentifiers()) {
						referenceTableName = referenceTableName.toLowerCase();
						tableName = tableName.toLowerCase();
					}

					if (!isNoTable) {
						ResultSet rs = null;
						try {
							rs = md.getCrossReference(catalog, schema, referenceTableName, catalog, schema, tableName);
							while (rs.next())
							{
								String dbFKName = rs.getString("FK_NAME");
								if (dbFKName == null)
									continue;

								String dbFKTable = rs.getString("FKTABLE_NAME");
								short deleteRule = rs.getShort("DELETE_RULE");

								String key = dbFKName.toLowerCase();
								DatabaseKey dbForeignKey = htForeignKeys.get(key);
								if (dbForeignKey == null)
									dbForeignKey = new DatabaseKey(dbFKName, dbFKTable, new String[30], deleteRule);

								String columnName = rs.getString("FKCOLUMN_NAME");
								int pos = (rs.getShort("KEY_SEQ"));
								if (pos > 0)
									dbForeignKey.getKeyColumns()[pos-1] = columnName;

								htForeignKeys.put(key, dbForeignKey);
							}
						} finally {
							DB.close(rs);  rs = null;
						}
					}

					Enumeration<String> en = htForeignKeys.keys();
					while (en.hasMoreElements())
					{
						String key = en.nextElement();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						if (dbForeignKey.getKeyColumns()[1] != null)
							htForeignKeys.remove(key);
					}

					boolean modified = false;
					en = htForeignKeys.keys();
					while (en.hasMoreElements())
					{
						String key = en.nextElement();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						if (dbForeignKey.getKeyColumns()[0].equalsIgnoreCase(column.getColumnName()))
						{
							DatabaseKey primaryKey = getPrimaryKey(md, referenceTableName);
							if (primaryKey != null)
							{
								fkConstraintSql.append(DB.SQLSTATEMENT_SEPARATOR);
								fkConstraintSql.append("ALTER TABLE ").append(table.getTableName());
								fkConstraintSql.append(" DROP CONSTRAINT ").append(dbForeignKey.getKeyName());

								String dbDeleteRule = null;
								if (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeyCascade)
									dbDeleteRule = MColumn.FKCONSTRAINTTYPE_Cascade;
								else if (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeySetNull)
									dbDeleteRule = MColumn.FKCONSTRAINTTYPE_SetNull;
								else if (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeyNoAction || dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeyRestrict)
									dbDeleteRule = MColumn.FKCONSTRAINTTYPE_NoAction;
								String fkConstraintType = column.getFKConstraintType();
								if (fkConstraintType == null) {
									fkConstraintType = dbDeleteRule;
									if (fkConstraintType == null) {
										if (   "AD_Client_ID".equals(column.getColumnName())
											|| "AD_Org_ID".equals(column.getColumnName())
											|| "CreatedBy".equals(column.getColumnName())
											|| "UpdatedBy".equals(column.getColumnName())
										   )
											fkConstraintType = MColumn.FKCONSTRAINTTYPE_DoNotCreate;
										else
											fkConstraintType = MColumn.FKCONSTRAINTTYPE_NoAction;
									}
								}
								if (!fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_DoNotCreate))
								{
									String fkConstraintName = column.getFKConstraintName();						
									if (fkConstraintName == null || fkConstraintName.trim().length() == 0)
										fkConstraintName = dbForeignKey.getKeyName();

									StringBuilder fkConstraint = new StringBuilder();
									fkConstraint.append("CONSTRAINT ").append(fkConstraintName);
									fkConstraint.append(" FOREIGN KEY (").append(column.getColumnName()).append(") REFERENCES ");
									fkConstraint.append(primaryKey.getKeyTable()).append("(").append(primaryKey.getKeyColumns()[0]);
									for (int i = 1; i < primaryKey.getKeyColumns().length; i++)
									{
										if (primaryKey.getKeyColumns()[i] == null)
											break;
										fkConstraint.append(", ").append(primaryKey.getKeyColumns()[i]);
									}
									fkConstraint.append(")");

									if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_NoAction))
										;
									else if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_Cascade))
										fkConstraint.append(" ON DELETE CASCADE");
									else if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_SetNull))
										fkConstraint.append(" ON DELETE SET NULL");

									fkConstraint.append(" DEFERRABLE INITIALLY DEFERRED");

									fkConstraintSql.append(DB.SQLSTATEMENT_SEPARATOR);
									fkConstraintSql.append("ALTER TABLE ").append(table.getTableName());
									fkConstraintSql.append(" ADD ");
									fkConstraintSql.append(fkConstraint);

									column.setFKConstraintName(fkConstraintName);
									column.setFKConstraintType(fkConstraintType);
									column.saveEx();

									// if the current db FK is same as what we need to create
									if (   dbForeignKey.getKeyName().equalsIgnoreCase(column.getFKConstraintName())
										&& (   (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeyCascade && MColumn.FKCONSTRAINTTYPE_Cascade.equals(column.getFKConstraintType()))
										    || (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeySetNull && MColumn.FKCONSTRAINTTYPE_SetNull.equals(column.getFKConstraintType()))
										    || (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeyNoAction && MColumn.FKCONSTRAINTTYPE_NoAction.equals(column.getFKConstraintType()))
										    || (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeyRestrict && MColumn.FKCONSTRAINTTYPE_NoAction.equals(column.getFKConstraintType()))
										   )
									   ) {
										// nothing changed
										return "";
									}
								}
							}
							modified = true;
							break;
						}
					}

					if (!modified)
					{
						String fkConstraint = getForeignKeyConstraint(md, table, column);
						if (fkConstraint != null && fkConstraint.length() > 0)
						{
							fkConstraintSql.append(DB.SQLSTATEMENT_SEPARATOR);
							fkConstraintSql.append("ALTER TABLE ").append(table.getTableName());
							fkConstraintSql.append(" ADD ");
							fkConstraintSql.append(fkConstraint);
						}
					}
				}
			}
		}
		return fkConstraintSql.toString();
	}

	public static DatabaseKey getPrimaryKey(DatabaseMetaData md, String primaryTableName) throws Exception 
	{
		DatabaseKey primaryKey = null;
		
		String catalog = DB.getDatabase().getCatalog();
		String schema = DB.getDatabase().getSchema();
		
		String tableName = primaryTableName;		
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();
		
		ResultSet rs = null;
		try {
			rs = md.getPrimaryKeys(catalog, schema, tableName);
			while (rs.next())
			{
				String primaryKeyName = rs.getString("PK_NAME");			
				if (primaryKeyName == null)
					continue;
				
				String primaryKeyTableName = rs.getString("TABLE_NAME");
				short deleteRule = -1;
				
				if (primaryKey == null)
					primaryKey = new DatabaseKey(primaryKeyName, primaryKeyTableName, new String[30], deleteRule);
				
				String primaryKeyColumn = rs.getString("COLUMN_NAME");
				int pos = (rs.getShort("KEY_SEQ"));				
				if (pos > 0)
					primaryKey.getKeyColumns()[pos-1] = primaryKeyColumn;
			}
		} catch (Exception e) {
			DB.close(rs);  rs = null;
		}
		return primaryKey;
	}

	public static String getForeignKeyConstraint(DatabaseMetaData md, MTable table, MColumn column) throws Exception 
	{		
		if (!column.isKey() && !column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())))
		{
			String fkConstraintType = column.getFKConstraintType();
			if (fkConstraintType == null)
				fkConstraintType = MColumn.FKCONSTRAINTTYPE_NoAction;
			
			if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_DoNotCreate))
				return "";

			int refid = column.getAD_Reference_ID();
			if (!DisplayType.isList(refid))
			{
				String referenceTableName = column.getReferenceTableName();
				if (referenceTableName != null)
				{
					DatabaseKey primaryKey = MColumn.getPrimaryKey(md, referenceTableName);
					
					if (primaryKey != null)
					{
						String fkConstraintName = column.getFKConstraintName();						
						if (fkConstraintName == null || fkConstraintName.trim().length() == 0)
						{
							String columnName = column.getColumnName();
							if (columnName.toUpperCase().endsWith("_ID"))
								columnName = columnName.substring(0, columnName.length() - 3);
							
							StringBuilder constraintName = new StringBuilder();
							constraintName.append(columnName.replace("_", ""));
							constraintName.append("_");
							constraintName.append(table.getTableName().replace("_", ""));
							if (constraintName.length() > 30)
								constraintName = new StringBuilder(constraintName.substring(0, 30));
							fkConstraintName = constraintName.toString();
						}
						
						StringBuilder fkConstraint = new StringBuilder();
						fkConstraint.append("CONSTRAINT ").append(fkConstraintName);
						fkConstraint.append(" FOREIGN KEY (").append(column.getColumnName()).append(") REFERENCES ");
						fkConstraint.append(primaryKey.getKeyTable()).append("(").append(primaryKey.getKeyColumns()[0]);
						for (int i = 1; i < primaryKey.getKeyColumns().length; i++)
						{
							if (primaryKey.getKeyColumns()[i] == null)
								break;
							fkConstraint.append(", ").append(primaryKey.getKeyColumns()[i]);
						}
						fkConstraint.append(")");
						
						if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_NoAction))
							;
						else if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_Cascade))
							fkConstraint.append(" ON DELETE CASCADE");
						else if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_SetNull))
							fkConstraint.append(" ON DELETE SET NULL");
						
						fkConstraint.append(" DEFERRABLE INITIALLY DEFERRED");
						
						column.setFKConstraintName(fkConstraintName);
						column.setFKConstraintType(fkConstraintType);
						column.saveEx();
						
						return fkConstraint.toString();
					}
				}
			}
		}
		
		return "";
	}

	/**
	 * 	Is Advanced
	 *	@return true if the column has any field marked as advanced or part of an advanced tab
	 */
	public boolean isAdvanced() {
		final String sql = ""
				+ "SELECT COUNT(*) "
				+ "FROM   AD_Tab t "
				+ "       JOIN AD_Field f ON ( f.AD_Tab_ID = t.AD_Tab_ID ) "
				+ "WHERE  f.AD_Column_ID = ? "
				+ "       AND ( t.IsAdvancedTab = 'Y' OR f.IsAdvancedField = 'Y' )";
		int cnt = DB.getSQLValueEx(get_TrxName(), sql, getAD_Column_ID());
		return cnt > 0;
	}

	public String getColumnSQL(boolean nullForUI) {
		return getColumnSQL(nullForUI, true);
	}
	
	public String getColumnSQL(boolean nullForUI, boolean nullForSearch) {
		String query = getColumnSQL();
		if (query != null && query.length() > 0) {
			if (query.startsWith("@SQL=") && nullForUI)
				query = "NULL";
			else if (query.startsWith("@SQLFIND=") && nullForSearch)
				query = "NULL";
			else if (query.startsWith("@SQLFIND=") && !nullForSearch)
				query = query.substring(9);
		}
		return query;
	}

	public String renameDBColumn(String newColumnName) {
		int rvalue = -1;
		String sql;
		if (! newColumnName.toLowerCase().equals(getColumnName().toLowerCase())) {
			MTable table = new MTable(getCtx(), getAD_Table_ID(), get_TrxName());
			sql = "ALTER TABLE " + table.getTableName() + " RENAME COLUMN " + getColumnName() + " TO " + newColumnName;
			rvalue = DB.executeUpdateEx(sql, get_TrxName());
		} else {
			sql = getColumnName() + " - rename not required";
		}
		setColumnName(newColumnName);
		return rvalue + " - " + sql;
	}

	@Override
	public MColumn markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MColumn
