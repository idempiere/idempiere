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

import org.compiere.model.I_C_Order;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.compiere.process.ICreditManager;
import org.compiere.util.Env;

/**
 * Credit Manager for InOut
 * 
 * @author Logilite Technologies
 * @since  June 25, 2023
 */
public class CreditManagerInOut implements ICreditManager
{
	private MInOut mInOut;

	public CreditManagerInOut(PO po)
	{
		this.mInOut = (MInOut) po;
	}

	@Override
	public String creditCheck(String docAction)
	{
		if (MInOut.DOCACTION_Prepare.equals(docAction) && mInOut.isSOTrx() && !mInOut.isReversal() && !mInOut.isCustomerReturn())
		{
			I_C_Order order = mInOut.getC_Order();
			if (order != null
				&& MDocType.DOCSUBTYPESO_PrepayOrder.equals(order.getC_DocType().getDocSubTypeSO())
				&& !MSysConfig.getBooleanValue(MSysConfig.CHECK_CREDIT_ON_PREPAY_ORDER, true, mInOut.getAD_Client_ID(), mInOut.getAD_Org_ID()))
			{
				// ignore -- don't validate Prepay Orders depending on sysconfig parameter
			}
			else
			{
				MBPartner bp = new MBPartner(mInOut.getCtx(), mInOut.getC_BPartner_ID(), mInOut.get_TrxName());
				if (MBPartner.SOCREDITSTATUS_CreditStop.equals(bp.getSOCreditStatus()))
				{
					return "@BPartnerCreditStop@ - @TotalOpenBalance@=" + bp.getTotalOpenBalance()
							+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
				}
				if (MBPartner.SOCREDITSTATUS_CreditHold.equals(bp.getSOCreditStatus()))
				{
					return "@BPartnerCreditHold@ - @TotalOpenBalance@=" + bp.getTotalOpenBalance()
							+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
				}
				if (!MBPartner.SOCREDITSTATUS_NoCreditCheck.equals(bp.getSOCreditStatus())
					&& Env.ZERO.compareTo(bp.getSO_CreditLimit()) != 0)
				{
					BigDecimal notInvoicedAmt = MBPartner.getNotInvoicedAmt(mInOut.getC_BPartner_ID());
					if (MBPartner.SOCREDITSTATUS_CreditHold.equals(bp.getSOCreditStatus(notInvoicedAmt)))
					{
						return "@BPartnerOverSCreditHold@ - @TotalOpenBalance@="	+ bp.getTotalOpenBalance()
								+ ", @NotInvoicedAmt@=" + notInvoicedAmt
								+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
					}
				}
			}
		}
		return null;
	} // creditCheck
}
