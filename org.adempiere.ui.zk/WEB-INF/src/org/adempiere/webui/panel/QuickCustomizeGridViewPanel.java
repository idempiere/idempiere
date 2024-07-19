/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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

package org.adempiere.webui.panel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.adempiere.model.MTabCustomization;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.QuickGridView;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.I_AD_Field;
import org.compiere.model.MField;
import org.compiere.model.MRole;
import org.compiere.model.MTab;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.zkoss.zhtml.Span;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Vbox;

/**
 * Customize grid panel for quick form
 * 
 * @author Logilite Technologies
 * @since Nov 08, 2017
 */
public class QuickCustomizeGridViewPanel extends Panel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7566420005952940208L;

	static CLogger					log					= CLogger.getCLogger(QuickCustomizeGridViewPanel.class);

	private Map <Integer, String>	m_columnsWidth;
	ArrayList <Integer>				tableSeqs;
	QuickGridView					gridview			= null;

	private int						m_WindowNo;
	private int						m_AD_Tab_ID;
	private int						m_AD_User_ID;

	// UI variables
	private Label					yesLabel			= new Label();

	private Button					bDown				= ButtonFactory.createNamedButton("MoveDown");
	private Button					bUp					= ButtonFactory.createNamedButton("MoveUp");

	private Checkbox				chkSaveWidth		= new Checkbox();

	SimpleListModel					yesModel			= new SimpleListModel();
	Listbox							yesList				= new Listbox();

	private boolean					uiCreated;
	private boolean					m_saved				= false;
	private ConfirmPanel			confirmPanel		= new ConfirmPanel(true, false, true, false, false, false);

	/**
	 * Sort Tab Constructor
	 * @param WindowNo Window No
	 * @param AD_Tab_ID
	 * @param AD_User_ID
	 * @param columnsWidth
	 * @param gridFieldIds
	 */
	public QuickCustomizeGridViewPanel(int WindowNo, int AD_Tab_ID, int AD_User_ID, Map <Integer, String> columnsWidth, ArrayList <Integer> gridFieldIds)
	{
		m_WindowNo = WindowNo;
		m_AD_Tab_ID = AD_Tab_ID;
		m_AD_User_ID = AD_User_ID;
		m_columnsWidth = columnsWidth;
		tableSeqs = gridFieldIds;
		this.setStyle("position: relative; height: 100%; width: 100%; margin: none; border: none; padding: none;");
	}

	/**
	 * Static Layout
	 * 
	 * @throws Exception
	 */
	private void init() throws Exception {
		Borderlayout layout = new Borderlayout();
		layout.setStyle("height: 100%; width: 100%; border: none; margin: none; padding: 2px;");

		yesLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected"));
		ZKUpdateUtil.setVflex(yesList, true);
		ZKUpdateUtil.setHeight(yesList, "300px");
		yesList.setSeltype("multiple");

		EventListener<Event> crossListMouseListener = new DragListener();
		yesList.addOnDropListener(crossListMouseListener);
		yesList.setItemDraggable(true);

		EventListener<Event> actionListener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				migrateValueWithinYesList(event);
			}
		};

		bUp.addEventListener(Events.ON_CLICK, actionListener);
		bDown.addEventListener(Events.ON_CLICK, actionListener);

		Panel northPanel = new Panel();

		ListHead listHead = new ListHead();
		listHead.setParent(yesList);
		ListHeader listHeader = new ListHeader();
		listHeader.appendChild(yesLabel);
		listHeader.setParent(listHead);

		Span span = new Span();
		span.setParent(northPanel);
		span.setStyle("height: 99%; display: inline-block; width: 86%; float: left;");
		span.appendChild(yesList);

		Vbox vbox = new Vbox();
		vbox.appendChild(bUp);
		vbox.appendChild(bDown);

		span = new Span();
		span.setParent(northPanel);
		span.setStyle("height: 99%; display: inline-block; width: 60px;  float: left;");
		span.appendChild(vbox);

		North north = new North();
		north.setStyle("border: none; margin: 0; padding: 0; ");
		north.appendChild(northPanel);
		layout.appendChild(north);

		South south = new South();
		south.setStyle("border: none; margin: 0; padding: 0; ");

		Separator sep = new Separator();
		sep.setSpacing("2px");

		Panel southPanel = new Panel();
		southPanel.appendChild(sep);

		chkSaveWidth.setLabel(Msg.getMsg(Env.getCtx(), "SaveColumnWidth"));

		vbox = new Vbox();

		Hbox hbox = new Hbox();
		hbox.appendChild(chkSaveWidth);
		vbox.appendChild(hbox);
		vbox.appendChild(sep);

		hbox = new Hbox();
		vbox.appendChild(hbox);

		southPanel.appendChild(vbox);
		southPanel.appendChild(sep);

		LayoutUtils.addSclass("dialog-footer", confirmPanel);
		EventListener<Event> onClickListener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_OK))) {
					saveData();
				} else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_CANCEL))) {
					if (gridview != null) {
						Events.postEvent("onCustomizeGrid", gridview, null);
					}
					getParent().detach();
				} else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_RESET))) {
					MTabCustomization tabCust = MTabCustomization.get(Env.getCtx(), m_AD_User_ID, m_AD_Tab_ID, null,true);
					if (tabCust != null && tabCust.getAD_Tab_Customization_ID() > 0)
						tabCust.deleteEx(true);
				}
			}
		};

		confirmPanel.addActionListener(onClickListener);
		southPanel.appendChild(confirmPanel);
		south.appendChild(southPanel);
		layout.appendChild(south);

		this.appendChild(layout);

	} // init

	public void loadData() {
		MTabCustomization tabCust = MTabCustomization.get(Env.getCtx(), m_AD_User_ID, m_AD_Tab_ID, null,true);
		boolean baseLanguage = Env.isBaseLanguage(Env.getCtx(), "AD_Field");
		yesModel.removeAllElements();
		Query query = null;
		query = new Query(Env.getCtx(), I_AD_Field.Table_Name,
				"AD_Tab_ID=? AND (IsDisplayed='Y' OR IsDisplayedGrid='Y') AND IsActive='Y' AND IsQuickForm='Y'", null);
		query.setOrderBy("SeqNoGrid, Name, SeqNo");
		query.setParameters(new Object[] { m_AD_Tab_ID });
		query.setApplyAccessFilter(true);

		try {
			List<MField> lsFieldsOfGrid = query.list();
			HashMap<Integer, ListElement> curTabSel = new HashMap<Integer, QuickCustomizeGridViewPanel.ListElement>();
			MTab tab = MTab.get(m_AD_Tab_ID);

			for (MField field : lsFieldsOfGrid) {
				if (!MRole.getDefault(Env.getCtx(), false).isColumnAccess(tab.getAD_Table_ID(), field.getAD_Column_ID(),
						true))
					continue;

				int key = field.get_ID();
				String name = null;
				if (baseLanguage)
					name = field.getName();
				else
					name = field.get_Translation(I_AD_Field.COLUMNNAME_Name);

				ListElement pp = new ListElement(key, name);
				if (tableSeqs != null && tableSeqs.size() > 0) {
					if (tableSeqs.contains(key)) {
						curTabSel.put(key, pp);
					}
				}
			}
			if (tableSeqs != null) {
				for (int key : tableSeqs) {
					if (curTabSel.get(key) != null) {
						yesModel.addElement(curTabSel.get(key));
					}
				}
			}
		} catch (DBException e) {
			log.log(Level.SEVERE, e.getMessage(), e);
		}

		bUp.setEnabled(true);
		bDown.setEnabled(true);
		yesList.setEnabled(true);

		yesList.setItemRenderer(yesModel);
		yesList.setModel(yesModel);

		if ((tabCust != null && tabCust.getCustom().indexOf("px") > 0))
			chkSaveWidth.setChecked(true);
	} // loadData

	void migrateLists(Listbox listFrom, Listbox listTo, int endIndex) {
		int index = 0;
		SimpleListModel lmFrom = (SimpleListModel) listFrom.getModel();
		SimpleListModel lmTo = (SimpleListModel) listTo.getModel();
		Set<?> selectedItems = listFrom.getSelectedItems();
		List<ListElement> selObjects = new ArrayList<ListElement>();
		for (Object obj : selectedItems) {
			ListItem listItem = (ListItem) obj;
			index = listFrom.getIndexOfItem(listItem);
			ListElement selObject = (ListElement) lmFrom.getElementAt(index);
			selObjects.add(selObject);
		}
		for (ListElement selObject : selObjects) {
			if (selObject == null || !selObject.isUpdateable())
				continue;

			lmFrom.removeElement(selObject);
			lmTo.add(endIndex, selObject);
			endIndex++;
			index = lmTo.indexOf(selObject);
			listTo.setSelectedIndex(index);
		}
	}

	/**
	 * Move within Yes List with Drag Event and Multiple Choice
	 * 
	 * @param event event
	 */
	void migrateValueWithinYesList(int endIndex, List<ListElement> selObjects) {
		int iniIndex = 0;
		Arrays.sort(selObjects.toArray());
		ListElement endObject = (ListElement) yesModel.getElementAt(endIndex);
		for (ListElement selected : selObjects) {
			iniIndex = yesModel.indexOf(selected);
			ListElement selObject = (ListElement) yesModel.getElementAt(iniIndex);
			yesModel.removeElement(selObject);
			endIndex = yesModel.indexOf(endObject);
			yesModel.add(endIndex, selObject);
		}
	}

	/**
	 * Move within Yes List
	 * 
	 * @param event event
	 */
	void migrateValueWithinYesList(Event event) {
		Object[] selObjects = yesList.getSelectedItems().toArray();

		if (selObjects == null)
			return;
		int length = selObjects.length;
		if (length == 0)
			return;
		//
		int[] indices = yesList.getSelectedIndices();
		Arrays.sort(indices);
		//
		boolean change = false;
		//
		Object source = event.getTarget();
		if (source == bUp) {
			for (int i = 0; i < length; i++) {
				int index = indices[i];
				if (index == 0)
					break;
				ListElement selObject = (ListElement) yesModel.getElementAt(index);
				ListElement newObject = (ListElement) yesModel.getElementAt(index - 1);
				if (!selObject.isUpdateable() || !newObject.isUpdateable())
					break;
				yesModel.setElementAt(newObject, index);
				yesModel.setElementAt(selObject, index - 1);
				indices[i] = index - 1;
				change = true;
			}
		} // up

		else if (source == bDown) {
			for (int i = length - 1; i >= 0; i--) {
				int index = indices[i];
				if (index >= yesModel.getSize() - 1)
					break;
				ListElement selObject = (ListElement) yesModel.getElementAt(index);
				ListElement newObject = (ListElement) yesModel.getElementAt(index + 1);
				if (!selObject.isUpdateable() || !newObject.isUpdateable())
					break;
				yesModel.setElementAt(newObject, index);
				yesModel.setElementAt(selObject, index + 1);
				yesList.setSelectedIndex(index + 1);
				indices[i] = index + 1;
				change = true;
			}
		} // down

		//
		if (change) {
			yesList.setSelectedIndices(indices);
			if (yesList.getSelectedItem() != null) {
				AuFocus focus = new AuFocus(yesList.getSelectedItem());
				Clients.response(focus);
			}
		}
	} // migrateValueWithinYesList

	public void saveData() {
		// yesList
		// int index = 0;
		boolean ok = true;
		final StringBuilder custom = new StringBuilder();
		for (int i = 0; i < yesModel.getSize(); i++) {
			ListElement pp = (ListElement) yesModel.getElementAt(i);
			if (!pp.isUpdateable())
				continue;

			if (i > 0)
				custom.append(",");
			custom.append(pp.getKey());
		}

		if (chkSaveWidth.isSelected() && m_columnsWidth != null && !m_columnsWidth.isEmpty()) {
			for (int i = 0; i < yesModel.getSize(); i++) {
				if (i > 0)
					custom.append(",");
				else
					custom.append(";");

				ListElement pp = (ListElement) yesModel.getElementAt(i);
				int fieldId = pp.getKey();
				String width = m_columnsWidth.get(fieldId);
				if (width == null)
					width = "";
				custom.append(width);
			}
		}
		// save Window width and height
		ok = MTabCustomization.saveData(Env.getCtx(), m_AD_Tab_ID, m_AD_User_ID, custom.toString(), null, null,true);
		if (ok) {
			m_saved = true;
			gridview.setStatusLine("Customize Preference Saved.", false);
			if (gridview != null) {
				Events.postEvent("onCustomizeGrid", gridview, null);
			}
			getParent().detach();
		} else {
			Dialog.error(m_WindowNo, "SaveError", custom.toString());
		}
	} // saveData

	public void activate(boolean b) {
		if (b && !uiCreated)
			createUI();
	}

	public void createUI() {
		if (uiCreated)
			return;
		try {
			init();
		} catch (Exception e) {
			log.log(Level.SEVERE, "", e);
		}
		uiCreated = true;
	}

	public boolean isSaved() {
		return m_saved;
	}

	public void setGridPanel(QuickGridView quickGridView) {
		this.gridview = quickGridView;
	}

	/**
	 * ListElement Item
	 */
	private static class ListElement extends NamePair {
		/**
		 * 
		 */
		private static final long serialVersionUID = -4428985595605126841L;

		private int m_key;

		private boolean m_updateable;

		public ListElement(int key, String name) {
			super(name);
			this.m_key = key;
			this.m_updateable = true;
		}

		public int getKey() {
			return m_key;
		}

		public boolean isUpdateable() {
			return m_updateable;
		}

		@Override
		public String getID() {
			return m_key != -1 ? String.valueOf(m_key) : null;
		}

		@Override
		public int hashCode() {
			return m_key;
		}

		@Override
		public boolean equals(Object obj) {
			if (obj instanceof ListElement) {
				ListElement li = (ListElement) obj;
				return li.getKey() == m_key && li.getName() != null && li.getName().equals(getName());
			}
			return false;
		} // equals

		@Override
		public String toString() {
			String s = super.toString();
			if (s == null || s.trim().length() == 0)
				s = "<" + getKey() + ">";
			return s;
		}
	} // ListElement Class

	/**
	 * DragListener Class
	 */
	private class DragListener implements EventListener<Event> {
		/**
		 * Creates a ADSortTab.DragListener.
		 */
		public DragListener() {
		}

		@Override
		public void onEvent(Event event) throws Exception {
			if (event instanceof DropEvent) {
				int endIndex = 0;
				DropEvent me = (DropEvent) event;
				ListItem endItem = (ListItem) me.getTarget();
				ListItem startItem = (ListItem) me.getDragged();

				if (!startItem.isSelected())
					startItem.setSelected(true);

				if (!(startItem.getListbox() == endItem.getListbox())) {
					Listbox listFrom = (Listbox) startItem.getListbox();
					Listbox listTo = (Listbox) endItem.getListbox();
					endIndex = yesList.getIndexOfItem(endItem);
					migrateLists(listFrom, listTo, endIndex);
				} else if (startItem.getListbox() == endItem.getListbox() && startItem.getListbox() == yesList) {
					List<ListElement> selObjects = new ArrayList<ListElement>();
					endIndex = yesList.getIndexOfItem(endItem);
					for (Object obj : yesList.getSelectedItems()) {
						ListItem listItem = (ListItem) obj;
						int index = yesList.getIndexOfItem(listItem);
						ListElement selObject = (ListElement) yesModel.getElementAt(index);
						selObjects.add(selObject);
					}
					migrateValueWithinYesList(endIndex, selObjects);
					yesList.clearSelection();
				}
			}
		}
	} // DragListener Class

} // QuickCustomizeGridPanel Class