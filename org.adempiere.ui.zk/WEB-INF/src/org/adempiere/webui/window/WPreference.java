/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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

import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WYesNoEditor;
import org.adempiere.webui.grid.WQuickEntry;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MRole;
import org.compiere.model.MUserPreference;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Div;
/**
 *
 * @author hengsin
 *
 */
public class WPreference extends WQuickEntry implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8223456746437563389L;
	private static CLogger log = CLogger.getCLogger(WPreference.class);

	private WYesNoEditor 	adempiereSys;
	private WYesNoEditor 	logMigrationScript;
	private WGadgets 		gadgets;
	private A 				addgadgets;
	private A 				morePreferences;
	private MUserPreference preferences = null;
	private int             recordId    = 0;


	public WPreference() {
		super(Env.getZoomWindowID(MUserPreference.Table_ID, 0));

		try
		{
			jbInit();
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, ex.getMessage());
		}

		Boolean canAccessPreference = MRole.getDefault().getWindowAccess(m_AD_Window_ID);
		if (canAccessPreference != null && canAccessPreference) {
			initPOs();
			loadPreferences();
		}

		this.setTitle("");
	} //WPreference

	private void loadPreferences(){
		preferences = MUserPreference.getUserPreference(Env.getAD_User_ID(Env.getCtx()), Env.getAD_Client_ID(Env.getCtx()));
		recordId = preferences.get_ID();

		loadRecord(recordId);
	} //loadPreferences

	protected void jbInit() throws Exception
	{
		ZKUpdateUtil.setWidth(this, "230px");
		this.setBorder("normal");
		this.setClosable(true);
		this.setSizable(true);
		this.appendChild(centerPanel);
		init();
	} //jbInit

	private void init() {

		Div div = new Div();
		div.setStyle("background-color: transparent !important; border: none; margin: 5px;");
		morePreferences= new A();	
		morePreferences.setLabel(Msg.translate(Env.getCtx(), "MorePreferences"));
		morePreferences.addEventListener(Events.ON_CLICK, this);
		div.appendChild(morePreferences);
		this.appendChild(div);

		if (Env.getAD_Client_ID(Env.getCtx()) <= 20 && Env.getAD_User_ID(Env.getCtx()) <= 102) {
			adempiereSys = new WYesNoEditor("AdempiereSys", Msg.getMsg(Env.getCtx(), "AdempiereSys", true),
					null, false, false, true);
			adempiereSys.getComponent().setTooltiptext(Msg.getMsg(Env.getCtx(), "AdempiereSys", false));
			div = new Div();
			div.setStyle("background-color: transparent !important; border: none; margin: 5px;");
			div.appendChild(adempiereSys.getComponent());
			this.appendChild(div);
			adempiereSys.setValue(Env.getCtx().getProperty("AdempiereSys"));

			logMigrationScript = new WYesNoEditor("LogMigrationScript", Msg.getMsg(Env.getCtx(), "LogMigrationScript", true),
					null, false, false, true);
			logMigrationScript.getComponent().setTooltiptext(Msg.getMsg(Env.getCtx(), "LogMigrationScript", false));
			div = new Div();
			div.setStyle("background-color: transparent !important; border: none; margin: 5px;");
			div.appendChild(logMigrationScript.getComponent());
			this.appendChild(div);
			logMigrationScript.setValue(Env.getCtx().getProperty("LogMigrationScript"));
		}

		ToolBar toolbar = new ToolBar();
		toolbar.setAlign("end");
		this.appendChild(toolbar);
		ToolBarButton btn = new ToolBarButton("");
		btn.setName("btnSave");
		btn.setImage(ThemeManager.getThemeResource("images/Save24.png"));
		btn.setTooltiptext(Msg.getMsg(Env.getCtx(),"Save"));
		btn.addEventListener(Events.ON_CLICK, this);
		toolbar.appendChild(btn);
		toolbar.setStyle("border: none");

		div = new Div();
		div.setStyle("background-color: transparent !important; border: none; margin: 5px;");
		addgadgets= new A();	
		addgadgets.setLabel( Msg.translate(Env.getCtx(), "ManageGadgets"));
		addgadgets.addEventListener(Events.ON_CLICK, this);
		div.appendChild(addgadgets);
		this.appendChild(div);

	} //init

	public void onEvent(Event event) throws Exception {
		String nameEvent=event.getName();
		Component com =event.getTarget();

		if (Events.ON_CLICK.equals(nameEvent)) {
			if (com instanceof ToolBarButton) {
				onSave();
			}

			if (com == addgadgets) {
				gadgets = new WGadgets();
				gadgets.setClosable(true);
				gadgets.setSizable(true);
				ZKUpdateUtil.setWidth(gadgets, "40%");
				ZKUpdateUtil.setHeight(gadgets, "60%");
				gadgets.setTitle( Msg.translate(Env.getCtx(), "DashboardGadgets"));
				gadgets.setAttribute(Window.MODE_KEY, Mode.HIGHLIGHTED);
				AEnv.showWindow(gadgets);
				gadgets.focus();
			}

			if (com == morePreferences) {
				AEnv.zoom(MUserPreference.Table_ID, recordId);
			}
		}
	} //onEvent

	private void onSave() {
		actionSave();

		// Log Migration Script and AdempiereSys are just in-memory preferences, must not be saved
		if (logMigrationScript != null)
			Env.getCtx().setProperty("LogMigrationScript", (Boolean)logMigrationScript.getValue() ? "Y" : "N");
		if (adempiereSys != null)
			Env.getCtx().setProperty("AdempiereSys", (Boolean)adempiereSys.getValue() ? "Y" : "N");

		this.detach();
	} //onSave
}
