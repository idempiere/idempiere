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

import org.compiere.grid.IPaymentForm;
import org.compiere.grid.IPaymentFormFactory;
import org.compiere.model.GridTab;
import org.compiere.model.MInvoice;

/**
 * 
 * @author Elaine
 *
 */
public class DefaultPaymentFormFactory implements IPaymentFormFactory {

	public IPaymentForm create(int windowNo, GridTab mTab, String paymentRule)
	{
		if (paymentRule.equals(MInvoice.PAYMENTRULE_Cash))
			return new WPaymentFormCash(windowNo, mTab);
		else if (paymentRule.equals(MInvoice.PAYMENTRULE_Check))
			return new WPaymentFormCheck(windowNo, mTab);
		else if (paymentRule.equals(MInvoice.PAYMENTRULE_CreditCard))
			return new WPaymentFormCreditCard(windowNo, mTab);
		else if (paymentRule.equals(MInvoice.PAYMENTRULE_DirectDebit))
			return new WPaymentFormDirectDebit(windowNo, mTab);
		else if (paymentRule.equals(MInvoice.PAYMENTRULE_DirectDeposit))
			return new WPaymentFormDirectDeposit(windowNo, mTab);
		else if (paymentRule.equals(MInvoice.PAYMENTRULE_MixedPOSPayment))
			return new WPaymentFormMixedPOS(windowNo, mTab);
		else if (paymentRule.equals(MInvoice.PAYMENTRULE_OnCredit))
			return new WPaymentFormOnCredit(windowNo, mTab);
		return null;
	}
}