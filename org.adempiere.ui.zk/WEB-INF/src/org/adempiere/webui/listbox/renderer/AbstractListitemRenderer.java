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

import org.zkoss.zul.ListModel;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;

/**
 * Abstract renderer base class for list box
 * @param <T>
 */
public abstract class AbstractListitemRenderer<T> implements ListitemRenderer<T>, ListitemRendererExt {
	
	public AbstractListitemRenderer() {
	}

	@Override
	public Listitem newListitem(Listbox listbox) {
		Listitem listitem = new Listitem();
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
	 * Renders data to the specified list item.
	 * @param item the listitem to render the result.
	 * @param data data returned from {@link ListModel#getElementAt}
	 * @param index the row/list index of data that is currently being rendered
	 */
	public abstract void renderListitem(Listitem item, T data, int index);
	
	@Override
	public void render(Listitem item, T data, int index) throws Exception {
		item.setStyle("vertical-align: top;");
		item.setValue(data);
		renderListitem(item, data, index);
	}
}
