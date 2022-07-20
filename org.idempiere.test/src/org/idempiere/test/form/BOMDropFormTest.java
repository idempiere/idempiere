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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProject;
import org.compiere.model.MProjectLine;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.apps.form.BOMDrop;
import org.idempiere.apps.form.BOMDrop.SelectedItem;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class BOMDropFormTest extends AbstractTestCase {

	public BOMDropFormTest() {
	}

	@Test
	public void testDropToOrder() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		order.setBPartner(bp);
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.saveEx();
		
		BOMDrop bomDrop = new BOMDrop();
		KeyNamePair[] orders = bomDrop.getDraftOrders(getTrxName());
		boolean found = false;
		for (KeyNamePair knp : orders)  {
			if (knp.getKey() == order.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Failed to retrieve open draft order");
		
		MProduct product = MProduct.get(DictionaryIDs.M_Product.P_CHAIR.id);
		MPPProductBOMLine[] bomLines = bomDrop.getBOMLine(product);
		assertTrue(bomLines.length > 0, "Failed to retrieve BOM lines for " + product.toString());
		
		List<SelectedItem> selectedItems = new ArrayList<>();
		List<String> selectedParent = new ArrayList<>();
		Map<Integer, Integer> variantMap = new HashMap<>();
		bomDrop.addBOMLines(product, new BigDecimal("1"), b -> {
			MProduct component = b.getProductBOMLine().getProduct();
			if (MPPProductBOMLine.COMPONENTTYPE_Variant.equals(b.getBOMType())) {
				if (variantMap.containsKey(b.getBOMLevel()))
					return;
				else
					variantMap.put(b.getBOMLevel(), component.get_ID());
			} else if (variantMap.containsKey(b.getBOMLevel())) {
				variantMap.remove(b.getBOMLevel());
			}
			
			if (b.getBOMLevel() > 0) {
				String key = b.getParentProduct().get_ID() + "_" + (b.getBOMLevel()-1);
				if (!selectedParent.contains(key))
					return;
			}
			
			if (component.isBOM() && component.isVerified()) {
				String key = component.get_ID()+"_"+b.getBOMLevel();
				selectedParent.add(key);
				return;
			}
			SelectedItem si = new SelectedItem(component.get_ID(), b.getLineQty());
			selectedItems.add(si);
		});
		
		assertEquals(8, selectedItems.size(), "Unexpected number of components");
		
		int priceListId = order.getM_PriceList_ID();
		MPriceListVersion priceListVersion = MPriceList.get(priceListId).getPriceListVersion(null);
		for(SelectedItem selectedItem : selectedItems) {
			MProductPrice pp = MProductPrice.get(Env.getCtx(), priceListVersion.get_ID(), selectedItem.getM_Product_ID(), getTrxName());
			if (pp == null) {
				pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
				pp.setM_PriceList_Version_ID(priceListVersion.get_ID());
				pp.setM_Product_ID(selectedItem.getM_Product_ID());
				pp.setPrices(new BigDecimal("1"), new BigDecimal("1"), BigDecimal.ZERO);
				pp.saveEx();
			}
		}
		bomDrop.saveOrderLines(order.getC_Order_ID(), selectedItems, getTrxName());
		
		order.load(getTrxName());
		MOrderLine[] orderLines = order.getLines(true, null);
		assertEquals(selectedItems.size(), orderLines.length, "Unexpected number of order lines");
	}
	
	@Test
	public void testDropToInvoice() {
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		invoice.setBPartner(bp);
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.saveEx();
		
		BOMDrop bomDrop = new BOMDrop();
		KeyNamePair[] invoices = bomDrop.getDraftInvoices(getTrxName());
		boolean found = false;
		for (KeyNamePair knp : invoices)  {
			if (knp.getKey() == invoice.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Failed to retrieve open draft invoice");
		
		MProduct product = MProduct.get(DictionaryIDs.M_Product.P_CHAIR.id);
		MPPProductBOMLine[] bomLines = bomDrop.getBOMLine(product);
		assertTrue(bomLines.length > 0, "Failed to retrieve BOM lines for " + product.toString());
		
		List<SelectedItem> selectedItems = new ArrayList<>();
		List<String> selectedParent = new ArrayList<>();
		Map<Integer, Integer> variantMap = new HashMap<>();
		bomDrop.addBOMLines(product, new BigDecimal("1"), b -> {
			MProduct component = b.getProductBOMLine().getProduct();
			if (MPPProductBOMLine.COMPONENTTYPE_Variant.equals(b.getBOMType())) {
				if (variantMap.containsKey(b.getBOMLevel()))
					return;
				else
					variantMap.put(b.getBOMLevel(), component.get_ID());
			} else if (variantMap.containsKey(b.getBOMLevel())) {
				variantMap.remove(b.getBOMLevel());
			}
			
			if (b.getBOMLevel() > 0) {
				String key = b.getParentProduct().get_ID() + "_" + (b.getBOMLevel()-1);
				if (!selectedParent.contains(key))
					return;
			}
			
			if (component.isBOM() && component.isVerified()) {
				String key = component.get_ID()+"_"+b.getBOMLevel();
				selectedParent.add(key);
				return;
			}
			SelectedItem si = new SelectedItem(component.get_ID(), b.getLineQty());
			selectedItems.add(si);
		});
		
		assertEquals(8, selectedItems.size(), "Unexpected number of components");
		
		bomDrop.saveInvoiceLines(invoice.get_ID(), selectedItems, getTrxName());
		
		invoice.load(getTrxName());
		MInvoiceLine[] invoiceLines = invoice.getLines(true);
		assertEquals(selectedItems.size(), invoiceLines.length, "Unexpected number of invoice lines");
	}
	
	@Test
	public void testDropToProject() {
		MProject project = new MProject(Env.getCtx(), 0, getTrxName());
		MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
		project.setC_BPartner_ID(bp.get_ID());
		project.setName("testDropToProject");
		project.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		project.saveEx();
		
		BOMDrop bomDrop = new BOMDrop();
		KeyNamePair[] projects = bomDrop.getNonServiceProjects(getTrxName());
		boolean found = false;
		for (KeyNamePair knp : projects)  {
			if (knp.getKey() == project.get_ID()) {
				found = true;
				break;
			}
		}
		assertTrue(found, "Failed to retrieve open non service project");
		
		MProduct product = MProduct.get(DictionaryIDs.M_Product.P_CHAIR.id);
		MPPProductBOMLine[] bomLines = bomDrop.getBOMLine(product);
		assertTrue(bomLines.length > 0, "Failed to retrieve BOM lines for " + product.toString());
		
		List<SelectedItem> selectedItems = new ArrayList<>();
		List<String> selectedParent = new ArrayList<>();
		Map<Integer, Integer> variantMap = new HashMap<>();
		bomDrop.addBOMLines(product, new BigDecimal("1"), b -> {
			MProduct component = b.getProductBOMLine().getProduct();
			if (MPPProductBOMLine.COMPONENTTYPE_Variant.equals(b.getBOMType())) {
				if (variantMap.containsKey(b.getBOMLevel()))
					return;
				else
					variantMap.put(b.getBOMLevel(), component.get_ID());
			} else if (variantMap.containsKey(b.getBOMLevel())) {
				variantMap.remove(b.getBOMLevel());
			}
			
			if (b.getBOMLevel() > 0) {
				String key = b.getParentProduct().get_ID() + "_" + (b.getBOMLevel()-1);
				if (!selectedParent.contains(key))
					return;
			}
			
			if (component.isBOM() && component.isVerified()) {
				String key = component.get_ID()+"_"+b.getBOMLevel();
				selectedParent.add(key);
				return;
			}
			SelectedItem si = new SelectedItem(component.get_ID(), b.getLineQty());
			selectedItems.add(si);
		});
		
		assertEquals(8, selectedItems.size(), "Unexpected number of components");
		
		bomDrop.saveProjectLines(project.get_ID(), selectedItems, getTrxName());
		
		project.load(getTrxName());
		MProjectLine[] projectLines = project.getLines();
		assertEquals(selectedItems.size(), projectLines.length, "Unexpected number of project lines");
	}
}
