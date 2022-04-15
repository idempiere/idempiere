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
 **********************************************************************/
package org.adempiere.webui.window;

import java.math.BigDecimal;
import java.util.List;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.action.IAction;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.ADWindowContent;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MLabel;
import org.compiere.model.MLabelAssignment;
import org.compiere.model.MLabelCategory;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.osgi.service.component.annotations.Component;
//import org.tgi.util.Util_Tgi;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;

/**
 * @author Nicolas Micoud (TGI)
 */

@Component(name = "org.adempiere.webui.window.LabelAction", service = {IAction.class})
public class LabelAction implements IAction {

	public static CLogger log = CLogger.getCLogger(LabelAction.class);

	public void execute(Object target) {
		ADWindow adwindow = (ADWindow) target;
		final ADWindowContent panel = adwindow.getADWindowContent();

		if (panel.getActiveGridTab().getRecord_ID() <= 0)
			return;

		LabelWindow lw = new LabelWindow(Env.getCtx(), panel, panel.getActiveGridTab().getAD_Table_ID(), panel.getActiveGridTab().getRecord_ID());
		lw.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			public void onEvent(Event event) throws Exception {
				panel.hideBusyMask();
				panel.getActiveGridTab().dataRefresh();
			}
		});

		panel.getComponent().getParent().appendChild(lw);
		panel.showBusyMask(lw);
		LayoutUtils.openOverlappedWindow(panel.getComponent(), lw, "middle_center");
		lw.focus();
	}

	public class LabelWindow extends Window implements EventListener<Event> {

		private static final long serialVersionUID = -6552275114179297364L;
		private int m_tableID = 0;
		private int m_recordID = 0;
		private int m_windowNo = 0;
		private WListbox table;
		private Vector<Vector<Object>> data;
		private ListModelTable tableModel;
		private int m_currentLabelID = 0;
		private WStringEditor fComments = new WStringEditor();
		private WTableDirEditor fLabelCat;
		private Listbox fLabel;
		private Button bRefresh = new Button();
		private Button bDelete = new Button();
		private Button bNew = new Button();
		private Button bSaveCreate = new Button();
		private Menupopup popupLabel = new Menupopup();
		private int idxColumnLabelID = 1;
		private final static String POPUP_NEW_LABEL = "newLabel";
		
		public LabelWindow(Properties ctx, ADWindowContent panel, int tableID, int recordID)
		{
			super();
			m_tableID = tableID;
			m_recordID = recordID;
			m_windowNo = panel.getWindowNo();
			setTitle("Label : " + panel.getTitle()); // TODO AD_Message
			try {
				dynInit();
				zkInit();
				
				setSclass("popup-dialog");
				setClosable(true);
				setMaximizable(true);
				setSizable(true);
				setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				setStyle("position: absolute; width: 600px; height: 400px");
			}
			catch(Exception e) {
				log.log(Level.SEVERE, "", e);
			}
		}

		private void zkInit() throws Exception
		{
			Borderlayout mainLayout = new Borderlayout();
			this.appendChild(mainLayout);

			North north = new North();
			mainLayout.appendChild(north);
			ZKUpdateUtil.setVflex(north, "1");

			bNew.setImage(ThemeManager.getThemeResource("images/New24.png"));
			bNew.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "New"));
			bNew.addEventListener(Events.ON_CLICK, this);
			bRefresh.setImage(ThemeManager.getThemeResource("images/Refresh24.png"));
			bRefresh.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "Refresh"));
			bRefresh.addEventListener(Events.ON_CLICK, this);
			bSaveCreate.setImage(ThemeManager.getThemeResource("images/SaveCreate24.png"));
			bSaveCreate.setTooltiptext(Msg.getCleanMsg(Env.getCtx(), "SaveCreate"));
			bSaveCreate.addEventListener(Events.ON_CLICK, this);
			bDelete.setImage(ThemeManager.getThemeResource("images/Delete24.png"));
			bDelete.setTooltiptext(Msg.getMsg(Env.getCtx(), "Delete"));
			bDelete.addEventListener(Events.ON_CLICK, this);
			bDelete.setEnabled(false);
			fComments.getComponent().setPlaceholder("OptionalComment"); // TODO AD_Message

			Panel panel = new Panel();
			panel.appendChild(bNew);
			panel.appendChild(new Separator("vertical"));
			panel.appendChild(bSaveCreate);
			panel.appendChild(new Separator("vertical"));
			panel.appendChild(bDelete);
			panel.appendChild(new Separator("vertical"));
			panel.appendChild(bRefresh);

			Grid grid = GridFactory.newGridLayout();
			ZKUpdateUtil.setVflex(grid, "1");
			Columns columns = new Columns();
			grid.appendChild(columns);
			Column column = new Column();
			columns.appendChild(column);
			column = new Column();
			columns.appendChild(column);
			column = new Column();
			columns.appendChild(column);

			Rows rows = grid.newRows();
			Row row = rows.newRow();
			row.appendCellChild(fLabelCat.getComponent());
			ZKUpdateUtil.setHflex(fLabelCat.getComponent(), "1");
			row.appendCellChild(panel, 2);

			row = rows.newRow();
			row.appendCellChild(fLabel);
			ZKUpdateUtil.setHflex(fLabel, "1");
			row.appendCellChild(fComments.getComponent());
			ZKUpdateUtil.setHflex(fComments.getComponent(), "2");

			north.appendChild(grid);

			Center center = new Center();
			mainLayout.appendChild(center);
			center.setAutoscroll(true);
			ZKUpdateUtil.setHeight(table, "100%");
			ZKUpdateUtil.setWidth(table, "100%");
			center.appendChild(table);
			ZKUpdateUtil.setHflex(table, "1");
			ZKUpdateUtil.setVflex(table, "1");

			Grid southLayout = GridFactory.newGridLayout();
			Panel southPanel = new Panel();
			southPanel.appendChild(southLayout);
		}

		public void dynInit() throws Exception
		{
			MLookup lookup = MLookupFactory.get (Env.getCtx(), m_windowNo, 
					MColumn.get(Env.getCtx(), MLabelCategory.Table_Name, MLabelCategory.COLUMNNAME_C_LabelCategory_ID).getAD_Column_ID(),
					DisplayType.TableDir, Env.getLanguage(Env.getCtx()), "C_LabelCategory_ID", 0, false, "IsActive='Y'");
			fLabelCat = new WTableDirEditor ("C_LabelCategory_ID", false, false, true, lookup);
			fLabelCat.getComponent().addEventListener(Events.ON_SELECT, this);

			int defaultID = DB.getSQLValueEx(null, "SELECT C_LabelCategory_ID FROM C_LabelCategory WHERE AD_Client_ID = ? AND IsDefault = 'Y' AND IsActive = 'Y'", Env.getAD_Client_ID(Env.getCtx()));
			if (defaultID > 0) {
				fLabelCat.setValue(defaultID);
				initTable();
			}

			fLabel = new Listbox();
			fLabel.setMold("select");
			fLabel.setRows(1);
			fLabel.addEventListener(Events.ON_RIGHT_CLICK, this);

			loadTagItem();
		}

		@Override
		public void onEvent(Event event) throws Exception {
			Object source = event.getTarget();

			if (source == bRefresh)
				loadData();
			else if (source == bNew) {
				onNew();
			} else if (source == bSaveCreate) {
				if (fLabel.getSelectedItem()==null)
					return;

				MLabelAssignment la = new MLabelAssignment(Env.getCtx(), m_currentLabelID, null);
				la.setAD_Table_ID(m_tableID);
				la.setRecord_ID(m_recordID);
				la.setComments((String) fComments.getValue());
				la.setC_LabelCategory_ID((Integer) fLabelCat.getValue());

				Listitem listitem = fLabel.getSelectedItem();
				if (listitem != null)
					la.setC_Label_ID((Integer) listitem.getValue());

				la.saveEx();
				loadData();
				onNew();
			} else if (source == bDelete) {

				FDialog.ask(0, null, "DeleteRecord?", new Callback<Boolean>() {

					public void onCallback(Boolean result) {
						if (result) {
							new MLabelAssignment(Env.getCtx(), m_currentLabelID, null).deleteEx(false);
							m_currentLabelID = 0;
							loadData();
						}
					}
				});
			} else if (source == fLabelCat.getComponent()) {
				loadTagItem();
			} else if (source == table) {

				if (table.getRowCount() > 0 && table.getSelectedRow() >= 0) {
					KeyNamePair knp = (KeyNamePair) table.getValueAt(table.getSelectedRow(), 1);
					if (knp != null) {
						m_currentLabelID = knp.getKey();
						fComments.setValue(knp.getName());
						knp = (KeyNamePair) table.getValueAt(table.getSelectedRow(), idxColumnLabelID);
						fLabel.setValue(knp.getKey());
						fLabel.setEnabled(true);
						fComments.setReadWrite(true);
						bDelete.setEnabled(true);
					}
				}
			}
			else if (source == fLabel) {
				popupLabel = new Menupopup();
				Menuitem menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), "NewRecord"));
				menuItem.setImage(ThemeManager.getThemeResource("images/New16.png"));
				menuItem.setParent(popupLabel);
				menuItem.addEventListener(Events.ON_CLICK, this);
				menuItem.setValue(POPUP_NEW_LABEL);
				popupLabel.setPage(event.getPage());
				popupLabel.open(fLabel);
			}
			else if (source instanceof Menuitem) {

				Menuitem menuItem = (Menuitem) event.getTarget();
				if (menuItem.getValue() == POPUP_NEW_LABEL) {
					
					if (fLabelCat.isNullOrEmpty() // TODO replace sql with Cache
							&& DB.getSQLValueEx(null, "SELECT C_LabelCategory_ID FROM C_LabelCategory WHERE AD_Client_ID = ? AND IsDefault ='Y' AND IsActive ='Y'", Env.getAD_Client_ID(Env.getCtx())) <= 0) {
						FDialog.error(m_windowNo, "Error", "Impossible to add label as there is no Label Category");
						return;
					}

					FDialog.askForInput(m_windowNo, null, "Label of new label", new Callback<String>() { // TODO AD_Message
						public void onCallback(String result) {
							MLabel l = new MLabel(Env.getCtx(), 0, null);
							l.setAD_Org_ID(0);
							l.setC_LabelCategory_ID((Integer) fLabelCat.getValue());
							l.setName(result);
							l.saveEx();

							onNew();
							KeyNamePair knp = new KeyNamePair(l.getC_Label_ID(), l.getName()); 
							fLabel.addItem(knp);
							fLabel.setSelectedKeyNamePair(knp);
							fLabel.setEnabled(true);
							fComments.setReadWrite(true);
						}
					});
				}
			}
		}

		void onNew()
		{
			if (fLabelCat.getValue() == null)
				return;

			m_currentLabelID = 0;
			fLabel.setValue(null);
			fComments.setValue(null);
			fLabel.setEnabled(true);
			fComments.setReadWrite(true);
			fLabel.setFocus(true);
		}

		void loadTagItem()
		{
			if (fLabelCat.getValue() != null) {
				loadData();

				fLabel.removeAllItems();

				List<List<Object>> rows = DB.getSQLArrayObjectsEx(null, "SELECT C_Label_ID, Name FROM C_Label WHERE C_LabelCategory_ID = ? ORDER BY Name", fLabelCat.getValue());
				if (rows != null && rows.size() > 0) {
					for (List<Object> row : rows) {
						KeyNamePair key = new KeyNamePair(((BigDecimal) row.get(0)).intValue(), (String) row.get(1)); 
						fLabel.addItem(key);
					}
				} 
				// si aucune ligne dans la grille, c'est qu'il s'agit du 1er enregistrement, donc on autorise la modification
				fLabel.setEnabled(table.getRowCount() == 0);
				fComments.setReadWrite(table.getRowCount() == 0);
			}
			else {
				initTable();
				loadData();
			}
		}

		ColumnInfo[] getLayout()
		{
			ColumnInfo category = new ColumnInfo(Msg.getElement(Env.getCtx(),  "C_LabelCategory_ID"), "Category", String.class);
			ColumnInfo critere = new ColumnInfo(Msg.getElement(Env.getCtx(),  "C_LabelAssignment_ID"), "Label", String.class);
			ColumnInfo comments = new ColumnInfo(Msg.getElement(Env.getCtx(), "Comments"), "Comments", String.class);
			if (fLabelCat.getValue() != null)
				return new ColumnInfo[]{critere, comments};
			else
				return new ColumnInfo[]{category, critere, comments};
		}

		void initTable()
		{
			if (tableModel!=null)
				tableModel.clear();
			else {
				data = new Vector<Vector<Object>>();
				table = ListboxFactory.newDataTable();
			}

			table.prepareTable(getLayout(), "", "", true , "osef");
			table.addEventListener(Events.ON_SELECT, this);
			table.addEventListener(Events.ON_RIGHT_CLICK, this); // sert juste à pas afficher le clic droit standard du navigateur
			tableModel = new ListModelTable(data);
			table.setModel(tableModel);
			table.repaint();

			if (fLabelCat.getValue() != null)
				idxColumnLabelID = 0;
			else
				idxColumnLabelID = 1;
		}

		void resetTable()
		{
			data.removeAllElements();
			table.clearTable();
			table.repaint();
		}

		void loadData()
		{
			table.clearTable();

			StringBuilder whereClause = new StringBuilder("AD_Table_ID = ? AND Record_ID = ?"); 
			if (fLabelCat.getValue() != null)
				whereClause.append(" AND C_LabelCategory_ID = ").append(fLabelCat.getValue());

			Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), MLabelAssignment.Table_Name), whereClause.toString(), null)
			.setParameters(m_tableID, m_recordID)
			.setClient_ID(true)
			.setOrderBy(MLabelAssignment.COLUMNNAME_C_LabelCategory_ID + ", " + MLabelAssignment.COLUMNNAME_Created);
			List<MLabelAssignment> list = query.list();

			if (list != null) {
				data = new Vector<Vector<Object>>();
				for (MLabelAssignment tag : list) {
					Vector<Object> line = new Vector<Object>();
					data.add(line);

					if (fLabelCat.getValue() == null)
						line.add(tag.getC_LabelCategory().getName());

					// ID et Nom du tag item
					MLabel l = new MLabel(Env.getCtx(), tag.getC_Label_ID(), null);
					KeyNamePair knp = new KeyNamePair(l.getC_Label_ID(), l.getName());
					line.add(knp);

					// ID et comment du tag
					knp = new KeyNamePair(tag.getC_LabelAssignment_ID(), tag.getComments());
					line.add(knp);

				}

				tableModel = new ListModelTable(data);
				table.setModel(tableModel);
				table.repaint();
			}
			bDelete.setEnabled(false);
		}
	}
}