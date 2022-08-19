/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.event;

import org.compiere.model.MQuery;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;

/**
 * 
 * @author hengsin
 *
 */
public class DrillEvent extends Event {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4877800961258241047L;
	public final static String ON_DRILL_DOWN = "onDrillDown";
	public final static String ON_DRILL_ACROSS = "onDrillAcross";
	
	public DrillEvent(String name, Component target, Object data) {
		super(name, target, data);
	}

	public static class DrillData {

		private MQuery query;

		private String columnName;

		private String displayValue;

		private Object value;

		private Object data;

		public DrillData(MQuery query, String columnName, Object value, String displayValue, Object data) {
			this.query = query;
			this.columnName = columnName;
			this.value = value;
			this.data = data;
			this.displayValue = displayValue;
		}

		public MQuery getQuery() {
			return query;
		}

		public String getColumnName() {
			return columnName;
		}

		public Object getValue() {
			return value;
		}

		public Object getData() {
			return data;
		}

		public String getDisplayValue() {
			return displayValue;
		}


	}

}
