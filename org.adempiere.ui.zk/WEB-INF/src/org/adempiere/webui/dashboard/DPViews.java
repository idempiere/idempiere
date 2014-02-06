/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation
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
package org.adempiere.webui.dashboard;

import java.util.List;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.InfoSchedule;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Box;
import org.zkoss.zul.Vbox;

/**
 * Dashboard item: Info views
 * @author Elaine
 * @date November 20, 2008
 */
public class DPViews extends DashboardPanel implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8375414665766937581L;

	public DPViews()
	{
		super();
		setSclass("views-box");
		this.appendChild(createViewPanel());
	}

	private Box createViewPanel()
	{
		Vbox vbox = new Vbox();

		if (MSysConfig.getBooleanValue(MSysConfig.DPVIEWS_SHOWINFOACCOUNT, true, Env.getAD_Client_ID(Env.getCtx()))
				&& MRole.getDefault().isShowAcct() && MRole.getDefault().isAllow_Info_Account())
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoAccount");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoAccount")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/InfoAccount16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MSysConfig.getBooleanValue(MSysConfig.DPVIEWS_SHOWINFOSCHEDULE, true, Env.getAD_Client_ID(Env.getCtx()))
				&& MRole.getDefault().isAllow_Info_Schedule())
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoSchedule");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoSchedule")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/InfoSchedule16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}

		List<MInfoWindow> list = new Query(Env.getCtx(), MInfoWindow.Table_Name, "IsValid='Y' AND IsShowInDashboard='Y'", null)
		.setOnlyActiveRecords(true)
		.setOrderBy(MInfoWindow.COLUMNNAME_SeqNo)
		.list();

		MInfoWindow[] infos = list.toArray(new MInfoWindow[list.size()]);

		for (int i = 0; i < infos.length; i++)
		{
			MInfoWindow info = infos[i];
			if (MInfoWindow.get(MTable.getTableName(Env.getCtx(), info.getAD_Table_ID()), null) != null)
			{
				ToolBarButton btnViewItem = new ToolBarButton(info.getName());
				btnViewItem.setSclass("link");
				btnViewItem.setLabel(info.get_Translation("Name"));
				btnViewItem.setImage(ThemeManager.getThemeResource("images/" + (Util.isEmpty(info.getImageURL()) ? "Info16.png" : info.getImageURL())));
				btnViewItem.addEventListener(Events.ON_CLICK, this);
				vbox.appendChild(btnViewItem);
			}
		}

		return vbox;
	}

	public void onEvent(Event event)
	{
		Component comp = event.getTarget();
		String eventName = event.getName();

		if(eventName.equals(Events.ON_CLICK))
		{
			if(comp instanceof ToolBarButton)
			{
				ToolBarButton btn = (ToolBarButton) comp;
				String actionCommand = btn.getName();

				if (actionCommand.equals("InfoAccount"))
				{
					new org.adempiere.webui.acct.WAcctViewer();
				}
				else if (actionCommand.equals("InfoSchedule"))
				{
					InfoSchedule is = new InfoSchedule(null, false);
					is.setAttribute(Window.MODE_KEY, Mode.EMBEDDED);
					AEnv.showWindow(is);
				}
				else
				{
					int infoWindowID = new Query(Env.getCtx(), MInfoWindow.Table_Name, "Name = ?", null)
					.setParameters(actionCommand)
					.setOnlyActiveRecords(true)
					.firstIdOnly();

					if (infoWindowID<=0)
						return;

					String tableName = MTable.getTableName(Env.getCtx(), new MInfoWindow(Env.getCtx(), infoWindowID, null).getAD_Table_ID());
					InfoPanel.showPanel(tableName);
				}
			}
		}
	}
}
