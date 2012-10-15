package org.compiere.grid;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.util.ArrayList;

import org.compiere.model.GridTab;
import org.compiere.swing.CComboBox;
import org.compiere.swing.CLabel;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

public class VPaymentFormOnCredit extends PaymentFormOnCredit {

	private VPaymentFormDialog dialog;
	
	private CLabel pTermLabel = new CLabel();
	private CComboBox pTermCombo = new CComboBox();

	public VPaymentFormOnCredit(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		dialog = new VPaymentFormDialog(this, windowNo);
		init();
	}
	
	public void init() {
		GridBagLayout pPanelLayout = new GridBagLayout();
		dialog.getPanel().setLayout(pPanelLayout);
		pTermLabel.setText(Msg.translate(Env.getCtx(), "C_PaymentTerm_ID"));
		dialog.getPanel().add(pTermLabel, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 0), 0, 0));
		dialog.getPanel().add(pTermCombo, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
	}
	
	@Override
	public void loadData() {
		ArrayList<KeyNamePair> list = getPaymentTermList();
		for (KeyNamePair pp : list)
			pTermCombo.addItem(pp);
		
		// Set Selection
		if (selectedPaymentTerm != null)
			pTermCombo.setSelectedItem(selectedPaymentTerm);
	}
	
	@Override
	public boolean checkMandatory() {
		return true;
	}

	@Override
	public boolean saveChangesInTrx(String trxName) {
		int newC_PaymentTerm_ID = 0;
		KeyNamePair kp = (KeyNamePair)pTermCombo.getSelectedItem();
		if (kp != null)
			newC_PaymentTerm_ID = kp.getKey();
		
		return save(newC_PaymentTerm_ID);		
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
