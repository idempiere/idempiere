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
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *	Dunning Run Line Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MDunningRunLine.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 */
public class MDunningRunLine extends X_C_DunningRunLine
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6329441027195611155L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_DunningRunLine_UU  UUID key
     * @param trxName Transaction
     */
    public MDunningRunLine(Properties ctx, String C_DunningRunLine_UU, String trxName) {
        super(ctx, C_DunningRunLine_UU, trxName);
		if (Util.isEmpty(C_DunningRunLine_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standarc Constructor
	 *	@param ctx ctx
	 *	@param C_DunningRunLine_ID id
	 *	@param trxName transaction
	 */
	public MDunningRunLine (Properties ctx, int C_DunningRunLine_ID, String trxName)
	{
		super (ctx, C_DunningRunLine_ID, trxName);
		if (C_DunningRunLine_ID == 0)
			setInitialDefaults();
	}	//	MDunningRunLine

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setAmt (Env.ZERO);
		setOpenAmt(Env.ZERO);
		setConvertedAmt (Env.ZERO);
		setFeeAmt (Env.ZERO);
		setInterestAmt (Env.ZERO);
		setTotalAmt (Env.ZERO);
		setDaysDue (0);
		setTimesDunned (0);
		setIsInDispute(false);
		setProcessed (false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDunningRunLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDunningRunLine

	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 */
	public MDunningRunLine (MDunningRunEntry parent)
	{
		this(parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setC_DunningRunEntry_ID(parent.getC_DunningRunEntry_ID());
		//
		m_parent = parent;
		m_C_CurrencyTo_ID = parent.getC_Currency_ID();
	}	//	MDunningRunLine

	private MDunningRunEntry	m_parent = null;
	private MInvoice			m_invoice = null;
	private MPayment			m_payment = null;
	private int					m_C_CurrencyFrom_ID = 0;
	private int					m_C_CurrencyTo_ID = 0;
	
	/**
	 * 	Get Parent 
	 *	@return parent
	 */
	public MDunningRunEntry getParent()
	{
		if (m_parent == null)
			m_parent = new MDunningRunEntry (getCtx(), getC_DunningRunEntry_ID(), get_TrxName());
		return m_parent;
	}	//	getParent
	
	/**
	 * 	Get Invoice
	 *	@return invoice or null
	 */
	public MInvoice getInvoice ()
	{
		if (getC_Invoice_ID() == 0)
			m_invoice = null;
		else if (m_invoice == null)
			m_invoice = new MInvoice (getCtx(), getC_Invoice_ID(), get_TrxName());
		return m_invoice;
	}	//	getInvoice
	
	/**
	 * 	Set Invoice
	 *	@param invoice The invoice to set.
	 */
	public void setInvoice (MInvoice invoice)
	{
		m_invoice = invoice;
		if (invoice != null)
		{
			m_C_CurrencyFrom_ID = invoice.getC_Currency_ID();
			setAmt(invoice.getGrandTotal());
			setOpenAmt(getAmt());	//	not correct
			setConvertedAmt (MConversionRate.convert(getCtx(), getOpenAmt(), 
				getC_CurrencyFrom_ID(), getC_CurrencyTo_ID(), getAD_Client_ID(), getAD_Org_ID()));
		}
		else
		{
			m_C_CurrencyFrom_ID = 0;
			setAmt(Env.ZERO);
			setOpenAmt(Env.ZERO);
			setConvertedAmt(Env.ZERO);
		}
	}	//	setInvoice
	
	/**
	 * 	Set Invoice
	 *	@param C_Invoice_ID
	 *	@param C_Currency_ID
	 *	@param GrandTotal 
	 *	@param Open
	 *  @param FeeAmount 
	 *	@param DaysDue
	 *	@param IsInDispute 
	 *	@param TimesDunned
	 *	@param DaysAfterLast not used
	 */
	public void setInvoice (int C_Invoice_ID, int C_Currency_ID, 
		BigDecimal GrandTotal, BigDecimal Open, 
		BigDecimal FeeAmount, 
		int DaysDue, boolean IsInDispute, 
		int TimesDunned, int DaysAfterLast)
	{
		setC_Invoice_ID(C_Invoice_ID);
		m_C_CurrencyFrom_ID = C_Currency_ID;
		setAmt (GrandTotal);
		setOpenAmt (Open);
		setFeeAmt (FeeAmount);
		setConvertedAmt (MConversionRate.convert(getCtx(), getOpenAmt(), 
			C_Currency_ID, getC_CurrencyTo_ID(), getAD_Client_ID(), getAD_Org_ID()));
		setIsInDispute(IsInDispute);
		setDaysDue(DaysDue);
		setTimesDunned(TimesDunned);
	}	//	setInvoice
	
	
	/**
	 * 	Set Fee
	 *	@param C_Currency_ID
	 *  @param FeeAmount 
	 */
	public void setFee (int C_Currency_ID, 
		BigDecimal FeeAmount)
	{
		m_C_CurrencyFrom_ID = C_Currency_ID;
		setAmt (FeeAmount);
		setOpenAmt (FeeAmount);
		setFeeAmt (FeeAmount);
		setConvertedAmt (MConversionRate.convert(getCtx(), getOpenAmt(), 
			C_Currency_ID, getC_CurrencyTo_ID(), getAD_Client_ID(), getAD_Org_ID()));
	}	//	setInvoice
	
	/**
	 * 	Get Payment
	 *	@return payment or null
	 */
	public MPayment getPayment ()
	{
		if (getC_Payment_ID() == 0)
			m_payment = null;
		else if (m_payment == null)
			m_payment = new MPayment (getCtx(), getC_Payment_ID(), get_TrxName());
		return m_payment;
	}	//	getPayment
	
	/**
	 * 	Set Payment
	 *	@param C_Payment_ID
	 *	@param C_Currency_ID
	 *	@param PayAmt
	 *	@param OpenAmt
	 */
	public void setPayment (int C_Payment_ID, int C_Currency_ID, 
		BigDecimal PayAmt, BigDecimal OpenAmt)
	{
		setC_Payment_ID(C_Payment_ID);
		m_C_CurrencyFrom_ID = C_Currency_ID;
		setAmt (PayAmt);
		setOpenAmt (OpenAmt);
		setConvertedAmt (MConversionRate.convert(getCtx(), getOpenAmt(), 
			C_Currency_ID, getC_CurrencyTo_ID(), getAD_Client_ID(), getAD_Org_ID()));
	}	//	setPayment

	
	/**
	 * 	Get Currency From (Invoice/Payment)
	 *	@return C_Currency_ID of invoice or payment
	 */
	public int getC_CurrencyFrom_ID ()
	{
		if (m_C_CurrencyFrom_ID == 0)
		{
			if (getC_Invoice_ID() != 0)
				m_C_CurrencyFrom_ID = getInvoice().getC_Currency_ID();
			else if (getC_Payment_ID() != 0)
				m_C_CurrencyFrom_ID = getPayment().getC_Currency_ID();
		}
		return m_C_CurrencyFrom_ID;
	}	//	getC_CurrencyFrom_ID
	
	/**
	 * 	Get Currency To from Parent
	 *	@return C_Currency_ID of parent (MDunningRunEntry)
	 */
	public int getC_CurrencyTo_ID ()
	{
		if (m_C_CurrencyTo_ID == 0)
			m_C_CurrencyTo_ID = getParent().getC_Currency_ID();
		return m_C_CurrencyTo_ID;
	}	//	getC_CurrencyTo_ID
	
	/**
	 * 	Update amount (open, converted, total).<br/>
	 *  Update collection status of invoice.
	 *	@param newRecord new
	 *	@return true
	 */
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		// Reset Amt and OpenAmt to 0 if both invoice and payment field is not fill
		if (getC_Invoice_ID() == 0 && getC_Payment_ID() == 0)
		{
			setAmt(Env.ZERO);
			setOpenAmt(Env.ZERO);
		}
		// Calculate Converted Amt from OpenAmt
		if (Env.ZERO.compareTo(getOpenAmt()) == 0)
			setConvertedAmt (Env.ZERO);
		else if (Env.ZERO.compareTo(getConvertedAmt()) == 0)
			setConvertedAmt (MConversionRate.convert(getCtx(), getOpenAmt(), 
				getC_CurrencyFrom_ID(), getC_CurrencyTo_ID(), getAD_Client_ID(), getAD_Org_ID()));
		// Calculate TotalAmt
		setTotalAmt(getConvertedAmt().add(getFeeAmt()).add(getInterestAmt()));
		// Update invoice with dunning level 
		if (isProcessed() && getInvoice() != null)
		{
			I_C_DunningLevel level = getParent().getC_DunningLevel();
			if (level != null) {
				getInvoice().setC_DunningLevel_ID(level.getC_DunningLevel_ID());
				if (level.getInvoiceCollectionType() != null) {
					getInvoice().setInvoiceCollectionType (level.getInvoiceCollectionType());
				} else {
					if (! level.isStatement()) {
						getInvoice().setInvoiceCollectionType (MInvoice.INVOICECOLLECTIONTYPE_Dunning);
					}
				}
				getInvoice().saveEx();
			}
		}

		return true;
	}	//	beforeSave
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		updateEntry();
		return success;
	}	//	afterSave
	
	@Override
	protected boolean afterDelete (boolean success)
	{
		if (!success)
			return success;
		updateEntry();
		return success;
	}	//	afterDelete
	
	/**
	 * 	Update Amt and Qty of Entry (C_DunningRunEntry) from Line (C_DunningRunLine)
	 */
	private void updateEntry()
	{
		// we do not count the fee line as an item, but it sum it up.
		StringBuilder sql = new StringBuilder("UPDATE C_DunningRunEntry e ")
			.append("SET Amt=NVL((SELECT SUM(ConvertedAmt)+SUM(FeeAmt)+SUM(InterestAmt)")
			.append(" FROM C_DunningRunLine l ")
				.append("WHERE e.C_DunningRunEntry_ID=l.C_DunningRunEntry_ID), 0), ")
			.append("QTY=(SELECT COUNT(*)")
			.append(" FROM C_DunningRunLine l ")
				.append("WHERE e.C_DunningRunEntry_ID=l.C_DunningRunEntry_ID ")
				.append(" AND (NOT C_Invoice_ID IS NULL OR NOT C_Payment_ID IS NULL))")
			.append(" WHERE C_DunningRunEntry_ID=").append(getC_DunningRunEntry_ID());
		
		DB.executeUpdate(sql.toString(), get_TrxName());
	}	//	updateEntry
	
}	//	MDunningRunLine
