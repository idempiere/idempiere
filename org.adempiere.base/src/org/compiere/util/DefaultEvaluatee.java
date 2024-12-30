/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.util;

import java.beans.Expression;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.compiere.model.GridTab;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MRefList;
import org.compiere.model.MTable;
import org.compiere.model.PO;

/**
 * Default {@link Evaluatee} implementation
 * @author hengsin
 */
public class DefaultEvaluatee implements Evaluatee {

	private DataProvider m_dataProvider;
	private int m_windowNo;
	private int m_tabNo;
	private boolean m_onlyWindow;
	private Boolean m_onlyTab;
	private boolean m_useMsgForBoolean = false;
	private boolean m_useColumnDateFormat = false;
	private String m_trxName = null;

	/** Cache for {@link #getColumnValue(MTable, String, String, int, String)} */
	private static final ReferenceCache s_ReferenceCache = new ReferenceCache("DefaultEvaluatee_ReferenceCache", 100, 1, 2000);
	
	/**
	 * @param gridTab
	 * @param windowNo
	 * @param tabNo
	 */
	public DefaultEvaluatee(GridTab gridTab, int windowNo, int tabNo) {
		this(gridTab, windowNo, tabNo, true);
	}
	
	/**
	 * @param gridTab
	 * @param windowNo
	 * @param tabNo
	 * @param onlyWindow
	 */
	public DefaultEvaluatee(GridTab gridTab, int windowNo, int tabNo, boolean onlyWindow) {
		this.m_dataProvider = gridTab != null ? new GridTabDataProvider(gridTab) : null;
		this.m_windowNo = windowNo;
		this.m_tabNo = tabNo;
		this.m_onlyWindow = onlyWindow;
	}
		
	/**
	 * @param gridTab
	 * @param windowNo
	 * @param tabNo
	 * @param onlyTab
	 * @param onlyWindow
	 */
	public DefaultEvaluatee(GridTab gridTab, int windowNo, int tabNo, boolean onlyTab, boolean onlyWindow) {
		this.m_dataProvider = gridTab != null ? new GridTabDataProvider(gridTab) : null;
		this.m_windowNo = windowNo;
		this.m_tabNo = tabNo;
		this.m_onlyWindow = onlyWindow;
		this.m_onlyTab = Boolean.valueOf(onlyTab);
	}
	
	/**
	 * @param po
	 */
	public DefaultEvaluatee(PO po) {
		this(new PODataProvider(po));
	}
	
	/**
	 * @param dataProvider
	 */
	public DefaultEvaluatee(DataProvider dataProvider) {
		this.m_dataProvider = dataProvider;
		this.m_windowNo = -1;
		this.m_tabNo = -1;
		this.m_onlyWindow = false;
		this.m_onlyTab = null;
	}
	
	/**
	 * Default constructor
	 */
	public DefaultEvaluatee() {
		this.m_dataProvider = null;
		this.m_windowNo = -1;
		this.m_tabNo = -1;
		this.m_onlyWindow = false;
		this.m_onlyTab = null;
	}
		
	public void setTrxName(String trxName) {
		m_trxName = trxName;
	}
	
	@Override
	public String get_ValueAsString(String variableName) {
		return get_ValueAsString(Env.getCtx(), variableName);
	}

	/**
	 * 	Get Variable Value (Evaluatee)
	 *  @param ctx
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (Properties ctx, String variableName)
	{
		//format string
		String format = "";
		int f = variableName.indexOf(Evaluator.VARIABLE_FORMATTING_OPERATOR_START);
		if (f > 0 && variableName.endsWith(Evaluator.VARIABLE_FORMATTING_OPERATOR_END)) {
			format = variableName.substring(f+1, variableName.length()-1);
			variableName = variableName.substring(0, f);
		}
		
		//reference column
		String foreignColumn = "";
		f = variableName.indexOf(Evaluator.VARIABLE_REFERENCE_OPERATOR);
		if (f > 0) {
			String t = variableName.substring(0, f);
			if (t.matches(".*[_]ID([:].+)?")) {
				foreignColumn = variableName.substring(f+1, variableName.length());
				variableName = t;
			}
		}
		
		// IDEMPIERE-194 Handling null context variable (default value)
		String defaultValue = null;
		int idx = variableName.indexOf(Evaluator.VARIABLE_DEFAULT_VALUE_OPERATOR);	//	or clause
		if (idx  >=  0) 
		{
			defaultValue = variableName.substring(idx+1, variableName.length());
			variableName = variableName.substring(0, idx);
		}
					
		String value = null;
		boolean globalVariable = Env.isGlobalVariable(variableName);
		boolean tabOnly = m_onlyTab != null ? m_onlyTab.booleanValue() : false;
		// get value from global or window context
		if (globalVariable)
		{
			value = Env.getContext(ctx, variableName);	// get from global context
		}
		else if (m_windowNo >= 0)
		{
			if (variableName.equalsIgnoreCase(GridTab.CTX_Record_ID))			
			{
				String keycolumnName = Env.getContext(Env.getCtx(), m_windowNo, m_tabNo, GridTab.CTX_KeyColumnName,
						m_onlyTab != null ? m_onlyTab.booleanValue() : false);
				value = Env.getContext(Env.getCtx(), m_windowNo, m_tabNo, keycolumnName, m_onlyTab != null ? m_onlyTab.booleanValue() : false);
			}
			else if (m_tabNo <= 0)
			{
				if (!tabOnly)
					value = Env.getContext (ctx, m_windowNo, variableName, m_onlyWindow);
				else
					value = Env.getContext (ctx, m_windowNo, m_tabNo, variableName, m_onlyTab.booleanValue(), m_onlyWindow);
			}
		    else
		    {		    	
		    	if (variableName.startsWith(Evaluator.VARIABLE_SELF_TAB_OPERATOR)) 
		    		variableName = variableName.substring(1);
		    	value = Env.getContext (ctx, m_windowNo, m_tabNo, variableName, tabOnly, true);
		    }
		}
		
		// po property operator
		Object dataValue = null;
		if (Util.isEmpty(value) && m_dataProvider != null && !globalVariable) {
			if (variableName.startsWith(Evaluator.VARIABLE_PO_PROPERTY_OPERATOR)) {
				variableName = variableName.substring(1);
				dataValue = m_dataProvider.getProperty(variableName);
				value = dataValue != null ? dataValue.toString() : "";
			}
		}
		
		//remove prefix from variable name
		boolean withTabNo = false;
		if (Env.isGlobalVariable(variableName)) {
			variableName = variableName.substring(1);				
		} else if (variableName.indexOf(Evaluator.VARIABLE_TAB_NO_SEPARATOR) > 0) {
			variableName = variableName.substring(variableName.lastIndexOf(Evaluator.VARIABLE_TAB_NO_SEPARATOR)+1);
			withTabNo = true;
		} else if (variableName.startsWith(Evaluator.VARIABLE_SELF_TAB_OPERATOR)) {
			variableName = variableName.substring(1);
			withTabNo = true;
		}
		
		//try window context again after removal of tab no
		if (!globalVariable && Util.isEmpty(value) && m_windowNo >= 0 && withTabNo && !tabOnly) {
			value = Env.getContext(ctx, m_windowNo, variableName);
		}
		
		// get value from data provider(usually PO or GridTab)
		if (Util.isEmpty(value) && m_dataProvider != null && !globalVariable) {
			dataValue = m_dataProvider.getValue(variableName);
			value = dataValue != null ? dataValue.toString() : "";
		}
		
		//try context if no data provider and not only window and not only tab
		if (!globalVariable && m_dataProvider == null && Util.isEmpty(value) && !m_onlyWindow && (m_onlyTab == null || !m_onlyTab.booleanValue())) {
			value = Env.getContext(ctx, variableName);
		}
		
		//fall back to default (if define)
		if (Util.isEmpty(value) && defaultValue != null)
			value = defaultValue;
		
		// get column from data provider (usually GridTab or PO)
		MColumn column = null;		
		if (!globalVariable) {
			if (m_dataProvider != null) {
				column = m_dataProvider.getColumn(variableName);
			}
		}
		
		// handle reference(.) operator
		if (!Util.isEmpty(value) && !Util.isEmpty(foreignColumn) && variableName.endsWith(Evaluator.ID_COLUMN_SUFFIX)) {
			int id = 0;
			try {
				id = Integer.parseInt(value);
			} catch (Exception e){}
			if (id > 0) {
				String defaultReferenceValue = "";
				String foreignTable = getForeignTableName(variableName, column);
				//verify fully qualified foreign column
				if (!Util.isEmpty(foreignTable)) {
					int tblIndex = foreignColumn.indexOf(".");
					if (tblIndex > 0) {
						String qualifiedTable = foreignColumn.substring(0, tblIndex);
						if (qualifiedTable.equalsIgnoreCase(foreignTable)) 
							foreignColumn = foreignColumn.substring(tblIndex + 1);
						else
							foreignTable = null;
					}
				}
				if (!Util.isEmpty(foreignTable)) {
					MTable table = MTable.get(Env.getCtx(), foreignTable);
					if (table != null) {
						dataValue = getColumnValue(table, foreignTable, foreignColumn, id, defaultReferenceValue);
						if (dataValue == null)
							value = "";
						else if (dataValue instanceof Boolean booleanValue)
							value = booleanValue ? "Y" : "N";
						else
							value = dataValue.toString();
					}
				}				
			}
		}
		
		// handle format in <> operator
		if (format != null && format.length() > 0) {
			String foreignTable = getForeignTableName(variableName, column);
			//no dot operator and variable name is *_ID
			if (Util.isEmpty(foreignColumn) && variableName.endsWith(Evaluator.ID_COLUMN_SUFFIX)) {
				int id = 0;
				try {
					id = Integer.parseInt(value);
				} catch (Exception e){}
				if (id > 0) {					
					//verify fully qualified foreign column
					if (!Util.isEmpty(foreignTable)) {
						int tblIndex = format.indexOf(".");
						if (tblIndex > 0) {
							String qualifiedTable = format.substring(0, tblIndex);
							if (qualifiedTable.equalsIgnoreCase(foreignTable)) 
								format = format.substring(tblIndex + 1);
							else
								foreignTable = null;
						}
					}
					if (!Util.isEmpty(foreignTable)) {
						MTable table = MTable.get(Env.getCtx(), foreignTable);
						if (table != null) {
							column = table.getColumn(format);
							if (column != null) {
								if (column.isSecure()) {
									value = "********";
								} else {
									String trxName = m_trxName != null ? m_trxName : (m_dataProvider != null ? m_dataProvider.getTrxName() : null);
									String keyCol = foreignTable + Evaluator.ID_COLUMN_SUFFIX;
									value = DB.getSQLValueString(trxName,"SELECT " + format + " FROM " + foreignTable + " WHERE " + keyCol + "=?", id);
								}
							}
						}
					}
				}				
			} else if (!Util.isEmpty(value) && !Util.isEmpty(foreignTable) && foreignTable.equals(MRefList.Table_Name) && column != null) {
				int refID = column.getAD_Reference_Value_ID();
				if (format.equals("Name"))
					value = MRefList.getListName(Env.getCtx(), refID, (String) value);
				else if (format.equals("Description"))
					value = MRefList.getListDescription(Env.getCtx(), DB.getSQLValueStringEx(null, "SELECT Name FROM AD_Reference WHERE AD_Reference_ID = ?", refID), value);
			} else if (dataValue != null && dataValue instanceof Date dateValue) {
				SimpleDateFormat df = new SimpleDateFormat(format);
				value = df.format(dateValue);
			} else if (dataValue != null && dataValue instanceof Number numberValue) {
				DecimalFormat df = new DecimalFormat(format);
				value = df.format(numberValue.doubleValue());
			} else if (dataValue != null) {
				MessageFormat mf = new MessageFormat(format);
				value = mf.format(dataValue);
			}			
		} else if (column != null) {
			if (column.isSecure()) {
				value = "********";
			} else if (column != null && column.getAD_Reference_ID() == DisplayType.YesNo && dataValue != null && dataValue instanceof Boolean booleanValue) {
				if (m_useMsgForBoolean ) {
					if (booleanValue.booleanValue())
						value = Msg.getMsg(Env.getCtx(), "Yes");
					else
						value = Msg.getMsg(Env.getCtx(), "No");
				} else {
					value = booleanValue.booleanValue() ? "Y" : "N";
				}
			} else if (column != null && DisplayType.isDate(column.getAD_Reference_ID()) && dataValue != null && dataValue instanceof Date dateValue && m_useColumnDateFormat) {
				SimpleDateFormat sdf = DisplayType.getDateFormat(column.getAD_Reference_ID());
				value = sdf.format (dateValue);
			}				
		} else if (dataValue != null && dataValue instanceof BigDecimal decimalValue) {
			int precision = MClient.get(Env.getCtx()).getAcctSchema().getStdPrecision();
			value = decimalValue.setScale(precision, RoundingMode.HALF_UP).toPlainString();
		}
		
		return value != null ? value : "";
	}

	/**
	 * Get reference table name
	 * @param variableName
	 * @param column
	 * @return null or reference table name
	 */
	private static String getForeignTableName(String variableName, MColumn column) {
		String foreignTable = null;
		if (column != null) {
			foreignTable = column.getReferenceTableName();
		} else if (variableName.endsWith(Evaluator.ID_COLUMN_SUFFIX)){
			foreignTable = variableName.substring(0, variableName.length()-3);
			if (MTable.get(Env.getCtx(), foreignTable) == null)
				foreignTable = null;
		}
		return foreignTable;
	}
	
	/**
	 * Get value of foreignColumn from foreignTable
	 * @param table
	 * @param foreignTable
	 * @param foreignColumn
	 * @param id record id for foreign table
	 * @param defaultValue default value
	 * @return value from foreign table or default value
	 */
	private Object getColumnValue(MTable table, String foreignTable, String foreignColumn, int id, String defaultValue) {
		Object returnValue = defaultValue; 
		String key = foreignTable+"|"+id;
		PO po = null;
		if (s_ReferenceCache.containsKey(key))
		{
			po = s_ReferenceCache.get(key);
			if (po != null && po.get_ID() == id)
			{
				returnValue = po.get_Value(foreignColumn);				
			}
			else
				po = null;
		}
		if (po == null)
		{
			po = table.getPO(id, null);
			if (po != null && po.get_ID() == id)
			{
				s_ReferenceCache.put(key, po);
				returnValue = po.get_Value(foreignColumn);
			}						 						
		}
		return returnValue;
	}
	
	/**
	 * CacheChangeListener for {@link DefaultEvaluatee#s_ReferenceCache}
	 */
	private static final class ReferenceCache extends CCache<String, PO> implements CacheChangeListener {

		private static final long serialVersionUID = 6884795644185015913L;

		private ReferenceCache(String name, int initialCapacity, int expireMinutes, int maxSize) {
			super(null, name, initialCapacity, expireMinutes, false, maxSize);
		}

		@Override
		public void reset(String tableName) {
			String filter = tableName + "|";
			List<String> keys = keySet().stream().filter(e -> e.startsWith(filter)).collect(Collectors.toList());
			if (!keys.isEmpty()) {
				for(String key : keys)
					remove(key);
			}
		}

		@Override
		public void reset(String tableName, int recordId) {
			String key = tableName + "|" + recordId;
			remove(key);
		}
	}
	
	/**
	 * Is using message translation for boolean data value
	 * @return true if using message translation for boolean data value
	 */
	public boolean isUseMsgForBoolean() {
		return m_useMsgForBoolean;
	}

	/**
	 * Set the use of message translation for boolean data value
	 * @param useMsgForBoolean
	 */
	public void setUseMsgForBoolean(boolean useMsgForBoolean) {
		this.m_useMsgForBoolean = useMsgForBoolean;
	}

	/**
	 * Is using column display format for date data value
	 * @return true if using column display format for date data value
	 */
	public boolean isUseColumnDateFormat() {
		return m_useColumnDateFormat;
	}

	/**
	 * Set the use of column display format for date data value
	 * @param useColumnDateFormat
	 */
	public void setUseColumnDateFormat(boolean useColumnDateFormat) {
		this.m_useColumnDateFormat = useColumnDateFormat;
	}
	
	/**
	 * Data provider interface
	 */
	public static interface DataProvider {
		/**
		 * Get column value via column name
		 * @param columnName
		 * @return null or value for columnName
		 */
		Object getValue(String columnName);
		
		/**
		 * Get value via bean property name
		 * @param propertyName
		 * @return null or value for propertyName
		 */
		Object getProperty(String propertyName);
		
		/**
		 * Get column via column name
		 * @param columnName
		 * @return null or column for columnName
		 */
		MColumn getColumn(String columnName);
		
		/**
		 * Get transaction name
		 * @return null or transaction name
		 */
		String getTrxName();
	}
	
	/**
	 * Get wrapped PO 
	 * @return wrapped PO or null
	 */
	public PO getPO() {
		if (m_dataProvider != null && m_dataProvider instanceof PODataProvider pdp) {
			return pdp.po;
		}
		return null;
	}
	
	/**
	 * Data provider implementation for PO
	 */
	public static class PODataProvider implements DataProvider {

		private PO po;

		public PODataProvider(PO po) {
			this.po = po;
		}
		
		@Override
		public Object getValue(String columnName) {
			if (po != null && po.get_ColumnIndex(columnName) >= 0)
				return po.get_Value(columnName);
				
			return null;
		}

		@Override
		public Object getProperty(String propertyName) {
			char startChar = propertyName.charAt(0);
			if (startChar != Character.toUpperCase(startChar)) {
				propertyName = Character.toUpperCase(startChar) + propertyName.substring(1);
			}
			String methodName = "get" + propertyName;
			Expression methodExpression = new Expression(po, methodName, null);
			Object poValue = null;
			try {
				poValue = methodExpression.getValue();
			} catch (Exception e) {				
			}
			return poValue;
		}

		@Override
		public MColumn getColumn(String columnName) {
			MColumn column = null;
			if (po != null) {
				if (po.get_ColumnIndex(columnName) >= 0) {
					column = MColumn.get(Env.getCtx(), po.get_TableName(), columnName);
				}
			}
			return column;
		}

		@Override
		public String getTrxName() {
			return po != null ? po.get_TrxName() : null;
		}
		
	}
	
	/**
	 * Data provider implementation for GridTab
	 */
	public static class GridTabDataProvider implements DataProvider {

		private GridTab gridTab;

		public GridTabDataProvider(GridTab gridTab) {
			this.gridTab = gridTab;
		}
		
		@Override
		public Object getValue(String columnName) {
			if (gridTab != null && gridTab.getField(columnName) != null) 
				return gridTab.getValue(columnName);
				
			return null;
		}

		@Override
		public Object getProperty(String propertyName) {
			return null;
		}

		@Override
		public MColumn getColumn(String columnName) {
			MColumn column = null;
			if (gridTab != null) {
				column = MColumn.get(Env.getCtx(), gridTab.getTableName(), columnName);					
				if (column == null) {
					//try parent
					GridTab parent = gridTab.getParentTab();
					while (column == null && parent != null) {
						column = MColumn.get(Env.getCtx(), parent.getTableName(), columnName);
						parent = parent.getParentTab();
					}
				}
			}
			return column;
		}

		@Override
		public String getTrxName() {
			return null;
		}		
	}
}
