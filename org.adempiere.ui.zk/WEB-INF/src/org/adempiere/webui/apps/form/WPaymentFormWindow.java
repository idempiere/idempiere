/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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
package org.adempiere.webui.apps.form;

import org.adempiere.webui.apps.BusyDialog;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.window.FDialog;
import org.compiere.grid.PaymentForm;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;

/**
 * 
 * @author Elaine
 *
 */
public class WPaymentFormWindow extends Window implements EventListener<Event>, DialogEvents {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2710316463655831868L;

	private PaymentForm paymentForm;
//	private int windowNo;
	
	private Panel mainPanel = new Panel();
	private Panel centerPanel = new Panel();
	private Borderlayout mainLayout = new Borderlayout();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	
	private boolean m_isLocked = false;
	private boolean initOK = false;
	private BusyDialog progressWindow;
	
	public WPaymentFormWindow(PaymentForm paymentForm, int windowNo)
	{
		super();
		
		this.paymentForm = paymentForm;
//		this.windowNo = windowNo;

		try {
			zkInit();
			initOK = dynInit(); // Null Pointer if order/invoice not saved yet
		} catch (Exception ex) {
			FDialog.error(windowNo, this, ex.getMessage() == null ? ex.toString() : ex.getMessage());
			initOK = false;
		}
		
		this.setTitle(Msg.getMsg(Env.getCtx(), "Payment"));
		this.setHeight("400px");
		this.setWidth("500px");
		this.setBorder("normal");
	}
	
	private void zkInit() throws Exception {
		this.appendChild(mainPanel);
		mainPanel.appendChild(mainLayout);
		mainPanel.setStyle("width: 100%; height: 100%; padding: 0; margin: 0");
		mainLayout.setHeight("100%");
		mainLayout.setWidth("100%");
		Center center = new Center();
		mainLayout.appendChild(center);
		center.appendChild(centerPanel = getPanel());
		centerPanel.setHflex("1");
		centerPanel.setVflex("1");
		center.setAutoscroll(true);
		//
		South south = new South();
		south.setStyle("border: none");
		mainLayout.appendChild(south);
		south.appendChild(confirmPanel);
		confirmPanel.addActionListener(this);
	}
	
	private boolean dynInit() throws Exception {
		boolean isInitOK = paymentForm.dynInit();
		centerPanel.setVisible(!paymentForm.isOnlyRule());
		return isInitOK;
	}
	
	public Panel getPanel() {
		return centerPanel;
	}
	
	/**************************************************************************
	 * Action Listener
	 * 
	 * @param e
	 *            event
	 */
	public void onEvent(Event e) {
		// Finish
		if (e.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			if (paymentForm.checkMandatory()) {
				paymentForm.saveChanges(); // cannot recover
				dispose();
			}
		} else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			dispose();
		
	} // actionPerformed
	
	public void runProcessOnline() {
		try {
			paymentForm.processOnline();
		} finally {
			unlockUI();
		}
	}
	
	public void unlockUI() {
		if (!m_isLocked) return;
		
		m_isLocked = false;
		hideBusyDialog();
		updateUI();
	}
	
	public void lockUI() {
		if (m_isLocked) return;
		
		m_isLocked = true;
		
		showBusyDialog();
	}
	
	private void hideBusyDialog() {
		if (progressWindow != null) {
			progressWindow.dispose();
			progressWindow = null;
		}
	}

	private void updateUI() {
		if (paymentForm.isApproved())
			dispose();
	}
	
	private void showBusyDialog() {
		progressWindow = new BusyDialog();
		progressWindow.setPage(this.getPage());
		progressWindow.doHighlighted();
	}
	
	public boolean isInitOK()
	{
		return initOK;
	}
}
