/******************************************************************************
 * Project: Trek Global ERP                                                   *                       
 * Copyright (C) 2009-2018 Trek Global Corporation                            *
 *                                                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.print.layout;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Util;

/**
 * 
 * @author hengsin
 *
 */
public class PrintDataEvaluatee implements Evaluatee {

	private PrintData m_data;
	private Page m_page;
	
	public PrintDataEvaluatee(Page page, PrintData data) {
		m_data = data;
		m_page = page;
	}

	@Override
	public String get_ValueAsString(String variableName) {
		if (Page.CONTEXT_PAGE.equals(variableName)) {
			return m_page != null ? String.valueOf(m_page.getPageNo()) : "1";
		} else if (Page.CONTEXT_PAGECOUNT.equals(variableName)) {
			return m_page != null ? String.valueOf(m_page.getPageCount()) : "1";
		}
		
		//ref column
		String foreignColumn = "";
		int f = variableName.indexOf('.');
		if (f > 0) {
			foreignColumn = variableName.substring(f+1, variableName.length());
			variableName = variableName.substring(0, f);
		}
		
		String value = null;
		if (variableName.startsWith("#") || variableName.startsWith("$")) {
			value  = Env.getContext(Env.getCtx(), variableName);
		} else {
			Object obj = m_data.getNode(variableName);
			if ( obj == null || !(obj instanceof PrintDataElement))
				return "";
			PrintDataElement data = (PrintDataElement) obj;
			if (data.isNull() )
				return "";
			
			if (data.getValue() instanceof Boolean)
				value = ((Boolean)data.getValue()).booleanValue() ? "Y" : "N";
			else
				value = data.getValueAsString();
		}
		if (!Util.isEmpty(value) && !Util.isEmpty(foreignColumn) && variableName.endsWith("_ID")) {
			String refValue = "";
			int id = 0;
			try {
				id = Integer.parseInt(value);
			} catch (Exception e){}
			if (id > 0) {
				String tableName = null;
				if (!Util.isEmpty(m_data.getTableName()))
					tableName = m_data.getTableName();
				else
					tableName = variableName.substring(0, variableName.length()-3);
				MColumn column = MColumn.get(m_data.getCtx(), tableName, variableName);
				if (column != null) {
					String foreignTable = column.getReferenceTableName();
					refValue = DB.getSQLValueString(null,
							"SELECT " + foreignColumn + " FROM " + foreignTable + " WHERE " 
							+ foreignTable + "_ID = ?", id);
				} else {
					if (variableName.startsWith("#") || variableName.startsWith("$")) {
						variableName = variableName.substring(1);
					} else if (variableName.indexOf("|") > 0) {
						variableName = variableName.substring(variableName.lastIndexOf("|")+1);
					}
					String foreignTable = null;
					if (foreignColumn.indexOf(".") > 0) {
						foreignTable = foreignColumn.substring(0, foreignColumn.indexOf("."));
					} else {
						foreignTable = variableName.substring(0, variableName.length()-3);
					}
					MTable t = MTable.get(Env.getCtx(), foreignTable);
					if (t != null) {
						refValue = DB.getSQLValueString(null,
								"SELECT " + foreignColumn + " FROM " + foreignTable + " WHERE " 
								+ foreignTable + "_ID = ?", id);
					}
				}
			}
			return refValue;
		}
		return value;
	}
	
	public static boolean hasPageLogic(String displayLogic) {
		if (Util.isEmpty(displayLogic, true))
			return false;
		return displayLogic.contains("@*Page");
	}
}
