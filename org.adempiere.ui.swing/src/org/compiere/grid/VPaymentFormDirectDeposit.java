package org.compiere.grid;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.util.ArrayList;

import org.adempiere.plaf.AdempierePLAF;
import org.compiere.apps.ADialog;
import org.compiere.model.GridTab;
import org.compiere.swing.CButton;
import org.compiere.swing.CComboBox;
import org.compiere.swing.CLabel;
import org.compiere.swing.CTextField;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

public class VPaymentFormDirectDeposit extends PaymentFormDirectDeposit {
	
	private VPaymentFormDialog dialog;
	
	private CLabel tAccountLabel = new CLabel();
	private CComboBox tAccountCombo = new CComboBox();
	private CButton tOnline = new CButton();
	private CTextField tRoutingField = new CTextField();
	private CTextField tNumberField = new CTextField();
	private CLabel tStatus = new CLabel();
	private CLabel tRoutingText = new CLabel();
	private CLabel tNumberText = new CLabel();

	public VPaymentFormDirectDeposit(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		dialog = new VPaymentFormDialog(this, windowNo);
		init();
	}
	
	public void init() {
		GridBagLayout tPanelLayout = new GridBagLayout();
		dialog.getPanel().setLayout(tPanelLayout);
		tAccountLabel.setText(Msg.translate(Env.getCtx(), "C_BP_BankAccount_ID"));
		tRoutingField.setColumns(8);
		tNumberField.setColumns(10);
		tRoutingText.setText(Msg.translate(Env.getCtx(), "RoutingNo"));
		tNumberText.setText(Msg.translate(Env.getCtx(), "AccountNo"));
		tOnline.setText(Msg.getMsg(Env.getCtx(), "Online"));
		tStatus.setText(" ");
		dialog.getPanel().add(tAccountLabel, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 5, 0), 0, 0));
		dialog.getPanel().add(tAccountCombo, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
		dialog.getPanel().add(tRoutingField, new GridBagConstraints(1, 1, 2, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 0, 5), 0, 0));
		dialog.getPanel().add(tNumberField, new GridBagConstraints(1, 2, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 0, 5), 0, 0));
		dialog.getPanel().add(tStatus, new GridBagConstraints(0, 3, 2, 1, 0.0, 0.0
			,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
		dialog.getPanel().add(tRoutingText, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 0, 0), 0, 0));
		dialog.getPanel().add(tNumberText, new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 0, 0), 0, 0));
		dialog.getPanel().add(tOnline, new GridBagConstraints(3, 2, 1, 1, 0.0, 0.0
			,GridBagConstraints.NORTHEAST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
	}
	
	@Override
	public void loadData() {
		if (m_C_Payment_ID != 0)
		{
			tRoutingField.setText(m_mPayment.getRoutingNo());
			tNumberField.setText(m_mPayment.getAccountNo());
			tStatus.setText(m_mPayment.getR_PnRef());
		}
		
		ArrayList<KeyNamePair> list = getBankAccountList();
		for (KeyNamePair pp : list)
			tAccountCombo.addItem(pp);
	}
	
	@Override
	public boolean checkMandatory() {
		/***********************
		 *	Mandatory Data Check
		 */
		boolean dataOK = true;
		KeyNamePair bpba = (KeyNamePair)tAccountCombo.getSelectedItem();
		if (bpba == null)
		{
			tAccountCombo.setBackground(AdempierePLAF.getFieldBackground_Error());
			ADialog.error(getWindowNo(), dialog, "PaymentBPBankNotFound");
			dataOK = false;
		}
		//
		log.config("OK=" + dataOK);
		return dataOK;
	}

	@Override
	public boolean saveChangesInTrx(String trxName) {
		boolean ok = save();		
		if (!ok)
			ADialog.error(getWindowNo(), dialog, "PaymentError", processMsg);
		else if (processMsg != null)
			ADialog.info(getWindowNo(), dialog, "PaymentCreated", m_mPayment.getDocumentNo());
		
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
