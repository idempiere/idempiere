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
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.AverageCostingZeroQtyException;
import org.compiere.model.ICostInfo;
import org.compiere.model.I_M_InOutLine;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClientInfo;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MCurrency;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MLandedCostAllocation;
import org.compiere.model.MOrderLandedCostAllocation;
import org.compiere.model.MTax;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.X_M_Cost;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;

/**
 *  Post Invoice Documents.
 *  <pre>
 *  Table:              C_Invoice (318)
 *  Document Types:     ARI, ARC, ARF, API, APC
 *  </pre>
 *  @author Jorg Janke
 *  @author Armen Rizal, Goodwill Consulting
 *  	<li>BF: 2797257	Landed Cost Detail is not using allocation qty
 *
 *  @version  $Id: Doc_Invoice.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_Invoice extends Doc
{
	/**
	 *  Constructor
	 * 	@param as accounting schemata
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_Invoice(MAcctSchema as, ResultSet rs, String trxName)
	{
		super (as, MInvoice.class, rs, null, trxName);
	}	//	Doc_Invoice

	/** Contained Optional Tax Lines    */
	protected DocTax[]        m_taxes = null;
	/** Contained Optional Tax Lines Distributed to Line Item */
	@SuppressWarnings("unused")
	private DocTax[]        m_addToLineTaxes = null;
	/** Currency Precision				*/
	protected int				m_precision = -1;
	/** All lines are Service			*/
	protected boolean			m_allLinesService = true;
	/** All lines are product item		*/
	protected boolean			m_allLinesItem = true;

	/**
	 *  Load Specific Document Details
	 *  @return error message or null
	 */
	@Override
	protected String loadDocumentDetails ()
	{
		MInvoice invoice = (MInvoice)getPO();
		setDateDoc(invoice.getDateInvoiced());
		setIsTaxIncluded(invoice.isTaxIncluded());
		//	Amounts
		setAmount(Doc.AMTTYPE_Gross, invoice.getGrandTotal());
		setAmount(Doc.AMTTYPE_Net, invoice.getTotalLines());
		setAmount(Doc.AMTTYPE_Charge, invoice.getChargeAmt());

		//	Contained Objects
		m_taxes = loadTaxes();
		p_lines = loadLines(invoice);
		if (log.isLoggable(Level.FINE)) log.fine("Lines=" + p_lines.length + ", Taxes=" + m_taxes.length);
		return null;
	}   //  loadDocumentDetails

	/**
	 *	Load Invoice Taxes
	 *  @return DocTax Array
	 */
	private DocTax[] loadTaxes()
	{
		ArrayList<DocTax> list = new ArrayList<DocTax>();
		ArrayList<DocTax> distributeList = new ArrayList<DocTax>();
		String sql = "SELECT it.C_Tax_ID, t.Name, t.Rate, it.TaxBaseAmt, it.TaxAmt, t.IsSalesTax "
				+ "FROM C_Tax t, C_InvoiceTax it "
				+ "WHERE t.C_Tax_ID=it.C_Tax_ID AND it.C_Invoice_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, get_ID());
			rs = pstmt.executeQuery();
			//
			while (rs.next())
			{
				int C_Tax_ID = rs.getInt(1);
				String name = rs.getString(2);
				BigDecimal rate = rs.getBigDecimal(3);
				BigDecimal taxBaseAmt = rs.getBigDecimal(4);
				BigDecimal amount = rs.getBigDecimal(5);
				boolean salesTax = "Y".equals(rs.getString(6));
				//
				MTax tax = MTax.get(getCtx(), C_Tax_ID);
				DocTax taxLine = new DocTax(C_Tax_ID, name, rate,
					taxBaseAmt, amount, salesTax);
				if (log.isLoggable(Level.FINE)) log.fine(taxLine.toString());
				if (!tax.isDistributeTaxWithLineItem())
				{					
					list.add(taxLine);
				}
				else
				{
					distributeList.add(taxLine);
				}
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return null;
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//	Return Array
		DocTax[] tl = new DocTax[list.size()];
		list.toArray(tl);
		//	Distribute list
		m_addToLineTaxes = distributeList.toArray(new DocTax[0]);
		
		return tl;
	}	//	loadTaxes

	/**
	 *	Load Invoice Line
	 *	@param invoice invoice
	 *  @return DocLine Array
	 */
	private DocLine[] loadLines (MInvoice invoice)
	{
		ArrayList<DocLine> list = new ArrayList<DocLine>();
		//
		MInvoiceLine[] lines = invoice.getLines(false);
		MInvoiceLine[] reversalLines = null;
		if (invoice.getReversal_ID() > 0)
		{
			MInvoice reversal = new MInvoice(invoice.getCtx(), invoice.getReversal_ID(), invoice.get_TrxName());
			reversalLines = reversal.getLines(false);		
		}
		for (int i = 0; i < lines.length; i++)
		{
			MInvoiceLine line = lines[i];
			if (line.isDescription())
				continue;
			DocLine docLine = new DocLine(line, this);
			//	Qty
			BigDecimal Qty = line.getQtyInvoiced();
			boolean cm = getDocumentType().equals(DOCTYPE_ARCredit)
				|| getDocumentType().equals(DOCTYPE_APCredit);
			docLine.setQty(cm ? Qty.negate() : Qty, invoice.isSOTrx());
			if (invoice.getReversal_ID() > 0 && reversalLines != null)
				docLine.setReversalLine_ID(reversalLines[i].get_ID());		
			//
			BigDecimal LineNetAmt = line.getLineNetAmt();
			BigDecimal PriceList = line.getPriceList();
			int C_Tax_ID = docLine.getC_Tax_ID();
			//	Correct included Tax
			if (isTaxIncluded() && C_Tax_ID != 0)
			{
				MTax tax = MTax.get(getCtx(), C_Tax_ID);
				if (!tax.isZeroTax())
				{
					BigDecimal LineNetAmtTax = tax.calculateTax(LineNetAmt, true, getStdPrecision());
					if (log.isLoggable(Level.FINE)) log.fine("LineNetAmt=" + LineNetAmt + " - Tax=" + LineNetAmtTax);

					if (tax.isSummary()) {
						LineNetAmt = LineNetAmt.subtract(LineNetAmtTax);
						BigDecimal base = LineNetAmt;
						BigDecimal sumChildLineNetAmtTax = Env.ZERO;
						DocTax taxToApplyDiff = null;
						for (MTax childTax : tax.getChildTaxes(false)) {
							if (!childTax.isZeroTax())
							{
								BigDecimal childLineNetAmtTax = childTax.calculateTax(base, false, getStdPrecision());
								if (log.isLoggable(Level.FINE)) log.fine("LineNetAmt=" + base + " - Child Tax=" + childLineNetAmtTax);
								if (childTax.isDistributeTaxWithLineItem())
								{
									LineNetAmt = LineNetAmt.add(childLineNetAmtTax);
									LineNetAmtTax = LineNetAmtTax.subtract(childLineNetAmtTax);
								}
								else
								{
									for (int t = 0; t < m_taxes.length; t++)
									{
										if (m_taxes[t].getC_Tax_ID() == childTax.getC_Tax_ID())
										{
											m_taxes[t].addIncludedTax(childLineNetAmtTax);
											taxToApplyDiff = m_taxes[t];
											sumChildLineNetAmtTax = sumChildLineNetAmtTax.add(childLineNetAmtTax);
											break;
										}
									}
								}
							}
						}
						BigDecimal diffChildVsSummary = LineNetAmtTax.subtract(sumChildLineNetAmtTax);
						if (diffChildVsSummary.signum() != 0 && taxToApplyDiff != null) {
							taxToApplyDiff.addIncludedTax(diffChildVsSummary);
						}
					} else {
						if (!tax.isDistributeTaxWithLineItem())
						{
							LineNetAmt = LineNetAmt.subtract(LineNetAmtTax);
							for (int t = 0; t < m_taxes.length; t++)
							{
								if (m_taxes[t].getC_Tax_ID() == C_Tax_ID)
								{
									m_taxes[t].addIncludedTax(LineNetAmtTax);
									break;
								}
							}
						}
					}
					
					BigDecimal PriceListTax = tax.calculateTax(PriceList, true, getStdPrecision());
					PriceList = PriceList.subtract(PriceListTax);
				}
			}	//	correct included Tax
			else
			{
				int stdPrecision = MCurrency.getStdPrecision(getCtx(), invoice.getC_Currency_ID());
				MTax tax = MTax.get(getCtx(), C_Tax_ID);
				if (tax.isSummary())
				{
					MTax[] cTaxes = tax.getChildTaxes(false);
					BigDecimal base = LineNetAmt;
					for(MTax cTax : cTaxes)
					{
						if (cTax.isDistributeTaxWithLineItem())
						{
							BigDecimal taxAmt = cTax.calculateTax(base, false, stdPrecision);
							LineNetAmt = LineNetAmt.add(taxAmt);
						}
					}
				}
				else if (tax.isDistributeTaxWithLineItem())
				{
					BigDecimal taxAmt = tax.calculateTax(LineNetAmt, false, stdPrecision);
					LineNetAmt = LineNetAmt.add(taxAmt);
				}
			}

			docLine.setAmount (LineNetAmt, PriceList, Qty);	//	qty for discount calc
			if (docLine.isItem())
				m_allLinesService = false;
			else
				m_allLinesItem = false;
			//
			if (log.isLoggable(Level.FINE)) log.fine(docLine.toString());
			list.add(docLine);
		}

		//	Convert to Array
		DocLine[] dls = new DocLine[list.size()];
		list.toArray(dls);

		//	Included Tax - make sure that no difference
		if (isTaxIncluded())
		{
			for (int i = 0; i < m_taxes.length; i++)
			{
				if (m_taxes[i].isIncludedTaxDifference())
				{
					BigDecimal diff = m_taxes[i].getIncludedTaxDifference();
					for (int j = 0; j < dls.length; j++)
					{
						MTax lineTax = MTax.get(getCtx(), dls[j].getC_Tax_ID());
						MTax[] composingTaxes = null;
						if (lineTax.isSummary()) {
							composingTaxes = lineTax.getChildTaxes(false);
						} else {
							composingTaxes = new MTax[1];
							composingTaxes[0] = lineTax;
						}
						for (MTax mTax : composingTaxes) {
							if (mTax.getC_Tax_ID() == m_taxes[i].getC_Tax_ID())
							{
								dls[j].setLineNetAmtDifference(diff);
								m_taxes[i].addIncludedTax(diff.negate());
								diff = Env.ZERO;
								break;
							}
						}
						if (diff.signum() == 0) {
							break;
						}
					}	//	for all lines
				}	//	tax difference
			}	//	for all taxes
		}	//	Included Tax difference

		//	Return Array
		return dls;
	}	//	loadLines

	/**
	 * 	Get Currency Precision
	 *	@return precision
	 */
	private int getStdPrecision()
	{
		if (m_precision == -1)
			m_precision = MCurrency.getStdPrecision(getCtx(), getC_Currency_ID());
		return m_precision;
	}	//	getPrecision


	/**
	 *  Get Source Currency Balance - subtracts line and tax amounts from total - no rounding
	 *  @return positive amount, if total invoice is bigger than lines
	 */
	@Override
	public BigDecimal getBalance()
	{
		BigDecimal retValue = Env.ZERO;
		StringBuilder sb = new StringBuilder (" [");
		//  Total
		retValue = retValue.add(getAmount(Doc.AMTTYPE_Gross));
		sb.append(getAmount(Doc.AMTTYPE_Gross));
		//  - Header Charge
		retValue = retValue.subtract(getAmount(Doc.AMTTYPE_Charge));
		sb.append("-").append(getAmount(Doc.AMTTYPE_Charge));
		//  - Tax
		for (int i = 0; i < m_taxes.length; i++)
		{
			retValue = retValue.subtract(m_taxes[i].getAmount());
			sb.append("-").append(m_taxes[i].getAmount());
		}
		//  - Lines
		for (int i = 0; i < p_lines.length; i++)
		{
			retValue = retValue.subtract(p_lines[i].getAmtSource());
			sb.append("-").append(p_lines[i].getAmtSource());
		}
		sb.append("]");
		//
		if (log.isLoggable(Level.FINE)) log.fine(toString() + " Balance=" + retValue + sb.toString());
		return retValue;
	}   //  getBalance

	/**
	 *  Create Facts (the accounting logic) for
	 *  ARI, ARC, ARF, API, APC.
	 *  <pre>
	 *  ARI, ARF
	 *      Receivables     DR
	 *      Charge                  CR
	 *      TaxDue                  CR
	 *      Revenue                 CR
	 *
	 *  ARC
	 *      Receivables             CR
	 *      Charge          DR
	 *      TaxDue          DR
	 *      Revenue         RR
	 *
	 *  API
	 *      Payables                CR
	 *      Charge          DR
	 *      TaxCredit       DR
	 *      Expense         DR
	 *
	 *  APC
	 *      Payables        DR
	 *      Charge                  CR
	 *      TaxCredit               CR
	 *      Expense                 CR
	 *  </pre>
	 *  @param as accounting schema
	 *  @return Fact
	 */
	@Override
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//
		ArrayList<Fact> facts = new ArrayList<Fact>();
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);

		//  Cash based accounting
		if (!as.isAccrual())
			return facts;

		//  ** ARI, ARF
		if (getDocumentType().equals(DOCTYPE_ARInvoice)
			|| getDocumentType().equals(DOCTYPE_ARProForma))
		{			
			BigDecimal grossAmt = getAmount(Doc.AMTTYPE_Gross);
			BigDecimal serviceAmt = Env.ZERO;

			//  Header Charge           CR
			BigDecimal amt = getAmount(Doc.AMTTYPE_Charge);
			if (amt != null && amt.signum() != 0)
				fact.createLine(null, getAccount(Doc.ACCTTYPE_Charge, as),
					getC_Currency_ID(), null, amt);
			//  TaxDue                  CR
			for (int i = 0; i < m_taxes.length; i++)
			{
				amt = m_taxes[i].getAmount();
				if (amt != null && amt.signum() != 0)
				{
					FactLine tl = fact.createLine(null, m_taxes[i].getAccount(DocTax.ACCTTYPE_TaxDue, as),
						getC_Currency_ID(), null, amt);
					if (tl != null)
						tl.setC_Tax_ID(m_taxes[i].getC_Tax_ID());					
				}
			}
			//  Revenue                 CR
			for (int i = 0; i < p_lines.length; i++)
			{
				amt = p_lines[i].getAmtSource();
				BigDecimal dAmt = null;
				if (as.isTradeDiscountPosted())
				{
					BigDecimal discount = p_lines[i].getDiscount();
					if (discount != null && discount.signum() != 0)
					{
						amt = amt.add(discount);
						dAmt = discount;
						fact.createLine (p_lines[i],
								p_lines[i].getAccount(ProductCost.ACCTTYPE_P_TDiscountGrant, as),
								getC_Currency_ID(), dAmt, null);
					}
				}
				fact.createLine (p_lines[i],
					p_lines[i].getAccount(ProductCost.ACCTTYPE_P_Revenue, as),
					getC_Currency_ID(), null, amt);
				if (!p_lines[i].isItem())
				{
					grossAmt = grossAmt.subtract(amt);
					serviceAmt = serviceAmt.add(amt);
				}
			}

			//  Receivables     DR
			int receivables_ID = getValidCombination_ID(Doc.ACCTTYPE_C_Receivable, as);
			int receivablesServices_ID = receivables_ID; // Receivable Services account Deprecated IDEMPIERE-362
			if (m_allLinesItem || !as.isPostServices()
				|| receivables_ID == receivablesServices_ID)
			{
				grossAmt = getAmount(Doc.AMTTYPE_Gross);
				serviceAmt = Env.ZERO;
			}
			else if (m_allLinesService)
			{
				serviceAmt = getAmount(Doc.AMTTYPE_Gross);
				grossAmt = Env.ZERO;
			}
			if (grossAmt.signum() != 0)
				fact.createLine(null, MAccount.get(getCtx(), receivables_ID),
					getC_Currency_ID(), grossAmt, null);
			if (serviceAmt.signum() != 0)
				fact.createLine(null, MAccount.get(getCtx(), receivablesServices_ID),
					getC_Currency_ID(), serviceAmt, null);

			//  Set Locations
			FactLine[] fLines = fact.getLines();
			for (int i = 0; i < fLines.length; i++)
			{
				if (fLines[i] != null)
				{
					fLines[i].setLocationFromOrg(fLines[i].getAD_Org_ID(), true);      //  from Loc
					fLines[i].setLocationFromBPartner(getC_BPartner_Location_ID(), false);  //  to Loc
				}
			}
		}
		//  ARC
		else if (getDocumentType().equals(DOCTYPE_ARCredit))
		{
			BigDecimal grossAmt = getAmount(Doc.AMTTYPE_Gross);
			BigDecimal serviceAmt = Env.ZERO;

			//  Header Charge   DR
			BigDecimal amt = getAmount(Doc.AMTTYPE_Charge);
			if (amt != null && amt.signum() != 0)
				fact.createLine(null, getAccount(Doc.ACCTTYPE_Charge, as),
					getC_Currency_ID(), amt, null);
			//  TaxDue          DR
			for (int i = 0; i < m_taxes.length; i++)
			{
				amt = m_taxes[i].getAmount();
				if (amt != null && amt.signum() != 0)
				{
					FactLine tl = fact.createLine(null, m_taxes[i].getAccount(DocTax.ACCTTYPE_TaxDue, as),
						getC_Currency_ID(), amt, null);
					if (tl != null)
						tl.setC_Tax_ID(m_taxes[i].getC_Tax_ID());
				}
			}
			//  Revenue         CR
			for (int i = 0; i < p_lines.length; i++)
			{
				amt = p_lines[i].getAmtSource();
				BigDecimal dAmt = null;
				if (as.isTradeDiscountPosted())
				{
					BigDecimal discount = p_lines[i].getDiscount();
					if (discount != null && discount.signum() != 0)
					{
						amt = amt.add(discount);
						dAmt = discount;
						fact.createLine (p_lines[i],
								p_lines[i].getAccount (ProductCost.ACCTTYPE_P_TDiscountGrant, as),
								getC_Currency_ID(), null, dAmt);
					}
				}
				fact.createLine (p_lines[i],
					p_lines[i].getAccount (ProductCost.ACCTTYPE_P_Revenue, as),
					getC_Currency_ID(), amt, null);
				if (!p_lines[i].isItem())
				{
					grossAmt = grossAmt.subtract(amt);
					serviceAmt = serviceAmt.add(amt);
				}
			}

			//  Receivables             CR
			int receivables_ID = getValidCombination_ID (Doc.ACCTTYPE_C_Receivable, as);
			int receivablesServices_ID = receivables_ID; // Receivable Services account Deprecated IDEMPIERE-362
			if (m_allLinesItem || !as.isPostServices()
				|| receivables_ID == receivablesServices_ID)
			{
				grossAmt = getAmount(Doc.AMTTYPE_Gross);
				serviceAmt = Env.ZERO;
			}
			else if (m_allLinesService)
			{
				serviceAmt = getAmount(Doc.AMTTYPE_Gross);
				grossAmt = Env.ZERO;
			}
			if (grossAmt.signum() != 0)
				fact.createLine(null, MAccount.get(getCtx(), receivables_ID),
					getC_Currency_ID(), null, grossAmt);
			if (serviceAmt.signum() != 0)
				fact.createLine(null, MAccount.get(getCtx(), receivablesServices_ID),
					getC_Currency_ID(), null, serviceAmt);

			//  Set Locations
			FactLine[] fLines = fact.getLines();
			for (int i = 0; i < fLines.length; i++)
			{
				if (fLines[i] != null)
				{
					fLines[i].setLocationFromOrg(fLines[i].getAD_Org_ID(), true);      //  from Loc
					fLines[i].setLocationFromBPartner(getC_BPartner_Location_ID(), false);  //  to Loc
				}
			}
		}

		//  ** API
		else if (getDocumentType().equals(DOCTYPE_APInvoice))
		{
			MInvoice invoice = (MInvoice)getPO();
			MInvoice originalInvoice = null;
			if (invoice.getReversal_ID() > 0 && invoice.getReversal_ID() < invoice.getC_Invoice_ID())
			{
				originalInvoice = new MInvoice(Env.getCtx(), invoice.getReversal_ID(), invoice.get_TrxName());
			}
			BigDecimal grossAmt = getAmount(Doc.AMTTYPE_Gross);
			BigDecimal serviceAmt = Env.ZERO;

			//  Charge          DR
			fact.createLine(null, getAccount(Doc.ACCTTYPE_Charge, as),
				getC_Currency_ID(), getAmount(Doc.AMTTYPE_Charge), null);
			//  TaxCredit       DR
			for (int i = 0; i < m_taxes.length; i++)
			{
				FactLine tl = fact.createLine(null, m_taxes[i].getAccount(m_taxes[i].getAPTaxType(), as),
					getC_Currency_ID(), m_taxes[i].getAmount(), null);
				if (tl != null)
					tl.setC_Tax_ID(m_taxes[i].getC_Tax_ID());
				if (tl != null && invoice.getReversal_ID() > 0 && invoice.getReversal_ID() < invoice.getC_Invoice_ID())
				{
					tl.updateReverseLine(MInvoice.Table_ID, invoice.getReversal_ID(), 0, BigDecimal.ONE);
				}
			}
			//  Expense         DR
			for (int i = 0; i < p_lines.length; i++)
			{
				DocLine line = p_lines[i];
				boolean landedCost = landedCost(as, fact, line, true);
				if (landedCost && as.isExplicitCostAdjustment())
				{
					fact.createLine (line, line.getAccount(ProductCost.ACCTTYPE_P_Expense, as),
						getC_Currency_ID(), line.getAmtSource(), null);
					//
					FactLine fl = fact.createLine (line, line.getAccount(ProductCost.ACCTTYPE_P_Expense, as),
						getC_Currency_ID(), null, line.getAmtSource());
					String desc = line.getDescription();
					if (desc == null)
						desc = "100%";
					else
						desc += " 100%";
					fl.setDescription(desc);
					if (invoice.getReversal_ID() > 0 && invoice.getReversal_ID() < invoice.getC_Invoice_ID())
					{
						int lineId = 0;
						if (originalInvoice != null)
						{
							MInvoiceLine[] lines = originalInvoice.getLines();
							if (lines.length > i)
								lineId = lines[i].getC_InvoiceLine_ID();
						}
						fl.updateReverseLine(MInvoice.Table_ID, invoice.getReversal_ID(), lineId, BigDecimal.ONE);
					}
				}
				if (!landedCost)
				{
					MAccount expense = line.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
					if (line.isItem())
						expense = line.getAccount (ProductCost.ACCTTYPE_P_InventoryClearing, as);
					BigDecimal amt = line.getAmtSource();
					BigDecimal dAmt = null;
					if (as.isTradeDiscountPosted() && !line.isItem())
					{
						BigDecimal discount = line.getDiscount();
						if (discount != null && discount.signum() != 0)
						{
							amt = amt.add(discount);
							dAmt = discount;
							MAccount tradeDiscountReceived = line.getAccount(ProductCost.ACCTTYPE_P_TDiscountRec, as);
							FactLine fl = fact.createLine (line, tradeDiscountReceived,
									getC_Currency_ID(), null, dAmt);
							if (fl != null && invoice.getReversal_ID() > 0 && invoice.getReversal_ID() < invoice.getC_Invoice_ID())
							{
								int lineId = 0;
								if (originalInvoice != null)
								{
									MInvoiceLine[] lines = originalInvoice.getLines();
									if (lines.length > i)
										lineId = lines[i].getC_InvoiceLine_ID();
								}
								fl.updateReverseLine(MInvoice.Table_ID, invoice.getReversal_ID(), lineId, BigDecimal.ONE);
							}
						}
					}
					FactLine fl = fact.createLine (line, expense,
						getC_Currency_ID(), amt, null);
					if (fl != null && invoice.getReversal_ID() > 0 && invoice.getReversal_ID() < invoice.getC_Invoice_ID())
					{
						int lineId = 0;
						if (originalInvoice != null)
						{
							MInvoiceLine[] lines = originalInvoice.getLines();
							if (lines.length > i)
								lineId = lines[i].getC_InvoiceLine_ID();
						}
						fl.updateReverseLine(MInvoice.Table_ID, invoice.getReversal_ID(), lineId, BigDecimal.ONE);
					}
					if (!line.isItem())
					{
						grossAmt = grossAmt.subtract(amt);
						serviceAmt = serviceAmt.add(amt);
					}
					//
					if (line.getM_Product_ID() != 0
						&& line.getProduct().isService()) {	//	otherwise Inv Matching
						int Ref_CostDetail_ID = 0;
						if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
						{
							MInvoiceLine reversalLine = new MInvoiceLine(getCtx(), line.getReversalLine_ID(), getTrxName());
							MCostDetail cd = MCostDetail.getInvoice(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
									reversalLine.get_ID(), 0, reversalLine.getParent().getDateAcct(), getTrxName());
							if (cd != null)
								Ref_CostDetail_ID = cd.getM_CostDetail_ID();
						}
						MCostDetail.createInvoice(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,		//	No Cost Element
							line.getAmtSource(), line.getQty(),
							line.getDescription(), line.getDateAcct(), Ref_CostDetail_ID, getTrxName());
					}
				}
			}

			//  Liability               CR
			int payables_ID = getValidCombination_ID (Doc.ACCTTYPE_V_Liability, as);
			int payablesServices_ID = payables_ID; // Liability Services account Deprecated IDEMPIERE-362
			if (m_allLinesItem || !as.isPostServices()
				|| payables_ID == payablesServices_ID)
			{
				grossAmt = getAmount(Doc.AMTTYPE_Gross);
				serviceAmt = Env.ZERO;
			}
			else if (m_allLinesService)
			{
				serviceAmt = getAmount(Doc.AMTTYPE_Gross);
				grossAmt = Env.ZERO;
			}
			FactLine fl = null;
			if (grossAmt.signum() > 0)
				fl = fact.createLine(null, MAccount.get(getCtx(), payables_ID),
					getC_Currency_ID(), null, grossAmt);
			else if (grossAmt.signum() < 0)
				fl = fact.createLine(null, MAccount.get(getCtx(), payables_ID),
						getC_Currency_ID(), grossAmt.negate(), null);
			if (serviceAmt.signum() > 0)
				fl = fact.createLine(null, MAccount.get(getCtx(), payablesServices_ID),
					getC_Currency_ID(), null, serviceAmt);
			else if (serviceAmt.signum() < 0)
				fl = fact.createLine(null, MAccount.get(getCtx(), payablesServices_ID),
						getC_Currency_ID(), serviceAmt.negate(), null);
			if (fl != null && invoice.getReversal_ID() > 0 && invoice.getReversal_ID() < invoice.getC_Invoice_ID())
			{
				fl.updateReverseLine(MInvoice.Table_ID, invoice.getReversal_ID(), 0, BigDecimal.ONE);
			}
			//  Set Locations
			FactLine[] fLines = fact.getLines();
			for (int i = 0; i < fLines.length; i++)
			{
				if (fLines[i] != null)
				{
					fLines[i].setLocationFromBPartner(getC_BPartner_Location_ID(), true);  //  from Loc
					fLines[i].setLocationFromOrg(fLines[i].getAD_Org_ID(), false);    //  to Loc
				}
			}

			//
			updateProductPO(as);	//	Only API
		}
		//  APC
		else if (getDocumentType().equals(DOCTYPE_APCredit))
		{
			BigDecimal grossAmt = getAmount(Doc.AMTTYPE_Gross);
			BigDecimal serviceAmt = Env.ZERO;
			//  Charge                  CR
			fact.createLine (null, getAccount(Doc.ACCTTYPE_Charge, as),
				getC_Currency_ID(), null, getAmount(Doc.AMTTYPE_Charge));
			//  TaxCredit               CR
			for (int i = 0; i < m_taxes.length; i++)
			{
				FactLine tl = fact.createLine (null, m_taxes[i].getAccount(m_taxes[i].getAPTaxType(), as),
					getC_Currency_ID(), null, m_taxes[i].getAmount());
				if (tl != null)
					tl.setC_Tax_ID(m_taxes[i].getC_Tax_ID());
			}
			//  Expense                 CR
			for (int i = 0; i < p_lines.length; i++)
			{
				DocLine line = p_lines[i];
				boolean landedCost = landedCost(as, fact, line, false);
				if (landedCost && as.isExplicitCostAdjustment())
				{
					fact.createLine (line, line.getAccount(ProductCost.ACCTTYPE_P_Expense, as),
						getC_Currency_ID(), null, line.getAmtSource());
					//
					FactLine fl = fact.createLine (line, line.getAccount(ProductCost.ACCTTYPE_P_Expense, as),
						getC_Currency_ID(), line.getAmtSource(), null);
					String desc = line.getDescription();
					if (desc == null)
						desc = "100%";
					else
						desc += " 100%";
					fl.setDescription(desc);
				}
				if (!landedCost)
				{
					MAccount expense = line.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
					if (line.isItem())
						expense = line.getAccount (ProductCost.ACCTTYPE_P_InventoryClearing, as);
					BigDecimal amt = line.getAmtSource();
					BigDecimal dAmt = null;
					if (as.isTradeDiscountPosted() && !line.isItem())
					{
						BigDecimal discount = line.getDiscount();
						if (discount != null && discount.signum() != 0)
						{
							amt = amt.add(discount);
							dAmt = discount;
							MAccount tradeDiscountReceived = line.getAccount(ProductCost.ACCTTYPE_P_TDiscountRec, as);
							fact.createLine (line, tradeDiscountReceived,
									getC_Currency_ID(), dAmt, null);
						}
					}
					fact.createLine (line, expense,
						getC_Currency_ID(), null, amt);
					if (!line.isItem())
					{
						grossAmt = grossAmt.subtract(amt);
						serviceAmt = serviceAmt.add(amt);
					}
					//
					if (line.getM_Product_ID() != 0
						&& line.getProduct().isService()) {	//	otherwise Inv Matching
						int Ref_CostDetail_ID = 0;
						if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
						{
							MInvoiceLine reversalLine = new MInvoiceLine(getCtx(), line.getReversalLine_ID(), getTrxName());
							MCostDetail cd = MCostDetail.getInvoice(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
									reversalLine.get_ID(), 0, reversalLine.getParent().getDateAcct(), getTrxName());
							if (cd != null)
								Ref_CostDetail_ID = cd.getM_CostDetail_ID();
						}
						MCostDetail.createInvoice(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,		//	No Cost Element
							line.getAmtSource().negate(), line.getQty(),
							line.getDescription(), line.getDateAcct(), Ref_CostDetail_ID, getTrxName());
					}
				}
			}

			//  Liability       DR
			int payables_ID = getValidCombination_ID (Doc.ACCTTYPE_V_Liability, as);
			int payablesServices_ID = payables_ID; // Liability Services account Deprecated IDEMPIERE-362
			if (m_allLinesItem || !as.isPostServices()
				|| payables_ID == payablesServices_ID)
			{
				grossAmt = getAmount(Doc.AMTTYPE_Gross);
				serviceAmt = Env.ZERO;
			}
			else if (m_allLinesService)
			{
				serviceAmt = getAmount(Doc.AMTTYPE_Gross);
				grossAmt = Env.ZERO;
			}
			if (grossAmt.signum() != 0)
				fact.createLine(null, MAccount.get(getCtx(), payables_ID),
					getC_Currency_ID(), grossAmt, null);
			if (serviceAmt.signum() != 0)
				fact.createLine(null, MAccount.get(getCtx(), payablesServices_ID),
					getC_Currency_ID(), serviceAmt, null);

			//  Set Locations
			FactLine[] fLines = fact.getLines();
			for (int i = 0; i < fLines.length; i++)
			{
				if (fLines[i] != null)
				{
					fLines[i].setLocationFromBPartner(getC_BPartner_Location_ID(), true);  //  from Loc
					fLines[i].setLocationFromOrg(fLines[i].getAD_Org_ID(), false);    //  to Loc
				}
			}
		}
		else
		{
			p_Error = "DocumentType unknown: " + getDocumentType();
			log.log(Level.SEVERE, p_Error);
			fact = null;
		}
		//
		facts.add(fact);
		return facts;
	}   //  createFact

	/**
	 * 	Create Fact for Cash Based accounting (i.e. only revenue/expense)
	 *	@param as accounting schema
	 *	@param fact fact to add lines to
	 *	@param multiplier source amount multiplier
	 *	@return accounted amount
	 */
	public BigDecimal createFactCash (MAcctSchema as, Fact fact, BigDecimal multiplier)
	{
		boolean creditMemo = getDocumentType().equals(DOCTYPE_ARCredit)
			|| getDocumentType().equals(DOCTYPE_APCredit);
		boolean payables = getDocumentType().equals(DOCTYPE_APInvoice)
			|| getDocumentType().equals(DOCTYPE_APCredit);
		BigDecimal acctAmt = Env.ZERO;
		FactLine fl = null;
		//	Revenue/Cost
		for (int i = 0; i < p_lines.length; i++)
		{
			DocLine line = p_lines[i];
			boolean landedCost = false;
			if  (payables)
				landedCost = landedCost(as, fact, line, false);
			if (landedCost && as.isExplicitCostAdjustment())
			{
				fact.createLine (line, line.getAccount(ProductCost.ACCTTYPE_P_Expense, as),
					getC_Currency_ID(), null, line.getAmtSource());
				//
				fl = fact.createLine (line, line.getAccount(ProductCost.ACCTTYPE_P_Expense, as),
					getC_Currency_ID(), line.getAmtSource(), null);
				String desc = line.getDescription();
				if (desc == null)
					desc = "100%";
				else
					desc += " 100%";
				fl.setDescription(desc);
			}
			if (!landedCost)
			{
				MAccount acct = line.getAccount(
					payables ? ProductCost.ACCTTYPE_P_Expense : ProductCost.ACCTTYPE_P_Revenue, as);
				if (payables)
				{
					//	if Fixed Asset
					if (line.isItem())
						acct = line.getAccount (ProductCost.ACCTTYPE_P_InventoryClearing, as);
				}
				BigDecimal amt = line.getAmtSource().multiply(multiplier);
				BigDecimal amt2 = null;
				if (creditMemo)
				{
					amt2 = amt;
					amt = null;
				}
				if (payables)	//	Vendor = DR
					fl = fact.createLine (line, acct,
						getC_Currency_ID(), amt, amt2);
				else			//	Customer = CR
					fl = fact.createLine (line, acct,
						getC_Currency_ID(), amt2, amt);
				if (fl != null)
					acctAmt = acctAmt.add(fl.getAcctBalance());
			}
		}
		//  Tax
		for (int i = 0; i < m_taxes.length; i++)
		{
			BigDecimal amt = m_taxes[i].getAmount();
			BigDecimal amt2 = null;
			if (creditMemo)
			{
				amt2 = amt;
				amt = null;
			}
			FactLine tl = null;
			if (payables)
				tl = fact.createLine (null, m_taxes[i].getAccount(m_taxes[i].getAPTaxType(), as),
					getC_Currency_ID(), amt, amt2);
			else
				tl = fact.createLine (null, m_taxes[i].getAccount(DocTax.ACCTTYPE_TaxDue, as),
					getC_Currency_ID(), amt2, amt);
			if (tl != null)
				tl.setC_Tax_ID(m_taxes[i].getC_Tax_ID());
		}
		//  Set Locations
		FactLine[] fLines = fact.getLines();
		for (int i = 0; i < fLines.length; i++)
		{
			if (fLines[i] != null)
			{
				if (payables)
				{
					fLines[i].setLocationFromBPartner(getC_BPartner_Location_ID(), true);  //  from Loc
					fLines[i].setLocationFromOrg(fLines[i].getAD_Org_ID(), false);    //  to Loc
				}
				else
				{
					fLines[i].setLocationFromOrg(fLines[i].getAD_Org_ID(), true);    //  from Loc
					fLines[i].setLocationFromBPartner(getC_BPartner_Location_ID(), false);  //  to Loc
				}
			}
		}
		return acctAmt;
	}	//	createFactCash


	/**
	 * 	Create Landed Cost accounting and Cost lines
	 *	@param as accounting schema
	 *	@param fact fact
	 *	@param line document line
	 *	@param dr true for DR side, false otherwise
	 *	@return true if landed costs were created
	 */
	protected boolean landedCost (MAcctSchema as, Fact fact, DocLine line, boolean dr)
	{
		int C_InvoiceLine_ID = line.get_ID();
		MLandedCostAllocation[] lcas = MLandedCostAllocation.getOfInvoiceLine(
			getCtx(), C_InvoiceLine_ID, getTrxName());
		if (lcas.length == 0)
			return false;

		//	Calculate Total Base
		double totalBase = 0;
		for (int i = 0; i < lcas.length; i++)
			totalBase += lcas[i].getBase().doubleValue();

		Map<String, BigDecimal> costDetailAmtMap = new HashMap<>();
		Map<String, BigDecimal> mcostQtyMap = new HashMap<>();
		
		//	Create New
		MInvoiceLine il = new MInvoiceLine (getCtx(), C_InvoiceLine_ID, getTrxName());
		for (int i = 0; i < lcas.length; i++)
		{
			MLandedCostAllocation lca = lcas[i];
			if (lca.getBase().signum() == 0)
				continue;
			double percent = lca.getBase().doubleValue() / totalBase;
			String desc = il.getDescription();
			if (desc == null)
				desc = percent + "%";
			else
				desc += " - " + percent + "%";
			if (line.getDescription() != null)
				desc += " - " + line.getDescription();

			// Accounting			
			BigDecimal drAmt = null;
			BigDecimal crAmt = null;
			MAccount account = null;
			ProductCost pc = new ProductCost (Env.getCtx(),
					lca.getM_Product_ID(), lca.getM_AttributeSetInstance_ID(), getTrxName());
			String costingMethod = pc.getProduct().getCostingMethod(as);
			if (X_M_Cost.COSTINGMETHOD_AverageInvoice.equals(costingMethod) || X_M_Cost.COSTINGMETHOD_AveragePO.equals(costingMethod))
			{
			
				BigDecimal allocationAmt =  lca.getAmt();
				boolean reversal = false;
				if (allocationAmt.signum() < 0) //reversal
				{
					allocationAmt = allocationAmt.negate();
					reversal = true;
				}
				
				BigDecimal estimatedAmt = BigDecimal.ZERO;
				BigDecimal costAdjustmentAmt = BigDecimal.ZERO;
				boolean usesSchemaCurrency = false;
				MInvoiceLine reversalLine = null;
				if (reversal)
				{
					MInvoice invoice = (MInvoice)getPO();
					MInvoice reversalInvoice = new MInvoice(getCtx(), invoice.getReversal_ID(), getTrxName());
					MInvoiceLine[] lines = invoice.getLines();
					MInvoiceLine[] reversalLines = reversalInvoice.getLines();
					for(int j = 0; j < lines.length; j++) {
						if (lines[j].get_ID() == il.get_ID()) {
							reversalLine = reversalLines[j];
							break;
						}
					}
				}
				else
				{
					int oCurrencyId = 0;					
					Timestamp oDateAcct = getDateAcct();
					if (lca.getM_InOutLine_ID() > 0)
					{
						I_M_InOutLine iol = lca.getM_InOutLine();
						if (iol.getC_OrderLine_ID() > 0)
						{
							oCurrencyId =  iol.getC_OrderLine().getC_Currency_ID();
							oDateAcct = iol.getC_OrderLine().getC_Order().getDateAcct();
							MOrderLandedCostAllocation[] allocations = MOrderLandedCostAllocation.getOfOrderLine(iol.getC_OrderLine_ID(), getTrxName());
							for(MOrderLandedCostAllocation allocation : allocations)
							{
								if (allocation.getC_OrderLandedCost().getM_CostElement_ID() != lca.getM_CostElement_ID())
									continue;
								
								BigDecimal amt = allocation.getAmt();
								BigDecimal qty = allocation.getQty();
								if (qty.compareTo(iol.getMovementQty()) != 0)
								{
									amt = amt.multiply(iol.getMovementQty()).divide(qty, 12, RoundingMode.HALF_UP);
								}
								estimatedAmt = estimatedAmt.add(amt); 
							}
						}
					}
					
					if (estimatedAmt.scale() > as.getCostingPrecision())
					{
						estimatedAmt = estimatedAmt.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
					}
					costAdjustmentAmt = allocationAmt;
					if (estimatedAmt.signum() > 0)
					{					
						//get other allocation amt
						StringBuilder sql = new StringBuilder("SELECT Sum(Amt) FROM C_LandedCostAllocation WHERE M_InOutLine_ID=? ")
							.append("AND C_LandedCostAllocation_ID<>? ")
							.append("AND M_CostElement_ID=? ")
							.append("AND AD_Client_ID=? ");
						BigDecimal otherAmt = DB.getSQLValueBD(getTrxName(), sql.toString(), lca.getM_InOutLine_ID(), lca.getC_LandedCostAllocation_ID(), 
								lca.getM_CostElement_ID(), lca.getAD_Client_ID());
						if (otherAmt != null) 
						{
							estimatedAmt = estimatedAmt.subtract(otherAmt);
						}	
						//added for IDEMPIERE-3014
						//convert to accounting schema currency
						if (estimatedAmt.signum() > 0 && oCurrencyId != getC_Currency_ID())
						{
							estimatedAmt = MConversionRate.convert(getCtx(), estimatedAmt,
									oCurrencyId, as.getC_Currency_ID(),
									oDateAcct, getC_ConversionType_ID(),
									getAD_Client_ID(), getAD_Org_ID());
	
							allocationAmt = MConversionRate.convert(getCtx(), allocationAmt,
									getC_Currency_ID(), as.getC_Currency_ID(),
									getDateAcct(), getC_ConversionType_ID(),
									getAD_Client_ID(), getAD_Org_ID());
							setC_Currency_ID(as.getC_Currency_ID());
							usesSchemaCurrency = true;
						}
	
						if (estimatedAmt.signum() > 0)
						{						
							costAdjustmentAmt = allocationAmt.subtract(estimatedAmt);
						}
					}
					
					if (!dr)
						costAdjustmentAmt = costAdjustmentAmt.negate();
				}
	
				BigDecimal amtAsset = Env.ZERO;
				BigDecimal amtVariance = Env.ZERO;
				BigDecimal costDetailQty = lca.getQty();
				if (costAdjustmentAmt.signum() != 0 && !reversal)
				{
					Trx trx = Trx.get(getTrxName(), false);
					Savepoint savepoint = null;					
					try {
						savepoint = trx.setSavepoint(null);
						
						amtVariance = Env.ZERO;
						amtAsset = costAdjustmentAmt;
						
						if(X_M_Cost.COSTINGMETHOD_AveragePO.equals(costingMethod))
						{
							int AD_Org_ID = lca.getAD_Org_ID();
							int M_AttributeSetInstance_ID = lca.getM_AttributeSetInstance_ID();

							if (MAcctSchema.COSTINGLEVEL_Client.equals(as.getCostingLevel()))
							{
								AD_Org_ID = 0;
								M_AttributeSetInstance_ID = 0;
							}
							else if (MAcctSchema.COSTINGLEVEL_Organization.equals(as.getCostingLevel()))
								M_AttributeSetInstance_ID = 0;
							else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(as.getCostingLevel()))
								AD_Org_ID = 0;
							
							MCostDetail cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), M_AttributeSetInstance_ID, 
									C_InvoiceLine_ID, lca.getM_CostElement_ID(), getDateAcct(), getTrxName());
							MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), as.getCostingMethod(),
									AD_Org_ID);
							ICostInfo c = MCost.getCostInfo(getCtx(), getAD_Client_ID(), AD_Org_ID, lca.getM_Product_ID(),
									as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getM_CostElement_ID(),
									M_AttributeSetInstance_ID, 
									getDateAcct(), cd, getTrxName());
							String key = getAD_Client_ID() + "_" + lca.getM_Product_ID() + "_" 
									+ as.getM_CostType_ID() + "_" + as.getC_AcctSchema_ID() + "_" + ce.getM_CostElement_ID() + "_" 
									+ M_AttributeSetInstance_ID;
							if (c != null)
							{
								BigDecimal mcostQty = c.getCurrentQty();
								if (mcostQtyMap.containsKey(key)) {
									mcostQty = mcostQty.subtract(mcostQtyMap.get(key));
									if (mcostQty.signum() < 0)
										mcostQty = new BigDecimal("0.00");
								}
								if (mcostQty.compareTo(lca.getQty()) < 0) {
									amtAsset = mcostQty.multiply(costAdjustmentAmt.divide(lca.getQty(), as.getCostingPrecision(), RoundingMode.HALF_UP));
									amtVariance = costAdjustmentAmt.subtract(amtAsset);
									costDetailQty = mcostQty;									
								}
								if (mcostQtyMap.containsKey(key)) {
									mcostQtyMap.put(key, mcostQtyMap.get(key).add(costDetailQty));
								} else {
									mcostQtyMap.put(key, costDetailQty);
								}
							}
						}
						
						BigDecimal costDetailAmt = amtAsset;
						//convert to accounting schema currency
						if (getC_Currency_ID() != as.getC_Currency_ID())
							costDetailAmt = MConversionRate.convert(getCtx(), costDetailAmt,
								getC_Currency_ID(), as.getC_Currency_ID(),
								getDateAcct(), getC_ConversionType_ID(),
								getAD_Client_ID(), getAD_Org_ID());
						if (costDetailAmt.scale() > as.getCostingPrecision())
							costDetailAmt = costDetailAmt.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
						
						String key = lca.getM_Product_ID()+"_"+lca.getM_AttributeSetInstance_ID();
						BigDecimal prevAmt = costDetailAmtMap.remove(key);
						if (prevAmt != null) {
							costDetailAmt = costDetailAmt.add(prevAmt);
						}
						costDetailAmtMap.put(key, costDetailAmt);
						int Ref_CostDetail_ID = 0;
						if (reversalLine != null && reversalLine.get_ID() > 0 && C_InvoiceLine_ID > reversalLine.get_ID())
						{
							MCostDetail cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), lca.getM_AttributeSetInstance_ID(),
									reversalLine.get_ID(), lca.getM_CostElement_ID(), reversalLine.getParent().getDateAcct(), getTrxName());
							if (cd != null)
								Ref_CostDetail_ID = cd.getM_CostDetail_ID();
						}
						// cost detail record is required for costing-relevant transaction
						if (!MCostDetail.createInvoice(as, lca.getAD_Org_ID(),
								lca.getM_Product_ID(), lca.getM_AttributeSetInstance_ID(),
								C_InvoiceLine_ID, lca.getM_CostElement_ID(),
								costDetailAmt, costDetailQty,
								desc, getDateAcct(), Ref_CostDetail_ID, getTrxName())) {
							throw new RuntimeException("Failed to create cost detail record.");
						}				
					} catch (SQLException e) {
						throw new RuntimeException(e.getLocalizedMessage(), e);
					} catch (AverageCostingZeroQtyException e) {
						try { 
							amtAsset = BigDecimal.ZERO;
							amtVariance = costAdjustmentAmt;
							trx.rollback(savepoint);
							savepoint = null;
						} catch (SQLException e1) {
							throw new RuntimeException(e1.getLocalizedMessage(), e1);
						}
					} finally {
						if (savepoint != null) {
							try {
								trx.releaseSavepoint(savepoint);
							} catch (SQLException e) {
								log.log(Level.WARNING, e.getMessage(), e);
							}
						}
					}
				} else if (reversal) {
					costDetailQty = BigDecimal.ZERO;
					int AD_Org_ID = lca.getAD_Org_ID();
					int M_AttributeSetInstance_ID = lca.getM_AttributeSetInstance_ID();

					if (MAcctSchema.COSTINGLEVEL_Client.equals(as.getCostingLevel()))
					{
						AD_Org_ID = 0;
						M_AttributeSetInstance_ID = 0;
					}
					else if (MAcctSchema.COSTINGLEVEL_Organization.equals(as.getCostingLevel()))
						M_AttributeSetInstance_ID = 0;
					else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(as.getCostingLevel()))
						AD_Org_ID = 0;
					String key = lca.getM_Product_ID()+"_"+M_AttributeSetInstance_ID;
					if (!costDetailAmtMap.containsKey(key)) {
						costDetailAmtMap.put(key, BigDecimal.ZERO);
						amtAsset = BigDecimal.ZERO;
						amtVariance = BigDecimal.ZERO;
						MAccount varianceAccount = pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
						MAccount assetAccount = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
						Query query = MFactAcct.createRecordIdQuery(MInvoice.Table_ID, reversalLine.getC_Invoice_ID(), as.getC_AcctSchema_ID(), getTrxName());
						List<MFactAcct> factAccts = query.list();
						for(MFactAcct factAcct : factAccts) {
							if (factAcct.getM_Product_ID() != lca.getM_Product_ID())
								continue;
							if (factAcct.getLine_ID() != reversalLine.get_ID())
								continue;
							if (factAcct.getAccount_ID() == assetAccount.getAccount_ID()) {
								if (factAcct.getAmtAcctDr().signum() != 0)
									amtAsset = amtAsset.add(factAcct.getAmtAcctDr());
								else if (factAcct.getAmtAcctCr().signum() != 0)
									amtAsset = amtAsset.subtract(factAcct.getAmtAcctCr());
							} else if (factAcct.getAccount_ID() == varianceAccount.getAccount_ID()) {
								if (factAcct.getAmtAcctDr().signum() != 0)
									amtVariance = amtVariance.add(factAcct.getAmtAcctDr());
								else if (factAcct.getAmtAcctCr().signum() != 0)
									amtVariance = amtVariance.subtract(factAcct.getAmtAcctCr());
							}
						}
						if (lca.getM_AttributeSetInstance_ID() > 0 && M_AttributeSetInstance_ID == 0) {
							String sql = 
									"""
										SELECT SUM(Qty)
										FROM M_CostDetail
										WHERE C_InvoiceLine_ID=? AND Coalesce(M_CostElement_ID,0)=?
										AND M_Product_ID=? AND C_AcctSchema_ID=? 										
									""";
							costDetailQty = DB.getSQLValueBDEx(getTrxName(), sql, reversalLine.get_ID(), lca.getM_CostElement_ID(), lca.getM_Product_ID(), as.getC_AcctSchema_ID());
							if (costDetailQty == null)
								costDetailQty = BigDecimal.ZERO;
						} else if (lca.getM_AttributeSetInstance_ID() > 0 && M_AttributeSetInstance_ID > 0) {
							MCostDetail cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), lca.getM_AttributeSetInstance_ID(), 
									reversalLine.get_ID(), lca.getM_CostElement_ID(), reversalLine.getParent().getDateAcct(), getTrxName());
							costDetailQty = cd != null ? cd.getQty() : BigDecimal.ZERO;
							if (cd != null) {
								amtAsset = cd.getAmt();
							}
							if (i > 0) {
								for(int j = 0; j < i; j++) {
									if (lcas[j].getM_Product_ID() == lca.getM_Product_ID()) {
										//variance have been posted by product
										amtVariance = BigDecimal.ZERO;
									}
								}
							}
						} else {
							MCostDetail cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), lca.getM_AttributeSetInstance_ID(), 
									reversalLine.get_ID(), lca.getM_CostElement_ID(), reversalLine.getParent().getDateAcct(), getTrxName());
							costDetailQty = cd != null ? cd.getQty() : BigDecimal.ZERO;
						}
						if (costDetailQty.signum() != 0)
						{
							MCostDetail cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), M_AttributeSetInstance_ID, 
									C_InvoiceLine_ID, lca.getM_CostElement_ID(), getDateAcct(), getTrxName());
							if (cd == null)
								cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), M_AttributeSetInstance_ID, 
									reversalLine.get_ID(), lca.getM_CostElement_ID(), getDateAcct(), getTrxName());
							MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), as.getCostingMethod(),
									AD_Org_ID);
  							ICostInfo c = MCost.getCostInfo(getCtx(), getAD_Client_ID(), AD_Org_ID, lca.getM_Product_ID(),
									as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getM_CostElement_ID(),
									M_AttributeSetInstance_ID, 
									getDateAcct(), cd, getTrxName());
							if (c != null) {
								if (c.getCurrentQty().signum() == 0) {
									amtVariance = amtVariance.add(amtAsset);
									amtAsset = BigDecimal.ZERO;
								} else if (c.getCurrentQty().compareTo(costDetailQty) < 0) {
									BigDecimal currentAmtAsset = amtAsset;
									amtAsset = amtAsset.divide(costDetailQty, 12, RoundingMode.HALF_UP).multiply(c.getCurrentQty());
									amtVariance = amtVariance.add(currentAmtAsset.subtract(amtAsset));
									costDetailQty = c.getCurrentQty();
								}
							}
						}
						int Ref_CostDetail_ID = 0;
						if (reversalLine != null && reversalLine.get_ID() > 0 && C_InvoiceLine_ID > reversalLine.get_ID())
						{
							MCostDetail cd = MCostDetail.getInvoice(as, lca.getM_Product_ID(), lca.getM_AttributeSetInstance_ID(),
									reversalLine.get_ID(), lca.getM_CostElement_ID(), reversalLine.getParent().getDateAcct(), getTrxName());
							if (cd != null)
								Ref_CostDetail_ID = cd.getM_CostDetail_ID();
						}
						// cost detail record is required for costing-relevant transaction
						if (!MCostDetail.createInvoice(as, lca.getAD_Org_ID(),
								lca.getM_Product_ID(), lca.getM_AttributeSetInstance_ID(),
								C_InvoiceLine_ID, lca.getM_CostElement_ID(),
								amtAsset.negate(), costDetailQty,
								desc, getDateAcct(), Ref_CostDetail_ID, getTrxName())) {
							throw new RuntimeException("Failed to create cost detail record.");
						}
						if (getC_Currency_ID() != as.getC_Currency_ID()) {
							usesSchemaCurrency = true;
							setC_Currency_ID(as.getC_Currency_ID());
						}
					}
				}
								
				if (allocationAmt.signum() > 0 && !reversal)
				{
					if (allocationAmt.scale() > as.getStdPrecision())
					{
						allocationAmt = allocationAmt.setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
					}
					if (estimatedAmt.scale() > as.getStdPrecision())
					{
						estimatedAmt = estimatedAmt.setScale(as.getStdPrecision(), RoundingMode.HALF_UP);
					}
					if (allocationAmt.compareTo(estimatedAmt)!=0)
					{
						if (estimatedAmt.signum() != 0)
						{
							drAmt = dr ? (reversal ? null : estimatedAmt): (reversal ? estimatedAmt : null);
							crAmt = dr ? (reversal ? estimatedAmt : null): (reversal ? null : estimatedAmt);						
							account = pc.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
							FactLine fl = fact.createLine (line, account, getC_Currency_ID(), drAmt, crAmt);
							fl.setDescription(desc);
							fl.setM_Product_ID(lca.getM_Product_ID());
							fl.setQty(line.getQty());
						}
						
						if (amtVariance.signum() != 0) {
							if (amtVariance.signum() > 0) {
								drAmt = dr ? amtVariance : null;
								crAmt = dr ? null : amtVariance;
							} else {
								BigDecimal underAmt = amtVariance.negate();
								drAmt = dr ? null : underAmt;
								crAmt = dr ? underAmt : null;
							}

							account = pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
							FactLine fl = fact.createLine(line, account, getC_Currency_ID(), drAmt, crAmt);
							fl.setDescription(desc);
							fl.setM_Product_ID(lca.getM_Product_ID());
							fl.setQty(line.getQty());
						}

						if (amtAsset.signum() != 0) {
							if (amtAsset.signum() > 0) {
								drAmt = dr ? amtAsset : null;
								crAmt = dr ? null : amtAsset;
							} else {
								BigDecimal underAmt = amtAsset.negate();
								drAmt = dr ? null : underAmt;
								crAmt = dr ? underAmt : null;
							}
							account = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
							FactLine  fl = fact.createLine(line, account, getC_Currency_ID(), drAmt, crAmt);
							fl.setDescription(desc);
							fl.setM_Product_ID(lca.getM_Product_ID());
							fl.setQty(line.getQty());
						}
					}
					else if (allocationAmt.signum() != 0)
					{
						drAmt = dr ? (reversal ? null : allocationAmt) : (reversal ? allocationAmt : null);
						crAmt = dr ? (reversal ? allocationAmt : null) : (reversal ? null : allocationAmt);
						account = pc.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
						FactLine fl = fact.createLine (line, account, getC_Currency_ID(), drAmt, crAmt);
						fl.setDescription(desc);
						fl.setM_Product_ID(lca.getM_Product_ID());
						fl.setQty(line.getQty());
					}
				} else if (reversal) {
					account = pc.getAccount(ProductCost.ACCTTYPE_P_LandedCostClearing, as);
					FactLine fl = fact.createLine (line, account, getC_Currency_ID(), BigDecimal.ZERO, BigDecimal.ZERO);
					fl.updateReverseLine(MInvoice.Table_ID, reversalLine.getC_Invoice_ID(), reversalLine.get_ID(), BigDecimal.ONE);
					if (fl.getAmtAcctCr().signum() == 0 && fl.getAmtAcctDr().signum() == 0)
						fact.remove(fl);
					
					if (amtVariance.signum() != 0) {
						if (amtVariance.signum() > 0) {
							drAmt = dr ? null : amtVariance;
							crAmt = dr ? amtVariance : null;
						} else {
							BigDecimal underAmt = amtVariance.negate();
							drAmt = dr ? underAmt : null;
							crAmt = dr ? null : underAmt;
						}

						account = pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
						fl = fact.createLine(line, account, getC_Currency_ID(), drAmt, crAmt);
						fl.setDescription(desc);
						fl.setM_Product_ID(lca.getM_Product_ID());
						fl.setQty(line.getQty());
					}

					if (amtAsset.signum() != 0) {
						if (amtAsset.signum() > 0) {
							drAmt = dr ? null : amtAsset;
							crAmt = dr ? amtAsset : null;
						} else {
							BigDecimal underAmt = amtAsset.negate();
							drAmt = dr ? underAmt : null;
							crAmt = dr ? null : underAmt;
						}
						account = pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
						fl = fact.createLine(line, account, getC_Currency_ID(), drAmt, crAmt);
						fl.setDescription(desc);
						fl.setM_Product_ID(lca.getM_Product_ID());
						fl.setQty(line.getQty());
					}
				}
				if (usesSchemaCurrency)
					setC_Currency_ID(line.getC_Currency_ID());
			} 
			else 
			{
				if (dr)
					drAmt = lca.getAmt();
				else
					crAmt = lca.getAmt();
				account = pc.getAccount(ProductCost.ACCTTYPE_P_CostAdjustment, as);
				FactLine fl = fact.createLine (line, account, getC_Currency_ID(), drAmt, crAmt);
				fl.setDescription(desc);
				fl.setM_Product_ID(lca.getM_Product_ID());
				fl.setQty(line.getQty());
			}
		}

		if (log.isLoggable(Level.CONFIG)) log.config("Created #" + lcas.length);
		return true;
	}	//	landedCosts

	/**
	 * 	Update ProductPO PriceLastInv
	 *	@param as accounting schema
	 */
	protected void updateProductPO (MAcctSchema as)
	{
		MClientInfo ci = MClientInfo.get(getCtx(), as.getAD_Client_ID());
		if (ci.getC_AcctSchema1_ID() != as.getC_AcctSchema_ID())
			return;

		StringBuilder sql = new StringBuilder (
			"UPDATE M_Product_PO po ")
			 .append("SET PriceLastInv = ")
			//	select
			.append("(SELECT currencyConvertInvoice(i.C_Invoice_ID,po.C_Currency_ID,il.PriceActual,i.DateInvoiced) ")
			.append("FROM C_Invoice i, C_InvoiceLine il ")
			.append("WHERE i.C_Invoice_ID=il.C_Invoice_ID")
			.append(" AND po.M_Product_ID=il.M_Product_ID AND po.C_BPartner_ID=i.C_BPartner_ID");
			if (DB.isOracle()) //jz
			{
				sql.append(" AND ROWNUM=1 ");
			}
			else
			{
				sql.append(" AND il.C_InvoiceLine_ID = (SELECT MIN(il1.C_InvoiceLine_ID) ")
						.append("FROM C_Invoice i1, C_InvoiceLine il1 ")
						.append("WHERE i1.C_Invoice_ID=il1.C_Invoice_ID")
						.append(" AND po.M_Product_ID=il1.M_Product_ID AND po.C_BPartner_ID=i1.C_BPartner_ID")
						.append("  AND i1.C_Invoice_ID=").append(get_ID()).append(") ");
			}
			sql.append("  AND i.C_Invoice_ID=").append(get_ID()).append(") ")
			//	update
			.append("WHERE EXISTS (SELECT * ")
			.append("FROM C_Invoice i, C_InvoiceLine il ")
			.append("WHERE i.C_Invoice_ID=il.C_Invoice_ID")
			.append(" AND po.M_Product_ID=il.M_Product_ID AND po.C_BPartner_ID=i.C_BPartner_ID")
			.append(" AND i.C_Invoice_ID=").append(get_ID()).append(")");
		int no = DB.executeUpdate(sql.toString(), getTrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Updated=" + no);
	}	//	updateProductPO

	@Override
	public BigDecimal getCurrencyRate() {
		if (getC_Currency_ID() == getAcctSchema().getC_Currency_ID())
			return null;
		
		MInvoice inv = (MInvoice)getPO();
		int baseCurrencyId = MClientInfo.get(getCtx(), inv.getAD_Client_ID()).getC_Currency_ID();
		if (baseCurrencyId != getAcctSchema().getC_Currency_ID())
			return null;
		
		if (inv.isOverrideCurrencyRate()) {
			return inv.getCurrencyRate();
		} else {
			return null;
		}		
	}	
	
	@Override
	public boolean isConvertible (MAcctSchema acctSchema) {
		MInvoice inv = (MInvoice)getPO();
		if (inv.getC_Currency_ID() != acctSchema.getC_Currency_ID()) {
			int baseCurrencyId = MClientInfo.get(getCtx(), inv.getAD_Client_ID()).getC_Currency_ID();
			if (baseCurrencyId == acctSchema.getC_Currency_ID() && inv.isOverrideCurrencyRate()) {
				return true;
			}
		}
		
		return super.isConvertible(acctSchema);
	}
	
}   //  Doc_Invoice
