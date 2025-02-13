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
package org.adempiere.webui.listbox.renderer;

import org.adempiere.webui.component.ListitemGroup;
import org.adempiere.webui.component.ListitemGroup.ListitemGroupHeader;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listgroup;
import org.zkoss.zul.ListgroupRendererExt;
import org.zkoss.zul.Listgroupfoot;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;

/**
 * Abstract renderer base class for {@link Listbox} with single level grouping.<br/>
 * Note1: due to a class hierarchy issue, this wouldn't works with {@link org.adempiere.webui.component.Listbox}.<br/>
 * Note2: not working very well with {@link Listbox#setCheckmark(boolean) Listbox.setCheckmark(true)}. Recommended to roll your own checkbox cell if you need multiple selection. 
 * @author hengsin
 * @param <T> Common ancestor type for Group and Item class.
 * @see https://github.com/idempiere/idempiere-examples/blob/master/org.idempiere.listbox.group.example/src/org/idempiere/listbox/group/example/BPartnerGroupRenderer.java
 */
public abstract class AbstractGroupListitemRenderer<T> implements ListitemRenderer<T>, ListitemRendererExt, ListgroupRendererExt {
	
	public AbstractGroupListitemRenderer() {
	}
	
	@Override
	public Listgroup newListgroup(Listbox listbox) {
		Listgroup group = new ListitemGroup();
		group.applyProperties();
		return group;
	}

	@Override
	public Listgroupfoot newListgroupfoot(Listbox listbox) {
		Listgroupfoot groupfoot = new Listgroupfoot();
		groupfoot.applyProperties();
		return groupfoot;
	}

	@Override
	public Listitem newListitem(Listbox listbox) {
		Listitem 	listitem = new Listitem();
		listitem.applyProperties();
		return listitem;
	}

	@Override
	public Listcell newListcell(Listitem item) {
		return null;// Default Cell
	}
	
	@Override
	public int getControls() {
        return ListitemRendererExt.DETACH_ON_RENDER; // Default Value
    }
	
	/**
	 * @return number of columns for listbox
	 */
	public abstract int getColumnCount();
	
	/**
	 * @param data group
	 * @return group header title
	 */
	public abstract String getGroupHeaderTitle(T data);
	
	/**
	 * Renders the data to the specified list item.
	 * @param item the listitem to render the result.
	 * @param data item within a group
	 * @param index the row/list index of the data that is currently being rendered
	 */
	public abstract void renderListitem(Listitem item, T data, int index);

	/**
	 * Render group
	 * @param item
	 * @param data group
	 * @param index
	 */
	public void renderGroup(Listitem item, T data, int index)
	{
		ListitemGroupHeader cell = new ListitemGroupHeader();
		cell.applyProperties();
		cell.setSpan(getColumnCount());
		cell.setTitle(getGroupHeaderTitle(data));
		item.appendChild(cell);		
	}
	
	/**
	 * Render group footer
	 * @param item
	 * @param data footer
	 * @param index
	 */
	public void renderGroupfoot(Listitem item, T data, int index)
	{
		
	}
	
	@Override
	public void render(Listitem item, T data, int index) throws Exception {
		if(item instanceof ListitemGroup)
    	{
			item.removeChild(item.getFirstChild());    		
    		renderGroup(item, data, index);
    	}
    	else
    	{
    		if (item.getListgroup() instanceof ListitemGroup)
    		{
    			ListitemGroup group = (ListitemGroup) item.getListgroup();
    			group.add(item);
    		}
    		
    		if (item instanceof Listgroupfoot)
    		{
    			item.setZclass("z-groupfoot");
    			renderGroupfoot(item, data, index);
    		}
    		else
    		{
    			item.setStyle("vertical-align: top;");
    			item.setValue(data);
    			renderListitem(item, data, index);
    		}
    	}
	}
}
