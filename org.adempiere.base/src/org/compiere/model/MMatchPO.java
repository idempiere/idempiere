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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

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
 *			@see http://sourceforge.net/tracker2/?func=detail&atid=879335&aid=2520591&group_id=176962 
 */
public class MMatchPO extends X_M_MatchPO
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3669451656879485463L;

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
	
	private static MMatchPO create(Properties ctx, MInvoiceLine iLine,
			MInOutLine sLine, int C_OrderLine_ID, Timestamp dateTrx,
			BigDecimal qty, String trxName) {
		MMatchPO retValue = null;
		String sql = "SELECT * FROM M_MatchPO WHERE C_OrderLine_ID=? ORDER BY M_MatchPO_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, C_OrderLine_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MMatchPO mpo = new MMatchPO (ctx, rs, trxName);
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
							Trx trx = trxName != null ? Trx.get(trxName, false) : null;
							Savepoint savepoint = trx != null ? trx.getConnection().setSavepoint() : null;
							MMatchInv matchInv = new MMatchInv(mpo.getCtx(), 0, mpo.get_TrxName());
							matchInv.setC_InvoiceLine_ID(C_InvoiceLine_ID);
							matchInv.setM_Product_ID(mpo.getM_Product_ID());
							matchInv.setM_InOutLine_ID(M_InOutLine_ID);
							matchInv.setAD_Client_ID(mpo.getAD_Client_ID());
							matchInv.setAD_Org_ID(mpo.getAD_Org_ID());
							matchInv.setM_AttributeSetInstance_ID(mpo.getM_AttributeSetInstance_ID());
							matchInv.setQty(mpo.getQty());
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
								//log as debug message and continue
								s_log.fine(msg);
								continue;
							}
							mpo.setMatchInvCreated(matchInv);
							if (savepoint != null) 
							{
								try {
									trx.getConnection().releaseSavepoint(savepoint);
								} catch (Exception e) {}
							}
						}
					}
					if (iLine != null)
						mpo.setC_InvoiceLine_ID(iLine);
					if (sLine != null)
						mpo.setM_InOutLine_ID(sLine.getM_InOutLine_ID());
					
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
				if (qty.signum() > 0)
				{
					retValue = new MMatchPO (sLine, dateTrx, qty);
					retValue.setC_OrderLine_ID(C_OrderLine_ID);
					if (iLine != null)
						retValue.setC_InvoiceLine_ID(iLine);
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
				if (qty.signum() > 0)
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
				}
			}
		}
		
		return retValue;
	}	//	create
	

	private MMatchInv m_matchInv;

	/**
	 * Register the match inv created for immediate accounting purposes
	 * @param matchInv
	 */
	private void setMatchInvCreated(MMatchInv matchInv) {
		m_matchInv = matchInv;
	}

	/**
	 * Get the match inv created for immediate accounting purposes
	 * Is cleared after read, so if you read twice second time it returns null
	 * @param matchInv
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
		//	setC_OrderLine_ID (0);
		//	setDateTrx (new Timestamp(System.currentTimeMillis()));
		//	setM_InOutLine_ID (0);
		//	setM_Product_ID (0);
			setM_AttributeSetInstance_ID(0);
		//	setQty (Env.ZERO);
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
	private boolean m_isInvoiceLineChange = false;
	/** InOut Changed			*/
	private boolean m_isInOutLineChange = false;
	/** Order Line				*/
	private MOrderLine		m_oLine = null;
	/** Invoice Line			*/
	private MInvoiceLine	m_iLine = null;
	
	
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
		if (newRecord && getC_InvoiceLine_ID() == 0) 
		{
			MMatchInv[] mpi = MMatchInv.getInOutLine(getCtx(), getM_InOutLine_ID(), get_TrxName());
			for (int i = 0; i < mpi.length; i++) 
			{
				if (mpi[i].getC_InvoiceLine_ID() != 0 && 
						mpi[i].getM_AttributeSetInstance_ID() == getM_AttributeSetInstance_ID()) 
				{
					setC_InvoiceLine_ID(mpi[i].getC_InvoiceLine_ID());
					break;
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
						.divide(Env.ONEHUNDRED, 2, BigDecimal.ROUND_HALF_UP);
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
				if (matchedQty != null && matchedQty.compareTo(line.getMovementQty()) > 0)
				{
					throw new IllegalStateException("Total matched qty > movement qty. MatchedQty="+matchedQty+", MovementQty="+line.getMovementQty()+", Line="+line);
				}
			}
			
			if (getC_InvoiceLine_ID() > 0)
			{
				MInvoiceLine line = new MInvoiceLine(getCtx(), getC_InvoiceLine_ID(), get_TrxName());
				BigDecimal matchedQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE C_InvoiceLine_ID=?" , getC_InvoiceLine_ID());
				if (matchedQty != null && matchedQty.compareTo(line.getQtyInvoiced()) > 0)
				{
					throw new IllegalStateException("Total matched qty > invoiced qty. MatchedQty="+matchedQty+", InvoicedQty="+line.getQtyInvoiced()+", Line="+line);
				}
			}
			
			if (getC_OrderLine_ID() > 0)
			{
				MOrderLine line = new MOrderLine(getCtx(), getC_OrderLine_ID(), get_TrxName());
				BigDecimal invoicedQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE C_InvoiceLine_ID > 0 and C_OrderLine_ID=?" , getC_OrderLine_ID());
				if (invoicedQty != null && invoicedQty.compareTo(line.getQtyOrdered()) > 0)
				{
					throw new IllegalStateException("Total matched invoiced qty > ordered qty. MatchedInvoicedQty="+invoicedQty+", OrderedQty="+line.getQtyOrdered()+", Line="+line);
				}
				
				BigDecimal deliveredQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE M_InOutLine_ID > 0 and C_OrderLine_ID=?" , getC_OrderLine_ID());
				if (deliveredQty != null && deliveredQty.compareTo(line.getQtyOrdered()) > 0)
				{
					throw new IllegalStateException("Total matched delivered qty > ordered qty. MatchedDeliveredQty="+deliveredQty+", OrderedQty="+line.getQtyOrdered()+", Line="+line);
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
				else //	if (getM_InOutLine_ID() == 0)					//	reset to 0
					orderLine.setQtyDelivered(orderLine.getQtyDelivered().subtract(getQty()));
				orderLine.setDateDelivered(getDateTrx());	//	overwrite=last
			}
			if (m_isInvoiceLineChange && (newRecord || getC_InvoiceLine_ID() != get_ValueOldAsInt("C_InvoiceLine_ID")))
			{
				if (getC_InvoiceLine_ID() != 0)						//	first time
					orderLine.setQtyInvoiced(orderLine.getQtyInvoiced().add(getQty()));
				else //	if (getC_InvoiceLine_ID() == 0)				//	set to 0
					orderLine.setQtyInvoiced(orderLine.getQtyInvoiced().subtract(getQty()));
				orderLine.setDateInvoiced(getDateTrx());	//	overwrite=last
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
			// AZ Goodwill
			deleteMatchPOCostDetail();
			// end AZ
			
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
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Consolidate MPO entries.
	 * 	(data conversion issue)
	 * 	@param ctx context
	 */
	public static void consolidate(Properties ctx)
	{
		String sql = "SELECT * FROM M_MatchPO po "
			+ "WHERE EXISTS (SELECT 1 FROM M_MatchPO x "
				+ "WHERE po.C_OrderLine_ID=x.C_OrderLine_ID AND po.Qty=x.Qty "
				+ "GROUP BY C_OrderLine_ID, Qty "
				+ "HAVING COUNT(*) = 2) "
			+ " AND AD_Client_ID=?"
			+ "ORDER BY C_OrderLine_ID, M_InOutLine_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int success = 0;
		int errors = 0;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt(1, Env.getAD_Client_ID(ctx));
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MMatchPO po1 = new MMatchPO (ctx, rs, null);
				if (rs.next())
				{
					MMatchPO po2 = new MMatchPO (ctx, rs, null);
					if (po1.getM_InOutLine_ID() != 0 && po1.getC_InvoiceLine_ID() == 0 
						&& po2.getM_InOutLine_ID() == 0 && po2.getC_InvoiceLine_ID() != 0)
					{
						StringBuilder s1 = new StringBuilder("UPDATE M_MatchPO SET C_InvoiceLine_ID=") 
							.append(po2.getC_InvoiceLine_ID()) 
							.append(" WHERE M_MatchPO_ID=").append(po1.getM_MatchPO_ID());
						int no1 = DB.executeUpdate(s1.toString(), null);
						if (no1 != 1)
						{
							errors++;
							s_log.warning("Not updated M_MatchPO_ID=" + po1.getM_MatchPO_ID());
							continue;
						}
						//
						String s2 = "DELETE FROM Fact_Acct WHERE AD_Table_ID=473 AND Record_ID=?";
						int no2 = DB.executeUpdate(s2, po2.getM_MatchPO_ID(), null);
						String s3 = "DELETE FROM M_MatchPO WHERE M_MatchPO_ID=?";
						int no3 = DB.executeUpdate(s3, po2.getM_MatchPO_ID(), null);
						if (no2 == 0 && no3 == 1)
							success++;
						else
						{
							s_log.warning("M_MatchPO_ID=" + po2.getM_MatchPO_ID()
								+ " - Deleted=" + no2 + ", Acct=" + no3); 
							errors++;
						}
					}
				}
			}
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (errors == 0 && success == 0)
			;
		else
			if (s_log.isLoggable(Level.INFO)) s_log.info("Success #" + success + " - Error #" + errors);
	}	//	consolidate
	
	//AZ Goodwill
	private String deleteMatchPOCostDetail()
	{
		// Get Account Schemas to delete MCostDetail
		MAcctSchema[] acctschemas = MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID());
		for(int asn = 0; asn < acctschemas.length; asn++)
		{
			MAcctSchema as = acctschemas[asn];
			
			if (as.isSkipOrg(getAD_Org_ID()))
			{
				continue;
			}
			
			// update/delete Cost Detail and recalculate Current Cost
			MCostDetail cd = MCostDetail.get (getCtx(), "C_OrderLine_ID=?", 
					getC_OrderLine_ID(), getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), get_TrxName());
			if (cd != null)
			{
				if (cd.isProcessed())
				{
					if (cd.getQty().compareTo(Env.ZERO) > 0)
					{
						BigDecimal price = cd.getAmt().divide(cd.getQty(),12,BigDecimal.ROUND_HALF_UP);
						cd.setDeltaAmt(price.multiply(getQty().negate()));
						cd.setDeltaQty(getQty().negate());
						cd.setProcessed(false);
						//
						cd.setAmt(price.multiply(cd.getQty().subtract(getQty())));
						cd.setQty(cd.getQty().subtract(getQty()));
						if (!cd.isProcessed())
						{
							cd.process();
						}
					}
					//after process clean-up
					if (cd.getQty().compareTo(Env.ZERO) == 0)
					{
						cd.setProcessed(false);
						cd.delete(true);
					}
				}
				else
				{
					cd.delete(true);
				}
			}
		}
		
		return "";
	}

	/**
	 * 	Reverse MatchPO.
	 *  @param reversalDate
	 *	@return boolean
	 *	@throws Exception
	 */

	public boolean reverse(Timestamp reversalDate)  
	{
		if (this.isPosted() && this.getReversal_ID() == 0)
		{		
			MMatchPO reversal = new MMatchPO (getCtx(), 0, get_TrxName());
			reversal.setC_InvoiceLine_ID(getC_InvoiceLine_ID()); 
			reversal.setM_InOutLine_ID(getM_InOutLine_ID()); 
			PO.copyValues(this, reversal);
			reversal.setAD_Org_ID(this.getAD_Org_ID());
			reversal.setDescription("(->" + this.getDocumentNo() + ")");
			reversal.setQty(this.getQty().negate());
			reversal.setDateAcct(reversalDate);
			reversal.setDateTrx(reversalDate);
			reversal.set_ValueNoCheck ("DocumentNo", null);
			reversal.setPosted (false);
			reversal.setReversal_ID(getM_MatchPO_ID());   
			reversal.saveEx();
			this.setDescription("(" + reversal.getDocumentNo() + "<-)");			
			this.setReversal_ID(reversal.getM_MatchPO_ID());
			this.saveEx();
			return true;
		}
		return false;
	}
}	//	MMatchPO
