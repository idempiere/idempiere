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
package org.adempiere.webui.component;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.webui.util.ZKUpdateUtil;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Label;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listgroup;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Span;

/**
 * Single level grouping for {@link Listbox}.<br/>
 * Note that due to a class hierarchy issue, this wouldn't works with {@link org.adempiere.webui.component.Listbox}. 
 */
public class ListitemGroup extends Listgroup {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1790997329703776505L;

	/** Listitem attribute to store visibility of a group */
	public static final String GROUP_LISTITEM_VISIBLE_KEY = "groupListitemVisible";

	/** The list of Listitem of this group */
	private List<Listitem> m_items = new ArrayList<Listitem>();

	/**
	 * Default constructor
	 */
	public ListitemGroup() {
		super();
	}
	
	/**
	 * @param label group label
	 */
	public ListitemGroup(String label) {
		super(label);
	}
	
	/**
	 * @param <T>
	 * @param label
	 * @param value
	 */
	public <T> ListitemGroup(String label, T value) {
		super(label, value);
	}

	/**
	 * @return group label/header
	 */
	public String getLabel() {
		final Component cell = getFirstChild();
		return cell != null && cell instanceof ListitemGroupHeader ? ((ListitemGroupHeader)cell).getTitle() : null;
	}

	@Override
	public void setLabel(String label) {
		getOrCreateGroupHeader().setTitle(label);
	}
	
	/**
	 * Set column span of group header (first cell)
	 * @param colspan
	 */
	public void setColspan(int colspan) {
		getOrCreateGroupHeader().setSpan(colspan);
	}
	
	/**
	 * Get/create group header cell
	 * @return {@link ListitemGroupHeader}
	 */
	private ListitemGroupHeader getOrCreateGroupHeader() {
		Component cell = getChildren().size() == 0 || getChildren().size() == 1 ? getFirstChild() : getFirstChild().getNextSibling();
		if (cell == null || cell instanceof ListitemGroupHeader) {
			if (cell == null) cell = new ListitemGroupHeader();
			cell.applyProperties();
			cell.setParent(this);
			return (ListitemGroupHeader)cell;
		}
		throw new UiException("Unsupported child for setLabel: "+cell);
	}
	
	@Override
	public void setOpen(boolean open) {
		super.setOpen(open);
		getOrCreateGroupHeader().setOpen(isOpen());
		
		if (getParent() != null)
		{
			for (Listitem item : m_items)
			{
				boolean visible = true;
				String value = (String) item.getAttribute(GROUP_LISTITEM_VISIBLE_KEY);
				if (value != null)
					visible = value.equals("true");				
				item.setVisible(isOpen() && visible);	// hide the row of the children when group is not open
			}
		}
	}
	
	/**
	 * Add Listitem to group
	 * @param item
	 */
	public void add(Listitem item) {
		m_items.add(item);
	}

	/**
	 * Custom Listcell class for list group header	 
	 */
	public static class ListitemGroupHeader extends Listcell implements EventListener<Event>
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
		public ListitemGroupHeader()
		{
			super();
			init();
			setTitle(null);
			setOpen(true);
			ZKUpdateUtil.setVflex(this, "1");
		}
		
		/**
		 * Layout header cell
		 */
		private void init()
		{
			setZclass("z-listgroup-header");
			
			span = new Span();
			span.setZclass("z-listgroup-icon");
			appendChild(span);
			span.addEventListener(Events.ON_CLICK, this);
			
			lbl = new Label();
			lbl.setStyle("cursor: pointer");
			appendChild(lbl);
			lbl.addEventListener(Events.ON_CLICK, this);
		}
		
		/**
		 * @return group header text
		 */
		public String getTitle() {
			return title;
		}

		/**
		 * Set group header text
		 * @param title
		 */
		public void setTitle(String title) {
			this.title = title;
			lbl.setValue(this.title);
		}

		/**
		 * @return true if group is open, false otherwise
		 */
		public boolean isOpen() {
			return open;
		}

		/**
		 * Set group state to open or close
		 * @param open true for open state, false for close state
		 */
		public void setOpen(boolean open) {
			this.open = open;
			span.setSclass(this.open ? "z-icon-listgroup-open" : "z-icon-listgroup-close");
		}

		@Override
		public void onEvent(Event e) throws Exception 
		{
			if (e.getName().equals(Events.ON_CLICK))
			{
				((ListitemGroup) getParent()).setOpen(!isOpen());
			}
		}
	}

}
