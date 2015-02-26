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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.session.SessionManager;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Layout;
import org.zkoss.zul.Vlayout;

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
	private static final long serialVersionUID = -3260639688339379279L;

	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ProcessModalDialog.class);
	//

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
			initComponents();
			init(Env.getCtx(), WindowNo, pi.getAD_Process_ID(), pi, "100%", autoStart, true);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
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

	private void initComponents() {
		this.setBorder("normal");
		Layout dialogBody = new Vlayout();
		dialogBody.setHflex("1");
		dialogBody.setStyle(dialogBody.getStyle() + ";max-height:" + (SessionManager.getAppDesktop().getClientInfo().desktopHeight - 100) + "px");
		
		
		Vlayout dialogContent = new Vlayout();
		dialogContent.setHflex("1");
		dialogContent.setVflex("1");
		dialogContent.setSclass("dialog-content");
		dialogContent.setStyle("overflow-y: auto;");
		dialogBody.appendChild(dialogContent);
		// description
		Div div = new Div();
		div.setId("message");
		div.appendChild(getMessage());
		div.setStyle("max-height: 150pt; overflow: auto;");
		dialogContent.appendChild(div);
		
		dialogContent.appendChild(getCenterPanel());
		// button panel
		Layout hbox = new Hlayout();
		hbox.setStyle("bottom:0;text-align:right");
		dialogBody.appendChild(hbox);
		hbox.setWidth("100%");
		hbox.setSclass("dialog-footer");
		
		Button btn = ButtonFactory.createNamedButton(ConfirmPanel.A_OK);
		btn.setId("Ok");
		btn.addEventListener(Events.ON_CLICK, this);
		hbox.appendChild(btn);

		btn = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL);
		btn.setId("Cancel");
		btn.addEventListener(Events.ON_CLICK, this);
		hbox.appendChild(btn);
		dialogBody.appendChild(hbox);
		this.appendChild(dialogBody);
		
		this.setSclass("popup-dialog");

	}

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
		if (component instanceof Button) {
			Button element = (Button)component;
			if ("Ok".equalsIgnoreCase(element.getId()))
				startProcess();
			else if ("Cancel".equalsIgnoreCase(element.getId()))
				cancelProcess();
		} else {
			super.onEvent(event);
		}
	}		
}	//	ProcessModalDialog
