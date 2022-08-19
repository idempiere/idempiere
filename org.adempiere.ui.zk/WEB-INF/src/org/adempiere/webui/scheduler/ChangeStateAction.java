/**********************************************************************
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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.adempiere.webui.scheduler;

import org.adempiere.base.Core;
import org.adempiere.util.Callback;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.action.IAction;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.ADWindowContent;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MScheduler;
import org.compiere.server.AdempiereServerMgr;
import org.compiere.server.IServerManager;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.distributed.IClusterService;
import org.idempiere.server.cluster.ClusterServerMgr;
import org.osgi.service.component.annotations.Component;
import org.zkoss.image.Image;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Toolbarbutton;

/**
 * @author hengsin
 *
 */
@Component(name = "org.adempiere.webui.scheduler.ChangeStateAction", service = {IAction.class})
public class ChangeStateAction implements IAction, EventListener<Event> {

	private static final String ON_START_SCHEDULER_EVENT = "onStartScheduler";
	private static final String ON_STOP_SCHEDULER_EVENT = "onStopScheduler";
	private static final String ON_ADD_SCHEDULER_EVENT = "onAddScheduler";
	private static final String SCHEDULER_MODEL = "scheduler.model";
	private static final String SCHEDULER_STATE = "scheduler.state";

	/**
	 * default constructor 
	 */
	public ChangeStateAction() {
	}

	@Override
	public void execute(Object target) {
		if (target instanceof ADWindow) {
			ADWindow adwindow = (ADWindow) target;
			ADWindowContent content = adwindow.getADWindowContent();
			GridTab gridTab = content.getADTab().getADTabpanel(0).getGridTab();
			if (MScheduler.Table_Name.equals(gridTab.getTableName()) && gridTab.getRecord_ID() > 0) {
				MScheduler scheduler = new MScheduler(Env.getCtx(), gridTab.getRecord_ID(), null);
				IServerManager serverMgr = getServerMgr();
				int status = serverMgr.getServerStatus(scheduler.getServerID());
				String label = null;
				if (status == IServerManager.SERVER_STATE_NOT_SCHEDULE)
					label = Msg.getMsg(Env.getCtx(), "SchedulerNotSchedule");
				else if (status == IServerManager.SERVER_STATE_STARTED)
					label = Msg.getMsg(Env.getCtx(), "SchedulerStarted");
				else if (status == IServerManager.SERVER_STATE_STOPPED)
					label = Msg.getMsg(Env.getCtx(), "SchedulerStopped");
				else
					Dialog.error(content.getWindowNo(), "CantReadCurrentSchedulerState");
				
				if (label == null)
					return;
				
				Button btn = ButtonFactory.createButton(label, null, null);
				btn.setAttribute(SCHEDULER_STATE, status);
				btn.setAttribute(SCHEDULER_MODEL, scheduler);
				btn.addActionListener(this);
				Popup popup = new Popup();
				popup.appendChild(btn);
				content.getComponent().appendChild(popup);
				popup.open(content.getToolbar().getButton("SchedulerState"), "after_end");
				
				GridField descriptionField = gridTab.getField("Description");
				if (!descriptionField.isEditable(Env.getCtx(), true, false)) {
					btn.setEnabled(false);
				}
				
				btn.addEventListener(ON_START_SCHEDULER_EVENT, evt -> {
					Object schedulerAttr = evt.getTarget().getAttribute(SCHEDULER_MODEL);
					if (schedulerAttr != null && schedulerAttr instanceof MScheduler) {
						MScheduler model = (MScheduler) schedulerAttr;
						String error = serverMgr.start(model.getServerID());
						if (error == null) {
							Dialog.info(0, "SchedulerStartSuccess");
						} else {
							Dialog.error(0, "SchedulerStartFail", error);
						}
						Clients.clearBusy();
					}
				});
				
				btn.addEventListener(ON_STOP_SCHEDULER_EVENT,  evt -> {
					Object schedulerAttr = evt.getTarget().getAttribute(SCHEDULER_MODEL);
					if (schedulerAttr != null && schedulerAttr instanceof MScheduler) {
						MScheduler model = (MScheduler) schedulerAttr;
						String error = serverMgr.stop(model.getServerID());
						if (error == null) {
							Dialog.info(0, "SchedulerStopSuccess");
						} else {
							Dialog.error(0, "SchedulerStopFail", error);
						}
						Clients.clearBusy();
					}
				});
				
				btn.addEventListener(ON_ADD_SCHEDULER_EVENT, evt -> {
					Object schedulerAttr = evt.getTarget().getAttribute(SCHEDULER_MODEL);
					if (schedulerAttr != null && schedulerAttr instanceof MScheduler) {
						String error = serverMgr.addScheduler(scheduler);
						if (error == null) {
							Dialog.info(0, "SchedulerAddAndStartSuccess");
						} else {
							Dialog.error(0, "SchedulerAddAndStartFail", error);
						}
						Clients.clearBusy();
					}
				});
			}
		}
	}

	private IServerManager getServerMgr() {
		IServerManager serverMgr = null;
		IClusterService service = Core.getClusterService();
		if (service != null)
			serverMgr = ClusterServerMgr.getInstance();
		else
			serverMgr = AdempiereServerMgr.get(false);
		return serverMgr;
	}

	@Override
	public void decorate(Toolbarbutton toolbarButton) {
		if (Util.isEmpty(toolbarButton.getTooltiptext()))
			toolbarButton.setTooltiptext(toolbarButton.getLabel());		
		toolbarButton.setIconSclass("z-icon-spinner");
		toolbarButton.setLabel(null);
		toolbarButton.setImageContent((Image)null);
		LayoutUtils.addSclass("font-icon-toolbar-button", toolbarButton);
	}

	@Override
	public void onEvent(Event evt) throws Exception {
		Object stateAttr = evt.getTarget().getAttribute(SCHEDULER_STATE);
		Object schedulerAttr = evt.getTarget().getAttribute(SCHEDULER_MODEL);
		if (stateAttr != null && stateAttr instanceof Number && schedulerAttr != null && schedulerAttr instanceof MScheduler) {
			int state = ((Number)stateAttr).intValue();
			if (state == IServerManager.SERVER_STATE_NOT_SCHEDULE) {
				Dialog.ask(0, "SchedulerAddAndStartPrompt", new Callback<Boolean>() {					
					@Override
					public void onCallback(Boolean result) {
						if (result) {
							Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
							Events.echoEvent(ON_ADD_SCHEDULER_EVENT, evt.getTarget(), null);							
						}
					}
				});				
			} else if (state == IServerManager.SERVER_STATE_STARTED) {				
				Dialog.ask(0, "SchedulerStopPrompt", new Callback<Boolean>() {					
					@Override
					public void onCallback(Boolean result) {
						if (result) {
							Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
							Events.echoEvent(ON_STOP_SCHEDULER_EVENT, evt.getTarget(), null);
						}
						
					}
				});				
			}
			else if (state == IServerManager.SERVER_STATE_STOPPED) {				
				Dialog.ask(0, "SchedulerStartPrompt", new Callback<Boolean>() {					
					@Override
					public void onCallback(Boolean result) {
						if (result) {
							Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
							Events.echoEvent(ON_START_SCHEDULER_EVENT, evt.getTarget(), null);
						}
					}
				});				
			}
		}
	}		
}
