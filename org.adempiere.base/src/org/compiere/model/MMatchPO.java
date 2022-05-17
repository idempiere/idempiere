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
package org.compiere.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.IReservationTracer;
import org.adempiere.util.IReservationTracerFactory;
import org.compiere.acct.Doc;
import org.compiere.process.DocAction;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

/**
 *	Match PO Model.
 *	= Created when processing Shipment or Order
 *	- Updates Order (delivered, invoiced)
 *	- Creates PPV acct
 *	
 *  @author Jorg Janke
 *  @version $Id: MMatchPO.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 *  
 *  @author Bayu Cahya, Sistematika
 *  		<li>BF [ 2240484 ] Re MatchingPO, MMatchPO doesn't contains Invoice info
 *  
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>BF [ 2314749 ] MatchPO not considering currency PriceMatchDifference
 *
 *  @author Armen Rizal, Goodwill Consulting
 *  		<li>BF [ 2215840 ] MatchPO Bug Collection
 *  		<li>BF [ 2858043 ] Correct Included Tax in Average Costing
 *
 *  @author victor.perez@e-evolution.com, e-Evolution http://www.e-evolution.com
 * 			<li> FR [ 2520591 ] Support multiples calendar for Org 
 *			@see https://sourceforge.net/p/adempiere/feature-requests/631/
 */
public class MMatchPO extends X_M_MatchPO
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 487498668807522050L;

	/**
	 * 	Get PO Match with order/invoice
	 *	@param ctx context
	 *	@param C_OrderLine_ID order
	 *	@param C_InvoiceLine_ID invoice
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchPO[] get (Properties ctx, 
		int C_OrderLine_ID, int C_InvoiceLine_ID, String trxName)
	{
		if (C_OrderLine_ID == 0 || C_InvoiceLine_ID == 0)
			return new MMatchPO[]{};
		//
		String sql = "SELECT * FROM M_MatchPO WHERE C_OrderLine_ID=? AND C_InvoiceLine_ID=?";
		ArrayList<MMatchPO> list = new ArrayList<MMatchPO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, C_OrderLine_ID);
			pstmt.setInt (2, C_InvoiceLine_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MMatchPO (ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e); 
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		MMatchPO[] retValue = new MMatchPO[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	get

	/**
	 * 	Get PO Match of Receipt Line
	 *	@param ctx context
	 *	@param M_InOutLine_ID receipt
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchPO[] get (Properties ctx,
		int M_InOutLine_ID, String trxName)
	{
		if (M_InOutLine_ID == 0)
			return new MMatchPO[]{};
		//
		String sql = "SELECT * FROM M_MatchPO WHERE M_InOutLine_ID=?";
		ArrayList<MMatchPO> list = new ArrayList<MMatchPO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, M_InOutLine_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MMatchPO (ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
			if (e instanceof RuntimeException)
			{
				throw (RuntimeException)e;
			}
			else
			{
				throw new IllegalStateException(e);
			}
		}
		finally 
		{
			DB.close(rs, pstmt);
		}
		
		MMatchPO[] retValue = new MMatchPO[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	get
	
	/**
	 * 	Get PO Matches of receipt
	 *	@param ctx context
	 *	@param M_InOut_ID receipt
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchPO[] getInOut (Properties ctx, 
		int M_InOut_ID, String trxName)
	{
		if (M_InOut_ID == 0)
			return new MMatchPO[]{};
		//
		String sql = "SELECT * FROM M_MatchPO m"
			+ " INNER JOIN M_InOutLine l ON (m.M_InOutLine_ID=l.M_InOutLine_ID) "
			+ "WHERE l.M_InOut_ID=?"; 
		ArrayList<MMatchPO> list = new ArrayList<MMatchPO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, M_InOut_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MMatchPO (ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e); 
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		MMatchPO[] retValue = new MMatchPO[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	getInOut

	/**
	 * 	Get PO Matches of Invoice
	 *	@param ctx context
	 *	@param C_Invoice_ID invoice
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchPO[] getInvoice (Properties ctx, 
		int C_Invoice_ID, String trxName)
	{
		if (C_Invoice_ID == 0)
			return new MMatchPO[]{};
		//
		String sql = "SELECT * FROM M_MatchPO mi"
			+ " INNER JOIN C_InvoiceLine il ON (mi.C_InvoiceLine_ID=il.C_InvoiceLine_ID) "
			+ "WHERE il.C_Invoice_ID=?";
		ArrayList<MMatchPO> list = new ArrayList<MMatchPO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, C_Invoice_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MMatchPO (ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e); 
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		MMatchPO[] retValue = new MMatchPO[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	getInvoice

	// MZ Goodwill
	/**
	 * 	Get PO Matches for OrderLine
	 *	@param ctx context
	 *	@param C_OrderLine_ID order
	 *	@param trxName transaction
	 *	@return array of matches
	 */
	public static MMatchPO[] getOrderLine (Properties ctx, int C_OrderLine_ID, String trxName)
	{
		if (C_OrderLine_ID == 0)
			return new MMatchPO[]{};
		//
		String sql = "SELECT * FROM M_MatchPO WHERE C_OrderLine_ID=?";
		ArrayList<MMatchPO> list = new ArrayList<MMatchPO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, C_OrderLine_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MMatchPO (ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e); 
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		MMatchPO[] retValue = new MMatchPO[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	getOrderLine
	// end MZ
	
	/**
	 * 	Find/Create PO(Inv) Match
	 *	@param iLine invoice line
	 *	@param sLine receipt line
	 *	@param dateTrx date
	 *	@param qty qty
	 *	@return Match Record
	 */
	public static MMatchPO create (MInvoiceLine iLine, MInOutLine sLine,  
		Timestamp dateTrx, BigDecimal qty)
	{
		String trxName = null;
		Properties ctx = null;
		int C_OrderLine_ID = 0;
		if (iLine != null)
		{
			trxName = iLine.get_TrxName();
			ctx = iLine.getCtx();
			C_OrderLine_ID = iLine.getC_OrderLine_ID();
		}
		if (sLine != null)
		{
			trxName = sLine.get_TrxName();
			ctx = sLine.getCtx();
			C_OrderLine_ID = sLine.getC_OrderLine_ID();
		}
		
		if (C_OrderLine_ID > 0)
		{
			return create(ctx, iLine, sLine, C_OrderLine_ID, dateTrx, qty, trxName);
		}
		else
		{
			if (sLine != null && iLine != null)
			{
				MMatchPO[] matchpos = MMatchPO.get(ctx, sLine.getM_InOutLine_ID(), trxName);
				for (MMatchPO matchpo : matchpos)
				{
					C_OrderLine_ID = matchpo.getC_OrderLine_ID();
					MOrderLine orderLine = new MOrderLine(ctx, C_OrderLine_ID, trxName);
					BigDecimal toInvoice = orderLine.getQtyOrdered().subtract(orderLine.getQtyInvoiced());
					if (toInvoice.signum() <= 0) 
						continue;
					BigDecimal matchQty = qty;
					if (matchQty.compareTo(toInvoice) > 0)
						matchQty = toInvoice;
					
					if (matchQty.signum() <= 0)
						continue;
					
					MMatchPO newMatchPO = create(ctx, iLine, sLine, C_OrderLine_ID, dateTrx, matchQty, trxName);
					if (!newMatchPO.save())
					{
						String msg = "Failed to update match po.";
						ValueNamePair error = CLogger.retrieveError();
						if (error != null)
						{
							msg = msg + " " + error.getName();
						}
						throw new RuntimeException(msg);
					}
					qty = qty.subtract(matchQty);
					if (qty.signum() <= 0)
						return newMatchPO;
				}
			}
			return null;
		}
	}
	
	protected static MMatchPO create(Properties ctx, MInvoiceLine iLine,
			MInOutLine sLine, int C_OrderLine_ID, Timestamp dateTrx,
			BigDecimal qty, String trxName) {
		MMatchPO retValue = null;
		List<MMatchPO> matchPOList = MatchPOAutoMatch.getNotMatchedMatchPOList(ctx, C_OrderLine_ID, trxName);
		if (!matchPOList.isEmpty())
		{
			for (MMatchPO mpo : matchPOList)
			{
				if (qty.compareTo(mpo.getQty()) >= 0)
				{
					BigDecimal toMatch = qty;
					BigDecimal matchQty = mpo.getQty();
					if (toMatch.compareTo(matchQty) > 0)
						toMatch = matchQty;
					if (iLine != null)
					{
						if ((mpo.getC_InvoiceLine_ID() == 0)
							|| (mpo.getC_InvoiceLine_ID() == iLine.getC_InvoiceLine_ID()))
						{
							if (iLine.getM_AttributeSetInstance_ID() != 0)
							{
								if (mpo.getM_AttributeSetInstance_ID() == 0)
									mpo.setM_AttributeSetInstance_ID(iLine.getM_AttributeSetInstance_ID());
								else if (mpo.getM_AttributeSetInstance_ID() != iLine.getM_AttributeSetInstance_ID())
									continue;
							}
						}
						else
							continue;
					}
					if (sLine != null)
					{
						if ((mpo.getM_InOutLine_ID() == 0)
							|| (mpo.getM_InOutLine_ID() == sLine.getM_InOutLine_ID()))
						{
							
							if (sLine.getM_AttributeSetInstance_ID() != 0)
							{
								if (mpo.getM_AttributeSetInstance_ID() == 0)
									mpo.setM_AttributeSetInstance_ID(sLine.getM_AttributeSetInstance_ID());
								else if (mpo.getM_AttributeSetInstance_ID() != sLine.getM_AttributeSetInstance_ID())
									continue;
							}
						}						
						else
							continue;
						if (iLine == null && mpo.isPosted())
							continue;
					}
					if (iLine != null && sLine == null && mpo.getC_InvoiceLine_ID() == 0)
					{
						//verify m_matchinv not created for other invoice
						int cnt = DB.getSQLValue(iLine.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+mpo.getM_InOutLine_ID()
								+" AND C_InvoiceLine_ID != "+iLine.getC_InvoiceLine_ID() + " AND Reversal_ID=0");
						if (cnt > 0)
							continue;
					}
					if ((iLine != null || mpo.getC_InvoiceLine_ID() > 0) && (sLine != null || mpo.getM_InOutLine_ID() > 0))
					{
						int M_InOutLine_ID = sLine != null ? sLine.getM_InOutLine_ID() : mpo.getM_InOutLine_ID();
						int C_InvoiceLine_ID = iLine != null ? iLine.getC_InvoiceLine_ID() : mpo.getC_InvoiceLine_ID();
						
						//verify invoiceline not already linked to another inoutline
						int tmpInOutLineId = DB.getSQLValue(mpo.get_TrxName(), "SELECT M_InOutLine_ID FROM C_InvoiceLine WHERE C_InvoiceLine_ID="+C_InvoiceLine_ID);
						if (tmpInOutLineId > 0 && tmpInOutLineId != M_InOutLine_ID) 
						{
							continue;
						}
						
						//verify m_matchinv not created yet
						int cnt = DB.getSQLValue(mpo.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+M_InOutLine_ID
								+" AND C_InvoiceLine_ID="+C_InvoiceLine_ID);
						if (cnt <= 0)
						{
							MMatchInv matchInv = createMatchInv(mpo, C_InvoiceLine_ID, M_InOutLine_ID, mpo.getQty(), dateTrx, trxName);
							if (matchInv == null)
								continue;
							mpo.setMatchInvCreated(matchInv);
						}
					}
					if (iLine != null)
						mpo.setC_InvoiceLine_ID(iLine);
					if (sLine != null){
						mpo.setM_InOutLine_ID(sLine.getM_InOutLine_ID());
						if (!mpo.isPosted())
							mpo.setDateAcct(sLine.getParent().getDateAcct());
					}
					
					if (!mpo.save())
					{
						String msg = "Failed to update match po.";
						ValueNamePair error = CLogger.retrieveError();
						if (error != null)
						{
							msg = msg + " " + error.getName();
						}
						throw new RuntimeException(msg);
					}
					
					qty = qty.subtract(toMatch);					
					if (qty.signum() <= 0)
					{
						retValue = mpo;
						break;
					}
				}
			}
		}
		
		//	Create New
		if (retValue == null)
		{
			BigDecimal sLineMatchedQty = null; 
			if (sLine != null && iLine != null)
			{
				sLineMatchedQty = DB.getSQLValueBD(sLine.get_TrxName(), "SELECT Sum(Qty) FROM M_MatchPO WHERE C_OrderLine_ID="+C_OrderLine_ID+" AND M_InOutLine_ID=?", sLine.getM_InOutLine_ID());
			}
			
			if (sLine != null && (sLine.getC_OrderLine_ID() == C_OrderLine_ID || iLine == null)
				&& (sLineMatchedQty == null || sLineMatchedQty.signum() <= 0))
			{				
				if (qty.signum() != 0)
				{
					retValue = new MMatchPO (sLine, dateTrx, qty);
					retValue.setC_OrderLine_ID(C_OrderLine_ID);
					MMatchPO otherMatchPO = null;
					if (iLine == null) {
						MMatchPO[] matchPOs = MMatchPO.getOrderLine(retValue.getCtx(), sLine.getC_OrderLine_ID(), retValue.get_TrxName());
						for (MMatchPO matchPO : matchPOs)
						{
							if (matchPO.getC_InvoiceLine_ID() > 0 && matchPO.getM_InOutLine_ID() == 0 && matchPO.getReversal_ID() == 0 && matchPO.getQty().compareTo(retValue.getQty()) >=0 )
							{
								//check m_matchinv not created with different qty
								int cnt = DB.getSQLValueEx(sLine.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+sLine.getM_InOutLine_ID()
										+" AND C_InvoiceLine_ID="+ matchPO.getC_InvoiceLine_ID() + "AND Qty != ?", retValue.getQty());
								if (cnt <= 0) {
									if (!matchPO.isPosted() && matchPO.getQty().compareTo(retValue.getQty()) >=0 )  // greater than or equal quantity
									{
										otherMatchPO = matchPO;
										iLine = new MInvoiceLine(retValue.getCtx(), matchPO.getC_InvoiceLine_ID(), retValue.get_TrxName());
										matchPO.setQty(matchPO.getQty().subtract(retValue.getQty()));										
										matchPO.saveEx();
										break;
									}
									
								}
							}
						}
					}
					if (iLine != null) { 
						if (otherMatchPO == null)
							retValue.setC_InvoiceLine_ID(iLine);
						//auto create matchinv
						if (otherMatchPO != null)
						{
							//verify m_matchinv not created yet
							int cnt = DB.getSQLValue(retValue.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+retValue.getM_InOutLine_ID()
									+" AND C_InvoiceLine_ID="+otherMatchPO.getC_InvoiceLine_ID());
							if (cnt <= 0)
							{
								MMatchInv matchInv = createMatchInv(retValue, otherMatchPO.getC_InvoiceLine_ID(), retValue.getM_InOutLine_ID(), retValue.getQty(), dateTrx, trxName);
								if (matchInv == null)
								{
									String msg = "Failed to create match inv.";
									ValueNamePair error = CLogger.retrieveError();
									if (error != null)
									{
										msg = msg + " " + error.getName();
									}
									throw new RuntimeException(msg);
								}
								retValue.setMatchInvCreated(matchInv);
							}
							if (otherMatchPO.getQty().signum() == 0 )
								otherMatchPO.deleteEx(true);
						}
					}
					if (!retValue.save())
					{
						String msg = "Failed to update match po.";
						ValueNamePair error = CLogger.retrieveError();
						if (error != null)
						{
							msg = msg + " " + error.getName();
						}
						throw new RuntimeException(msg);
					}
				}
			}
			else if (iLine != null)
			{
				if (qty.signum() != 0)
				{
					retValue = new MMatchPO (iLine, dateTrx, qty);
					retValue.setC_OrderLine_ID(C_OrderLine_ID);
					if (!retValue.save())
					{
						String msg = "Failed to update match po.";
						ValueNamePair error = CLogger.retrieveError();
						if (error != null)
						{
							msg = msg + " " + error.getName();
						}
						throw new RuntimeException(msg);
					}
					
					//auto create m_matchinv
					Map<Integer, BigDecimal[]> noInvoiceLines = new HashMap<>();
					Map<Integer, List<MMatchPO>> invoiceMatched = new HashMap<Integer, List<MMatchPO>>();
					List<MMatchPO> noInvoiceList = new ArrayList<MMatchPO>();
					//get all matchpo with inoutline for C_OrderLine_ID
					MMatchPO[] matchPOs = MMatchPO.getOrderLine(iLine.getCtx(), C_OrderLine_ID, iLine.get_TrxName());
					for (MMatchPO matchPO : matchPOs)
					{
						if (matchPO.getM_MatchPO_ID() == retValue.getM_MatchPO_ID())
							continue;
						
						if (matchPO.getM_InOutLine_ID() > 0 && matchPO.getReversal_ID() == 0 && matchPO.getRef_MatchPO_ID() == 0)
						{
							if (matchPO.getC_InvoiceLine_ID() == 0)
							{
								String docStatus = matchPO.getM_InOutLine().getM_InOut().getDocStatus();
								if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) 
								{
									noInvoiceLines.put(matchPO.getM_MatchPO_ID(), new BigDecimal[]{matchPO.getQty()});
									noInvoiceList.add(matchPO);
								}
							}
							else
							{
								List<MMatchPO> invoices = invoiceMatched.get(matchPO.getM_InOutLine_ID());
								if (invoices == null) 
								{
									invoices = new ArrayList<MMatchPO>();
									invoiceMatched.put(matchPO.getM_InOutLine_ID(), invoices);
								}
								invoices.add(matchPO);
							}
						} 
					}
					
					//sort in created sequence
					Collections.sort(noInvoiceList, new Comparator<MMatchPO>() {
						@Override
						public int compare(MMatchPO arg0, MMatchPO arg1) {
							return arg0.getM_MatchPO_ID() > arg1.getM_MatchPO_ID() 
									? 1
									: (arg0.getM_MatchPO_ID()==arg1.getM_MatchPO_ID() ? 0 : -1);
						}
					});
					
					//goes through all matchpo that potentially have not been matched to any invoice yet
					//calculate balance that have not been matched to invoice line 
					for (MMatchPO matchPO : noInvoiceList)
					{
						BigDecimal[] qtyHolder = noInvoiceLines.get(matchPO.getM_MatchPO_ID());
						List<MMatchPO> matchedInvoices = invoiceMatched.get(matchPO.getM_InOutLine_ID());
						MMatchInv[] matchInvoices = MMatchInv.getInOutLine(iLine.getCtx(), matchPO.getM_InOutLine_ID(), iLine.get_TrxName());
						for (MMatchInv matchInv : matchInvoices)
						{
							if (matchInv.getReversal_ID() > 0)
								continue;
							BigDecimal alreadyMatch = BigDecimal.ZERO;
							if (matchedInvoices != null)
							{
								for(MMatchPO matchedInvoice : matchedInvoices)
								{
									if (matchedInvoice.getC_InvoiceLine_ID()==matchInv.getC_InvoiceLine_ID())
										alreadyMatch = alreadyMatch.add(matchedInvoice.getQty());
								}
							}
							BigDecimal balance = matchInv.getQty().subtract(alreadyMatch);
							if (balance.signum() > 0)
							{
								String docStatus = matchInv.getC_InvoiceLine().getC_Invoice().getDocStatus();
								if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) 
								{
									qtyHolder[0] = qtyHolder[0].subtract(balance);
								}
							}
						}							
					}
					
					//do matching
					BigDecimal toMatch = retValue.getQty();
					for (MMatchPO matchPO : noInvoiceList)
					{
						BigDecimal[] qtyHolder = noInvoiceLines.get(matchPO.getM_MatchPO_ID());
						if (qtyHolder[0].signum() > 0)
						{
							BigDecimal autoMatchQty = null;
							if (qtyHolder[0].compareTo(toMatch) >= 0)
							{
								autoMatchQty = toMatch;
								toMatch = BigDecimal.ZERO;
							}
							else
							{
								autoMatchQty = qtyHolder[0];
								toMatch = toMatch.subtract(autoMatchQty);
							}
							if (autoMatchQty != null && autoMatchQty.signum() > 0)
							{
								MMatchInv[] matchInvoices = MMatchInv.get(Env.getCtx(), matchPO.getM_InOutLine_ID(), retValue.getC_InvoiceLine_ID(), trxName);
								if (matchInvoices == null || matchInvoices.length == 0)
								{
									MMatchInv matchInv = createMatchInv(retValue, retValue.getC_InvoiceLine_ID(), matchPO.getM_InOutLine_ID(), autoMatchQty, dateTrx, trxName);
									retValue.setMatchInvCreated(matchInv);
									if (matchInv == null)
										break;
								}
							}
						}
						if (toMatch.signum() <= 0)
							break;
					}
				}
			}
		}
		
		if (C_OrderLine_ID > 0 && retValue != null)
			MatchPOAutoMatch.match(ctx, C_OrderLine_ID, retValue, trxName);
				
		return retValue;
	}	//	create
	
	protected static MMatchInv createMatchInv(MMatchPO mpo, int C_InvoiceLine_ID, int M_InOutLine_ID, BigDecimal qty, Timestamp dateTrx, String trxName) 
	{
		Savepoint savepoint = null;
		Trx trx = null;
		MMatchInv matchInv = null;
		try
		{
			trx = trxName != null ? Trx.get(trxName, false) : null;
			savepoint = trx != null ? trx.getConnection().setSavepoint() : null;
			matchInv = new MMatchInv(mpo.getCtx(), 0, mpo.get_TrxName());
			matchInv.setC_InvoiceLine_ID(C_InvoiceLine_ID);
			matchInv.setM_Product_ID(mpo.getM_Product_ID());
			matchInv.setM_InOutLine_ID(M_InOutLine_ID);
			matchInv.setAD_Client_ID(mpo.getAD_Client_ID());
			matchInv.setAD_Org_ID(mpo.getAD_Org_ID());
			matchInv.setM_AttributeSetInstance_ID(mpo.getM_AttributeSetInstance_ID());
			matchInv.setQty(qty);
			matchInv.setDateTrx(dateTrx);
			matchInv.setProcessed(true);
			if (!matchInv.save())
			{
				if (savepoint != null)
				{
					trx.getConnection().rollback(savepoint);								
					savepoint = null;
				}
				else
				{
					matchInv.delete(true);
				}
				String msg = "Failed to auto match invoice.";
				ValueNamePair error = CLogger.retrieveError();
				if (error != null)
				{
					msg = msg + " " + error.getName();
				}
				s_log.severe(msg);
				matchInv = null;
			}
		} catch (Exception e) {						
			s_log.log(Level.SEVERE, "Failed to auto match Invoice.", e);
			matchInv = null;
		} finally {
			if (savepoint != null) 
			{
				try {
					trx.getConnection().releaseSavepoint(savepoint);
				} catch (Exception e) {}
			}	
		}
		
		return matchInv;
	}

	protected MMatchInv m_matchInv;

	/**
	 * Register the match inv created for immediate accounting purposes
	 * @param matchInv
	 */
	protected void setMatchInvCreated(MMatchInv matchInv) {
		m_matchInv = matchInv;
	}

	/**
	 * Get the match inv created for immediate accounting purposes
	 * Is cleared after read, so if you read twice second time it returns null
	 */
	public MMatchInv getMatchInvCreated() {
		MMatchInv tmp = m_matchInv;
		m_matchInv = null;
		return tmp;
	}

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MMatchPO.class);

	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_MatchPO_ID id
	 *	@param trxName transaction
	 */
	public MMatchPO (Properties ctx, int M_MatchPO_ID, String trxName)
	{
		super (ctx, M_MatchPO_ID, trxName);
		if (M_MatchPO_ID == 0)
		{
			setM_AttributeSetInstance_ID(0);
			setPosted (false);
			setProcessed (false);
			setProcessing (false);
		}
	}	//	MMatchPO

	/**
	 * 	Load Construor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MMatchPO (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MMatchPO
	
	/**
	 * 	Shipment Line Constructor
	 *	@param sLine shipment line
	 *	@param dateTrx optional date
	 *	@param qty matched quantity
	 */
	public MMatchPO (MInOutLine sLine, Timestamp dateTrx, BigDecimal qty)
	{
		this (sLine.getCtx(), 0, sLine.get_TrxName());
		setClientOrg(sLine);
		setM_InOutLine_ID (sLine.getM_InOutLine_ID());
		setC_OrderLine_ID (sLine.getC_OrderLine_ID());
		if (dateTrx != null)
			setDateTrx (dateTrx);
		setM_Product_ID (sLine.getM_Product_ID());
		setM_AttributeSetInstance_ID(sLine.getM_AttributeSetInstance_ID());
		setQty (qty);
		setProcessed(true);		//	auto
	}	//	MMatchPO

	/**
	 * 	Invoice Line Constructor
	 *	@param iLine invoice line
	 *	@param dateTrx optional date
	 *	@param qty matched quantity
	 */
	public MMatchPO (MInvoiceLine iLine, Timestamp dateTrx, BigDecimal qty)
	{
		this (iLine.getCtx(), 0, iLine.get_TrxName());
		setClientOrg(iLine);
		setC_InvoiceLine_ID(iLine);
		if (iLine.getC_OrderLine_ID() != 0)
			setC_OrderLine_ID (iLine.getC_OrderLine_ID());
		if (dateTrx != null)
			setDateTrx (dateTrx);
		setM_Product_ID (iLine.getM_Product_ID());
		setM_AttributeSetInstance_ID(iLine.getM_AttributeSetInstance_ID());
		setQty (qty);
		setProcessed(true);		//	auto
	}	//	MMatchPO
	
	/** Invoice Changed			*/
	protected boolean m_isInvoiceLineChange = false;
	/** InOut Changed			*/
	protected boolean m_isInOutLineChange = false;
	/** Order Line				*/
	protected MOrderLine		m_oLine = null;
	/** Invoice Line			*/
	protected MInvoiceLine	m_iLine = null;
	
	
	/**
	 * 	Set C_InvoiceLine_ID
	 *	@param line line
	 */
	public void setC_InvoiceLine_ID (MInvoiceLine line)
	{
		m_iLine = line;
		if (line == null)
			setC_InvoiceLine_ID(0);
		else
			setC_InvoiceLine_ID(line.getC_InvoiceLine_ID());
	}	//	setC_InvoiceLine_ID

	/**
	 * 	Set C_InvoiceLine_ID
	 *	@param C_InvoiceLine_ID id
	 */
	public void setC_InvoiceLine_ID (int C_InvoiceLine_ID)
	{
		int old = getC_InvoiceLine_ID();
		if (old != C_InvoiceLine_ID)
		{
			super.setC_InvoiceLine_ID (C_InvoiceLine_ID);
			m_isInvoiceLineChange = true;
		}
	}	//	setC_InvoiceLine_ID

	/**
	 * 	Get Invoice Line
	 *	@return invoice line or null
	 */
	public MInvoiceLine getInvoiceLine()
	{
		if (m_iLine == null && getC_InvoiceLine_ID() != 0)
			m_iLine = new MInvoiceLine(getCtx(), getC_InvoiceLine_ID(), get_TrxName());
		return m_iLine;
	}	//	getInvoiceLine
	
	/**
	 * 	Set M_InOutLine_ID
	 *	@param M_InOutLine_ID id
	 */
	public void setM_InOutLine_ID (int M_InOutLine_ID)
	{
		int old = getM_InOutLine_ID();
		if (old != M_InOutLine_ID)
		{
			super.setM_InOutLine_ID (M_InOutLine_ID);
			m_isInOutLineChange = true;
		}
	}	//	setM_InOutLine_ID
	
	/**
	 * 	Set C_OrderLine_ID
	 *	@param line line
	 */
	public void setC_OrderLine_ID (MOrderLine line)
	{
		m_oLine = line;
		if (line == null)
			setC_OrderLine_ID(0);
		else
			setC_OrderLine_ID(line.getC_OrderLine_ID());
	}	//	setC_InvoiceLine_ID

	/**
	 * 	Get Order Line
	 *	@return order line or null
	 */
	public MOrderLine getOrderLine()
	{
		if ((m_oLine == null && getC_OrderLine_ID() != 0) 
			|| getC_OrderLine_ID() != m_oLine.getC_OrderLine_ID())
			m_oLine = new MOrderLine(getCtx(), getC_OrderLine_ID(), get_TrxName());
		return m_oLine;
	}	//	getOrderLine
	
	/**
	 * Get PriceActual from Invoice and convert it to Order Currency
	 * @return Price Actual in Order Currency
	 */
	public BigDecimal getInvoicePriceActual()
	{
		MInvoiceLine iLine = getInvoiceLine();
		MInvoice invoice = iLine.getParent();
		MOrder order = getOrderLine().getParent();

		BigDecimal priceActual = iLine.getPriceActual();
		int invoiceCurrency_ID = invoice.getC_Currency_ID();
		int orderCurrency_ID = order.getC_Currency_ID();
		if (invoiceCurrency_ID != orderCurrency_ID)
		{
			priceActual = MConversionRate.convert(getCtx(), priceActual, invoiceCurrency_ID, orderCurrency_ID,
										invoice.getDateInvoiced(), invoice.getC_ConversionType_ID(),
										getAD_Client_ID(), getAD_Org_ID());
			
			if (priceActual == null)
				throw new AdempiereException(MConversionRateUtil.getErrorMessage(getCtx(), "ErrorConvertingCurrencyToBaseCurrency",
						invoiceCurrency_ID, orderCurrency_ID, invoice.getC_ConversionType_ID(), invoice.getDateInvoiced(), get_TrxName()));
		}
		return priceActual;
	}
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		//	Set Trx Date
		if (getDateTrx() == null)
			setDateTrx (new Timestamp(System.currentTimeMillis()));
		//	Set Acct Date
		if (getDateAcct() == null)
		{
			Timestamp ts = getNewerDateAcct();
			if (ts == null)
				ts = getDateTrx();
			setDateAcct (ts);
		}
		//	Set ASI from Receipt
		if (getM_AttributeSetInstance_ID() == 0 && getM_InOutLine_ID() != 0)
		{
			MInOutLine iol = new MInOutLine (getCtx(), getM_InOutLine_ID(), get_TrxName());
			setM_AttributeSetInstance_ID(iol.getM_AttributeSetInstance_ID());
		}
		
		// Bayu, Sistematika
		// BF [ 2240484 ] Re MatchingPO, MMatchPO doesn't contains Invoice info
		// If newRecord, set c_invoiceline_id while null
		if (newRecord && getC_InvoiceLine_ID() == 0 && getReversal_ID()==0) 
		{
			MMatchInv[] mpi = MMatchInv.getInOutLine(getCtx(), getM_InOutLine_ID(), get_TrxName());
			for (int i = 0; i < mpi.length; i++) 
			{
				if (mpi[i].getC_InvoiceLine_ID() != 0 && 
						mpi[i].getM_AttributeSetInstance_ID() == getM_AttributeSetInstance_ID()) 
				{
					//verify m_matchpo not created yet
					int cnt = DB.getSQLValue(get_TrxName(), "SELECT Count(*) FROM M_MatchPO WHERE M_InOutLine_ID="+getM_InOutLine_ID()
							+" AND C_InvoiceLine_ID="+mpi[i].getC_InvoiceLine_ID());
					if (cnt > 0)
						continue;
					
					if (mpi[i].getQty().compareTo(getQty()) == 0)  // same quantity
					{
						setC_InvoiceLine_ID(mpi[i].getC_InvoiceLine_ID());
						break;
					}
					else // create MatchPO record for PO-Invoice if different quantity
					{
						MInvoiceLine il = new MInvoiceLine(getCtx(), mpi[i].getC_InvoiceLine_ID(), get_TrxName());						
						MMatchPO match = new MMatchPO(il, getDateTrx(), mpi[i].getQty());
						match.setC_OrderLine_ID(getC_OrderLine_ID());
						if (!match.save())
						{
							String msg = "Failed to create match po";
							ValueNamePair error = CLogger.retrieveError();
							if (error != null)
								msg = msg + " " + error.getName();
							throw new RuntimeException(msg);
						}
					}
				}
			}
		}
		// end Bayu
		
		//	Find OrderLine
		if (getC_OrderLine_ID() == 0)
		{
			MInvoiceLine il = null;
			if (getC_InvoiceLine_ID() != 0)
			{
				il = getInvoiceLine();
				if (il.getC_OrderLine_ID() != 0)
					setC_OrderLine_ID(il.getC_OrderLine_ID());
			}	//	get from invoice
			if (getC_OrderLine_ID() == 0 && getM_InOutLine_ID() != 0)
			{
				MInOutLine iol = new MInOutLine (getCtx(), getM_InOutLine_ID(), get_TrxName());
				if (iol.getC_OrderLine_ID() != 0)
				{
					setC_OrderLine_ID(iol.getC_OrderLine_ID());
					if (il != null)
					{
						il.setC_OrderLine_ID(iol.getC_OrderLine_ID());
						il.saveEx();
					}
				}
			}	//	get from shipment
		}	//	find order line
		
		//	Price Match Approval
		if (getC_OrderLine_ID() != 0 
			&& getC_InvoiceLine_ID() != 0
			&& (newRecord || 
				is_ValueChanged("C_OrderLine_ID") || is_ValueChanged("C_InvoiceLine_ID")))
		{
			BigDecimal poPrice = getOrderLine().getPriceActual();
			BigDecimal invPrice = getInvoicePriceActual();
			BigDecimal difference = poPrice.subtract(invPrice);
			if (difference.signum() != 0)
			{
				difference = difference.multiply(getQty());
				setPriceMatchDifference(difference);
				//	Approval
				MBPGroup group = MBPGroup.getOfBPartner(getCtx(), getOrderLine().getC_BPartner_ID());
				BigDecimal mt = group.getPriceMatchTolerance();
				if (mt != null && mt.signum() != 0)
				{
					BigDecimal poAmt = poPrice.multiply(getQty());
					BigDecimal maxTolerance = poAmt.multiply(mt);
					maxTolerance = maxTolerance.abs()
						.divide(Env.ONEHUNDRED, 2, RoundingMode.HALF_UP);
					difference = difference.abs();
					boolean ok = difference.compareTo(maxTolerance) <= 0;
					if (log.isLoggable(Level.CONFIG)) log.config("Difference=" + getPriceMatchDifference() 
						+ ", Max=" + maxTolerance + " => " + ok);
					setIsApproved(ok);
				}
			}
			else
			{
				setPriceMatchDifference(difference);
				setIsApproved(true);
			}
			
			//validate against M_MatchInv
			if (getM_InOutLine_ID() > 0 && getC_InvoiceLine_ID() > 0)
			{
				int cnt = DB.getSQLValue(get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+getM_InOutLine_ID()
						+" AND C_InvoiceLine_ID="+getC_InvoiceLine_ID());
				if (cnt <= 0)
				{
					MInvoiceLine invoiceLine = new MInvoiceLine(getCtx(), getC_InvoiceLine_ID(), get_TrxName());
					MInOutLine inoutLine = new MInOutLine(getCtx(), getM_InOutLine_ID(), get_TrxName());
					throw new IllegalStateException("[MatchPO] Missing corresponding invoice matching record for invoice line "
							+ invoiceLine + " and receipt line " + inoutLine);
				}
			}
		}
		
		return true;
	}	//	beforeSave	
	
	/**
	 * 	After Save.
	 * 	Set Order Qty Delivered/Invoiced 
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		//perform matched qty validation
		if (success)
		{
			if (getM_InOutLine_ID() > 0)
			{
				MInOutLine line = new MInOutLine(getCtx(), getM_InOutLine_ID(), get_TrxName());
				BigDecimal matchedQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE M_InOutLine_ID=?" , getM_InOutLine_ID());
				if (line.getMovementQty().signum() > 0 && matchedQty != null && matchedQty.compareTo(line.getMovementQty()) > 0)
				{
					throw new IllegalStateException("Total matched qty > movement qty. MatchedQty="+matchedQty+", MovementQty="+line.getMovementQty()+", Line="+line);
				}
			}
			
			if (getC_InvoiceLine_ID() > 0)
			{
				MInvoiceLine line = new MInvoiceLine(getCtx(), getC_InvoiceLine_ID(), get_TrxName());				
				BigDecimal matchedQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE C_InvoiceLine_ID=?  AND Reversal_ID IS NULL " , getC_InvoiceLine_ID() );
				if (matchedQty != null && matchedQty.compareTo(line.getQtyInvoiced()) > 0)
				{
					throw new IllegalStateException("Total matched qty > invoiced qty. MatchedQty="+matchedQty+", InvoicedQty="+line.getQtyInvoiced()+", Line="+line);
				}
			}
			
			if (getC_OrderLine_ID() > 0)
			{
				boolean validateOrderedQty = MSysConfig.getBooleanValue(MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY, true, Env.getAD_Client_ID(Env.getCtx()));
				if (validateOrderedQty)
				{
					MOrderLine line = new MOrderLine(getCtx(), getC_OrderLine_ID(), get_TrxName());
					BigDecimal qtyOrdered = line.getQtyOrdered();
					BigDecimal invoicedQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE C_InvoiceLine_ID > 0 and C_OrderLine_ID=? AND Reversal_ID IS NULL" , getC_OrderLine_ID());
					if (    invoicedQty != null
						&& (   (qtyOrdered.signum() > 0 && invoicedQty.compareTo(qtyOrdered) > 0)
						    || (qtyOrdered.signum() < 0 && invoicedQty.compareTo(qtyOrdered) < 0)
						   )
					   )
					{
						throw new IllegalStateException("Total matched invoiced qty > ordered qty. MatchedInvoicedQty="+invoicedQty+", OrderedQty="+qtyOrdered+", Line="+line);
					}
					BigDecimal deliveredQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE M_InOutLine_ID > 0 and C_OrderLine_ID=? AND Reversal_ID IS NULL" , getC_OrderLine_ID());
					if (   deliveredQty != null
						&& (   (qtyOrdered.signum() > 0 && deliveredQty.compareTo(qtyOrdered) > 0)
						    || (qtyOrdered.signum() < 0 && deliveredQty.compareTo(qtyOrdered) < 0)
						   )
					   )
					{
						throw new IllegalStateException("Total matched delivered qty > ordered qty. MatchedDeliveredQty="+deliveredQty+", OrderedQty="+qtyOrdered+", Line="+line);
					}
				}
			}
		}
				
		//	Purchase Order Delivered/Invoiced
		//	(Reserved in VMatch and MInOut.completeIt)
		if (success && getC_OrderLine_ID() != 0)
		{
			MOrderLine orderLine = getOrderLine();
			//
			if (m_isInOutLineChange && (newRecord || getM_InOutLine_ID() != get_ValueOldAsInt("M_InOutLine_ID")))
			{
				if (getM_InOutLine_ID() != 0)							//	new delivery
					orderLine.setQtyDelivered(orderLine.getQtyDelivered().add(getQty()));
				else if (!newRecord) //	if (getM_InOutLine_ID() == 0)					//	reset to 0
					orderLine.setQtyDelivered(orderLine.getQtyDelivered().subtract(getQty()));
				orderLine.setDateDelivered(getDateTrx());	//	overwrite=last
			}
			else if (!newRecord && getM_InOutLine_ID() > 0 && is_ValueChanged(COLUMNNAME_Qty))
			{
				BigDecimal oldQty = (BigDecimal)(get_ValueOld(COLUMNNAME_Qty));
				orderLine.setQtyDelivered(orderLine.getQtyDelivered().subtract(oldQty.subtract(getQty())));
			}
			
			if (m_isInvoiceLineChange && (newRecord || getC_InvoiceLine_ID() != get_ValueOldAsInt("C_InvoiceLine_ID")))
			{
				if (getC_InvoiceLine_ID() != 0)						//	first time
					orderLine.setQtyInvoiced(orderLine.getQtyInvoiced().add(getQty()));
				else if (!newRecord) //	if (getC_InvoiceLine_ID() == 0)				//	set to 0
					orderLine.setQtyInvoiced(orderLine.getQtyInvoiced().subtract(getQty()));
				orderLine.setDateInvoiced(getDateTrx());	//	overwrite=last
			}
			else if (!newRecord && getC_InvoiceLine_ID() > 0 && is_ValueChanged(COLUMNNAME_Qty))
			{
				BigDecimal oldQty = (BigDecimal)(get_ValueOld(COLUMNNAME_Qty));
				orderLine.setQtyInvoiced(orderLine.getQtyInvoiced().subtract(oldQty.subtract(getQty())));
			}
			
			//	Update Order ASI if full match
			if (orderLine.getM_AttributeSetInstance_ID() == 0
				&& getM_InOutLine_ID() != 0)
			{
				MInOutLine iol = new MInOutLine (getCtx(), getM_InOutLine_ID(), get_TrxName());
				if (iol.getMovementQty().compareTo(orderLine.getQtyOrdered()) == 0)
					orderLine.setM_AttributeSetInstance_ID(iol.getM_AttributeSetInstance_ID());
			}
			return orderLine.save();
		}
		//
		return success;
	}	//	afterSave

	
	/**
	 * 	Get the later Date Acct from invoice or shipment
	 *	@return date or null
	 */
	public Timestamp getNewerDateAcct()
	{
		Timestamp invoiceDate = null;
		Timestamp shipDate = null;
		
		if (getC_InvoiceLine_ID() != 0)
		{
			String sql = "SELECT i.DateAcct "
				+ "FROM C_InvoiceLine il"
				+ " INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID) "
				+ "WHERE C_InvoiceLine_ID=?";
			invoiceDate = DB.getSQLValueTS(null, sql, getC_InvoiceLine_ID());
		}
		//
		if (getM_InOutLine_ID() != 0)
		{
			String sql = "SELECT io.DateAcct "
				+ "FROM M_InOutLine iol"
				+ " INNER JOIN M_InOut io ON (io.M_InOut_ID=iol.M_InOut_ID) "
				+ "WHERE iol.M_InOutLine_ID=?";
			shipDate = DB.getSQLValueTS(null, sql, getM_InOutLine_ID());
		}
		//
		//	Assuming that order date is always earlier
		if (invoiceDate == null)
			return shipDate;
		if (shipDate == null)
			return invoiceDate;
		if (invoiceDate.after(shipDate))
			return invoiceDate;
		return shipDate;
	}	//	getNewerDateAcct

	
	/**
	 * 	Before Delete
	 *	@return true if acct was deleted
	 */
	@Override
	protected boolean beforeDelete ()
	{
		if (isPosted())
		{
			MPeriod.testPeriodOpen(getCtx(), getDateTrx(), MDocType.DOCBASETYPE_MatchPO, getAD_Org_ID());
			setPosted(false);
			MFactAcct.deleteEx (Table_ID, get_ID(), get_TrxName());
		}
		return true;
	}	//	beforeDelete

	
	/**
	 * 	After Delete.
	 * 	Set Order Qty Delivered/Invoiced 
	 *	@param success success
	 *	@return success
	 */
	@Override
	protected boolean afterDelete (boolean success)
	{
		//	Order Delivered/Invoiced
		//	(Reserved in VMatch and MInOut.completeIt)
		if (success && getC_OrderLine_ID() != 0)
		{
			MOrderLine orderLine = new MOrderLine (getCtx(), getC_OrderLine_ID(), get_TrxName());
			if (getM_InOutLine_ID() != 0)
				orderLine.setQtyDelivered(orderLine.getQtyDelivered().subtract(getQty()));
			if (getC_InvoiceLine_ID() != 0)
				orderLine.setQtyInvoiced(orderLine.getQtyInvoiced().subtract(getQty()));
			return orderLine.save(get_TrxName());
		}
		return success;
	}	//	afterDelete
		
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MMatchPO[");
		sb.append (get_ID())
			.append (",Qty=").append (getQty())
			.append (",C_OrderLine_ID=").append (getC_OrderLine_ID())
			.append (",M_InOutLine_ID=").append (getM_InOutLine_ID())
			.append (",C_InvoiceLine_ID=").append (getC_InvoiceLine_ID())
			.append (",Processed=").append(isProcessed())
			.append (",Posted=").append(isPosted())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Reverse MatchPO.
	 *  @param reversalDate
	 *	@return boolean
	 *	@throws Exception
	 */

	public boolean reverse(Timestamp reversalDate)
	{
		return reverse(reversalDate, false);
	}
	
	/**
	 * 	Reverse MatchPO.
	 *  @param reversalDate
	 *  @param reverseMatchingOnly true if MR is not reverse
	 *	@return boolean
	 *	@throws Exception
	 */

	public boolean reverse(Timestamp reversalDate, boolean reverseMatchingOnly)  
	{
		if (this.isProcessed() && this.getReversal_ID() == 0)
		{		
			MMatchPO reversal = new MMatchPO (getCtx(), 0, get_TrxName());
			reversal.setC_InvoiceLine_ID(getC_InvoiceLine_ID()); 
			reversal.setM_InOutLine_ID(getM_InOutLine_ID());
			if (getC_OrderLine_ID() != 0)			
				reversal.setC_OrderLine_ID(getC_OrderLine_ID());
			else{
				reversal.setC_OrderLine_ID(getM_InOutLine().getC_OrderLine_ID());
			}
			reversal.setM_Product_ID(getM_Product_ID());
			reversal.setM_AttributeSetInstance_ID(getM_AttributeSetInstance_ID());
			reversal.setAD_Org_ID(this.getAD_Org_ID());
			reversal.setDescription("(->" + this.getDocumentNo() + ")");
			reversal.setQty(this.getQty().negate());
			reversal.setDateAcct(reversalDate);
			reversal.setDateTrx(reversalDate);
			reversal.set_ValueNoCheck ("DocumentNo", null);
			reversal.setPosted (false);
			reversal.setProcessed(true);
			reversal.setRef_MatchPO_ID(getRef_MatchPO_ID());
			reversal.setReversal_ID(getM_MatchPO_ID());   	
			reversal.saveEx();

			this.setDescription("(" + reversal.getDocumentNo() + "<-)");			
			this.setReversal_ID(reversal.getM_MatchPO_ID());
			this.saveEx();

			//update qtyOrdered
			if (reverseMatchingOnly && reversal.getM_InOutLine_ID() > 0 && reversal.getC_OrderLine_ID() > 0)
			{
				MInOutLine sLine = new MInOutLine(Env.getCtx(), reversal.getM_InOutLine_ID(), get_TrxName());
				if (sLine.getMovementQty().compareTo(this.getQty()) == 0 && sLine.getC_OrderLine_ID() == reversal.getC_OrderLine_ID())
				{
					//clear c_orderline from shipment so we can match the shipment again (to the same or different order line)
					sLine.setC_OrderLine_ID(0);
					sLine.saveEx();					
				}
				//add back qtyOrdered
				MOrderLine oLine = new MOrderLine(Env.getCtx(), reversal.getC_OrderLine_ID(), get_TrxName());
				BigDecimal storageReservationToUpdate = oLine.getQtyReserved();
				oLine.setQtyReserved(oLine.getQtyReserved().add(getQty()));
				BigDecimal reservedAndDelivered = oLine.getQtyDelivered().add(oLine.getQtyReserved());
				if (reservedAndDelivered.compareTo(oLine.getQtyOrdered()) > 0) 
				{
					oLine.setQtyReserved(oLine.getQtyReserved().subtract(reservedAndDelivered.subtract(oLine.getQtyOrdered())));
					if (oLine.getQtyReserved().signum()==-1)
						oLine.setQtyReserved(Env.ZERO);
				}
				oLine.saveEx();
				storageReservationToUpdate = storageReservationToUpdate.subtract(oLine.getQtyReserved());
				if (storageReservationToUpdate.signum() != 0)
				{
					IReservationTracer tracer = null;
					IReservationTracerFactory factory = Core.getReservationTracerFactory();
					if (factory != null) 
					{
						int docTypeId = DB.getSQLValue((String)null, Doc.DOC_TYPE_BY_DOC_BASE_TYPE_SQL, getAD_Client_ID(), Doc.DOCTYPE_MatMatchPO);
						tracer = factory.newTracer(docTypeId, reversal.getDocumentNo(), 10, 
								reversal.get_Table_ID(), reversal.get_ID(), oLine.getM_Warehouse_ID(), 
								oLine.getM_Product_ID(), oLine.getM_AttributeSetInstance_ID(), oLine.getParent().isSOTrx(), 
								get_TrxName());
					}
					boolean success = MStorageReservation.add (Env.getCtx(), oLine.getM_Warehouse_ID(),
						oLine.getM_Product_ID(),
						oLine.getM_AttributeSetInstance_ID(),
						storageReservationToUpdate.negate(), oLine.getParent().isSOTrx(), get_TrxName(), tracer);
					if (!success)
						return false;
				}
			}
			
			// auto create new matchpo if have invoice line
			if ( reversal.getC_InvoiceLine_ID() > 0 && reversal.getM_InOutLine_ID() > 0 )
			{
				MMatchPO[] matchPOs = MMatchPO.getOrderLine(reversal.getCtx(), reversal.getC_OrderLine_ID(), reversal.get_TrxName());
				BigDecimal matchQty = getQty();
				for (MMatchPO matchPO : matchPOs)
				{
					if (matchPO.getReversal_ID() == 0 && !matchPO.isPosted() 
							&& matchPO.getC_InvoiceLine_ID() == reversal.getC_InvoiceLine_ID() 
							&& matchPO.getM_InOutLine_ID() == 0 )  
					{
						matchPO.setQty(matchPO.getQty().add(matchQty));
						matchPO.saveEx();
						matchQty = BigDecimal.ZERO;
						break;
					}
				}
				
				if (matchQty.signum() != 0)
				{
					MMatchPO matchPO = new MMatchPO (getCtx(), 0, get_TrxName());		
					matchPO.setC_OrderLine_ID(getC_OrderLine_ID());
					matchPO.setC_InvoiceLine_ID(getC_InvoiceLine_ID()); 
					matchPO.setM_InOutLine_ID(0);
					matchPO.setAD_Org_ID(getAD_Org_ID());
					matchPO.setQty(getQty());
					matchPO.setDateAcct(getDateAcct());
					matchPO.setDateTrx(getDateTrx());
					matchPO.setM_AttributeSetInstance_ID(getM_AttributeSetInstance_ID());
					matchPO.setM_Product_ID(getM_Product_ID());
					matchPO.setDescription(null);
					matchPO.setProcessed(true);
					matchPO.setPosted (false);					
					matchPO.saveEx();
				}
			}
			return true;
		}
		return false;
	}
	
	/**
	 * @return true if this is created to reverse another match po document
	 */
	public boolean isReversal() {
		if (getReversal_ID() > 0) {
			MMatchPO reversal = new MMatchPO (getCtx(), getReversal_ID(), get_TrxName());
			if (reversal.getM_MatchPO_ID() < getM_MatchPO_ID())
				return true;
		}
		return false;
	}
}	//	MMatchPO
