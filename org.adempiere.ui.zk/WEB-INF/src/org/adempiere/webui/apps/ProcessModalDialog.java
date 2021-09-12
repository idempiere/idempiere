/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2007 Low Heng Sin hengsin@avantz.com
 * _____________________________________________
 *****************************************************************************/
package org.adempiere.webui.apps;

import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.print.MPrintFormat;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 *
 *	Modal Dialog to Start process.
 *	Displays information about the process
 *		and lets the user decide to start it
 *  	and displays results (optionally print them).
 *  Calls ProcessCtl to execute.
 *  @author 	Low Heng Sin
 *  @author     arboleda - globalqss
 *  - Implement ShowHelp option on processes and reports
 */
public class ProcessModalDialog extends AbstractProcessDialog implements EventListener<Event>, DialogEvents
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6227339628038418701L;
	
	private static final String ON_OK_ECHO = "onOkEcho";
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(ProcessModalDialog.class);
	//
	private String orientation;

	/**
	 * @param aProcess
	 * @param WindowNo
	 * @param pi
	 * @param autoStart
	 */
	public ProcessModalDialog(int WindowNo, ProcessInfo pi, boolean autoStart)
	{
		this(null, WindowNo, pi, autoStart);
	}
	
	/**
	 * @param aProcess
	 * @param WindowNo
	 * @param pi
	 * @param autoStart
	 */
	public ProcessModalDialog(EventListener<Event> listener, int WindowNo, ProcessInfo pi, boolean autoStart)
	{
		super();
		
		if (listener != null) 
		{
			addEventListener(ON_WINDOW_CLOSE, listener);
			addEventListener(ON_BEFORE_RUN_PROCESS, listener);
		}

		log.info("Process=" + pi.getAD_Process_ID());
		try
		{
			init(Env.getCtx(), WindowNo, pi.getAD_Process_ID(), pi, autoStart, true);
			if (mainParameterLayout != null)// when auto start it's null
			{
				mainParameterLayout.setStyle("max-height:" + ClientInfo.get().desktopHeight + "px");
				ZKUpdateUtil.setVflex(mainParameterLayout, "1");
			}
			if (topParameterLayout != null)
			{
				topParameterLayout.setStyle("max-height:" + (ClientInfo.get().desktopHeight-130) + "px");
				ZKUpdateUtil.setVflex(topParameterLayout, "1");
			}
			if (bottomParameterLayout != null)
			{
				for(Component c : bottomParameterLayout.getChildren())
				{
					if (c instanceof HtmlBasedComponent)
						ZKUpdateUtil.setVflex((HtmlBasedComponent) c, "min");
				}
			}			
			this.setSclass("popup-dialog process-modal-dialog z-flex z-flex-column");
			this.setSizable(true);
			this.setMaximizable(true);
			if (ClientInfo.isMobile())
			{
				orientation = ClientInfo.get().orientation;
				ClientInfo.onClientInfo(this, this::onClientInfo);
			}
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
		addEventListener(ON_OK_ECHO, this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}

	public ProcessModalDialog (int WindowNo, int AD_Process_ID, int tableId, int recordId, boolean autoStart)
	{
		this(null, WindowNo, AD_Process_ID, tableId, recordId, autoStart);
	}
	
	/**
	 * Dialog to start a process/report
	 * @param WindowNo
	 * @param AD_Process_ID
	 * @param tableId
	 * @param recordId
	 * @param autoStart
	 */
	public ProcessModalDialog (EventListener<Event> listener, int WindowNo, int AD_Process_ID, int tableId, int recordId, boolean autoStart)
	{
		this(listener, WindowNo, new ProcessInfo("", AD_Process_ID, tableId, recordId), autoStart);
	}

	/**
	 * Dialog to start a process/report
	 * @param ctx
	 * @param parent not used
	 * @param title not used
	 * @param WindowNo
	 * @param AD_Process_ID
	 * @param tableId
	 * @param recordId
	 * @param autoStart
	 * @deprecated
	 */
	public ProcessModalDialog (Window parent, String title,
			int WindowNo, int AD_Process_ID,
			int tableId, int recordId, boolean autoStart)
	{
		this(WindowNo, AD_Process_ID, tableId, recordId, autoStart);
	}	//	ProcessDialog

	/**
	 * 	Set Visible
	 * 	(set focus to OK if visible)
	 * 	@param visible true if visible
	 */
	public boolean setVisible (boolean visible)
	{
		return super.setVisible(visible);
	}	//	setVisible

	/**
	 *	Dispose
	 */
	public void dispose()
	{
		super.dispose();
		getParameterPanel().restoreContext();
		this.detach();
	}	//	dispose
	
	@Override
	public void autoStart() 	
	{	
		this.setBorder("none");	
		this.setTitle(null);
		this.getFirstChild().setVisible(false);	
		super.autoStart();	
	}	

	@Override
	public void showBusyDialog() {
		BusyDialog progressWindow = createBusyDialog();
		if (this.getParent() != null){
			this.getParent().appendChild(progressWindow);
			LayoutUtils.openOverlappedWindow(this.getParent(), progressWindow, "middle_center");
		}
		
		this.setVisible(false);
	}
	
	@Override
	public void updateUI() {
		
	}
	
	@Override
	public void hideBusyDialog() {
		closeBusyDialog();
	}
	
	/**
	 * handle events
	 */
	public void onEvent(Event event) {		
		Component component = event.getTarget();
		if (component.equals(bOK)) {
			super.onEvent(event);
			onOk();
		} else if (event.getName().equals(ON_OK_ECHO)) {
			onOk();
		} else if (component.equals(bCancel)) {
			super.onEvent(event);
			onCancel();
		}else {
			super.onEvent(event);
		}
	}

	private void onCancel() {
		cancelProcess();
	}

	private void onOk() {
		if (getParameterPanel().isWaitingForDialog())
		{
			Events.echoEvent(ON_OK_ECHO, this, null);
			return;
		}
		if(fPrintFormat != null && fPrintFormat.getValue() != null) {
			MPrintFormat format = new MPrintFormat(Env.getCtx(), (Integer) fPrintFormat.getValue(), null);
			if (format != null) {
				getProcessInfo().setSerializableObject(format);
			}
		}
		if(freportType != null && freportType.getSelectedItem() != null) {
			getProcessInfo().setReportType(freportType.getSelectedItem().getValue().toString());
		}
		startProcess();
	}	
	
	protected void onClientInfo() {
		if (getPage() != null) {
			String newOrientation = ClientInfo.get().orientation;
			if (!newOrientation.equals(orientation)) {
				orientation = newOrientation;
				if (mainParameterLayout != null)// when auto start it's null
				{
					mainParameterLayout.setStyle("max-height:" + ClientInfo.get().desktopHeight + "px");
				}
				if (topParameterLayout != null)
				{
					topParameterLayout.setStyle("max-height:" + (ClientInfo.get().desktopHeight-130) + "px");
				}
				this.invalidate();
			}
		}
	}
}	//	ProcessModalDialog
