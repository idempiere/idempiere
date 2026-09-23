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
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.IReservationTracer;
import org.adempiere.util.IReservationTracerFactory;
import org.compiere.process.DocAction;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.acct.IDoc;

/**
 *	Match PO Model.
 *  <pre>
 *  Created when processing Shipment or Order
 *  - Updates Order (delivered, invoiced)
 *  - Creates PPV acct
 *	</pre>
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
	 * generated serial id
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
	
	/**
	 * 	Update or Create Match PO record
	 *	@param iLine invoice line
	 *	@param sLine receipt line
	 *	@param dateTrx transaction date
	 *	@param qty qty to match
	 *	@return Match PO Record
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
	
	/**
	 * Update existing M_MatchPO record(s) or create new one(s) to match qty between an invoice
	 * line, a receipt line, or both, against a given order line.
	 * <p>
	 * This method handles the standard PO matching cases plus lot/serial-aware ("ASI-aware")
	 * splitting: when a receipt line's own M_AttributeSetInstance_ID is 0 (because its quantity
	 * was received across multiple lots/serials, tracked individually in M_InOutLineMA), a single
	 * matching request may need to be fulfilled by MULTIPLE M_MatchPO records - one per distinct
	 * lot/ASI - rather than one M_MatchPO carrying an ambiguous or blank ASI. This matters for
	 * costing: M_CostDetail lookups key off (C_OrderLine_ID, M_AttributeSetInstance_ID), so an
	 * M_MatchPO with the wrong or missing ASI can silently attach to the wrong cost layer.
	 * <p>
	 * Overall flow:
	 * <ol>
	 *   <li>Phase 1: try to satisfy {@code qty} by completing existing "half-matched" M_MatchPO
	 *       stubs (records that already have either an invoice line or a receipt line linked,
	 *       but not both) via {@link MatchPOAutoMatch#getNotMatchedMatchPOList}.</li>
	 *   <li>Phase 2 ("Create New"): if Phase 1 didn't fully satisfy {@code qty}, create brand-new
	 *       M_MatchPO record(s) from whichever of iLine/sLine was passed in.</li>
	 * </ol>
	 *
	 * @param ctx context
	 * @param iLine invoice line to match, or null if matching a receipt line without an invoice yet
	 * @param sLine receipt line to match, or null if matching an invoice line without a receipt yet
	 * @param C_OrderLine_ID the order line both sides are being reconciled against
	 * @param dateTrx transaction date to stamp on new/updated records
	 * @param qty quantity still needing to be matched (mutated/reduced as candidates are consumed)
	 * @param trxName transaction
	 * @return the first M_MatchPO record created/updated to satisfy the match (representative
	 *         record only - if lot-splitting created siblings, only the first is returned, but
	 *         all siblings are saved before this method returns)
	 */
	protected static MMatchPO create(Properties ctx, MInvoiceLine iLine,
			MInOutLine sLine, int C_OrderLine_ID, Timestamp dateTrx,
			BigDecimal qty, String trxName) {
		MMatchPO retValue = null;

		// ============================================================================
		// PHASE 1: Try to satisfy qty using existing "not fully matched" M_MatchPO stubs
		// (records missing either their invoice-line or receipt-line link) for this order line.
		// This reuses partially-matched records instead of always creating brand-new ones -
		// e.g. an invoice was already recorded against this order line, and now the matching
		// receipt has arrived, so we complete the existing stub rather than duplicate it.
		// ============================================================================
		List<MMatchPO> matchPOList = MatchPOAutoMatch.getNotMatchedMatchPOList(ctx, C_OrderLine_ID, trxName);
		if (!matchPOList.isEmpty())
		{
			for (MMatchPO mpo : matchPOList)
			{
				// Only consider this candidate if the requested qty is large enough to fully
				// absorb it. This method never splits mpo's OWN qty down to a partial slice here -
				// it either fully consumes mpo (matching toMatch = mpo.getQty()) or skips it.
				// (Lot/ASI-based splitting below is a different kind of split: it may turn ONE
				// mpo into several sibling M_MatchPO records, each still summing to mpo's qty.)
				if (qty.compareTo(mpo.getQty()) >= 0)
				{
					BigDecimal toMatch = qty;
					BigDecimal matchQty = mpo.getQty();
					if (toMatch.compareTo(matchQty) > 0)
						toMatch = matchQty;

					// --- Invoice-side ASI reconciliation ---
					// If iLine is supplied and either mpo has no invoice link yet or already
					// points to this same invoice line, adopt iLine's ASI onto mpo (if mpo doesn't
					// have one yet), or reject this candidate if the ASIs conflict.
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
									continue; // ASI conflict - this stub belongs to a different lot
							}
						}
						else
							continue; // already linked to a different invoice line entirely
					}

					// ---- BEGIN qty-aware, lot-aware ASI resolution ----
					// lotMatches collects every M_MatchPO record that must be saved to fully
					// represent this match: normally just [mpo] itself, but if the receipt line's
					// qty spans multiple lots/ASIs, this can contain mpo (now sized down to its
					// first lot's slice) PLUS one or more brand-new "overflow" sibling records,
					// one per additional lot needed to cover mpo's original qty.
					List<MMatchPO> lotMatches = new ArrayList<MMatchPO>();
					// Set when the receipt's lot data can't fully account for mpo's qty - in that
					// case we abandon this candidate entirely rather than partially match it.
					boolean skipThisCandidate = false;

					if (sLine != null)
					{
						if ((mpo.getM_InOutLine_ID() == 0)
							|| (mpo.getM_InOutLine_ID() == sLine.getM_InOutLine_ID()))
						{
							if (sLine.getM_AttributeSetInstance_ID() != 0)
							{
								// Simple case: receipt line has a single ASI for its whole qty
								// (no lot splitting needed). Same adopt-or-reject logic as above.
								if (mpo.getM_AttributeSetInstance_ID() == 0)
									mpo.setM_AttributeSetInstance_ID(sLine.getM_AttributeSetInstance_ID());
								else if (mpo.getM_AttributeSetInstance_ID() != sLine.getM_AttributeSetInstance_ID())
									continue;
								lotMatches.add(mpo);
							}
							else if (mpo.getM_AttributeSetInstance_ID() != 0)
							{
								// sLine's own ASI is 0 (multi-lot receipt line), but mpo already
								// picked up an ASI earlier in this loop iteration (e.g. from the
								// iLine block above). Trust that assignment rather than re-deriving
								// it from M_InOutLineMA - avoids double-resolving the same value.
								lotMatches.add(mpo);
							}
							else
							{
								// Hard case: sLine's qty is split across multiple lots/ASIs
								// (M_InOutLineMA rows) and mpo has no ASI yet. Query how much
								// qty is still free per ASI (summed across all M_InOutLineMA rows
								// sharing that ASI, minus what other M_MatchPO rows already claimed).
								Map<Integer, BigDecimal> availableByASI = getAvailableQtyByASI(trxName, sLine.getM_InOutLine_ID(), mpo.getM_MatchPO_ID());
								if (availableByASI.isEmpty())
								{
									// No lot/ASI data at all to allocate against (e.g. data gap) -
									// degrade gracefully to the pre-existing no-ASI behavior rather
									// than fail the match outright.
									lotMatches.add(mpo);
								}
								else
								{
									// Walk lots oldest-first (see getAvailableQtyByASI ordering),
									// consuming mpo's qty against each lot's available balance
									// until fully allocated.
									BigDecimal remainingToAllocate = mpo.getQty();
									boolean firstLotUsed = false;

									for (Map.Entry<Integer, BigDecimal> entry : availableByASI.entrySet())
									{
										if (remainingToAllocate.signum() <= 0)
											break;

										BigDecimal avail = entry.getValue();
										BigDecimal take = avail.compareTo(remainingToAllocate) >= 0
												? remainingToAllocate  // this lot alone covers the rest
												: avail;               // this lot only partially covers it
										if (take.signum() <= 0)
											continue;

										if (!firstLotUsed)
										{
											// First lot: reuse mpo itself, just resize its qty/ASI
											// rather than creating an extra record for no reason.
											mpo.setM_AttributeSetInstance_ID(entry.getKey());
											if (take.compareTo(mpo.getQty()) < 0)
												mpo.setQty(take);
											lotMatches.add(mpo);
											firstLotUsed = true;
										}
										else
										{
											// Second and subsequent lots: mpo can't represent two
											// ASIs at once, so spin up a new sibling M_MatchPO
											// carrying this lot's ASI and qty slice. Together with
											// mpo (and any other siblings), these sum back to mpo's
											// original qty.
											MMatchPO overflow = new MMatchPO(sLine, dateTrx, take);
											overflow.setC_OrderLine_ID(C_OrderLine_ID);
											overflow.setM_AttributeSetInstance_ID(entry.getKey());
											lotMatches.add(overflow);
										}
										remainingToAllocate = remainingToAllocate.subtract(take);
									}

									if (remainingToAllocate.signum() > 0)
									{
										// The receipt's known lots don't add up to mpo's qty -
										// something is inconsistent (e.g. missing M_InOutLineMA
										// rows). Rather than guess, abandon this candidate.
										skipThisCandidate = true;
									}
								}
							}
						}						
						else
							continue; // mpo is tied to a different receipt line entirely
						if (iLine == null && mpo.isPosted())
							continue; // can't attach a new receipt to an already-posted match
					}
					else
					{
						// No receipt line involved in this call at all (pure invoice-side match) -
						// nothing to split, just carry mpo through unchanged.
						lotMatches.add(mpo);
					}

					if (skipThisCandidate)
						continue;
					// ---- END qty-aware, lot-aware ASI resolution ----

					// Guard: if we're matching a receipt-less invoice line against a stub that
					// has no invoice link yet, make sure no M_MatchInv already exists for this
					// receipt against some OTHER invoice - that would indicate the receipt is
					// already fully accounted for elsewhere.
					if (iLine != null && sLine == null && mpo.getC_InvoiceLine_ID() == 0)
					{
						int cnt = DB.getSQLValue(iLine.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+mpo.getM_InOutLine_ID()
								+" AND C_InvoiceLine_ID != "+iLine.getC_InvoiceLine_ID() + " AND Reversal_ID=0");
						if (cnt > 0)
							continue;
					}

					// ---- BEGIN per-lot invoice-line linkage + MMatchInv creation + save ----
					// IMPORTANT: these guards must behave like the original single-record continues -
					// i.e. abort the WHOLE candidate (skip qty subtraction / retValue assignment below)
					// rather than silently dropping just one lotMatches sibling while the outer
					// bookkeeping proceeds as if the candidate fully succeeded.
					boolean candidateAborted = false;

					// Pre-resolve invoice-line/M_MatchInv target ids per slice so we can validate before
					// mutating/saving anything.
					Map<MMatchPO, int[]> resolvedIds = new LinkedHashMap<MMatchPO, int[]>(); // m -> {M_InOutLine_ID, C_InvoiceLine_ID}
					for (MMatchPO m : lotMatches)
					{
					    if ((iLine != null || m.getC_InvoiceLine_ID() > 0) && (sLine != null || m.getM_InOutLine_ID() > 0))
					    {
					        int M_InOutLine_ID = sLine != null ? sLine.getM_InOutLine_ID() : m.getM_InOutLine_ID();
					        int C_InvoiceLine_ID = iLine != null ? iLine.getC_InvoiceLine_ID() : m.getC_InvoiceLine_ID();

					        int tmpInOutLineId = DB.getSQLValue(m.get_TrxName(), "SELECT M_InOutLine_ID FROM C_InvoiceLine WHERE C_InvoiceLine_ID="+C_InvoiceLine_ID);
					        if (tmpInOutLineId > 0 && tmpInOutLineId != M_InOutLine_ID)
					        {
					            // This invoice line is already tied to a DIFFERENT receipt line - the whole
					            // candidate is unmatchable as constructed, not just this one slice.
					            candidateAborted = true;
					            break;
					        }
					        resolvedIds.put(m, new int[]{M_InOutLine_ID, C_InvoiceLine_ID});
					    }
					    else
					    {
					        resolvedIds.put(m, null); // no MatchInv step needed for this slice
					    }
					}

					if (candidateAborted)
					    continue; // abandon this candidate entirely - try the next one in matchPOList

					// All slices passed validation - now actually create MMatchInv records and save.
					for (MMatchPO m : lotMatches)
					{
					    int[] ids = resolvedIds.get(m);
					    if (ids != null)
					    {
					        int M_InOutLine_ID = ids[0];
					        int C_InvoiceLine_ID = ids[1];

					        int cnt = DB.getSQLValue(m.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+M_InOutLine_ID
					                +" AND C_InvoiceLine_ID="+C_InvoiceLine_ID);
					        if (cnt <= 0)
					        {
					            MMatchInv matchInv = createMatchInv(m, C_InvoiceLine_ID, M_InOutLine_ID, m.getQty(), dateTrx, trxName);
					            if (matchInv == null)
					            {
					                // createMatchInv failed for this slice - abort the whole candidate rather
					                // than leave some siblings saved and others not.
					                candidateAborted = true;
					                break;
					            }
					            m.setMatchInvCreated(matchInv);
					        }
					    }
					    if (iLine != null)
					        m.setC_InvoiceLine_ID(iLine);
					    if (sLine != null){
					        m.setM_InOutLine_ID(sLine.getM_InOutLine_ID());
					        if (!m.isPosted())
					            m.setDateAcct(sLine.getParent().getDateAcct());
					    }

					    if (!m.save())
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

					if (candidateAborted)
					    continue; // abandon - some slices may already be saved; see caveat below
					// ---- END per-lot invoice-line linkage + MMatchInv creation + save ----

					qty = qty.subtract(toMatch);					
					if (qty.signum() <= 0)
					{
					    retValue = mpo;
					    break;
					}
				}
			}
		}
		
		// ============================================================================
		// PHASE 2 ("Create New"): only runs if Phase 1 didn't fully satisfy qty
		// (retValue is still null). Two mutually-exclusive branches depending on whether
		// a receipt line or only an invoice line is available to originate a new record from.
		// ============================================================================
		if (retValue == null)
		{
			// If both iLine and sLine are given, check whether this receipt line has already
			// been (partially) matched against this order line before - if so, we should not
			// create ANOTHER brand-new record from it here (branch below is skipped in that case).
			BigDecimal sLineMatchedQty = null; 
			if (sLine != null && iLine != null)
			{
				sLineMatchedQty = DB.getSQLValueBD(sLine.get_TrxName(), "SELECT Sum(Qty) FROM M_MatchPO WHERE C_OrderLine_ID="+C_OrderLine_ID+" AND M_InOutLine_ID=?", sLine.getM_InOutLine_ID());
			}
			
			// --- Branch A: receipt-first creation ---
			// Taken when sLine belongs to this same order line (or there's no invoice context
			// at all), and this receipt line hasn't already been matched here.
			if (sLine != null && (sLine.getC_OrderLine_ID() == C_OrderLine_ID || iLine == null)
				&& (sLineMatchedQty == null || sLineMatchedQty.signum() <= 0))
			{				
				if (qty.signum() != 0)
				{
					// ---- BEGIN qty-aware, lot-aware new-record creation ----
					// Same lot-splitting idea as Phase 1, but here there's no existing mpo to
					// reuse - every slice becomes a brand-new M_MatchPO via
					// createNewMatchPOFromReceiptSlice, which also handles borrowing an existing
					// invoice-only stub per slice (see that method's Javadoc).
					Map<Integer, BigDecimal> availableByASI = null;
					if (sLine.getM_AttributeSetInstance_ID() == 0)
						// Only bother querying lot data if the receipt line's own ASI is blank -
						// a single-ASI receipt line needs no splitting at all.
						availableByASI = getAvailableQtyByASI(trxName, sLine.getM_InOutLine_ID(), 0);

					List<MMatchPO> newMatches = new ArrayList<MMatchPO>();

					if (availableByASI == null || availableByASI.isEmpty())
					{
						// Single-ASI receipt line, or no lot data to allocate against - fall back
						// to the original single-record behavior (ASI comes from sLine directly
						// via the MMatchPO(MInOutLine, ...) constructor, or stays 0).
						newMatches.add(createNewMatchPOFromReceiptSlice(iLine, sLine, C_OrderLine_ID, dateTrx, qty, -1, trxName));
					}
					else
					{
						// Multi-lot receipt line: slice qty across ASIs oldest-lot-first,
						// creating one new M_MatchPO per slice actually needed.
						BigDecimal remaining = qty;
						for (Map.Entry<Integer, BigDecimal> entry : availableByASI.entrySet())
						{
							if (remaining.signum() <= 0)
								break;
							BigDecimal avail = entry.getValue();
							BigDecimal take = avail.compareTo(remaining) >= 0 ? remaining : avail;
							if (take.signum() <= 0)
								continue;

							newMatches.add(createNewMatchPOFromReceiptSlice(iLine, sLine, C_OrderLine_ID, dateTrx, take, entry.getKey(), trxName));
							remaining = remaining.subtract(take);
						}
						if (remaining.signum() > 0)
						{
							// Known lots didn't fully cover the requested qty (data gap) -
							// rather than fail, assign the leftover to ASI 0 so the total matched
							// qty still reconciles with the receipt's MovementQty (afterSave()
							// validates matched-qty-vs-movement-qty and would otherwise throw).
							// TODO: consider logging a warning here, since this indicates the
							// M_InOutLineMA data doesn't fully account for the receipt's qty.
							newMatches.add(createNewMatchPOFromReceiptSlice(iLine, sLine, C_OrderLine_ID, dateTrx, remaining, 0, trxName));
						}
					}

					// retValue is just the first slice created; it's used below purely as a
					// representative record for MatchPOAutoMatch.match() and as this method's
					// return value. All slices in newMatches are already saved at this point.
					if (!newMatches.isEmpty())
						retValue = newMatches.get(0);
					// ---- END qty-aware, lot-aware new-record creation ----
				}
			}
			// --- Branch B: invoice-only creation ---
			// Taken when Branch A's conditions don't apply (no usable sLine) but iLine is present.
			// Creates a new M_MatchPO with no receipt link yet, then tries to auto-attach it to
			// existing un-invoiced receipts on this order line (handles "invoice arrived before/
			// separately from receipt, possibly split across multiple receipts" scenarios).
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
					
					// --- Auto-match this new invoice-only record against un-invoiced receipts ---
					// noInvoiceLines: M_MatchPO_ID -> remaining un-invoiced qty (as a 1-element
					//   array so it can be mutated in place inside the loops below).
					// invoiceMatched: M_InOutLine_ID -> list of M_MatchPO rows already linking
					//   that receipt line to SOME invoice (used to compute how much of each
					//   receipt's qty is already claimed by other invoices).
					// noInvoiceList: candidate M_MatchPO rows (receipt-linked, no invoice yet,
					//   from a completed/closed shipment) that this new record might attach to.
					Map<Integer, BigDecimal[]> noInvoiceLines = new HashMap<>();
					Map<Integer, List<MMatchPO>> invoiceMatched = new HashMap<Integer, List<MMatchPO>>();
					List<MMatchPO> noInvoiceList = new ArrayList<MMatchPO>();
					//get all matchpo with inoutline for C_OrderLine_ID
					MMatchPO[] matchPOs = MMatchPO.getOrderLine(iLine.getCtx(), C_OrderLine_ID, iLine.get_TrxName());
					for (MMatchPO matchPO : matchPOs)
					{
						if (matchPO.getM_MatchPO_ID() == retValue.getM_MatchPO_ID())
							continue; // skip the record we just created

						// Only consider "real" receipt-linked matches: not reversals, not
						// overflow siblings created by another match (Ref_MatchPO_ID == 0).
						if (matchPO.getM_InOutLine_ID() > 0 && matchPO.getReversal_ID() == 0 && matchPO.getRef_MatchPO_ID() == 0)
						{
							if (matchPO.getC_InvoiceLine_ID() == 0)
							{
								// Candidate: receipt-linked, no invoice yet. Only eligible if the
								// underlying shipment is Completed/Closed (not still in-progress).
								MInOutLine iol = new MInOutLine(iLine.getCtx(), matchPO.getM_InOutLine_ID(), iLine.get_TrxName());
								String docStatus = iol.getParent().getDocStatus();
								if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) 
								{
									noInvoiceLines.put(matchPO.getM_MatchPO_ID(), new BigDecimal[]{matchPO.getQty()});
									noInvoiceList.add(matchPO);
								}
							}
							else
							{
								// This receipt line is already claimed (fully or partially) by
								// some OTHER invoice line - track it so we can compute how much of
								// the receipt's total qty is still free below.
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
					
					// Process candidates in creation order (oldest M_MatchPO_ID first), so
					// earlier receipts get matched before later ones - a simple FIFO tie-break.
					Collections.sort(noInvoiceList, new Comparator<MMatchPO>() {
						@Override
						public int compare(MMatchPO arg0, MMatchPO arg1) {
							return arg0.getM_MatchPO_ID() > arg1.getM_MatchPO_ID() 
									? 1
									: (arg0.getM_MatchPO_ID()==arg1.getM_MatchPO_ID() ? 0 : -1);
						}
					});
					
					// For each candidate receipt, work out how much of its qty is genuinely
					// still un-invoiced: start from matchPO.getQty() (the full receipt-matched
					// qty) and subtract any M_MatchInv amounts already recorded against it where
					// the corresponding invoice is Completed/Closed (i.e. genuinely committed,
					// not just a draft).
					for (MMatchPO matchPO : noInvoiceList)
					{
						BigDecimal[] qtyHolder = noInvoiceLines.get(matchPO.getM_MatchPO_ID());
						List<MMatchPO> matchedInvoices = invoiceMatched.get(matchPO.getM_InOutLine_ID());
						MMatchInv[] matchInvoices = MMatchInv.getInOutLine(iLine.getCtx(), matchPO.getM_InOutLine_ID(), iLine.get_TrxName());
						for (MMatchInv matchInv : matchInvoices)
						{
							if (matchInv.getReversal_ID() > 0)
								continue; // ignore reversed match-inv records
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
								MInvoiceLine il = new MInvoiceLine(ctx, matchInv.getC_InvoiceLine_ID(), trxName);
								String docStatus = il.getParent().getDocStatus();
								if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) 
								{
									qtyHolder[0] = qtyHolder[0].subtract(balance);
								}
							}
						}							
					}
					
					// Greedily consume retValue's qty (toMatch) against the still-free balance of
					// each candidate receipt, in the sorted order above, creating an M_MatchInv for
					// each slice actually needed until either retValue's qty or the candidate list
					// is exhausted.
					BigDecimal toMatch = retValue.getQty();
					for (MMatchPO matchPO : noInvoiceList)
					{
						BigDecimal[] qtyHolder = noInvoiceLines.get(matchPO.getM_MatchPO_ID());
						if (qtyHolder[0].signum() > 0)
						{
							BigDecimal autoMatchQty = null;
							if (qtyHolder[0].compareTo(toMatch) >= 0)
							{
								// this receipt alone can cover the rest of retValue's qty
								autoMatchQty = toMatch;
								toMatch = BigDecimal.ZERO;
							}
							else
							{
								// this receipt only partially covers it; move to the next one after
								autoMatchQty = qtyHolder[0];
								toMatch = toMatch.subtract(autoMatchQty);
							}
							if (autoMatchQty != null && autoMatchQty.signum() > 0)
							{
								// Guard against creating a duplicate M_MatchInv if one already
								// exists between this receipt and retValue's invoice line.
								MMatchInv[] matchInvoices = MMatchInv.get(Env.getCtx(), matchPO.getM_InOutLine_ID(), retValue.getC_InvoiceLine_ID(), trxName);
								if (matchInvoices == null || matchInvoices.length == 0)
								{
									MMatchInv matchInv = createMatchInv(retValue, retValue.getC_InvoiceLine_ID(), matchPO.getM_InOutLine_ID(), autoMatchQty, dateTrx, trxName);
									retValue.setMatchInvCreated(matchInv);
									if (matchInv == null)
										break; // stop trying further receipts on failure
								}
							}
						}
						if (toMatch.signum() <= 0)
							break; // retValue's qty is fully accounted for
					}
				}
			}
		}
		
		// Run any further order-line-level auto-matching/consistency pass (e.g. reconciling
		// sibling M_MatchPO records created above) now that this order line's state has changed.
		if (C_OrderLine_ID > 0 && retValue != null)
			MatchPOAutoMatch.match(ctx, C_OrderLine_ID, retValue, trxName);
				
		return retValue;
	}	//	create

	/**
	 * Computes, for a given receipt line, how much quantity is still available to allocate
	 * per distinct {@code M_AttributeSetInstance_ID} (lot/serial).
	 * <p>
	 * A single receipt line can have MULTIPLE {@code M_InOutLineMA} rows sharing the same ASI
	 * (e.g. the same lot received/consumed across different {@code DateMaterialPolicy} cost-layer
	 * buckets for FIFO/LIFO costing) - see {@link MInOutLineMA#addOrCreate} which de-duplicates on
	 * {@code (M_InOutLine_ID, M_AttributeSetInstance_ID, DateMaterialPolicy)}, not on ASI alone.
	 * This method sums those rows together PER ASI, so each distinct lot/serial is represented
	 * exactly once regardless of how many date-buckets it's spread across underneath.
	 * <p>
	 * The result is further reduced by quantity already claimed by other saved, non-reversed
	 * {@code M_MatchPO} rows against the same receipt line + ASI combination, so callers get a
	 * true "still free to allocate" number rather than the raw received quantity.
	 * <p>
	 * Rows with {@code M_AttributeSetInstance_ID = 0} are excluded entirely - there is no lot/ASI
	 * to assign from them, so they're not useful input to the M_MatchPO ASI-splitting logic above.
	 * <p>
	 * Ordering: results are ordered oldest-lot-first (by earliest {@code DateMaterialPolicy} per
	 * ASI), which assumes FIFO-style consumption. If the product/organization uses a different
	 * costing/valuation method, this ordering should be revisited - it currently doesn't consult
	 * {@code MStorageOnHand}'s own policy resolution.
	 *
	 * @param trxName transaction
	 * @param M_InOutLine_ID the receipt line to inspect
	 * @param excludeMatchPO_ID an M_MatchPO_ID to exclude from the "already consumed" calculation
	 *        (typically the record currently being resolved, so its own prior qty doesn't count
	 *        against itself)
	 * @return ordered map of M_AttributeSetInstance_ID -> remaining available qty; ASIs with
	 *         nothing left available are omitted entirely
	 */
	private static Map<Integer, BigDecimal> getAvailableQtyByASI(String trxName, int M_InOutLine_ID, int excludeMatchPO_ID)
	{
		Map<Integer, BigDecimal> byASI = new LinkedHashMap<Integer, BigDecimal>();

		// Group by ASI and sum MovementQty across all DateMaterialPolicy buckets for that ASI.
		// NULLS LAST keeps rows with a null DateMaterialPolicy (shouldn't normally happen once
		// M_InOutLineMA.beforeSave() resolves it, but defensive ordering costs nothing) sorted
		// after dated rows rather than unpredictably first. Compatible with both PostgreSQL and
		// Oracle syntax.
		String sql = "SELECT M_AttributeSetInstance_ID, SUM(MovementQty) "
				+ "FROM M_InOutLineMA WHERE M_InOutLine_ID=? AND M_AttributeSetInstance_ID<>0 "
				+ "GROUP BY M_AttributeSetInstance_ID "
				+ "ORDER BY MIN(DateMaterialPolicy) ASC NULLS LAST, M_AttributeSetInstance_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			pstmt.setInt(1, M_InOutLine_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
				byASI.put(rs.getInt(1), rs.getBigDecimal(2));
		}
		catch (SQLException e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}

		// Subtract qty already claimed by OTHER M_MatchPO rows for this line+ASI, so the caller
		// sees genuinely free quantity rather than the raw total ever received under that ASI.
		for (Map.Entry<Integer, BigDecimal> entry : byASI.entrySet())
		{
			BigDecimal consumed = DB.getSQLValueBD(trxName,
				"SELECT COALESCE(SUM(Qty),0) FROM M_MatchPO WHERE M_InOutLine_ID=? AND M_AttributeSetInstance_ID=? "
				+ "AND M_MatchPO_ID<>? AND Reversal_ID=0",
				new Object[] { M_InOutLine_ID, entry.getKey(), excludeMatchPO_ID });
			entry.setValue(entry.getValue().subtract(consumed == null ? BigDecimal.ZERO : consumed));
		}
		// Drop any ASI with nothing left to allocate - callers shouldn't see zero/negative entries.
		byASI.values().removeIf(v -> v.signum() <= 0);
		return byASI;
	}

	/**
	 * Creates a single new {@code M_MatchPO} record representing one lot/ASI "slice" of a
	 * receipt line's quantity, and attempts to auto-attach it to an existing invoice.
	 * <p>
	 * This factors out the body of the original single-record "Create New" (receipt-first)
	 * logic so it can be invoked once per lot when a receipt line's qty is split across multiple
	 * ASIs (see the caller in {@link #create}), while still behaving identically to the original
	 * single-shot code path when {@code forceASI = -1} and only one slice is ever created.
	 * <p>
	 * If {@code iLine} is null, this method searches for an existing invoice-only M_MatchPO stub
	 * (already linked to an invoice, not yet to any receipt) large enough to cover this slice's
	 * qty, and "borrows" it: the stub's qty is reduced by this slice's qty (or deleted if it
	 * reaches zero), and this slice adopts that stub's invoice line instead of remaining
	 * receipt-only. This handles the case where an invoice was recorded before this particular
	 * lot's receipt arrived.
	 *
	 * @param iLine invoice line to attach directly, or null to search for a borrowable stub
	 * @param sLine the receipt line this slice originates from
	 * @param C_OrderLine_ID order line to attribute this match to
	 * @param dateTrx transaction date
	 * @param qty the qty for JUST this slice/lot (not necessarily the receipt line's full qty)
	 * @param forceASI the M_AttributeSetInstance_ID to assign to this slice, or -1 to leave
	 *        whatever the {@code MMatchPO(MInOutLine, ...)} constructor derives from sLine itself
	 *        (used for the "no lot-splitting needed" single-ASI case)
	 * @param trxName transaction
	 * @return the newly created and saved M_MatchPO record for this slice
	 */
	private static MMatchPO createNewMatchPOFromReceiptSlice(MInvoiceLine iLine, MInOutLine sLine,
			int C_OrderLine_ID, Timestamp dateTrx, BigDecimal qty, int forceASI, String trxName)
	{
		MMatchPO retValue = new MMatchPO(sLine, dateTrx, qty);
		retValue.setC_OrderLine_ID(C_OrderLine_ID);
		if (forceASI >= 0)
			retValue.setM_AttributeSetInstance_ID(forceASI);

		MMatchPO otherMatchPO = null;   // an existing invoice-only stub we may borrow, if found
		MInvoiceLine sliceILine = iLine; // the invoice line this slice will ultimately attach to

		if (sliceILine == null)
		{
			// Search this order line's other M_MatchPO records for an invoice-only stub
			// (has an invoice, no receipt yet, not a reversal, not already posted) that is
			// large enough to fully cover this slice's qty, and hasn't already been matched
			// to some receipt at a different qty (which would indicate it's already spoken for).
			MMatchPO[] matchPOs = MMatchPO.getOrderLine(retValue.getCtx(), sLine.getC_OrderLine_ID(), retValue.get_TrxName());
			for (MMatchPO matchPO : matchPOs)
			{
				if (matchPO.getC_InvoiceLine_ID() > 0 && matchPO.getM_InOutLine_ID() == 0 && matchPO.getReversal_ID() == 0
					&& matchPO.getQty().compareTo(retValue.getQty()) >= 0)
				{
					int cnt = DB.getSQLValueEx(sLine.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+sLine.getM_InOutLine_ID()
							+" AND C_InvoiceLine_ID="+ matchPO.getC_InvoiceLine_ID() + " AND Qty != ?", retValue.getQty());
					if (cnt <= 0)
					{
						if (!matchPO.isPosted() && matchPO.getQty().compareTo(retValue.getQty()) >= 0)
						{
							// Found a usable stub: shrink its qty by what this slice takes
							// (delete it later below if it hits zero), and adopt its invoice line.
							otherMatchPO = matchPO;
							sliceILine = new MInvoiceLine(retValue.getCtx(), matchPO.getC_InvoiceLine_ID(), retValue.get_TrxName());
							matchPO.setQty(matchPO.getQty().subtract(retValue.getQty()));
							matchPO.saveEx();
							break; // only borrow from one stub per slice
						}
					}
				}
			}
		}

		if (sliceILine != null)
		{
			if (otherMatchPO == null)
				// Simple case: iLine was passed in directly - just attach it.
				retValue.setC_InvoiceLine_ID(sliceILine);
			if (otherMatchPO != null)
			{
				// Borrowed case: create the M_MatchInv linking this slice's receipt to the
				// borrowed invoice line, if one doesn't already exist for that pair.
				int cnt = DB.getSQLValue(retValue.get_TrxName(), "SELECT Count(*) FROM M_MatchInv WHERE M_InOutLine_ID="+retValue.getM_InOutLine_ID()
						+" AND C_InvoiceLine_ID="+otherMatchPO.getC_InvoiceLine_ID());
				if (cnt <= 0)
				{
					MMatchInv matchInv = createMatchInv(retValue, otherMatchPO.getC_InvoiceLine_ID(), retValue.getM_InOutLine_ID(), retValue.getQty(), dateTrx, trxName);
					if (matchInv == null)
					{
						String msg = "Failed to create match inv.";
						ValueNamePair error = CLogger.retrieveError();
						if (error != null) msg = msg + " " + error.getName();
						throw new RuntimeException(msg);
					}
					retValue.setMatchInvCreated(matchInv);
				}
				// If borrowing fully drained the stub's qty, it no longer represents anything -
				// remove it rather than leaving a zero-qty orphan record around.
				if (otherMatchPO.getQty().signum() == 0)
					otherMatchPO.deleteEx(true);
			}
		}
		if (!retValue.save())
		{
			String msg = "Failed to update match po.";
			ValueNamePair error = CLogger.retrieveError();
			if (error != null) msg = msg + " " + error.getName();
			throw new RuntimeException(msg);
		}
		return retValue;
	}
	
	/**
	 * Create MatchInv record
	 * @param mpo
	 * @param C_InvoiceLine_ID
	 * @param M_InOutLine_ID
	 * @param qty
	 * @param dateTrx
	 * @param trxName
	 * @return Match Inv record
	 */
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
	 * Register the match inv created for immediate accounting posting
	 * @param matchInv
	 */
	protected void setMatchInvCreated(MMatchInv matchInv) {
		m_matchInv = matchInv;
	}

	/**
	 * Get the match inv created for immediate accounting posting. <br/>
	 * The Match Inv record reference is set to null after call, so if you call this method twice, the second call will returns null.
	 * @return Match Inv record or null
	 */
	public MMatchInv getMatchInvCreated() {
		MMatchInv tmp = m_matchInv;
		m_matchInv = null;
		return tmp;
	}

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MMatchPO.class);

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_MatchPO_UU  UUID key
     * @param trxName Transaction
     */
    public MMatchPO(Properties ctx, String M_MatchPO_UU, String trxName) {
        super(ctx, M_MatchPO_UU, trxName);
		if (Util.isEmpty(M_MatchPO_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_MatchPO_ID id
	 *	@param trxName transaction
	 */
	public MMatchPO (Properties ctx, int M_MatchPO_ID, String trxName)
	{
		super (ctx, M_MatchPO_ID, trxName);
		if (M_MatchPO_ID == 0)
			setInitialDefaults();
	}	//	MMatchPO

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setM_AttributeSetInstance_ID(0);
		setPosted (false);
		setProcessed (false);
		setProcessing (false);
	}

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
	
	/** Invoice Line Changed			*/
	protected boolean m_isInvoiceLineChange = false;
	/** InOut Line Changed			*/
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
	 * Get PriceActual from Invoice and convert it to Order Currency.
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
		//	Set DateTrx to today date
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
		
		// Set C_InvoiceLine_ID from MatchInv records
		if (newRecord && getC_InvoiceLine_ID() == 0 && getReversal_ID()==0) 
		{
			MMatchInv[] mpi = MMatchInv.getInOutLine(getCtx(), getM_InOutLine_ID(), get_TrxName());
			for (int i = 0; i < mpi.length; i++) 
			{
				if (mpi[i].getC_InvoiceLine_ID() != 0 && 
						mpi[i].getM_AttributeSetInstance_ID() == getM_AttributeSetInstance_ID()) 
				{
					// skip if m_matchpo have been created
					int cnt = DB.getSQLValue(get_TrxName(), "SELECT Count(*) FROM M_MatchPO WHERE M_InOutLine_ID="+getM_InOutLine_ID()
							+" AND C_InvoiceLine_ID="+mpi[i].getC_InvoiceLine_ID());
					if (cnt > 0)
						continue;
					
					if (mpi[i].getQty().compareTo(getQty()) == 0)  // same quantity
					{
						setC_InvoiceLine_ID(mpi[i].getC_InvoiceLine_ID());
						break;
					}
					else 
					{
						// Create new MatchPO record for PO-Invoice if quantity is different
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
		
		//	Find OrderLine or invoice line or material receipt line
		if (getC_OrderLine_ID() == 0)
		{
			MInvoiceLine il = null;
			if (getC_InvoiceLine_ID() != 0)
			{
				// get from invoice
				il = getInvoiceLine();
				if (il.getC_OrderLine_ID() != 0)
					setC_OrderLine_ID(il.getC_OrderLine_ID());
			}	
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
		
		//	Set PriceMatchDifference to difference between PO price and Invoice price
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
				//	Validate against PriceMatchTolerance of business partner group and update IsApproved
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
			
			// Validate existence of corresponding invoice matching record.
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
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		// Perform matched qty validation
		if (success)
		{
			// Validate total M_MatchPO.Qty for M_InOutLine_ID against M_InOutLine.MovementQty
			if (getM_InOutLine_ID() > 0)
			{
				MInOutLine line = new MInOutLine(getCtx(), getM_InOutLine_ID(), get_TrxName());
				BigDecimal matchedQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE M_InOutLine_ID=?" , getM_InOutLine_ID());
				if (line.getMovementQty().signum() > 0 && matchedQty != null && matchedQty.compareTo(line.getMovementQty()) > 0)
				{
					throw new IllegalStateException("Total matched qty > movement qty. MatchedQty="+matchedQty+", MovementQty="+line.getMovementQty()+", Line="+line);
				}
			}
			
			// Validate total M_MatchPO.Qty for C_InvoiceLine_ID against C_InvoiceLine.QtyInvoiced
			if (getC_InvoiceLine_ID() > 0)
			{
				MInvoiceLine line = new MInvoiceLine(getCtx(), getC_InvoiceLine_ID(), get_TrxName());				
				BigDecimal matchedQty = DB.getSQLValueBD(get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE C_InvoiceLine_ID=?  AND Reversal_ID IS NULL " , getC_InvoiceLine_ID() );
				if (matchedQty != null && matchedQty.compareTo(line.getQtyInvoiced()) > 0)
				{
					throw new IllegalStateException("Total matched qty > invoiced qty. MatchedQty="+matchedQty+", InvoicedQty="+line.getQtyInvoiced()+", Line="+line);
				}
			}
			
			// Validate matching for QtyOrdered
			if (getC_OrderLine_ID() > 0)
			{
				boolean validateOrderedQty = MSysConfig.getBooleanValue(MSysConfig.VALIDATE_MATCHING_TO_ORDERED_QTY, true, Env.getAD_Client_ID(Env.getCtx()));
				if (validateOrderedQty)
				{
					// Validate total M_MatchPO.Qty (with C_InvoiceLine) for C_OrderLine_ID against C_OrderLine.QtyOrdered
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
					// Validate total M_MatchPO.Qty (with M_InOutLine) for C_OrderLine_ID against C_OrderLine.QtyOrdered
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
		//	(Reserved in WMatch and MInOut.completeIt)
		if (success && getC_OrderLine_ID() != 0)
		{
			MOrderLine orderLine = getOrderLine();
			// Update C_OrderLine.QtyDelivered and C_OrderLine.DateDelivered
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
			// Update C_OrderLine.QtyInvoiced and C_OrderLine.DateInvoiced
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
			
			//	Update Order ASI from M_InOutLine if it is exact quantity match between C_OrderLine and M_InOutLine
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
	 * 	Get the newer Date Acct between invoice and shipment
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
	
	@Override
	protected boolean beforeDelete ()
	{
		// Check is period open and delete postings (Fact_Acct)
		if (isPosted())
		{
			MPeriod.testPeriodOpen(getCtx(), getDateTrx(), MDocType.DOCBASETYPE_MatchPO, getAD_Org_ID());
			setPosted(false);
			MFactAcct.deleteEx (Table_ID, get_ID(), get_TrxName());
		}
		return true;
	}	//	beforeDelete
	
	@Override
	protected boolean afterDelete (boolean success)
	{
		// Update QtyDelivered and QtyInvoiced of order line
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
	@Override
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
	 * 	Reverse this MatchPO document.
	 *  @param reversalDate
	 *	@return true if reversed
	 *	@throws Exception
	 */
	public boolean reverse(Timestamp reversalDate)
	{
		return reverse(reversalDate, false);
	}
	
	/**
	 * 	Reverse this MatchPO document.
	 *  @param reversalDate
	 *  @param reverseMatchingOnly true if MR is not reverse
	 *	@return true if reversed
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
				MInOutLine inoutLine = new MInOutLine(getCtx(), getM_InOutLine_ID(), get_TrxName());
				reversal.setC_OrderLine_ID(inoutLine.getC_OrderLine_ID());
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
						int docTypeId = DB.getSQLValue((String)null, IDoc.DOC_TYPE_BY_DOC_BASE_TYPE_SQL, getAD_Client_ID(), IDoc.DOCTYPE_MatMatchPO);
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
	
	/**
	 * Get or create Match PO record for order line.
	 * @param C_OrderLine_ID
	 * @param qty
	 * @param sLine
	 * @param trxName
	 * @return new or existing MMatchPO record
	 */
	public static MMatchPO getOrCreate(int C_OrderLine_ID, BigDecimal qty, MInOutLine sLine, String trxName) {
		Query query = new Query(Env.getCtx(), MMatchPO.Table_Name, "C_OrderLine_ID=? AND Qty=? AND Posted IN (?,?) AND M_InOutLine_ID IS NULL", trxName);
		MMatchPO matchPO = query.setParameters(C_OrderLine_ID, qty, IDoc.STATUS_NotPosted, IDoc.STATUS_Deferred).first();
		if (matchPO != null) {
			matchPO.setM_InOutLine_ID(sLine.getM_InOutLine_ID());
			return matchPO;
		} else {
			return new MMatchPO (sLine, null, qty);
		}
	}
}	//	MMatchPO
