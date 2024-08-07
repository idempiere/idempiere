/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.idempiere.test.costing;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutConfirm;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.FactAcct;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Test cases Stocked Expense type product with Average PO Costing Method.
 * 
 * @author Logilite Technologies
 * @since  September 15, 2023
 */
@Isolated
public class NonStockedExpTypeAvgPOCostingTest extends AbstractTestCase
{
	private static final BigDecimal	BD_2	= new BigDecimal("2.00");
	private static final BigDecimal	BD_5	= new BigDecimal("5.00");
	private static final BigDecimal	BD_20	= new BigDecimal("20.00");

	public NonStockedExpTypeAvgPOCostingTest()
	{
	}

	@Test
	public void testMaterialReceipt()
	{
		//need to create category and product for the every test case because after the first test completed it's rollback 
		//and also need to delete category and product at the end of the each test case otherwise next test case failed
		MProductCategory category = createProductCategory();
		MProduct product = createProduct(category.get_ID());

		try
		{
			MAcctSchema as = getAccountingSchema();
			MCost cost = getCost(as, product);

			// Create Material Receipt
			MInOutLine rLine = createPOAndMRForProduct(product);

			MMatchPO[] matchPOs = MMatchPO.get(Env.getCtx(), rLine.getM_InOutLine_ID(), getTrxName());
			assertEquals(1, matchPOs.length);
			assertEquals(rLine.getC_OrderLine_ID(), matchPOs[0].getC_OrderLine_ID());
			assertEquals(rLine.getM_InOutLine_ID(), matchPOs[0].getM_InOutLine_ID());
			assertTrue(matchPOs[0].getQty().compareTo(BigDecimal.TEN) == 0);
			
			cost.load(getTrxName());
			
			//Validate that averagePO costing method should not be created in the cost for the expense type product
			assertNoAveragePOCost(product.get_ID());

		
			// Testing cost and stock of the product after completing MR
			assertEquals(BD_2, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			
			assertEquals(BigDecimal.TEN.setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current Qty");
			//Assert no storage records created for expense type product
			MStorageOnHand[] storages = MStorageOnHand.getAll( Env.getCtx(), product.get_ID(),
			                                                   DictionaryIDs.M_Locator.HQ.id, getTrxName(), false, 0);
			assertEquals(0,storages.length,"No storage records should be created for expense type product");
			
			// Testing Accounting For MR
			Doc doc = DocManager.getDocument(as, MInOut.Table_ID, rLine.getM_InOut_ID(), getTrxName());
			doc.setC_BPartner_ID(rLine.getM_InOut().getC_BPartner_ID());
			MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);

			// get ProductExpense Of the created MR
			ProductCost pc = new ProductCost(Env.getCtx(), rLine.getM_Product_ID(), 0, getTrxName());
			MAccount productExpense = pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);

			Query query = MFactAcct.createRecordIdQuery(MInOut.Table_ID, rLine.getM_InOut_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(acctNIR, BD_20, 2, false, new BigDecimal("-10.00")),
					new FactAcct(productExpense, BD_20, 2, true, BigDecimal.TEN));
			assertFactAcctEntries(factAccts, expected);
		}
		finally
		{
			rollback();
			if (product != null)
				product.deleteEx(true);
			if (category != null)
				category.deleteEx(true);
		}
	}

	@Test
	public void testSOAndShipment()
	{
		MProductCategory category = createProductCategory();
		MProduct product = createProduct(category.get_ID());

		try
		{
			MAcctSchema as = getAccountingSchema();
			MCost cost = getCost(as, product);

			createPOAndMRForProduct(product);
			cost.load(getTrxName());
			assertNoAveragePOCost(product.get_ID());
			
			createSOAndShipmentForProduct(product);
			cost.load(getTrxName());

			// testing cost and stock of the product after completing Shipment
			assertEquals(BD_2, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(BigDecimal.TEN.setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current Qty");
			// Assert no storage records created for expense type product
			MStorageOnHand[] storages = MStorageOnHand.getAll( Env.getCtx(), product.get_ID(),
			                                                   DictionaryIDs.M_Locator.HQ.id, getTrxName(), false, 0);
			assertEquals(0,storages.length,"No storage records should be created for expense type product");
		}
		finally
		{
			rollback();
			if (product != null)
				product.deleteEx(true);
			if (category != null)
				category.deleteEx(true);
		}

	}

	@Test
	public void testCustomerRMA()
	{
		MProductCategory category = createProductCategory();
		MProduct product = createProduct(category.get_ID());

		try
		{
			MAcctSchema as = getAccountingSchema();
			MCost cost = getCost(as, product);

			createPOAndMRForProduct(product);
			cost.load(getTrxName());
			assertNoAveragePOCost(product.get_ID());


			// Create SO And Shipment
			MInOutLine sLine = createSOAndShipmentForProduct(product);
			cost.load(getTrxName());

			// Create MRA
			MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
			rma.setName("testCustomerReturnMaterial");
			rma.setC_DocType_ID(DictionaryIDs.C_DocType.CUSTOMER_RETURN_MATERIAL.id);
			rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
			rma.setM_InOut_ID(sLine.getM_InOut_ID());
			rma.setIsSOTrx(true);
			rma.setSalesRep_ID(SystemIDs.USER_SUPERUSER); // SuperUser
			rma.saveEx();

			// Create MRALine
			MRMALine rmaLine = new MRMALine(Env.getCtx(), 0, getTrxName());
			rmaLine.setLine(10);
			rmaLine.setM_RMA_ID(rma.get_ID());
			rmaLine.setQty(new BigDecimal("3"));
			rmaLine.setM_InOutLine_ID(sLine.get_ID());
			rmaLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(rma, DocAction.ACTION_Complete);
			rma.load(getTrxName());

			assertFalse(info.isError(), info.getSummary());
			assertEquals(DocAction.STATUS_Completed, rma.getDocStatus());

			// Create delivery for Customer Return Material
			MInOut delivery = new MInOut(Env.getCtx(), 0, getTrxName());
			delivery.setM_RMA_ID(rma.get_ID());
			delivery.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			delivery.setC_DocType_ID(DictionaryIDs.C_DocType.MM_CUSTOMER_RETURN.id);
			delivery.setMovementType(MInOut.MOVEMENTTYPE_CustomerReturns);
			delivery.setIsSOTrx(true);
			delivery.setDocStatus(DocAction.STATUS_Drafted);
			delivery.setDocAction(DocAction.ACTION_Complete);
			delivery.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			delivery.saveEx();

			MInOutLine dLine = new MInOutLine(delivery);
			dLine.setM_RMALine_ID(rmaLine.get_ID());
			dLine.setLine(10);
			dLine.setProduct(new MProduct(Env.getCtx(), product.getM_Product_ID(), getTrxName()));
			dLine.setM_Locator_ID(sLine.getM_Locator_ID());
			dLine.setQty(new BigDecimal("3"));
			dLine.saveEx();

			info = MWorkflow.runDocumentActionWorkflow(delivery, DocAction.ACTION_Complete);
			delivery.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());

			// Complete the MInOutConfirm to complete the delivery
			MInOutConfirm[] confirmations = delivery.getConfirmations(true);
			assertEquals(1, confirmations.length, "Expected 1 Shipment Confirmation Document");

			assertTrue(confirmations[0].getM_InOutConfirm_ID() != delivery.getM_InOut_ID(), "Test should run with M_InOut_ID != M_InOutConfirm_ID");

			info = MWorkflow.runDocumentActionWorkflow(confirmations[0], DocAction.ACTION_Complete);
			if (info.isError())
			{
				fail("Failed to complete shipment confirmation" + (Util.isEmpty(info.getSummary()) ? "" : " : " + info.getSummary()));
				return;
			}
			confirmations[0].load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, confirmations[0].getDocStatus(), "Expected Completed Status for Shipment Confirmation");

			// Complete the delivery
			info = MWorkflow.runDocumentActionWorkflow(delivery, DocAction.ACTION_Complete);
			delivery.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, delivery.getDocStatus(), "Expected Completed Status for Shipment");

			if (!delivery.isPosted())
			{
				String error = DocumentEngine.postImmediate(	Env.getCtx(), delivery.getAD_Client_ID(), MInOut.Table_ID,
																delivery.get_ID(), false, getTrxName());
				assertNull(error, error);
			}

			// testing cost and stock of the product after Customer return
			cost.load(getTrxName());

			assertEquals(BD_2, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost price");
			assertEquals(BigDecimal.TEN.setScale(2, RoundingMode.HALF_UP), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "Unexpected current cost Qty");
			// Assert no storage records created for expense type product
			MStorageOnHand[] storages = MStorageOnHand.getAll( Env.getCtx(), product.get_ID(),
			                                                   DictionaryIDs.M_Locator.HQ.id, getTrxName(), false, 0);
			assertEquals(0,storages.length,"No storage records should be created for expense type product");

		}
		finally
		{
			rollback();
			if (product != null)
				product.deleteEx(true);
			if (category != null)
				category.deleteEx(true);
		}
	}

	@Test
	public void testInvoice()
	{
		MProductCategory category = createProductCategory();
		MProduct product = createProduct(category.get_ID());

		try
		{
			MAcctSchema as = getAccountingSchema();
			MCost cost = getCost(as, product);

			// Create PO And MR
			MInOutLine rLine = createPOAndMRForProduct(product);
			cost.load(getTrxName());
			assertNoAveragePOCost(product.get_ID());

			// Create Invoice from the MR
			MInOut mInOut = (MInOut) rLine.getM_InOut();
			MInvoice invoice = new MInvoice(mInOut, rLine.getM_InOut().getMovementDate());
			invoice.setDocStatus(DocAction.STATUS_Drafted);
			invoice.setDocAction(DocAction.ACTION_Complete);
			invoice.saveEx();

			MOrderLine oLine = (MOrderLine) rLine.getC_OrderLine();
			MInvoiceLine iLine = new MInvoiceLine(invoice);
			iLine.setOrderLine(oLine);
			iLine.setLine(10);
			iLine.setProduct(new MProduct(Env.getCtx(), product.getM_Product_ID(), getTrxName()));
			iLine.setQty(BigDecimal.TEN);
			iLine.saveEx();

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			invoice.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			invoice.getDocsPostProcess().clear();
			if (!invoice.isPosted())
			{
				String error = DocumentEngine.postImmediate(	Env.getCtx(), invoice.getAD_Client_ID(),
																invoice.get_Table_ID(), invoice.get_ID(), false, getTrxName());
				assertNull(error, error);
			}
			// Testing Accounting for Invoice
			// get ProductExpense Of the Invoice
			ProductCost pc = new ProductCost(Env.getCtx(), iLine.getM_Product_ID(), 0, getTrxName());
			MAccount productExpense = pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);

			// get AccPayable of the Invoice
			MAccount acctPT = new MAccount(Env.getCtx(), as.getAcctSchemaDefault().getV_Liability_Acct(), getTrxName());

			Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, iLine.getC_Invoice_ID(), as.getC_AcctSchema_ID(), getTrxName());
			List<MFactAcct> factAccts = query.list();
			List<FactAcct> expected = Arrays.asList(new FactAcct(acctPT, BD_20, 2, false, BigDecimal.ZERO), 
					new FactAcct(productExpense, BD_20, 2, true, BigDecimal.TEN));
			assertFactAcctEntries(factAccts, expected);

			// Testing Accounting For MatchInv
			MMatchInv[] matchInvoices = MMatchInv.getInOut(Env.getCtx(), rLine.getM_InOut_ID(), getTrxName());
			assertEquals(1, matchInvoices.length);
			assertEquals(rLine.getM_InOutLine_ID(), matchInvoices[0].getM_InOutLine_ID());
			assertTrue(	matchInvoices[0].getQty().compareTo(BigDecimal.TEN) == 0,
						"Expected 5, get " + matchInvoices[0].getQty());
			
			// get NotInvoicedReceipts for the MatchInv
			Doc doc = DocManager.getDocument(as, MMatchInv.Table_ID, matchInvoices[0].get_ID(), getTrxName());
			doc.setC_BPartner_ID(matchInvoices[0].getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
			MAccount acctNIR = doc.getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as);

			// get Product Expense for the MatchInv
			pc = new ProductCost(Env.getCtx(), matchInvoices[0].getM_Product_ID(), 0, getTrxName());
			productExpense = pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
			query = MFactAcct.createRecordIdQuery(MMatchInv.Table_ID, matchInvoices[0].get_ID(), as.getC_AcctSchema_ID(), getTrxName());
			factAccts = query.list();
			expected = Arrays.asList(new FactAcct(acctNIR, BD_20, 2, true, BigDecimal.TEN), 
					new FactAcct(productExpense, BD_20, 2, false, BigDecimal.TEN.negate()));
			assertFactAcctEntries(factAccts, expected);
		}
		finally
		{
			rollback();
			if (product != null)
				product.deleteEx(true);
			if (category != null)
				category.deleteEx(true);
		}

	}

	@Test
	public void testExpenseProduction()
	{
		MProductCategory category = createProductCategory();
		MProduct product = createProduct(category.get_ID());
		MProduct fgProdcut = null;

		try
		{
			MAcctSchema as = getAccountingSchema();
			MCost cost = getCost(as, product);

			// create PO And MR for the expense type product
			createPOAndMRForProduct(product);
			cost.load(getTrxName());
			assertNoAveragePOCost(product.get_ID());

			// Create Product in which isBOM Flag true
			fgProdcut = new MProduct(Env.getCtx(), 0, null);
			fgProdcut.setName("Test_BOM");
			fgProdcut.setIsBOM(true);
			fgProdcut.setIsStocked(true);
			fgProdcut.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			fgProdcut.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			fgProdcut.setProductType(MProduct.PRODUCTTYPE_Item);
			fgProdcut.setM_Product_Category_ID(category.get_ID());
			fgProdcut.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			fgProdcut.saveEx();

			MCost fgCost = MCost.get(fgProdcut, 0, as, 0, DictionaryIDs.M_CostElement.MATERIAL.id, getTrxName());

			// create Product BOM
			MPPProductBOM bom = new MPPProductBOM(Env.getCtx(), 0, getTrxName());
			bom.setM_Product_ID(fgProdcut.get_ID());
			bom.setBOMType(MPPProductBOM.BOMTYPE_CurrentActive);
			bom.setBOMUse(MPPProductBOM.BOMUSE_Master);
			bom.setName(fgProdcut.getName());
			bom.saveEx();

			// Add expense type product in the ProductBOMLine
			MPPProductBOMLine bomLine = new MPPProductBOMLine(bom);
			bomLine.setM_Product_ID(product.getM_Product_ID());
			bomLine.setQtyBOM(BD_2);
			bomLine.saveEx();

			// Create production for the BOM product
			MProduction production = new MProduction(Env.getCtx(), 0, getTrxName());
			production.setM_Product_ID(fgProdcut.get_ID());
			production.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
			production.setIsUseProductionPlan(false);
			production.setMovementDate(getLoginDate());
			production.setDocAction(DocAction.ACTION_Complete);
			production.setDocStatus(DocAction.STATUS_Drafted);
			production.setIsComplete(false);
			production.setProductionQty(BD_2);
			production.setPP_Product_BOM_ID(bom.getPP_Product_BOM_ID());
			production.saveEx();

			// Create ProductionLine for the BOM Product
			MProcess process = MProcess.get(Env.getCtx(), 53226); // CreateProductionAndCreateLines
			ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setRecord_ID(production.get_ID());
			pi.setTransactionName(getTrxName());
			ServerProcessCtl.process(pi, getTrx(), false);
			assertFalse(pi.isError(), pi.getSummary());

			production.load(getTrxName());
			MProductionLine[] plines = production.getLines();
			assertEquals("Y", production.getIsCreated(), "MProduction.IsCreated != Y");
			assertTrue(plines.length > 0, "No Production Lines");
			assertEquals(2, plines.length, "Unexpected number of production lines");

			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(production, DocAction.ACTION_Complete);
			production.load(getTrxName());
			assertFalse(info.isError(), info.getSummary());
			assertEquals(	DocAction.STATUS_Completed, production.getDocStatus(),
							"Production Status=" + production.getDocStatus());

			fgCost.load(getTrxName());

			cost.load(getTrxName());

			// Test the Cost and stock for the Expense type's Product
			assertEquals(new BigDecimal("6.00"), cost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "");
			assertEquals(BD_2, cost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "");
			// Assert no storage records created for expense type product
			MStorageOnHand[] storages = MStorageOnHand.getAll( Env.getCtx(), product.get_ID(),
			                                                   DictionaryIDs.M_Locator.HQ.id, getTrxName(), false, 0);
			assertEquals(0,storages.length,"No stocked should be used for expense type product Usage in Poroduction");


			// test Stock and cost of the Product in which BOM is created
			assertEquals(BD_2, fgCost.getCurrentQty().setScale(2, RoundingMode.HALF_UP), "");
			assertEquals(BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP), fgCost.getCurrentCostPrice().setScale(2, RoundingMode.HALF_UP), "");
			// Assert that OnHand Qty for the  Finished goods of item type is created
			BigDecimal onHand = MStorageOnHand.getQtyOnHand(fgProdcut.get_ID(),DictionaryIDs.M_Warehouse.HQ.id, 0, getTrxName());
			assertEquals(BD_2, onHand.setScale(2, RoundingMode.HALF_UP), "Storage for the Expense Type Product Should not be Created");


		}
		finally
		{
			rollback();
			if (product != null)
				product.deleteEx(true);
			if (fgProdcut != null)
				fgProdcut.deleteEx(true);
			if (category != null)
				category.deleteEx(true);
		}
	}

	/**
	 * Create Expense Type Product
	 * 
	 * @param  category_ID Standard Costing
	 * @return
	 */
	private MProduct createProduct(int category_ID)
	{
		MProduct product = new MProduct(Env.getCtx(), 0, null);
		product.setName("testStandardCosting");
		product.setValue("testStandardCosting");
		product.setProductType(MProduct.PRODUCTTYPE_ExpenseType);
		product.setIsStocked(false);
		product.setIsSold(true);
		product.setIsPurchased(true);
		product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		product.setM_Product_Category_ID(category_ID);
		product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		product.saveEx();

		MPriceListVersion plv = MPriceList.get(DictionaryIDs.M_PriceList.PURCHASE.id).getPriceListVersion(null);
		MProductPrice pp = new MProductPrice(Env.getCtx(), 0, getTrxName());
		pp.setM_PriceList_Version_ID(plv.getM_PriceList_Version_ID());
		pp.setM_Product_ID(product.get_ID());
		pp.saveEx();

		MPriceListVersion plvs = MPriceList.get(DictionaryIDs.M_PriceList.STANDARD.id).getPriceListVersion(null);
		MProductPrice pps = new MProductPrice(Env.getCtx(), 0, getTrxName());
		pps.setM_PriceList_Version_ID(plvs.getM_PriceList_Version_ID());
		pps.setM_Product_ID(product.get_ID());
		pps.saveEx();

		return product;

	}

	/**
	 * Create PO And MR for the Expense Type Product
	 * 
	 * @param  product
	 * @return
	 */
	private MInOutLine createPOAndMRForProduct(MProduct product)
	{
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine oLine = new MOrderLine(order);
		oLine.setLine(10);
		oLine.setProduct(product);
		oLine.setQty(BigDecimal.TEN);
		oLine.setDatePromised(today);
		oLine.setPrice(BD_2);
		oLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine rLine = new MInOutLine(receipt);
		rLine.setOrderLine(oLine, 0, BigDecimal.TEN);
		rLine.setQty(BigDecimal.TEN);
		rLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		if (!receipt.isPosted())
		{
			String error = DocumentEngine.postImmediate(	Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(),
															receipt.get_ID(), false, getTrxName());
			assertNull(error, error);
		}

		return rLine;
	}

	/**
	 * Create SO And Shipment for the Expense Type Product
	 * 
	 * @param  product
	 * @return
	 */
	private MInOutLine createSOAndShipmentForProduct(MProduct product)
	{
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setIsSOTrx(true);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine oLine = new MOrderLine(order);
		oLine.setLine(10);
		oLine.setProduct(product);
		oLine.setQty(BD_5);
		oLine.setDatePromised(today);
		oLine.setPrice(BD_2);
		oLine.saveEx();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());

		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_SHIPMENT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.setIsSOTrx(true);
		receipt.saveEx();

		MInOutLine rLine = new MInOutLine(receipt);
		rLine.setOrderLine(oLine, 0, BD_5);
		rLine.setQty(BD_5);
		rLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());

		if (!receipt.isPosted())
		{
			String error = DocumentEngine.postImmediate(	Env.getCtx(), receipt.getAD_Client_ID(), receipt.get_Table_ID(),
															receipt.get_ID(), false, getTrxName());
			assertNull(error, error);
		}

		return rLine;
	}

	/**
	 * Get Accounting Schema
	 * 
	 * @return
	 */
	private MAcctSchema getAccountingSchema()
	{
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		return as;
	}

	private MCost getCost(MAcctSchema as, MProduct product)
	{
		return MCost.get(product, 0, as, 0, DictionaryIDs.M_CostElement.MATERIAL.id, getTrxName());
	}

	/**
	 * Create Product Category "Standard Costing"
	 * 
	 * @return
	 */
	private MProductCategory createProductCategory()
	{
		MProductCategory category = new MProductCategory(Env.getCtx(), 0, null);
		category.setName("Average PO");
		category.saveEx();
		String whereClause = "M_Product_Category_ID=?";
		List<MProductCategoryAcct> categoryAccts = new Query(Env.getCtx(), MProductCategoryAcct.Table_Name, whereClause, null)
														.setParameters(category.get_ID())
														.list();
		for (MProductCategoryAcct categoryAcct : categoryAccts)
		{
			categoryAcct.setCostingMethod(MAcctSchema.COSTINGMETHOD_AveragePO);
			categoryAcct.saveEx();
		}
		return category;
	}

	private void assertNoAveragePOCost(int productID)
	{
		List<MCost> costs = new Query(Env.getCtx(), MCost.Table_Name, " M_Product_ID = ? ", null)
						.setParameters(productID)
						.list();
		for (MCost cost : costs)
		{
			assertFalse(DictionaryIDs.M_CostElement.AVERAGE_PO.id == cost.getM_CostElement_ID(),"Average PO cost should not be created for Expense type product");
		}

	}
}
