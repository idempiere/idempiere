/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 Low Heng Sin. All Rights Reserved.                      *
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
package org.adempiere.webui.window;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.WebUIActivator;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.FolderBrowser;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.FeedbackManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.Adempiere;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.MUser;
import org.compiere.util.CLogErrorBuffer;
import org.compiere.util.CLogMgt;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.SecureEngine;
import org.compiere.util.Util;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.BundleException;
import org.osgi.framework.wiring.BundleRevision;
import org.zkoss.util.media.AMedia;
import org.zkoss.zhtml.Pre;
import org.zkoss.zhtml.Text;
import org.zkoss.zhtml.Textarea;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Image;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;

/**
 *
 * @author Low Heng Sin
 *
 */
public class AboutWindow extends Window implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7922577248288156723L;

	private Checkbox bErrorsOnly;
	private Listbox logTable;
	private Tabbox tabbox;
	protected Tabpanels tabPanels;
	protected Button btnDownload;
	protected Button btnErrorEmail;
	protected Button btnViewLog;
	protected Tab tabLog;
	protected Tab tabPlugins;

	protected Button btnAdempiereLog;
	protected Button btnReloadLogProps;

	private Listbox levelListBox;

	private WListbox pluginsTable;
	private Listbox pluginActions;
	private Button pluginProcess;
	private Vector<Vector<Object>> pluginData;
	private Vector<String> pluginColumnNames;

	private static final int PLUGIN_ACTION_NONE = 0;
	private static final int PLUGIN_ACTION_STOP = 1;
	private static final int PLUGIN_ACTION_START = 2;
	private static final int PLUGIN_ACTION_UPDATE = 3;
	private static final int PLUGIN_ACTION_UNINSTALL = 4;
	private static final int PLUGIN_ACTION_INSTALL = 5;

	public AboutWindow() {
		super();
		init();
	}

	private void init() {

		System.runFinalization();
		System.gc();
		
		this.setPosition("center");
		this.setTitle(ThemeManager.getBrowserTitle());
		this.setSclass("popup-dialog about-window");
		this.setClosable(true);
		this.setMaximizable(true);
		this.setSizable(true);

		tabbox = new Tabbox();
		ZKUpdateUtil.setVflex(tabbox, "1");
		ZKUpdateUtil.setHflex(tabbox, "1");
		Tabs tabs = new Tabs();
		tabs.setParent(tabbox);
		tabPanels = new Tabpanels();
		tabPanels.setParent(tabbox);
		ZKUpdateUtil.setHflex(tabPanels, "1");
		ZKUpdateUtil.setVflex(tabPanels, "1");

		initTabs(tabs);

		Button btnOk = ButtonFactory.createNamedButton(ConfirmPanel.A_OK); 
		btnOk.addEventListener(Events.ON_CLICK, this);
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "1");
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		centerPane.appendChild(tabbox);

		South southPane = new South();
		southPane.setStyle("text-align: right");
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(btnOk);

		this.setBorder("normal");
		if (!ThemeManager.isUseCSSForWindowSize())
		{
			ZKUpdateUtil.setWindowWidthX(this, 600);
			ZKUpdateUtil.setWindowHeightX(this, 450);
		}
		else
		{
			addCallback(AFTER_PAGE_ATTACHED, t-> {
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
			});
		}
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
	}
	
	protected void initTabs(Tabs tabs) {
		//about
		Tab tab = new Tab();
		tab.setLabel(Msg.getMsg(Env.getCtx(), "About"));
		tab.setParent(tabs);
		Tabpanel tabPanel = createAbout();
		tabPanel.setParent(tabPanels);

		//Credit
		tab = new Tab();
		tab.setLabel(Msg.getMsg(Env.getCtx(), "Credits"));
		tab.setParent(tabs);
		tabPanel = createCredit();
		tabPanel.setParent(tabPanels);

		//Info
		tab = new Tab();
		tab.setLabel(Msg.getMsg(Env.getCtx(), "Info"));
		tab.setParent(tabs);
		tabPanel = createInfo();
		tabPanel.setParent(tabPanels);

		//Trace
		tab = new Tab();
		tab.setLabel("Errors");
		tabLog = tab;
		tab.setParent(tabs);
		tabPanel = createTrace();
		tabPanel.setParent(tabPanels);

		//Plugins
		tab = new Tab();
		tab.setLabel("Plugins");
		tabPlugins= tab;
		tabPanel = createPlugins();
		if (tabPanel != null) {
			tab.setParent(tabs);
			tabPanel.setParent(tabPanels);
		}
	}

	protected Tabpanel createTrace() {
		Tabpanel tabPanel = new Tabpanel();
		Vbox vbox = new Vbox();
		LayoutUtils.addSclass("about-trace-panel", vbox);
		vbox.setParent(tabPanel);
		ZKUpdateUtil.setHflex(vbox, "1");
		ZKUpdateUtil.setVflex(vbox, "1");
		
		Hbox hbox = new Hbox();
		hbox.setAlign("center");
		hbox.setPack("start");
		Label levelLabel = new Label("Trace Level:");
		ZKUpdateUtil.setHeight(levelLabel, "100%");
		hbox.appendChild(levelLabel);
		levelListBox = ListboxFactory.newDropdownListbox();
		levelListBox.addEventListener(Events.ON_SELECT, this);
		hbox.appendChild(levelListBox);
		for (Level level : CLogMgt.LEVELS)
		{
			levelListBox.appendItem(level.getName(), level);
		}

		Level level = CLogMgt.getLevel();
		for (int i = 0; i < CLogMgt.LEVELS.length; i++)
		{
			if (CLogMgt.LEVELS[i].intValue() == level.intValue())
			{
				levelListBox.setSelectedIndex(i);
				break;
			}
		}

		levelListBox.setEnabled(false);
		if (Env.getAD_Client_ID(Env.getCtx()) == 0)
		{
			MUser user = MUser.get(Env.getCtx());
			if (user.isAdministrator())
			{
				levelListBox.setEnabled(true);
				levelListBox.setTooltiptext("Set trace level. Warning: this will effect all session not just the current session");
				levelLabel.setTooltiptext("Set trace level. Warning: this will effect all session not just the current session");

				btnAdempiereLog = new Button("iDempiere Log");
				btnAdempiereLog.setTooltiptext("Download iDempiere log file from server");
				LayoutUtils.addSclass("txt-btn", btnAdempiereLog);
				btnAdempiereLog.addEventListener(Events.ON_CLICK, this);
				hbox.appendChild(new Space());
				hbox.appendChild(btnAdempiereLog);

				btnReloadLogProps = new Button("Reload Log Props");
				btnReloadLogProps.setTooltiptext("Reload the configuration of log levels from idempiere.properties file");
				LayoutUtils.addSclass("txt-btn", btnReloadLogProps);
				btnReloadLogProps.addEventListener(Events.ON_CLICK, this);
				hbox.appendChild(new Space());
				hbox.appendChild(btnReloadLogProps);
			}
		}

		ZKUpdateUtil.setHflex(hbox, "1");
		ZKUpdateUtil.setVflex(hbox, "0");
		vbox.appendChild(hbox);

		hbox = new Hbox();
		hbox.setAlign("center");
		hbox.setPack("start");
		bErrorsOnly = new Checkbox();
		bErrorsOnly.setLabel(Msg.getMsg(Env.getCtx(), "ErrorsOnly"));
		//default only show error
		bErrorsOnly.setChecked(true);
		bErrorsOnly.addEventListener(Events.ON_CHECK, this);
		hbox.appendChild(bErrorsOnly);
		hbox.appendChild(new Space());
		btnDownload = new Button(Msg.getMsg(Env.getCtx(), "SaveFile"));
		btnDownload .setTooltiptext("Download session log");
		LayoutUtils.addSclass("txt-btn", btnDownload);
		btnDownload.addEventListener(Events.ON_CLICK, this);
		hbox.appendChild(btnDownload);
		btnErrorEmail = new Button(Msg.getMsg(Env.getCtx(), "SendEMail"));
		btnErrorEmail.setTooltiptext("Email session log");
		LayoutUtils.addSclass("txt-btn", btnErrorEmail);
		btnErrorEmail.addEventListener(Events.ON_CLICK, this);
		hbox.appendChild(btnErrorEmail);
		btnViewLog = new Button(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "View")));
		btnViewLog.setTooltiptext("View session log");
		LayoutUtils.addSclass("txt-btn", btnViewLog);
		btnViewLog.addEventListener(Events.ON_CLICK, this);
		hbox.appendChild(btnViewLog);
		ZKUpdateUtil.setHflex(hbox, "1");
		ZKUpdateUtil.setVflex(hbox, "0");
		vbox.appendChild(hbox);

		Vector<String> columnNames = CLogErrorBuffer.get(true).getColumnNames(Env.getCtx());

		logTable = new Listbox();
		ListHead listHead = new ListHead();
		listHead.setParent(logTable);
		listHead.setSizable(true);
		for (Object obj : columnNames) {
			ListHeader header = new ListHeader(obj.toString());
			ZKUpdateUtil.setHflex(header, "1");
			listHead.appendChild(header);
		}

		vbox.appendChild(logTable);
		ZKUpdateUtil.setVflex(logTable, "1");
		ZKUpdateUtil.setHflex(logTable, "1");

		updateLogTable();

		return tabPanel;
	}

	private void updateLogTable() {
		Vector<Vector<Object>> data = CLogErrorBuffer.get(true).getLogData(bErrorsOnly.isChecked());
		SimpleListModel model = new SimpleListModel(data);
		model.setMaxLength(new int[]{0, 0, 0, 200, 0, 200});
		logTable.setItemRenderer(model);
		logTable.setModel(model);
		if (bErrorsOnly.isSelected())
			tabLog.setLabel(Msg.getMsg(Env.getCtx(), "Errors") + " (" + data.size() + ")");
		else
			tabLog.setLabel(Msg.getMsg(Env.getCtx(), "TraceInfo") + " (" + data.size() + ")");
	}

	protected Tabpanel createPlugins() {
		Properties ctx = Env.getCtx();
		MUser user = MUser.get(ctx);
		Tabpanel tabPanel = null;
		if (Env.getAD_Client_ID(ctx) == 0 && user.isAdministrator()) {
			tabPanel = new Tabpanel();
			Vbox vbox = new Vbox();
			ZKUpdateUtil.setHflex(vbox, "1");
			ZKUpdateUtil.setVflex(vbox, "1");

			pluginColumnNames = new Vector<String>();
			pluginColumnNames.add("");
			pluginColumnNames.add(Msg.getMsg(ctx, "Id"));
			pluginColumnNames.add(Msg.getMsg(ctx, "State"));
			pluginColumnNames.add(Msg.getCleanMsg(ctx, "Name"));
			pluginColumnNames.add(Msg.getMsg(ctx, "Version"));

			pluginsTable = ListboxFactory.newDataTableAutoSize();
			pluginData = new Vector<Vector<Object>>();
			int i = 0;
			pluginsTable.setColumnClass(i++, IDColumn.class, true);        //  0-bundleId
			pluginsTable.setColumnClass(i++, Integer.class, true);         //  1-bundleId
			pluginsTable.setColumnClass(i++, String.class, true);          //  2-State
			pluginsTable.setColumnClass(i++, String.class, true);          //  3-SymbolicName
			pluginsTable.setColumnClass(i++, String.class, true);          //  4-Version
			vbox.appendChild(pluginsTable);
			ZKUpdateUtil.setVflex(pluginsTable, "1");
			ZKUpdateUtil.setHflex(pluginsTable, "1");
			refreshPluginTable();
			pluginsTable.autoSize();
			pluginsTable.addEventListener(Events.ON_SELECT, this);
			
			pluginActions = new Listbox(
					new KeyNamePair[] {
							new KeyNamePair(PLUGIN_ACTION_NONE, ""),
							new KeyNamePair(PLUGIN_ACTION_STOP, Msg.getMsg(ctx, "Stop")),
							new KeyNamePair(PLUGIN_ACTION_START, Msg.getMsg(ctx, "Start")),
							new KeyNamePair(PLUGIN_ACTION_UPDATE, Msg.getMsg(ctx, "Update")),
							new KeyNamePair(PLUGIN_ACTION_UNINSTALL, Msg.getMsg(ctx, "Uninstall")),
							new KeyNamePair(PLUGIN_ACTION_INSTALL, Msg.getMsg(ctx, "Install"))
					});
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
			vbox.setParent(tabPanel);

			tabPlugins.setLabel(Msg.getMsg(ctx, "Plugins") + " (" + pluginData.size() + ")");
		}

		return tabPanel;
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
		boolean hasFragments = false;
		if (!isFragment) {
			if (rev.getWiring() != null) {
				if (rev.getWiring().getProvidedWires(BundleRevision.HOST_NAMESPACE).size() > 0) {
					hasFragments = true;
				}
			}
		}
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
			int pluginId = ((IDColumn)pluginVector.get(0)).getRecord_ID();
			BundleContext bundleCtx = WebUIActivator.getBundleContext();
			retValue = bundleCtx.getBundle(pluginId);
		}
		return retValue;
	}

	private void processPlugin() {
		Listitem actionItem = pluginActions.getSelectedItem();
		if (actionItem != null && actionItem.getValue() instanceof Integer) {
			int action = (Integer)actionItem.getValue();
			Bundle bundle = getSelectedBundle();
			if (action == PLUGIN_ACTION_STOP && bundle != null) {
				try {
					bundle.stop();
				} catch (BundleException e) {
					throw new AdempiereException(e);
				}
			} else if (action == PLUGIN_ACTION_START && bundle != null) {
				try {
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
		refreshPluginTable();
		refreshActionList();
	}

	private void refreshPluginTable() {
		int idx = pluginsTable.getSelectedIndex();
		pluginsTable.getModel().removeAll(pluginData);
		pluginData.removeAllElements();

		BundleContext bundleCtx = WebUIActivator.getBundleContext();
		for (Bundle bundle : bundleCtx.getBundles()) {
			Vector<Object> line = new Vector<Object>();
			Integer bundl = Long.valueOf(bundle.getBundleId()).intValue(); // potential problem converting Long to Integer, but WListBox cannot order Long
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

	protected Tabpanel createInfo() {
		Tabpanel tabPanel = new Tabpanel();
		Div div = new Div();
		LayoutUtils.addSclass("about-info-panel", div);
		div.setParent(tabPanel);
		ZKUpdateUtil.setHeight(div, "100%");
		div.setStyle("overflow: auto;");
		Pre pre = new Pre();
		pre.setParent(div);
		Text text = new Text(CLogMgt.getInfo(null).toString());
		text.setParent(pre);

		return tabPanel;
	}

	protected Tabpanel createCredit() {
		Tabpanel tabPanel = new Tabpanel();		
		Div div = new Div();
		LayoutUtils.addSclass("about-credit-panel", div);
		div.setParent(tabPanel);
		ZKUpdateUtil.setWidth(div, "100%");
		ZKUpdateUtil.setHeight(div, "100%");
		div.setStyle("overflow: auto;");
		Vbox vbox = new Vbox();
		LayoutUtils.addSclass("about-credit-panel-logo", vbox);
		vbox.setParent(div);
		Label caption = new Label("Top iDempiere sponsor");
		caption.setStyle("font-weight: bold;");
		caption.setParent(vbox);
		ToolBarButton link = new ToolBarButton();
		ZKUpdateUtil.setHeight(link, "72px");
		link.setImage("images/TrekGlobal.jpg");
		link.setParent(vbox);
		link.setHref("http://www.trekglobal.com");
		link.setTarget("_blank");

		Separator separator = new Separator();
		separator.setParent(div);

		Div panel = new Div();
		LayoutUtils.addSclass("about-credit-panel-sponsors", panel);
		panel.setParent(div);
		ZKUpdateUtil.setWidth(panel, "100%");
		vbox = new Vbox();
		LayoutUtils.addSclass("about-credit-panel-sponsors-header", vbox);
		ZKUpdateUtil.setWidth(vbox, "100%");
		vbox.setParent(panel);
		caption = new Label("Sponsors");
		caption.setStyle("font-weight: bold;");
		caption.setParent(vbox);
		Vbox content = new Vbox();
		LayoutUtils.addSclass("about-credit-panel-sponsors-links", content);
		ZKUpdateUtil.setWidth(content, "100%");
		content.setParent(panel);

		Grid grid = new Grid();
		grid.setParent(content);

		Rows rows = new Rows();
		rows.setParent(grid);

		Row row = new Row();
		row.setParent(rows);
		row.appendCellChild(addLink("GlobalQSS", "http://www.globalqss.com/"));
		row.appendCellChild(addLink("Adaxa", "http://www.adaxa.com/"));
		row.appendCellChild(addLink("Sysnova", "http://www.sysnova.com/"));
		row = new Row();
		row.setParent(rows);
		row.appendCellChild(addLink("See also ...", "http://www.idempiere.org/sponsors"), 3);

		panel = new Div();
		LayoutUtils.addSclass("about-credit-panel-contributors", panel);
		panel.setParent(div);
		ZKUpdateUtil.setWidth(panel, "100%");
		vbox = new Vbox();
		LayoutUtils.addSclass("about-credit-panel-contributors-header", vbox);
		ZKUpdateUtil.setWidth(vbox, "100%");
		vbox.setParent(panel);
		caption = new Label("Contributors");
		caption.setStyle("font-weight: bold;");
		caption.setParent(vbox);
		content = new Vbox();
		LayoutUtils.addSclass("about-credit-panel-contributors-links", content);
		ZKUpdateUtil.setWidth(content, "100%");
		content.setParent(panel);

		grid = new Grid();
		grid.setParent(content);

		rows = new Rows();
		rows.setParent(grid);

		row = new Row();
		row.setParent(rows);
		row.appendCellChild(addLink("Low Heng Sin", "http://www.adempiere.com/User:Hengsin"));
		row.appendCellChild(addLink("Carlos Ruiz", "http://wiki.idempiere.org/en/User:CarlosRuiz"));
		row = new Row();
		row.setParent(rows);
		row.appendCellChild(addLink("Hiep Lq", "http://wiki.idempiere.org/en/User:Hieplq"));
		row.appendCellChild(addLink("Nicolas Micoud", "http://wiki.idempiere.org/en/User:Nmicoud"));
		row = new Row();
		row.setParent(rows);
		row.appendCellChild(addLink("Jan Thielemann", "http://wiki.idempiere.org/en/User:Jan.thielemann"));
		row.appendCellChild(addLink("Redhuan D. Oon", "http://www.red1.org"));
		row = new Row();
		row.setParent(rows);
		row.appendCellChild(addLink("Thomas Bayen", "http://wiki.idempiere.org/en/User:TBayen"));
		row.appendCellChild(addLink("Ashley G Ramdass", "http://www.adempiere.com/User:Agramdass"));
		row = new Row();
		row.setParent(rows);
		row.appendCellChild(addLink("Teo Sarca", "http://www.adempiere.com/User:Teo_sarca"));
		row.appendCellChild(addLink("Trifon Trifonov", "http://www.adempiere.com/User:Trifonnt"));

		return tabPanel;
	}

	private ToolBarButton addLink(String label, String href) {
		ToolBarButton link = new ToolBarButton();
		link.setLabel(label);
		link.setHref(href);
		link.setTarget("_blank");
		return link;
	}

	protected Tabpanel createAbout() {
		Tabpanel tabPanel = new Tabpanel();

		Vbox vb = new Vbox();
		LayoutUtils.addSclass("about-main-panel", vb);
		ZKUpdateUtil.setWidth(vb, "100%");
		ZKUpdateUtil.setHeight(vb, "100%");
		vb.setAlign("center");
		vb.setPack("center");
		vb.setParent(tabPanel);

		Vbox vbox = new Vbox();
		LayoutUtils.addSclass("about-main-panel-logo", vbox);
		ZKUpdateUtil.setWidth(vbox, "100%");
		vbox.setAlign("center");
		vbox.setParent(vb);
		
		Image image = new Image(ThemeManager.getLargeLogo());
		image.setParent(vbox);

		vbox = new Vbox();
		LayoutUtils.addSclass("about-main-panel-version", vbox);
		ZKUpdateUtil.setWidth(vbox, "100%");
		vbox.setAlign("center");
		vbox.setParent(vb);
		
		Text text = new Text(Adempiere.getSubtitle());
		text.setParent(vbox);
		Separator separator = new Separator();
		separator.setParent(vbox);
		text = new Text(Adempiere.getVersion());
		text.setParent(vbox);
		
		vbox = new Vbox();
		LayoutUtils.addSclass("about-main-panel-links", vbox);
		ZKUpdateUtil.setWidth(vb, "100%");
		vbox.setAlign("center");
		vbox.setParent(vb);
		
		separator = new Separator();
		separator.setParent(vbox);
		ToolBarButton link = new ToolBarButton();
		link.setLabel("Project Site");
		link.setHref("http://www.idempiere.org");
		link.setTarget("_blank");
		link.setParent(vbox);

		separator = new Separator();
		separator.setParent(vbox);
		link = new ToolBarButton();
		link.setLabel("Community Wiki");
		link.setHref("http://wiki.idempiere.org");
		link.setTarget("_blank");
		link.setParent(vbox);

		separator = new Separator();
		separator.setParent(vbox);
		link = new ToolBarButton();
		link.setLabel("Functional Forums");
		link.setHref("http://groups.google.com/group/idempiere");
		link.setTarget("_blank");
		link.setParent(vbox);

		return tabPanel;
	}

	public void onEvent(Event event) throws Exception {
		if (event.getTarget() == bErrorsOnly) {
			this.updateLogTable();
		}
		else if (event.getTarget() == btnDownload)
			downloadLog();
		else if (event.getTarget() == btnViewLog)
			viewLog();
		else if (event.getTarget() == btnErrorEmail)
			cmd_errorEMail();
		else if (event.getTarget() == btnAdempiereLog)
			downloadAdempiereLogFile();
		else if (event.getTarget() == btnReloadLogProps)
			reloadLogProps();
		else if (event.getTarget() == levelListBox)
			setTraceLevel();
        else if (Events.ON_SELECT.equals(event.getName()) && event.getTarget() == pluginsTable)
        	refreshActionList();
		else if (Events.ON_CLICK.equals(event.getName())) {
			if (event.getTarget() == pluginProcess)
				processPlugin();
			else
				this.detach();
		}
	}

	private void reloadLogProps() {
		Properties props = new Properties();
		String propertyFileName = Ini.getFileName(false);
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(propertyFileName);
			props.load(fis);
		} catch (Exception e) {
			throw new AdempiereException("Could not load properties file, cause: " + e.getLocalizedMessage());
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {}
			}
		}
		String globalLevel = props.getProperty(Ini.P_TRACELEVEL);
		if (! Util.isEmpty(globalLevel)) {
			globalLevel = SecureEngine.decrypt(globalLevel, 0);
			if (! Util.isEmpty(globalLevel)) {
				CLogMgt.setLevel(globalLevel);
				Level level = CLogMgt.getLevel();
				for (int i = 0; i < CLogMgt.LEVELS.length; i++) {
					if (CLogMgt.LEVELS[i].intValue() == level.intValue()) {
						levelListBox.setSelectedIndex(i);
						break;
					}
				}
			}
		}
		for(Object key : props.keySet()) {
			if (key instanceof String) {
				String s = (String)key;
				if (s.endsWith("."+Ini.P_TRACELEVEL)) {
					String level = props.getProperty(s);
					if (! Util.isEmpty(level)) {
						level = SecureEngine.decrypt(level, 0);
						if (! Util.isEmpty(level)) {
							s = s.substring(0, s.length() - ("."+Ini.P_TRACELEVEL).length());
							CLogMgt.setLevel(s, level);
						}
					}
				}
			}
		}
	}

	private void setTraceLevel() {
		Listitem item = levelListBox.getSelectedItem();
		if (item != null && item.getValue() != null) {
			Level level = (Level) item.getValue();
			CLogMgt.setLevel(level);
			Ini.setProperty(Ini.P_TRACELEVEL, CLogMgt.getLevel().getName());
			Ini.saveProperties(false);
		}
	}

	private void downloadAdempiereLogFile() {
		String path = Ini.getAdempiereHome() + File.separator + "log";
		final FolderBrowser fileBrowser = new FolderBrowser(path, false);
		fileBrowser.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				String selected = fileBrowser.getPath();
				if (selected != null && selected.trim().length() > 0) {
					File file = new File(selected);
					if (file.exists() && file.isFile() && file.canRead()) {
						try {
							AMedia media = new AMedia(file, "text/plain", null);
							Filedownload.save(media);
						} catch (FileNotFoundException e) {
						}
					}
				}
			}
		});
	}

	private void downloadLog() {
		String log = CLogErrorBuffer.get(true).getErrorInfo(Env.getCtx(), bErrorsOnly.isChecked());
		AMedia media = new AMedia("trace.log", null, "text/plain", log.getBytes());
		Filedownload.save(media);
	}

	private void viewLog() {
		String log = CLogErrorBuffer.get(true).getErrorInfo(Env.getCtx(), bErrorsOnly.isChecked());
		Window w = new Window();
		w.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		w.setTitle("View Log");
		w.setBorder("normal");
		w.setClosable(true);
		w.setMaximizable(true);
		w.setSizable(true);
		ZKUpdateUtil.setWindowWidthX(w, 600);
		ZKUpdateUtil.setWindowHeightX(w, 500);
		Textarea textbox = new Textarea();
		textbox.setDynamicProperty("readonly", "true");
		textbox.setStyle("width:99%; height: 99%; margin: auto; display: inline-block;");
		w.appendChild(textbox);
		textbox.setValue(log);
		AEnv.showCenterScreen(w);
	}

	/**
	 * 	EMail Errors
	 */
	private void cmd_errorEMail()
	{
		this.detach();
		FeedbackManager.emailSupport(bErrorsOnly.isSelected());
	}	//	cmd_errorEMail
}
