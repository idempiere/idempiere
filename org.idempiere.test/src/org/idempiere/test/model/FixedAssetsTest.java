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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAsset;
import org.compiere.model.MAssetAddition;
import org.compiere.model.MAssetGroup;
import org.compiere.model.MAssetGroupAcct;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MWarehouse;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class FixedAssetsTest extends AbstractTestCase {

	public FixedAssetsTest() {
	}

	/**
	 * IDEMPIERE-3763 - create one fixed asset per matched UOM.
	 */
	@Test
	public void testCreateOneAssetPerMatchedUOM() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		BigDecimal qty = new BigDecimal("3");
		BigDecimal unitPrice = new BigDecimal("100");
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

		MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.ASSET_VEHICLE.id);
		MAssetGroup assetGroup = new MAssetGroup(ctx, product.getA_Asset_Group_ID(), trxName);
		assetGroup.setIsOneAssetPerUOM(true);
		assetGroup.saveEx();

		MPriceListVersion priceListVersion = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id)
				.getPriceListVersion(today);
		MProductPrice productPrice = new MProductPrice(ctx, 0, trxName);
		productPrice.setM_PriceList_Version_ID(priceListVersion.get_ID());
		productPrice.setM_Product_ID(product.get_ID());
		productPrice.setPrices(unitPrice, unitPrice, unitPrice);
		productPrice.saveEx();

		MOrder order = new MOrder(ctx, 0, trxName);
		order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		order.saveEx();

		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(product);
		orderLine.setQty(qty);
		orderLine.setPrice(unitPrice);
		orderLine.setDatePromised(today);
		orderLine.saveEx();

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, today);
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, 0, qty);
		receiptLine.setQty(qty);
		receiptLine.setM_Locator_ID(MWarehouse.get(ctx, receipt.getM_Warehouse_ID()).getDefaultLocator().get_ID());
		receiptLine.saveEx();

		MInvoice invoice = new MInvoice(receipt, today);
		invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AP_INVOICE.id);
		invoice.setC_ConversionType_ID(DictionaryIDs.C_ConversionType.SPOT.id);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();

		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setM_InOutLine_ID(receiptLine.get_ID());
		invoiceLine.setLine(10);
		invoiceLine.setProduct(product);
		invoiceLine.setQty(qty);
		invoiceLine.setPrice(unitPrice);
		invoiceLine.setA_CapvsExp(MAssetAddition.A_CAPVSEXP_Capital);
		invoiceLine.setA_CreateAsset(true);
		invoiceLine.saveEx();

		MMatchInv match = new MMatchInv(invoiceLine, today, qty);
		match.saveEx();

		MMatchInv[] matches = MMatchInv.getInvoiceLine(ctx, invoiceLine.get_ID(), trxName);
		assertEquals(1, matches.length);
		List<MAssetAddition> additions = MAssetAddition.createAssetAdditions(matches[0]);
		assertEquals(3, additions.size());
		assertEquals(3, new HashSet<>(additions.stream().map(MAssetAddition::getA_Asset_ID).toList()).size());
		assertTrue(additions.stream().allMatch(addition -> Env.ONE.compareTo(addition.getA_QTY_Current()) == 0));
		assertEquals(0, invoiceLine.getLineNetAmt().compareTo(
				additions.stream().map(MAssetAddition::getAssetSourceAmt).reduce(Env.ZERO, BigDecimal::add)));

		List<MAssetAddition> repeated = MAssetAddition.createAssetAdditions(matches[0]);
		assertEquals(additions.stream().map(MAssetAddition::get_ID).toList(),
				repeated.stream().map(MAssetAddition::get_ID).toList());

		List<MAssetAddition> persisted = new Query(ctx, MAssetAddition.Table_Name,
				MAssetAddition.COLUMNNAME_M_MatchInv_ID + "=?", trxName)
				.setParameters(matches[0].get_ID())
				.list();
		assertEquals(3, persisted.size());
	}

	/**
	 * IDEMPIERE-5474 - depreciation on 18 months
	 */
	@Test
	public void test18MonthsDepreciation() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		MAssetGroupAcct aga = new MAssetGroupAcct(ctx, DictionaryIDs.A_Asset_Group_Acct.EQUIPMENT_DOLLAR.id, trxName);
		aga.setUseLifeMonths(18);
		aga.setUseLifeYears(Env.ZERO);
		aga.setUseLifeMonths_F(18);
		aga.setUseLifeYears_F(Env.ZERO);
		aga.saveEx();
		aga.load(trxName);
		assertTrue( ( new BigDecimal("1.5").compareTo(aga.getUseLifeYears()) == 0 ) );
		assertTrue( ( new BigDecimal("1.5").compareTo(aga.getUseLifeYears_F()) == 0 ) );

		MAsset a = new MAsset(ctx, 0, trxName);
		a.setValue("test_18_m");
		a.setName("test_18_m");
		a.setA_Asset_Group_ID(DictionaryIDs.A_Asset_Group.EQUIPMENT.id);
		a.setM_Product_ID(DictionaryIDs.M_Product.ASSET_VEHICLE.id);
		a.setIsOwned(true);
		a.setIsDepreciated(true);
		a.saveEx();

		MAssetAddition aa = new MAssetAddition(ctx, 0, trxName);
		aa.setA_Asset_ID(a.getA_Asset_ID());
		aa.setDateDoc(new Timestamp(System.currentTimeMillis()));
		aa.setA_SourceType(MAssetAddition.A_SOURCETYPE_Manual);
		aa.setAssetAmtEntered(new BigDecimal("12000.0"));
		aa.setAssetSourceAmt(aa.getAssetAmtEntered());
		aa.setA_Salvage_Value(new BigDecimal("2000.0"));
		aa.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(aa, DocAction.ACTION_Complete);
		aa.load(getTrxName());
		assertFalse(info.isError(), "Error processing asset addition: " + info.getSummary());
		assertEquals(DocAction.STATUS_Completed, aa.getDocStatus(), "Asset addition status is not completed: " + aa.getDocStatus());
		assertTrue(aa.isPosted(), "Asset addition not posted");

		final String sqlCnt = ""
				+ "SELECT COUNT(*) "
				+ "FROM A_Depreciation_Exp "
				+ "WHERE A_Asset_ID=? AND C_AcctSchema_ID=?";
		int cnt = DB.getSQLValueEx(trxName, sqlCnt, a.getA_Asset_ID(), DictionaryIDs.C_AcctSchema.DOLLAR.id);
		assertEquals(18, cnt);

		final String sqlSumExp = ""
				+ "SELECT SUM(Expense) "
				+ "FROM A_Depreciation_Exp "
				+ "WHERE A_Asset_ID=? AND C_AcctSchema_ID=?";
		BigDecimal sumExp = DB.getSQLValueBDEx(trxName, sqlSumExp, a.getA_Asset_ID(), DictionaryIDs.C_AcctSchema.DOLLAR.id);
		assertTrue( ( new BigDecimal("10000.0").compareTo(sumExp) == 0 ) );

	}

}
