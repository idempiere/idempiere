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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.compiere.model.MTax;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MTaxTest extends AbstractTestCase {

	private static final int STANDARD_TAX_ID = 104;
	private static final int STANDARD_TAX_CATEGORY_ID=107;
	
	public MTaxTest() {
	}

	@Test
	public void testClearParentTaxId() {
		MTax tax = new MTax(Env.getCtx(), 0, getTrxName());
		tax.setName("testClearParentTaxId");
		tax.setParent_Tax_ID(STANDARD_TAX_ID);
		tax.setValidFrom(TimeUtil.getDay(null));
		tax.setIsSummary(false);
		tax.setC_TaxCategory_ID(STANDARD_TAX_CATEGORY_ID);
		tax.saveEx();		
		assertEquals(STANDARD_TAX_ID, tax.getParent_Tax_ID(), "Unexpected parent tax id");
		
		tax.setIsSummary(true);
		tax.saveEx();
		assertEquals(0, tax.getParent_Tax_ID(), "Unexpected parent tax id");
	}
}
