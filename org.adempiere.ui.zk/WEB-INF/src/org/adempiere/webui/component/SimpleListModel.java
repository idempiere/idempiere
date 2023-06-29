/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution       
 * Copyright (C) 2008 Low Heng Sin  All Rights Reserved.                      *
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
package org.adempiere.webui.component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.compiere.apps.form.TreeMaintenance;
import org.zkoss.lang.Objects;
import org.zkoss.zul.AbstractListModel;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;
import org.zkoss.zul.event.ListDataEvent;
import org.zkoss.zul.ext.Sortable;

/**
 * List model for {@link Listbox} that also implements {@link ListitemRenderer} interface. 
 * @author Low Heng Sin
 */
public class SimpleListModel extends AbstractListModel<Object> implements ListitemRenderer<Object>, ListitemRendererExt, Sortable<Object> {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -572148106182756840L;

	/** List backing this model instance */
	protected List<Object> list;
	
	/** Comparator for sorting */
	private Comparator<Object> _sorting;

	/** Sort Direction. True for Ascending, False for Descrending */
	private boolean _sortDir;
	
	/** Max length for each column (value <= 0 means no Max length) */
	private int[] maxLength;

	/**
	 * Default constructor
	 */
	public SimpleListModel() {
		this(new ArrayList<Object>());
	}
	
	/**
	 * Create model from list
	 * @param list List<?>
	 */
	@SuppressWarnings("unchecked")
	public SimpleListModel(List<?> list) {
		this.list = (List<Object>)list;
	}
	
	@Override
	public Object getElementAt(int index) {
		if (index >= 0 && index < list.size())
			return list.get(index);
		else
			return null;
	}

	@Override
	public int getSize() {
		return list.size();
	}

	/**
	 * Truncate src to maxLength.<br/> 
	 * "..." will be added to the end of truncated text to indicate text have been truncated.
	 * @param src Input text
	 * @param maxLength Maximum length of text
	 * @return truncated text
	 */
	protected StringBuffer truncate(String src, int maxLength) {
		int j = maxLength;
		while (j > 0 && Character.isWhitespace(src.charAt(j - 1)))
			--j;
		return new StringBuffer(j + 3)
			.append(src.substring(0, j)).append("...");
	}
	
	@Override
	public void render(Listitem item, Object data, int index) throws Exception {
		if (data instanceof Object[]) {
			renderArray(item, (Object[])data);
		} else if (data instanceof Collection) {
			renderCollection(item, (Collection<?>)data);
		} else {
			String value = data != null ? data.toString() : "";
			renderCell(0, item, value);
		}		
	}
	
	/**
	 * Render text {@link Listbox} cell/column
	 * @param col Column index
	 * @param item Listitem 
	 * @param value Text content for cell
	 */
	protected void renderCell(int col, Listitem item, String value) {
		String tooltip = null;
		if (maxLength != null && maxLength.length > col && maxLength[col] > 0 && value.length() > maxLength[col]) {
			tooltip = value;
			value = truncate(value, maxLength[col]).toString();
		}
		ListCell listCell = new ListCell(value);
		listCell.setParent(item);			
		if (tooltip != null)
			listCell.setTooltiptext(tooltip);
		// IDEMPIERE-492
		boolean isSummary = false;
		Object li = null;
		if (item != null && list != null)
			li = list.get(item.getIndex());
		if (li != null && li instanceof TreeMaintenance.ListItem)
			isSummary = ((TreeMaintenance.ListItem)li).isSummary;
		if (isSummary)
			ZkCssHelper.appendStyle(listCell, "font-weight: bold");
	}

	/**
	 * Render collection of values
	 * @param item Listitem 
	 * @param data Collection<?>
	 */
	private void renderCollection(Listitem item, Collection<?> data) {
		int i = 0;
		for (Object col : data) {
			String value = (col != null ? col.toString() : "");
			renderCell(i, item, value);
			i++;
		}
	}

	/**
	 * Render array of values
	 * @param item Listitem 
	 * @param data Object[] 
	 */
	private void renderArray(Listitem item, Object[] data) {
		int i = 0;
		for (Object col : data) {			
			String value = (col != null ? col.toString() : "");
			renderCell(i, item, value);
			i++;
		}
	}

	@Override
	public int getControls() {
		return DETACH_ON_RENDER;
	}

	@Override
	public Listcell newListcell(Listitem item) {
		return null;
	}

	@Override
	public Listitem newListitem(Listbox listbox) {
		ListItem item = new ListItem();
		item.applyProperties();
		return item;
	}
	
	/**
	 * Set max length for each column
	 * @param maxLength int[]
	 */
	public void setMaxLength(int[] maxLength) {
		this.maxLength = maxLength;
	}
	
	/**
	 * Append new row
	 * @param obj Object 
	 */
	public void addElement(Object obj) {
		list.add(obj);
		int index = list.size() - 1;
		fireEvent(ListDataEvent.INTERVAL_ADDED, index, index);
	}
	
	/**
	 * Add new row at index
	 * @param index
	 * @param obj Object 
	 */
	public void add(int index, Object obj) {
		list.add(index, obj);
		fireEvent(ListDataEvent.INTERVAL_ADDED, index, index);
	}

	/**
	 * Remove all elements
	 */
	public void removeAllElements() {
		list.clear();
		fireEvent(ListDataEvent.CONTENTS_CHANGED, -1, -1);
	}

	/**
	 * Remove element from list
	 * @param element
	 */
	public void removeElement(Object element) {
		int index = list.indexOf(element);
		list.remove(element);
		fireEvent(ListDataEvent.INTERVAL_REMOVED, index, index); 
	}

	/**
	 * Replace element at index
	 * @param element Object
	 * @param index List index
	 */
	public void setElementAt(Object element, int index) {
		list.set(index, element);
		fireEvent(ListDataEvent.CONTENTS_CHANGED, index, index);
	}

	public int indexOf(Object value) {
		return list.indexOf(value);
	}

	@Override
	public void sort(Comparator<Object> cmpr, boolean ascending) {
		_sorting = cmpr;
		_sortDir = ascending;
		Collections.sort(list, cmpr);
		fireEvent(ListDataEvent.STRUCTURE_CHANGED, -1, -1);
	}

	@Override
	public String getSortDirection(Comparator<Object> cmpr) {
		if (Objects.equals(_sorting, cmpr))
			return _sortDir ?
					"ascending" : "descending";
		return "natural";
	}
}
