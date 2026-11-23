package org.idempiere.test.acct;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MBank;
import org.compiere.model.MBankAccount;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductPrice;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.acct.doc.Doc_InOut;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;


/**
 * Unit Test for Doc_InOut Reversal Precision using Mockito.
 * Validates that the precise original cost (e.g. 4 decimal places (common value)
 * is retrieved, rather than relying on FactLine rounding.
 */
@Isolated
public class Doc_InOutTest extends AbstractTestCase {


    public Doc_InOutTest() {
    }

    @Test
    public void testFindReversalExactCostDetail_PreservesPrecision() throws Exception {
        MAcctSchema as = mock(MAcctSchema.class);
        when(as.getC_AcctSchema_ID()).thenReturn(100);

        Doc_InOut docInOut = mock(Doc_InOut.class, Mockito.CALLS_REAL_METHODS);

        int M_Product_ID = 10;
        int M_AttributeSetInstance_ID = 20;
        int reversalLine_ID = 30;
       
        // Simulates the original Cost Detail value with high precision (4 decimals).
        BigDecimal expectedCostDetailValue = new BigDecimal("10.1235");


        try (MockedStatic<DB> dbMock = Mockito.mockStatic(DB.class)) {
           
            dbMock.when(() -> DB.getSQLValueBDEx(
                    any(),
                    anyString(),
                    eq(100),
                    eq(M_AttributeSetInstance_ID),
                    eq(reversalLine_ID),
                    eq(M_Product_ID)
            )).thenReturn(expectedCostDetailValue);


            Method method = Doc_InOut.class.getDeclaredMethod(
                    "findReversalExactCostDetail",
                    MAcctSchema.class, int.class, int.class, int.class
            );
            method.setAccessible(true);


            BigDecimal actualCost = (BigDecimal) method.invoke(
                    docInOut, as, M_Product_ID, M_AttributeSetInstance_ID, reversalLine_ID
            );


            assertEquals(expectedCostDetailValue, actualCost,
                "The reversal cost must preserve the higher precision from MCostDetail (e.g. 10.1235).");
        }
    }
        /**
         * Integration test that executes the simplified high-precision flow requested:
		**/
    @Test
    public void testHighPrecisionFlow() throws Exception {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();
        Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

        MClient client = MClient.get(ctx);
        MAcctSchema as = client.getAcctSchema();
        int C_Currency_ID = as.getC_Currency_ID();

        // 1. Configure currency costing precision to cost precision decimals
        MCurrency currency = new MCurrency(ctx, C_Currency_ID, trxName);
        int originalPrecision = currency.getCostingPrecision();
        try {
            org.compiere.model.PO.setCrossTenantSafe();
            currency.setCostingPrecision(4);// Common value
            currency.saveEx();
        } finally {
            org.compiere.model.PO.clearCrossTenantSafe();
        }

        try {
            java.lang.reflect.Field s_currencies = MCurrency.class.getDeclaredField("s_currencies");
            s_currencies.setAccessible(true);
            ((org.idempiere.cache.ImmutableIntPOCache<?, ?>) s_currencies.get(null)).clear();
            
            java.lang.reflect.Field s_currenciesISO = MCurrency.class.getDeclaredField("s_currenciesISO");
            s_currenciesISO.setAccessible(true);
            ((org.idempiere.cache.ImmutablePOCache<?, ?>) s_currenciesISO.get(null)).clear();
            
            java.lang.reflect.Field s_cache = MAcctSchema.class.getDeclaredField("s_cache");
            s_cache.setAccessible(true);
            ((org.idempiere.cache.ImmutableIntPOCache<?, ?>) s_cache.get(null)).clear();

            BigDecimal preciseCost = new BigDecimal("1.12345678");

            // Prepare a product category (PATIO)
            MProductCategory cat = MProductCategory.get(ctx, DictionaryIDs.M_Product_Category.PATIO.id);
            
            MBank bank = new MBank(ctx, 0, trxName);
            bank.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            bank.setName("Bank Test");
            bank.setRoutingNo("123456");
            bank.saveEx();
            
            MBankAccount bankAccount = new MBankAccount(ctx, 0, trxName);
            bankAccount.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            bankAccount.setName("Account Bank Test");
            bankAccount.setC_Bank_ID(bank.get_ID());
            bankAccount.setAccountNo("654321");
            bankAccount.setC_Currency_ID(C_Currency_ID);
            bankAccount.setBankAccountType(MBankAccount.BANKACCOUNTTYPE_Cash);
            bankAccount.saveEx();

            // ==========================================
            // PRODUCT CREATION
            // ==========================================
            MProduct product = new MProduct(ctx, 0, trxName);
            product.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            product.setName("PreciseFlowProd");
            product.setValue("PFP");
            product.setM_Product_Category_ID(cat.get_ID());
            product.setIsStocked(true);
            product.setIsPurchased(true);
            product.setIsSold(true);
            product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
            product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
            product.saveEx();
            MProduct.get(ctx, product.get_ID(), trxName); // cache for product

            // Add Product Price
            int priceListId = DB.getSQLValue(trxName,
                "SELECT M_PriceList_ID FROM M_PriceList WHERE IsSOPriceList='N' AND AD_Client_ID=?", Env.getAD_Client_ID(ctx));
            int priceListVersionId = DB.getSQLValue(trxName,
                "SELECT M_PriceList_Version_ID FROM M_PriceList_Version WHERE M_PriceList_ID=? AND IsActive='Y' ORDER BY ValidFrom DESC", priceListId);
            MProductPrice productPrice = new MProductPrice(ctx, 0, trxName);
            productPrice.setM_Product_ID(product.get_ID());
            productPrice.setM_PriceList_Version_ID(priceListVersionId);
            productPrice.setPriceList(preciseCost);
            productPrice.setPriceStd(preciseCost);
            productPrice.setPriceLimit(preciseCost);
            productPrice.saveEx();

            // Add Product Price for Sales Price List (SO)
            int priceListSOVersionId = DictionaryIDs.M_PriceList_Version.STANDARD_2003.id;
            MProductPrice productPriceSO = new MProductPrice(ctx, 0, trxName);
            productPriceSO.setM_Product_ID(product.get_ID());
            productPriceSO.setM_PriceList_Version_ID(priceListSOVersionId);
            productPriceSO.setPriceList(new BigDecimal("2.0"));
            productPriceSO.setPriceStd(new BigDecimal("2.0"));
            productPriceSO.setPriceLimit(new BigDecimal("2.0"));
            productPriceSO.saveEx();

            // ==========================================
            // PURCHASE ORDER (PO)
            // ==========================================
            MOrder po = new MOrder(ctx, 0, trxName);
            po.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            po.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
            po.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
            po.setIsSOTrx(false);
            po.setDateOrdered(today);
            po.setDateAcct(today);
            po.setDatePromised(today);
            po.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.FERTILIZER.id);
            po.setM_PriceList_ID(DictionaryIDs.M_PriceList.PURCHASE.id);
            po.saveEx();

            MOrderLine poLine = new MOrderLine(po);
            poLine.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            poLine.setM_Product_ID(product.get_ID());
            poLine.setQty(new BigDecimal("10"));
            poLine.setPrice(preciseCost);
            poLine.saveEx();

            ProcessInfo poInfo = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
            po.load(trxName);
            assertFalse(poInfo.isError(), "Failed PO completion: " + poInfo.getSummary());
            assertEquals(DocAction.STATUS_Completed, po.getDocStatus());
            
            if(!po.isPosted()) {
            	String postErr = DocumentEngine.postImmediate(ctx, po.getAD_Client_ID(), po.get_Table_ID(), po.get_ID(), false, trxName);
            	assertNull(postErr == null, "Post error on PO: " + postErr);
            }
            // ==========================================
            // MANUAL COST ADJUSTMENT (Standard Costing)
            // ==========================================
            MInventory invManual = new MInventory(ctx, 0, trxName);
            invManual.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            invManual.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
            invManual.setC_Currency_ID(C_Currency_ID);
            invManual.setCostingMethod(MCostElement.COSTINGMETHOD_StandardCosting);
            invManual.saveEx();

            MInventoryLine lineManual = new MInventoryLine(ctx, 0, trxName);
            lineManual.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            lineManual.setM_Inventory_ID(invManual.get_ID());
            lineManual.setM_Product_ID(product.get_ID());
            lineManual.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
            lineManual.setCurrentCostPrice(BigDecimal.ZERO);
            lineManual.setNewCostPrice(preciseCost);
            lineManual.saveEx();

            ProcessInfo infoManual = MWorkflow.runDocumentActionWorkflow(invManual, DocAction.ACTION_Complete);
            invManual.load(trxName);
            assertFalse(infoManual.isError(), "Failed Manual Cost Adjustment: " + infoManual.getSummary());
            assertEquals(DocAction.STATUS_Completed, invManual.getDocStatus());
            
            if(!invManual.isPosted()) {
            	String postErr = DocumentEngine.postImmediate(ctx, invManual.getAD_Client_ID(), invManual.get_Table_ID(), invManual.get_ID(), false, trxName);
                assertTrue(postErr == null, "Post error on manual cost adjustment: " + postErr);
            }
            
            // ==========================================
            // AVERAGE INVOICE COST ADJUSTMENT
            // ==========================================
            // Initialize cost record for Average Invoice
            MCostElement ceAvg = MCostElement.getMaterialCostElement(as, MCostElement.COSTINGMETHOD_AveragePO);
            MCost costRecordAvg = MCost.get(product, 0, as, 0, ceAvg.getM_CostElement_ID(), trxName);
            costRecordAvg.setCurrentCostPrice(preciseCost);
            costRecordAvg.setCurrentQty(BigDecimal.ONE); // Seed quantity to allow normal adjustment
            costRecordAvg.saveEx();

            MInventory invAvg = new MInventory(ctx, 0, trxName);
            invAvg.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            invAvg.setC_DocType_ID(DictionaryIDs.C_DocType.COST_ADJUSTMENT.id);
            invAvg.setC_Currency_ID(C_Currency_ID);
            invAvg.setCostingMethod(MCostElement.COSTINGMETHOD_AveragePO);
            invAvg.saveEx();

            MInventoryLine lineAvg = new MInventoryLine(ctx, 0, trxName);
            lineAvg.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            lineAvg.setM_Inventory_ID(invAvg.get_ID());
            lineAvg.setM_Product_ID(product.get_ID());
            lineAvg.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
            lineAvg.setCurrentCostPrice(preciseCost);
            lineAvg.setNewCostPrice(preciseCost);
            lineAvg.saveEx();

            ProcessInfo infoAvg = MWorkflow.runDocumentActionWorkflow(invAvg, DocAction.ACTION_Complete);
            assertFalse(infoAvg.isError(), "Failed average cost adjustment: " + infoAvg.getSummary());
            
            if(!invAvg.isPosted()) {
            	String postErr = DocumentEngine.postImmediate(ctx, invAvg.getAD_Client_ID(), invAvg.get_Table_ID(), invAvg.get_ID(), false, trxName);
                assertTrue(postErr == null, "Post error on average cost adjustment: " + postErr);
            }
            
            // ==========================================
            // MATERIAL RECEIPT (InOut / Material Receipt)
            // ==========================================
            MInOut receipt = new MInOut(po, DictionaryIDs.C_DocType.MM_RECEIPT.id, today);
            receipt.setIsSOTrx(false);
            receipt.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            receipt.setDocStatus(DocAction.STATUS_Drafted);
            receipt.setDocAction(DocAction.ACTION_Complete);
            receipt.setC_Order_ID(po.getC_Order_ID());
            receipt.saveEx();

            MInOutLine recLine = new MInOutLine(receipt);
            recLine.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            recLine.setOrderLine(poLine, 0, new BigDecimal("10"));
            recLine.setQty(new BigDecimal("10"));
            recLine.setM_Locator_ID(DictionaryIDs.M_Locator.FERTILIZER.id);
            recLine.saveEx();

            ProcessInfo recInfo = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
    		receipt.load(getTrxName());
            assertFalse(recInfo.isError(), "Failed receipt completion: " + recInfo.getSummary());
            if(!receipt.isPosted()) {
            	String postErr = DocumentEngine.postImmediate(ctx, receipt.getAD_Client_ID(), receipt.get_Table_ID(), receipt.get_ID(), false, trxName);
                assertTrue(postErr == null, "Post error on material receipt: " + postErr);	
            }

            // =========================================
            // PURCHASE INVOICE
            // =========================================
            MInvoice apInvoice = new MInvoice(po, DictionaryIDs.C_DocType.AP_INVOICE.id, today);
            apInvoice.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            apInvoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_APInvoice);
            apInvoice.setIsSOTrx(false);
            apInvoice.saveEx();
            
            MInvoiceLine invLine = new MInvoiceLine(apInvoice);
            invLine.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            invLine.setOrderLine(poLine);
            invLine.setQty(new BigDecimal("10"));
            invLine.setPrice(preciseCost);
            invLine.setM_InOutLine_ID(recLine.get_ID());
            invLine.saveEx();
            
            ProcessInfo apInvInfo = MWorkflow.runDocumentActionWorkflow(apInvoice, DocAction.ACTION_Complete);
            apInvoice.load(trxName);
            assertFalse(apInvInfo.isError(), "Failed AP Invoice completion: " + apInvInfo.getSummary());
            assertEquals(DocAction.STATUS_Completed, apInvoice.getDocStatus());
            
            if(!apInvoice.isPosted()) {
                String postErr = DocumentEngine.postImmediate(ctx, apInvoice.getAD_Client_ID(), apInvoice.get_Table_ID(), apInvoice.get_ID(), false, trxName);
                assertNull(postErr, "Post error on AP Invoice: " + postErr);
            }

            // ==========================================
            // SALES ORDER (OV / Saler Order)
            // ==========================================
            MOrder so = new MOrder(ctx, 0, trxName);
            so.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            so.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
            so.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
            so.setIsSOTrx(true);
            so.setDateOrdered(today);
            so.setDateAcct(today);
            so.setDatePromised(today);
            so.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.FERTILIZER.id);
            so.setM_PriceList_ID(DictionaryIDs.M_PriceList.STANDARD.id);
            so.saveEx();

            MOrderLine soLine = new MOrderLine(so);
            soLine.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            soLine.setM_Product_ID(product.get_ID());
            soLine.setQty(new BigDecimal("1"));
            soLine.setPrice(new BigDecimal("2.0"));
            soLine.saveEx();

            ProcessInfo soInfo = MWorkflow.runDocumentActionWorkflow(so, DocAction.ACTION_Complete);
            assertFalse(soInfo.isError(), "Failed SO completion: " + soInfo.getSummary());
            if(!so.isPosted()) {
            	String postErr = DocumentEngine.postImmediate(ctx, so.getAD_Client_ID(), so.get_Table_ID(), so.get_ID(), false, trxName);
                assertTrue(postErr == null, "Post error on Sales Order: " + postErr);	
            }
            
            // ==========================================
            // CUSTOMER SHIPMENT (Sales Shipment)
            // ==========================================
            int mmShipmentDocType_ID = DB.getSQLValue(trxName, "SELECT C_DocType_ID FROM C_DocType WHERE DocBaseType='MMS' AND AD_Client_ID=? ORDER BY IsDefault DESC", Env.getAD_Client_ID(ctx));
            MInOut shipment = new MInOut(so, mmShipmentDocType_ID, today);
            shipment.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            shipment.setMovementType(MInOut.MOVEMENTTYPE_CustomerShipment);
            shipment.setIsSOTrx(true);
            shipment.saveEx();

            MInOutLine shipLine = new MInOutLine(shipment);
            shipLine.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            shipLine.setOrderLine(soLine, 0, new BigDecimal("1"));
            shipLine.setQty(new BigDecimal("1"));
            shipLine.setM_Locator_ID(DictionaryIDs.M_Locator.FERTILIZER.id);
            shipLine.saveEx();

            ProcessInfo shipInfo = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
            shipment.load(trxName);
            assertFalse(shipInfo.isError(), "Failed shipment completion: " + shipInfo.getSummary());
            if(!shipment.isPosted()) {
                String postErr = DocumentEngine.postImmediate(ctx, shipment.getAD_Client_ID(), shipment.get_Table_ID(), shipment.get_ID(), false, trxName);
                assertNull(postErr, "Post error on customer shipment: " + postErr);
            }

            // ==========================================
            // AR INVOICE (Sales Invoice)
            // ==========================================
            int arInvoiceDocType_ID = DB.getSQLValue(trxName, "SELECT C_DocType_ID FROM C_DocType WHERE DocBaseType='ARI' AND AD_Client_ID=? ORDER BY IsDefault DESC", Env.getAD_Client_ID(ctx));
            MInvoice arInvoice = new MInvoice(so, arInvoiceDocType_ID, today);
            arInvoice.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            arInvoice.setIsSOTrx(true);
            arInvoice.saveEx();

            MInvoiceLine arInvLine = new MInvoiceLine(arInvoice);
            arInvLine.setAD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
            arInvLine.setOrderLine(soLine);
            arInvLine.setQty(new BigDecimal("1"));
            arInvLine.setPrice(new BigDecimal("2.0"));
            arInvLine.setM_InOutLine_ID(shipLine.get_ID());
            arInvLine.saveEx();


            ProcessInfo arInvInfo = MWorkflow.runDocumentActionWorkflow(arInvoice, DocAction.ACTION_Complete);
            arInvoice.load(trxName);
            assertFalse(arInvInfo.isError(), "Failed AR Invoice completion: " + arInvInfo.getSummary());
            
            if(!arInvoice.isPosted()) {
                String postErr = DocumentEngine.postImmediate(ctx, arInvoice.getAD_Client_ID(), arInvoice.get_Table_ID(), arInvoice.get_ID(), false, trxName);
                assertNull(postErr, "Post error on AR Invoice: " + postErr);
            }

            // ==========================================
            // Reverse Shipment
            // ==========================================
          
            shipment.load(trxName);
            ProcessInfo reversalInfo = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Reverse_Correct);
            assertFalse(reversalInfo.isError(), "The reversal process failed: " + reversalInfo.getSummary());
            shipment.saveEx();
            int reversal_ID = shipment.getReversal_ID();
            assertTrue(reversal_ID > 0, "The refund document ID was not generated/registered.");
            MInOut reversalShipment = new MInOut(ctx, reversal_ID, trxName);
            String postRevErr = DocumentEngine.postImmediate(ctx, reversalShipment.getAD_Client_ID(), reversalShipment.get_Table_ID(), reversalShipment.get_ID(), true, trxName);
            assertTrue(postRevErr == null, "Error in accounting for reversal: " + postRevErr);
            assertEquals(DocAction.STATUS_Reversed, shipment.getDocStatus(), "The original document should be listed as reversed.");
            MInOutLine[] revLines = reversalShipment.getLines();
            assertTrue(revLines.length > 0, "The reverse documento should have copied the lines from the original.");
            MInOutLine revLine = revLines[0];
            String sqlRevCostDetail = "SELECT Amt FROM M_CostDetail"
                    + " WHERE C_AcctSchema_ID = ?"
                 + " AND M_AttributeSetInstance_ID = ?"
                 + " AND M_InOutLine_ID = ?"
                 + " AND M_Product_ID = ?"
                 + " AND COALESCE(M_CostElement_ID, 0)=0";
          
            BigDecimal reversalCostDetailAmt = DB.getSQLValueBDEx(trxName, sqlRevCostDetail, as.get_ID(), revLine.getM_AttributeSetInstance_ID(), revLine.get_ID(), revLine.getM_Product_ID());
          
            List<MCostDetail> costOriginal = new Query(ctx, MCostDetail.Table_Name, "M_InOutLine_ID=?", trxName)
                 .setParameters(shipLine.get_ID())
                 .list();
            assertNotNull(reversalCostDetailAmt, "The cost breakdown for the reverse was not generated.");
          
            BigDecimal expectedReversalAmt = costOriginal.isEmpty() ? BigDecimal.ZERO : costOriginal.get(0).getAmt().negate();
            assertEquals(0, expectedReversalAmt.compareTo(reversalCostDetailAmt),
                "The reverse cost should preserve the cost precision. Expected: "
                + expectedReversalAmt + " | Found: " + reversalCostDetailAmt);

        } finally {
            try {
                org.compiere.model.PO.setCrossTenantSafe();
                currency.setCostingPrecision(originalPrecision);
                currency.saveEx();
            } finally {
                org.compiere.model.PO.clearCrossTenantSafe();
            }
        }
    }
}
