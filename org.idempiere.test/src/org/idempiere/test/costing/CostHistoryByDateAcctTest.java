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
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.ICostInfo;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MCostHistory;
import org.compiere.model.MProduct;
import org.compiere.model.ProductCost;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * The cost history record valid at an account date, read through {@link MCost#getCostInfo} and
 * {@link ProductCost#getProductCosts}: the last record on or before the date, else the first record after it with its
 * old values (IDEMPIERE-7190).
 * <p>
 * Two history records of a new product: account date today + 1 (cost 10) and today + 3 (cost 20). Dates are in the
 * future so the lookup runs whatever {@code C_AcctSchema.BackDateDay} is.
 */
@DisplayName("Cost history by account date")
public class CostHistoryByDateAcctTest extends AbstractTestCase {

	private MAcctSchema as;
	private MCostElement ce;
	private MProduct product;
	private Timestamp today;
	private MCostHistory first;
	private MCostHistory second;

	@BeforeEach
	void createHistory() {
		as = MAcctSchema.getClientAcctSchema(Env.getCtx(), getAD_Client_ID())[0];
		product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setValue("IDEMPIERE-7190-" + System.currentTimeMillis());
		product.setName(product.getValue());
		product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.saveEx();
		ce = MCostElement.getMaterialCostElement(product, MCostElement.COSTINGMETHOD_AveragePO);
		assertNotNull(ce, "Average PO material cost element");

		today = TimeUtil.getDay(System.currentTimeMillis());
		first = history(TimeUtil.addDays(today, 1), new BigDecimal("5"), new BigDecimal("10"));
		second = history(TimeUtil.addDays(today, 3), new BigDecimal("10"), new BigDecimal("20"));
	}

	@Test
	@DisplayName("Between the two records: the first one, its new values")
	void betweenRecords() {
		MCostHistory h = lookup(TimeUtil.addDays(today, 2));
		assertEquals(first.getM_CostHistory_ID(), h.getM_CostHistory_ID());
		assertEquals(0, new BigDecimal("10").compareTo(h.getNewCostPrice()));
	}

	@Test
	@DisplayName("On the second record's date and after it: the second one")
	void onAndAfterLastRecord() {
		assertEquals(second.getM_CostHistory_ID(), lookup(TimeUtil.addDays(today, 3)).getM_CostHistory_ID());
		assertEquals(second.getM_CostHistory_ID(), lookup(TimeUtil.addDays(today, 10)).getM_CostHistory_ID());
	}

	@Test
	@DisplayName("Before the first record: the first one, with its old values as the new ones")
	void beforeFirstRecord() {
		MCostHistory h = lookup(today);
		assertEquals(first.getM_CostHistory_ID(), h.getM_CostHistory_ID());
		assertEquals(0, new BigDecimal("4").compareTo(h.getNewCostPrice()), "old cost price of the first record");
		assertEquals(0, new BigDecimal("1").compareTo(h.getNewQty()), "old quantity of the first record");
	}

	@Test
	@DisplayName("An attribute set instance without its own history: the record of ASI 0")
	void attributeSetInstanceFallsBackToZero() {
		int asi = Integer.MAX_VALUE; // the lookup only filters by the id, no instance record is needed
		ICostInfo info = MCost.getCostInfo(Env.getCtx(), getAD_Client_ID(), 0, product.getM_Product_ID(),
				as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getM_CostElement_ID(), asi,
				TimeUtil.addDays(today, 2), null, getTrxName());
		assertEquals(first.getM_CostHistory_ID(), assertInstanceOf(MCostHistory.class, info).getM_CostHistory_ID());
	}

	@Test
	@DisplayName("Another organization has no history: no record, the current cost is used")
	void otherOrganization() {
		ICostInfo info = MCost.getCostInfo(Env.getCtx(), getAD_Client_ID(), DictionaryIDs.AD_Org.HQ.id, product.getM_Product_ID(),
				as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getM_CostElement_ID(), 0,
				TimeUtil.addDays(today, 2), null, getTrxName());
		assertFalse(info instanceof MCostHistory, "no cost history in another organization");
	}

	@Test
	@DisplayName("Without a cost element (posting, ProductCost): the price of the record valid at the account date")
	void productCostWithoutCostElement() {
		currentCost(new BigDecimal("99"));
		assertEquals(0, new BigDecimal("10").compareTo(productCost(TimeUtil.addDays(today, 2))), "between the records");
		assertEquals(0, new BigDecimal("20").compareTo(productCost(TimeUtil.addDays(today, 3))), "on the second record");
	}

	@Test
	@DisplayName("Without a cost element, before the first record: the old price of the first record")
	void productCostWithoutCostElementBeforeFirstRecord() {
		currentCost(new BigDecimal("99"));
		assertEquals(0, new BigDecimal("4").compareTo(productCost(today)));
	}

	/** The current cost of the product (the history price replaces it for an earlier account date) */
	private void currentCost(BigDecimal price) {
		MCost cost = MCost.get(product, 0, as, 0, ce.getM_CostElement_ID(), getTrxName());
		cost.setCurrentCostPrice(price);
		cost.setCurrentQty(BigDecimal.TEN);
		cost.saveEx();
	}

	/** Cost of one unit as posting reads it: MCost.getCost without a cost element, by account date */
	private BigDecimal productCost(Timestamp dateAcct) {
		ProductCost pc = new ProductCost(Env.getCtx(), product.getM_Product_ID(), 0, getTrxName());
		pc.setQty(BigDecimal.ONE);
		return pc.getProductCosts(as, 0, MCostElement.COSTINGMETHOD_AveragePO, 0, true, dateAcct, null, false);
	}

	private MCostHistory lookup(Timestamp dateAcct) {
		ICostInfo info = MCost.getCostInfo(Env.getCtx(), getAD_Client_ID(), 0, product.getM_Product_ID(),
				as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getM_CostElement_ID(), 0, dateAcct, null, getTrxName());
		return assertInstanceOf(MCostHistory.class, info, "cost history for " + dateAcct);
	}

	/** A processed cost detail with one history record: old cost 4 / qty 1, new cost {@code newCost} / qty {@code qty}. */
	private MCostHistory history(Timestamp dateAcct, BigDecimal qty, BigDecimal newCost) {
		MCostDetail cd = new MCostDetail(as, 0, product.getM_Product_ID(), 0, ce.getM_CostElement_ID(),
				newCost.multiply(qty), qty, "IDEMPIERE-7190", dateAcct, 0, getTrxName());
		cd.setProcessed(true);
		cd.saveEx();

		MCostHistory h = new MCostHistory(Env.getCtx(), 0, getTrxName());
		h.setAD_Org_ID(0);
		h.setM_CostDetail_ID(cd.getM_CostDetail_ID());
		h.setM_Product_ID(product.getM_Product_ID());
		h.setM_AttributeSetInstance_ID(0);
		h.setM_CostElement_ID(ce.getM_CostElement_ID());
		h.setM_CostType_ID(as.getM_CostType_ID());
		h.setDateAcct(dateAcct);
		h.setOldCostPrice(new BigDecimal("4"));
		h.setOldQty(BigDecimal.ONE);
		h.setOldCAmt(new BigDecimal("4"));
		h.setOldCQty(BigDecimal.ONE);
		h.setNewCostPrice(newCost);
		h.setNewQty(qty);
		h.setNewCAmt(newCost.multiply(qty));
		h.setNewCQty(qty);
		h.saveEx();
		return h;
	}
}
