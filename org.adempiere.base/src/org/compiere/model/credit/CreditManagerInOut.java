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

import org.adempiere.base.CreditStatus;
import org.adempiere.base.ICreditManager;
import org.compiere.model.I_C_Order;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Credit Status Management for InOut
 * 
 * @author Logilite Technologies
 * @since  June 25, 2023
 */
public class CreditManagerInOut implements ICreditManager
{
	private MInOut mInOut;

	/**
	 * InOut Credit Manager Load Constructor
	 * 
	 * @param po MInOut
	 */
	public CreditManagerInOut(MInOut po)
	{
		this.mInOut = po;
	}

	@Override
	public CreditStatus checkCreditStatus(String docAction)
	{
		String errorMsg = null;
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
					errorMsg = "@BPartnerCreditStop@ - @TotalOpenBalance@=" + bp.getTotalOpenBalance()
							+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
				}
				if (MBPartner.SOCREDITSTATUS_CreditHold.equals(bp.getSOCreditStatus()))
				{
					errorMsg = "@BPartnerCreditHold@ - @TotalOpenBalance@=" + bp.getTotalOpenBalance()
							+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
				}
				if (!MBPartner.SOCREDITSTATUS_NoCreditCheck.equals(bp.getSOCreditStatus())
					&& Env.ZERO.compareTo(bp.getSO_CreditLimit()) != 0)
				{
					BigDecimal notInvoicedAmt = MBPartner.getNotInvoicedAmt(mInOut.getC_BPartner_ID());
					if (MBPartner.SOCREDITSTATUS_CreditHold.equals(bp.getSOCreditStatus(notInvoicedAmt)))
					{
						errorMsg = "@BPartnerOverSCreditHold@ - @TotalOpenBalance@="	+ bp.getTotalOpenBalance()
								+ ", @NotInvoicedAmt@=" + notInvoicedAmt
								+ ", @SO_CreditLimit@=" + bp.getSO_CreditLimit();
					}
				}
			}
		}
		
		return new CreditStatus(errorMsg, !Util.isEmpty(errorMsg));
	} // creditCheck
}
