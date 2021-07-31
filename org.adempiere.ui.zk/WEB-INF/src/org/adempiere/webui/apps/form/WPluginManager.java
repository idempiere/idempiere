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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.adempiere.webui.apps.form;

import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.WebUIActivator;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.minigrid.IDColumn;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.BundleException;
import org.osgi.framework.wiring.BundleRevision;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Vbox;

/**
 * A Custom Form to manage plugins in iDempiere
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
public class WPluginManager extends ADForm implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5661912464378243252L;

	/** Log. */
	private static final CLogger log = CLogger.getCLogger(WPluginManager.class);

	private WListbox pluginsTable;
	private Listbox pluginActions;
	private Button pluginProcess;
	private Vector<Vector<Object>> pluginData;
	private Vector<String> pluginColumnNames;
	private Textbox fFilter = new Textbox();
	private Button btnRefresh = null;

	private static final int PLUGIN_ACTION_NONE = 0;
	private static final int PLUGIN_ACTION_STOP = 1;
	private static final int PLUGIN_ACTION_START = 2;
	private static final int PLUGIN_ACTION_UPDATE = 3;
	private static final int PLUGIN_ACTION_UNINSTALL = 4;
	private static final int PLUGIN_ACTION_INSTALL = 5;

	/**
	 * Default constructor.
	 */
	public WPluginManager() {
		super();
	}

	@Override
	protected void initForm() {
		Properties ctx = Env.getCtx();
		Vbox vbox = new Vbox();
		ZKUpdateUtil.setHflex(vbox, "1");
		ZKUpdateUtil.setVflex(vbox, "1");

		fFilter.setPlaceholder(Msg.getMsg(ctx, "filter.by"));
		fFilter.addEventListener(Events.ON_CHANGE, this);
		btnRefresh = ButtonFactory.createNamedButton("Refresh");
		btnRefresh.addEventListener(Events.ON_CLICK, this);

		Hlayout hl = new Hlayout();
		hl.setValign("middle");
		hl.appendChild(fFilter);
		hl.appendChild(btnRefresh);
		vbox.appendChild(hl);

		pluginColumnNames = new Vector<String>();
		pluginColumnNames.add("");
		pluginColumnNames.add(Msg.getMsg(ctx, "Id"));
		pluginColumnNames.add(Msg.getMsg(ctx, "State"));
		pluginColumnNames.add(Msg.getCleanMsg(ctx, "Name"));
		pluginColumnNames.add(Msg.getMsg(ctx, "Version"));

		pluginsTable = ListboxFactory.newDataTableAutoSize();
		pluginData = new Vector<Vector<Object>>();
		int i = 0;
		pluginsTable.setColumnClass(i++, IDColumn.class, true); // 0-bundleId
		pluginsTable.setColumnClass(i++, Integer.class, true); // 1-bundleId
		pluginsTable.setColumnClass(i++, String.class, true); // 2-State
		pluginsTable.setColumnClass(i++, String.class, true); // 3-SymbolicName
		pluginsTable.setColumnClass(i++, String.class, true); // 4-Version
		vbox.appendChild(pluginsTable);
		ZKUpdateUtil.setVflex(pluginsTable, "1");
		ZKUpdateUtil.setHflex(pluginsTable, "1");
		refreshPluginTable();
		pluginsTable.autoSize();
		pluginsTable.addEventListener(Events.ON_SELECT, this);

		pluginActions = new Listbox(new KeyNamePair[] { new KeyNamePair(PLUGIN_ACTION_NONE, ""),
				new KeyNamePair(PLUGIN_ACTION_STOP, Msg.getMsg(ctx, "Stop")),
				new KeyNamePair(PLUGIN_ACTION_START, Msg.getMsg(ctx, "Start")),
				new KeyNamePair(PLUGIN_ACTION_UPDATE, Msg.getMsg(ctx, "Update")),
				new KeyNamePair(PLUGIN_ACTION_UNINSTALL, Msg.getMsg(ctx, "Uninstall")),
				new KeyNamePair(PLUGIN_ACTION_INSTALL, Msg.getMsg(ctx, "Install")) });
		pluginActions.setId("pluginActions");
		pluginActions.setRows(0);
		pluginActions.setMold("select");
		ZKUpdateUtil.setWidth(pluginActions, "200px");
		refreshActionList();
		pluginProcess = new Button(Msg.getMsg(ctx, "Process"));
		pluginProcess.addEventListener(Events.ON_CLICK, this);
		Div div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(pluginActions);
		div.appendChild(pluginProcess);
		vbox.appendChild(div);

		this.appendChild(vbox);
	}

	private String state(int state) {
		switch (state) {
		case Bundle.ACTIVE:
			return "ACTIVE";
		case Bundle.INSTALLED:
			return "INSTALLED";
		case Bundle.RESOLVED:
			return "RESOLVED";
		case Bundle.STARTING:
			return "STARTING";
		case Bundle.STOPPING:
			return "STOPPING";
		case Bundle.UNINSTALLED:
			return "UNINSTALLED";
		default:
			return "UNKNOWN";
		}
	}

	private void refreshActionList() {
		pluginActions.getItemAtIndex(PLUGIN_ACTION_UPDATE).setVisible(false); // not implemented yet
		pluginActions.getItemAtIndex(PLUGIN_ACTION_UNINSTALL).setVisible(false); // not implemented yet
		pluginActions.getItemAtIndex(PLUGIN_ACTION_INSTALL).setVisible(false); // not implemented yet
		pluginActions.getItemAtIndex(PLUGIN_ACTION_STOP).setVisible(false);
		pluginActions.getItemAtIndex(PLUGIN_ACTION_START).setVisible(false);
		pluginActions.setSelectedItem(null);
		Bundle bundle = getSelectedBundle();
		if (bundle == null)
			return;
		int state = bundle.getState();
		boolean isFragment = false;
		BundleRevision rev = bundle.adapt(BundleRevision.class);
		if (rev != null) {
			isFragment = (rev.getTypes() & BundleRevision.TYPE_FRAGMENT) != 0;
		}
		/*
		 * boolean hasFragments = false; if (!isFragment) { if (rev.getWiring() != null)
		 * { if (rev.getWiring().getProvidedWires(BundleRevision.HOST_NAMESPACE).size()
		 * > 0) { hasFragments = true; } } }
		 */
		if (bundle.getBundleId() == 0) {
			// bundle 0 cannot be stopped
		} else if (state == Bundle.ACTIVE) {
			pluginActions.getItemAtIndex(PLUGIN_ACTION_STOP).setVisible(true);
		} else if (state == Bundle.RESOLVED) {
			if (!isFragment) {
				pluginActions.getItemAtIndex(PLUGIN_ACTION_START).setVisible(true);
			}
		} else if (state == Bundle.INSTALLED) {
			if (!isFragment) {
				pluginActions.getItemAtIndex(PLUGIN_ACTION_START).setVisible(true);
			}
		} else if (state == Bundle.STARTING) {
			if (!isFragment) {
				pluginActions.getItemAtIndex(PLUGIN_ACTION_START).setVisible(true);
			}
		} else if (state == Bundle.STOPPING) {
			// no options yet for stopping
		} else if (state == Bundle.UNINSTALLED) {
			// no options yet for uninstalled
		}
	}

	private Bundle getSelectedBundle() {
		Bundle retValue = null;
		int idx = pluginsTable.getSelectedIndex();
		if (idx >= 0) {
			Vector<Object> pluginVector = pluginData.get(idx);
			int pluginId = ((IDColumn) pluginVector.get(0)).getRecord_ID();
			BundleContext bundleCtx = WebUIActivator.getBundleContext();
			retValue = bundleCtx.getBundle(pluginId);
		}
		return retValue;
	}

	private void processPlugin() {
		Listitem actionItem = pluginActions.getSelectedItem();
		if (actionItem != null && actionItem.getValue() instanceof Integer) {
			int action = (Integer) actionItem.getValue();
			Bundle bundle = getSelectedBundle();
			if (action == PLUGIN_ACTION_STOP && bundle != null) {
				try {
					if (log.isLoggable(Level.INFO))
						log.info("Stopping plugin " + bundle.getSymbolicName());
					bundle.stop();
				} catch (BundleException e) {
					throw new AdempiereException(e);
				}
			} else if (action == PLUGIN_ACTION_START && bundle != null) {
				try {
					if (log.isLoggable(Level.INFO))
						log.info("Starting plugin " + bundle.getSymbolicName());
					bundle.start();
				} catch (BundleException e) {
					throw new AdempiereException(e);
				}
			} else if (action == PLUGIN_ACTION_UPDATE && bundle != null) {
				// PLUGIN_ACTION_UPDATE not implemented yet
			} else if (action == PLUGIN_ACTION_UNINSTALL && bundle != null) {
				// PLUGIN_ACTION_UNINSTALL not implemented yet
			} else if (action == PLUGIN_ACTION_INSTALL && bundle != null) {
				// PLUGIN_ACTION_INSTALL not implemented yet
			}
		}
		refreshAll();
	}

	private void refreshPluginTable() {
		int idx = pluginsTable.getSelectedIndex();
		pluginsTable.getModel().removeAll(pluginData);
		pluginData.removeAllElements();

		BundleContext bundleCtx = WebUIActivator.getBundleContext();
		for (Bundle bundle : bundleCtx.getBundles()) {

			if (!Util.isEmpty(fFilter.getValue()) && !bundle.getSymbolicName().toUpperCase().contains(fFilter.getValue().toUpperCase()))
				continue;

			Vector<Object> line = new Vector<Object>();
			Integer bundl = Long.valueOf(bundle.getBundleId()).intValue(); // potential problem converting Long to
			// Integer, but WListBox cannot order Long
			line.add(new IDColumn(bundl));
			line.add(bundl);
			line.add(state(bundle.getState()));
			line.add(bundle.getSymbolicName());
			line.add(bundle.getVersion());
			pluginData.add(line);
		}
		ListModelTable model = new ListModelTable(pluginData);
		pluginsTable.setData(model, pluginColumnNames);
		pluginsTable.setSelectedIndex(idx);
	}

	private void refreshAll() {
		refreshPluginTable();
		refreshActionList();
	}

	public void onEvent(Event event) throws Exception {
		if (Events.ON_SELECT.equals(event.getName()) && event.getTarget() == pluginsTable)
			refreshActionList();
		else if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() == pluginProcess)
			processPlugin();
		else if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() == btnRefresh)
			refreshAll();
		else if (Events.ON_CHANGE.equals(event.getName()) && event.getTarget() == fFilter) {
			pluginsTable.setSelectedIndex(-1);
			refreshAll();
		}
	}

}
