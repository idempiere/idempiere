package org.compiere.grid;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;

import org.compiere.apps.ADialog;
import org.compiere.grid.ed.VDate;
import org.compiere.grid.ed.VNumber;
import org.compiere.model.GridTab;
import org.compiere.model.MConversionRate;
import org.compiere.model.MInvoice;
import org.compiere.swing.CComboBox;
import org.compiere.swing.CLabel;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;


public class VPaymentFormCash extends PaymentFormCash implements ActionListener {

	private VPaymentFormDialog dialog;
	
	private CLabel bBankAccountLabel = new CLabel();
	private CComboBox bBankAccountCombo = new CComboBox();
	private CLabel bCashBookLabel = new CLabel();
	private CComboBox bCashBookCombo = new CComboBox();
	private CLabel bCurrencyLabel = new CLabel();
	private CComboBox bCurrencyCombo = new CComboBox();
	private VDate bDateField;
	private CLabel bDateLabel = new CLabel();
	private CLabel bAmountLabel = new CLabel();
	private VNumber bAmountField = new VNumber();

	public VPaymentFormCash(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		bDateField = new VDate("DateAcct", false, false, true, DisplayType.Date, "DateAcct");
		dialog = new VPaymentFormDialog(this, windowNo);	
		init();		
		
		//Bojana&Daniel
		//If Invoice is Vendor invoice then Cash has to be created by negative amount
		int C_Invoice_ID = Env.getContextAsInt(Env.getCtx(), windowNo, "C_Invoice_ID");
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
		GridBagLayout bPanelLayout = new GridBagLayout();
		bBankAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
		bCurrencyLabel.setText(Msg.translate(Env.getCtx(), "C_Currency_ID"));		
		dialog.getPanel().setLayout(bPanelLayout);
		bAmountLabel.setText(Msg.getMsg(Env.getCtx(), "Amount"));
		//bAmountField.setText("");
		bDateLabel.setText(Msg.translate(Env.getCtx(), "DateAcct"));
		
		if (m_Cash_As_Payment){
			dialog.getPanel().add(bBankAccountLabel,   new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
					,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
			dialog.getPanel().add(bBankAccountCombo,    new GridBagConstraints(1, 0, 2, 1, 0.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));

		} else {
			bCashBookLabel.setText(Msg.translate(Env.getCtx(), "C_CashBook_ID"));
			dialog.getPanel().add(bCashBookLabel,  new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
					,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
			dialog.getPanel().add(bCashBookCombo,  new GridBagConstraints(1, 0, 2, 1, 0.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));

		}
		
		dialog.getPanel().add(bCurrencyLabel,  new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(bCurrencyCombo,  new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		dialog.getPanel().add(bDateLabel,  new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 0, 2, 0), 0, 0));
		dialog.getPanel().add(bDateField,  new GridBagConstraints(1, 2, 2, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		dialog.getPanel().add(bAmountLabel,   new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 0, 2, 0), 0, 0));
		dialog.getPanel().add(bAmountField,  new GridBagConstraints(1, 3, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
	}
	
	@Override
	public void loadData() {
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
			bCurrencyCombo.setSelectedItem(s_Currencies.get(C_Currency_ID));
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
			bBankAccountCombo.setSelectedItem(selectedBankAccount);
		
		
		list = getCashBookList();
		for (KeyNamePair pp : list)
			bCashBookCombo.addItem(pp);
		
		//	Set Selection
		if (selectedCashBook != null)
			bCashBookCombo.setSelectedItem(selectedCashBook);
	}
	
	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == bCurrencyCombo)
		{
			KeyNamePair pp = (KeyNamePair)bCurrencyCombo.getSelectedItem();
			BigDecimal amt = MConversionRate.convert(Env.getCtx(),
				m_Amount, m_C_Currency_ID, pp.getKey(), m_AD_Client_ID, m_AD_Org_ID);
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
			KeyNamePair kp = (KeyNamePair)bBankAccountCombo.getSelectedItem();
			if (kp != null)
				C_BankAccount_ID = kp.getKey();
		}
		
		//  find Bank Account if not qualified yet
		if (m_Cash_As_Payment && C_BankAccount_ID == 0)
		{
			// Check & Cash (Payment) must have a bank account
			if (C_BankAccount_ID == 0 && m_Cash_As_Payment)
			{
				ADialog.error(getWindowNo(), dialog, "FillMandatory", bBankAccountLabel.getText());
				dataOK = false;
			}
		}
		
		return dataOK;
	}

	@Override
	public boolean saveChangesInTrx(String trxName) {
		int newC_CashBook_ID = m_C_CashBook_ID;
		int newC_BankAccount_ID = 0;
		if (m_Cash_As_Payment){
			// get bank account
			KeyNamePair kp = (KeyNamePair)bBankAccountCombo.getSelectedItem();
			if (kp != null)
				newC_BankAccount_ID = kp.getKey();
		} else {
			// get cash book
			KeyNamePair kp = (KeyNamePair)bCashBookCombo.getSelectedItem();
			if (kp != null)
				newC_CashBook_ID = kp.getKey();	
		}
		
		Timestamp newDateAcct = (Timestamp)bDateField.getValue();
		
		boolean ok = save(newC_BankAccount_ID,newC_CashBook_ID, newDateAcct, (BigDecimal) bAmountField.getValue(), trxName);
		
		if (!ok)
			ADialog.error(getWindowNo(), dialog, "PaymentError", processMsg);
		else if (processMsg != null)
			ADialog.info(getWindowNo(), dialog, "PaymentCreated", processMsg);
		
		return true;
	}

	@Override
	public void showWindow()
	{
		dialog.setVisible(true);
	}
	
	@Override
	public void closeWindow()
	{
		dialog.dispose();
	}
	
	@Override
	public Object getWindow() {
		return dialog;
	}
}
