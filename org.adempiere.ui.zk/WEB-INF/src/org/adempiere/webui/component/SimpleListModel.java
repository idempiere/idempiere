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
 * 
 * @author Low Heng Sin
 *
 */
public class SimpleListModel extends AbstractListModel<Object> implements ListitemRenderer<Object>, ListitemRendererExt, Sortable<Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -572148106182756840L;

	protected List<Object> list;
	
	private Comparator<Object> _sorting;

	private boolean _sortDir;
	
	private int[] maxLength;

	public SimpleListModel() {
		this(new ArrayList<Object>());
	}
	
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
	}

	private void renderCollection(Listitem item, Collection<?> data) {
		int i = 0;
		for (Object col : data) {
			String value = (col != null ? col.toString() : "");
			renderCell(i, item, value);
			i++;
		}
	}

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
	
	public void setMaxLength(int[] maxLength) {
		this.maxLength = maxLength;
	}
	
	public void addElement(Object obj) {
		list.add(obj);
		int index = list.size() - 1;
		fireEvent(ListDataEvent.INTERVAL_ADDED, index, index);
	}
	
	public void add(int index, Object obj) {
		list.add(index, obj);
		fireEvent(ListDataEvent.INTERVAL_ADDED, index, index);
	}

	public void removeAllElements() {
		list.clear();
		fireEvent(ListDataEvent.CONTENTS_CHANGED, -1, -1);
	}

	public void removeElement(Object element) {
		int index = list.indexOf(element);
		list.remove(element);
		fireEvent(ListDataEvent.INTERVAL_REMOVED, index, index); 
	}

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
