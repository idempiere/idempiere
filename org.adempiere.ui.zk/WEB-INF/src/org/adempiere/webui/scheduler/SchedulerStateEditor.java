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
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.editor.IEditorConfiguration;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.GridField;
import org.compiere.model.MScheduler;
import org.compiere.model.StateChangeEvent;
import org.compiere.model.StateChangeListener;
import org.compiere.server.AdempiereServerMgr;
import org.compiere.server.IServerManager;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.distributed.IClusterService;
import org.idempiere.server.cluster.ClusterServerMgr;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;

/**
 * @author hengsin
 *
 */
public class SchedulerStateEditor extends WEditor {

	private static final String ON_START_SCHEDULER_EVENT = "onStartScheduler";
	private static final String ON_STOP_SCHEDULER_EVENT = "onStopScheduler";
	private static final String ON_ADD_SCHEDULER_EVENT = "onAddScheduler";
	
	private int schedulerState;

	/**
	 * 
	 * @param gridField
	 */
	public SchedulerStateEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public SchedulerStateEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        this(gridField, -1, tableEditor, editorConfiguration);
    }

	/**
	 * 
	 * @param gridField
	 * @param rowIndex
	 */
	public SchedulerStateEditor(GridField gridField, int rowIndex)
	{
		this(gridField, rowIndex, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param rowIndex
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public SchedulerStateEditor(GridField gridField, int rowIndex, boolean tableEditor, IEditorConfiguration editorConfiguration) {
        super(new Button(), gridField, rowIndex, tableEditor, editorConfiguration);
        Button btn = getComponent();
        
        btn.addEventListener(ON_START_SCHEDULER_EVENT, evt -> {
        	int id = getAD_Scheduler_ID();
			if (id > 0) {
				MScheduler model = new MScheduler(Env.getCtx(), id, null);
				IServerManager serverMgr = getServerMgr();
				if (serverMgr != null) {
					String error = serverMgr.start(model.getServerID());
					if (error == null) {
						Dialog.info(0, "SchedulerStartSuccess");
					} else {
						Dialog.error(0, "SchedulerStartFail", error);
					}
					getComponent().setLabel(getDisplay());
				}
				Clients.clearBusy();
			}
		});
		
		btn.addEventListener(ON_STOP_SCHEDULER_EVENT,  evt -> {
			int id = getAD_Scheduler_ID();
			if (id > 0) {
				MScheduler model = new MScheduler(Env.getCtx(), id, null);
				IServerManager serverMgr = getServerMgr();
				if (serverMgr != null) {
					String error = serverMgr.stop(model.getServerID());
					if (error == null) {
						Dialog.info(0, "SchedulerStopSuccess");
					} else {
						Dialog.error(0, "SchedulerStopFail", error);
					}
					getComponent().setLabel(getDisplay());
				}
				Clients.clearBusy();
			}
		});
		
		btn.addEventListener(ON_ADD_SCHEDULER_EVENT, evt -> {
			int id = getAD_Scheduler_ID();
			if (id > 0) {
				MScheduler model = new MScheduler(Env.getCtx(), id, null);
				IServerManager serverMgr = getServerMgr();
				if (serverMgr != null) {
					String error = serverMgr.addScheduler(model);
					if (error == null) {
						if (serverMgr.getServerInstance(model.getServerID()) != null) {
							Dialog.info(0, "SchedulerAddAndStartSuccess");
						} else {
							Dialog.error(0, "SchedulerAddAndStartFail", "Not accepted by any server node, please check the scheduler's schedule setting");
						}						
					} else {						
						Dialog.error(0, "SchedulerAddAndStartFail", error);
					}
					getComponent().setLabel(getDisplay());
				}
				Clients.clearBusy();
			}
		});
		
        getComponent().addEventListener(Events.ON_CLICK, this);
        getComponent().setLabel(getDisplay());
        if (gridField.getGridTab() != null) {
	        gridField.getGridTab().addStateChangeListener(new StateChangeListener() {			
				@Override
				public void stateChange(StateChangeEvent event) {
					if (event.getEventType() == StateChangeEvent.DATA_SAVE || event.getEventType() == StateChangeEvent.DATA_IGNORE) {
						getComponent().setLabel(getDisplay());
					}
				}
			});
        }
	}
    
	private int getAD_Scheduler_ID() {
		return gridTab != null ? gridTab.getRecord_ID() : 0;
	}

	/**
	 * @see org.zkoss.zk.ui.event.EventListener#onEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(Events.ON_CLICK)) {        	
			if (schedulerState == AdempiereServerMgr.SERVER_STATE_NOT_SCHEDULE) {
				ADWindow adwindow = ADWindow.findADWindow(getComponent());
				if (adwindow != null) {
					if (gridTab != null && (gridTab.isNew() || gridTab.needSave(false, false))) {
						adwindow.getADWindowContent().onSave(true, false, new Callback<Boolean>() {
							@Override
							public void onCallback(Boolean result) {
								if (result) {
									int id = getAD_Scheduler_ID();
						        	if (id <= 0)
						        		return;
									schedule();
								}
							}
						});					
					} else {
						schedule();
					}
				}
			} else if (schedulerState == AdempiereServerMgr.SERVER_STATE_STARTED) {
				ADWindow adwindow = ADWindow.findADWindow(getComponent());
				if (adwindow != null) {
					if (gridTab != null && (gridTab.isNew() || gridTab.needSave(false, false))) {
						adwindow.getADWindowContent().onSave(true, false, new Callback<Boolean>() {
							@Override
							public void onCallback(Boolean result) {
								if (result)
									stop();
							}
						});					
					} else {
						stop();
					}
				}
			} else if (schedulerState == AdempiereServerMgr.SERVER_STATE_STOPPED) {
				ADWindow adwindow = ADWindow.findADWindow(getComponent());
				if (adwindow != null) {
					if (gridTab != null && (gridTab.isNew() || gridTab.needSave(false, false))) {
						adwindow.getADWindowContent().onSave(true, false, new Callback<Boolean>() {
							@Override
							public void onCallback(Boolean result) {
								if (result)
									start();
							}
						});					
					} else {
						start();
					}
				}
			} else {
				Dialog.error(0, "CantReadCurrentSchedulerState");
			}
		}

	}

	private void schedule() {
		int id = getAD_Scheduler_ID();
    	if (id <= 0)
    		return;
    	
    	Dialog.ask(0, "SchedulerAddAndStartPrompt", new Callback<Boolean>() {					
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
					Events.echoEvent(ON_ADD_SCHEDULER_EVENT, getComponent(), null);							
				}
			}
		});			
	}
	
	

	private void stop() {
		int id = getAD_Scheduler_ID();
    	if (id <= 0)
    		return;
    	
    	Dialog.ask(0, "SchedulerStopPrompt", new Callback<Boolean>() {					
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
					Events.echoEvent(ON_STOP_SCHEDULER_EVENT, getComponent(), null);
				}
				
			}
		});
	}
	
	private void start() {
		int id = getAD_Scheduler_ID();
    	if (id <= 0)
    		return;
    	
    	Dialog.ask(0, "SchedulerStartPrompt", new Callback<Boolean>() {					
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
					Events.echoEvent(ON_START_SCHEDULER_EVENT, getComponent(), null);
				}
			}
		});
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setReadWrite(boolean)
	 */
	@Override
	public void setReadWrite(boolean readWrite) {
		GridField descriptionField = gridTab != null ? gridTab.getField("Description") : null;
		if (descriptionField != null)	
			getComponent().setEnabled(descriptionField.isEditable(true));
		else
			getComponent().setEnabled(readWrite);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isReadWrite()
	 */
	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setValue(java.lang.Object)
	 */
	@Override
	public void setValue(Object value) {
		getComponent().setLabel(getDisplay());
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getValue()
	 */
	@Override
	public Object getValue() {
		return getAD_Scheduler_ID();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getDisplay()
	 */
	@Override
	public String getDisplay() {
		schedulerState=0;
		MScheduler scheduler = new MScheduler(Env.getCtx(), getAD_Scheduler_ID(), null);
		IServerManager serverMgr = getServerMgr();
		schedulerState = serverMgr != null ? serverMgr.getServerStatus(scheduler.getServerID()) : -1;
		String label = null;
		if (schedulerState == IServerManager.SERVER_STATE_NOT_SCHEDULE)
			label = Msg.getMsg(Env.getCtx(), "SchedulerNotSchedule");
		else if (schedulerState == IServerManager.SERVER_STATE_STARTED)
			label = Msg.getMsg(Env.getCtx(), "SchedulerStarted");
		else if (schedulerState == IServerManager.SERVER_STATE_STOPPED)
			label = Msg.getMsg(Env.getCtx(), "SchedulerStopped");
		else
			label = "-";
		
		return label;
	}

	@Override
	public Button getComponent() {
		return (Button) component;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isSearchable()
	 */
	@Override
	public boolean isSearchable() {
		return false;
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
}

