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

import java.util.ArrayList;

import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.compiere.grid.PaymentFormOnCredit;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 * 
 * @author Elaine
 *
 */
public class WPaymentFormOnCredit extends PaymentFormOnCredit {

	private WPaymentFormWindow window;
		
	private Label pTermLabel = new Label();
	private Listbox pTermCombo = ListboxFactory.newDropdownListbox();
		
	public WPaymentFormOnCredit(int windowNo, GridTab mTab) {
		super(windowNo, mTab);
		window = new WPaymentFormWindow(this, windowNo);
		init();
	}
	
	public void init() {
		Grid pPanelLayout = GridFactory.newGridLayout();
		window.getPanel().appendChild(pPanelLayout);
		pTermLabel.setText(Msg.translate(Env.getCtx(), "C_PaymentTerm_ID"));
		window.getPanel().setId("pPanel");
		
		Columns columns = new Columns();
		pPanelLayout.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		column.setWidth("40%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("60%");
		
		Rows rows = pPanelLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(pTermLabel.rightAlign());
		row.appendChild(pTermCombo);		
	}

	@Override
	public void loadData() {
		super.loadData();
		
		ArrayList<KeyNamePair> list = getPaymentTermList();
		for (KeyNamePair pp : list)
			pTermCombo.addItem(pp);
		
		// Set Selection
		if (selectedPaymentTerm != null)
			pTermCombo.setSelectedKeyNamePair(selectedPaymentTerm);
	}
	
	@Override
	public boolean checkMandatory() {
		return true;
	}
	
	@Override
	public boolean saveChangesInTrx(final String trxName) {
		int newC_PaymentTerm_ID = 0;
		ListItem selected = pTermCombo.getSelectedItem(); 
		KeyNamePair kp = selected != null ? selected.toKeyNamePair() : null;
		if (kp != null)
			newC_PaymentTerm_ID = kp.getKey();
		
		return save(newC_PaymentTerm_ID);
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
