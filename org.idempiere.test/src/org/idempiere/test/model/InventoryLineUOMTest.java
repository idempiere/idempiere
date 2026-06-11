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
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.util.Properties;

import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MProduct;
import org.compiere.model.MUOMConversion;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
import org.compiere.process.ProcessInfo;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Tests for MInventoryLine C_UOM_ID and QtyEntered support.
 *
 * Scenarios covered:
 * 1. Physical Inventory - product UOM (no conversion): QtyEntered → QtyCount
 * 2. Physical Inventory - alternate UOM (SIX_PACK): QtyEntered → QtyCount converted
 * 3. Internal Use Inventory - product UOM: QtyEntered → QtyInternalUse
 * 4. Backward compat (Physical): QtyCount set directly, QtyEntered back-filled
 * 5. Backward compat (Internal Use): QtyInternalUse set directly, QtyEntered back-filled
 * 6. Detail constructor: C_UOM_ID and QtyEntered set from product UOM
 * 7. End-to-end: Physical Inventory with QtyEntered completes successfully
 */
@Isolated
public class InventoryLineUOMTest extends AbstractTestCase {

	public InventoryLineUOMTest() {
	}

	@Test
	public void testPhysicalInventory_QtyEntered_ProductUOM() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.ELM.id);
		int productUOM = product.getC_UOM_ID();

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();

		MInventoryLine line = new MInventoryLine(ctx, 0, trxName);
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.setM_Product_ID(DictionaryIDs.M_Product.ELM.id);
		line.setC_UOM_ID(productUOM);
		line.setQtyBook(Env.ZERO);
		line.setQtyEntered(new BigDecimal("10"));
		line.saveEx();

		assertEquals(productUOM, line.getC_UOM_ID(), "C_UOM_ID should be product UOM");
		assertEquals(0, new BigDecimal("10").compareTo(line.getQtyEntered()), "QtyEntered should be 10");
		// No conversion: QtyCount == QtyEntered
		assertEquals(0, new BigDecimal("10").compareTo(line.getQtyCount()),
				"QtyCount should equal QtyEntered when UOM = product UOM");
	}

	@Test
	public void testPhysicalInventory_QtyEntered_AlternateUOM() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();

		//Product with Different UOMs
		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.ELM.id);
		
		// Enter 2 six-packs → expect QtyCount = 12 each
		MInventoryLine line = new MInventoryLine(ctx, 0, trxName);
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.setM_Product_ID(product.get_ID());
		line.setC_UOM_ID(DictionaryIDs.C_UOM.SIX_PACK.id);
		line.setQtyBook(Env.ZERO);
		line.setQtyEntered(new BigDecimal("2"));
		line.saveEx();

		assertEquals(DictionaryIDs.C_UOM.SIX_PACK.id, line.getC_UOM_ID(), "C_UOM_ID should be SIX_PACK");
		assertEquals(0, new BigDecimal("2").compareTo(line.getQtyEntered()), "QtyEntered should be 2");

		BigDecimal expectedQtyCount = MUOMConversion.convertProductFrom(ctx, product.get_ID(),
				DictionaryIDs.C_UOM.SIX_PACK.id, new BigDecimal("2"));
		assertNotNull(expectedQtyCount, "UOM conversion should exist");
		assertEquals(0, expectedQtyCount.compareTo(line.getQtyCount()),
				"QtyCount should be the converted quantity (2 six-packs = 12 each)");
	}

	@Test
	public void testInternalUseInventory_QtyEntered_ProductUOM() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.MULCH.id);
		int productUOM = product.getC_UOM_ID();

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
		inventory.saveEx();

		MInventoryLine line = new MInventoryLine(ctx, 0, trxName);
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setC_UOM_ID(productUOM);
		line.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		line.setQtyEntered(new BigDecimal("5"));
		line.saveEx();

		assertEquals(productUOM, line.getC_UOM_ID(), "C_UOM_ID should be product UOM");
		assertEquals(0, new BigDecimal("5").compareTo(line.getQtyEntered()), "QtyEntered should be 5");
		assertEquals(0, new BigDecimal("5").compareTo(line.getQtyInternalUse()),
				"QtyInternalUse should equal QtyEntered when UOM = product UOM");
	}

	@Test
	public void testBackwardCompatibility_Physical_QtyCountDirectlySet() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.MULCH.id);

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();

		// Legacy / REST API style: only QtyCount set, QtyEntered and C_UOM_ID not touched
		MInventoryLine line = new MInventoryLine(ctx, 0, trxName);
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setQtyBook(Env.ZERO);
		line.setQtyCount(new BigDecimal("20"));
		// QtyEntered intentionally NOT set
		line.saveEx();

		// C_UOM_ID must default to product UOM
		assertEquals(product.getC_UOM_ID(), line.getC_UOM_ID(),
				"C_UOM_ID should be defaulted to product UOM for legacy callers");
		// QtyEntered must be back-filled
		System.out.println("QtyEntered: " + line.getQtyEntered());
		System.out.println("QtyCount: " + line.getQtyCount());
		assertEquals(0, new BigDecimal("20").compareTo(line.getQtyEntered()),
				"QtyEntered should be back-filled from QtyCount for legacy callers");
		// QtyCount unchanged
		assertEquals(0, new BigDecimal("20").compareTo(line.getQtyCount()),
				"QtyCount should remain as set");
	}

	@Test
	public void testBackwardCompatibility_InternalUse_QtyInternalUseDirectlySet() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.MULCH.id);

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.INTERNAL_USE_INVENTORY.id);
		inventory.saveEx();

		// Legacy / REST API style
		MInventoryLine line = new MInventoryLine(ctx, 0, trxName);
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
		line.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		line.setQtyInternalUse(new BigDecimal("7"));
		// QtyEntered intentionally NOT set
		line.saveEx();

		assertEquals(product.getC_UOM_ID(), line.getC_UOM_ID(),
				"C_UOM_ID should be defaulted to product UOM for legacy callers");
		assertEquals(0, new BigDecimal("7").compareTo(line.getQtyEntered()),
				"QtyEntered should be back-filled from QtyInternalUse");
		assertEquals(0, new BigDecimal("7").compareTo(line.getQtyInternalUse()),
				"QtyInternalUse should remain as set");
	}

	@Test
	public void testDetailConstructor_SetsUOMAndQtyEntered() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.MULCH.id);

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();

		MInventoryLine line = new MInventoryLine(inventory,
				DictionaryIDs.M_Locator.HQ.id,
				DictionaryIDs.M_Product.MULCH.id,
				0,
				Env.ZERO,              // QtyBook
				new BigDecimal("15")); // QtyCount
		line.saveEx();

		assertEquals(product.getC_UOM_ID(), line.getC_UOM_ID(),
				"Detail constructor should set C_UOM_ID from product");
		assertEquals(0, new BigDecimal("15").compareTo(line.getQtyEntered()),
				"Detail constructor should set QtyEntered = QtyCount");
	}

	@Test
	public void testPhysicalInventory_WithQtyEntered_CompletesSuccessfully() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MInventory inventory = new MInventory(ctx, 0, trxName);
		inventory.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
		inventory.setC_DocType_ID(DictionaryIDs.C_DocType.MATERIAL_PHYSICAL_INVENTORY.id);
		inventory.saveEx();

		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.ELM.id);

		MInventoryLine line = new MInventoryLine(ctx, 0, trxName);
		line.setM_Inventory_ID(inventory.get_ID());
		line.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		line.setM_Product_ID(product.get_ID());
		line.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		line.setQtyBook(Env.ZERO);
		line.setQtyEntered(new BigDecimal("50"));
		line.saveEx();

		assertNotEquals(0, line.getLine(), "Line no should be set after save");
		assertEquals(0, new BigDecimal("50").compareTo(line.getQtyCount()),
				"QtyCount should be derived from QtyEntered");

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(inventory, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		inventory.load(trxName);
		assertEquals(DocAction.STATUS_Completed, inventory.getDocStatus());
	}
}
