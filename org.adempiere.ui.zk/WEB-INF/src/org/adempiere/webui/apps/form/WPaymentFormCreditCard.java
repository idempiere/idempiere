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

import org.adempiere.util.PaymentUtil;
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
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.window.FDialog;
import org.compiere.grid.PaymentFormCreditCard;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MInvoice;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Space;

/**
 * 
 * @author Elaine
 *
 */
public class WPaymentFormCreditCard extends PaymentFormCreditCard implements EventListener<Event> {

	private WPaymentFormWindow window;
	
	private Label kTypeLabel = new Label();
	private Listbox kTypeCombo = ListboxFactory.newDropdownListbox();
	private Label kNumberLabel = new Label();
	private Textbox kNumberField = new Textbox();
	private Label kExpLabel = new Label();
	private Textbox kExpField = new Textbox();
	private Label kAmountLabel = new Label();
	private WNumberEditor kAmountField = new WNumberEditor();
	private Label kApprovalLabel = new Label();
	private Textbox kApprovalField = new Textbox();
	private Button kOnline = ButtonFactory.createNamedButton("Online");
	private Label kStatus = new Label();
	
	public WPaymentFormCreditCard(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		window = new WPaymentFormWindow(this, windowNo);
		init();
	}
	
	public void init() {
		Grid kLayout = GridFactory.newGridLayout();
		window.getPanel().appendChild(kLayout);
		kNumberField.setCols(16);
		kExpField.setCols(4);
		kApprovalField.setCols(4);
		kApprovalField.setType("password");
		kTypeLabel.setText(Msg.translate(Env.getCtx(), "CreditCardType"));
		kNumberLabel.setText(Msg.translate(Env.getCtx(), "CreditCardNumber"));
		kExpLabel.setText(Msg.getMsg(Env.getCtx(), "Expires"));
		kApprovalLabel.setText(Msg.translate(Env.getCtx(), "VoiceAuthCode"));
		kAmountLabel.setText(Msg.getMsg(Env.getCtx(), "Amount"));
		kOnline.addActionListener(this);
		window.getPanel().setId("kPanel");
		
		Columns columns = new Columns();
		kLayout.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		column.setWidth("40%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("60%");
		
		kAmountField.getComponent().setWidth("150px");
		kAmountField.getComponent().setId("K_Ammount");
		
		Rows rows = kLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(kTypeLabel.rightAlign());
		row.appendChild(kTypeCombo);
		kTypeCombo.addEventListener(Events.ON_SELECT, this);
		kTypeCombo.setId("K_Type");
		
		row = rows.newRow();
		row.appendChild(kNumberLabel.rightAlign());
		row.appendChild(kNumberField);
		kNumberField.setId("K_CreditCardNumber");
		
		row = rows.newRow();
		row.appendChild(kExpLabel.rightAlign());
		row.appendChild(kExpField);
		kExpField.setId("K_Expires");
		
		row = rows.newRow();
		row.appendChild(kAmountLabel.rightAlign());
		row.appendChild(kAmountField.getComponent());
		kAmountField.getComponent().addEventListener(Events.ON_BLUR, this);
		
		row = rows.newRow();
		row.appendChild(kApprovalLabel.rightAlign());
		row.appendChild(kApprovalField);
		kApprovalField.setId("K_Approval");
		
		row = rows.newRow();
		row.appendChild(new Space());
		row.appendChild(kOnline);
		kOnline.setId("K_Online");
		
		row = rows.newRow();
		row.appendCellChild(kStatus, 2);
		kStatus.setId("status");
	}

	@Override
	public void loadData() {
		super.loadData();
		
		kAmountField.setValue(m_Amount);
		
		if (m_C_Payment_ID != 0)
		{
			m_CCType = m_mPayment.getCreditCardType();
			kNumberField.setText(m_mPayment.getCreditCardNumber());
			kExpField.setText(m_mPayment.getCreditCardExp(null));
			kApprovalField.setText(m_mPayment.getVoiceAuthCode());
			kStatus.setText(m_mPayment.getR_PnRef());
			kAmountField.setValue(m_mPayment.getPayAmt());
			
			//	if approved/paid, don't let it change
			kTypeCombo.setEnabled(!(m_mPayment.isApproved() && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed)));
			kNumberField.setReadonly(m_mPayment.isApproved() && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed));
			kExpField.setReadonly(m_mPayment.isApproved() && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed));
			kApprovalField.setReadonly(m_mPayment.isApproved() && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed));
			kOnline.setEnabled(!(m_mPayment.isApproved() && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed)));
			kAmountField.setReadWrite(!(m_mPayment.isApproved() && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed)));
		}
		else if (m_mPaymentTransaction != null)
		{
			m_CCType = m_mPaymentTransaction.getCreditCardType();
			kNumberField.setText(m_mPaymentTransaction.getCreditCardNumber());
			kExpField.setText(PaymentUtil.getCreditCardExp(m_mPaymentTransaction.getCreditCardExpMM(), m_mPaymentTransaction.getCreditCardExpYY(), null));
			kApprovalField.setText(m_mPaymentTransaction.getVoiceAuthCode());
			kStatus.setText(m_mPaymentTransaction.getR_PnRef());
			kAmountField.setValue(m_mPaymentTransaction.getPayAmt());
			
			//	if approved/paid, don't let it change
			kTypeCombo.setEnabled(!m_mPaymentTransaction.isApproved());
			kNumberField.setReadonly(m_mPaymentTransaction.isApproved());
			kExpField.setReadonly(m_mPaymentTransaction.isApproved());
			kApprovalField.setReadonly(m_mPaymentTransaction.isApproved());
			kOnline.setEnabled(!m_mPaymentTransaction.isApproved());
			kAmountField.setReadWrite(!m_mPaymentTransaction.isApproved());			
		}
		
		/**
		 *	Load Credit Cards
		 */
		kTypeCombo.removeAllItems();
		
		ValueNamePair[] ccs = getCreditCardList();
		for (int i = 0; i < ccs.length; i++)
			kTypeCombo.addItem(ccs[i]);
		
		//	Set Selection
		if (selectedCreditCard != null)
			kTypeCombo.setSelectedValueNamePair(selectedCreditCard);
		
		if (m_mPayment.isApproved() && m_DocStatus.equals(MInvoice.DOCSTATUS_Completed))
		{
			kOnline.setVisible(m_mPayment.isOnline());
			kOnline.setEnabled(false);
			
			MBankAccountProcessor bankAccountProcessor = new MBankAccountProcessor(m_mPayment.getCtx(), m_mPayment.getC_BankAccount_ID(), m_mPayment.getC_PaymentProcessor_ID(), null);
			setBankAccountProcessor(bankAccountProcessor);
		}
		else if (m_mPaymentTransaction != null)
		{
			kOnline.setVisible(m_mPaymentTransaction.isOnline());
			kOnline.setEnabled(false);
			
			MBankAccountProcessor bankAccountProcessor = new MBankAccountProcessor(m_mPaymentTransaction.getCtx(), m_mPaymentTransaction.getC_BankAccount_ID(), m_mPaymentTransaction.getC_PaymentProcessor_ID(), null);
			setBankAccountProcessor(bankAccountProcessor);			
		}
		else
		{
			boolean exist = isBankAccountProcessorExist("", (BigDecimal) kAmountField.getValue());
			kOnline.setVisible(exist);
			
			if (exist)
				updateOnlineButton();
			else
				kApprovalField.setReadonly(false);
		}
	}
	
	public void onEvent(Event e)
	{
		if (e.getTarget() == kOnline) {
			window.lockUI();
			Clients.response(new AuEcho(window, "runProcessOnline", null));
		}
		else if (e.getTarget() == kTypeCombo || e.getTarget() == kAmountField)
			updateOnlineButton();
	}
	
	private void updateOnlineButton()
	{
		String CCType = null;
		ListItem selected = kTypeCombo.getSelectedItem(); 
		ValueNamePair vp = selected != null ? selected.toValueNamePair() : null;
		if (vp != null)
			CCType = vp.getValue();
		
		BigDecimal PayAmt = (BigDecimal) kAmountField.getValue();
		
		if (CCType != null && CCType.length() != 0 && PayAmt != null)
		{
			MBankAccountProcessor bankAccountProcessor = getBankAccountProcessor(CCType, PayAmt);
			kOnline.setEnabled(bankAccountProcessor != null);
			setBankAccountProcessor(bankAccountProcessor);
			
			if (bankAccountProcessor != null)
				kApprovalField.setReadonly(!bankAccountProcessor.isRequireVV());
			else
				kApprovalField.setReadonly(false);
		}
		else
		{
			kOnline.setEnabled(false);
			setBankAccountProcessor(null);
		}
	}

	@Override
	public boolean checkMandatory() {
		return true;
	}

	@Override
	public boolean saveChangesInTrx(final String trxName) {
		String newCCType = m_CCType;
		ListItem selected = kTypeCombo.getSelectedItem(); 
		ValueNamePair vp = selected != null ? selected.toValueNamePair() : null;
		if (vp != null)
			newCCType = vp.getValue();
		
		boolean ok = save(newCCType, kNumberField.getText(), kExpField.getText(), (BigDecimal) kAmountField.getValue(), trxName);		
		if(!ok)
			FDialog.error(getWindowNo(), window, "PaymentError", processMsg);
		else if (processMsg != null)
			FDialog.info(getWindowNo(), window, "PaymentCreated", processMsg);
		
		return ok;
	}
	
	@Override
	public void processOnline()
	{
		log.config("");
		if (!checkMandatory())
			return;

		ValueNamePair vp = kTypeCombo.getSelectedItem().toValueNamePair();
		String CCType = vp.getValue();
		
		boolean ok = processOnline(CCType, kNumberField.getText(), kExpField.getText());
		if (!ok)
			FDialog.error(getWindowNo(), window, "PaymentNotProcessed", processMsg);
		else 
		{
			loadData();
			if (processMsg != null)
				FDialog.info(getWindowNo(), window, "PaymentProcessed", processMsg);
		}
	}   //  online
	
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
