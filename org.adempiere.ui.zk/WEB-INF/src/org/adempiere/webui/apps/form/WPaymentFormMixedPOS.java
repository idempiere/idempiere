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

import org.compiere.grid.PaymentFormMixedPOS;
import org.compiere.model.GridTab;
import org.compiere.model.X_C_Order;

/**
 * Form for mixed POS payment rule ({@link X_C_Order#PAYMENTRULE_MixedPOSPayment}).<br/>
 * As it is, this is a dummy implementation that doesn't do anything.
 * @author Elaine
 *
 */
public class WPaymentFormMixedPOS extends PaymentFormMixedPOS {
	/** Payment form window instance */
	private WPaymentFormWindow window;
	
	/**
	 * @param windowNo
	 * @param mTab
	 */
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
	
	@Override
	protected void afterSave(boolean success) {		
	}
}
