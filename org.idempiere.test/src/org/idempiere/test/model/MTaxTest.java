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
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.adempiere.base.Core;
import org.compiere.model.MBPartner;
import org.compiere.model.MTax;
import org.compiere.model.Tax;
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
	
	private final static int BP_JOE_BLOCK = 118;
	private static final int PRODUCT_MULCH = 137;
	
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
	
	@Test
	public void testTaxLookup() {
		int taxExemptId = Tax.getExemptTax(Env.getCtx(), getAD_Org_ID(), getTrxName());
		assertTrue(taxExemptId>0, "Fail to get tax exempt Id");
		
		MBPartner bp = new MBPartner(Env.getCtx(), BP_JOE_BLOCK, getTrxName());
		bp.setIsTaxExempt(true);
		bp.saveEx();
		
		int id = Core.getTaxLookup().get(Env.getCtx(), PRODUCT_MULCH, 0, getLoginDate(), getLoginDate(), getAD_Org_ID(), getM_Warehouse_ID(), 
				bp.getPrimaryC_BPartner_Location_ID(), bp.getPrimaryC_BPartner_Location_ID(), true, null, getTrxName());
		assertEquals(taxExemptId, id, "Unexpected tax id");
		
		bp.setIsTaxExempt(false);
		bp.saveEx();
		
		id = Core.getTaxLookup().get(Env.getCtx(), PRODUCT_MULCH, 0, getLoginDate(), getLoginDate(), getAD_Org_ID(), getM_Warehouse_ID(), 
				bp.getPrimaryC_BPartner_Location_ID(), bp.getPrimaryC_BPartner_Location_ID(), true, null, getTrxName());
		assertTrue(id != taxExemptId, "Unexpected tax id: " + id);
		assertEquals(STANDARD_TAX_ID, id, "Unexpected tax id");
	}
}
