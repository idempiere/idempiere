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

import org.compiere.model.GridTab;

/**
 * 
 * @author Elaine
 *
 */
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
