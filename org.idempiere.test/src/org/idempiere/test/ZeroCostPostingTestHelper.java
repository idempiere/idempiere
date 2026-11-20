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
 **********************************************************************/
package org.idempiere.test;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.eq;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MSysConfig;
import org.compiere.model.Query;
import org.mockito.MockedStatic;

/**
 * Shared test helper for zero-cost posting unit tests.
 */
public final class ZeroCostPostingTestHelper {

	private ZeroCostPostingTestHelper() {
	}

	public static MProduct createStockedProduct(Properties ctx, String name, int M_Product_Category_ID, String trxName) {
		MProduct product = new MProduct(ctx, 0, trxName);
		product.setName(name);
		product.setValue(name);
		product.setM_Product_Category_ID(M_Product_Category_ID);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		product.setIsStocked(true);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();
		return product;
	}

	public static MProductCategory createStandardCostingCategory(Properties ctx, String name, String trxName) {
		return createStandardCostingCategory(ctx, name, null, trxName);
	}

	public static MProductCategory createStandardCostingCategory(Properties ctx, String name, String costingLevel, String trxName) {
		MProductCategory category = new MProductCategory(ctx, 0, trxName);
		category.setName(name);
		category.saveEx();
		List<MProductCategoryAcct> categoryAccts = new Query(ctx, MProductCategoryAcct.Table_Name, "M_Product_Category_ID=?", trxName)
				.setParameters(category.get_ID())
				.list();
		for (MProductCategoryAcct categoryAcct : categoryAccts) {
			categoryAcct.setCostingMethod(MAcctSchema.COSTINGMETHOD_StandardCosting);
			if (costingLevel != null) {
				categoryAcct.setCostingLevel(costingLevel);
			}
			categoryAcct.saveEx();
		}
		return category;
	}

	public static MPriceList createPurchasePriceList(Properties ctx, String name, Timestamp validFrom, int M_Product_ID, BigDecimal price, String trxName) {
		MPriceList priceList = new MPriceList(ctx, 0, trxName);
		priceList.setName(name);
		priceList.setIsSOPriceList(false);
		priceList.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		priceList.setPricePrecision(2);
		priceList.saveEx();

		addPriceListVersion(priceList, validFrom, M_Product_ID, price);
		return priceList;
	}

	public static MProductPrice addPriceListVersion(MPriceList priceList, Timestamp validFrom, int M_Product_ID, BigDecimal price) {
		MPriceListVersion plv = new MPriceListVersion(priceList);
		plv.setM_DiscountSchema_ID(DictionaryIDs.M_DiscountSchema.PURCHASE_2001.id);
		plv.setValidFrom(validFrom);
		plv.saveEx();

		MProductPrice pp = new MProductPrice(plv, M_Product_ID, price, price, BigDecimal.ZERO);
		pp.saveEx();
		return pp;
	}

	public static void addSalesPriceListEntry(Properties ctx, int M_Product_ID, BigDecimal price, String trxName) {
		MPriceListVersion salesPLV = MPriceList.get(DictionaryIDs.M_PriceList.STANDARD.id).getPriceListVersion(null);
		MProductPrice pp = new MProductPrice(ctx, 0, trxName);
		pp.setM_PriceList_Version_ID(salesPLV.get_ID());
		pp.setM_Product_ID(M_Product_ID);
		pp.setPrices(price, price, BigDecimal.ZERO);
		pp.saveEx();
	}

	public static void mockProductGet(MockedStatic<MProduct> productMock, MProduct product) {
		productMock.when(() -> MProduct.get(eq(product.get_ID()))).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()))).thenReturn(product);
		productMock.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
		productMock.when(() -> MProduct.getCopy(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);
	}

	public static void mockProductCategoryGet(MockedStatic<MProductCategory> categoryMock, MProductCategory category) {
		categoryMock.when(() -> MProductCategory.get(eq(category.get_ID()))).thenReturn(category);
		categoryMock.when(() -> MProductCategory.get(any(Properties.class), eq(category.get_ID()))).thenReturn(category);
	}

	public static void mockPriceListGet(MockedStatic<MPriceList> priceListMock, MPriceList priceList) {
		priceListMock.when(() -> MPriceList.get(eq(priceList.get_ID()))).thenReturn(priceList);
		priceListMock.when(() -> MPriceList.get(eq(priceList.get_ID()), any())).thenReturn(priceList);
		priceListMock.when(() -> MPriceList.get(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
		priceListMock.when(() -> MPriceList.getCopy(any(Properties.class), eq(priceList.get_ID()), any())).thenReturn(priceList);
	}

	public static void mockZeroCostSysConfig(MockedStatic<MSysConfig> sysConfigMock, int AD_Client_ID,
			boolean checkPO, boolean checkProduction, boolean checkPriceList) {
		sysConfigMock.when(() -> MSysConfig.getBooleanValue(eq(MSysConfig.CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING), anyBoolean(), eq(AD_Client_ID)))
			.thenReturn(checkPO);
		sysConfigMock.when(() -> MSysConfig.getBooleanValue(eq(MSysConfig.CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING), anyBoolean(), eq(AD_Client_ID)))
			.thenReturn(checkProduction);
		sysConfigMock.when(() -> MSysConfig.getBooleanValue(eq(MSysConfig.CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING), anyBoolean(), eq(AD_Client_ID)))
			.thenReturn(checkPriceList);
	}
}
