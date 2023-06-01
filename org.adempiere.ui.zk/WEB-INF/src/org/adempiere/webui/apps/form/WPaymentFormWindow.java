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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.BusyDialog;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.grid.IPaymentForm;
import org.compiere.grid.PaymentForm;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;

/**
 * Window for {@link IPaymentForm}.
 * @author Elaine
 */
public class WPaymentFormWindow extends Window implements EventListener<Event>, DialogEvents {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2710316463655831868L;

	/** Form Controller */
	private PaymentForm paymentForm;
	private int windowNo;
	
	/** Main panel of form */
	private Panel mainPanel = new Panel();
	/** Center of {@link #mainLayout} */
	private Panel centerPanel = new Panel();
	/** Layout of {@link #mainPanel} */
	private Borderlayout mainLayout = new Borderlayout();
	/** South of {@link #mainLayout}. Action buttons panel. */
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	/** True when UI is lock */
	private boolean m_isLocked = false;
	/** Status of initialization */ 
	private boolean initOK = false;
	private BusyDialog progressWindow;
	
	/**
	 * @param paymentForm
	 * @param windowNo
	 */
	public WPaymentFormWindow(PaymentForm paymentForm, int windowNo)
	{
		super();
		
		this.paymentForm = paymentForm;
		this.windowNo = windowNo;

		try {
			zkInit();
			initOK = dynInit(); // Null Pointer if order/invoice not saved yet
		} catch (Exception ex) {
			Dialog.error(windowNo, ex.getMessage() == null ? ex.toString() : ex.getMessage());
			initOK = false;
		}
		
		this.setTitle(Msg.getMsg(Env.getCtx(), "Payment"));
		this.setSclass("popup-dialog payment-form-dialog");
		this.setBorder("normal");
		if (!ThemeManager.isUseCSSForWindowSize())
			ZKUpdateUtil.setWindowWidthX(this, 500);
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
	}
	
	/**
	 * @return window number
	 */
	protected int getWindowNo() {
		return this.windowNo;
	}
	
	/**
	 * Layout form.
	 * @throws Exception
	 */
	private void zkInit() throws Exception {
		this.appendChild(mainPanel);
		mainPanel.appendChild(mainLayout);
		Center center = new Center();
		center.setSclass("dialog-content");
		mainLayout.appendChild(center);
		ZKUpdateUtil.setHflex(mainLayout, "1");
		ZKUpdateUtil.setVflex(mainLayout, "min");	
		center.appendChild(centerPanel = getPanel());
		LayoutUtils.addSclass("payment-form-content", centerPanel);
		ZKUpdateUtil.setVflex(centerPanel, "min");
		ZKUpdateUtil.setHflex(centerPanel, "1");
		center.setAutoscroll(true);
		//
		South south = new South();
		south.setSclass("dialog-footer");		
		mainLayout.appendChild(south);
		south.appendChild(confirmPanel);
		confirmPanel.addActionListener(this);
	}
	
	/**
	 * Dynamic initialization.
	 * Call {@link PaymentForm#dynInit()}.
	 * @return initialization status
	 * @throws Exception
	 */
	private boolean dynInit() throws Exception {
		boolean isInitOK = paymentForm.dynInit();
		centerPanel.setVisible(!paymentForm.isOnlyRule());
		return isInitOK;
	}
	
	/**
	 * @return {@link #centerPanel}
	 */
	public Panel getPanel() {
		return centerPanel;
	}
	
	/**
	 * Event Listener
	 * 
	 * @param e event
	 */
	public void onEvent(Event e) {
		// Finish
		if (e.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			if (paymentForm.checkMandatory()) {
				paymentForm.saveChanges();
				dispose();
			}
		} else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			dispose();		
	}
	
	/**
	 * Handle runProcessOnline event.
	 * Call {@link PaymentForm#processOnline()}.
	 */
	public void runProcessOnline() {
		try {
			paymentForm.processOnline();
		} finally {
			unlockUI();
		}
	}
	
	/**
	 * Unlock and update UI.
	 */
	public void unlockUI() {
		if (!m_isLocked) return;
		
		m_isLocked = false;
		hideBusyDialog();
		updateUI();
	}
	
	/**
	 * Lock UI and show in progress dialog.
	 */
	public void lockUI() {
		if (m_isLocked) return;
		
		m_isLocked = true;
		
		showBusyDialog();
	}
	
	/**
	 * Close in progress dialog.
	 */
	private void hideBusyDialog() {
		if (progressWindow != null) {
			progressWindow.dispose();
			progressWindow = null;
		}
	}

	/**
	 * Update UI after completion of processing/save.<br/>
	 * Call from {@link #unlockUI()}.
	 */
	private void updateUI() {
		if (paymentForm.isApproved())
			dispose();
	}
	
	/**
	 * Show in progress window.
	 */
	private void showBusyDialog() {
		progressWindow = new BusyDialog();
		progressWindow.setPage(this.getPage());
		progressWindow.doHighlighted();
	}
	
	/**
	 * @return true if initialization have been completed sucessfully
	 */
	public boolean isInitOK()
	{
		return initOK;
	}
}
