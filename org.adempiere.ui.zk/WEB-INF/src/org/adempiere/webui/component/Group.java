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
 * - etan                                                              *
 * - carlos                                                            *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.component;

import java.util.ArrayList;
import java.util.List;

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;
import org.zkoss.zul.Row;
import org.zkoss.zul.Span;

/**
 * Extend {@link org.zkoss.zul.Group} 
 */
public class Group extends org.zkoss.zul.Group {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6735090880559291438L;

	/** {@link Row} attribute to hold visibility state of row */
	public static final String GROUP_ROW_VISIBLE_KEY = "groupRowVisible";

	private List<org.adempiere.webui.component.Row> m_rows = new ArrayList<org.adempiere.webui.component.Row>();

	/**
	 * Default constructor
	 */
	public Group() {
		super();
		setZclass("z-group");
	}
	
	/**
	 * @param label
	 */
	public Group(String label) {
		super(label);
		setZclass("z-group");
	}
	
	/**
	 * @param <T>
	 * @param label
	 * @param value
	 */
	public <T> Group(String label, T value) {
		super(label, value);
		setZclass("z-group");
	}

	/**
	 * @return group label
	 */
	public String getLabel() {
		final Component cell = getFirstChild();
		return cell != null && cell instanceof GroupHeader ? ((GroupHeader)cell).getTitle() : null;
	}

	@Override
	public void setLabel(String label) {
		autoFirstCell().setTitle(label);
	}	
	
	/**
	 * @return GroupHeader
	 */
	private GroupHeader autoFirstCell() {
		Component cell = getFirstChild();
		if (cell == null || cell instanceof GroupHeader) {
			if (cell == null) cell = new GroupHeader();
			cell.applyProperties();
			cell.setParent(this);
			return (GroupHeader)cell;
		}
		throw new UiException("Unsupported child for setLabel: "+cell);
	}
	
	/**
	 * Set open/close state of group
	 * @param open true for open state, false for close state
	 */
	public void setOpen(boolean open) {
		super.setOpen(open);
		autoFirstCell().setOpen(isOpen());
		
		if (getParent() != null)
		{
			for (Row row : m_rows)
			{
				boolean visible = true;
				String value = (String) row.getAttribute(GROUP_ROW_VISIBLE_KEY);
				if (value != null)
					visible = value.equals("true");				
				row.setVisible(isOpen() && visible);	// hide the row of the children when group is not open
			}
		}
	}
	
	/**
	 * Add row to group
	 * @param row
	 */
	public void add(org.adempiere.webui.component.Row row) {
		m_rows.add(row);
	}

	/**
	 * Group header component 
	 */
	public static class GroupHeader extends Cell implements EventListener<Event>
	{
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = -4070011056533999557L;
		private Span span;
		private Label lbl;
		
		private String title;
		private boolean open;
		
		/**
		 * Default constructor
		 */
		public GroupHeader()
		{
			super();
			init();
			setTitle(null);
			setOpen(true);
		}
		
		/**
		 * Layout component
		 */
		private void init()
		{
			setZclass("z-group-header");
			
			Div div = new Div();
			div.setZclass("z-group-header-body");
			appendChild(div);
			
			span = new Span();
			div.appendChild(span);
			span.addEventListener(Events.ON_CLICK, this);
			span.setZclass("z-group-icon");
			
			lbl = new Label();
			lbl.setStyle("cursor: pointer");
			lbl.addEventListener(Events.ON_CLICK, this);
			div.appendChild(lbl);
		}
		
		/**
		 * @return group title
		 */
		public String getTitle() {
			return title;
		}

		/**
		 * set group title
		 * @param title
		 */
		public void setTitle(String title) {
			this.title = title;
			lbl.setValue(this.title);
		}

		/**
		 * @return true if open, false otherwise
		 */
		public boolean isOpen() {
			return open;
		}

		/**
		 * Set open/close state of group
		 * @param open
		 */
		public void setOpen(boolean open) {
			this.open = open;
			span.setSclass(this.open ? "z-group-icon-open" : "z-group-icon-close");
		}

		@Override
		public void onEvent(Event e) throws Exception 
		{
			if (e.getName().equals(Events.ON_CLICK))
			{
				((Group) getParent()).setOpen(!isOpen());
			}
		}
	}

}
