package org.idempiere.test.process;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.ProductCost;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 */
public class ProjectIssueTest extends AbstractTestCase
{
	@Test
	public void testProjBalanceUpdate()
	{
		MProject proj = new MProject(Env.getCtx(), 0, getTrxName());
		proj.setName("Test Project");
		proj.setC_ProjectType_ID(DictionaryIDs.C_ProjectType.WORK_ORDER.id);
		proj.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		proj.setPlannedAmt(Env.ONE);
		proj.setCommittedQty(Env.ONE);
		proj.save();
		assertTrue(Env.ZERO.compareTo(proj.getProjectBalanceAmt()) == 0, "Initial Project Balance is not Zero");

		MProjectIssue projIssue = new MProjectIssue(Env.getCtx(), 0, getTrxName());
		projIssue.setLine(10);
		projIssue.setMovementDate(TimeUtil.getDay(System.currentTimeMillis()));
		projIssue.setM_Locator_ID(DictionaryIDs.M_Locator.HQ_TRANSIT.id);
		projIssue.setMovementQty(Env.ONE);
		projIssue.setC_Project_ID(proj.get_ID());
		projIssue.setM_Product_ID(DictionaryIDs.M_Product.OAK.id);
		projIssue.save();

		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(projIssue, DocAction.ACTION_Complete);
		proj.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		projIssue.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, projIssue.getDocStatus(), "Project issue is not completing");

		ProductCost prodCost = new ProductCost(Env.getCtx(), projIssue.getM_Product_ID(), 0, getTrxName());
		prodCost.setQty(Env.ONE);
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		BigDecimal cost = prodCost.getProductCosts(as, DictionaryIDs.AD_Org.HQ.id, null, 0, false);

		assertTrue(proj.getProjectBalanceAmt().compareTo(cost) == 0, "Project Issue Amount is not added in project balance");
	}
}
