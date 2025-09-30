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
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Evaluatee;
import org.compiere.util.Util;

/**
 * {@link Evaluatee} implementation for {@link PrintData}
 * @author hengsin
 *
 */
public class PrintDataEvaluatee implements Evaluatee {

	private PrintData m_data;
	private Page m_page;
	
	/**
	 * @param page
	 * @param data
	 */
	public PrintDataEvaluatee(Page page, PrintData data) {
		m_data = data;
		m_page = page;
	}

	@Override
	public String get_ValueAsString(String variableName) {
		DefaultEvaluatee evaluatee = new DefaultEvaluatee(new PrintDataDataProvider(m_page, m_data));
		return evaluatee.get_ValueAsString(variableName);
	}
	
	/**
	 * Is displayLogic has page expression
	 * @param displayLogic
	 * @return true if displayLogic has page expression
	 */
	public static boolean hasPageLogic(String displayLogic) {
		if (Util.isEmpty(displayLogic, true))
			return false;
		return displayLogic.contains("@*Page");
	}
	
	public static class PrintDataDataProvider implements DefaultEvaluatee.DataProvider {

		private Page m_page;
		private PrintData m_data;

		public PrintDataDataProvider(Page page, PrintData data) {
			this.m_page = page;
			this.m_data = data;
		}
		
		@Override
		public Object getValue(String columnName) {
			if (Page.CONTEXT_PAGE.equals(columnName)) {
				return m_page != null ? String.valueOf(m_page.getPageNo()) : "1";
			} else if (Page.CONTEXT_PAGECOUNT.equals(columnName)) {
				return m_page != null ? String.valueOf(m_page.getPageCount()) : "1";
			}
			
			Object obj = m_data.getNode(columnName);
			if ( obj == null || !(obj instanceof PrintDataElement))
				return "";
			PrintDataElement data = (PrintDataElement) obj;
			if (data.isNull() )
				return "";
			
			if (data.getValue() instanceof Boolean)
				return ((Boolean)data.getValue()).booleanValue() ? "Y" : "N";
			else
				return data.getValueAsString();			
		}

		@Override
		public Object getProperty(String propertyName) {
			return null;
		}

		@Override
		public MColumn getColumn(String columnName) {
			MColumn column = null;
			String tableName = m_data.getTableName();
			if (!Util.isEmpty(tableName))
				column = MColumn.get(m_data.getCtx(), tableName, columnName);
			
			return column;
		}

		@Override
		public String getTrxName() {
			return null;
		}
		
	}
}
