package org.adempiere.webui.apps.form;

import org.compiere.grid.PaymentFormMixedPOS;
import org.compiere.model.GridTab;

public class WPaymentFormMixedPOS extends PaymentFormMixedPOS {

	private WPaymentFormWindow window;
	
	public WPaymentFormMixedPOS(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		window = new WPaymentFormWindow(this, windowNo);
	}

	@Override
	public void loadData() {
	}

	@Override
	public boolean checkMandatory() {
		return true;
	}

	@Override
	public boolean saveChangesInTrx(final String trxName) {
		return true;
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
