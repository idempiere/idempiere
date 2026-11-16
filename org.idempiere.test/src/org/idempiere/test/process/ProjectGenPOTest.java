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
 * - hengsin                                                           *
 **********************************************************************/
package org.idempiere.test.process;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

import java.math.BigDecimal;
import java.util.Properties;

import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPO;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProject;
import org.compiere.model.MProjectLine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.ConversionRateHelper;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * IDEMPIERE-7031 Unit tests for {@link org.compiere.process.ProjectGenPO}
 */
public class ProjectGenPOTest extends AbstractTestCase {

    @Test
    public void testMissingCurrencyConversionRate() {
        try (MockedStatic<MProduct> productMock = Mockito.mockStatic(MProduct.class);
             MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic()) {

            MProduct product = createPurchaseFallbackProduct(
                    productMock,
                    "testProjectGenPOMissingRate",
                    DictionaryIDs.C_Currency.GBP.id,
                    new BigDecimal("100.00"));

            MProject project = createTestProject("testProjectGenPONoRate");
            MProjectLine projectLine = createTestProjectLine(project, product, BigDecimal.ONE);

            ProcessInfo pi = runProjectGenPO(project);

            assertTrue(pi.isError(), "Expected ProjectGenPO to fail when currency conversion rate is missing");
            String summary = pi.getSummary();
            assertNotNull(summary, "Expected error summary when conversion rate is missing");
            assertFalse(summary.contains("PriceActual"), "Should not fail with PriceActual mandatory error: " + summary);
            assertTrue(summary.contains("GBP") && summary.contains("USD"),
                    "Expected source and target currency codes in error summary: " + summary);

            assertTrue(projectLine.load(getTrxName()), "Expected projectLine to reload in transaction");
            assertEquals(0, projectLine.getC_OrderPO_ID(),
                    "C_OrderPO_ID should not be updated when PO generation fails");
        }
    }

    @Test
    public void testValidCurrencyConversionRate() {
        try (MockedStatic<MProduct> productMock = Mockito.mockStatic(MProduct.class);
             MockedStatic<MConversionRate> conversionRateMock = ConversionRateHelper.mockStatic()) {

            MProduct product = createPurchaseFallbackProduct(
                    productMock,
                    "testProjectGenPOValidRate",
                    DictionaryIDs.C_Currency.GBP.id,
                    new BigDecimal("100.00"));

            MCurrency gbp = MCurrency.get(Env.getCtx(), DictionaryIDs.C_Currency.GBP.id);
            MCurrency usd = MCurrency.get(Env.getCtx(), DictionaryIDs.C_Currency.USD.id);
            ConversionRateHelper.mockGetRate(conversionRateMock, gbp, usd, 0, null,
                    new BigDecimal("1.25"), getAD_Client_ID(), getAD_Org_ID());

            MProject project = createTestProject("testProjectGenPOValidRate");
            BigDecimal plannedQty = new BigDecimal("2");
            MProjectLine projectLine = createTestProjectLine(project, product, plannedQty);

            ProcessInfo pi = runProjectGenPO(project);

            assertFalse(pi.isError(), pi.getSummary());

            assertTrue(projectLine.load(getTrxName()), "Expected projectLine to reload in transaction");
            assertTrue(projectLine.getC_OrderPO_ID() > 0, "Purchase order not linked to project line");

            MOrder order = new MOrder(Env.getCtx(), projectLine.getC_OrderPO_ID(), getTrxName());
            assertFalse(order.isSOTrx(), "Generated order should be a purchase order");
            assertEquals(DictionaryIDs.C_BPartner.SEED_FARM.id, order.getC_BPartner_ID(),
                    "Unexpected PO vendor");
            assertEquals(DictionaryIDs.C_Currency.USD.id, order.getC_Currency_ID(),
                    "Unexpected PO currency");

            MOrderLine[] lines = order.getLines();
            assertEquals(1, lines.length, "Unexpected PO line count");
            assertEquals(product.get_ID(), lines[0].getM_Product_ID(),
                    "Unexpected PO line product");
            assertEquals(0, new BigDecimal("125.00").compareTo(lines[0].getPriceActual()),
                    "Unexpected converted PO line price: " + lines[0].getPriceActual());
            assertEquals(0, plannedQty.compareTo(lines[0].getQtyOrdered()),
                    "Unexpected PO line quantity: " + lines[0].getQtyOrdered());
        }
    }

    private MProduct createPurchaseFallbackProduct(MockedStatic<MProduct> productMock, String name, int poCurrencyId,
            BigDecimal poPrice) {
        MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
        product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
        product.setValue(name);
        product.setName(name);
        product.setProductType(MProduct.PRODUCTTYPE_Item);
        product.setIsStocked(false);
        product.setIsSold(false);
        product.setIsPurchased(true);
        product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
        product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
        product.saveEx();
        mockProductGet(productMock, product);

        // Zero price on vendor's Purchase price list (USD) triggers fallback to MProductPO pricing
        MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(getLoginDate());
        MProductPrice pp = new MProductPrice(Env.getCtx(), plv.getM_PriceList_Version_ID(), product.get_ID(),
                Env.ZERO, Env.ZERO, Env.ZERO, getTrxName());
        pp.saveEx();

        MProductPO productPO = new MProductPO(Env.getCtx(), 0, getTrxName());
        productPO.setM_Product_ID(product.get_ID());
        productPO.setC_BPartner_ID(DictionaryIDs.C_BPartner.SEED_FARM.id);
        productPO.setIsCurrentVendor(true);
        productPO.setC_Currency_ID(poCurrencyId);
        productPO.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
        productPO.setVendorProductNo("V-" + product.get_ID());
        productPO.setPricePO(poPrice);
        productPO.saveEx();

        return product;
    }

    private MProject createTestProject(String name) {
        MProject project = new MProject(Env.getCtx(), 0, getTrxName());
        project.setValue(name);
        project.setName(name);
        project.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
        project.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id);
        project.setC_BPartner_Location_ID(DictionaryIDs.C_BPartner_Location.C_AND_W_STAMFORD.id);
        project.setM_PriceList_Version_ID(DictionaryIDs.M_PriceList_Version.STANDARD_2003.id);
        project.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.NET_30_DAYS.id);
        project.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
        project.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
        project.setSalesRep_ID(getAD_User_ID());
        project.saveEx();
        return project;
    }

    private MProjectLine createTestProjectLine(MProject project, MProduct product, BigDecimal plannedQty) {
        MProjectLine projectLine = new MProjectLine(project);
        projectLine.setM_Product_ID(product.get_ID());
        projectLine.setPlannedQty(plannedQty);
        projectLine.setPlannedPrice(new BigDecimal("150.00"));
        projectLine.saveEx();
        return projectLine;
    }

    private ProcessInfo runProjectGenPO(MProject project) {
        MProcess process = MProcess.get(Env.getCtx(), DictionaryIDs.AD_Process.C_PROJECT_GENERATE_PO.id);
        ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
        pi.setAD_Client_ID(getAD_Client_ID());
        pi.setAD_User_ID(getAD_User_ID());
        pi.setTransactionName(getTrxName());
        pi.setParameter(new ProcessInfoParameter[] {
            new ProcessInfoParameter("C_Project_ID", BigDecimal.valueOf(project.get_ID()), null, null, null)
        });
        ServerProcessCtl.process(pi, getTrx(), false);
        return pi;
    }

    private void mockProductGet(MockedStatic<MProduct> productMock, MProduct product) {
        int productId = product.get_ID();
        productMock.when(() -> MProduct.get(productId)).thenReturn(product);
        productMock.when(() -> MProduct.get(any(Properties.class), eq(productId))).thenReturn(product);
        productMock.when(() -> MProduct.get(any(Properties.class), eq(productId), any())).thenReturn(product);
        productMock.when(() -> MProduct.getCopy(any(Properties.class), eq(productId), any())).thenReturn(product);
    }
}
