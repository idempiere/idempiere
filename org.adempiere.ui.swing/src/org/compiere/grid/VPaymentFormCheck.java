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
package org.compiere.grid;

import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Enumeration;

import org.adempiere.plaf.AdempierePLAF;
import org.compiere.apps.ADialog;
import org.compiere.grid.ed.VNumber;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MConversionRate;
import org.compiere.model.MPaymentValidate;
import org.compiere.swing.CButton;
import org.compiere.swing.CComboBox;
import org.compiere.swing.CLabel;
import org.compiere.swing.CTextField;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 * 
 * @author Elaine
 *
 */
public class VPaymentFormCheck extends PaymentFormCheck implements ActionListener, FocusListener {

	private VPaymentFormDialog dialog;
	
	private CLabel sBankAccountLabel = new CLabel();
	private CComboBox sBankAccountCombo = new CComboBox();
	private CLabel sCurrencyLabel = new CLabel();
	private CComboBox sCurrencyCombo = new CComboBox();
	private CLabel sAmountLabel = new CLabel();
	private VNumber sAmountField = new VNumber();
	private CLabel sRoutingLabel = new CLabel();
	private CTextField sRoutingField = new CTextField();	
	private CLabel sNumberLabel = new CLabel();
	private CTextField sNumberField = new CTextField();
	private CLabel sCheckLabel = new CLabel();
	private CTextField sCheckField = new CTextField();
	private CButton sOnline = new CButton();
	private CLabel sStatus = new CLabel();

	public VPaymentFormCheck(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		dialog = new VPaymentFormDialog(this, windowNo);
		init();
	}
	
	public void init() {
		GridBagLayout sPanelLayout = new GridBagLayout();
		dialog.getPanel().setLayout(sPanelLayout);
		sBankAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));
		sAmountLabel.setText(Msg.getMsg(Env.getCtx(), "Amount"));
		//sAmountField.setText("");
		sRoutingLabel.setText(Msg.translate(Env.getCtx(), "RoutingNo"));
		sNumberLabel.setText(Msg.translate(Env.getCtx(), "AccountNo"));
		sCheckLabel.setText(Msg.translate(Env.getCtx(), "CheckNo"));
		sCheckField.setColumns(8);
		sCurrencyLabel.setText(Msg.translate(Env.getCtx(), "C_Currency_ID"));
		sNumberField.setPreferredSize(new Dimension(100, 21));
		sRoutingField.setPreferredSize(new Dimension(70, 21));
		sStatus.setText(" ");
		sOnline.setText(Msg.getMsg(Env.getCtx(), "Online"));
		sOnline.addActionListener(this);
		dialog.getPanel().add(sBankAccountLabel,   new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 0, 2, 0), 0, 0));
		dialog.getPanel().add(sBankAccountCombo,    new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		dialog.getPanel().add(sCurrencyLabel,   new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(sCurrencyCombo,    new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		dialog.getPanel().add(sAmountLabel,   new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 5, 0), 0, 0));
		dialog.getPanel().add(sAmountField,     new GridBagConstraints(1, 2, 1, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 5, 5), 0, 0));
		sAmountField.addFocusListener(this);
		dialog.getPanel().add(sRoutingLabel,   new GridBagConstraints(0, 3, 1, 2, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(0, 0, 2, 0), 0, 0));
		dialog.getPanel().add(sRoutingField,    new GridBagConstraints(1, 3, 2, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 5, 2, 0), 0, 0));
		dialog.getPanel().add(sNumberLabel,   new GridBagConstraints(0, 5, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(sNumberField,    new GridBagConstraints(1, 5, 2, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 5, 2, 0), 0, 0));
		dialog.getPanel().add(sCheckLabel,   new GridBagConstraints(0, 6, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(sCheckField,    new GridBagConstraints(1, 6, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 0), 0, 0));
		dialog.getPanel().add(sOnline,      new GridBagConstraints(3, 6, 1, 1, 0.0, 0.0
				,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
		dialog.getPanel().add(sStatus,    new GridBagConstraints(0, 7, 3, 1, 0.0, 0.0
			,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));	
	}

	@Override
	public void loadData() {
		sAmountField.setValue(m_Amount);
		
		if (m_C_Payment_ID != 0)
		{
			sRoutingField.setText(m_mPayment.getRoutingNo());
			sNumberField.setText(m_mPayment.getAccountNo());
			sCheckField.setText(m_mPayment.getCheckNo());
			sStatus.setText(m_mPayment.getR_PnRef());
			sAmountField.setValue(m_mPayment.getPayAmt());
		}
		
		//	Is the currency an EMU currency?
		Integer C_Currency_ID = new Integer(m_C_Currency_ID);
		if (s_Currencies.containsKey(C_Currency_ID))
		{
			Enumeration<Integer> en = s_Currencies.keys();
			while (en.hasMoreElements())
			{
				Object key = en.nextElement();
				sCurrencyCombo.addItem(s_Currencies.get(key));
			}
			sCurrencyCombo.addActionListener(this);
			sCurrencyCombo.setSelectedItem(s_Currencies.get(C_Currency_ID));
		}
		else	//	No EMU Currency
		{
			sCurrencyLabel.setVisible(false);	//	Check
			sCurrencyCombo.setVisible(false);
		}

		ArrayList<KeyNamePair> list = getBankAccountList();
		for (KeyNamePair pp : list)
			sBankAccountCombo.addItem(pp);
		
		//	Set Selection
		if (selectedBankAccount != null)
			sBankAccountCombo.setSelectedItem(selectedBankAccount);
		
		boolean exist = isBankAccountProcessorExist(m_C_Currency_ID, (BigDecimal) sAmountField.getValue());
		sOnline.setVisible(exist);
		
		if (exist)
			updateOnlineButton();
	}
	
	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == sCurrencyCombo)
		{
			int C_Currency_ID = 0;
			KeyNamePair pp = (KeyNamePair)sCurrencyCombo.getSelectedItem();
			if (pp != null)
				C_Currency_ID = pp.getKey();
			
			BigDecimal amt = MConversionRate.convert(Env.getCtx(),
				m_Amount, m_C_Currency_ID, C_Currency_ID, m_AD_Client_ID, m_AD_Org_ID);
			sAmountField.setValue(amt);
			
			updateOnlineButton();
		}
		else if (e.getSource() == sOnline)
			processOnline();
	}
	
	@Override
	public void focusGained(FocusEvent e) {
	}

	@Override
	public void focusLost(FocusEvent e) {
		if (e.getSource() == sAmountField)
			updateOnlineButton();
	}
	
	private void updateOnlineButton()
	{
		int C_Currency_ID = 0;
		KeyNamePair pp = (KeyNamePair)sCurrencyCombo.getSelectedItem();
		if (pp != null)
			C_Currency_ID = pp.getKey();
		
		BigDecimal PayAmt = (BigDecimal) sAmountField.getValue();
		
		if (C_Currency_ID > 0 && PayAmt != null)
		{
			MBankAccountProcessor bankAccountProcessor = getBankAccountProcessor(C_Currency_ID, PayAmt);
			sOnline.setEnabled(bankAccountProcessor != null);
			setBankAccountProcessor(bankAccountProcessor);
		}
		else
		{
			sOnline.setEnabled(false);
			setBankAccountProcessor(null);
		}
	}
	
	@Override
	public boolean checkMandatory() {
		int C_BankAccount_ID = 0;
		/***********************
		 *	Mandatory Data Check
		 */
		boolean dataOK = true;
		KeyNamePair kp = (KeyNamePair)sBankAccountCombo.getSelectedItem();
		if (kp != null)
			C_BankAccount_ID = kp.getKey();
		String error = MPaymentValidate.validateRoutingNo(sRoutingField.getText());
		if (error.length() != 0)
		{
			sRoutingField.setBackground(AdempierePLAF.getFieldBackground_Error());
			ADialog.error(getWindowNo(), dialog, error);
			dataOK = false;
		}
		error = MPaymentValidate.validateAccountNo(sNumberField.getText());
		if (error.length() != 0)
		{
			sNumberField.setBackground(AdempierePLAF.getFieldBackground_Error());
			ADialog.error(getWindowNo(), dialog, error);
			dataOK = false;
		}
		error = MPaymentValidate.validateCheckNo(sCheckField.getText());
		if (error.length() != 0)
		{
			sCheckField.setBackground(AdempierePLAF.getFieldBackground_Error());
			ADialog.error(getWindowNo(), dialog, error);
			dataOK = false;
		}
		
		// Check & Cash (Payment) must have a bank account
		if (C_BankAccount_ID == 0)
		{
			ADialog.error(getWindowNo(), dialog, "FillMandatory", sBankAccountLabel.getText());
			dataOK = false;
		}
		
		return dataOK;
	}

	@Override
	public boolean saveChangesInTrx(String trxName) {
		int newC_BankAccount_ID = 0;
		KeyNamePair kp = (KeyNamePair)sBankAccountCombo.getSelectedItem();
		if (kp != null)
			newC_BankAccount_ID = kp.getKey();
		
		boolean ok = save(newC_BankAccount_ID, sRoutingField.getText(), sNumberField.getText(), sCheckField.getText(), (BigDecimal) sAmountField.getValue());		
		if (!ok)
			ADialog.error(getWindowNo(), dialog, "PaymentError", processMsg);
		else if (processMsg != null)
			ADialog.info(getWindowNo(), dialog, "PaymentCreated", m_mPayment.getDocumentNo());
		
		return ok;
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
