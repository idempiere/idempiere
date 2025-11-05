/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.acct;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MCostDetail;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MTimeExpenseLine;
import org.compiere.model.ProductCost;
import org.compiere.util.Env;

/**
 *	Posting for {@link MProjectIssue} document. DOCTYPE_ProjectIssue.<br/>
 *	Note:
 *		Will load the default GL Category.
 *		Set up a document type to set the GL Category.
 *
 *  @author Jorg Janke
 *  @version $Id: Doc_ProjectIssue.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_ProjectIssue extends Doc
{
	/**
	 *  Constructor
	 * 	@param as accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_ProjectIssue (MAcctSchema as, ResultSet rs, String trxName)
	{
		super (as, MProjectIssue.class, rs, DOCTYPE_ProjectIssue, trxName);
	}   //  Doc_ProjectIssue

	/**	Pseudo Line								*/
	private DocLine				m_line = null;
	/** Issue									*/
	private MProjectIssue		m_issue = null;

	/**
	 *  Load Document Details
	 *  @return error message or null
	 */
	@Override
	protected String loadDocumentDetails()
	{
		setC_Currency_ID(NO_CURRENCY);
		m_issue = (MProjectIssue)getPO();
		setDateDoc (m_issue.getMovementDate());
		setDateAcct(m_issue.getMovementDate());

		//	Pseudo Line
		m_line = new DocLine (m_issue, this);
		m_line.setQty (m_issue.getMovementQty(), true);    //  sets Trx and Storage Qty
		m_line.setReversalLine_ID(m_issue.getReversal_ID());

		//	Pseudo Line Check
		if (m_line.getM_Product_ID() == 0)
			log.warning(m_line.toString() + " - No Product");
		if (log.isLoggable(Level.FINE)) log.fine(m_line.toString());
		return null;
	}   //  loadDocumentDetails

	/**
	 * 	Get DocumentNo
	 *	@return document no
	 */
	@Override
	public String getDocumentNo ()
	{
		MProject p = m_issue.getParent();
		if (p != null){
			StringBuilder msgreturn = new StringBuilder().append(p.getValue()).append(" #").append(m_issue.getLine());
			return msgreturn.toString();
		}	
		StringBuilder msgreturn = new StringBuilder("(").append(m_issue.get_ID()).append(")");
		return msgreturn.toString();
	}	//	getDocumentNo

	/**
	 *  Get Balance
	 *  @return Zero (always balanced)
	 */
	@Override
	public BigDecimal getBalance()
	{
		BigDecimal retValue = Env.ZERO;
		return retValue;
	}   //  getBalance

	/**
	 *  Create Facts (the accounting logic) for
	 *  PJI
	 *  <pre>
	 *  Issue
	 *      ProjectWIP      DR
	 *      Inventory               CR
	 *  </pre>
	 *  Project Account is either Asset or WIP depending on Project Type
	 *  @param as accounting schema
	 *  @return Fact
	 */
	@Override
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID (as.getC_Currency_ID());

		MProject project = new MProject (getCtx(), m_issue.getC_Project_ID(), getTrxName());
		String ProjectCategory = project.getProjectCategory();
		MProduct product = MProduct.get(getCtx(), m_issue.getM_Product_ID());

		//  Line pointers
		FactLine dr = null;
		FactLine cr = null;

		//  Issue Cost
		BigDecimal cost = null;
		if (m_issue.getM_InOutLine_ID() != 0)
		{
			MInOutLine inOutLine = new MInOutLine(getCtx(), m_issue.getM_InOutLine_ID(), getTrxName());
			cost = inOutLine.getPOCost(as, m_line.getQty());
		}
		else if (m_issue.getS_TimeExpenseLine_ID() != 0)
		{
			MTimeExpenseLine timeExpenseLine = new MTimeExpenseLine(getCtx(), m_issue.getS_TimeExpenseLine_ID(), getTrxName());
			cost = timeExpenseLine.getLaborCost(as);
		}
		if (cost == null)	//	standard Product Costs
			cost = m_line.getProductCosts(as, getAD_Org_ID(), false);

		//  Project         DR
		int acctType = ACCTTYPE_ProjectWIP;
		if (MProject.PROJECTCATEGORY_AssetProject.equals(ProjectCategory))
			acctType = ACCTTYPE_ProjectAsset;
		dr = fact.createLine(m_line,
			getAccount(acctType, as), as.getC_Currency_ID(), cost, null);
		dr.setQty(m_line.getQty().negate());

		//  Inventory               CR
		acctType = ProductCost.ACCTTYPE_P_Asset;
		if (product.isService())
			acctType = ProductCost.ACCTTYPE_P_Expense;
		cr = fact.createLine(m_line,
			m_line.getAccount(acctType, as),
			as.getC_Currency_ID(), null, cost);
		cr.setM_Locator_ID(m_line.getM_Locator_ID());
		cr.setLocationFromLocator(m_line.getM_Locator_ID(), true);	// from Loc
		//
		if (product != null && product.get_ID() > 0 && !product.isService() && product.isStocked()) {
			BigDecimal costDetailQty = m_line.getQty();
			BigDecimal costDetailAmt = cost;
			if (m_line.getQty().signum() != m_line.getProductCost().getQty().signum())
				costDetailAmt = costDetailAmt.negate();
			int Ref_CostDetail_ID = 0;
			if (m_line.getReversalLine_ID() > 0 && m_line.get_ID() > m_line.getReversalLine_ID())
			{
				MCostDetail cd = MCostDetail.getProduction(as, m_line.getM_Product_ID(), m_line.getM_AttributeSetInstance_ID(),
						m_line.getReversalLine_ID(), 0, getTrxName());
				if (cd != null)
					Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			}
			if (!MCostDetail.createProjectIssue(as, m_line.getAD_Org_ID(),
				m_line.getM_Product_ID(), m_line.getM_AttributeSetInstance_ID(),
				m_line.get_ID(), 0,
				costDetailAmt, costDetailQty,
				m_line.getDescription(), m_line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
			{
				p_Error = "Failed to create cost detail record";
				return null;
			}
		}
		//
		ArrayList<Fact> facts = new ArrayList<Fact>();
		facts.add(fact);
		return facts;
	}   //  createFact
}	//	DocProjectIssue