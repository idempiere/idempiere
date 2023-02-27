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

import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.grid.PaymentFormDirect;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccount;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Space;

/**
 * Abstract base payment form class for payment rule direct debit and direct deposit.
 * @author Elaine
 *
 */
public abstract class WPaymentFormDirect extends PaymentFormDirect implements EventListener<Event> {
	/** Payment form window instance */
	private WPaymentFormWindow window;
	
	private Label tAccountLabel = new Label();
	/** Bank accounts */
	private Listbox tAccountCombo = ListboxFactory.newDropdownListbox();
	private Button tOnline = new Button();
	/** Routing number */
	private Textbox tRoutingField = new Textbox();
	/** Account number */
	private Textbox tNumberField = new Textbox();
	private Label tStatus = new Label();
	/** Label for {@link #tRoutingField} */
	private Label tRoutingText = new Label();
	/** Label for {@link #tNumberField} */
	private Label tNumberText = new Label();
	
	/**
	 * @param windowNo
	 * @param mTab
	 * @param isDebit true for direct debit, false for direct deposit
	 */
	public WPaymentFormDirect(int windowNo, GridTab mTab, boolean isDebit) {
		super(windowNo, mTab, isDebit);
		window = new WPaymentFormWindow(this, windowNo);
		init();
	}
	
	/**
	 * Layout {@link #window}
	 */
	protected void init() {		
		Grid tPanelLayout = GridFactory.newGridLayout();
		window.getPanel().appendChild(tPanelLayout);
		tAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
		tRoutingField.setCols(8);
		tNumberField.setCols(10);
		tRoutingText.setText(Msg.translate(Env.getCtx(), "RoutingNo"));
		tNumberText.setText(Msg.translate(Env.getCtx(), "AccountNo"));
		tOnline.setLabel(Msg.getMsg(Env.getCtx(), "Online"));
		LayoutUtils.addSclass("txt-btn", tOnline);
		tOnline.addActionListener(this);
		window.getPanel().setId("tPanel");
		
		Columns columns = new Columns();
		tPanelLayout.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "40%");
		
		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "60%");
		
		Rows rows = tPanelLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(tAccountLabel.rightAlign());
		row.appendChild(tAccountCombo);
		
		row = rows.newRow();
		row.appendChild(tRoutingText.rightAlign());
		row.appendChild(tRoutingField);
		
		row = rows.newRow();
		row.appendChild(tNumberText.rightAlign());
		row.appendChild(tNumberField);
		
		row = rows.newRow();
		row.appendChild(new Space());
		row.appendChild(tOnline);		
		
		row = rows.newRow();
		row.appendCellChild(tStatus, 2);
	}

	@Override
	public void loadData() {		
		super.loadData();
		
		if (m_C_Payment_ID != 0)
		{
			tRoutingField.setText(m_mPayment.getRoutingNo());
			tNumberField.setText(m_mPayment.getAccountNo());
			tStatus.setText(m_mPayment.getR_PnRef());
		}
		
		ArrayList<KeyNamePair> list = getBankAccountList();
		for (KeyNamePair pp : list)
			tAccountCombo.addItem(pp);
		
		boolean exist = isBankAccountProcessorExist();
		tOnline.setVisible(exist);
		
		MBankAccountProcessor bankAccountProcessor = getBankAccountProcessor();
		setBankAccountProcessor(bankAccountProcessor);
	}
	
	@Override
	public void onEvent(Event e)
	{
		if (e.getTarget() == tOnline) 
		{
			window.lockUI();
			Clients.response(new AuEcho(window, "runProcessOnline", null));
		}
	}

	@Override
	public boolean checkMandatory() {
		/***********************
		 *	Mandatory Data Check
		 */
		boolean dataOK = true;
		ListItem selected =  tAccountCombo.getSelectedItem();
		KeyNamePair ba = selected != null ? selected.toKeyNamePair() : null;
		if (ba == null)
		{
			Dialog.error(getWindowNo(), "FillMandatory", Msg.translate(Env.getCtx(), MBankAccount.COLUMNNAME_C_BankAccount_ID));
			dataOK = false;
		}
		//
		if (log.isLoggable(Level.CONFIG)) log.config("OK=" + dataOK);
		return dataOK;
	}

	@Override
	public boolean saveChangesInTrx(final String trxName) {		
		ListItem selected =  tAccountCombo.getSelectedItem();
		KeyNamePair ba = selected != null ? selected.toKeyNamePair() : null;
		int C_BankAccount_ID = ba != null ? ba.getKey() : 0;
		boolean ok = save(C_BankAccount_ID, tRoutingField.getText(), tNumberField.getText(), trxName);		
		if (!ok)
			Dialog.error(getWindowNo(), "PaymentError", processMsg);
		else
			Dialog.info(getWindowNo(), "PaymentCreated", m_mPayment.getDocumentNo());
		
		return ok;
	}

	@Override
	public void showWindow() {
		window.setVisible(true);
	}

	@Override
	public void closeWindow() {
		window.dispose();
	}

	@Override
	public Object getWindow() {
		return window;
	}
}
