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
import java.util.Properties;

import org.adempiere.base.CreditStatus;
import org.adempiere.base.ICreditManager;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MConversionRateUtil;
import org.compiere.model.MPayment;
import org.compiere.model.MPaymentAllocate;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Credit Status Management for Payment
 * 
 * @author Logilite Technologies
 * @since  June 25, 2023
 */
public class CreditManagerPayment implements ICreditManager
{
	private MPayment payment;

	/**
	 * Payment Credit Manager Load Constructor
	 * 
	 * @param po MPayment
	 */
	public CreditManagerPayment(MPayment po)
	{
		this.payment = po;
	}

	@Override
	public CreditStatus checkCreditStatus(String docAction)
	{
		String errorMsg = null;
		if (MPayment.DOCACTION_Prepare.equals(docAction) && !payment.isReceipt())
		{ //	Do not pay when Credit Stop/Hold and issue refund to customer
			MBPartner bp = new MBPartner(payment.getCtx(), payment.getC_BPartner_ID(), payment.get_TrxName());
			if (MBPartner.SOCREDITSTATUS_CreditStop.equals(bp.getSOCreditStatus()))
			{
				errorMsg = "@BPartnerCreditStop@ - @TotalOpenBalance@=" + bp.getTotalOpenBalance()
						+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
			}
			if (MBPartner.SOCREDITSTATUS_CreditHold.equals(bp.getSOCreditStatus()))
			{
				errorMsg = "@BPartnerCreditHold@ - @TotalOpenBalance@=" + bp.getTotalOpenBalance()
						+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
			}
		}
		else if (MPayment.DOCACTION_Complete.equals(docAction))
		{
			// Charge Handling
			boolean createdAllocationRecords = false;
			if (payment.getC_Charge_ID() == 0)
			{
				createdAllocationRecords = payment.allocateIt(); // Create Allocation Records
				payment.testAllocation();
			}
			// Update BP for Prepayments
			if (payment.getC_BPartner_ID() != 0
				&& payment.getC_Invoice_ID() == 0
				&& payment.getC_Charge_ID() == 0
				&& MPaymentAllocate.get(payment).length == 0
				&& !createdAllocationRecords)
			{
				Properties ctx = payment.getCtx();
				MBPartner bp = new MBPartner(ctx, payment.getC_BPartner_ID(), payment.get_TrxName());
				DB.getDatabase().forUpdate(bp, 0);
				// Update total balance to include this payment
				BigDecimal payAmt = null;
				int baseCurrencyId = Env.getContextAsInt(ctx, Env.C_CURRENCY_ID);
				if (payment.getC_Currency_ID() != baseCurrencyId && payment.isOverrideCurrencyRate())
				{
					payAmt = payment.getConvertedAmt();
				}
				else
				{
					payAmt = MConversionRate.convertBase(	ctx, payment.getPayAmt(),
															payment.getC_Currency_ID(),
															payment.getDateAcct(),
															payment.getC_ConversionType_ID(),
															payment.getAD_Client_ID(),
															payment.getAD_Org_ID());

					if (payAmt == null)
					{
						errorMsg = MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingCurrencyToBaseCurrency",
																	payment.getC_Currency_ID(),
																	MClient.get(ctx).getC_Currency_ID(),
																	payment.getC_ConversionType_ID(),
																	payment.getDateAcct(), payment.get_TrxName());
					}
				}
				// Total Balance
				BigDecimal newBalance = bp.getTotalOpenBalance();
				if (newBalance == null)
					newBalance = Env.ZERO;
				if (payment.isReceipt())
					newBalance = newBalance.subtract(payAmt);
				else
					newBalance = newBalance.add(payAmt);

				bp.setTotalOpenBalance(newBalance);
				bp.setSOCreditStatus();
				bp.saveEx();
			}
		}
		else if (MPayment.DOCACTION_Reverse_Accrual.equals(docAction) || MPayment.DOCACTION_Reverse_Correct.equals(docAction))
		{
			if (payment.getC_BPartner_ID() != 0)
			{
				MBPartner bp = new MBPartner(payment.getCtx(), payment.getC_BPartner_ID(), payment.get_TrxName());
				bp.setTotalOpenBalance();
				bp.saveEx(payment.get_TrxName());
			}
		}
		return new CreditStatus(errorMsg, !Util.isEmpty(errorMsg));
	} // creditCheck
}
