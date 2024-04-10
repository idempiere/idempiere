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
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * 	Payment Allocate Model.
 *  Process to create allocation records (C_AllocationHdr and C_AllocationLine)
 *	
 *  @author Jorg Janke
 *  @version $Id: MPaymentAllocate.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MPaymentAllocate extends X_C_PaymentAllocate
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2894385378672375131L;

	/**
	 * 	Get active Payment Allocation of Payment
	 *	@param parent payment
	 *	@return array of payment allocations
	 */
	public static MPaymentAllocate[] get (MPayment parent)
	{
		final String whereClause = "C_Payment_ID=?";
		Query query = MTable.get(parent.getCtx(), Table_ID).createQuery(whereClause, parent.get_TrxName());
		query.setParameters(parent.getC_Payment_ID()).setOnlyActiveRecords(true);
		List<MPaymentAllocate> list = query.list();
		return list.toArray(new MPaymentAllocate[list.size()]);
	}	//	get
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_PaymentAllocate_UU  UUID key
     * @param trxName Transaction
     */
    public MPaymentAllocate(Properties ctx, String C_PaymentAllocate_UU, String trxName) {
        super(ctx, C_PaymentAllocate_UU, trxName);
		if (Util.isEmpty(C_PaymentAllocate_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_PaymentAllocate_ID id
	 *	@param trxName trx
	 */
	public MPaymentAllocate (Properties ctx, int C_PaymentAllocate_ID, String trxName)
	{
		super (ctx, C_PaymentAllocate_ID, trxName);
		if (C_PaymentAllocate_ID == 0)
			setInitialDefaults();
	}	//	MPaymentAllocate

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setAmount (Env.ZERO);
		setDiscountAmt (Env.ZERO);
		setOverUnderAmt (Env.ZERO);
		setWriteOffAmt (Env.ZERO);
		setInvoiceAmt(Env.ZERO);
	}

	/**	The Invoice				*/
	private MInvoice	m_invoice = null;
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MPaymentAllocate (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MPaymentAllocate
	
	/**
	 * 	Set C_Invoice_ID
	 *	@param C_Invoice_ID id
	 */
	public void setC_Invoice_ID (int C_Invoice_ID)
	{
		super.setC_Invoice_ID (C_Invoice_ID);
		m_invoice = null;
	}	//	setC_Invoice_ID
	
	/**
	 * 	Get Invoice
	 *	@return invoice
	 */
	public MInvoice getInvoice()
	{
		if (m_invoice == null && getC_Invoice_ID() != 0)
			m_invoice = new MInvoice(getCtx(), getC_Invoice_ID(), get_TrxName());
		return m_invoice;
	}	//	getInvoice
	
	/**
	 * 	Get BPartner of Invoice
	 *	@return bp
	 */
	public int getC_BPartner_ID()
	{
		if (m_invoice == null)
			getInvoice();
		if (m_invoice == null)
			return 0;
		return m_invoice.getC_BPartner_ID();
	}	//	getC_BPartner_ID
		
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		// Check is payment already allocated to charge or invoice or order
		MPayment payment = new MPayment (getCtx(), getC_Payment_ID(), get_TrxName());
		if ((newRecord || is_ValueChanged("C_Invoice_ID"))
			&& (payment.getC_Charge_ID() != 0 
				|| payment.getC_Invoice_ID() != 0 
				|| payment.getC_Order_ID() != 0))
		{
			log.saveError("PaymentIsAllocated", "");
			return false;
		}
		
		// Validate allocation amount = invoice amount
		BigDecimal check = getAmount()
			.add(getDiscountAmt())
			.add(getWriteOffAmt())
			.add(getOverUnderAmt());
		if (check.compareTo(getInvoiceAmt()) != 0)
		{
			log.saveError("Error", Msg.parseTranslation(getCtx(), 
				"@InvoiceAmt@(" + getInvoiceAmt()
				+ ") <> @Totals@(" + check + ")"));
			return false;
		}
		
		//	Set organization from invoice
		if (newRecord || is_ValueChanged("C_Invoice_ID"))
		{
			getInvoice();
			if (m_invoice != null)
				setAD_Org_ID(m_invoice.getAD_Org_ID());
		}
		
		return true;
	}	//	beforeSave
	
}	//	MPaymentAllocate
