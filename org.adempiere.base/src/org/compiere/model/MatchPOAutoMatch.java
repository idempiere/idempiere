/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2019 Elaine Tan                                              *
 *                                                                            *
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
package org.compiere.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Properties;

import org.compiere.process.DocAction;
import org.compiere.util.Env;

/**
 *
 * @author hengsin
 *
 */
public class MatchPOAutoMatch {

	/**
	 *
	 * @param ctx
	 * @param C_OrderLine_ID
	 * @param trxName
	 * @return not fully matched matchpo records
	 */
	public static List<MMatchPO> getNotMatchedMatchPOList(Properties ctx, int C_OrderLine_ID, String trxName)
	{
		List<MMatchPO> notMatchedMatchPOList = new ArrayList<MMatchPO>();
		List<MMatchPO> creditMemoMatchPOList = new ArrayList<MMatchPO>();
		List<MMatchPO> notMatchedCreditMemoMatchPOList = new ArrayList<MMatchPO>();
		MMatchPO[] mpos = MMatchPO.getOrderLine(ctx, C_OrderLine_ID, trxName);
		for (MMatchPO mpo : mpos)
		{
			if (mpo.getReversal_ID() == 0 && mpo.getRef_MatchPO_ID() == 0)
			{
				if (mpo.getQty().signum() < 0)
				{
					if (mpo.getC_InvoiceLine_ID() > 0 && mpo.getM_InOutLine_ID() == 0)
					{
						String docStatus = mpo.getC_InvoiceLine().getC_Invoice().getDocStatus();
						if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) {
							creditMemoMatchPOList.add(mpo);
							continue;
						}
					}
				}
				notMatchedMatchPOList.add(mpo);
			}
		}

		if (!notMatchedMatchPOList.isEmpty())
		{
			Collections.sort(notMatchedMatchPOList, new Comparator<MMatchPO>() {
				@Override
				public int compare(MMatchPO arg0, MMatchPO arg1) {
					return arg0.getM_MatchPO_ID() > arg1.getM_MatchPO_ID()
							? 1
							: (arg0.getM_MatchPO_ID()==arg1.getM_MatchPO_ID() ? 0 : -1);
				}
			});
		}

		if (!creditMemoMatchPOList.isEmpty())
		{
			BigDecimal totalNotMatchingCreditMemoQty = Env.ZERO;
			for (MMatchPO matchPOCreditMemo : creditMemoMatchPOList)
			{
				boolean found = false;
				int Ref_InvoiceLine_ID = matchPOCreditMemo.getC_InvoiceLine().getRef_InvoiceLine_ID();
				if (Ref_InvoiceLine_ID > 0)
				{
					for (MMatchPO matchPO : notMatchedMatchPOList)
					{
						if (!matchPO.isPosted() && matchPO.getC_InvoiceLine_ID() == Ref_InvoiceLine_ID && matchPO.getM_InOutLine_ID() == 0)
						{
							if (matchPO.getQty().compareTo(matchPOCreditMemo.getQty().negate()) == 0)
							{
								notMatchedMatchPOList.remove(matchPO);
								found = true;
								break;
							}
						}
					}
				}

				if (found)
					continue;

				for (MMatchPO matchPO : notMatchedMatchPOList)
				{
					if (!matchPO.isPosted() && matchPO.getC_InvoiceLine_ID() > 0 && matchPO.getM_InOutLine_ID() == 0)
					{
						if (matchPO.getQty().compareTo(matchPOCreditMemo.getQty().negate()) == 0)
						{
							notMatchedMatchPOList.remove(matchPO);
							found = true;
							break;
						}
					}
				}

				if (!found)
				{
					totalNotMatchingCreditMemoQty = totalNotMatchingCreditMemoQty.add(matchPOCreditMemo.getQty().negate());
					notMatchedCreditMemoMatchPOList.add(matchPOCreditMemo);
				}
			}

			if (totalNotMatchingCreditMemoQty.signum() != 0)
			{
				BigDecimal totalInvoiceQty = Env.ZERO;
				for (MMatchPO matchPO : notMatchedMatchPOList)
				{
					if (!matchPO.isPosted() && matchPO.getC_InvoiceLine_ID() > 0 && matchPO.getM_InOutLine_ID() == 0)
						totalInvoiceQty = totalInvoiceQty.add(matchPO.getQty());
				}

				if (totalNotMatchingCreditMemoQty.compareTo(totalInvoiceQty) == 0)
					notMatchedMatchPOList.clear();
			}
		}

		return notMatchedMatchPOList;
	}

	/**
	 * auto match matchpo
	 * @param ctx
	 * @param C_OrderLine_ID
	 * @param currentPO
	 * @param trxName
	 */
	public static void match(Properties ctx, int C_OrderLine_ID, MMatchPO currentPO, String trxName)
	{
		List<MMatchPO> notMatchedMatchPOList = new ArrayList<MMatchPO>();
		List<MMatchPO> creditMemoMatchPOList = new ArrayList<MMatchPO>();
		List<MMatchPO> matchedMatchPOList = new ArrayList<MMatchPO>();
		MMatchPO[] mpos = MMatchPO.getOrderLine(ctx, C_OrderLine_ID, trxName);
		for (MMatchPO mpo : mpos)
		{
			if (mpo.getReversal_ID() == 0 && mpo.getRef_MatchPO_ID() == 0)
			{
				if (mpo.getQty().signum() < 0)
				{
					if (mpo.getC_InvoiceLine_ID() > 0 && mpo.getM_InOutLine_ID() == 0)
					{
						String docStatus = mpo.getC_InvoiceLine().getC_Invoice().getDocStatus();
						if ((currentPO != null && mpo.getM_MatchPO_ID() == currentPO.getM_MatchPO_ID())
								|| docStatus.equals(DocAction.STATUS_Completed)
								|| docStatus.equals(DocAction.STATUS_Closed)) {
							creditMemoMatchPOList.add(mpo);
						}
					}
					continue;
				}
				notMatchedMatchPOList.add(mpo);
			}
		}

		if (!notMatchedMatchPOList.isEmpty())
		{
			Collections.sort(notMatchedMatchPOList, new Comparator<MMatchPO>() {
				@Override
				public int compare(MMatchPO arg0, MMatchPO arg1) {
					return arg0.getM_MatchPO_ID() > arg1.getM_MatchPO_ID()
							? 1
							: (arg0.getM_MatchPO_ID()==arg1.getM_MatchPO_ID() ? 0 : -1);
				}
			});
		}

		if (!creditMemoMatchPOList.isEmpty())
		{
			for (MMatchPO matchPOCreditMemo : creditMemoMatchPOList)
			{
				BigDecimal creditMemoQty = matchPOCreditMemo.getQty().negate();

				int Ref_InvoiceLine_ID = matchPOCreditMemo.getC_InvoiceLine().getRef_InvoiceLine_ID();
				if (Ref_InvoiceLine_ID > 0)
				{
					for (MMatchPO matchPO : notMatchedMatchPOList)
					{
						if (!matchPO.isPosted() && matchPO.getC_InvoiceLine_ID() == Ref_InvoiceLine_ID && matchPO.getM_InOutLine_ID() == 0)
						{
							if (matchPO.getQty().compareTo(creditMemoQty) > 0)
							{
								matchPO.setQty(matchPO.getQty().subtract(creditMemoQty));
								matchPO.saveEx(trxName);

								MInvoiceLine iLine = new MInvoiceLine(ctx, matchPO.getC_InvoiceLine_ID(), trxName);
								MMatchPO po = new MMatchPO(iLine, iLine.getC_Invoice().getDateInvoiced(), creditMemoQty);
								po.setC_OrderLine_ID(C_OrderLine_ID);
								po.setRef_MatchPO_ID(matchPOCreditMemo.getM_MatchPO_ID());
								po.setPosted(true);
								po.saveEx(trxName);

								matchPOCreditMemo.setRef_MatchPO_ID(po.getM_MatchPO_ID());
								matchPOCreditMemo.setPosted(true);
								matchPOCreditMemo.saveEx(trxName);
								
								MMatchInv matchInv1 = MMatchPO.createMatchInv(po, po.getC_InvoiceLine_ID(), po.getM_InOutLine_ID(), po.getQty(), po.getDateTrx(), trxName);
								MMatchInv matchInv2 = MMatchPO.createMatchInv(matchPOCreditMemo, matchPOCreditMemo.getC_InvoiceLine_ID(), matchPOCreditMemo.getM_InOutLine_ID(), matchPOCreditMemo.getQty(), matchPOCreditMemo.getDateTrx(), trxName);
								if (matchInv1 != null && matchInv2 != null)
								{
									matchInv1.setRef_MatchInv_ID(matchInv2.getM_MatchInv_ID());
									matchInv1.saveEx(trxName);
									
									matchInv2.setRef_MatchInv_ID(matchInv1.getM_MatchInv_ID());									
									matchInv2.saveEx(trxName);
								}
								else
									break;

								matchedMatchPOList.add(po);
								creditMemoQty = creditMemoQty.subtract(po.getQty());
							}
							else if (matchPO.getQty().compareTo(creditMemoQty) == 0)
							{
								matchPO.setRef_MatchPO_ID(matchPOCreditMemo.getM_MatchPO_ID());
								matchPO.setPosted(true);
								matchPO.saveEx(trxName);

								matchPOCreditMemo.setRef_MatchPO_ID(matchPO.getM_MatchPO_ID());
								matchPOCreditMemo.setPosted(true);
								matchPOCreditMemo.saveEx(trxName);
								
								MMatchInv matchInv1 = MMatchPO.createMatchInv(matchPO, matchPO.getC_InvoiceLine_ID(), matchPO.getM_InOutLine_ID(), matchPO.getQty(), matchPO.getDateTrx(), trxName);
								MMatchInv matchInv2 = MMatchPO.createMatchInv(matchPOCreditMemo, matchPOCreditMemo.getC_InvoiceLine_ID(), matchPOCreditMemo.getM_InOutLine_ID(), matchPOCreditMemo.getQty(), matchPOCreditMemo.getDateTrx(), trxName);
								if (matchInv1 != null && matchInv2 != null)
								{
									matchInv1.setRef_MatchInv_ID(matchInv2.getM_MatchInv_ID());
									matchInv1.saveEx(trxName);
									
									matchInv2.setRef_MatchInv_ID(matchInv1.getM_MatchInv_ID());									
									matchInv2.saveEx(trxName);
								}
								else
									break;

								matchedMatchPOList.add(matchPO);
								creditMemoQty = creditMemoQty.subtract(matchPO.getQty());
							}
							else if (matchPO.getQty().compareTo(creditMemoQty) < 0)
							{
								matchPOCreditMemo.setQty(matchPOCreditMemo.getQty().add(matchPO.getQty()));
								matchPOCreditMemo.saveEx(trxName);

								MInvoiceLine iLine = new MInvoiceLine(ctx, matchPOCreditMemo.getC_InvoiceLine_ID(), trxName);
								MMatchPO po = new MMatchPO(iLine, iLine.getC_Invoice().getDateInvoiced(), matchPO.getQty().negate());
								po.setC_OrderLine_ID(C_OrderLine_ID);
								po.setRef_MatchPO_ID(matchPO.getM_MatchPO_ID());
								po.setPosted(true);
								po.saveEx(trxName);

								matchPO.setRef_MatchPO_ID(po.getM_MatchPO_ID());
								matchPO.setPosted(true);
								matchPO.saveEx(trxName);
								
								MMatchInv matchInv1 = MMatchPO.createMatchInv(po, po.getC_InvoiceLine_ID(), po.getM_InOutLine_ID(), po.getQty(), po.getDateTrx(), trxName);
								MMatchInv matchInv2 = MMatchPO.createMatchInv(matchPO, matchPO.getC_InvoiceLine_ID(), matchPO.getM_InOutLine_ID(), matchPO.getQty(), matchPO.getDateTrx(), trxName);
								if (matchInv1 != null && matchInv2 != null)
								{
									matchInv1.setRef_MatchInv_ID(matchInv2.getM_MatchInv_ID());
									matchInv1.saveEx(trxName);
									
									matchInv2.setRef_MatchInv_ID(matchInv1.getM_MatchInv_ID());									
									matchInv2.saveEx(trxName);
								}
								else
									break;

								matchedMatchPOList.add(matchPO);
								creditMemoQty = creditMemoQty.subtract(matchPO.getQty());
							}

							if (creditMemoQty.signum() == 0)
								break;
						}
					}

					for (MMatchPO matchedMatchPO : matchedMatchPOList)
						notMatchedMatchPOList.remove(matchedMatchPO);
				}

				if (creditMemoQty.signum() == 0)
					continue;

				for (MMatchPO matchPO : notMatchedMatchPOList)
				{
					if (!matchPO.isPosted() && matchPO.getC_InvoiceLine_ID() > 0 && matchPO.getM_InOutLine_ID() == 0)
					{
						if (matchPO.getQty().compareTo(creditMemoQty) > 0)
						{
							matchPO.setQty(matchPO.getQty().subtract(creditMemoQty));
							matchPO.saveEx(trxName);

							MInvoiceLine iLine = new MInvoiceLine(ctx, matchPO.getC_InvoiceLine_ID(), trxName);
							MMatchPO po = new MMatchPO(iLine, iLine.getC_Invoice().getDateInvoiced(), creditMemoQty);
							po.setC_OrderLine_ID(C_OrderLine_ID);
							po.setRef_MatchPO_ID(matchPOCreditMemo.getM_MatchPO_ID());
							po.setPosted(true);
							po.saveEx(trxName);

							matchPOCreditMemo.setRef_MatchPO_ID(po.getM_MatchPO_ID());
							matchPOCreditMemo.setPosted(true);
							matchPOCreditMemo.saveEx(trxName);
							
							MMatchInv matchInv1 = MMatchPO.createMatchInv(po, po.getC_InvoiceLine_ID(), po.getM_InOutLine_ID(), po.getQty(), po.getDateTrx(), trxName);
							MMatchInv matchInv2 = MMatchPO.createMatchInv(matchPOCreditMemo, matchPOCreditMemo.getC_InvoiceLine_ID(), matchPOCreditMemo.getM_InOutLine_ID(), matchPOCreditMemo.getQty(), matchPOCreditMemo.getDateTrx(), trxName);
							if (matchInv1 != null && matchInv2 != null)
							{
								matchInv1.setRef_MatchInv_ID(matchInv2.getM_MatchInv_ID());
								matchInv1.saveEx(trxName);
								
								matchInv2.setRef_MatchInv_ID(matchInv1.getM_MatchInv_ID());									
								matchInv2.saveEx(trxName);
							}
							else
								break;

							matchedMatchPOList.add(po);
							creditMemoQty = creditMemoQty.subtract(po.getQty());
						}
						else if (matchPO.getQty().compareTo(creditMemoQty) == 0)
						{
							matchPO.setRef_MatchPO_ID(matchPOCreditMemo.getM_MatchPO_ID());
							matchPO.setPosted(true);
							matchPO.saveEx(trxName);

							matchPOCreditMemo.setRef_MatchPO_ID(matchPO.getM_MatchPO_ID());
							matchPOCreditMemo.setPosted(true);
							matchPOCreditMemo.saveEx(trxName);
							
							MMatchInv matchInv1 = MMatchPO.createMatchInv(matchPO, matchPO.getC_InvoiceLine_ID(), matchPO.getM_InOutLine_ID(), matchPO.getQty(), matchPO.getDateTrx(), trxName);
							MMatchInv matchInv2 = MMatchPO.createMatchInv(matchPOCreditMemo, matchPOCreditMemo.getC_InvoiceLine_ID(), matchPOCreditMemo.getM_InOutLine_ID(), matchPOCreditMemo.getQty(), matchPOCreditMemo.getDateTrx(), trxName);
							if (matchInv1 != null && matchInv2 != null)
							{
								matchInv1.setRef_MatchInv_ID(matchInv2.getM_MatchInv_ID());
								matchInv1.saveEx(trxName);
								
								matchInv2.setRef_MatchInv_ID(matchInv1.getM_MatchInv_ID());									
								matchInv2.saveEx(trxName);
							}
							else
								break;

							matchedMatchPOList.add(matchPO);
							creditMemoQty = creditMemoQty.subtract(matchPO.getQty());
						}
						else if (matchPO.getQty().compareTo(creditMemoQty) < 0)
						{
							matchPOCreditMemo.setQty(matchPOCreditMemo.getQty().add(matchPO.getQty()));
							matchPOCreditMemo.saveEx(trxName);

							MInvoiceLine iLine = new MInvoiceLine(ctx, matchPOCreditMemo.getC_InvoiceLine_ID(), trxName);
							MMatchPO po = new MMatchPO(iLine, iLine.getC_Invoice().getDateInvoiced(), matchPO.getQty().negate());
							po.setC_OrderLine_ID(C_OrderLine_ID);
							po.setRef_MatchPO_ID(matchPO.getM_MatchPO_ID());
							po.setPosted(true);
							po.saveEx(trxName);

							matchPO.setRef_MatchPO_ID(po.getM_MatchPO_ID());
							matchPO.setPosted(true);
							matchPO.saveEx(trxName);
							
							MMatchInv matchInv1 = MMatchPO.createMatchInv(po, po.getC_InvoiceLine_ID(), po.getM_InOutLine_ID(), po.getQty(), po.getDateTrx(), trxName);
							MMatchInv matchInv2 = MMatchPO.createMatchInv(matchPO, matchPO.getC_InvoiceLine_ID(), matchPO.getM_InOutLine_ID(), matchPO.getQty(), matchPO.getDateTrx(), trxName);
							if (matchInv1 != null && matchInv2 != null)
							{
								matchInv1.setRef_MatchInv_ID(matchInv2.getM_MatchInv_ID());
								matchInv1.saveEx(trxName);
								
								matchInv2.setRef_MatchInv_ID(matchInv1.getM_MatchInv_ID());									
								matchInv2.saveEx(trxName);
							}
							else
								break;

							matchedMatchPOList.add(matchPO);
							creditMemoQty = creditMemoQty.subtract(matchPO.getQty());
						}

						if (creditMemoQty.signum() == 0)
							break;
					}
				}

				for (MMatchPO matchedMatchPO : matchedMatchPOList)
					notMatchedMatchPOList.remove(matchedMatchPO);
			}
		}

		if (currentPO != null)
		{
			for (MMatchPO matchPOCreditMemo : creditMemoMatchPOList)
			{
				if (matchPOCreditMemo.getM_MatchPO_ID() == currentPO.getM_MatchPO_ID())
				{
					if (matchPOCreditMemo.getReversal_ID() == 0 && matchPOCreditMemo.getRef_MatchPO_ID() == 0)
						throw new RuntimeException("Failed to find the corresponding invoice matched po");
				}
			}
		}
	}

	/**
	 * remove match between vendor invoice and vendor cm
	 * @param ctx
	 * @param C_Invoice_ID
	 * @param trxName
	 */
	public static void unmatch(Properties ctx, int C_Invoice_ID, String trxName)
	{
		MMatchInv[] minvs = MMatchInv.getInvoice(ctx, C_Invoice_ID, trxName);
		for(MMatchInv minv : minvs)
		{
			if (minv.getReversal_ID() > 0 || minv.getRef_MatchInv_ID() == 0)
				continue;
			
			MMatchInv refMatchInv = new MMatchInv(ctx, minv.getRef_MatchInv_ID(), trxName);
			refMatchInv.deleteEx(true);
			
			minv.deleteEx(true);
		}
		
		List<Integer> unmatchedOrderLineID = new ArrayList<Integer>();
		MMatchPO[] mpos = MMatchPO.getInvoice(ctx, C_Invoice_ID, trxName);
		for (MMatchPO mpo : mpos)
		{
			if (mpo.getReversal_ID() > 0 || mpo.getRef_MatchPO_ID() == 0)
				continue;

			int C_OrderLine_ID = mpo.getC_OrderLine_ID();
			if (!unmatchedOrderLineID.contains(C_OrderLine_ID))
			{
				unmatchedOrderLineID.add(C_OrderLine_ID);

				MMatchPO[] pos = MMatchPO.getOrderLine(ctx, C_OrderLine_ID, trxName);
				for (MMatchPO po : pos)
				{
					if (po.getReversal_ID() == 0 && po.getC_InvoiceLine_ID() > 0 && po.getRef_MatchPO_ID() > 0)
					{
						if (po.getC_InvoiceLine().getC_Invoice_ID() == C_Invoice_ID)
						{
							po.setRef_MatchPO_ID(0);
							po.setPosted(false);
							po.saveEx(trxName);
						}
						else if (po.getRef_MatchPO().getC_InvoiceLine().getC_Invoice_ID() == C_Invoice_ID)
						{
							po.setRef_MatchPO_ID(0);
							po.setPosted(false);
							po.saveEx(trxName);
						}
					}
				}
			}
		}
	}
}
