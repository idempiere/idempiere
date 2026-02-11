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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.base.acct.AcctInfoServices;
import org.adempiere.base.acct.constants.IAcctSchemaElementConstants;
import org.adempiere.base.acct.constants.IFactAcctConstants;
import org.adempiere.base.acct.info.IAccountInfo;
import org.adempiere.base.acct.info.IAcctSchemaElementInfo;
import org.adempiere.base.acct.info.IAcctSchemaInfo;
import org.adempiere.base.acct.info.IDistributionInfo;
import org.adempiere.base.acct.info.IDistributionLineInfo;
import org.adempiere.base.acct.info.IElementValueInfo;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 *  Accounting Fact for {@link Doc}.<br/>
 *  Create and save one or more {@link FactLine} for an accounting document.
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: Fact.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
 *  
 *  BF [ 2789949 ] Multicurrency in matching posting
 */
public final class Fact
{	
	/**
	 *	Constructor
	 *  @param  document    pointer to document
	 *  @param  acctSchema  Account Schema to create accounts
	 *  @param  defaultPostingType  the default Posting type (actual,..) for this posting
	 */
	public Fact (Doc document, IAcctSchemaInfo acctSchema, String defaultPostingType)
	{
		m_doc = document;
		m_acctSchema = acctSchema;
		m_postingType = defaultPostingType;
		// Fix [ 1884676 ] Fact not setting transaction
		m_trxName = document.getTrxName();
		//
		if (log.isLoggable(Level.CONFIG)) log.config(toString());
	}	//	Fact

	/**	Log					*/
	private static final CLogger	log = CLogger.getCLogger(Fact.class);

	/** Document            */
	private Doc             m_doc = null;
	/** Accounting Schema   */
	private IAcctSchemaInfo	    m_acctSchema = null;
	/** Transaction			*/
	private String m_trxName;

	/** Posting Type        */
	private String		    m_postingType = null;

	/** Actual Balance Type */
	public static final String	POST_Actual = IFactAcctConstants.POSTINGTYPE_Actual;
	/** Budget Balance Type */
	public static final String	POST_Budget = IFactAcctConstants.POSTINGTYPE_Budget;
	/** Encumbrance Posting */
	public static final String	POST_Commitment = IFactAcctConstants.POSTINGTYPE_Commitment;
	/** Encumbrance Posting */
	public static final String	POST_Reservation = IFactAcctConstants.POSTINGTYPE_Reservation;

	/** Is Converted        */
	private boolean		    m_converted = false;

	/** Lines               */
	private ArrayList<FactLine>	m_lines = new ArrayList<FactLine>();

	/**
	 *  Dispose
	 */
	public void dispose()
	{
		m_lines.clear();
		m_lines = null;
	}   //  dispose

	/**
	 *	Create and convert Fact Line.
	 *  Used to create a DR and/or CR entry
	 *
	 *	@param  docLine     the document line or null
	 *  @param  account     if null, line is not created
	 *  @param  C_Currency_ID   the currency
	 *  @param  debitAmt    debit amount, can be null
	 *  @param  creditAmt  credit amount, can be null
	 *  @return Fact Line
	 */
	public FactLine createLine (DocLine docLine, IAccountInfo account,
		int C_Currency_ID, BigDecimal debitAmt, BigDecimal creditAmt)
	{
		//  Data Check
		if (account == null)
		{
			if (log.isLoggable(Level.INFO)) log.info("No account for " + docLine 
				+ ": Amt=" + debitAmt + "/" + creditAmt 
				+ " - " + toString());			
			return null;
		}
		//
		FactLine line = new FactLine (m_doc.getCtx(), m_doc.get_Table_ID(), 
			m_doc.get_ID(),
			docLine == null ? 0 : docLine.get_ID(), m_trxName);
		//  Set Info & Account
		line.setDocumentInfo(m_doc, docLine);
		line.setDocumentTextInfo(m_acctSchema);
		line.getFactAcctInfo().getRecord().setPostingType(m_postingType);
		line.setAccount(m_acctSchema, account);

		//  Amounts - one needs to not zero
		if (!line.setAmtSource(C_Currency_ID, debitAmt, creditAmt))
		{
			if (docLine == null || docLine.getQty() == null || docLine.getQty().signum() == 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Both amounts & qty = 0/Null - " + docLine		
					+ " - " + toString());			
				return null;
			}
			if (log.isLoggable(Level.FINE)) log.fine("Both amounts = 0/Null, Qty=" + docLine.getQty() + " - " + docLine		
				+ " - " + toString());			
		}
		//  Convert
		line.convert();
		//  Optionally overwrite Acct Amount
		if (docLine != null 
			&& (docLine.getAmtAcctDr() != null || docLine.getAmtAcctCr() != null))
			line.setAmtAcct(docLine.getAmtAcctDr(), docLine.getAmtAcctCr());
		//
		if (log.isLoggable(Level.FINE)) log.fine(line.toString());
		add(line);
		return line;
	}	//	createLine

	/**
	 *  Add Fact Line
	 *  @param line fact line
	 */
	public void add (FactLine line)
	{
		m_lines.add(line);
	}   //  add

	/**
	 *  Remove Fact Line
	 *  @param line fact line
	 */
	public void remove (FactLine line)
	{
		m_lines.remove(line);
	}   //  remove

	/**
	 *	Create and convert Fact Line.
	 *  Used to create either a DR or CR entry
	 *
	 *	@param  docLine     Document Line or null
	 *  @param  accountDr   Account to be used if Amt is DR balance
	 *  @param  accountCr   Account to be used if Amt is CR balance
	 *  @param  C_Currency_ID Currency
	 *  @param  Amt if negative Cr else Dr
	 *  @return FactLine
	 */
	public FactLine createLine (DocLine docLine, IAccountInfo accountDr, IAccountInfo accountCr,
		int C_Currency_ID, BigDecimal Amt)
	{
		if (Amt.signum() < 0)
			return createLine (docLine, accountCr, C_Currency_ID, null, Amt.abs());
		else
			return createLine (docLine, accountDr, C_Currency_ID, Amt, null);
	}   //  createLine

	/**
	 *	Create and convert Fact Line.
	 *  Used to create either a DR or CR entry
	 *
	 *	@param  docLine Document line or null
	 *  @param  account   Account to be used
	 *  @param  C_Currency_ID Currency
	 *  @param  Amt if negative Cr else Dr
	 *  @return FactLine
	 */
	public FactLine createLine (DocLine docLine, IAccountInfo account,
		int C_Currency_ID, BigDecimal Amt)
	{
		if (Amt.signum() < 0)
			return createLine (docLine, account, C_Currency_ID, null, Amt.abs());
		else
			return createLine (docLine, account, C_Currency_ID, Amt, null);
	}   //  createLine

	/**
	 *  Is Posting Type
	 *  @param  PostingType - see POST_*
	 *  @return true if document is posting type
	 */
	public boolean isPostingType (String PostingType)
	{
		return m_postingType.equals(PostingType);
	}   //  isPostingType

	/**
	 *	Is converted
	 *  @return true if converted
	 */
	public boolean isConverted()
	{
		return m_converted;
	}	//	isConverted

	/**
	 *	Get AcctSchema
	 *  @return AcctSchema
	 */
	public IAcctSchemaInfo getAcctSchema()
	{
		return m_acctSchema;
	}	//	getAcctSchema
	
	/**
	 *	Are the lines Source Balanced
	 *  @return true if source lines balanced
	 */
	public boolean isSourceBalanced()
	{
		//AZ Goodwill
		//  Multi-Currency documents are source balanced by definition
		//  No lines -> balanced
		if (m_lines.size() == 0 || m_doc.isMultiCurrency())
			return true;
		
		// If there is more than 1 currency in fact lines, it is a multi currency doc
		ArrayList<Integer> list = new ArrayList<Integer>();
		for (int i = 0; i < m_lines.size(); i++){
			FactLine line = (FactLine)m_lines.get(i);
			if (line.getFactAcctInfo().getRecord().getC_Currency_ID() > 0 && !list.contains(line.getFactAcctInfo().getRecord().getC_Currency_ID()))
				list.add(line.getFactAcctInfo().getRecord().getC_Currency_ID());
	
		}
		if (list.size() > 1 )
			return true;
				
		BigDecimal balance = getSourceBalance();
		boolean retValue = balance.signum() == 0;
		if (retValue) {
			if (log.isLoggable(Level.FINER)) log.finer(toString());
		} else {
			log.warning ("NO - Diff=" + balance + " - " + toString());
		}
		return retValue;
	}	//	isSourceBalanced

	/**
	 *	Get Source Balance Amount
	 *  @return source balance
	 */
	protected BigDecimal getSourceBalance()
	{
		BigDecimal result = Env.ZERO;
		for (int i = 0; i < m_lines.size(); i++)
		{
			FactLine line = (FactLine)m_lines.get(i);
			result = result.add (line.getSourceBalance());
		}
	//	log.fine("getSourceBalance - " + result.toString());
		return result;
	}	//	getSourceBalance

	/**
	 *	Create Source Line for Suspense Balancing.<br/>
	 *  Only if Suspense Balancing is enabled and not a multi-currency document
	 *  (double check as, otherwise the rule should not have fired). <br/>
	 *  If not balanced, create balancing entry in currency of the document.
	 *  @return Balancing FactLine or null
	 */
	public FactLine balanceSource()
	{
		if (!m_acctSchema.isSuspenseBalancing() || m_doc.isMultiCurrency())
			return null;
		BigDecimal diff = getSourceBalance();
		if (log.isLoggable(Level.FINER)) log.finer("Diff=" + diff);

		//  new line
		FactLine line = new FactLine (m_doc.getCtx(), m_doc.get_Table_ID(), 
			m_doc.get_ID(), 0, m_trxName);
		line.setDocumentInfo(m_doc, null);
		line.setDocumentTextInfo(m_acctSchema);
		line.getFactAcctInfo().getRecord().setAD_Org_ID(m_doc.getAD_Org_ID());
		line.getFactAcctInfo().getRecord().setPostingType(m_postingType);

		//	Account
		line.setAccount(m_acctSchema, m_acctSchema.getSuspenseBalancing_AcctInfo());

		//  Amount
		if (diff.signum() < 0)   //  negative balance => DR
			line.setAmtSource(m_doc.getC_Currency_ID(), diff.abs(), Env.ZERO);
		else                                //  positive balance => CR
			line.setAmtSource(m_doc.getC_Currency_ID(), Env.ZERO, diff);
			
		//  Convert
		line.convert();
		//
		if (log.isLoggable(Level.FINE)) log.fine(line.toString());
		m_lines.add(line);
		return line;
	}   //  balancingSource
	
	/**
	 *  Are all segments balanced
	 *  @return true if segments are balanced
	 */
	public boolean isSegmentBalanced()
	{
		//  No lines -> balanced
		if (m_lines.size() == 0)
			return true;
		
		IAcctSchemaElementInfo[] elements = m_acctSchema.getAcctSchemaElementsInfo();
		//  check all balancing segments
		for (int i = 0; i < elements.length; i++)
		{
			IAcctSchemaElementInfo ase = elements[i];
			if (ase.getRecord().isBalanced() && !isSegmentBalanced (ase.getRecord().getElementType()))
				return false;
		}
		return true;
	}   //  isSegmentBalanced

	/**
	 *  Is Source Segment balanced.
	 *  @param  segmentType - see AcctSchemaElement.SEGMENT_*.<br/>
	 *  Implemented only for Org.
	 *  Other sensible candidates are Project, User1/2.
	 *  @return true if segments are balanced
	 */
	public boolean isSegmentBalanced (String segmentType)
	{
		if (segmentType.equals(IAcctSchemaElementConstants.ELEMENTTYPE_Organization))
		{
			HashMap<Integer,BigDecimal> map = new HashMap<Integer,BigDecimal>();
			//  Add up values by organization
			for (int i = 0; i < m_lines.size(); i++)
			{
				FactLine line = (FactLine)m_lines.get(i);
				Integer key = Integer.valueOf(line.getAD_Org_ID());
				BigDecimal bal = line.getSourceBalance();
				BigDecimal oldBal = (BigDecimal)map.get(key);
				if (oldBal != null)
					bal = bal.add(oldBal);
				map.put(key, bal);
			}
			
			//  check if there are not balance entries involving multiple organizations
			Map<Integer, BigDecimal> notBalance = new HashMap<>();			
			for(Map.Entry<Integer, BigDecimal> entry : map.entrySet())
			{
				BigDecimal bal = entry.getValue();
				if (bal.signum() != 0)
				{
					notBalance.put(entry.getKey(), entry.getValue());
				}
			}
			
			if (notBalance.size() > 1)
			{
				return false;
			}
			
			if (log.isLoggable(Level.FINER)) log.finer("(" + segmentType + ") - " + toString());
			return true;
		}
		if (log.isLoggable(Level.FINER)) log.finer("(" + segmentType + ") (not checked) - " + toString());
		return true;
	}   //  isSegmentBalanced

	/**
	 *  Balance all segments.
	 *  - For all balancing segments
	 *      - For all segment values
	 *          - If balance &lt;&gt; 0 create dueTo/dueFrom line
	 *              overwriting the segment value
	 */
	public void balanceSegments()
	{
		IAcctSchemaElementInfo[] elements = m_acctSchema.getAcctSchemaElementsInfo();
		//  check all balancing segments
		for (int i = 0; i < elements.length; i++)
		{
			IAcctSchemaElementInfo ase = elements[i];
			if (ase.getRecord().isBalanced())
				balanceSegment (ase.getRecord().getElementType());
		}
	}   //  balanceSegments

	/**
	 *  Balance Source Segment
	 *  @param elementType segment element type
	 */
	private void balanceSegment (String elementType)
	{
		//  no lines -> balanced
		if (m_lines.size() == 0)
			return;

		if (log.isLoggable(Level.FINE)) log.fine ("(" + elementType + ") - " + toString());

		//  Org
		if (elementType.equals(IAcctSchemaElementConstants.ELEMENTTYPE_Organization))
		{
			HashMap<Integer,Balance> map = new HashMap<Integer,Balance>();
			//  Add up values by key
			for (int i = 0; i < m_lines.size(); i++)
			{
				FactLine line = (FactLine)m_lines.get(i);
				Integer key = Integer.valueOf(line.getAD_Org_ID());
				Balance oldBalance = (Balance)map.get(key);
				if (oldBalance == null)
				{
					oldBalance = new Balance (line.getFactAcctInfo().getRecord().getAmtSourceDr(), line.getFactAcctInfo().getRecord().getAmtSourceCr());
					map.put(key, oldBalance);
				}
				else
					oldBalance.add(line.getFactAcctInfo().getRecord().getAmtSourceDr(), line.getFactAcctInfo().getRecord().getAmtSourceCr());
			}

			//  Create entry for non-zero element
			Iterator<Integer> keys = map.keySet().iterator();
			while (keys.hasNext())
			{
				Integer key = keys.next();
				Balance difference = map.get(key);
				if (log.isLoggable(Level.INFO)) log.info (elementType + "=" + key + ", " + difference);
				//
				if (!difference.isZeroBalance())
				{
					//  Create Balancing Entry
					FactLine line = new FactLine (m_doc.getCtx(), m_doc.get_Table_ID(), 
						m_doc.get_ID(), 0, m_trxName);
					line.setDocumentInfo(m_doc, null);
					line.setDocumentTextInfo(m_acctSchema);
					line.getFactAcctInfo().getRecord().setPostingType(m_postingType);
					//  Amount & Account
					if (difference.getBalance().signum() < 0)
					{
						if (difference.isReversal())
						{
							line.setAccount(m_acctSchema, m_acctSchema.getDueTo_AcctInfo(elementType));
							line.setAmtSource(m_doc.getC_Currency_ID(), Env.ZERO, difference.getPostBalance());
						}
						else
						{
							line.setAccount(m_acctSchema, m_acctSchema.getDueFrom_AcctInfo(elementType));
							line.setAmtSource(m_doc.getC_Currency_ID(), difference.getPostBalance(), Env.ZERO);
						}
					}
					else
					{
						if (difference.isReversal())
						{
							line.setAccount(m_acctSchema, m_acctSchema.getDueFrom_AcctInfo(elementType));
							line.setAmtSource(m_doc.getC_Currency_ID(), difference.getPostBalance(), Env.ZERO);
						}
						else
						{
							line.setAccount(m_acctSchema, m_acctSchema.getDueTo_AcctInfo(elementType));
							line.setAmtSource(m_doc.getC_Currency_ID(), Env.ZERO, difference.getPostBalance());
						}
					}
					line.convert();
					line.getFactAcctInfo().getRecord().setAD_Org_ID(key.intValue());
					//
					m_lines.add(line);
					if (log.isLoggable(Level.FINE)) log.fine("(" + elementType + ") - " + line);
				}
			}
			map.clear();
		}
	}   //  balanceSegment
	
	/**
	 *	Are the lines Accounting Balanced
	 *  @return true if accounting lines are balanced
	 */
	public boolean isAcctBalanced()
	{
		//  no lines -> balanced
		if (m_lines.size() == 0)
			return true;
		BigDecimal balance = getAcctBalance();
		boolean retValue = balance.signum() == 0;
		if (retValue) {
			if (log.isLoggable(Level.FINER)) log.finer(toString());
		} else {
			log.warning("NO - Diff=" + balance + " - " + toString());
		}
		return retValue;
	}	//	isAcctBalanced

	/**
	 *	Return Accounting Balance
	 *  @return true if accounting lines are balanced
	 */
	protected BigDecimal getAcctBalance()
	{
		BigDecimal result = Env.ZERO;
		for (int i = 0; i < m_lines.size(); i++)
		{
			FactLine line = (FactLine)m_lines.get(i);
			result = result.add(line.getAcctBalance());
		}
		return result;
	}	//	getAcctBalance

	/**
	 *  Balance Accounting Currency.
	 *  <pre>
	 *  If the accounting currency is not balanced,
	 *      if Currency balancing is enabled
	 *          create a new line using the currency balancing account with zero source balance
	 *      or
	 *          adjust the line with the largest balance sheet account
	 *          or if no balance sheet account exist, the line with the largest amount
	 *  </pre>
	 *  @return FactLine
	 */
	public FactLine balanceAccounting()
	{
		BigDecimal diff = getAcctBalance();		//	DR-CR
		if (log.isLoggable(Level.FINE)) log.fine("Balance=" + diff 
			+ ", CurrBal=" + m_acctSchema.isCurrencyBalancing() 
			+ " - " + toString());
		FactLine line = null;

		BigDecimal BSamount = Env.ZERO;
		FactLine BSline = null;
		BigDecimal PLamount = Env.ZERO;
		FactLine PLline = null;

		//  Find line biggest BalanceSheet or P&L line
		for (int i = 0; i < m_lines.size(); i++)
		{
			FactLine l = (FactLine)m_lines.get(i);
			BigDecimal amt = l.getAcctBalance().abs();
			if (l.isBalanceSheet() && amt.compareTo(BSamount) > 0)
			{
				BSamount = amt;
				BSline = l;
			}
			else if (!l.isBalanceSheet() && amt.compareTo(PLamount) > 0)
			{
				PLamount = amt;
				PLline = l;
			}
		}
		
		//  Create Currency Balancing Entry
		if (m_acctSchema.isCurrencyBalancing())
		{
			line = new FactLine (m_doc.getCtx(), m_doc.get_Table_ID(), 
				m_doc.get_ID(), 0, m_trxName);
			line.setDocumentInfo (m_doc, null);
			line.setDocumentTextInfo(m_acctSchema);
			line.getFactAcctInfo().getRecord().setPostingType (m_postingType);
			line.getFactAcctInfo().getRecord().setAD_Org_ID(m_doc.getAD_Org_ID());
			line.setAccount (m_acctSchema, m_acctSchema.getCurrencyBalancing_AcctInfo());
			
			//  Amount
			line.setAmtSource(m_doc.getC_Currency_ID(), Env.ZERO, Env.ZERO);
			line.convert();
			//	Accounted
			BigDecimal drAmt = Env.ZERO;
			BigDecimal crAmt = Env.ZERO;
			boolean isDR = diff.signum() < 0;
			BigDecimal difference = diff.abs();
			if (isDR)
				drAmt = difference;
			else
				crAmt = difference;
			//	Switch sides
			boolean switchIt = BSline != null 
				&& ((BSline.isDrSourceBalance() && isDR)
					|| (!BSline.isDrSourceBalance() && !isDR));
			if (switchIt)
			{
				drAmt = Env.ZERO;
				crAmt = Env.ZERO;
				if (isDR)
					crAmt = difference.negate();
				else
					drAmt = difference.negate();
			}
			line.setAmtAcct(drAmt, crAmt);
			if (log.isLoggable(Level.FINE)) log.fine(line.toString());
			m_lines.add(line);
		}
		else	//  Adjust biggest (Balance Sheet) line amount
		{
			if (BSline != null)
				line = BSline;
			else
				line = PLline;
			if (line == null)
				log.severe ("No Line found");
			else
			{
				if (log.isLoggable(Level.FINE)) log.fine("Adjusting Amt=" + diff + "; Line=" + line);
				line.currencyCorrect(diff);
				if (log.isLoggable(Level.FINE)) log.fine(line.toString());
			}
		}   //  correct biggest amount

		return line;
	}   //  balanceAccounting

	/**
	 * 	Check Accounts of Fact Lines
	 *	@return true if success
	 */
	public boolean checkAccounts()
	{
		//  no lines -> nothing to distribute
		if (m_lines.size() == 0)
			return true;
		
		//	For all fact lines
		for (int i = 0; i < m_lines.size(); i++)
		{
			FactLine line = (FactLine)m_lines.get(i);
			IAccountInfo account = line.getAccount();
			if (account == null)
			{
				log.warning("No Account for " + line);
				return false;
			}
			IElementValueInfo ev = account.getAccountInfo();
			if (ev == null)
			{
				log.warning("No Element Value for " + account 
					+ ": " + line);
				m_doc.p_Error = account.toString();
				return false;
			}
			if (ev.getRecord().isSummary())
			{
				log.warning("Cannot post to Summary Account " + ev 
					+ ": " + line);
				m_doc.p_Error = ev.toString();
				return false;
			}
			if (!ev.getRecord().isActive())
			{
				log.warning("Cannot post to Inactive Account " + ev 
					+ ": " + line);
				m_doc.p_Error = ev.toString();
				return false;
			}

		}	//	for all lines
		
		return true;
	}	//	checkAccounts
	
	/**
	 * 	GL Distribution of Fact Lines
	 *	@return true if success
	 */
	public boolean distribute()
	{
		//  no lines -> nothing to distribute
		if (m_lines.size() == 0)
			return true;
		
		ArrayList<FactLine> newLines = new ArrayList<FactLine>();
		//	For all fact lines
		for (int i = 0; i < m_lines.size(); i++)
		{
			FactLine dLine = (FactLine)m_lines.get(i);
			IDistributionInfo[] distributions = AcctInfoServices.getDistributionInfoService().get (dLine.getFactAcctInfo().getPO().getCtx(), dLine.getFactAcctInfo().getRecord().getC_AcctSchema_ID(),
					m_postingType, m_doc.getC_DocType_ID(), dLine.getFactAcctInfo().getRecord().getDateAcct(),
					dLine.getAD_Org_ID(), dLine.getFactAcctInfo().getRecord().getAccount_ID(),
					dLine.getFactAcctInfo().getRecord().getM_Product_ID(), dLine.getFactAcctInfo().getRecord().getC_BPartner_ID(), dLine.getFactAcctInfo().getRecord().getC_Project_ID(),
					dLine.getFactAcctInfo().getRecord().getC_Campaign_ID(), dLine.getFactAcctInfo().getRecord().getC_Activity_ID(), dLine.getFactAcctInfo().getRecord().getAD_OrgTrx_ID(),
					dLine.getC_SalesRegion_ID(), dLine.getFactAcctInfo().getRecord().getC_LocTo_ID(), dLine.getFactAcctInfo().getRecord().getC_LocFrom_ID(),
					dLine.getFactAcctInfo().getRecord().getUser1_ID(), dLine.getFactAcctInfo().getRecord().getUser2_ID(), dLine.getFactAcctInfo().getRecord().getC_CostCenter_ID(),
					dLine.getFactAcctInfo().getRecord().getC_Department_ID(), dLine.getFactAcctInfo().getRecord().getC_Employee_ID(), dLine.getFactAcctInfo().getRecord().getC_Charge_ID(),
					dLine.getFactAcctInfo().getRecord().getA_Asset_ID(), dLine.getFactAcctInfo().getRecord().getM_Warehouse_ID(), dLine.getFactAcctInfo().getRecord().getM_AttributeSetInstance_ID());
			
			if (distributions == null || distributions.length == 0)
			{
				continue;
			}
			
			//	Just the first
			if (distributions.length > 1)
				log.warning("More than one Distribution for " + dLine.getAccount());
			IDistributionInfo distribution = distributions[0];

			// FR 2685367 - GL Distribution delete line instead reverse
			if (distribution.getRecord().isCreateReversal()) {
				//	Add Reversal
				FactLine reversal = dLine.reverse(distribution.getRecord().getName());
				if (log.isLoggable(Level.INFO)) log.info("Reversal=" + reversal);
				newLines.add(reversal);		//	saved in postCommit
			} else {
				// delete the line being distributed
				m_lines.remove(i);    // or it could be m_lines.remove(dLine);
				i--;
			}

			//	Prepare
			distribution.distribute(dLine.getAccount(), dLine.getSourceBalance(), dLine.getFactAcctInfo().getRecord().getQty(), dLine.getFactAcctInfo().getRecord().getC_Currency_ID());
			IDistributionLineInfo[] lines = distribution.getLinesInfo(false);
			for (int j = 0; j < lines.length; j++)
			{
				IDistributionLineInfo dl = lines[j];
				if (!dl.getRecord().isActive() || dl.getAmt().signum() == 0)
					continue;
				FactLine factLine = new FactLine (m_doc.getCtx(), m_doc.get_Table_ID(),
					m_doc.get_ID(), dLine.getFactAcctInfo().getRecord().getLine_ID(), m_trxName);
				//  Set Info & Account
				factLine.setDocumentInfo(m_doc, dLine.getDocLine());
				factLine.setDocumentTextInfo(m_acctSchema);
				factLine.getFactAcctInfo().getRecord().setDescription(dLine.getFactAcctInfo().getRecord().getDescription());
				factLine.setAccount(m_acctSchema, dl.getAccountInfo());
				factLine.getFactAcctInfo().getRecord().setPostingType(m_postingType);
				if (dl.getRecord().isOverwriteOrg())	//	set Org explicitly
					factLine.getFactAcctInfo().getRecord().setAD_Org_ID(dl.getRecord().getOrg_ID());
				else
					factLine.getFactAcctInfo().getRecord().setAD_Org_ID(dLine.getAD_Org_ID());
				// Silvano - freepath - F3P - Bug#2904994 Fact distribtution only overwriting Org
				if(dl.getRecord().isOverwriteAcct())
					factLine.getFactAcctInfo().getRecord().setAccount_ID(dl.getRecord().getAccount_ID());
				else
					factLine.getFactAcctInfo().getRecord().setAccount_ID(dLine.getFactAcctInfo().getRecord().getAccount_ID());
				if(dl.getRecord().isOverwriteActivity())
					factLine.getFactAcctInfo().getRecord().setC_Activity_ID(dl.getRecord().getC_Activity_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_Activity_ID(dLine.getFactAcctInfo().getRecord().getC_Activity_ID());
				if(dl.getRecord().isOverwriteBPartner())
					factLine.getFactAcctInfo().getRecord().setC_BPartner_ID(dl.getRecord().getC_BPartner_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_BPartner_ID(dLine.getFactAcctInfo().getRecord().getC_BPartner_ID());
				if(dl.getRecord().isOverwriteCampaign())
					factLine.getFactAcctInfo().getRecord().setC_Campaign_ID(dl.getRecord().getC_Campaign_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_Campaign_ID(dLine.getFactAcctInfo().getRecord().getC_Campaign_ID());
				if(dl.getRecord().isOverwriteLocFrom())
					factLine.getFactAcctInfo().getRecord().setC_LocFrom_ID(dl.getRecord().getC_LocFrom_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_LocFrom_ID(dLine.getFactAcctInfo().getRecord().getC_LocFrom_ID());
				if(dl.getRecord().isOverwriteLocTo())
					factLine.getFactAcctInfo().getRecord().setC_LocTo_ID(dl.getRecord().getC_LocTo_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_LocTo_ID(dLine.getFactAcctInfo().getRecord().getC_LocTo_ID());
				if(dl.getRecord().isOverwriteOrgTrx())
					factLine.getFactAcctInfo().getRecord().setAD_OrgTrx_ID(dl.getRecord().getAD_OrgTrx_ID());
				else
					factLine.getFactAcctInfo().getRecord().setAD_OrgTrx_ID(dLine.getFactAcctInfo().getRecord().getAD_OrgTrx_ID());
				if(dl.getRecord().isOverwriteProduct())
					factLine.getFactAcctInfo().getRecord().setM_Product_ID(dl.getRecord().getM_Product_ID());
				else
					factLine.getFactAcctInfo().getRecord().setM_Product_ID(dLine.getFactAcctInfo().getRecord().getM_Product_ID());
				if(dl.getRecord().isOverwriteProject())
					factLine.getFactAcctInfo().getRecord().setC_Project_ID(dl.getRecord().getC_Project_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_Project_ID(dLine.getFactAcctInfo().getRecord().getC_Project_ID());
				if(dl.getRecord().isOverwriteSalesRegion())
					factLine.getFactAcctInfo().getRecord().setC_SalesRegion_ID(dl.getRecord().getC_SalesRegion_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_SalesRegion_ID(dLine.getC_SalesRegion_ID());
				if(dl.getRecord().isOverwriteUser1())				
					factLine.getFactAcctInfo().getRecord().setUser1_ID(dl.getRecord().getUser1_ID());
				else
					factLine.getFactAcctInfo().getRecord().setUser1_ID(dLine.getFactAcctInfo().getRecord().getUser1_ID());
				if(dl.getRecord().isOverwriteUser2())				
					factLine.getFactAcctInfo().getRecord().setUser2_ID(dl.getRecord().getUser2_ID());					
				else
					factLine.getFactAcctInfo().getRecord().setUser2_ID(dLine.getFactAcctInfo().getRecord().getUser2_ID());
				
				if (dl.getRecord().isOverwriteAsset())
					factLine.getFactAcctInfo().getRecord().setA_Asset_ID(dl.getRecord().getA_Asset_ID());
				else
					factLine.getFactAcctInfo().getRecord().setA_Asset_ID(dLine.getFactAcctInfo().getRecord().getA_Asset_ID());
				
				if (dl.getRecord().isOverwriteCharge())
					factLine.getFactAcctInfo().getRecord().setC_Charge_ID(dl.getRecord().getC_Charge_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_Charge_ID(dLine.getFactAcctInfo().getRecord().getC_Charge_ID());
				
				if (dl.getRecord().isOverwriteCostCenter())
					factLine.getFactAcctInfo().getRecord().setC_CostCenter_ID(dl.getRecord().getC_CostCenter_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_CostCenter_ID(dLine.getFactAcctInfo().getRecord().getC_CostCenter_ID());
				
				if (dl.getRecord().isOverwriteDepartment())
					factLine.getFactAcctInfo().getRecord().setC_Department_ID(dl.getRecord().getC_Department_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_Department_ID(dLine.getFactAcctInfo().getRecord().getC_Department_ID());

				if (dl.getRecord().isOverwriteEmployee())
					factLine.getFactAcctInfo().getRecord().setC_Employee_ID(dl.getRecord().getC_Employee_ID());
				else
					factLine.getFactAcctInfo().getRecord().setC_Employee_ID(dLine.getFactAcctInfo().getRecord().getC_Employee_ID());
				
				if (dl.getRecord().isOverwriteWarehouse())
					factLine.getFactAcctInfo().getRecord().setM_Warehouse_ID(dl.getRecord().getM_Warehouse_ID());
				else
					factLine.getFactAcctInfo().getRecord().setM_Warehouse_ID(dLine.getFactAcctInfo().getRecord().getM_Warehouse_ID());
				factLine.getFactAcctInfo().getRecord().setUserElement1_ID(dLine.getFactAcctInfo().getRecord().getUserElement1_ID());
				factLine.getFactAcctInfo().getRecord().setUserElement2_ID(dLine.getFactAcctInfo().getRecord().getUserElement2_ID());
				// F3P end
				//
				if (dLine.getFactAcctInfo().getRecord().getAmtAcctCr().signum() != 0) // isCredit
					factLine.setAmtSource(dLine.getFactAcctInfo().getRecord().getC_Currency_ID(), null, dl.getAmt().negate());
				else
					factLine.setAmtSource(dLine.getFactAcctInfo().getRecord().getC_Currency_ID(), dl.getAmt(), null);
				factLine.getFactAcctInfo().getRecord().setQty(dl.getQty());
				//  Convert
				factLine.convert();
				//
				String description = distribution.getRecord().getName() + " #" + dl.getRecord().getLine();
				if (dl.getRecord().getDescription() != null)
					description += " - " + dl.getRecord().getDescription();
				factLine.addDescription(description);
				//
				if (log.isLoggable(Level.INFO)) log.info(factLine.toString());
				newLines.add(factLine);
			}
		}	//	for all lines
		
		//	Add Lines
		for (int i = 0; i < newLines.size(); i++)
			m_lines.add(newLines.get(i));
		
		return true;
	}	//	distribute	
	
	/**
	 * String representation
	 * @return String
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("Fact[");
		sb.append(m_doc.toString());
		sb.append(",").append(m_acctSchema.toString());
		sb.append(",PostType=").append(m_postingType);
		sb.append("]");
		return sb.toString();
	}	//	toString

	/**
	 *	Get Lines
	 *  @return FactLine Array
	 */
	public FactLine[] getLines()
	{
		FactLine[] temp = new FactLine[m_lines.size()];
		m_lines.toArray(temp);
		return temp;
	}	//	getLines

	/**
	 *  Save Fact Lines
	 *  @param trxName transaction
	 *  @return true if all lines were saved
	 */
	public boolean save (String trxName)
	{
		m_trxName = trxName;
		//  save Lines
		for (int i = 0; i < m_lines.size(); i++)
		{
			FactLine fl = (FactLine)m_lines.get(i);
			if (!fl.save(trxName))  //  abort on first error
				return false;
		}
		return true;
	}   //  commit

	/**
	 * 	Get Transaction Name
	 *	@return trx nam
	 */
	public String get_TrxName() 
	{
		return m_trxName;
	}	//	getTrxName

	/**
	 * 	Set Transaction name
	 * 	@param trxName
	 */
	@SuppressWarnings("unused")
	private void set_TrxName(String trxName) 
	{
		m_trxName = trxName;
	}	//	set_TrxName

	/**
	 * 	Fact Balance Utility
	 *	
	 *  @author Jorg Janke
	 *  @version $Id: Fact.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
	 */
	public static class Balance
	{
		/**
		 *	@param dr DR
		 *	@param cr CR
		 */
		public Balance (BigDecimal dr, BigDecimal cr)
		{
			DR = dr;
			CR = cr;
		}
		
		/** DR Amount	*/
		public BigDecimal DR = Env.ZERO;
		/** CR Amount	*/
		public BigDecimal CR = Env.ZERO;
		
		/**
		 * 	Add 
		 *	@param dr DR
		 *	@param cr CR
		 */
		public void add (BigDecimal dr, BigDecimal cr)
		{
			DR = DR.add(dr);
			CR = CR.add(cr);
		}
		
		/**
		 * 	Get Balance
		 *	@return balance
		 */
		public BigDecimal getBalance()
		{
			return DR.subtract(CR);
		}	//	getBalance
		
		/**
		 * 	Get Post Balance
		 *	@return absolute balance - negative if reversal
		 */
		public BigDecimal getPostBalance()
		{
			BigDecimal bd = getBalance().abs();
			if (isReversal())
				return bd.negate();
			return bd;
		}	//	getPostBalance

		/**
		 * 	Zero Balance
		 *	@return true if 0
		 */
		public boolean isZeroBalance()
		{
			return getBalance().signum() == 0;
		}	//	isZeroBalance
		
		/**
		 * 	Reversal
		 *	@return true if both DR/CR are negative or zero
		 */
		public boolean isReversal()
		{
			return DR.signum() <= 0 && CR.signum() <= 0;
		}	//	isReversal
		
		/**
		 * 	String Representation
		 *	@return info
		 */
		public String toString ()
		{
			StringBuilder sb = new StringBuilder ("Balance[");
			sb.append ("DR=").append(DR)
				.append ("-CR=").append(CR)
				.append(" = ").append(getBalance())
				.append ("]");
			return sb.toString ();
		} //	toString
		
	}	//	Balance
	
}   //  Fact