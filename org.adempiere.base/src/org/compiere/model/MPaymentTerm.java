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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;


/**
 *	Payment Term Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MPaymentTerm.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 *  @author Cristina Ghita, www.arhipac.ro
 * 			<li>BF [ 2889886 ] Net days in payment term
 * 				https://sourceforge.net/p/adempiere/bugs/2194/
 */
public class MPaymentTerm extends X_C_PaymentTerm
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4506224598566445450L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_PaymentTerm_ID id
	 *	@param trxName transaction
	 */
	public MPaymentTerm(Properties ctx, int C_PaymentTerm_ID, String trxName)
	{
		super(ctx, C_PaymentTerm_ID, trxName);
		if (C_PaymentTerm_ID == 0)
		{
			setAfterDelivery (false);
			setNetDays (0);
			setDiscount (Env.ZERO);
			setDiscount2 (Env.ZERO);
			setDiscountDays (0);
			setDiscountDays2 (0);
			setGraceDays (0);
			setIsDueFixed (false);
			setIsValid (false);
		}	}	//	MPaymentTerm

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPaymentTerm(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPaymentTerm

	/**	Payment Schedule children			*/
	private MPaySchedule[]				m_schedule;

	/**
	 * 	Get Payment Schedule
	 * 	@param requery if true re-query
	 *	@return array of schedule
	 */
	public MPaySchedule[] getSchedule (boolean requery)
	{
		if (m_schedule != null && !requery)
			return m_schedule;
		String sql = "SELECT * FROM C_PaySchedule WHERE C_PaymentTerm_ID=? AND IsActive='Y' ORDER BY NetDays";
		ArrayList<MPaySchedule> list = new ArrayList<MPaySchedule>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getC_PaymentTerm_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MPaySchedule ps = new MPaySchedule(getCtx(), rs, get_TrxName());
				ps.setParent(this);
				list.add (ps);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "getSchedule", e); 
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		m_schedule = new MPaySchedule[list.size()];
		list.toArray(m_schedule);
		return m_schedule;
	}	//	getSchedule

	/**
	 * 	Validate Payment Term and Schedule
	 *	@return Validation Message @OK@ or error
	 */
	public String validate()
	{
		String validMsg = Msg.parseTranslation(getCtx(), "@OK@");
		getSchedule(true);
		if (m_schedule.length == 0)
		{
			if (! isValid())
				setIsValid(true);
			return validMsg;
		}
		
		//	Add up
		BigDecimal total = Env.ZERO;
		for (int i = 0; i < m_schedule.length; i++)
		{
			BigDecimal percent = m_schedule[i].getPercentage();
			if (percent != null)
				total = total.add(percent);
		}
		boolean valid = total.compareTo(Env.ONEHUNDRED) == 0;
		if (isValid() != valid)
			setIsValid (valid);
		for (int i = 0; i < m_schedule.length; i++)
		{
			if (m_schedule[i].isValid() != valid)
			{
				m_schedule[i].setIsValid(valid);
				m_schedule[i].saveEx();
			}
		}
		if (valid)
			return validMsg;
		return "@Total@ = " + total + " - @Difference@ = " + Env.ONEHUNDRED.subtract(total); 
	}	//	validate


	/*************************************************************************
	 * 	Apply Payment Term to Invoice -
	 *	@param C_Invoice_ID invoice
	 *	@return true if payment schedule is valid
	 */
	public boolean apply (int C_Invoice_ID)
	{
		MInvoice invoice = new MInvoice (getCtx(), C_Invoice_ID, get_TrxName());
		if (invoice == null || invoice.get_ID() == 0)
		{
			log.log(Level.SEVERE, "apply - Not valid C_Invoice_ID=" + C_Invoice_ID);
			return false;
		}
		return apply (invoice);
	}	//	apply
	
	/**
	 * 	Apply Payment Term to Invoice
	 *	@param invoice invoice
	 *	@return true if payment schedule is valid
	 */
	public boolean apply (MInvoice invoice)
	{
		if (invoice == null || invoice.get_ID() == 0)
		{
			log.log(Level.SEVERE, "No valid invoice - " + invoice);
			return false;
		}

		// do not apply payment term if the invoice is not on credit or if total is zero
		if ( (! (MInvoice.PAYMENTRULE_OnCredit.equals(invoice.getPaymentRule()) || MInvoice.PAYMENTRULE_DirectDebit.equals(invoice.getPaymentRule())))
			|| invoice.getGrandTotal().signum() == 0)
			return false;
			
		if (!isValid())
			return applyNoSchedule (invoice);
		//
		getSchedule(true);
		if (m_schedule.length <= 0) // Allow schedules with just one record
			return applyNoSchedule (invoice);
		else	//	only if valid
			return applySchedule(invoice);		
	}	//	apply

	/**
	 * 	Apply Payment Term without schedule to Invoice
	 *	@param invoice invoice
	 *	@return false as no payment schedule
	 */
	private boolean applyNoSchedule (MInvoice invoice)
	{
		deleteInvoicePaySchedule (invoice.getC_Invoice_ID(), invoice.get_TrxName());
		//	updateInvoice
		if (invoice.getC_PaymentTerm_ID() != getC_PaymentTerm_ID())
			invoice.setC_PaymentTerm_ID(getC_PaymentTerm_ID());
		if (invoice.isPayScheduleValid())
			invoice.setIsPayScheduleValid(false);
		return false;
	}	//	applyNoSchedule

	/**
	 * 	Apply Payment Term with schedule to Invoice
	 *	@param invoice invoice
	 *	@return true if payment schedule is valid
	 */
	private boolean applySchedule (MInvoice invoice)
	{
		deleteInvoicePaySchedule (invoice.getC_Invoice_ID(), invoice.get_TrxName());
		//	Create Schedule
		MInvoicePaySchedule ips = null;
		BigDecimal remainder = invoice.getGrandTotal();
		for (int i = 0; i < m_schedule.length; i++)
		{
			ips = new MInvoicePaySchedule (invoice, m_schedule[i]);
			ips.saveEx(invoice.get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine(ips.toString());
			remainder = remainder.subtract(ips.getDueAmt());
		}	//	for all schedules
		//	Remainder - update last
		if (remainder.compareTo(Env.ZERO) != 0 && ips != null)
		{
			ips.setDueAmt(ips.getDueAmt().add(remainder));
			ips.saveEx(invoice.get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Remainder=" + remainder + " - " + ips);
		}
		
		//	updateInvoice
		if (invoice.getC_PaymentTerm_ID() != getC_PaymentTerm_ID())
			invoice.setC_PaymentTerm_ID(getC_PaymentTerm_ID());
		return invoice.validatePaySchedule();
	}	//	applySchedule

	/**
	 * 	Delete existing Invoice Payment Schedule
	 *	@param C_Invoice_ID id
	 *	@param trxName transaction
	 */
	private void deleteInvoicePaySchedule (int C_Invoice_ID, String trxName)
	{
		Query query = new Query(Env.getCtx(), I_C_InvoicePaySchedule.Table_Name, "C_Invoice_ID=?", trxName);
		List<MInvoicePaySchedule> ipsList = query.setParameters(C_Invoice_ID).list();
		for (MInvoicePaySchedule ips : ipsList)
		{
			ips.deleteEx(true);
		}
		if (log.isLoggable(Level.FINE)) log.fine("C_Invoice_ID=" + C_Invoice_ID + " - #" + ipsList.size());
	}	//	deleteInvoicePaySchedule

	
	/*************************************************************************
	 * 	Apply Payment Term to Order -
	 *	@param C_Order_ID order
	 *	@return true if payment schedule is valid
	 */
	public boolean applyOrder (int C_Order_ID)
	{
		MOrder order = new MOrder (getCtx(), C_Order_ID, get_TrxName());
		if (order == null || order.get_ID() == 0)
		{
			log.log(Level.SEVERE, "apply - Not valid C_Order_ID=" + C_Order_ID);
			return false;
		}
		return applyOrder (order);
	}	//	applyOrder
	
	/**
	 * 	Apply Payment Term to Order
	 *	@param order order
	 *	@return true if payment schedule is valid
	 */
	public boolean applyOrder (MOrder order)
	{
		if (order == null || order.get_ID() == 0)
		{
			log.log(Level.SEVERE, "No valid order - " + order);
			return false;
		}
		
		// do not apply payment term if the order is not on credit or if total is zero
		if ( (! (MOrder.PAYMENTRULE_OnCredit.equals(order.getPaymentRule()) || MOrder.PAYMENTRULE_DirectDebit.equals(order.getPaymentRule())) )
			|| order.getGrandTotal().signum() == 0)
			return false;
			
		if (!isValid())
			return applyOrderNoSchedule (order);
		//
		getSchedule(true);
		if (m_schedule.length <= 0) // Allow schedules with just one record
			return applyOrderNoSchedule (order);
		else	//	only if valid
			return applyOrderSchedule(order);
	}	//	applyOrder

	/**
	 * 	Apply Payment Term without schedule to Order
	 *	@param order order
	 *	@return false as no payment schedule
	 */
	private boolean applyOrderNoSchedule (MOrder order)
	{
		deleteOrderPaySchedule (order.getC_Order_ID(), order.get_TrxName());
		//	updateOrder
		if (order.getC_PaymentTerm_ID() != getC_PaymentTerm_ID())
			order.setC_PaymentTerm_ID(getC_PaymentTerm_ID());
		if (order.isPayScheduleValid())
			order.setIsPayScheduleValid(false);
		return false;
	}	//	applyOrderNoSchedule

	/**
	 * 	Apply Payment Term with schedule to Order
	 *	@param order order
	 *	@return true if payment schedule is valid
	 */
	private boolean applyOrderSchedule (MOrder order)
	{
		deleteOrderPaySchedule (order.getC_Order_ID(), order.get_TrxName());
		//	Create Schedule
		MOrderPaySchedule ops = null;
		BigDecimal remainder = order.getGrandTotal();
		for (int i = 0; i < m_schedule.length; i++)
		{
			ops = new MOrderPaySchedule (order, m_schedule[i]);
			ops.saveEx(order.get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine(ops.toString());
			remainder = remainder.subtract(ops.getDueAmt());
		}	//	for all schedules
		//	Remainder - update last
		if (remainder.compareTo(Env.ZERO) != 0 && ops != null)
		{
			ops.setDueAmt(ops.getDueAmt().add(remainder));
			ops.saveEx(order.get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Remainder=" + remainder + " - " + ops);
		}
		
		//	updateOrder
		if (order.getC_PaymentTerm_ID() != getC_PaymentTerm_ID())
			order.setC_PaymentTerm_ID(getC_PaymentTerm_ID());
		return order.validatePaySchedule();
	}	//	applyOrderSchedule

	/**
	 * 	Delete existing Order Payment Schedule
	 *	@param C_Order_ID id
	 *	@param trxName transaction
	 */
	private void deleteOrderPaySchedule (int C_Order_ID, String trxName)
	{
		Query query = new Query(Env.getCtx(), I_C_OrderPaySchedule.Table_Name, "C_Order_ID=?", trxName);
		List<MOrderPaySchedule> opsList = query.setParameters(C_Order_ID).list();
		for (MOrderPaySchedule ops : opsList)
		{
			ops.deleteEx(true);
		}
		if (log.isLoggable(Level.FINE)) log.fine("C_Order_ID=" + C_Order_ID + " - #" + opsList.size());
	}	//	deleteOrderPaySchedule

	
	/**************************************************************************
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MPaymentTerm[");
		sb.append(get_ID()).append("-").append(getName())
			.append(",Valid=").append(isValid())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (isDueFixed())
		{
			int dd = getFixMonthDay();
			if (dd < 1 || dd > 31)
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), "@Invalid@ @FixMonthDay@"));
				return false;
			}
			dd = getFixMonthCutoff();
			if (dd < 1 || dd > 31)
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), "@Invalid@ @FixMonthCutoff@"));
				return false;
			}
		}
		
		if (Integer.signum(getNetDays()) < 0)
		{
			throw new AdempiereException(Msg.parseTranslation(getCtx(), "@NetDays@") + " " +
										 Msg.parseTranslation(getCtx(), "@positive.number@"));
		}
		
		if (!newRecord || !isValid())
			validate();
		return true;
	}	//	beforeSave
	
}	//	MPaymentTerm
