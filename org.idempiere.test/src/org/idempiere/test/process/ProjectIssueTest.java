package org.idempiere.test.process;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MWarehouse;
import org.compiere.model.ProductCost;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 */
public class ProjectIssueTest extends AbstractTestCase
{
	@Test
	public void testProdProjBalanceUpdate()
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp currentDate = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));

		// Create PO Order
		MOrder order = new MOrder(ctx, 0, trxName);
		order.setC_BPartner_ID(DictionaryIDs.C_BPartner.PATIO.id);
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		order.setDateOrdered(currentDate);
		order.setIsSOTrx(false);
		order.save();

		// Add Order Line
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setM_Product_ID(DictionaryIDs.M_Product.OAK.id);
		orderLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		orderLine.setQty(BigDecimal.TEN);
		orderLine.setPrice(BigDecimal.TEN);
		orderLine.save();

		// Complete Order
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(trxName);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order issue is not completing");

		// MM Receipt
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, currentDate);
		receipt.saveEx();

		// Receipt Line
		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setC_OrderLine_ID(orderLine.get_ID());
		receiptLine.setLine(orderLine.getLine());
		receiptLine.setProduct(orderLine.getProduct());
		receiptLine.setQty(BigDecimal.TEN);

		MWarehouse wh = MWarehouse.get(Env.getCtx(), receipt.getM_Warehouse_ID());
		int M_Locator_ID = wh.getDefaultLocator().getM_Locator_ID();
		receiptLine.setM_Locator_ID(M_Locator_ID);
		receiptLine.saveEx();

		// Complete Receipt
		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		receipt.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus(), DocAction.STATUS_Completed + " != " + receipt.getDocStatus());

		// Create Project
		MProject proj = new MProject(ctx, 0, trxName);
		proj.setName("Test Project");
		proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
		proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		proj.setPlannedAmt(Env.ONE);
		proj.setCommittedQty(Env.ONE);
		proj.save();
		assertTrue(Env.ZERO.compareTo(proj.getProjectBalanceAmt()) == 0, "Initial Project Balance is not Zero");

		// Create Project Issue
		MProjectIssue projIssue = new MProjectIssue(ctx, 0, trxName);
		projIssue.setLine(10);
		projIssue.setMovementDate(TimeUtil.getDay(System.currentTimeMillis()));
		projIssue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ.id);
		projIssue.setMovementQty(Env.ONE);
		projIssue.setC_Project_ID(proj.get_ID());
		projIssue.setM_Product_ID(DictionaryIDs.M_Product.OAK.id);
		projIssue.save();

		// Complete Project Issue
		info = MWorkflow.runDocumentActionWorkflow(projIssue, DocAction.ACTION_Complete);
		proj.load(trxName);
		assertFalse(info.isError(), info.getSummary());
		projIssue.load(trxName);
		assertEquals(DocAction.STATUS_Completed, projIssue.getDocStatus(), "Project issue is not completing");

		ProductCost prodCost = new ProductCost(ctx, projIssue.getM_Product_ID(), 0, trxName);
		prodCost.setQty(Env.ONE);
		MAcctSchema as = MClient.get(ctx).getAcctSchema();
		BigDecimal cost = prodCost.getProductCosts(as, DictionaryIDs.AD_Org.HQ.id, null, 0, false);

		assertTrue(proj.getProjectBalanceAmt().compareTo(cost) == 0, "Project Issue Amount is not added in project balance");
	} // testProdProjBalanceUpdate

	@Test
	public void testChargeProjBalanceUpdate()
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp currentDate = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));

		// Create PO Order
		MOrder order = new MOrder(ctx, 0, trxName);
		order.setC_BPartner_ID(DictionaryIDs.C_BPartner.PATIO.id);
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		order.setDateOrdered(currentDate);
		order.setIsSOTrx(false);
		order.saveEx();

		// Add Order Line
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setC_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		orderLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		orderLine.setQty(BigDecimal.TEN);
		orderLine.setQtyInvoiced(BigDecimal.TEN);
		orderLine.setPrice(BigDecimal.TEN);
		orderLine.saveEx();

		// Complete Order
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(trxName);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order issue is not completing");

		// C Invoice
		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, currentDate);
		invoice.saveEx();

		// Invoice Line
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setC_OrderLine_ID(orderLine.get_ID());
		invoiceLine.setLine(orderLine.getLine());
		invoiceLine.setC_Charge_ID(orderLine.getC_Charge_ID());
		invoiceLine.setQty(orderLine.getQtyEntered());
		invoiceLine.setQtyInvoiced(orderLine.getQtyInvoiced());
		invoiceLine.setPriceEntered(orderLine.getPriceEntered());
		invoiceLine.setLineNetAmt(orderLine.getLineNetAmt());
		invoiceLine.setLineTotalAmt(orderLine.getLineNetAmt());
		invoiceLine.saveEx();

		// Complete Invoice
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), DocAction.STATUS_Completed + " != " + invoice.getDocStatus());

		// Create Project
		MProject proj = new MProject(ctx, 0, trxName);
		proj.setName("Test Project");
		proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
		proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		proj.setPlannedAmt(Env.ONE);
		proj.setCommittedQty(Env.ONE);
		proj.saveEx();
		assertTrue(Env.ZERO.compareTo(proj.getProjectBalanceAmt()) == 0, "Initial Project Balance is not Zero");

		// Create Project Issue
		MProjectIssue projIssue = new MProjectIssue(ctx, 0, trxName);
		projIssue.setLine(10);
		projIssue.setMovementDate(TimeUtil.getDay(System.currentTimeMillis()));
		projIssue.setMovementQty(invoiceLine.getQtyInvoiced());
		projIssue.setC_Project_ID(proj.get_ID());
		projIssue.setC_InvoiceLine_ID(invoiceLine.get_ID());
		projIssue.setC_Charge_ID(invoiceLine.getC_Charge_ID());
		projIssue.setAmt(invoiceLine.getLineTotalAmt());
		projIssue.saveEx();

		// Complete Project Issue
		info = MWorkflow.runDocumentActionWorkflow(projIssue, DocAction.ACTION_Complete);
		proj.load(trxName);
		assertFalse(info.isError(), info.getSummary());
		projIssue.load(trxName);
		assertEquals(DocAction.STATUS_Completed, projIssue.getDocStatus(), "Project issue is not completing");

		BigDecimal cost = invoiceLine.getQtyEntered().multiply(invoiceLine.getPriceEntered());

		assertTrue(proj.getProjectBalanceAmt().compareTo(cost) == 0, "Project Issue Amount is not added in project balance");
	} // testChargeProjBalanceUpdate

	@Test
	public void testProdInvLineFails()
	{
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();
		Timestamp currentDate = TimeUtil.getDay(Env.getContextAsDate(Env.getCtx(), "#Date"));

		// Create PO Order
		MOrder order = new MOrder(ctx, 0, trxName);
		order.setC_BPartner_ID(DictionaryIDs.C_BPartner.PATIO.id);
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
		order.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		order.setDateOrdered(currentDate);
		order.setIsSOTrx(false);
		order.saveEx();

		// Add Order Line
		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setM_Product_ID(DictionaryIDs.M_Product.OAK.id);
		orderLine.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
		orderLine.setQty(BigDecimal.TEN);
		orderLine.setQtyInvoiced(BigDecimal.TEN);
		orderLine.setPrice(BigDecimal.TEN);
		orderLine.saveEx();

		// Complete Order
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		order.load(trxName);
		assertFalse(info.isError(), info.getSummary());
		order.load(trxName);
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Order issue is not completing");

		// C Invoice
		MInvoice invoice = new MInvoice(order, DictionaryIDs.C_DocType.AP_INVOICE.id, currentDate);
		invoice.saveEx();

		// Invoice Line
		MInvoiceLine invoiceLine = new MInvoiceLine(invoice);
		invoiceLine.setC_OrderLine_ID(orderLine.get_ID());
		invoiceLine.setLine(orderLine.getLine());
		invoiceLine.setM_Product_ID(orderLine.getM_Product_ID());
		invoiceLine.setQty(orderLine.getQtyEntered());
		invoiceLine.setQtyInvoiced(orderLine.getQtyInvoiced());
		invoiceLine.setPriceEntered(orderLine.getPriceEntered());
		invoiceLine.setLineNetAmt(orderLine.getLineNetAmt());
		invoiceLine.setLineTotalAmt(orderLine.getLineNetAmt());
		invoiceLine.saveEx();

		// Complete Receipt
		info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus(), DocAction.STATUS_Completed + " != " + invoice.getDocStatus());

		// Create Project
		MProject proj = new MProject(ctx, 0, trxName);
		proj.setName("Test Project");
		proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
		proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		proj.setPlannedAmt(Env.ONE);
		proj.setCommittedQty(Env.ONE);
		proj.saveEx();
		assertTrue(Env.ZERO.compareTo(proj.getProjectBalanceAmt()) == 0, "Initial Project Balance is not Zero");

		// Create Project Issue
		MProjectIssue projIssue = null;
		try
		{
			projIssue = new MProjectIssue(ctx, 0, trxName);
			projIssue.setLine(10);
			projIssue.setMovementDate(TimeUtil.getDay(System.currentTimeMillis()));
			projIssue.setMovementQty(invoiceLine.getQtyInvoiced());
			projIssue.setC_Project_ID(proj.get_ID());
			projIssue.setC_InvoiceLine_ID(invoiceLine.get_ID());
			projIssue.setAmt(invoiceLine.getLineTotalAmt());
			projIssue.saveEx();
		}
		catch (Exception e)
		{
			assertTrue(!Util.isEmpty(e.getMessage(), true), "Exception message is not as expected: " + e.getMessage());
			return;
		}
		assertTrue(false, "Project Issue creation did not fail as expected");
	} // testProdInvLineFails
}
