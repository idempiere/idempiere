/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 SC ARHIPAC SERVICE SRL. All Rights Reserved.            *
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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;

import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Test for the getBOM SQL function classes
 */
@Isolated
public class GetBOMFunctionsTest extends AbstractTestCase
{
	private static final int PRODUCT_PRICE_PATIOSET_STANDARD_2003 = 200084;

	@Test
	public void test_getBOMFunctions() throws Exception
	{
		BigDecimal price;
		String trxName = getTrxName();

		// Prices of PatioSet in Standard 2003 Price List Version

		price = DB.getSQLValueBDEx(trxName, "SELECT bompricestd(145, 104) FROM Dual");
		assertTrue(BigDecimal.valueOf(500.0).compareTo(price) == 0, "Unexpected direct bompricestd");
		
		price = DB.getSQLValueBDEx(trxName, "SELECT bompricelist(145, 104) FROM Dual");
		assertTrue(BigDecimal.valueOf(520.0).compareTo(price) == 0, "Unexpected direct bompricelist");

		price = DB.getSQLValueBDEx(trxName, "SELECT bompricelimit(145, 104) FROM Dual");
		assertTrue(BigDecimal.valueOf(496.0).compareTo(price) == 0, "Unexpected direct bompricelimit");

		MProductPrice productPrice = new MProductPrice(Env.getCtx(), PRODUCT_PRICE_PATIOSET_STANDARD_2003, trxName);
		productPrice.setIsActive(false);
		productPrice.saveEx();

		price = DB.getSQLValueBDEx(trxName, "SELECT bompricestd(145, 104) FROM Dual");
		assertTrue(BigDecimal.valueOf(225.0).compareTo(price) == 0, "Unexpected indirect bompricestd");

		price = DB.getSQLValueBDEx(trxName, "SELECT bompricelist(145, 104) FROM Dual");
		assertTrue(BigDecimal.valueOf(220.0).compareTo(price) == 0, "Unexpected indirect bompricelist");

		price = DB.getSQLValueBDEx(trxName, "SELECT bompricelimit(145, 104) FROM Dual");
		assertTrue(BigDecimal.valueOf(180.0).compareTo(price) == 0, "Unexpected indirect bompricelimit");

		// Quantities of PatioSet in Standard 2003 Price List Version

		BigDecimal qty;
		qty = DB.getSQLValueBDEx(trxName, "SELECT bomqtyavailable(145, 103, 0) FROM Dual");
		assertTrue(BigDecimal.valueOf(0.0).compareTo(qty) == 0, "Unexpected direct bomqtyavailable");

		qty = DB.getSQLValueBDEx(trxName, "SELECT bomqtyonhand(145, 103, 0) FROM Dual");
		assertTrue(BigDecimal.valueOf(0.0).compareTo(qty) == 0, "Unexpected direct bomqtyonhand");

		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.PATIOSET.id, trxName);
		product.setIsStocked(false);
		product.saveEx();

		qty = DB.getSQLValueBDEx(trxName, "SELECT bomqtyavailable(145, 103, 0) FROM Dual");
		assertTrue(BigDecimal.valueOf(12.0).compareTo(qty) == 0, "Unexpected indirect bomqtyavailable");

		qty = DB.getSQLValueBDEx(trxName, "SELECT bomqtyonhand(145, 103, 0) FROM Dual");
		assertTrue(BigDecimal.valueOf(12.0).compareTo(qty) == 0, "Unexpected indirect bomqtyonhand");

	}

}
