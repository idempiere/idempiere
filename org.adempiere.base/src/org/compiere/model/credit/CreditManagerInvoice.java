/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.compiere.model.credit;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.logging.Level;

import org.adempiere.base.CreditStatus;
import org.adempiere.base.ICreditManager;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MConversionRateUtil;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Credit Status Management for Invoice
 * 
 * @author Logilite Technologies
 * @since  June 25, 2023
 */
public class CreditManagerInvoice implements ICreditManager
{
	/** Logger */
	protected transient CLogger	log	= CLogger.getCLogger(CreditManagerInvoice.class);

	private MInvoice			mInvoice;

	/**
	 * Invoice Credit Manager Load Constructor
	 * 
	 * @param po MInvoice
	 */
	public CreditManagerInvoice(MInvoice po)
	{
		this.mInvoice = po;
	}

	@Override
	public CreditStatus checkCreditStatus(String docAction)
	{
		String errorMsg = null;
		if (MInvoice.DOCACTION_Prepare.equals(docAction) && mInvoice.isSOTrx())
		{
			MDocType doc = (MDocType) mInvoice.getC_DocTypeTarget();
			// IDEMPIERE-365 - just check credit if is going to increase the debt
			if ((doc.getDocBaseType().equals(MDocType.DOCBASETYPE_ARCreditMemo) && mInvoice.getGrandTotal().signum() < 0)
				|| (doc.getDocBaseType().equals(MDocType.DOCBASETYPE_ARInvoice) && mInvoice.getGrandTotal().signum() > 0))
			{
				MBPartner bp = new MBPartner(mInvoice.getCtx(), mInvoice.getC_BPartner_ID(), mInvoice.get_TrxName());
				if (MBPartner.SOCREDITSTATUS_CreditStop.equals(bp.getSOCreditStatus()))
				{
					errorMsg = "@BPartnerCreditStop@ - @TotalOpenBalance@=" + bp.getTotalOpenBalance()
							+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
				}
			}
		}
		else if (MInvoice.DOCACTION_Complete.equals(docAction))
		{
			// POS supports multiple payments
			boolean fromPOS = false;
			if (mInvoice.getC_Order_ID() > 0)
			{
				fromPOS = mInvoice.getC_Order().getC_POS_ID() > 0;
			}
			// Update BP Statistics
			MBPartner bp = new MBPartner(mInvoice.getCtx(), mInvoice.getC_BPartner_ID(), mInvoice.get_TrxName());
			DB.getDatabase().forUpdate(bp, 0);
			// Update total revenue and balance / credit limit (reversed on
			// AllocationLine.processIt)
			BigDecimal invAmt = null;
			int baseCurrencyId = Env.getContextAsInt(mInvoice.getCtx(), Env.C_CURRENCY_ID);
			if (mInvoice.getC_Currency_ID() != baseCurrencyId && mInvoice.isOverrideCurrencyRate())
			{
				invAmt = mInvoice.getGrandTotal(true).multiply(mInvoice.getCurrencyRate());
				int stdPrecision = MCurrency.getStdPrecision(mInvoice.getCtx(), baseCurrencyId);
				if (invAmt.scale() > stdPrecision)
					invAmt = invAmt.setScale(stdPrecision, RoundingMode.HALF_UP);
			}
			else
			{
				invAmt = MConversionRate.convertBase(	mInvoice.getCtx(),
														mInvoice.getGrandTotal(true), // CM adjusted
														mInvoice.getC_Currency_ID(),
														mInvoice.getDateAcct(),
														mInvoice.getC_ConversionType_ID(),
														mInvoice.getAD_Client_ID(),
														mInvoice.getAD_Org_ID());
			}
			if (invAmt == null)
			{
				errorMsg = MConversionRateUtil.getErrorMessage(	mInvoice.getCtx(),
															"ErrorConvertingCurrencyToBaseCurrency",
															mInvoice.getC_Currency_ID(),
															MClient.get(mInvoice.getCtx()).getC_Currency_ID(),
															mInvoice.getC_ConversionType_ID(),
															mInvoice.getDateAcct(),
															mInvoice.get_TrxName());
			}
			// Total Balance
			BigDecimal newBalance = bp.getTotalOpenBalance();
			if (newBalance == null)
				newBalance = Env.ZERO;
			if (mInvoice.isSOTrx())
			{
				newBalance = newBalance.add(invAmt);
				//
				if (bp.getFirstSale() == null)
					bp.setFirstSale(mInvoice.getDateInvoiced());

				BigDecimal newLifeAmt = bp.getActualLifeTimeValue();
				if (newLifeAmt == null)
					newLifeAmt = invAmt;
				else
					newLifeAmt = newLifeAmt.add(invAmt);

				BigDecimal newCreditAmt = bp.getSO_CreditUsed();
				if (newCreditAmt == null)
					newCreditAmt = invAmt;
				else
					newCreditAmt = newCreditAmt.add(invAmt);
				//
				if (log.isLoggable(Level.FINE))
					log.fine(	"GrandTotal="	+ mInvoice.getGrandTotal(true) + "(" + invAmt
								+ ") BP Life=" + bp.getActualLifeTimeValue() + "->" + newLifeAmt
								+ ", Credit=" + bp.getSO_CreditUsed() + "->" + newCreditAmt
								+ ", Balance=" + bp.getTotalOpenBalance() + " -> " + newBalance);
				bp.setActualLifeTimeValue(newLifeAmt);
				bp.setSO_CreditUsed(newCreditAmt);
			} // SO
			else
			{
				newBalance = newBalance.subtract(invAmt);
				if (log.isLoggable(Level.FINE))
					log.fine(	"GrandTotal="	+ mInvoice.getGrandTotal(true) + "(" + invAmt
								+ ") Balance=" + bp.getTotalOpenBalance() + " -> " + newBalance);
			}
			// the payment just created already updated the open balance
			if (!(MInvoice.PAYMENTRULE_Cash.equals(mInvoice.getPaymentRule()) && !fromPOS))
			{
				bp.setTotalOpenBalance(newBalance);
			}
			bp.setSOCreditStatus();
			if (!bp.save(mInvoice.get_TrxName()))
			{
				errorMsg = "Could not update Business Partner";
			}
		}
		return new CreditStatus(errorMsg, !Util.isEmpty(errorMsg));
	} // creditCheck
}
