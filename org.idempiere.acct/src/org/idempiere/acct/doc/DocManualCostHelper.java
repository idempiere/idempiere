/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                                                           *
 **********************************************************************/
package org.idempiere.acct.doc;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCharge;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.X_C_Charge_Acct;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * Helper methods for posting charge-mapped manual (non-material) cost elements in {@link Doc} subclasses.
 */
public final class DocManualCostHelper
{
	private DocManualCostHelper()
	{
	}

	/**
	 * Accumulate manual (non-material, charge-mapped) costs into a map keyed by M_CostElement_ID.
	 * @param map target accumulation map
	 * @param manualCosts manual costs to accumulate
	 */
	public static void accumulateManualCosts(Map<Integer, ManualCost> map, ManualCost[] manualCosts)
	{
		if (manualCosts == null)
			return;
		for (ManualCost mc : manualCosts)
		{
			if (mc == null || mc.getAmount() == null || mc.getAmount().signum() == 0)
				continue;
			int ceId = mc.getCostElement().getM_CostElement_ID();
			ManualCost existing = map.get(ceId);
			if (existing == null)
				map.put(ceId, mc);
			else
				map.put(ceId, new ManualCost(existing.getCostElement(), existing.getAmount().add(mc.getAmount())));
		}
	}

	/**
	 * Round manual cost amounts to standard accounting precision and retain non-zero entries.
	 * @param manualCosts manual cost array
	 * @param stdPrecision standard accounting currency precision
	 * @return list of rounded non-zero manual costs
	 */
	public static List<ManualCost> roundManualCosts(ManualCost[] manualCosts, int stdPrecision)
	{
		if (manualCosts == null || manualCosts.length == 0)
			return new ArrayList<>();
		return roundManualCosts(Arrays.asList(manualCosts), stdPrecision);
	}

	/**
	 * Round manual cost amounts to standard accounting precision and retain non-zero entries.
	 * @param manualCosts manual cost entries
	 * @param stdPrecision standard accounting currency precision
	 * @return list of rounded non-zero manual costs
	 */
	public static List<ManualCost> roundManualCosts(Iterable<ManualCost> manualCosts, int stdPrecision)
	{
		List<ManualCost> result = new ArrayList<>();
		if (manualCosts == null)
			return result;
		for (ManualCost mc : manualCosts)
		{
			if (mc != null && mc.getAmount() != null)
			{
				BigDecimal amt = mc.getAmount().setScale(stdPrecision, RoundingMode.HALF_UP);
				if (amt.signum() != 0)
					result.add(new ManualCost(mc.getCostElement(), amt));
			}
		}
		return result;
	}

	/**
	 * Stage a {@link MManualCostDetail} record for a posted manual cost charge entry so it is
	 * persisted atomically alongside {@link Fact} lines in {@link Doc#postCommit(String)} only when
	 * posting succeeds.
	 * @param doc owning document
	 * @param as accounting schema
	 * @param line document line
	 * @param M_CostElement_ID manual cost element ID
	 * @param C_Charge_ID charge ID
	 * @param chargeAcct posted charge account combination
	 * @param amt signed amount (Charge CR minus Charge DR)
	 * @return staged (or saved when called outside {@link Doc#post}) {@link MManualCostDetail}
	 */
	public static MManualCostDetail saveManualCostDetail(Doc doc, MAcctSchema as, DocLine line,
			int M_CostElement_ID, int C_Charge_ID, MAccount chargeAcct, BigDecimal amt)
	{
		MManualCostDetail detail = MManualCostDetail.build(doc.getCtx(), line.getAD_Org_ID(), as.getC_AcctSchema_ID(),
				doc.get_Table_ID(), doc.get_ID(), line.get_ID(),
				M_CostElement_ID, C_Charge_ID,
				line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
				chargeAcct.getC_ValidCombination_ID(), line.getDateAcct(),
				amt, line.getQty(), line.getDescription(), doc.getTrxName());
		doc.stageManualCostDetail(detail);
		return detail;
	}

	/**
	 * Resolve the historical charge {@link MAccount} recorded on a {@link MManualCostDetail}
	 * within the current posting transaction, falling back to the current charge account if missing.
	 * @param doc owning document
	 * @param as accounting schema
	 * @param detail original manual cost detail
	 * @return charge account or null
	 */
	public static MAccount getManualCostChargeAccount(Doc doc, MAcctSchema as, MManualCostDetail detail)
	{
		int vcId = detail.getC_ValidCombination_ID();
		if (vcId > 0)
		{
			MAccount acct = Util.isEmpty(doc.getTrxName())
					? MAccount.get(doc.getCtx(), vcId)
					: new MAccount(doc.getCtx(), vcId, doc.getTrxName());
			if (acct != null && acct.get_ID() > 0)
				return acct;
		}
		return MCharge.getAccount(detail.getC_Charge_ID(), as, doc.getTrxName());
	}

	/**
	 * Create a manual-cost charge {@link FactLine} and stage its {@link MManualCostDetail}.
	 * Resolves the charge account via {@link MCharge#getAccount} when {@code chargeAcct} is null,
	 * validates creation, sets {@code C_Charge_ID}, and stages the detail record.
	 * On failure sets {@code doc.p_Error} and logs a warning.
	 * @param doc owning document
	 * @param fact target fact
	 * @param as accounting schema
	 * @param line document line
	 * @param M_CostElement_ID manual cost element ID
	 * @param C_Charge_ID charge ID
	 * @param chargeAcct charge account (or null to resolve via {@link MCharge#getAccount})
	 * @param drAmt debit amount (mutually exclusive with crAmt)
	 * @param crAmt credit amount (mutually exclusive with drAmt)
	 * @param detailAmt signed amount for {@link MManualCostDetail} (Charge CR minus Charge DR)
	 * @return created {@link FactLine}, or null on error (with {@code doc.p_Error} populated)
	 */
	public static FactLine createManualCostChargeLine(Doc doc, Fact fact, MAcctSchema as, DocLine line,
			int M_CostElement_ID, int C_Charge_ID, MAccount chargeAcct,
			BigDecimal drAmt, BigDecimal crAmt, BigDecimal detailAmt)
	{
		boolean isCredit = (crAmt != null && crAmt.signum() > 0) || (drAmt != null && drAmt.signum() < 0);
		String msgKey = isCredit ? "FactLine CR not created" : "FactLine DR not created";
		if (chargeAcct == null)
			chargeAcct = MCharge.getAccount(C_Charge_ID, as, doc.getTrxName());
		if (chargeAcct == null)
		{
			doc.p_Error = formatMissingChargeAccountError(doc, as, C_Charge_ID, line, msgKey);
			doc.log.log(Level.WARNING, doc.p_Error);
			return null;
		}
		FactLine fl = fact.createLine(line, chargeAcct, as.getC_Currency_ID(), drAmt, crAmt);
		if (fl == null)
		{
			doc.p_Error = Msg.getMsg(doc.getCtx(), msgKey) + ": " + line;
			doc.log.log(Level.WARNING, doc.p_Error);
			return null;
		}
		fl.setC_Charge_ID(C_Charge_ID);
		saveManualCostDetail(doc, as, line, M_CostElement_ID, C_Charge_ID, chargeAcct, detailAmt);
		return fl;
	}

	/**
	 * Format a translated posting error naming the charge and accounting schema when
	 * {@link MCharge#getAccount} returns null for a manual cost charge.
	 * @param doc owning document
	 * @param as accounting schema
	 * @param C_Charge_ID charge ID
	 * @param line document line context
	 * @param baseMsgKey base AD_Message key (e.g. {@code FactLine CR not created})
	 * @return translated error message
	 */
	public static String formatMissingChargeAccountError(Doc doc, MAcctSchema as, int C_Charge_ID, DocLine line, String baseMsgKey)
	{
		MCharge charge = Util.isEmpty(doc.getTrxName()) ? MCharge.get(doc.getCtx(), C_Charge_ID) : new MCharge(doc.getCtx(), C_Charge_ID, doc.getTrxName());
		String chargeName = charge != null && charge.get_ID() > 0 ? charge.getName() : String.valueOf(C_Charge_ID);
		return Msg.getMsg(doc.getCtx(), baseMsgKey) + " ("
				+ Msg.getElement(doc.getCtx(), X_C_Charge_Acct.COLUMNNAME_Ch_Expense_Acct) + " "
				+ Msg.getMsg(doc.getCtx(), "NotFound") + " - "
				+ Msg.getElement(doc.getCtx(), MCharge.COLUMNNAME_C_Charge_ID) + "=" + chargeName + ", "
				+ Msg.getElement(doc.getCtx(), MAcctSchema.COLUMNNAME_C_AcctSchema_ID) + "=" + as.getName()
				+ "): " + line;
	}
}
