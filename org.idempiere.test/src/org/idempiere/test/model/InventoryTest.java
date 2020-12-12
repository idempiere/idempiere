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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.util.Properties;

import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MProduct;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Carlos Ruiz - globalqss
 */
public class InventoryTest extends AbstractTestCase {

	public InventoryTest() {
	}

	private static final int PRODCAT_BUSHES = 107;
	private static final int TAXCAT_STANDARD = 107;
	private static final int UOM_EACH = 100;
	private static final int WAREHOUSE_HQ = 103;
	private static final int LOCATOR_HQ = 101;
	private static final int DOCTYPE_PHYSICAL_INV = 144;

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4596
	 */
	@Test
	public void testCreateAProductAndInventory() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = new MProduct(ctx, 0, trxName);
		product.setM_Product_Category_ID(PRODCAT_BUSHES);
		product.setName("Test 4596");
		product.setValue("T4596");
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(UOM_EACH);
		product.setC_TaxCategory_ID(TAXCAT_STANDARD);
		product.saveEx();

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(WAREHOUSE_HQ);
		inventory.setC_DocType_ID(DOCTYPE_PHYSICAL_INV);
		inventory.saveEx();

		MInventoryLine iline = new MInventoryLine(inventory,
				LOCATOR_HQ, 
				product.getM_Product_ID(),
				0, // M_AttributeSetInstance_ID
				Env.ZERO, // QtyBook
				Env.ONEHUNDRED);
		iline.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		assertFalse(info.isError());
		inventory.load(trxName);
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
	}

}
