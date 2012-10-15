package org.compiere.grid;

import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.math.BigDecimal;

import org.compiere.apps.ADialog;
import org.compiere.grid.ed.VNumber;
import org.compiere.model.GridTab;
import org.compiere.swing.CButton;
import org.compiere.swing.CComboBox;
import org.compiere.swing.CLabel;
import org.compiere.swing.CTextField;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;

public class VPaymentFormCreditCard extends PaymentFormCreditCard implements ActionListener {

	private VPaymentFormDialog dialog;
	
	private CLabel kTypeLabel = new CLabel();
	private CComboBox kTypeCombo = new CComboBox();
	private CLabel kNumberLabel = new CLabel();
	private CTextField kNumberField = new CTextField();
	private CLabel kNameLabel = new CLabel();
	private CTextField kNameField = new CTextField();
	private CLabel kExpLabel = new CLabel();
	private CTextField kExpField = new CTextField();
	private CLabel kAmountLabel = new CLabel();
	private VNumber kAmountField = new VNumber();
	private CLabel kApprovalLabel = new CLabel();
	private CTextField kApprovalField = new CTextField();
	private CButton kOnline = new CButton();
	private CLabel kStatus = new CLabel();

	
	public VPaymentFormCreditCard(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		dialog = new VPaymentFormDialog(this, windowNo);
		init();
	}
	
	public void init() {
		GridBagLayout kLayout = new GridBagLayout();
		dialog.getPanel().setLayout(kLayout);
		kNumberField.setPreferredSize(new Dimension(160, 21));
		kNameField.setPreferredSize(new Dimension(160, 21));
		kExpField.setPreferredSize(new Dimension(40, 21));
		kApprovalField.setPreferredSize(new Dimension(120, 21));
		kTypeLabel.setText(Msg.translate(Env.getCtx(), "CreditCardType"));
		kNumberLabel.setText(Msg.translate(Env.getCtx(), "CreditCardNumber"));
		kNameLabel.setText(Msg.translate(Env.getCtx(),"Name"));
		kExpLabel.setText(Msg.getMsg(Env.getCtx(), "Expires"));
		kApprovalLabel.setText(Msg.translate(Env.getCtx(), "VoiceAuthCode"));
		kAmountLabel.setText(Msg.getMsg(Env.getCtx(), "Amount"));
		kOnline.setText(Msg.getMsg(Env.getCtx(), "Online"));
		kOnline.addActionListener(this);
		kStatus.setText(" ");
		dialog.getPanel().add(kTypeLabel, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(kTypeCombo, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		dialog.getPanel().add(kNumberLabel, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(kNumberField, new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.VERTICAL, new Insets(2, 5, 2, 5), 0, 0));
		dialog.getPanel().add(kNameLabel, new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(kNameField, new GridBagConstraints(1, 2, 1, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.VERTICAL, new Insets(2, 5, 2, 5), 0, 0));
		dialog.getPanel().add(kExpLabel, new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 0), 0, 0));
		dialog.getPanel().add(kExpField, new GridBagConstraints(1, 3, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		dialog.getPanel().add(kAmountLabel,   new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 5, 0), 0, 0));
		dialog.getPanel().add(kAmountField,     new GridBagConstraints(1, 4, 1, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 5, 5), 0, 0));
		dialog.getPanel().add(kApprovalLabel, new GridBagConstraints(0, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 5, 0), 0, 0));
		dialog.getPanel().add(kApprovalField, new GridBagConstraints(1, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
		dialog.getPanel().add(kStatus, new GridBagConstraints(0, 6, 2, 1, 0.0, 0.0
			,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
		dialog.getPanel().add(kOnline, new GridBagConstraints(2, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
	}

	@Override
	public void loadData() {
		kAmountField.setValue(m_Amount);
		
		if (m_C_Payment_ID != 0)
		{
			kNumberField.setText(m_mPayment.getCreditCardNumber());
			kNameField.setText(m_mPayment.getA_Name());
			kExpField.setText(m_mPayment.getCreditCardExp(null));
			kApprovalField.setText(m_mPayment.getVoiceAuthCode());
			kStatus.setText(m_mPayment.getR_PnRef());
			kAmountField.setValue(m_mPayment.getPayAmt());
			
			//	if approved/paid, don't let it change
			kTypeCombo.setReadWrite(!m_mPayment.isApproved());
			kNumberField.setReadWrite(!m_mPayment.isApproved());
			kNameField.setReadWrite(!m_mPayment.isApproved());
			kExpField.setReadWrite(!m_mPayment.isApproved());
			kApprovalField.setReadWrite(!m_mPayment.isApproved());
			kOnline.setReadWrite(!m_mPayment.isApproved());
			kAmountField.setReadWrite(!m_mPayment.isApproved());
		}
		
		/**
		 *	Load Credit Cards
		 */
		ValueNamePair[] ccs = getCreditCardList();
		for (int i = 0; i < ccs.length; i++)
			kTypeCombo.addItem(ccs[i]);
		
		//	Set Selection
		if (selectedCreditCard != null)
			kTypeCombo.setSelectedItem(selectedCreditCard);
	}
	
	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == kOnline)
			processOnline();
	}
	
	@Override
	public boolean checkMandatory() {
		return true;
	}

	@Override
	public boolean saveChangesInTrx(String trxName) {
		String newCCType = m_CCType;
		ValueNamePair vp = (ValueNamePair)kTypeCombo.getSelectedItem();
		if (vp != null)
			newCCType = vp.getValue();

		boolean ok = save(newCCType, kNumberField.getText(), kExpField.getText(), (BigDecimal) kAmountField.getValue());		
		if(!ok)
			ADialog.error(getWindowNo(), dialog, "PaymentError", processMsg);
		else if (processMsg != null)
			ADialog.info(getWindowNo(), dialog, "PaymentCreated", processMsg);
		
		return true;
		
	}
	
	/**************************************************************************
	 *  Process Online (sales only) - if approved - exit
	 */
	private void processOnline()
	{
		ValueNamePair vp = (ValueNamePair)kTypeCombo.getSelectedItem();
		String CCType = vp.getValue();
		
		boolean ok = processOnline(CCType, kNumberField.getText(), kExpField.getText());
		if (!ok)
			ADialog.error(getWindowNo(), dialog, "PaymentError", processMsg);
		else if (processMsg != null)
			ADialog.info(getWindowNo(), dialog, "PaymentProcessed", processMsg);
	}   //  online

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
