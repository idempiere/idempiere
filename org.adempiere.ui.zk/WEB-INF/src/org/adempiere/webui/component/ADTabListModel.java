/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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

import java.util.List;

import org.adempiere.webui.adwindow.IADTabbox;
import org.zkoss.zul.AbstractListModel;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;

/**
 * List model and List item renderer implementation for list of AD_Tab label.<br/>
 * ADTabLabel class aside, this is not use any more.  
 */
public class ADTabListModel extends AbstractListModel<Object> implements ListitemRenderer<Object>, ListitemRendererExt {
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7683969121090679214L;
	protected List<ADTabLabel> listItems = null;
	private IADTabbox tabbox;
	
	/**
	 * @param listItems
	 * @param tabbox
	 */
	public ADTabListModel(List<ADTabLabel> listItems, IADTabbox tabbox) {
		this.listItems = listItems;
		this.tabbox = tabbox;
	}

	@Override
	public Object getElementAt(int index) {
		ADTabLabel item = index < listItems.size() ? listItems.get(index) : null;
		return item;
	}

	@Override
	public int getSize() {
		return listItems.size();
	}
	
	/**
	 * Value object for AD_Tab
	 */
	public static class ADTabLabel {
		public String label;
		public int tabLevel;
		public String description;
		public int windowNo = -1;
		public int AD_Tab_ID = -1;
		
		public ADTabLabel(String label, int tabLevel) {
			this.label = label;
			this.tabLevel = tabLevel;
		}
		
		public ADTabLabel(String label, int tabLevel, String description) {
			this(label,tabLevel);
			this.description = description;
		}
		
		public ADTabLabel(String label, int tabLevel, String description, int windowNo, int AD_Tab_ID) {
			this(label,tabLevel,description);
			this.windowNo = windowNo;
			this.AD_Tab_ID = AD_Tab_ID;
		}
	}

	@Override
	public void render(Listitem item, Object data, int index) throws Exception {
		ADTabLabel tabLabel = (ADTabLabel)data;
		Listcell cell = new Listcell(tabLabel.label, null);
		if (tabLabel.tabLevel > 0) {
			cell.setStyle("padding-left:" + (tabLabel.tabLevel*15+5) + "px");
		}
		cell.setParent(item);
		int i = listItems.indexOf(tabLabel);
		int s = tabbox.getSelectedIndex();
		if (!tabbox.canNavigateTo(s, i))
			cell.setVisible(false);
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

}
