package org.compiere.grid;

import org.compiere.model.GridTab;

public class VPaymentFormMixedPOS extends PaymentFormMixedPOS {
	private VPaymentFormDialog dialog;
	
	public VPaymentFormMixedPOS(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		dialog = new VPaymentFormDialog(this, windowNo);
	}
		
	@Override
	public void loadData() {
	}
	
	@Override
	public boolean checkMandatory() {
		return true;
	}

	@Override
	public boolean saveChangesInTrx(String trxName) {
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
