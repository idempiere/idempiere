/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.form;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Vector;

import org.compiere.apps.form.Charge;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.ui.MiniTableImpl;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class ChargeFormTest extends AbstractTestCase {

	/**
	 * 
	 */
	public ChargeFormTest() {
	}

	@Test
	public void testCreateNewAccontAndCharge() {
		Charge charge = new Charge();
		charge.setTrxName(getTrxName());
		
		String value = "testCreateNewAccontAndCharge";
		String name = "testCreateNewAccontAndCharge";
		
		int elementValueId = charge.createElementValue(value, name, true);
		assertTrue(elementValueId > 0, "Failed to create new account element record");
		int chargeId = charge.createCharge(name, elementValueId);
		assertTrue(chargeId > 0, "Failed to creaet new Charge record");
	}
	
	@Test
	public void testCreateChargeFromAccount() {
		Charge charge = new Charge();
		charge.setTrxName(getTrxName());
		
		//load data
		MiniTableImpl minitable = new MiniTableImpl();
		Vector<String> columns = charge.getColumnNames();
		for (String column : columns) {
			minitable.addColumn(column);
		}
		charge.setColumnClass(minitable);
		//Boolean[Select],KeyNamePair[C_ElementValue_ID,Value],Name,Boolean[IsExpense]
		Vector<Vector<Object>> accounts = charge.getData();
		assertTrue(accounts.size() > 0, "Failed to retrieve account element records");
		for(int i = 0; i < accounts.size(); i++) {
			minitable.setRowCount(i+1);
			Vector<Object> account = accounts.get(i);
			for(int j = 0; j < account.size(); j++)
				minitable.setValueAt(account.get(j), i, j);
		}		
		assertEquals(accounts.size(), minitable.getRowCount(), "Error populating mini table");
		
		//test with no selection
		charge.createAccount(minitable);
		String created = charge.getCreatedAccountNames();
		assertTrue(created == null || created.length() == 0, "Unexpected create of charge record");
		
		//test create with selection of first and second account element
		minitable.setValueAt(Boolean.TRUE, 0, Charge.EColumn.SELECT.index());
		minitable.setValueAt(Boolean.TRUE, 1, Charge.EColumn.SELECT.index());
		//create charge from selected account element
		charge.createAccount(minitable);
		created = charge.getCreatedAccountNames();
		assertTrue(created != null && created.length() > 0, "Failed to create Charge record from Account Element ");
		String[] splited = created.split("[,]");
		assertEquals(2, splited.length, "Unexpected number of charge records created");
		
		//should auto de-select
		assertFalse((Boolean)minitable.getValueAt(0, Charge.EColumn.SELECT.index()), "Selection of first row not reset after create");
		assertFalse((Boolean)minitable.getValueAt(1, Charge.EColumn.SELECT.index()), "Selection of second row not reset after create");
	}
}
