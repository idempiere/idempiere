package org.compiere.grid;

import org.compiere.model.GridTab;
import org.compiere.model.MInvoice;

public abstract class PaymentFormDirectDebit extends PaymentFormDirectDeposit {	
	public static final String PAYMENTRULE = MInvoice.PAYMENTRULE_DirectDebit;
	
	public PaymentFormDirectDebit(int WindowNo, GridTab mTab) {
		super(WindowNo, mTab);
	}
}
