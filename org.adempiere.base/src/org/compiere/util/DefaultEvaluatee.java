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

import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.compiere.model.GridTab;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;

/**
 * @author hengsin
 *
 */
public class DefaultEvaluatee implements Evaluatee {

	private GridTab m_GridTab;
	private int m_WindowNo;
	private int m_TabNo;

	private static final ReferenceCache s_ReferenceCache = new ReferenceCache("DefaultEvaluatee_ReferenceCache", 100, 1, 2000);
	
	/**
	 * 
	 * @param gridTab
	 * @param windowNo
	 * @param tabNo
	 */
	public DefaultEvaluatee(GridTab gridTab, int windowNo, int tabNo) {
		this.m_GridTab = gridTab;
		this.m_WindowNo = windowNo;
		this.m_TabNo = tabNo;
	}

	@Override
	public String get_ValueAsString(String variableName) {
		return get_ValueAsString(Env.getCtx(), variableName);
	}

	/**
	 * 	Get Variable Value (Evaluatee)
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (Properties ctx, String variableName)
	{
		//ref column
		String foreignColumn = "";
		int f = variableName.indexOf('.');
		if (f > 0) {
			foreignColumn = variableName.substring(f+1, variableName.length());
			variableName = variableName.substring(0, f);
		}
		
		String value = null;
		if( m_TabNo == 0)
	    	value = Env.getContext (ctx, m_WindowNo, variableName, true);
	    else
	    {
	    	boolean tabOnly = false;
	    	if (variableName.startsWith("~")) 
	    	{
	    		variableName = variableName.substring(1);
	    		tabOnly = true;
	    	}
	    	value = Env.getContext (ctx, m_WindowNo, m_TabNo, variableName, tabOnly, true);
	    }
		if (!Util.isEmpty(value) && !Util.isEmpty(foreignColumn) && variableName.endsWith("_ID")) {
			int id = 0;
			try {
				id = Integer.parseInt(value);
			} catch (Exception e){}
			if (id > 0) {
				String refValue = "";
				MColumn column = null;
				if (m_GridTab != null) {
					column = MColumn.get(ctx, m_GridTab.getTableName(), variableName);					
					if (column == null) {
						//try parent
						GridTab parent = m_GridTab.getParentTab();
						while (column == null && parent != null) {
							column = MColumn.get(ctx, parent.getTableName(), variableName);
							parent = parent.getParentTab();
						}
					}
				}
				if (column != null) {
					String foreignTable = column.getReferenceTableName();
					MTable table = MTable.get(Env.getCtx(), foreignTable);
					if (table != null) {
						return getColumnValue(table, foreignTable, foreignColumn, id, refValue);
					}
				} else {
					// no MColumn found, try tableName from columnName
					String foreignTable = variableName.substring(0, variableName.length()-3);
					MTable table = MTable.get(ctx, foreignTable);
					if (table != null) {
						return getColumnValue(table, foreignTable, foreignColumn, id, refValue);
					}
				}
			}
		}
		return value;
	}

	private String getColumnValue(MTable table, String foreignTable, String foreignColumn, int id, String refValue) {
		String key = foreignTable+"|"+id;
		PO po = null;
		if (s_ReferenceCache.containsKey(key))
		{
			po = s_ReferenceCache.get(key);
			if (po != null && po.get_ID() == id)
				refValue = po.get_ValueAsString(foreignColumn);
			else
				po = null;
		}
		if (po == null)
		{
			po = table.getPO(id, null);
			if (po != null && po.get_ID() == id)
			{
				s_ReferenceCache.put(key, po);
				refValue = po.get_ValueAsString(foreignColumn);
			}						 						
		}
		return refValue;
	}
	
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
}
