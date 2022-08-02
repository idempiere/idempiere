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
 * - Nicolas Micoud (TGI)                                              *
 * - Alan Lescano                                                      *
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.adempiere.webui.apps;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.panel.LabelsPanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MLabel;
import org.compiere.model.MLabelAssignment;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;
import org.zkoss.zul.Vlayout;

public class LabelsSearchController implements EventListener<Event>{
	public static final String ON_POST_SELECT_LABELITEM_EVENT = "onPostSelectLabelitem";
	private static final String ON_SEARCH_ECHO = "onSearchEcho";
	private static final String ON_LOAD_MORE = "onLoadMore";
	private Component parent;
	private Listbox listbox;
	private ListModelList<LabelItem> model;
	private Vlayout layout;
	private LabelsPanel labelsPanel;

	/**
	 * Standard constructor
	 * @param labelsPanel
	 */
	public LabelsSearchController(LabelsPanel labelsPanel) {
		this.labelsPanel = labelsPanel;
	}

	/**
	 * Create the controller for the search field
	 * @param parent
	 */
	public void create(Component parent) {
		this.parent = parent;
		
		layout = new Vlayout();
		ZKUpdateUtil.setHeight(layout, "100%");
		parent.appendChild(layout);
		
		listbox = new Listbox();
		listbox.setItemRenderer(new LabelItemRenderer());
		listbox.setStyle("border: none");
		ZKUpdateUtil.setWidth(listbox, "100%");
		ZKUpdateUtil.setVflex(listbox, "true");
		layout.appendChild(listbox);
		listbox.addEventListener(Events.ON_SELECT, this);
		listbox.addEventListener(ON_POST_SELECT_LABELITEM_EVENT, this);
		ListHead listhead = new ListHead();
		listbox.appendChild(listhead);
		Listheader listheader = new Listheader();
		listhead.appendChild(listheader);
		listheader = new Listheader();
		listheader.setAlign("center");
		listheader.setValign("middle");
		ZKUpdateUtil.setWidth(listheader, "30px");
		listhead.appendChild(listheader);
		
		layout.addEventListener(ON_SEARCH_ECHO, this);
		layout.addEventListener(ON_LOAD_MORE, this);
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(ON_SEARCH_ECHO)) {
        	onSearchEcho((String) event.getData());
		} else if (Events.ON_CLICK.equals(event.getName())) {
			if (event.getTarget() instanceof ListItem) {
	        	ListItem item = (ListItem) event.getTarget();
	        	LabelItem labelItem = item.getValue();
	        	onSelect(labelItem);
        	}
        }
	}
	
	/**
	 * Search for a given text
	 * @param value
	 */
	public void search(String value) {
		listbox.setModel((ListModel<?>)null);
		Events.echoEvent(ON_SEARCH_ECHO, layout, value);
	}
	
	/**
	 * Search for a given text
	 * @param value
	 */
	public void onSearchEcho(String value) {
		ListModelList<LabelItem> newModel = null;
		
		if (Util.isEmpty(value)) {
			newModel = model;
		} else {
			newModel = new ListModelList<LabelItem>();
			
			boolean found = false;
			int currentIndex = 0;
			int foundIndex = 0;
			
			String sql = "SELECT"
					+ "   AD_Label.AD_Label_ID,"
					+ "   AD_Label.Name,"
					+ "   COUNT(AD_LabelAssignment.*),"
					+ "   CASE " 
					+ "     WHEN AD_Label.AD_LabelCategory_ID > 0 AND AD_LabelCategory.IsCanBeUsedInAllTables = 'N'"
					+ "       AND AD_LabelCategoryTable.AD_Table_ID <> ? THEN 'N'"
					+ "     ELSE 'Y'"
					+ "   END AS IsAllowed"
					+ " FROM AD_Label"
					+ " LEFT JOIN AD_LabelAssignment ON AD_LabelAssignment.AD_Label_ID = AD_Label.AD_Label_ID"
					+ " LEFT JOIN AD_LabelCategory ON AD_LabelCategory.AD_LabelCategory_ID = AD_LabelCategory.AD_LabelCategory_ID"
					+ " LEFT JOIN AD_LabelCategoryTable ON AD_LabelCategoryTable.AD_LabelCategory_ID = AD_LabelCategory.AD_LabelCategory_ID"
					+ " WHERE AD_Label.AD_Client_ID = ? AND AD_Label.Name ILIKE ?"
					+ " GROUP BY AD_Label.AD_Label_ID, AD_Label.Name, IsAllowed"
					+ " ORDER BY COUNT(AD_LabelAssignment.*) DESC";
					//+ " FETCH FIRST 15 ROWS ONLY";
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, labelsPanel.getAD_Table_ID());
				pstmt.setInt(2, Env.getAD_Client_ID(Env.getCtx()));
				pstmt.setString(3, "%" + value + "%");

				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					LabelItem i = new LabelItem(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getBoolean(4));
					newModel.add(i);
					
					if (rs.getString(2).toUpperCase().equals(value.toUpperCase())) {
						found = true;
						foundIndex = currentIndex;
					}
					
					currentIndex++;
				}
			} catch (SQLException e) {
				throw new AdempiereException(e);
			} finally {
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			
			if (!found) {
				LabelItem i = new LabelItem(0, value, 0, true);
				newModel.add(i);
			}
			
			listbox.setModel(newModel);
			listbox.setSelectedIndex(foundIndex);
		}
	}	
	
	/**
	 * Assign the selected label to the record. If doesn't exist, create the label.
	 * @param item
	 */
	public void onSelect(LabelItem item) {		
		if (item == null || !item.isAllowed())
			return;
		
		MLabel label = null;
		
		if (item.getC_Label_ID() > 0) {
			label = new MLabel(Env.getCtx(), item.getC_Label_ID(), null);
		} else {
			// Try to find an existing label before creating a new one
			label = MLabel.getByName(Env.getCtx(), item.getLabel(), null);
			
			if (label == null) {
				label = new MLabel(Env.getCtx(), 0, null);
			}
		}
		
		if (label.get_ID() <= 0) {
			label.setAD_Org_ID(0);
			label.setName(item.getLabel());
			label.saveEx();
		}

		// Assign
		if (!MLabelAssignment.hasLabelAssignment(label.get_ID(),
				labelsPanel.getAD_Table_ID(),
				labelsPanel.getRecord_ID())) {
			MLabelAssignment assign = new MLabelAssignment(Env.getCtx(), 0, null);
			assign.setAD_Org_ID(label.getAD_Org_ID());
			assign.setAD_Label_ID(label.get_ID());
			assign.setAD_Table_ID(labelsPanel.getAD_Table_ID());
			assign.setRecord_ID(labelsPanel.getRecord_ID());
			assign.saveEx();
		}
		
    	Events.echoEvent(ON_POST_SELECT_LABELITEM_EVENT, labelsPanel, item);	
    	Events.echoEvent(ON_POST_SELECT_LABELITEM_EVENT, parent.getParent().getParent(), item);
	}	
	
	/**
	 * Get the selected item in the search results
	 * @return selected label or null
	 */
	public LabelItem getSelectedItem() {
		ListItem selected = listbox.getSelectedItem();
		if (selected == null) return null;
		return selected.getValue();
	}

	/**
	 * Select the previous item in the search results
	 * @return previous label or null
	 */
	public LabelItem selectPrior() {
		int i = listbox.getSelectedIndex();
		if (i > 0) {
			listbox.setSelectedIndex(i-1);
			ListItem selected = listbox.getSelectedItem();
			if (selected == null) return null;
			Clients.scrollIntoView(selected);
			LabelItem item = selected.getValue();
			return item;
		}
		return null;
	}
	
	/**
	 * Select the next item in the search results
	 * @return next label or null
	 */
	public LabelItem selectNext() {
		int i = listbox.getSelectedIndex();
		if (i < 0 && listbox.getItemCount() > 0) {
			listbox.setSelectedIndex(0);
			ListItem selected = listbox.getSelectedItem();
			if (selected == null) return null;
			LabelItem item = selected.getValue();			
			return item;
		} else if (i+1 < listbox.getItemCount()) {
			listbox.setSelectedIndex(i+1);
			ListItem selected = listbox.getSelectedItem();
			if (selected == null) return null;
			LabelItem item = selected.getValue();
			if (item == null) return null;
			Clients.scrollIntoView(selected);
			return item;
		}
		return null;
	}
	
	/**
	 * Search result item
	 */
	public class LabelItem {
		private String label;
		private int C_Label_ID;
		private int countUsed;
		private boolean isAllowed;
		
		public LabelItem(int C_Label_ID, String label, int countUsed, boolean isAllowed) {
			this.label = label;
			this.C_Label_ID = C_Label_ID;
			this.countUsed = countUsed;
			this.isAllowed = isAllowed;
		}
		
		public String getLabel() {
			return label;
		}
		
		public int getC_Label_ID() {
			return C_Label_ID;
		}

		public int getCountUsed() {
			return countUsed;
		}

		public boolean isAllowed() {
			return isAllowed;
		}
	}
	
	private class LabelItemRenderer implements ListitemRenderer<LabelItem>, ListitemRendererExt {
		@Override
		public Listitem newListitem(org.zkoss.zul.Listbox listbox) {
			return new ListItem();
		}

		@Override
		public Listcell newListcell(Listitem item) {
			return new Listcell(item.getLabel());
		}

		@Override
		public int getControls() {
			return ListitemRendererExt.DETACH_ON_RENDER;
		}

		@Override
		public void render(Listitem item, LabelItem data, int index)
				throws Exception {
			Label labelName = new Label(data.getLabel());
			labelName.setStyle("color: " + MLabel.calculateHexColor(data.getLabel()));
			
			Listcell cell = new Listcell();
			cell.appendChild(labelName);
			
			if (data.getC_Label_ID() > 0) {
				Label labelCountUsed = new Label("(" + data.getCountUsed() + ")");
				labelCountUsed.setStyle("color: #909090; margin-left: 4px;");
				cell.appendChild(labelCountUsed);
			}
			
			if (!data.isAllowed())
				item.setDisabled(true);
			
			item.appendChild(cell);
			item.setValue(data);
			item.addEventListener(Events.ON_CLICK, LabelsSearchController.this);
			
			Listcell cell2 = new Listcell();
			
			if (data.getC_Label_ID() <= 0) {
				if (ThemeManager.isUseFontIconForImage())
					cell2.setIconSclass("z-icon-New");
				else
					cell2.setImage(ThemeManager.getThemeResource("images/New16.png"));
			} else {
				if (!data.isAllowed()) {
					if (ThemeManager.isUseFontIconForImage())
						cell2.setIconSclass("z-icon-NotAllowed");
					else
						cell2.setImage(ThemeManager.getThemeResource("images/Cancel16.png"));
				}
			}

			item.appendChild(cell2);
		}			
	}
}
