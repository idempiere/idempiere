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

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;

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
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.window.FDialog;
import org.compiere.grid.PaymentFormCash;
import org.compiere.model.GridTab;
import org.compiere.model.MConversionRate;
import org.compiere.model.MInvoice;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * 
 * @author Elaine
 *
 */
public class WPaymentFormCash extends PaymentFormCash implements EventListener<Event> {

	private WPaymentFormWindow window;
	
	private Label bBankAccountLabel = new Label();
	private Listbox bBankAccountCombo = ListboxFactory.newDropdownListbox();
	private Label bCashBookLabel = new Label();
	private Listbox bCashBookCombo = ListboxFactory.newDropdownListbox();
	private Label bCurrencyLabel = new Label();
	private Listbox bCurrencyCombo = ListboxFactory.newDropdownListbox();
	private Label bDateLabel = new Label();
	private WDateEditor bDateField;
	private Label bAmountLabel = new Label();
	private WNumberEditor bAmountField = new WNumberEditor();
	
	public WPaymentFormCash() {
		super();
	}
	
	public void init(int windowNo, GridTab mTab) {
		super.init(windowNo, mTab);
		bDateField = new WDateEditor("DateAcct", false, false, true, "DateAcct");
		window = new WPaymentFormWindow(this, windowNo);
		init();
				
		//Bojana&Daniel
		//If Invoice is Vendor invoice then Cash has to be created by negative amount
		int C_Invoice_ID = Env.getContextAsInt(Env.getCtx(), getWindowNo(), "C_Invoice_ID");
		MInvoice invoice_tmp = new MInvoice (Env.getCtx(), C_Invoice_ID, null);
		if (! invoice_tmp.isSOTrx())
		{
			bAmountField.setValue(m_Amount.negate());
		}else {
			bAmountField.setValue(m_Amount);
		}
		invoice_tmp = null;
	}
	
	public void init() {
		Grid bPanelLayout = GridFactory.newGridLayout();
		window.getPanel().appendChild(bPanelLayout);
		bCashBookLabel.setText(Msg.translate(Env.getCtx(), "C_CashBook_ID"));
		bCurrencyLabel.setText(Msg.translate(Env.getCtx(), "C_Currency_ID"));
		bAmountLabel.setText(Msg.getMsg(Env.getCtx(), "Amount"));
		//bAmountField.setText("");
		bDateLabel.setText(Msg.translate(Env.getCtx(), "DateAcct"));
		window.getPanel().setId("bPanel");
		
		Columns columns = new Columns();
		bPanelLayout.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		column.setWidth("40%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("60%");
		
		bAmountField.getComponent().setWidth("150px");
		
		Rows rows = bPanelLayout.newRows();
		Row row = rows.newRow();
		if (m_Cash_As_Payment) {
			bBankAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
			row.appendChild(bBankAccountLabel.rightAlign());
			row.appendChild(bBankAccountCombo);
		} else {
			row.appendChild(bCashBookLabel.rightAlign());
			row.appendChild(bCashBookCombo);
		}
		
		row = rows.newRow();
		row.appendChild(bCurrencyLabel.rightAlign());
		row.appendChild(bCurrencyCombo);
		
		row = rows.newRow();
		row.appendChild(bDateLabel.rightAlign());
		row.appendChild(bDateField.getComponent());
		
		row = rows.newRow();
		row.appendChild(bAmountLabel.rightAlign());
		row.appendChild(bAmountField.getComponent());
	}

	@Override
	public void loadData() {
		super.loadData();
		
		bAmountField.setValue(m_Amount);
		
		if (m_C_Payment_ID != 0)
			bAmountField.setValue(m_mPayment.getPayAmt());
		
		//  Existing Cashbook entry
		if (m_C_CashLine_ID != 0)
			bAmountField.setValue(m_cashLine.getAmount()); 

		//	Accounting Date
		bDateField.setValue(m_DateAcct);
		
		// Is the currency an EMU currency?
		Integer C_Currency_ID = new Integer(m_C_Currency_ID);
		if (s_Currencies.containsKey(C_Currency_ID)) {
			Enumeration<Integer> en = s_Currencies.keys();
			while (en.hasMoreElements()) {
				Object key = en.nextElement();
				bCurrencyCombo.addItem(s_Currencies.get(key));
			}
			bCurrencyCombo.addActionListener(this);
			bCurrencyCombo.setSelectedKeyNamePair(s_Currencies.get(C_Currency_ID));
		} 
		else // No EMU Currency
		{
			bCurrencyLabel.setVisible(false); // Cash
			bCurrencyCombo.setVisible(false);
		}
		
		ArrayList<KeyNamePair> list = getBankAccountList();
		for (KeyNamePair pp : list)
			bBankAccountCombo.addItem(pp);
		
		//	Set Selection
		if (selectedBankAccount != null)
			bBankAccountCombo.setSelectedKeyNamePair(selectedBankAccount);
		
		
		list = getCashBookList();
		for (KeyNamePair pp : list)
			bCashBookCombo.addItem(pp);
		
		//	Set Selection
		if (selectedCashBook != null)
			bCashBookCombo.setSelectedKeyNamePair(selectedCashBook);
	}
	
	public void onEvent(Event e)
	{
		if (e.getTarget() == bCurrencyCombo)
		{
			KeyNamePair pp = bCurrencyCombo.getSelectedItem().toKeyNamePair();
			BigDecimal amt = MConversionRate.convert(Env.getCtx(), m_Amount, m_C_Currency_ID, pp.getKey(), m_AD_Client_ID, m_AD_Org_ID);
			bAmountField.setValue(amt);
		}
	}
	
	@Override
	public boolean checkMandatory() {
		int C_BankAccount_ID = 0;
		/***********************
		 *	Mandatory Data Check
		 */
		boolean dataOK = true;
		if (m_Cash_As_Payment)
		{
			ListItem selected = bBankAccountCombo.getSelectedItem(); 
			KeyNamePair kp = selected != null ? selected.toKeyNamePair() : null;
			if (kp != null)
				C_BankAccount_ID = kp.getKey();
		}
		
		//  find Bank Account if not qualified yet
		if (m_Cash_As_Payment && C_BankAccount_ID == 0)
		{
			// Check & Cash (Payment) must have a bank account
			if (C_BankAccount_ID == 0 && m_Cash_As_Payment)
			{
				FDialog.error(getWindowNo(), window, "FillMandatory", bBankAccountLabel.getValue());
				dataOK = false;
			}
		}
		
		return dataOK;
	}

	@Override
	public boolean saveChangesInTrx(final String trxName) {
		int newC_CashBook_ID = m_C_CashBook_ID;
		int newC_BankAccount_ID = 0;
		if (m_Cash_As_Payment){
			// get bank account
			ListItem selected = bBankAccountCombo.getSelectedItem(); 
			KeyNamePair kp = selected != null ? selected.toKeyNamePair() : null;
			if (kp != null)
				newC_BankAccount_ID = kp.getKey();
		} else {
			// get cash book
			ListItem selected = bCashBookCombo.getSelectedItem(); 
			KeyNamePair kp = selected != null ? selected.toKeyNamePair() : null;
			if (kp != null)
				newC_CashBook_ID = kp.getKey();	
		}
		
		Timestamp newDateAcct = (Timestamp)bDateField.getValue();
		
		boolean ok = save(newC_BankAccount_ID,newC_CashBook_ID, newDateAcct, (BigDecimal) bAmountField.getValue(), trxName);
		
		if (!ok)
			FDialog.error(getWindowNo(), window, "PaymentError", processMsg);
		else if (processMsg != null)
			FDialog.info(getWindowNo(), window, "PaymentCreated", processMsg);
		
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
