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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.compiere.apps.form.AttributeGrid;
import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeValue;
import org.compiere.model.MBPartner;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class AttributeGridFormTest extends AbstractTestCase {

	public AttributeGridFormTest() {
	}

	@Test
	public void testForm() {
		AttributeGrid attributeGrid = new AttributeGrid();
		List<KeyNamePair> priceLists = new ArrayList<>();
		List<KeyNamePair> warehouses = new ArrayList<>();
		attributeGrid.fillPriceListAndWarehouse(priceLists, warehouses);
		assertTrue(priceLists.stream().anyMatch(knp -> knp.getKey() >0), "Failed to retrieve price list records");
		assertTrue(warehouses.stream().anyMatch(knp -> knp.getKey() >0), "Failed to retrieve warehouse records");
		
		MAttributeValue large = new MAttributeValue(Env.getCtx(), DictionaryIDs.M_AttributeValue.LARGE.id, getTrxName());
		assertTrue(attributeGrid.hasProduct(large, null, null), "Failed to locate product with Size=Large");
		MAttributeValue green = new MAttributeValue(Env.getCtx(), DictionaryIDs.M_AttributeValue.GREEN.id, getTrxName());
		assertTrue(attributeGrid.hasProduct(large, green, null), "Failed to locate product with Size=Large and Color=Green");
		
		List<MProduct> list = new ArrayList<>();
		attributeGrid.travelProducts(large, green, null, e -> {
			list.add(e);
		});
		assertTrue(list.size() > 0, "Failed to retrieve products with Size=Large and Color=Green");
		
		MAttribute size = MAttribute.get(Env.getCtx(), DictionaryIDs.M_Attribute.SIZE.id);
		MAttributeValue[] values = size.getMAttributeValues();
		List<MAttributeValue> outputList = new ArrayList<>();
		attributeGrid.filterAttributeValues(values, DictionaryIDs.M_Attribute.SIZE.id, DictionaryIDs.M_Attribute.COLOR.id, null, outputList);
		assertTrue(outputList.size() > 0, "Unexpected output attribute list size");
		
		outputList = new ArrayList<>();
		attributeGrid.filterAttributeValues(values, DictionaryIDs.M_Attribute.SIZE.id, DictionaryIDs.M_Attribute.COLOR.id, large, outputList);
		assertTrue(outputList.size() == 1, "Unexpected filtered output attribute list size");
	}
	
	@Test
	public void testSaveOrderLines() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();
		
		Map<Integer, BigDecimal> productInputMap = new HashMap<>();
		Map<Integer, Integer> productOrderLineMap = new HashMap<>();
		AttributeGrid attributeGrid = new AttributeGrid();
		MAttributeValue large = new MAttributeValue(Env.getCtx(), DictionaryIDs.M_AttributeValue.LARGE.id, getTrxName());
		MAttributeValue green = new MAttributeValue(Env.getCtx(), DictionaryIDs.M_AttributeValue.GREEN.id, getTrxName());
		attributeGrid.travelProducts(large, green, null, e -> {
			productInputMap.put(e.get_ID(), new BigDecimal("1"));
		});
		assertTrue(productInputMap.size() > 0, "Failed to retrieve products with Size=Large and Color=Green");
		int created = attributeGrid.saveOrderLines(order.get_ID(), productInputMap, productOrderLineMap, getTrxName());
		assertTrue(created > 0, "Failed to create new order lines");
		order.load(getTrxName());
		MOrderLine[] lines = order.getLines();
		assertEquals(created, lines.length, "Unexpected number of order lines retrieve from DB");
		
		int orderLineId = attributeGrid.getC_OrderLine_ID(order.get_ID(), productInputMap.keySet().iterator().next(), getTrxName());
		assertTrue(orderLineId > 0, "Failed to retrieve order line id");
		BigDecimal qtyEntered = attributeGrid.getQtyEnter(orderLineId, getTrxName());
		assertTrue(qtyEntered != null && qtyEntered.intValue() == 1, "Unexpected quantity entered value");
	}
}
