package org.compiere.grid;

import org.compiere.model.GridTab;
import org.compiere.model.MInvoice;

public abstract class PaymentFormMixedPOS extends PaymentForm {
	public static final String PAYMENTRULE = MInvoice.PAYMENTRULE_MixedPOSPayment;

	public PaymentFormMixedPOS(int WindowNo, GridTab mTab) {
		super(WindowNo, mTab);
	}
}
